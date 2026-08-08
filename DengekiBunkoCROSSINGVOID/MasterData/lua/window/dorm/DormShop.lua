local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DU = require("Common/DormUtil")
local LU = require("Common/ListUtil")
local m_buyRecordMap, m_goodsMap, m_themeGoodsMap, m_currGoodList, m_category, m_furnMoneyId

function SetupWindow()
  for i = 0, REF.TabGrid.transform.childCount - 1 do
    REF.TabGrid[i]["@category"] = i
    if i == 0 then
      REF.TabGrid[i]["$$SetTab"](WU.GetString("Dorm_Theme"), "DormitorySystem", "choice_1")
    else
      REF.TabGrid[i]["$$SetTab"](WU.GetString("Dorm_Category_" .. i), "DormitorySystem", "choice_" .. i + 1)
    end
    REF.TabGrid[i]["$$SetClickCallback"](OnClickTab)
  end
  LU.Bind(REF.WrapContentTheme, {
    updateRow = UpdateGoodSlot
  })
  LU.Bind(REF.WrapContentFurn, {
    updateRow = UpdateGoodSlot
  })
  m_goodsMap = _ENV["!"]({})
  local goodsInfo = PB.all("DormShopGoods")
  for i = 1, #goodsInfo do
    local config = goodsInfo[i]
    m_goodsMap[config.goods.id] = m_goodsMap[config.goods.id] or {}
    table.insert(m_goodsMap[config.goods.id], config)
    if m_furnMoneyId == nil then
      for i = 1, #config.cost do
        if config.cost[i].type == PB.enum.ResourceType.ResItem then
          m_furnMoneyId = config.cost[i].id
        end
      end
    end
  end
  m_themeGoodsMap = _ENV["!"]({})
  local furnInfo = PB.all("FurnitureConfig")
  for i = 1, #furnInfo do
    local furn = furnInfo[i]
    m_themeGoodsMap[furn.theme] = m_themeGoodsMap[furn.theme] or {}
    table.insert(m_themeGoodsMap[furn.theme], m_goodsMap[furn.id])
  end
  m_themeGoodsMap = table.where(m_themeGoodsMap, function(k, v)
    return 0 < #v
  end)
end

function InitWindow()
  LU.Set(REF.WrapContentTheme, 0)
  LU.Set(REF.WrapContentFurn, 0)
  this:BindRemote(this:GameRequest("fci/dorm-shop-goods/"), function(data)
    if data then
      m_buyRecordMap = {}
      for i = 1, #data.buyRecord do
        local record = data.buyRecord[i]
        m_buyRecordMap[record.furnitureId] = record.buyCount
      end
      if m_category == nil then
        REF.TabGrid[0]["$$SetSelected"]()
      else
        ActiveShop(m_category)
      end
      REF.LabelFurnMoneyStock.ResourcePrinter:SetResource(PB.enum.ResourceType.ResItem, m_furnMoneyId, this:GetData("fci/item/" .. m_furnMoneyId).count)
    end
  end)
end

function UninitWindow()
  m_category = nil
end

function ActiveShop(category)
  m_category = category
  if category == 0 then
    WU.SetActive(REF.ShopScrollViewListFurn, false)
    WU.SetActive(REF.ShopScrollViewListTheme, true)
    m_currGoodList = _ENV["!"](m_themeGoodsMap):toarray()
    LU.Set(REF.WrapContentTheme, #m_currGoodList)
  else
    WU.SetActive(REF.ShopScrollViewListTheme, false)
    WU.SetActive(REF.ShopScrollViewListFurn, true)
    m_currGoodList = m_goodsMap:where(function(furnId, v)
      return PB.get("FurnitureConfig", furnId).category == category
    end):toarray():sort(function(a, b)
      local aFurnId = a[1].goods.id
      local bFurnId = b[1].goods.id
      local aSoldOut = FurnIsSoldOut(a)
      local bSoldOut = FurnIsSoldOut(b)
      if aSoldOut ~= bSoldOut then
        return bSoldOut
      end
      return aFurnId < bFurnId
    end)
    LU.Set(REF.WrapContentFurn, #m_currGoodList)
  end
end

function UpdateGoodSlot(goRef, wrapIndex, realIndex)
  if m_currGoodList and realIndex and realIndex < #m_currGoodList then
    if m_category == 0 then
      local goodInfoList = m_currGoodList[realIndex + 1]
      local furnId = goodInfoList[1][1].goods.id
      local themeId = PB.get("FurnitureConfig", furnId).theme
      local manifests = {}
      goRef["@themeId"] = themeId
      local soldOut = true
      for i = 1, #goodInfoList do
        local goodInfo = goodInfoList[i]
        if not FurnIsSoldOut(goodInfo) then
          soldOut = false
          UpdateManifest(manifests, goodInfo)
        end
      end
      goRef["@manifests"] = manifests
      goRef["$$SetTheme"](themeId, manifests, soldOut)
      goRef["$$SetClickCallback"](fif(soldOut, nil, OnClickGood))
    else
      local goodInfo = m_currGoodList[realIndex + 1]
      local soldOut = FurnIsSoldOut(goodInfo)
      goRef["@goodInfo"] = goodInfo
      goRef["$$SetFurniture"](goodInfo, soldOut, false)
      goRef["$$SetClickCallback"](fif(soldOut, nil, OnClickGood))
    end
  end
end

function FurnIsSoldOut(goodInfo)
  local furnId = goodInfo[1].goods.id
  local buyRecord = m_buyRecordMap[furnId]
  return buyRecord and buyRecord >= goodInfo[1].buyLimit
end

function UpdateManifest(manifests, goodInfo)
  for i = 1, #goodInfo do
    local info = goodInfo[i]
    local _, manifest = table.find(manifests, function(k, v)
      return v.type == info.cost[1].type
    end)
    if not manifest then
      local srcCost = info.cost[1]
      manifest = {
        type = srcCost.type,
        cost = {
          type = srcCost.type,
          id = srcCost.id,
          count = srcCost.count
        },
        shopGoods = {}
      }
      table.insert(manifests, manifest)
    end
    manifest.cost.count = manifest.cost.count + info.cost[1].count
    table.insert(manifest.shopGoods, info.shopGoodsId)
  end
end

function OnClickTab(go)
  ActiveShop(_ENV["$"](go)["@category"])
end

function OnClickGood(go)
  if m_category == 0 then
    WU.AcquireWindowAsync("DormShopTheme", function(w)
      _ENV["$"](w)["$$SetData"](_ENV["$"](go)["@themeId"], _ENV["$"](go)["@manifests"])
    end)
  else
    WU.AcquireWindowAsync("DormShopBuy", function(w)
      _ENV["$"](w)["$$SetFurniture"](_ENV["$"](go)["@goodInfo"])
    end)
  end
end
