local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local m_goodsMap, m_buyRecordMap, m_furnList, m_themeId, m_manifests

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonBuyAll, OnClickBuyAll)
  LU.Bind(REF.WrapContentFurniture, {
    updateRow = UpdateSlot
  })
  m_goodsMap = _ENV["!"]({})
  local goodsInfo = PB.all("DormShopGoods")
  for i = 1, #goodsInfo do
    local config = goodsInfo[i]
    m_goodsMap[config.goods.id] = m_goodsMap[config.goods.id] or {}
    table.insert(m_goodsMap[config.goods.id], config)
  end
end

function InitWindow()
  LU.Set(REF.WrapContentFurniture, 0)
  this:Bind("fci/dorm-shop-goods/", OnDormShopGoods, false)
end

function OnDormShopGoods(data)
  if data then
    m_buyRecordMap = {}
    for i = 1, #data.buyRecord do
      local record = data.buyRecord[i]
      m_buyRecordMap[record.furnitureId] = record.buyCount
    end
  end
  m_furnList = m_furnList:sort(function(a, b)
    local aSoldOut = FurnIsSoldOut(m_goodsMap[a])
    local bSoldOut = FurnIsSoldOut(m_goodsMap[b])
    if aSoldOut ~= bSoldOut then
      return bSoldOut
    end
    return a < b
  end)
  LU.Set(REF.WrapContentFurniture, #m_furnList)
end

function SetData(themeId, manifests)
  m_themeId = themeId
  m_manifests = manifests
  REF.LabelThemeName.UIHtmlLabel.text = WU.GetString("FurnitureThemeName_" .. themeId)
  m_furnList = _ENV["!"]({})
  local dormShopGoods = PB.all("DormShopGoods")
  for i = 1, #dormShopGoods do
    local goodConfig = dormShopGoods[i]
    local furnId = goodConfig.goods.id
    if PB.get("FurnitureConfig", furnId).theme == themeId then
      m_furnList[furnId] = furnId
    end
  end
  m_furnList = m_furnList:toarray()
  REF.WidgetDormShopThemeSlot["$SetTheme"](themeId, manifests, false, true)
  OnDormShopGoods(this:GetData("fci/dorm-shop-goods"))
end

function UpdateSlot(goRef, wrapIndex, realIndex)
  if m_furnList and realIndex and realIndex < #m_furnList then
    local furnId = m_furnList[realIndex + 1]
    local goodInfo = m_goodsMap[furnId]
    if goodInfo == nil then
      error("GamePlay", "GoodInfo is nil, id: " .. furnId)
      return
    end
    local soldOut = FurnIsSoldOut(goodInfo)
    goRef["@goodInfo"] = goodInfo
    goRef["$$SetFurniture"](goodInfo, soldOut, true)
    goRef["$$SetClickCallback"](fif(soldOut, nil, OnClickGood))
  end
end

function FurnIsSoldOut(goodInfo)
  local furnId = goodInfo[1].goods.id
  local buyRecord = m_buyRecordMap[furnId]
  return buyRecord and buyRecord >= goodInfo[1].buyLimit
end

function OnClickGood(go)
  WU.AcquireWindowAsync("DormShopBuy", function(w)
    _ENV["$"](w)["$$SetFurniture"](_ENV["$"](go)["@goodInfo"])
  end)
end

function OnClickBuyAll(go)
  WU.AcquireWindowAsync("DormShopBuy", function(w)
    _ENV["$"](w)["$$SetTheme"](m_themeId, m_manifests)
  end)
end
