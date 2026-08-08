local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_callback

function Start()
end

function SetView(exchangeInfo, currentCount)
  if exchangeInfo == nil then
    return
  end
  WU.BindButtonEvent(REF.ButtonExchange, OnSlotClick)
  for i = 0, #REF.RewardsGroup - 1 do
    local good = exchangeInfo.good[i + 1]
    local ref = REF.RewardsGroup[i]
    WU.SetActive(ref.root, good ~= nil)
    if good ~= nil then
      ref["$$SetData"](good.type, good.id, good.count)
    end
  end
  local canBuy = currentCount < exchangeInfo.buyLimit
  for i = 0, #REF.CostsGroup - 1 do
    local cost = exchangeInfo.cost[i + 1]
    local ref = REF.CostsGroup[i]
    WU.SetActive(ref.root, cost ~= nil)
    if cost ~= nil then
      local myCount = GetCount(cost.type, cost.id)
      if myCount < cost.count then
        canBuy = false
      end
      ref.LabelMoney.ResourcePrinter:SetResource(cost.type, cost.id, cost.count)
      ref["@cost"] = cost
      WU.BindButtonEvent(ref.root, OnShowMoneyMessage)
    end
  end
  if canBuy then
    REF.ButtonExchange.UIButton:SetState(1, true)
    REF.ButtonExchange.BoxCollider2D.enabled = true
  else
    REF.ButtonExchange.UIButton:SetState(3, true)
    REF.ButtonExchange.BoxCollider2D.enabled = false
  end
  WU.SetActive(REF.SpriteRefrash, exchangeInfo.needRefresh)
  if exchangeInfo.needRefresh then
    REF.LabelRefrash.UILabel.text = WU.GetString("Window_RefrashType" .. exchangeInfo.refreshRule)
  end
  REF.LabelExchange.UILabel.text = WU.GetString("Window_ExchangeRatio", exchangeInfo.buyLimit - currentCount, exchangeInfo.buyLimit)
end

function OnShowMoneyMessage(go)
  local cost = _ENV["$"](go)["@cost"]
  WU.ShowResourceDetail(cost.type, cost.id)
end

function SetClickCallback(callback)
  m_callback = callback
end

function OnSlotClick()
  if m_callback ~= nil then
    m_callback(REF.root.gameObject)
  end
end

function GetCount(type, id)
  if type == PB.enum.ResourceType.ResItem then
    local itemInfo = DB:GetData("fci/item/" .. id)
    if itemInfo then
      return itemInfo.count
    else
      return 0
    end
  else
    return DB:GetData("fci/resource/" .. PB.enum.ResourceType.__keys[type] .. "_" .. id) or 0
  end
end
