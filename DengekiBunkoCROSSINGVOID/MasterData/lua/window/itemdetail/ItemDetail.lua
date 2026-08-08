local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local EU = require("Common/EquipUtil")
local LU = require("Common/ListUtil")
local DU = require("Common/DungeonUtil")
local ACU = require("Common/ActivityUtil")
local GotoUtil = require("Common/GotoUtil")
local S = require("Common/Singleton")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local AU = require("Common/ActorUtil")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local m_activityManager = S:Get("ActivityManager")
local m_itemId
local m_displaySource = false
local m_sourcesData = {}
local m_itemType
local m_sellNum = 0
local m_useNum = 0
local m_isAcItem = false
local m_isPreview = false
local m_compose, m_itemCount, m_composeRequireNum, m_composeTarget, m_contextType, m_contextData, m_isShowUse, m_buttonUseClick, m_buttonUseLabelText
local m_scrNormalHeight = 330
local m_scrSellHeight = 255
local m_repeatedContext = {}
local ActorTypePrefix = {
  "Window_ActorMainPrefix",
  "Window_ActorAssistPrefix"
}

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonGet, function()
    if not m_displaySource then
      WU.RecordButtonClick(979)
    end
    ShowContent(not m_displaySource)
  end)
  WU.BindButtonEvent(REF.ButtonEquip, function()
    if m_contextType == PB.enum.ResourceType.ResMedal then
      if m_contextData and m_contextData.id and m_contextData.windowName ~= "MedalList" then
        local fightMedal
        local param = {
          fightMedal = m_contextData.id
        }
        local wireFormatparam = ProtobufT("ApiRelationPlayerPageInfo", param)
        this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatparam, function(result)
          this:SetData("Space/SelectedPlayer", result)
          this:SetData("PlayerFightMedal", m_contextData.id)
          WU.RecycleWindow(this)
        end)
      end
      if m_contextData and m_contextData.windowName == "MedalList" then
        WU.AcquireWindowAsync("Account", function(ui)
          _ENV["$"](ui)["$$SetMySpace"]()
        end)
        WU.RecycleWindow(this)
      end
    else
      WU.RecycleWindow(this)
    end
  end)
  WU.BindButtonEvent(REF.ButtonSell, OnButtonSellClick)
  WU.BindButtonEvent(REF.ButtonUse, OnButtonUseClick)
  WU.BindButtonEvent(REF.ButtonShare, function()
    WU.RecordButtonClick(901)
    this:SetData("ShareConfig", {
      shareName = "ItemDetail/Medal",
      fromWindow = WU.TopWindow() and WU.TopWindow().name
    })
    local data = {
      medalId = m_itemId,
      detailText = REF.LabelDetail.UIHtmlLabel.text
    }
    this:SetData("Share/ItemDetail/Medal", data)
    WU.AcquireWindowAsync("Share")
  end)
  WU.BindButtonEvent(REF.ButtonCompose, OnButtonComposeClick)
  REF.WidgetNumberEdit["$SetNumberUpdateCallback"](OnItemNumEdit)
  REF.WidgetNumberEdit["$SetShowMax"](true)
end

function InitWindow()
  ResetDisplay()
  m_displaySource = false
  m_buttonUseClick = nil
  m_buttonUseLabelText = nil
  m_isShowUse = nil
  this:Bind("ItemDetail/DisplaySource", function(flag)
    if flag == nil then
      return
    end
    local showGetButton = false
    if m_contextType == PB.enum.ResourceType.ResItem then
      showGetButton = (m_itemType == PB.enum.ItemType.Material or m_itemType == PB.enum.ItemType.Consumable or m_itemType == PB.enum.ItemType.ActivityDrop) and flag
    elseif m_contextType == "ActorSkin" then
      showGetButton = flag
    elseif m_contextType == "Resource" then
      showGetButton = m_contextData.type == PB.enum.ResourceType.ResPlayerRelationPoint and flag
    end
    REF.ButtonGet.gameObject:SetActive(showGetButton)
  end)
end

function SaveContext(context)
  table.insert(m_repeatedContext, {type = m_contextType, context = m_contextData})
end

