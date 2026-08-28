local DataModel = {}
DataModel.NPCDialogEnum = {
  talkText = "talkText",
  enterText = "enterText",
  ItemText = "ItemText",
  saleOutText = "saleOutText",
  buySuccessText = "buySuccessText"
}

function DataModel.initPurchaseDic(shopId)
  local serverData = PlayerData.ServerData.shops[tostring(shopId)] or {}
  local nowData = serverData.items or {}
  local purchaseDic = {}
  for i, v in ipairs(nowData) do
    purchaseDic[tonumber(v.id)] = v.py_cnt
  end
  DataModel.purchaseDic = purchaseDic
end

function DataModel.init(activityId, shopId)
  local activityCfg = PlayerData:GetFactoryData(activityId)
  local shopCfg = PlayerData:GetFactoryData(shopId)
  DataModel.npcId = activityCfg.npcId
  DataModel.shopId = shopId
  DataModel.shopList = {}
  DataModel.initPurchaseDic(shopId)
  local StoreDataModel = require("UIStore/UIStoreDataModel")
  for i, v in ipairs(shopCfg.shopList) do
    local cfg = PlayerData:GetFactoryData(v.id)
    local limitBuy = cfg.purchase
    local maxBuyCnt = StoreDataModel:GetPurchaseNum(cfg)
    table.insert(DataModel.shopList, {
      id = v.id,
      idx = i,
      limitBuy = limitBuy,
      maxBuyCnt = maxBuyCnt
    })
  end
  DataModel.SortShopList()
  DataModel.coinList = shopCfg.currencyShow or {}
end

function DataModel.SortShopList()
  table.sort(DataModel.shopList, function(t1, t2)
    local canBuy1 = false
    local canBuy2 = false
    if not t1.limitBuy then
      canBuy1 = true
    else
      canBuy1 = 0 < t1.maxBuyCnt - (DataModel.purchaseDic[t1.id] or 0)
    end
    if not t2.limitBuy then
      canBuy2 = true
    else
      canBuy2 = 0 < t2.maxBuyCnt - (DataModel.purchaseDic[t2.id] or 0)
    end
    if canBuy1 == canBuy2 then
      return t1.idx < t2.idx
    end
    return canBuy1
  end)
end

return DataModel
