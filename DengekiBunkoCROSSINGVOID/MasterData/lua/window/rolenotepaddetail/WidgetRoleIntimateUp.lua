local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local HU = require("Common/HtmlUtil")
local m_expItems, m_holdItemSlot, m_holdItemInfo, m_holdItem
local m_reserveCount = 0
local m_maxLevel = 0
local m_predictLevel = 0
local m_predictExp = 0
local m_data, m_roleId, m_onHide, m_pressStart, m_pressHold

function Start()
  REF.Blocker.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ButtonClose, function(go)
    Hide()
  end)
  WU.BindButtonEvent(REF.Blocker, function(go)
    Hide()
  end)
  this:Bind("fci/item", OnItemChange)
end

function Show(roleId)
  ToggleVisibility(true)
  InitMaterials()
  OnItemChange()
  if m_roleId then
    this:Unbind("fci/RoleNotePad/" .. m_roleId, OnRoleChange)
    m_roleId = nil
  end
  m_roleId = roleId
  m_data = nil
  if m_roleId then
    this:BindRemote(DB:GameRequest("fci/RoleNotePad/" .. m_roleId), OnRoleChange)
  end
end

function OnRoleChange(data)
  if data then
    m_data = data
    REF.LabelLevel.UIHtmlLabel.text = data.favourLevel
    local favourLevel = PB.get("FavourLevel", data.favourLevel + 1)
    if favourLevel then
      REF.LabelExp.UIHtmlLabel.text = data.favour .. "/" .. favourLevel.favour
      REF.SpriteExpPredict.UISprite.fillAmount = 0
      REF.SpriteExp.gameObject:SetActive(true)
      REF.SpriteExp.UISprite.fillAmount = data.favour / favourLevel.favour
    else
      REF.LabelExp.UIHtmlLabel.text = WU.GetString("Window_FavourMax")
      REF.SpriteExpPredict.UISprite.fillAmount = 0
      REF.SpriteExp.gameObject:SetActive(true)
      REF.SpriteExp.UISprite.fillAmount = 1
    end
  end
end

function Hide(instant)
  if m_roleId then
    this:Unbind("fci/RoleNotePad/" .. m_roleId, OnRoleChange)
    m_roleId = nil
  end
  if m_onHide ~= nil then
    m_onHide()
  end
  ToggleVisibility(false, instant)
end

function ToggleVisibility(visible, instant)
  REF.Blocker.gameObject:SetActive(visible)
  local showGroup = 0
  local hideGroup = 1
  REF.root.UIPlayTween:Finish()
  REF.root.UIPlayTween.tweenGroup = fif(visible, showGroup, hideGroup)
  REF.root.UIPlayTween:Play(true)
  if instant then
    REF.root.UIPlayTween:Finish()
  end
end

function SetOnHideCallback(func)
  m_onHide = func
end