function LoadContext(context)
  if 0 < #m_repeatedContext then
    local data = m_repeatedContext[#m_repeatedContext]
    if data.type == PB.enum.ResourceType.ResItem then
      SetItemId(data.context.id)
    elseif data.type == PB.enum.ResourceType.ResMedal then
      SetMedalId(data.context.id, data.context.showButtonEquip, data.context.expireTime)
    elseif data.type == "ActorAura" then
      SetAuraActor(data.context.id, data.context.quality)
    elseif data.type == "Resource" then
      SetResourceType(data.context.type)
    elseif data.type == "ActorSkin" then
      SetSkinId(data.context.id, data.context.actorId)
    elseif data.type == PB.enum.ResourceType.ResMazeHollow then
      SetHollowId(data.context.id)
    end
    table.remove(m_repeatedContext, #m_repeatedContext)
  end
  REF["$UILuaWindow"]:PlayAnimation("Open")
  WU.ToggleRendering(REF.root, false)
end

function ShowContent(displaySource)
  m_displaySource = displaySource
  WU.ToggleRendering(REF.WidgetDetailSource, m_displaySource)
  REF.NodeDetail.gameObject:SetActive(not m_displaySource)
  if m_displaySource then
    _ENV["$"](REF.ButtonGet).Label.UIHtmlLabel.text = WU.GetString("Window_Back")
    REF.WidgetDetailSource["$SetData"](m_sourcesData, "item")
  else
    _ENV["$"](REF.ButtonGet).Label.UIHtmlLabel.text = WU.GetString("WindowItem_Get")
  end
end

function ResetDisplay()
  WU.SetActive(REF.WidgetSkinDetail, false)
  WU.SetActive(REF.LabelDetail, false)
  WU.SetActive(REF.NodeActorDetail, false)
  WU.SetActive(REF.ButtonEquip, false)
  WU.SetActive(REF.LabelCount, false)
  WU.SetActive(REF.NodeSell, false)
  WU.SetActive(REF.NodeUse, false)
  WU.SetActive(REF.WidgetNumberEdit, false)
  WU.SetActive(REF.ButtonShare, false)
  WU.SetActive(REF.NodeCompose, false)
  ShowContent(false)
end

function SetItemId(id, isPreview)
  if id == nil then
    return
  end
  ResetDisplay()
  WU.SetActive(REF.LabelDetail, true)
  m_isPreview = isPreview
  if m_isPreview == nil then
    m_isPreview = true
  end
  local itemInfo = PB.get("ItemInfo", id)
  m_contextType = PB.enum.ResourceType.ResItem
  m_itemType = itemInfo.type
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_contextData = {id = id}
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResItem, id)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  local xlsxConfig = PB.get("ItemInfo", id)
  REF.LabelCount.gameObject:SetActive(not xlsxConfig or xlsxConfig.type ~= PB.enum.ItemType.Scene and xlsxConfig.type ~= PB.enum.ItemType.CultivationCG)
  local detailText = "<font size=46>" .. WU.GetString("ItemName_" .. id) .. "</font><br><br>"
  detailText = detailText .. WU.GetItemDesc(id)
  REF.LabelDetail.UIHtmlLabel.text = detailText
  REF.ButtonEquip.gameObject:SetActive(false)
  if m_itemId then
    this:Unbind("fci/item/" .. m_itemId, OnItemCountChange)
  end
  m_itemId = id
  this:Bind("fci/item/" .. m_itemId, OnItemCountChange)
  m_sourcesData = GetSourcesData(itemInfo.sources)
  REF.WidgetDetailSource["$SetData"](m_sourcesData, "item")
end

function SetResourceType(type)
  if type == nil then
    return
  end
  ResetDisplay()
  WU.SetActive(REF.LabelDetail, true)
  m_contextType = "Resource"
  m_contextData = {type = type}
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_sourcesData = {}
  if type == PB.enum.ResourceType.ResPlayerRelationPoint then
    m_sourcesData = GetSourcesData(PB.get("ResourceQuality", type).sources)
  end
  REF.WidgetDetailSource["$SetData"](m_sourcesData, "item")
  REF.WidgetIconSlot["$SetData"](type)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  local detailText = "<font size=46>" .. WU.GetString("ResourceTypeName_" .. type) .. "</font><br><br>"
  detailText = detailText .. WU.GetString("ResourceTypeDesc_" .. type)
  REF.LabelDetail.UIHtmlLabel.text = detailText
end

function SetHollowId(id)
  if id == nil then
    return
  end
  ResetDisplay()
  WU.SetActive(REF.LabelDetail, true)
  m_contextType = PB.enum.ResourceType.ResMazeHollow
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_sourcesData = {id = id}
  if type == PB.enum.ResourceType.ResPlayerRelationPoint then
    m_sourcesData = GetSourcesData(PB.get("ResourceQuality", type).sources)
  end
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResMazeHollow, id)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  local hollowInfo = PB.get("MazeEquipmentInfo", id)
  local hollowAffixText
  if hollowInfo and hollowInfo.buffId then
    local tpl = WU.GetString("AffixDesc_" .. hollowInfo.buffId)
    local tplParam = SE.GetAffixTplParam(hollowInfo.buffId)
    if tplParam == nil then
      return
    else
      hollowAffixText = TU.render(tpl, tplParam)
    end
  else
    error("MazeEquipmentInfo.xlsx has no id " .. id)
    return
  end
  local detailText = "<font size=46>" .. WU.GetString("Maze_HollowName_" .. id) .. "</font><br><br>"
  detailText = detailText .. hollowAffixText
  REF.LabelDetail.UIHtmlLabel.text = detailText
