local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local m_shopInfo, m_currency, m_currencyCount, m_firstEnter, m_activityType

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollViewBuff.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  LU.Bind(REF.WrapContentBuff, {
    updateRow = UpdateBuffSlot
  })
end

function InitWindow()
  m_firstEnter = true
  m_activityType = this:GetData("Welfare/ActivityType")
  REF.ScrollViewBuff.gameObject:SetActive(false)
  REF.LabelStock.ResourceChangeListener:AddListener(OnResourceChanged)
  this:BindRemote(this:GameRequest("fci/BuffShop/" .. m_activityType), OnBuffShop)
end

function Focus()
  local goodsId = this:GetData("Carnival91Pass/EffectGoodsId")
  if goodsId then
    this:BroadcastGameEvent("Carnival91PassPlayEffect", goodsId)
    this:SetData("Carnival91Pass/EffectGoodsId", nil)
  end
end

function OnBuffShop(result)
  if result then
    m_shopInfo = result.shopInfo
    local costConfig = PB.get("ActivityBuffGoods", m_shopInfo[1].goodsId, 1).cost[1]
    m_currency = {
      type = costConfig.type,
      id = costConfig.id
    }
    m_currencyCount = this:GetData("fci/item/" .. m_currency.id).count
    REF.LabelStock.ResourcePrinter:SetResource(m_currency.type, m_currency.id, m_currencyCount)
    LU.Set(REF.WrapContentBuff, #m_shopInfo, m_firstEnter)
    REF.ScrollViewBuff.gameObject:SetActive(true)
    REF.WrapContentBuff.UIPlayTween:Play(true)
    m_firstEnter = false
  end
end

function OnResourceChanged(type, id, count)
  m_currency.type = U.ToInt(type)
  m_currency.id = id
  m_currencyCount = count
end

function UpdateBuffSlot(slotRef, wrapIndex, rowIndex)
  if m_shopInfo and rowIndex and rowIndex < #m_shopInfo then
    slotRef["$$SetData"](m_shopInfo[rowIndex + 1].goodsId, rowIndex)
  end
end
