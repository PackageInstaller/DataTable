local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local m_manualBox, m_dataList, m_selection, m_isPreview, m_callback, m_goodsInfo
local m_buyCount = 1

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollViewMix.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  LU.Bind(REF.WrapContentMix, {
    updateRow = UpdateMixSlot
  })
  WU.BindButtonEvent(REF.ButtonGet, OnGetClick)
  WU.BindButtonEvent(REF.ButtonBuy, OnBuyClick)
  WU.BindButtonEvent(REF.ButtonClose, OnCloseClick)
  REF.WidgetNumberEdit["$SetNumberUpdateCallback"](OnBuyCoundChange)
end

function InitWindow()
  WU.SetActive(REF.WidgetNumberEdit, false)
  this:Bind("MixSlotSelected", OnMixSlotSelected)
end

function UninitWindow()
  m_goodsInfo = nil
  this:SetData("MixSlotSelected", nil)
end

function SetBoxId(boxId, isPreview, callback)
  if boxId then
    WU.ToggleRendering(REF.NodeContent, true)
    REF.LabelBoxName.UILabel.text = WU.GetString("ItemName_" .. boxId)
    REF.LabelBoxDesc.UIHtmlLabel.text = WU.GetItemDesc(boxId)
    m_isPreview = isPreview
    m_callback = callback
    m_manualBox = IU.GetManualBox(boxId)
    if m_manualBox.type == PB.enum.ManualBoxType.Mix then
      m_dataList = {}
      for k, v in ipairs(m_manualBox.inBoxArray) do
        table.insert(m_dataList, {index = k, inBox = v})
      end
      local count = #m_dataList
      if REF.WrapContentMix.UIWrapContent.itemSize * (count - 1) + REF.WrapContentMix[0]["$UIWidget"].width <= REF.ScrollViewMix.UIPanel.finalClipRegion.z then
        REF.ScrollViewMix.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
      else
        REF.ScrollViewMix.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
      end
      LU.Set(REF.WrapContentMix, #m_dataList, true, true)
      if 0 < #m_dataList then
        this:SetData("MixSlotSelected", m_dataList[1])
      end
      WU.SetActive(REF.ButtonGet, not m_isPreview and not m_goodsInfo)
      WU.SetActive(REF.ButtonBuy, m_goodsInfo)
      if m_goodsInfo then
        local cost = m_goodsInfo.cost[1]
        REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count * m_buyCount)
      end
    else
      error("ManualBoxMix", "ManualBox with id " .. boxId .. " was not an mix box")
    end
    WU.ToggleRendering(REF.EffectOpen, false)
  end
end

function SetGoodsInfo(goodsInfo)
  m_goodsInfo = goodsInfo
  if m_goodsInfo then
    WU.SetActive(REF.WidgetNumberEdit, true)
    REF.WidgetNumberEdit["$SetNumber"](1, true)
    local cost = m_goodsInfo.cost[1]
    local stock = 0
    if cost.type == PB.enum.ResourceType.ResItem then
      local item = this:GetData("fci/item/" .. cost.id)
      if item then
        stock = item.count
      end
    else
      stock = DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[cost.type] .. "_" .. tostring(cost.id or 0)) or 0
    end
    local affordCount = stock // cost.count
    local buyMaxCount = affordCount
    if 0 < m_goodsInfo.buyLimit then
      buyMaxCount = math.min(affordCount, m_goodsInfo.buyLimit - m_goodsInfo.buyCountRecord)
    end
    REF.WidgetNumberEdit["$SetRange"](1, buyMaxCount)
    SetBoxId(m_goodsInfo.good.id)
  end
end

function SetRewardsInfo(id, isPreview, callback)
  m_isPreview = isPreview
  if id then
    if not m_isPreview then
      WU.SetActive(REF.WidgetNumberEdit, true)
      REF.WidgetNumberEdit["$SetNumber"](1, true)
      local item = this:GetData("fci/item/" .. id)
      if item == nil then
        warning("A manual box which isn't preview can't be found in fci/item/id")
      end
      REF.WidgetNumberEdit["$SetRange"](1, item.count or 0)
    end
    SetBoxId(id, isPreview, callback)
  end
end

function OnBuyCoundChange(count)
  m_buyCount = count
  if m_goodsInfo then
    local cost = m_goodsInfo.cost[1]
    REF.LabelCost.ResourcePrinter:SetResource(cost.type, cost.id, cost.count * m_buyCount)
  end
end

function OnMixSlotSelected(selection)
  if m_selection ~= selection then
    m_selection = selection
    if m_goodsInfo then
      REF.WidgetNumberEdit["$SetNumber"](1, true)
    end
  end
end

function UpdateMixSlot(slotRef, wrapIndex, rowIndex)
  if m_dataList and rowIndex and rowIndex < #m_dataList then
    slotRef["$$SetData"](m_dataList[rowIndex + 1], rowIndex)
  end
end

function OnGetClick()
  this:GameRequest("fci/itemuse/"):Post({
    id = m_manualBox.id,
    count = m_buyCount,
    index = m_selection.index - 1
  }, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange, function()
      WU.RecycleWindow(this)
      DB:DelayInvokeInFrames(1, function()
        if m_callback then
          m_callback(true, m_buyCount)
        end
      end)
    end)
  end)
end

function OnBuyClick()
  this:BroadcastGameEvent("TryToBuyGoods", m_goodsInfo, m_selection.index - 1, m_buyCount, function()
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