end

function SetMedalId(id, showButtonEquip, expireTime, windowName)
  if id == nil then
    return
  end
  m_itemId = id
  ResetDisplay()
  WU.SetActive(REF.LabelDetail, true)
  m_contextType = PB.enum.ResourceType.ResMedal
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_contextData = {
    id = id,
    showButtonEquip = showButtonEquip,
    expireTime = expireTime,
    windowName = windowName
  }
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResMedal, id)
  REF.WidgetIconSlot["$ShowCustom"]({name = false})
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  REF.ButtonEquip.gameObject:SetActive(showButtonEquip)
  if windowName == "MedalList" then
    REF.LabelEquip.UIHtmlLabel.text = WU.GetString("WindowItem_GoToEquip")
    WU.SetActive(REF.ButtonShare, showButtonEquip)
  elseif windowName == "MySpace" then
    REF.LabelEquip.UIHtmlLabel.text = WU.GetString("WindowActorEquip_Equip")
  end
  local medalInfo = PB.get("MedalInfo", id)
  if medalInfo == nil then
    error("MedalInfo", "xlsx error, id " .. tostring(id))
    return
  end
  local expireText
  if expireTime == nil then
    expireTime = 0
  end
  if medalInfo.expireDay ~= 0 then
    if expireTime == 0 then
      expireText = WU.GetString("Window_ValidTime") .. WU.GetString("Window_Day", medalInfo.expireDay)
    else
      local expireDate = CS.GameTime.UtcToLocal(expireTime).Date
      expireText = WU.GetString("Window_ValidTime") .. expireDate:ToString("yyyy-MM-dd")
    end
  elseif medalInfo.expireTime ~= "" then
    expireText = WU.GetString("Window_ValidTime") .. medalInfo.expireTime:split(" ")[1]
  end
  local detailText = "<font size=46>" .. WU.GetString("MedalName_" .. id) .. "</font>&nbsp;<font size=24>(" .. WU.GetString("MedalSource_" .. medalInfo.source) .. ")</font><br>" .. "<font size=10><br></font>"
  if expireText ~= nil then
    detailText = detailText .. expireText .. "<br>"
  end
  detailText = detailText .. AU.RenderAuraOrMedalAttr(medalInfo)
  detailText = detailText .. "<font size=10><br></font>" .. "<font color=#6682B6FF>" .. WU.GetString("MedalStory_" .. id) .. "</font>"
  REF.LabelDetail.UIHtmlLabel.text = detailText
end

function SetAuraActor(id, quality)
  ResetDisplay()
  WU.SetActive(REF.LabelDetail, true)
  m_contextType = "ActorAura"
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_contextData = {id = id, quality = quality}
  REF.WidgetIconSlot["$SetActorCustom"]({id = id, quality = quality})
  REF.ButtonEquip.gameObject:SetActive(false)
  local actorQualityInfo = PB.get("ActorQualityInfo", id, quality)
  local actorName = WU.GetString("ActorName_" .. id)
  local attrText = AU.RenderAuraOrMedalAttr(actorQualityInfo)
  REF.LabelDetail.UIHtmlLabel.text = actorName .. "<br><br>" .. attrText