function InitMaterials()
  m_maxLevel = PB.all("Misc")[1].maxRoleFavourLevel
  m_expItems = PB.all("ItemInfo"):where(function(_, i)
    return i.funcType == PB.enum.ItemFuncType.Favour
  end):toarray()
  table.sort(m_expItems, function(a, b)
    return a.param[1] < b.param[1]
  end)
  REF.NodeEmpty.gameObject:SetActive(false)
  REF.NodeMaterial.gameObject:SetActive(true)
  if 0 < #m_expItems then
    for i = 0, #REF.MaterialList - 1 do
      local itemIndex = i + 1
      local itemSlot = REF.MaterialList[i]
      itemSlot["$gameObject"]:SetActive(itemIndex <= #m_expItems)
      if itemIndex <= #m_expItems then
        local itemInfo = m_expItems[itemIndex]
        itemSlot["@itemId"] = itemInfo.id
        itemSlot["$$BindItem"](itemInfo.id)
        itemSlot["$$SetBottomText"](WU.GetString("Window_ItemAddExp", itemInfo.param[1]))
        itemSlot["$$SetPressCallback"](OnPressSlot)
        itemSlot["$$SetClickCallback"](OnClickSlot)
        itemSlot["$$SetReleaseCallback"](OnReleaseSlot)
      end
    end
    REF.MaterialList.UIGrid:Reposition()
  end
end

local m_BubbleOn = false

function showCountEffect(isShow)
  if isShow then
    REF.BubbleTips01.gameObject:SetActive(true)
    REF.BubbleTips01.EffectGenerator:Play()
    REF.LabelEffectCount.gameObject:SetActive(true)
    m_BubbleOn = true
  elseif m_BubbleOn then
    local now = CS.System.DateTime.Now
    local delayTime = 0
    local t = m_pressHold:AddSeconds(0.5)
    if now < t then
      delayTime = t:Subtract(now).Ticks / 1.0E7
    end
    this:DelayInvokeInSeconds(delayTime, function()
      REF.BubbleTips01.gameObject:SetActive(false)
      REF.LabelEffectCount.gameObject:SetActive(false)
      REF.BubbleTips02.gameObject:SetActive(true)
      REF.BubbleTips02.EffectGenerator:Play()
      m_BubbleOn = false
    end)
  end
end

function OnPressSlot(go)
  if m_data then
    local itemId = _ENV["$"](go)["@itemId"]
    m_holdItemSlot = go
    m_holdItemInfo = PB.get("ItemInfo", itemId)
    m_holdItem = this:GetData("fci/item/" .. itemId)
    m_reserveCount = 0
    m_predictLevel = m_data.favourLevel
    m_predictExp = m_data.favour
    local ref = REF.Count
    local curPosition = ref.transform.position
    ref.transform.position = CS.UnityEngine.Vector3(go.transform.position.x, curPosition.y, curPosition.z)
    REF.LabelEffectCount.UIHtmlLabel.text = m_holdItem.count
    m_pressStart = true
    m_pressHold = CS.System.DateTime.Now
  end
end

function OnClickSlot()
  local result = false
  if m_holdItemSlot and m_holdItemInfo and m_holdItem and m_data then
    WU.RecordButtonClick(m_holdItemInfo.id)
    if CanEatFood(m_predictLevel, m_maxLevel, m_predictExp) and m_holdItem.count > m_reserveCount then
      m_reserveCount = m_reserveCount + 1
      m_predictExp = m_predictExp + m_holdItemInfo.param[1]
      local levelupNext = PB.get("FavourLevel", m_predictLevel + 1)
      while levelupNext and m_predictExp >= levelupNext.favour and CanEatFood(m_predictLevel, m_maxLevel, m_predictExp) do
        m_predictExp = m_predictExp - levelupNext.favour
        m_predictLevel = m_predictLevel + 1
        levelupNext = PB.get("FavourLevel", m_predictLevel + 1)
        REF.LabelLevel.UIHtmlLabel.text = m_predictLevel
        UpgradeEffect()
      end
      if levelupNext and m_predictLevel == m_maxLevel and m_predictExp > levelupNext.favour then
        m_predictExp = levelupNext.favour
      end
      local levelText = m_data.favourLevel
      if m_predictLevel > m_data.favourLevel then
        REF.SpriteExp.gameObject:SetActive(false)
      end
      REF.LabelEffectCount.UIHtmlLabel.text = tostring(m_holdItem.count - m_reserveCount)
      if levelupNext then
        REF.LabelExp.UIHtmlLabel.text = m_predictExp .. "/" .. levelupNext.favour
        REF.SpriteExpPredict.UISprite.fillAmount = m_predictExp / levelupNext.favour
      else
        REF.LabelExp.UIHtmlLabel.text = "Max"
        REF.SpriteExpPredict.UISprite.fillAmount = 1
      end
      if m_pressStart then
        showCountEffect(true)
        m_pressStart = false
      end
      result = true
    end
  end
  if not result and m_holdItem and m_holdItem.count <= 0 then
    WU.ShowItemDetail(m_holdItem.id)
  end
  return result
end

function OnReleaseSlot(go)
  if 0 < m_reserveCount and m_data ~= nil then
    local slotRef = _ENV["$"](m_holdItemSlot)
    local preLevel = m_data.favourLevel
    local itemCost = {
      type = PB.enum.ResourceType.ResItem,
      id = slotRef["@itemId"],
      count = m_reserveCount
    }
    local costList = {}
    table.insert(costList, itemCost)
    this:GameRequest("fci/FavourGift/" .. m_data.roleId):Patch({usedItemList = costList}, function(result)
      DBH.ResChange(result.resChange)
      DBH.RoleNotepadChange(result.roleNotepad)
      if result.roleNotepad.favourLevel > preLevel then
        this:SetData("RoleNotepadUpdateAble", true)
      end
    end)
  end
  if m_holdItem ~= nil and 0 < m_holdItem.count then
    CheckMaxLevelLimit()
  end
  m_holdItemSlot = nil
  m_holdItemInfo = nil
  m_holdItem = nil
  showCountEffect(false)
end

function UpgradeEffect()
  CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Relationship")
  REF.AccountLoveEffect.EffectGenerator.gameObject:SetActive(true)
  REF.AccountLoveEffect.EffectGenerator:Play()
  this:DelayInvokeInScaledSeconds(1.5, function()
    REF.AccountLoveEffect.EffectGenerator.gameObject:SetActive(false)
  end)
end

function CheckMaxLevelLimit()
  if m_data and not CanEatFood(m_predictLevel, m_maxLevel, m_predictExp) then
    WU.ShowHintText(WU.GetString("Window_RoleFavourLevelupReachLevelLimit", WU.GetString("RoleName_" .. m_data.roleId)))
  end
end

function CanEatFood(curLevel, maxLevel, exp)
  if curLevel < maxLevel then
    return true
  end
  local favourLevel = PB.get("FavourLevel", curLevel + 1)
  if curLevel == maxLevel and favourLevel and exp < favourLevel.favour then
    return true
  end
  return false
end

function OnItemChange(items)
  for i = 0, #REF.MaterialList - 1 do
    if m_expItems and i + 1 <= #m_expItems then
      local itemCount = this:GetData("fci/item/" .. m_expItems[i + 1].id).count
      REF.GrayList[i]["$gameObject"]:SetActive(itemCount <= 0)
    end
  end
  REF.MaterialList.UIGrid:Reposition()
end
