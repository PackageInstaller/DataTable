local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local m_manualBox, m_dataList, m_selection, m_isPreview, m_callback, m_goodsInfo

function SetupWindow()
  LU.Bind(REF.WrapContentSkin, {
    updateRow = UpdateSkinSlot
  })
  WU.BindButtonEvent(REF.ButtonGet, OnGetClick)
  WU.BindButtonEvent(REF.ButtonBuy, OnBuyClick)
  WU.BindButtonEvent(REF.ButtonClose, OnCloseClick)
end

function InitWindow()
  this:Bind("SkinSlotSelected", OnSkinSlotSelected)
end

function UninitWindow()
  m_goodsInfo = nil
  this:SetData("SkinSlotSelected", nil)
end

function SetBoxId(boxId, isPreview, callback)
  if boxId then
    WU.ToggleRendering(REF.NodeContent, true)
    REF.LabelBoxName.UILabel.text = WU.GetString("ItemName_" .. boxId)
    REF.LabelBoxDesc.UIHtmlLabel.text = WU.GetItemDesc(boxId)
    m_isPreview = isPreview
    m_callback = callback
    m_manualBox = IU.GetManualBox(boxId)
    if m_manualBox.type == PB.enum.ManualBoxType.ActorSkin then
      m_dataList = {}
      for k, v in ipairs(m_manualBox.inBoxArray) do
        local actorIds = AU.GetSkinActors(v.id)
        table.insert(m_dataList, {
          index = k,
          inBox = v,
          isNew = IsNew(v),
          actorIds = actorIds,
          hasActor = HasActor(actorIds)
        })
      end
      table.sort(m_dataList, function(a, b)
        local aHasActor = fif(a.hasActor, 0, 1)
        local bHasActor = fif(b.hasActor, 0, 1)
        local aNew = fif(a.isNew, 0, 1)
        local bNew = fif(b.isNew, 0, 1)
        if aHasActor ~= bHasActor then
          return aHasActor < bHasActor
        else
          return aNew < bNew
        end
      end)
      LU.Set(REF.WrapContentSkin, #m_dataList)
      if 0 < #m_dataList then
        this:SetData("SkinSlotSelected", m_dataList[1])
      end
      WU.SetActive(REF.ButtonGet, not m_isPreview and not m_goodsInfo)
      WU.SetActive(REF.ButtonBuy, m_goodsInfo)
      if m_goodsInfo then
        local cost = m_goodsInfo.cost[1]
        REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
      end
    else
      error("ManualBoxSkin", "ManualBox with id " .. boxId .. " was not an skin box")
    end
    WU.ToggleRendering(REF.EffectOpen, false)
  end
end

function SetGoodsInfo(goodsInfo)
  m_goodsInfo = goodsInfo
  if m_goodsInfo then
    SetBoxId(m_goodsInfo.good.id)
  end
end

function OnSkinSlotSelected(selection)
  m_selection = selection
  UpdateData()
end

function UpdateData()
  if m_selection then
    local actorSkin = PB.get("ActorSkin", m_selection.inBox.id)
    if actorSkin then
      REF.LabelSkinName.UILabel.text = WU.GetString("ActorSkinName_" .. m_selection.inBox.id)
      REF.LabelSkinDesc.UILabel.text = WU.GetStringEmpty("ActorSkinDesc_" .. m_selection.inBox.id)
      for i = 0, #REF.GridTargets - 1 do
        local actorId = m_selection.actorIds[i + 1]
        local refIcon = REF.GridTargets[i]
        WU.ToggleRendering(refIcon.root, actorId)
        if actorId then
          refIcon["$$SetData"](actorId)
        end
      end
      local actorId = m_selection.actorIds[1]
      REF.TexturePreview.ActorUIPreview:ResetActor(actorId, AU.GetActorPaletteIndex(actorId, m_selection.inBox.id))
    end
  end
end

function UpdateSkinSlot(slotRef, wrapIndex, rowIndex)
  if m_dataList and rowIndex and rowIndex < #m_dataList then
    slotRef["$$SetData"](m_dataList[rowIndex + 1], rowIndex)
  end
end

function IsNew(inBox)
  return not this:GetData("fci/unlockedSkins")[inBox.id]
end

function HasActor(actorIds)
  local hasActor = false
  local actors = this:GetData("fci/actor")
  for _, actorId in ipairs(actorIds) do
    for _, actor in ipairs(actors) do
      if actor.id == actorId then
        hasActor = true
        break
      end
    end
    if hasActor then
      break
    end
  end
  return hasActor
end

function OnGetClick()
  this:GameRequest("fci/itemuse/"):Post({
    id = m_manualBox.id,
    count = 1,
    index = m_selection.index - 1
  }, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange, function()
      WU.RecycleWindow(this)
      DB:DelayInvokeInFrames(1, function()
        if m_callback then
          m_callback(true)
        end
      end)
    end)
  end)
end

function OnBuyClick()
  this:BroadcastGameEvent("TryToBuyGoods", m_goodsInfo, m_selection.index - 1, 1, function()
    WU.RecycleWindow(this)
    if m_callback then
      m_callback(true)
    end
  end)
end

function OnCloseClick()
  WU.RecycleWindow(this)
  DB:DelayInvokeInFrames(1, function()
    if m_callback then
      m_callback(false)
    end
  end)
end