end

function SetSkinId(skinId, actorId)
  ResetDisplay()
  m_contextType = "ActorSkin"
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_contextData = {id = skinId, actorId = actorId}
  local resSkin = PB.get("ActorSkin", skinId)
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResActorSkin, skinId)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  if actorId then
    REF.WidgetIconSkin["$SetDefault"](actorId)
  end
  local actorIds
  if actorId then
    actorIds = {actorId}
  else
    actorIds = AU.GetSkinActors(skinId)
  end
  REF.LabelDetail.UIHtmlLabel.text = ""
  WU.SetActive(REF.WidgetSkinDetail, true)
  REF.WidgetSkinDetail["$SetDataBySkinId"](skinId, actorId)
  actorId = actorId or actorIds[1]
  if skinId == 0 then
    m_sourcesData = {}
  else
    m_sourcesData = GetSourcesData(PB.get("ActorSkin", skinId).sources)
  end
  REF.WidgetDetailSource["$SetData"](m_sourcesData, "item")
end

function SetSignboardId(id)
  ResetDisplay()
  WU.SetActive(REF.LabelDetail, true)
  m_contextType = PB.enum.ResourceType.ResSignboard
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_contextData = {id = id}
  REF.WidgetIconSlot["$SetData"](PB.enum.ResourceType.ResSignboard, id)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  local detailText = "<font size=46>" .. WU.GetString("SignboardName_" .. id) .. "</font><br><br>"
  detailText = detailText .. WU.GetString("SignboardDesc_" .. id)
  REF.LabelDetail.UIHtmlLabel.text = detailText
end

function SetActorInfo(id, quality)
  ResetDisplay()
  m_contextType = "ActorInfo"
  this:SetData("ItemDetail/DisplaySource", this:GetData("ItemDetail/DisplaySource"))
  m_contextData = {id = id, quality = quality}
  REF.WidgetIconSlot["$SetActorCustom"]({id = id, quality = quality})
  REF.ButtonEquip.gameObject:SetActive(false)
  REF.NodeActorDetail.gameObject:SetActive(true)
  if quality then
    REF.SpriteActorQualityBG.UISprite.spriteName = "actor_type_bg_" .. quality
  end
  REF.SpriteActorType.UISprite.spriteName = "actor_type_" .. id
  REF.LabelActorCV.UILabel.text = WU.GetString("ActorCV_" .. id)
  REF.LabelActorDescription.UIHtmlLabel.text = WU.GetString("ActorDescribe_" .. id)
  local actorConfig = PB.get("ActorConfig", id)
  if actorConfig then
    REF.SpriteActorName.UISprite.spriteName = "actor_name_" .. actorConfig.animRes
    local actorTag = PB.get("ActorTag", id)
    if actorTag then
      REF.LabelActorType.UILabel.text = WU.GetString(ActorTypePrefix[actorConfig.kind]) .. WU.GetString("tag" .. actorTag.tag[1])
    end
  end
end

function SetHeadFrameId(id)
  ResetDisplay()
  local type = PB.enum.ResourceType.ResPlayerHeadFrame
  WU.SetActive(REF.LabelDetail, true)
  m_contextType = "PlayerHeadFrame"
  m_contextData = {type = type}
  REF.WidgetIconSlot["$SetData"](type, id, 1)
  REF.WidgetIconSlot["$SetClickCallback"](nil)
  REF.LabelDetail.UIHtmlLabel.text = "<font size=46>" .. WU.GetString("PlayerHeadFrameName_" .. id) .. "</font><br><br>" .. WU.GetString("PlayerHeadFrameDesc_" .. id)
end

function OnItemCountChange(item)
  REF.LabelCount.UIHtmlLabel.text = WU.GetString("WindowItem_OwnCount") .. ": " .. item.count
  REF.ScrollViewDetail.UIScrollView:ResetPosition()
  m_itemCount = item.count
  local itemInfo = PB.get("ItemInfo", item.id)
  local showSell = not m_isPreview and itemInfo.saleable and item.count > 0
  WU.SetActive(REF.NodeSell, showSell)
  m_isAcItem = false
  m_compose = false
  if itemInfo.bindActivityType then
    m_activityManager.GetActivityByType(itemInfo.bindActivityType, function(acList)
      if acList then
        local ac = table.find(acList, function(k, v)
          local status = ACU.GetStatus(v)
          return v.activityId == itemInfo.bindActivityId and (status == PB.enum.ActivityStatus.Close or status == PB.enum.ActivityStatus.Finished)
        end)
        m_isAcItem = ac ~= nil
        WU.SetActive(REF.NodeSell, m_isAcItem or showSell)
      end
    end)
  end
  if not m_isAcItem and not showSell and not m_isPreview then
    local allComposeInfo = PB.all("ResourceCompose")
    local index, composeInfo = table.find(allComposeInfo, function(k, v)
      local materialRes = v.materialRes
      if materialRes and materialRes[1].id == item.id and materialRes[1].type == PB.enum.ResourceType.ResItem then
        return true
      end
      return false
    end)
    if composeInfo then
      m_compose = true
      m_composeRequireNum = composeInfo.materialRes[1].count
      m_composeTarget = composeInfo.targetRes
      local canCompose = false
      if item.count >= m_composeRequireNum then
        canCompose = true
      end
      REF.ButtonCompose.UISprite.graify = not canCompose
      REF.ButtonCompose.BoxCollider2D.enabled = canCompose
      _ENV["$"](REF.ButtonCompose).Label.UILabel.text = fif(canCompose, WU.GetString("Window_Compose"), WU.GetString("Item_NotEnoughToCompose"))
    end
    WU.SetActive(REF.NodeCompose, m_compose)
  end
  local height = fif(m_isAcItem or showSell or m_compose, m_scrSellHeight, m_scrNormalHeight)
  local width = REF.ScrollViewDetail.UIPanel.width
  local pos = REF.ScrollViewDetail.transform.localPosition
  REF.ScrollViewDetail.UIPanel:SetRect(0, 0, width, height)
  REF.ScrollViewDetail.transform.localPosition = CS.UnityEngine.Vector3(80, 0, 0)
  local showUse = not m_isPreview and itemInfo.funcType == PB.enum.ItemFuncType.Box and itemInfo.type == PB.enum.ItemType.Consumable and item.count > 0 or m_isShowUse == true and item.count > 0
  if m_buttonUseLabelText then
    _ENV["$"](REF.ButtonUse).Label.UIHtmlLabel.text = m_buttonUseLabelText
  end
  WU.SetActive(REF.NodeUse, showUse)
  WU.SetActive(REF.WidgetNumberEdit, showSell or showUse or m_isAcItem)
  if showSell or showUse or m_isAcItem then
    REF.WidgetNumberEdit["$SetNumber"](math.min(1, item.count), true)
    REF.WidgetNumberEdit["$SetRange"](1, item.count)
  end
end

function OnItemSourceClick(go)
  local windowName = _ENV["$"](go)["@windowName"]
  local params = _ENV["$"](go)["@params"]
  if windowName ~= "None" then
    GotoUtil.Goto(windowName, params)
  end
end

function OnItemNumEdit(num)
  local itemInfo = PB.get("ItemInfo", m_itemId)
  if itemInfo.saleable or m_isAcItem then
    m_sellNum = num
    local totalPrice = m_sellNum * itemInfo.sellPrice.count
    REF.LabelSell.UIHtmlLabel.text = WU.GetString(fif(itemInfo.sellPrice.count > 0, "Window_Sell", "Window_Destroy"))
    local icon = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[itemInfo.sellPrice.type] .. "_" .. itemInfo.sellPrice.id .. "' />"
    REF.LabelPrice.UIHtmlLabel.text = WU.GetString("Window_ItemSellPriceTotal", icon .. tostring(totalPrice))
  elseif itemInfo.funcType == PB.enum.ItemFuncType.Box and itemInfo.type == PB.enum.ItemType.Consumable or m_isShowUse == true then
    m_useNum = num
  end
end

function OnButtonSellClick()
  if 0 < m_sellNum then
    local itemInfo = PB.get("ItemInfo", m_itemId)
    local totalPrice = m_sellNum * itemInfo.sellPrice.count
    local icon = "<img src='ResIcon_s." .. PB.enum.ResourceType.__keys[itemInfo.sellPrice.type] .. "_" .. itemInfo.sellPrice.id .. "' />"
    WU.ShowMessageYesNo(WU.GetString("Window_SellItemConfirm", icon .. tostring(totalPrice)), function(result)
      if result == "YES" then
        local postTable = {
          itemsell = {
            {id = m_itemId, count = m_sellNum}
          }
        }
        local wireFormatTable = ProtobufT("ApiItemSell", postTable)
        this:GameRequest("fci/itemsell/"):Post(wireFormatTable, function(result)
          DBH.ResChange(result.resChange)
          WU.ShowRewards(result.resChange)
          this:BroadcastGameEvent("ItemNew")
          WU.RecycleWindow(this)
        end)
      end
    end)
  end
end

function OnButtonUseClick()
  if 0 < m_useNum then
    if m_buttonUseClick then
      local item = {
        type = PB.enum.ResourceType.ResItem,
        id = m_itemId,
        count = m_useNum
      }
      m_buttonUseClick(item)
    else
      this:GameRequest("fci/itemuse/"):Post({id = m_itemId, count = m_useNum}, function(result)
        DBH.ResChange(result.resChange)
        WU.ShowRewards(result.resChange)
        this:BroadcastGameEvent("ItemNew")
      end)
    end
  end
end

function GetSourcesData(sources)
  local sourcesData = {}
  for i = 1, #sources do
    local gotoData = PB.get("Goto", sources[i])
    if gotoData then
      table.insert(sourcesData, gotoData)
    else
      error("ItemDetail", "id [" .. sources[i] .. "] was not found in Goto.xlsx")
    end
  end
  return sourcesData
end

function OnButtonComposeClick()
  if 0 < m_itemCount then
    if m_itemCount >= m_composeRequireNum then
      this:GameRequest("fci/resourcecompose/"):Post({
        count = 1,
        type = m_composeTarget.type,
        id = m_composeTarget.id
      }, function(result)
        DBH.ResChange(result.resChange)
        local items = {}
        local armChangeInfo = _ENV["!"]({})
        for _, reward in pairs(result.resChange) do
          if reward.baseRes or reward.weapon then
            if reward.baseRes and reward.baseRes.countDelta > 0 and reward.baseRes.param == PB.enum.ResourceParamType.None then
              local type = reward.baseRes.type
              table.insert(items, {
                type = reward.baseRes.type,
                id = reward.baseRes.id,
                count = reward.baseRes.count,
                countDelta = reward.baseRes.countDelta,
                ownerBoxId = reward.ownerBoxId
              })
            elseif reward.weapon then
              if reward.inBox and 0 < #reward.inBox then
                table.insert(armChangeInfo, {
                  arm = reward.weapon,
                  decomposeItems = reward.inBox
                })
                table.insert(items, {
                  type = reward.inBox[1].baseRes.type,
                  id = reward.inBox[1].baseRes.id,
                  count = reward.inBox[1].baseRes.count,
                  countDelta = reward.inBox[1].baseRes.countDelta
                })
              else
                if reward.afterUpgradeWeapon then
                  table.insert(armChangeInfo, {
                    arm = reward.weapon,
                    newArm = reward.afterUpgradeWeapon
                  })
                else
                  table.insert(armChangeInfo, {
                    arm = reward.weapon
                  })
                end
                table.insert(items, {
                  type = PB.enum.ResourceType.ResUniqueWeapon,
                  id = reward.weapon.id,
                  countDelta = reward.weapon.count,
                  countDelta = reward.weapon.countDelta,
                  ownerBoxId = reward.ownerBoxId
                })
              end
            end
          end
        end
        WU.AcquireWindowAsync("ComposeResult", function(win)
          _ENV["$"](win)["$$ShowComposeResult"](items, function()
            this:BroadcastGameEvent("ItemNew")
            if 0 < #armChangeInfo then
              WU.ShowNewArmChange(armChangeInfo)
            end
          end)
        end)
      end)
    else
      WU.ShowHintText(WU.GetString("Item_NotEnoughToCompose"))
    end
  end
end

function SetButtonUse(isShowUse, fuc, buttonUseLabelText)
  m_isShowUse = isShowUse
  m_buttonUseClick = fuc
  m_buttonUseLabelText = buttonUseLabelText
end
