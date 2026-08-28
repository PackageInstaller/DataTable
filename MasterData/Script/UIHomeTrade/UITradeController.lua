local View = require("UIHomeTrade/UIHomeTradeView")
local DataModel = require("UIHomeTrade/UITradeDataModel")
local MainDataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local MainController = require("UIHomeTrade/UIHomeTradeController")
local Controller = {}

function Controller:ShowTradeView(type)
  Net:SendProto("station.goods_info", function(json)
    DataModel.cacheNPCTalk = {}
    DataModel.BargainBuff = nil
    DataModel.SidGoodLvList = json.sid_good_lv
    DataModel.GoodFunds = json.good_funds
    DataModel.SidTotalInvestMoney = json.currency_funds or {}
    Controller:ShowBargainBuffTip(false)
    DataModel.recent_trade_report = json.recent_trade_report
    DataModel.server_sid_tax = json.server_sid_tax
    DataModel.Revenue = json.revenue or 0
    DataModel.QuestTagBuff = json.quest_tag_bf or {}
    DataModel.RandomRate = json.rate or 1
    DataModel.InitDayRefreshTime()
    DataModel.InitQuestGoodsId()
    DataModel.InitHomeSkillData()
    DataModel.InitLocalSellGoods()
    DataModel.InitOrderBuffGoods()
    DataModel.BargainSuccessRateIndex = 1
    DataModel.RiseSuccessRateIndex = 1
    DataModel.CurTradeType = 0
    DataModel.CurCityGoodsInfo = json.stations[tostring(DataModel.StationId)]
    DataModel.CurCityGoodsInfo.sell_price = json.goods_price.sell_price
    DataModel.CurCityGoodsInfo.buy_price = json.goods_price.buy_price
    DataModel.CurCityGoodsInfo.b_num = DataModel.CurCityGoodsInfo.b_num or 0
    DataModel.CurCityGoodsInfo.r_num = DataModel.CurCityGoodsInfo.r_num or 0
    DataModel.CurCityGoodsInfo.b_quota = DataModel.CurCityGoodsInfo.b_quota or 0
    DataModel.CurCityGoodsInfo.r_quota = DataModel.CurCityGoodsInfo.r_quota or 0
    for k, v in pairs(DataModel.CurCityGoodsInfo.sell_price) do
      local sellInfo = json.stations[tostring(DataModel.StationId)].sell[k]
      if sellInfo ~= nil then
        v.num = sellInfo.num or 0
        v.extra = sellInfo.extra or 0
        v.sold = sellInfo.sold or 0
      else
        v.num = 0
        v.extra = 0
        v.sold = 0
      end
    end
    DataModel.RefreshTradeDataPercent()
    View.Group_Main.self:SetActive(false)
    UIManager:LoadSplitPrefab(View, "UI/HomeTrade/HomeTrade", "Group_Trade")
    View.Group_Trade.self:SetActive(true)
    View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_DrinkWL:SetActive(false)
    View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_Drink:SetActive(false)
    if DataModel.DrinkBuff then
      local tempList = PlayerData:GetFactoryData(80309368, "ListFactory").drinkBuffList
      for k, v in pairs(tempList) do
        if tonumber(DataModel.DrinkBuff.id) == v.id then
          View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_DrinkWL:SetActive(true)
          break
        end
      end
      tempList = PlayerData:GetFactoryData(80300224, "ListFactory").drinkBuffList
      for k, v in pairs(tempList) do
        if tonumber(DataModel.DrinkBuff.id) == v.id then
          View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_Drink:SetActive(true)
          break
        end
      end
    end
    local stationCA = PlayerData:GetFactoryData(MainDataModel.StationId)
    View.Group_Trade.Group_NpcInfoL.Group_Station.Txt_Station:SetText(stationCA.name)
    MainDataModel.IsTradeOpen = true
    Controller:RefreshResources()
    Controller:RefreshTradePanelByType(type)
    if type == DataModel.TradeType.Buy then
      Controller:RefreshBuyTradeMode()
      View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:MoveToTop()
    else
      Controller:RefreshSaleTradeMode()
      View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:MoveToTop()
    end
    View.self:PlayAnim("Trade")
  end)
end

function Controller:RefreshBuyLimit()
  local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
  local refreshItem = tradeConfig.refreshGoods[1]
  local t = {}
  t.itemId = refreshItem.id
  t.itemNum = PlayerData:GetGoodsById(t.itemId).num
  t.useNum = 1
  local itemCA = PlayerData:GetFactoryData(refreshItem.id, "ItemFactory")
  CommonTips.OnItemPromptBatch(string.format(GetText(80600453), itemCA.name), t, function()
    if PlayerData.TempCache.ItemPromptBatchNum == 0 or t.itemNum < PlayerData.TempCache.ItemPromptBatchNum then
      CommonTips.OpenTips(80600488)
      return
    end
    Net:SendProto("station.purchase_order", function(json)
      local useItem = {}
      useItem[refreshItem.id] = PlayerData.TempCache.ItemPromptBatchNum
      PlayerData:RefreshUseItems(useItem)
      for k, v in pairs(DataModel.CurCityGoodsInfo.sell_price) do
        local sellInfo = json.sell[k]
        if sellInfo then
          v.num = sellInfo.num or 0
          v.extra = sellInfo.extra or 0
          v.sold = sellInfo.sold or 0
        end
      end
      DataModel.RefreshSellList(true)
      Controller:RefreshTradePanelByType(DataModel.TradeType.Buy, true, true)
      CommonTips.OpenTips(80601103)
    end, PlayerData.TempCache.ItemPromptBatchNum, refreshItem.id)
  end)
end

function Controller:RefreshResources()
  Controller:RefreshCoin()
  Controller:RefreshActionValue()
  Controller:RefreshTradeLv()
end

function Controller:RefreshCoin()
  if View.Group_Trade and View.Group_Trade.self and View.Group_Trade.self.IsActive then
    local goldIcon, goldNum = DataModel.GetStationGoldIconAndNum()
    View.Group_Trade.Group_Resources.Group_GoldCoin.Txt_Num:SetText(goldNum or 0)
    View.Group_Trade.Group_Resources.Group_GoldCoin.Img_Icon:SetSprite(goldIcon or "")
  end
end

function Controller:RefreshActionValue()
  if View.Group_Trade and View.Group_Trade.self and View.Group_Trade.self.IsActive then
    local homeCommon = require("Common/HomeCommon")
    local maxHomeEnergy = homeCommon.GetMaxHomeEnergy()
    View.Group_Trade.Group_Resources.Group_Energy.Txt_Num:SetText(DataModel.GetActionValue() .. "/" .. maxHomeEnergy)
    View.Group_Trade.Group_Resources.Group_Energy.Img_PB:SetFilledImgAmount(DataModel.GetActionValue() / maxHomeEnergy)
  end
end

function Controller:RefreshTradeLv()
  if View.Group_Trade and View.Group_Trade.self and View.Group_Trade.self.IsActive then
    View.Group_Trade.Group_Resources.Group_TradeLv.Txt_Num:SetText(string.format(GetText(80600599), PlayerData:GetHomeInfo().trade_lv))
  end
end

function Controller:RefreshTradePanelByType(type, force, noShowTalk)
  if type == nil then
    type = DataModel.CurTradeType
  end
  if not force and DataModel.CurTradeType == type then
    return
  end
  if not force then
    View.Group_Trade.Group_Bargain.Group_Success.self:SetActive(false)
    View.Group_Trade.Group_Bargain.Group_Success2.self:SetActive(false)
    View.Group_Trade.Group_Bargain.Group_Fail.self:SetActive(false)
  end
  DataModel.CurTradeType = type
  DataModel.CalcSpaceInfo()
  Controller:ShowQuestInfoChild(false)
  if type == DataModel.TradeType.Buy then
    if not noShowTalk then
      MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.tabBuyText)
    end
    View.Group_Trade.Group_Buy.self:SetActive(true)
    View.Group_Trade.Group_Sell.self:SetActive(false)
    DOTweenTools.DOLocalMoveXCallback(View.Group_Trade.Group_Tab.Img_Selected.transform, -382.5, 0.25, function()
      View.Group_Trade.Group_Tab.Btn_Buy.Group_On.self:SetActive(true)
      View.Group_Trade.Group_Tab.Btn_Buy.Group_Off.self:SetActive(false)
      View.Group_Trade.Group_Tab.Btn_Sell.Group_On.self:SetActive(false)
      View.Group_Trade.Group_Tab.Btn_Sell.Group_Off.self:SetActive(true)
    end)
    if not force then
      DataModel.RefreshSellList()
      DataModel.TempGoodsList = {}
      DataModel.TempCurSpace = 0
      DataModel.TempCurCost = 0
      DataModel.CurSelectGoodIdx = 1
    end
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurSellList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
    Controller:RefreshBargainPanel()
    Controller:RefreshTempBuyBottomShow()
  else
    if not noShowTalk then
      MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.tabSellText)
    end
    View.Group_Trade.Group_Buy.self:SetActive(false)
    View.Group_Trade.Group_Sell.self:SetActive(true)
    DOTweenTools.DOLocalMoveXCallback(View.Group_Trade.Group_Tab.Img_Selected.transform, -83.5, 0.25, function()
      View.Group_Trade.Group_Tab.Btn_Buy.Group_On.self:SetActive(false)
      View.Group_Trade.Group_Tab.Btn_Buy.Group_Off.self:SetActive(true)
      View.Group_Trade.Group_Tab.Btn_Sell.Group_On.self:SetActive(true)
      View.Group_Trade.Group_Tab.Btn_Sell.Group_Off.self:SetActive(false)
    end)
    if not force then
      DataModel.RefreshAcquisitionList()
      DataModel.TempGoodsList = {}
      DataModel.AcquistionRemoveReocrd = {}
      DataModel.CurSelectGoodIdx = 1
      DataModel.TempCurSpace = 0
      DataModel.TempCurProfit = 0
      DataModel.TempCurAvgCost = 0
      DataModel.TempCurTotalSalePrice = 0
    end
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurAcquisitionList)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    View.Group_Trade.Group_Sell.Txt_Null:SetActive(#DataModel.CurAcquisitionList == 0 and #DataModel.TempGoodsList == 0)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
    Controller:RefreshBargainPanel()
    Controller:RefreshTempSaleBottomShow()
  end
end

function Controller:RefreshBuyTradeMode(mode)
  if DataModel.BuyBatchMode == mode then
    return
  end
  if mode ~= nil then
    DataModel.BuyBatchMode = mode
    if View.Group_Trade.self == nil or not View.Group_Trade.self.IsActive then
      return
    end
  end
  View.Group_Trade.Group_Buy.Btn_Batch.Group_Off.self:SetActive(DataModel.BuyBatchMode ~= 1)
  View.Group_Trade.Group_Buy.Btn_Max.Group_Off.self:SetActive(DataModel.BuyBatchMode ~= 2)
  View.Group_Trade.Group_Buy.Btn_Batch.Group_On.self:SetActive(DataModel.BuyBatchMode == 1)
  View.Group_Trade.Group_Buy.Btn_Max.Group_On.self:SetActive(DataModel.BuyBatchMode == 2)
end

function Controller:RefreshSaleTradeMode(mode)
  if DataModel.SaleBatchMode == mode then
    return
  end
  if mode ~= nil then
    DataModel.SaleBatchMode = mode
    if View.Group_Trade.self == nil or not View.Group_Trade.self.IsActive then
      return
    end
  end
  View.Group_Trade.Group_Sell.Btn_Batch.Group_Off.self:SetActive(DataModel.SaleBatchMode ~= 1)
  View.Group_Trade.Group_Sell.Btn_Max.Group_Off.self:SetActive(DataModel.SaleBatchMode ~= 2)
  View.Group_Trade.Group_Sell.Btn_Batch.Group_On.self:SetActive(DataModel.SaleBatchMode == 1)
  View.Group_Trade.Group_Sell.Btn_Max.Group_On.self:SetActive(DataModel.SaleBatchMode == 2)
end

function Controller:RefreshTempBuyBottomShow()
  View.Group_Trade.Group_Buy.Txt_Tax:SetText(string.format("%.1f%%", DataModel.GetTax() * 100))
  View.Group_Trade.Group_Buy.Group_Price.Txt_Num:SetText(MainDataModel.NumRound(DataModel.TempCurCost * (1 + DataModel.GetTax()) + DataModel.GetActivityGoodsTax()))
  local goldIcon, _ = DataModel.GetStationGoldIconAndNum()
  View.Group_Trade.Group_Buy.Group_Price.Img_Coin:SetSprite(goldIcon or "")
  local oriSpace = MainDataModel.NumCeilPrecision(DataModel.CurUseSpace)
  local curUseSpace = MainDataModel.NumCeilPrecision(DataModel.TempCurSpace)
  if curUseSpace == 0 then
    View.Group_Trade.Group_Buy.Txt_Space:SetText(string.format(GetText(80600529), oriSpace, "", DataModel.MaxSpace))
  else
    View.Group_Trade.Group_Buy.Txt_Space:SetText(string.format(GetText(80600529), oriSpace, "+" .. curUseSpace, DataModel.MaxSpace))
  end
  View.Group_Trade.Group_Buy.Img_PBNow:SetFilledImgAmount(DataModel.CurUseSpace / DataModel.MaxSpace)
  View.Group_Trade.Group_Buy.Img_PBAfter:SetFilledImgAmount((oriSpace + curUseSpace) / DataModel.MaxSpace)
  local tempCount = #DataModel.TempGoodsList
  View.Group_Trade.Group_Buy.Btn_AddAll.self:SetActive(tempCount == 0)
  View.Group_Trade.Group_Buy.Btn_Clear.self:SetActive(tempCount ~= 0)
end

function Controller:RefreshBargainPanel()
  local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
  local isBuy = DataModel.CurTradeType == DataModel.TradeType.Buy
  local bargainMaxCount = DataModel.GetMaxBargainCount(isBuy)
  local bargainSuccessCount = isBuy and DataModel.BargainSuccessRateIndex or DataModel.RiseSuccessRateIndex
  local bargainUseCount = isBuy and DataModel.CurCityGoodsInfo.b_num or DataModel.CurCityGoodsInfo.r_num
  local Btn_Bargain = isBuy and View.Group_Trade.Group_Buy.Btn_Bargain or View.Group_Trade.Group_Sell.Btn_Bargain
  local Btn_Renegotiate = isBuy and View.Group_Trade.Group_Buy.Btn_Renegotiate or View.Group_Trade.Group_Sell.Btn_Renegotiate
  local Txt_Bargain = isBuy and View.Group_Trade.Group_Buy.Txt_Bargain or View.Group_Trade.Group_Sell.Txt_Bargain
  local failed = false
  local isMaxSuccess = bargainMaxCount < bargainSuccessCount
  if isMaxSuccess then
    Btn_Bargain.Btn.interactable = false
  else
    Btn_Bargain.Btn.interactable = true
  end
  local actionValueCost = tradeConfig.bargainCost
  Btn_Bargain.Txt_Cost:SetText(actionValueCost)
  for i = 1, 10 do
    local child = Btn_Bargain.Group_Num["Img_N" .. i]
    child.self:SetActive(i <= bargainMaxCount)
    child.Img_Full:SetActive(i > bargainUseCount)
  end
  local buyPercent = 0
  if not failed then
    buyPercent = isBuy == true and DataModel.CurCityGoodsInfo.b_quota or DataModel.CurCityGoodsInfo.r_quota
  end
  Txt_Bargain:SetText(buyPercent * 100 .. "%")
  Btn_Renegotiate.self:SetActive(not isMaxSuccess and bargainMaxCount <= bargainUseCount)
end

function Controller:ConfirmBargain()
  local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
  local isBuy = DataModel.CurTradeType == DataModel.TradeType.Buy
  local bargainMaxCount = DataModel.GetMaxBargainCount(isBuy)
  local bargainSuccessCount = isBuy and DataModel.BargainSuccessRateIndex or DataModel.RiseSuccessRateIndex
  local bargainUseCount = isBuy and DataModel.CurCityGoodsInfo.b_num or DataModel.CurCityGoodsInfo.r_num
  local quota = isBuy and DataModel.CurCityGoodsInfo.b_quota or DataModel.CurCityGoodsInfo.r_quota
  local maxQuota = isBuy and tradeConfig.bargainMax or tradeConfig.riseMax
  if quota >= maxQuota then
    CommonTips.OpenTips(80600487)
    return
  end
  if Controller:CheckDrinkBuff() then
    CommonTips.OpenTips(80600774)
    return
  end
  if bargainMaxCount < bargainSuccessCount then
    return
  end
  if bargainMaxCount <= bargainUseCount then
    local itemInfo = tradeConfig.refreshBargain[1]
    local itemCA = PlayerData:GetFactoryData(itemInfo.id, "ItemFactory")
    local param = {}
    param.itemId = itemInfo.id
    param.itemNum = PlayerData:GetGoodsById(itemInfo.id).num or 0
    param.useNum = itemInfo.num
    CommonTips.OnItemPrompt(string.format(GetText(80600683), itemCA.name), param, function()
      if param.itemNum < param.useNum then
        CommonTips.OpenTips(80600488)
        return
      end
      Net:SendProto("station.refresh_dicker", function(json)
        local useItem = {}
        useItem[itemInfo.id] = itemInfo.num
        PlayerData:RefreshUseItems(useItem)
        DataModel.CurCityGoodsInfo.b_num = 0
        DataModel.CurCityGoodsInfo.b_quota = 0
        DataModel.CurCityGoodsInfo.r_num = 0
        DataModel.CurCityGoodsInfo.r_quota = 0
        DataModel.BargainSuccessRateIndex = 1
        DataModel.RiseSuccessRateIndex = 1
        Controller:RefreshBargainPanel()
        DataModel.RefreshPriceInfo(0)
        Controller:RefreshTradePanelByType(DataModel.CurTradeType, true, true)
      end)
    end)
    return
  end
  local actionValueCost = tradeConfig.bargainCost
  local homeCommon = require("Common/HomeCommon")
  if actionValueCost + DataModel.GetActionValue() > homeCommon.GetMaxHomeEnergy() then
    homeCommon.OpenMoveEnergyUseItem(function()
      Controller:RefreshActionValue()
    end)
    return
  end
  local netName = isBuy and "station.down_price" or "station.up_price"
  Net:SendProto(netName, function(json)
    local isSuccess = json.info == 1
    DataModel.ConfirmBargain(isSuccess, json.quota)
    bargainUseCount = bargainUseCount + 1
    local bargainPercent = json.quota
    local t = {}
    t.stationId = MainDataModel.StationId
    t.isSuccess = isSuccess
    t.isBuy = isBuy
    t.quota = quota
    t.bargainPercent = bargainPercent or 0
    
    local function cb()
      if isSuccess then
        if isBuy then
          MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.haggleSuccessText, true)
        else
          MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.raiseSuccessText, true)
        end
      elseif isBuy then
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.haggleFailText, true)
      else
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.raiseFailText, true)
      end
    end
    
    UIManager:Open("UI/HomeTrade/BargainTips", Json.encode(t), cb)
    Controller:RefreshActionValue()
    Controller:RefreshBargainPanel()
    Controller:RefreshTradePanelByType(DataModel.CurTradeType, true, true)
  end)
end

function Controller:BuyToTemp(info, num)
  if 0 < num and 0 >= info.num then
    CommonTips.OpenTips(80600354)
    return
  end
  local buyComplete, tempNum = DataModel.RefreshBuyToTempData(info, num)
  if buyComplete then
    Controller:UpdateQuestInfoPanel(info.id, tempNum)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurSellList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
    Controller:RefreshTempBuyBottomShow()
    if 0 < num then
      if info.percent < 1 then
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.buyDownText, true)
      elseif info.percent > 1 then
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.buyUpText, true)
      else
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.buyFlatText, true)
      end
    else
      MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.cancelBuyText, true)
    end
  end
end

function Controller:ConfirmBuy()
  local function completeCb(info)
    Controller:ReturnToMain()
    
    Controller:ShowSettlement(info, DataModel.TradeType.Buy)
    MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.buySuccessText)
  end
  
  local function priceWaveCb()
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurSellList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    Controller:RefreshCoin()
    Controller:RefreshTempBuyBottomShow()
    CommonTips.OpenTips(80600357)
  end
  
  if Controller:CheckDrinkBuff() then
    CommonTips.OpenTips(80600774)
    return
  end
  if Controller:CheckActiveBuff() then
    CommonTips.OpenTips(80606887)
    return
  end
  if MainDataModel.NumRound(DataModel.TempCurCost * (1 + DataModel.GetTax()) + DataModel.GetActivityGoodsTax()) > DataModel.GetMoney() then
    CommonTips.OpenTips(80600539)
    return
  end
  if #DataModel.TempGoodsList == 0 then
    CommonTips.OpenTips(80600289)
    return
  end
  local strGoods = ""
  for i = 1, #DataModel.TempGoodsList do
    local info = DataModel.TempGoodsList[i]
    strGoods = strGoods .. info.id .. ":" .. info.num
    if i ~= #DataModel.TempGoodsList then
      strGoods = strGoods .. ","
    end
  end
  Net:SendProto("station.buy", function(json)
    if json.goods_price ~= nil or json.server_sid_tax ~= nil then
      if json.goods_price then
        DataModel.GoodsPriceWave(json.goods_price)
      end
      if json.server_sid_tax then
        DataModel.server_sid_tax = json.server_sid_tax
      end
      priceWaveCb()
      return
    end
    MainController:RefreshWarehouseUnlock()
    local stationId = DataModel.StationId
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    if stationCA.attachedToCity > 0 then
      stationId = stationCA.attachedToCity
    end
    local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
    local completeInfo = {}
    completeInfo.tax = DataModel.GetTax()
    completeInfo.taxPrice = MainDataModel.NumRound(DataModel.TempCurCost * completeInfo.tax + DataModel.GetActivityGoodsTax())
    completeInfo.totalPrice = completeInfo.taxPrice + DataModel.TempCurCost
    local goldRate = DataModel.GetTradeGoldRate()
    completeInfo.rep = MainDataModel.NumRound(completeInfo.taxPrice / goldRate) / tradeConfig.taxConvertRep
    completeInfo.repLv = PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
    completeInfo.bargain = DataModel.CurCityGoodsInfo.b_quota
    local homeCommon = require("Common/HomeCommon")
    local curTotalRep, totalRep = homeCommon.GetReputationValue(stationId)
    completeInfo.curTotalRep = curTotalRep
    completeInfo.totalRep = totalRep
    local goodsInfo = {}
    for k, v in pairs(DataModel.TempGoodsList) do
      local t = {}
      t.id = v.id
      t.num = v.num
      t.price = DataModel.IdToDetailInfo[v.id].newPrice
      t.totalPrice = t.price * t.num
      goodsInfo[k] = t
    end
    SdkReporter.TrackStationBuy({
      stationId = stationId,
      goodStr = strGoods,
      allPrice = completeInfo.totalPrice,
      quato = completeInfo.bargain
    })
    DataModel.BargainBuff = nil
    DataModel.TempGoodsList = {}
    DataModel.CurUseSpace = DataModel.CurUseSpace + DataModel.TempCurSpace
    DataModel.TempCurSpace = 0
    DataModel.TempCurCost = 0
    completeCb({info = completeInfo, goodsInfo = goodsInfo})
    if PlayerData.TempCache.repLvUpCache ~= nil then
      CommonTips.OpenRepLvUp()
    end
  end, strGoods)
end

function Controller:BuyAllToTemp()
  local function SortGoods(a, b)
    local function GetCategory(good)
      if good.isSpecial then
        return 1
      else
        return 2
      end
    end
    
    local categoryA = GetCategory(a)
    local categoryB = GetCategory(b)
    if categoryA ~= categoryB then
      return categoryA < categoryB
    end
    return a.price > b.price
  end
  
  local function SortGoodsList(goodsList)
    local sortedList = {}
    for i, v in ipairs(goodsList) do
      sortedList[i] = v
    end
    table.sort(sortedList, SortGoods)
    return sortedList
  end
  
  local sortedList = SortGoodsList(DataModel.CurSellList)
  local totalBuyNum = 0
  local showTipOk = false
  
  local function GetCanBuyNum(k, v)
    if v.isBan then
      return 0
    end
    local isRepUnlocked = DataModel.GetStationGoodRepUnLocked(v)
    if not isRepUnlocked then
      return 0
    end
    local isQuestUnlock = DataModel.GetGoodQuestIsUnlock(v)
    if not isQuestUnlock then
      return 0
    end
    if v.num == 0 and k ~= 1 then
      return 0
    end
    local showTip = k == 1
    local num = DataModel.GetCanBuyOrSaleMaxNum(v, showTip)
    if v and v.num ~= 0 and num == 0 and showTip then
      showTipOk = true
    end
    return num
  end
  
  local buyComplete = false
  for k, v in pairs(sortedList) do
    local buyNum = GetCanBuyNum(k, v)
    if 0 < buyNum then
      buyComplete = DataModel.RefreshBuyToTempData(v, buyNum) or buyComplete
      totalBuyNum = totalBuyNum + buyNum
    end
  end
  if not showTipOk and totalBuyNum == 0 then
    CommonTips.OpenTips(80600354)
    return
  end
  if buyComplete then
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurSellList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
    View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
    Controller:RefreshTempBuyBottomShow()
  end
end

function Controller:ClearBuy()
  for k, v in pairs(DataModel.TempGoodsList) do
    DataModel.IdToDetailInfo[v.id].num = DataModel.IdToDetailInfo[v.id].revertRemainNum
  end
  DataModel.TempGoodsList = {}
  View.Group_Trade.Group_Buy.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
  View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
  View.Group_Trade.Group_Buy.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
  DataModel.TempCurCost = 0
  DataModel.TempCurSpace = 0
  Controller:RefreshTempBuyBottomShow()
end

function Controller:RefreshTempSaleBottomShow()
  View.Group_Trade.Group_Sell.Txt_Tax:SetText(string.format("%.1f%%", DataModel.GetTax() * 100))
  View.Group_Trade.Group_Sell.Group_Profit.Txt_Num:SetText(string.format("%.0f", DataModel.TempCurProfit))
  local color = "#FFFFFF"
  if DataModel.TempCurProfit > 0 then
    color = "#A0FFF5"
  elseif DataModel.TempCurProfit < 0 then
    color = "#FF4848"
  end
  View.Group_Trade.Group_Sell.Group_Profit.Txt_Num:SetColor(color)
  local goldIcon, _ = DataModel.GetStationGoldIconAndNum()
  View.Group_Trade.Group_Sell.Group_Profit.Img_Coin:SetSprite(goldIcon)
  local showText = DataModel.TempCurTotalSalePrice
  if DataModel.TempCurProfit > 0 then
    local activityTax = DataModel.GetActivityGoodsTax()
    local newTax = DataModel.TempCurProfit * DataModel.GetTax() + activityTax
    if newTax < 0 then
      newTax = 0
    end
    showText = DataModel.TempCurTotalSalePrice - MainDataModel.NumRound(newTax)
  end
  View.Group_Trade.Group_Sell.Group_Price.Txt_Num:SetText(showText)
  View.Group_Trade.Group_Sell.Group_Price.Img_Coin:SetSprite(goldIcon)
  local oriSpace = MainDataModel.NumCeilPrecision(DataModel.CurUseSpace)
  local curUseSpace = MainDataModel.NumCeilPrecision(DataModel.TempCurSpace)
  if curUseSpace == 0 then
    View.Group_Trade.Group_Sell.Txt_Space:SetText(string.format(GetText(80600529), oriSpace, "", DataModel.MaxSpace))
  else
    View.Group_Trade.Group_Sell.Txt_Space:SetText(string.format(GetText(80600529), oriSpace, "-" .. curUseSpace, DataModel.MaxSpace))
  end
  View.Group_Trade.Group_Sell.Img_PBNow:SetFilledImgAmount(DataModel.CurUseSpace / DataModel.MaxSpace)
  View.Group_Trade.Group_Sell.Img_PBAfter:SetFilledImgAmount((oriSpace - curUseSpace) / DataModel.MaxSpace)
  local tempCount = #DataModel.TempGoodsList
  View.Group_Trade.Group_Sell.Btn_AddAll.self:SetActive(tempCount == 0)
  View.Group_Trade.Group_Sell.Btn_Clear.self:SetActive(tempCount ~= 0)
end

function Controller:SaleToTemp(info, num)
  if not info.isActive then
    CommonTips.OpenTips(80600287)
    return
  end
  local saleComplete, tempNum = DataModel.RefreshSaleToTempData(info, num)
  if saleComplete then
    Controller:UpdateQuestInfoPanel(info.id, -tempNum)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurAcquisitionList)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    Controller:RefreshTempSaleBottomShow()
    if 0 < num then
      if info.percent < 1 then
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.sellDownText, true)
      elseif info.percent > 1 then
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.sellUpText, true)
      else
        MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.sellFlatText, true)
      end
    else
      MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.cancelSellText, true)
    end
  end
end

function Controller:SaleAllToTemp()
  if table.count(DataModel.CurAcquisitionList) == 0 then
    CommonTips.OpenTips(80601810)
    return
  end
  local idx = 1
  while idx <= table.count(DataModel.CurAcquisitionList) do
    local info = DataModel.CurAcquisitionList[idx]
    if info.isLocal then
      idx = idx + 1
    else
      local goodsServerInfo = PlayerData:GetHomeInfo().warehouse[tostring(info.goodsId)]
      if goodsServerInfo and goodsServerInfo.is_locked == 1 then
        idx = idx + 1
      else
        DataModel.RefreshSaleToTempData(info, info.num)
      end
    end
  end
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurAcquisitionList)
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
  Controller:RefreshTempSaleBottomShow()
end

function Controller:ConfirmSale()
  local function completeCb()
    Controller:RefreshTradeLv()
    
    Controller:ReturnToMain()
    MainController:ShowNPCTalk(MainDataModel.NPCDialogEnum.sellSuccessText)
  end
  
  local function priceWaveCb()
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurAcquisitionList)
    View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
    Controller:RefreshCoin()
    Controller:RefreshTempSaleBottomShow()
    CommonTips.OpenTips(80600357)
  end
  
  if #DataModel.TempGoodsList == 0 then
    CommonTips.OpenTips(80600288)
    return
  end
  if Controller:CheckDrinkBuff() then
    CommonTips.OpenTips(80600774)
    return
  end
  if Controller:CheckActiveBuff() then
    CommonTips.OpenTips(80606887)
    return
  end
  local strGoods = ""
  for i = 1, #DataModel.TempGoodsList do
    local info = DataModel.TempGoodsList[i]
    strGoods = strGoods .. info.id .. ":" .. info.num
    if i ~= #DataModel.TempGoodsList then
      strGoods = strGoods .. ","
    end
  end
  Net:SendProto("station.sell", function(json)
    if json.activities then
      PlayerData.ServerData.all_activities = json.activities
    end
    if json.goods_price ~= nil or json.server_sid_tax ~= nil then
      if json.goods_price then
        DataModel.GoodsPriceWave(json.goods_price)
      end
      if json.server_sid_tax then
        DataModel.server_sid_tax = json.server_sid_tax
      end
      priceWaveCb()
      return
    end
    MainController:RefreshWarehouseUnlock()
    local totalSaleSpace = 0
    local serverStock = PlayerData.ServerData.user_home_info.warehouse
    for k, v in pairs(DataModel.TempGoodsList) do
      local goodInfo = DataModel.IdToDetailInfo[v.id]
      local serverInfo = serverStock[tostring(goodInfo.goodsId)]
      if serverInfo ~= nil then
        serverInfo.num = serverInfo.num - v.num
        totalSaleSpace = totalSaleSpace + v.num * goodInfo.space
        if 0 >= serverInfo.num then
          serverStock[tostring(goodInfo.goodsId)].num = 0
        end
      end
    end
    DataModel.CurUseSpace = DataModel.CurUseSpace - totalSaleSpace
    local oldTradeLv = PlayerData:GetHomeInfo().trade_lv
    local tradeExpConfig = PlayerData:GetFactoryData(99900016, "ConfigFactory")
    if 0 < DataModel.TempCurProfit then
      local maxLv = tradeExpConfig.levelMax
      local lv = PlayerData.ServerData.user_home_info.trade_lv
      local curExp = PlayerData.ServerData.user_home_info.exp + DataModel.TempCurProfit
      if maxLv > lv then
        local expLvCA = tradeExpConfig.expList[lv]
        while 0 < expLvCA.needExp and curExp >= expLvCA.needExp do
          curExp = curExp - expLvCA.needExp
          lv = lv + 1
          if maxLv <= lv then
            if lv <= #tradeExpConfig.expList then
              local needExp = tradeExpConfig.expList[lv].needExp
              if curExp > needExp then
                curExp = needExp
              end
            end
            break
          end
          expLvCA = tradeExpConfig.expList[lv]
        end
      elseif lv <= #tradeExpConfig.expList then
        local needExp = tradeExpConfig.expList[lv].needExp
        if curExp > needExp then
          curExp = needExp
        end
      end
      PlayerData:GetHomeInfo().trade_lv = lv
      PlayerData:GetHomeInfo().exp = curExp
    end
    local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
    local completeInfo = {}
    completeInfo.tax = DataModel.GetTax()
    completeInfo.profit = DataModel.TempCurProfit
    if 0 < DataModel.TempCurAvgCost then
      completeInfo.profitPercent = completeInfo.profit / DataModel.TempCurAvgCost
    else
      completeInfo.profitPercent = 1
    end
    completeInfo.tradeExp = 0 < completeInfo.profit and completeInfo.profit or 0
    completeInfo.tradeLv = PlayerData:GetHomeInfo().trade_lv
    completeInfo.taxPrice = 0
    if 0 < completeInfo.profit then
      local tax = completeInfo.profit * completeInfo.tax + DataModel.GetActivityGoodsTax()
      if tax < 0 then
        tax = 0
      end
      completeInfo.taxPrice = MainDataModel.NumRound(tax)
    end
    completeInfo.totalPrice = DataModel.TempCurTotalSalePrice - completeInfo.taxPrice
    local goldRate = DataModel.GetTradeGoldRate()
    local rateTaxPrice = MainDataModel.NumRound(completeInfo.taxPrice / goldRate)
    local rateProfit = MainDataModel.NumRound(completeInfo.profit / goldRate)
    if 0 < completeInfo.profit then
      completeInfo.rep = rateTaxPrice / tradeConfig.taxConvertRep + rateProfit / tradeConfig.profitConvertRep
    else
      completeInfo.rep = rateTaxPrice / tradeConfig.taxConvertRep
    end
    local stationId = DataModel.StationId
    local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    if 0 < stationCA.attachedToCity then
      stationId = stationCA.attachedToCity
    end
    completeInfo.repLv = PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
    completeInfo.bargain = DataModel.CurCityGoodsInfo.r_quota
    local homeCommon = require("Common/HomeCommon")
    local curTotalRep, totalRep = homeCommon.GetReputationValue(stationId)
    completeInfo.curTotalRep = curTotalRep
    completeInfo.totalRep = totalRep
    local curTotalTradeExp, totalTradeExp = homeCommon.GetTradeExpValue()
    completeInfo.curTotalTradeExp = curTotalTradeExp
    completeInfo.totalTradeExp = totalTradeExp
    local goodsInfo = {}
    for k, v in pairs(DataModel.TempGoodsList) do
      local t = {}
      t.id = v.id
      t.num = v.num
      local detailInfo = DataModel.IdToDetailInfo[v.id]
      t.price = detailInfo.newPrice
      t.totalProfit = (t.price - detailInfo.avgPrice) * t.num
      goodsInfo[k] = t
    end
    SdkReporter.TrackStationSell({
      stationId = stationId,
      goodStr = strGoods,
      allPrice = completeInfo.totalPrice,
      quato = completeInfo.bargain,
      profit = completeInfo.profit
    })
    Controller:ShowSettlement({
      info = completeInfo,
      goodsInfo = goodsInfo,
      rank_profit_per = json.rank_profit_per
    }, DataModel.TradeType.Sale)
    
    local function showLvUp()
      CommonTips.OpenRepLvUp()
      CommonTips.OpenTradeLvUp(PlayerData:GetHomeInfo().trade_lv, oldTradeLv)
    end
    
    CommonTips.OpenQuestsCompleteTip()
    CommonTips.OpenQuestPcntUpdateTip()
    showLvUp()
    DataModel.BargainBuff = nil
    DataModel.TempGoodsList = {}
    DataModel.TempCurSpace = 0
    DataModel.TempCurProfit = 0
    DataModel.TempCurAvgCost = 0
    DataModel.TempCurTotalSalePrice = 0
    completeCb()
  end, strGoods)
end

function Controller:ClearSale()
  DataModel.TempGoodsList = {}
  DataModel.RefreshAcquisitionList()
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:SetDataCount(#DataModel.CurAcquisitionList)
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:RefreshAllElement()
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:SetDataCount(#DataModel.TempGoodsList)
  View.Group_Trade.Group_Sell.ScrollGrid_GoodsListR.grid.self:RefreshAllElement()
  DataModel.TempCurSpace = 0
  DataModel.TempCurAvgCost = 0
  DataModel.TempCurProfit = 0
  DataModel.TempCurTotalSalePrice = 0
  Controller:RefreshTempSaleBottomShow()
end

function Controller:ShowSettlement(info, type)
  local showBuy = type == DataModel.TradeType.Buy
  local showSale = type == DataModel.TradeType.Sale
  if showBuy then
    Controller:PlaySound(DataModel.SoundEnum.tradeSettlementBuy)
  end
  if showSale then
    local uiSoundConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
    if info.info.profit < uiSoundConfig.needProfit2 then
      Controller:PlaySound(DataModel.SoundEnum.tradeSettlementSell)
    elseif info.info.profit < uiSoundConfig.needProfit3 then
      Controller:PlaySound(DataModel.SoundEnum.tradeSettlementSell30W)
    else
      Controller:PlaySound(DataModel.SoundEnum.tradeSettlementSell100W)
    end
  end
  local t = {}
  t.info = info.info
  t.type = type
  t.stationId = DataModel.StationId
  t.goodsInfo = info.goodsInfo
  t.npcId = MainDataModel.NpcId
  t.recent_trade_report = DataModel.recent_trade_report
  t.rank_profit_per = info.rank_profit_per or 0
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId)
  if not stationCA.isAddRep and t.info and t.info.rep then
    t.info.rep = 0
  end
  UIManager:Open("UI/HomeTrade/TradeSettlement", Json.encode(t))
end

function Controller:ShowBargainOrRiseTips(type)
  local showBuy = type == DataModel.TradeType.Buy
  local showSale = type == DataModel.TradeType.Sale
  local txt1 = 80600585
  local txt2 = 80600588
  local txt3 = 80600589
  local txt4 = 80600590
  local totalRange = 0
  local onceRange = 0
  local tradeConfig = PlayerData:GetFactoryData(99900062, "ConfigFactory")
  local HomeCommon = require("Common/HomeCommon")
  local successRate = HomeCommon.GetCurLvRepData(DataModel.StationId).bargainSuccessRate or 0
  local tradeExpConfig = PlayerData:GetFactoryData(99900016, "ConfigFactory")
  local tradeLv = PlayerData.ServerData.user_home_info.trade_lv or 1
  local tradeInfo = tradeExpConfig.expList[tradeLv]
  local firstBargain = 0
  if showBuy then
    if DataModel.CurCityGoodsInfo.b_num == 0 then
      firstBargain = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.FirstBargain)
    end
    totalRange = tradeConfig.bargainMax
    successRate = successRate + DataModel.AddBargainSuccessRate + firstBargain + DataModel.AfterBargainFailBuy
    onceRange = tradeInfo.bargainRange + DataModel.AddBargainRange
    local rateInfo = tradeConfig.bargainSuccessRateList[DataModel.BargainSuccessRateIndex]
    successRate = successRate + rateInfo.rate
  end
  if showSale then
    txt1 = 80600591
    txt2 = 80600592
    txt3 = 80600593
    txt4 = 80600594
    if DataModel.CurCityGoodsInfo.r_num == 0 then
      firstBargain = PlayerData:GetHomeSkillIncrease(EnumDefine.HomeSkillEnum.FirstBargain)
    end
    totalRange = tradeConfig.riseMax
    successRate = successRate + DataModel.AddRiseSuccessRate + firstBargain + DataModel.AfterBargainFailSale
    onceRange = tradeInfo.riseRange + DataModel.AddRiseRange
    local rateInfo = tradeConfig.riseSuccessRateList[DataModel.RiseSuccessRateIndex]
    successRate = successRate + rateInfo.rate
  end
  if 0 < DataModel.GetBargainBuffParam(EnumDefine.HomeSkillEnum.AddSuccessRate) then
    successRate = successRate + DataModel.GetBargainBuffParam(EnumDefine.HomeSkillEnum.AddSuccessRate)
  elseif 0 < DataModel.GetBargainBuffParam(EnumDefine.HomeSkillEnum.OneOfUs) then
    successRate = 1
    onceRange = totalRange
  end
  if 1 < successRate then
    successRate = 1
  end
  View.Group_Trade.Group_Tips.Img_Tips.Txt_Tips1:SetText(GetText(txt1))
  View.Group_Trade.Group_Tips.Img_Tips.Txt_Tips2:SetText(string.format(GetText(txt2), successRate * 100 .. "%"))
  View.Group_Trade.Group_Tips.Img_Tips.Txt_Tips3:SetText(string.format(GetText(txt3), totalRange * 100 .. "%"))
  View.Group_Trade.Group_Tips.Img_Tips.Txt_Tips4:SetText(string.format(GetText(txt4), onceRange * 100 .. "%"))
  View.Group_Trade.Group_Tips.self:SetActive(true)
end

function Controller:CheckDrinkBuff()
  if DataModel.DrinkBuff ~= nil and TimeUtil:GetServerTimeStamp() >= DataModel.DrinkBuff.endTime then
    DataModel.CalcDrinkBuffData(true)
    if View.Group_Trade.self.IsActive then
      local buffCA = PlayerData:GetFactoryData(PlayerData.TempCache.drinkBuff.id, "HomeBuffFactory")
      local buffType = buffCA.buffType
      if buffType == EnumDefine.HomeSkillEnum.AddHaggleNum or buffType == EnumDefine.HomeSkillEnum.AddRiseNum then
        Controller:RefreshBargainPanel()
      elseif buffType == EnumDefine.HomeSkillEnum.TaxCuts then
        if DataModel.CurTradeType == DataModel.TradeType.Buy then
          Controller:RefreshTempBuyBottomShow()
        else
          Controller:RefreshTempSaleBottomShow()
        end
      elseif (buffType == EnumDefine.HomeSkillEnum.AddSpecQty or buffType == EnumDefine.HomeSkillEnum.AddQty) and DataModel.CurTradeType == DataModel.TradeType.Buy then
        DataModel.RefreshSellList(true)
        Controller:RefreshTradePanelByType(DataModel.CurTradeType, true, true)
      end
      DataModel.DrinkBuff = nil
      PlayerData:SetDrinkBuff(nil)
      return true
    end
  end
  return false
end

function Controller:CheckActiveBuff()
  local curTime = TimeUtil:GetServerTimeStamp()
  local isRefresh = false
  if DataModel.ActivityGoodsBuyLimitUpTime and DataModel.ActivityGoodsBuyLimitUpTime[1] and curTime >= DataModel.ActivityGoodsBuyLimitUpTime[1] then
    isRefresh = true
    DataModel.ActivityGoodsBuyLimitUpTime = {}
    DataModel.ActivityGoodsBuyLimitUp = PlayerData:GetActivityBuff(EnumDefine.HomeSkillEnum.AddQty, DataModel.StationId, nil, DataModel.ActivityGoodsBuyLimitUpTime)
    if DataModel.ActivityGoodsBuyLimitUp == 0 then
      DataModel.ActivityGoodsBuyLimitUp = {}
    end
  end
  if DataModel.ActivityTaxCutsTime and DataModel.ActivityTaxCutsTime[1] and curTime >= DataModel.ActivityTaxCutsTime[1] then
    isRefresh = true
    DataModel.ActivityTaxCutsTime = {}
    DataModel.ActivityTaxCuts = PlayerData:GetActivityBuff(EnumDefine.HomeSkillEnum.TaxCuts, nil, nil, DataModel.ActivityTaxCutsTime)
    if DataModel.ActivityTaxCuts == 0 then
      DataModel.ActivityTaxCuts = {}
    end
  end
  if isRefresh then
    if DataModel.CurTradeType == DataModel.TradeType.Buy then
      DataModel.RefreshSellList(true)
      Controller:RefreshTradePanelByType(DataModel.CurTradeType, true, true)
      Controller:RefreshTempBuyBottomShow()
    else
      Controller:RefreshTempSaleBottomShow()
    end
    return true
  end
end

function Controller:PlaySound(enum)
  local uiSoundConfig = PlayerData:GetFactoryData(99900002, "ConfigFactory")
  local soundId = uiSoundConfig[enum]
  if type(soundId) == "table" then
    local count = #soundId
    local randomIdx = 1
    if 1 < count then
      randomIdx = math.random(count)
    end
    local sound = SoundManager:CreateSound(soundId[randomIdx].id)
    if sound ~= nil then
      sound:Play()
    end
  elseif type(soundId) == "number" and 0 < soundId then
    local sound = SoundManager:CreateSound(soundId)
    if sound ~= nil then
      sound:Play()
    end
  end
end

function Controller:ShowQuestInfoChild(isShow, goodsId)
  if isShow == nil then
    isShow = true
  end
  local sameGoods = false
  if isShow then
    if goodsId == nil or DataModel.CurShowGoodsId == goodsId then
      sameGoods = true
    end
  else
    sameGoods = true
  end
  if DataModel.IsShowChildQuest == isShow and sameGoods then
    return
  end
  DataModel.IsShowChildQuest = isShow
  if isShow then
    DataModel.CurShowGoodsId = goodsId
    local ca = PlayerData:GetFactoryData(goodsId)
    local t = Clone(DataModel.QuestGoodsId[ca.goodsId])
    t.id = ca.goodsId
    UIManager:Open(DataModel.ChildQuestInfoUrl, Json.encode(t))
    View.self:RegChildPanel(DataModel.ChildQuestInfoUrl)
    local num = 0
    for k, v in pairs(DataModel.TempGoodsList) do
      if goodsId == v.id then
        num = v.num
        break
      end
    end
    if DataModel.CurTradeType == DataModel.TradeType.Sale then
      num = -num
    end
    Controller:UpdateQuestInfoPanel(goodsId, num)
  else
    DataModel.CurShowGoodsId = 0
    UIManager:ClosePanel(false, DataModel.ChildQuestInfoUrl)
    View.self:UnregChildPanel(DataModel.ChildQuestInfoUrl)
  end
end

function Controller:UpdateQuestInfoPanel(id, num)
  if DataModel.IsShowChildQuest and id == DataModel.CurShowGoodsId then
    local SetToChildController = require("UIQuestInfo/OtherSetController")
    SetToChildController:SetDeltaNum(num)
  end
end

function Controller:UseItem()
  local t = {}
  local isBuy = DataModel.CurTradeType == DataModel.TradeType.Buy
  t.type = isBuy and 1 or 2
  local bargainUseCount = isBuy and DataModel.CurCityGoodsInfo.b_num or DataModel.CurCityGoodsInfo.r_num
  t.canBargain = bargainUseCount ~= 0
  t.isUsedBargainItem = DataModel.BargainBuff ~= nil
  t.sellList = {}
  if isBuy and DataModel.CurSellList then
    for k, v in pairs(DataModel.CurSellList) do
      table.insert(t.sellList, v.goodsId)
    end
  end
  PlayerData.TempCache.PromptCallbackStr = ""
  UIManager:Open("UI/HomeTrade/UseItem", Json.encode(t), function()
    local info = Json.decode(PlayerData.TempCache.PromptCallbackStr)
    if info.useItemType == "RefreshGoods" then
      for k, v in pairs(DataModel.CurCityGoodsInfo.sell_price) do
        local sellInfo = info.json.sell[k]
        if sellInfo then
          v.num = sellInfo.num or 0
          v.extra = sellInfo.extra or 0
          v.sold = sellInfo.sold or 0
        end
      end
      DataModel.RefreshSellList(true)
      Controller:RefreshTradePanelByType(DataModel.TradeType.Buy, true, true)
    elseif info.useItemType == "RefreshBargain" then
      DataModel.CurCityGoodsInfo.b_num = 0
      DataModel.CurCityGoodsInfo.b_quota = 0
      DataModel.CurCityGoodsInfo.r_num = 0
      DataModel.CurCityGoodsInfo.r_quota = 0
      DataModel.BargainSuccessRateIndex = 1
      DataModel.RiseSuccessRateIndex = 1
      Controller:RefreshBargainPanel()
      DataModel.RefreshPriceInfo(0)
      Controller:RefreshTradePanelByType(DataModel.CurTradeType, true, true)
    elseif info.useItemType == "BargainItem" then
      local buffId = info.buffId
      local ca = PlayerData:GetFactoryData(buffId, "HomeBuffFactory")
      DataModel.BargainBuff = {}
      DataModel.BargainBuff.id = buffId
      DataModel.BargainBuff.type = ca.buffType
      DataModel.BargainBuff.param = ca.param
      local toInfo = {}
      toInfo.name = ca.name
      toInfo.desc = ca.desc
      if info.isOneOfUs then
        toInfo.stationId = DataModel.StationId
      end
      UIManager:Open("UI/HomeTrade/BargainBuff", Json.encode(toInfo))
      Controller:ShowBargainBuffTip(true)
      local param = DataModel.GetBargainBuffParam(EnumDefine.HomeSkillEnum.AddBargainNum)
      if 0 < param then
        Controller:RefreshBargainPanel()
      end
    end
  end)
end

function Controller:ShowBargainBuffTip(isShow)
  if not isShow and DataModel.BargainBuff ~= nil then
    isShow = true
  end
  if View.Group_Trade ~= nil and View.Group_Trade.Group_NpcInfoL ~= nil then
    View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_Bargain:SetActive(isShow)
  end
end

function Controller:OutTradePreCheck(cb)
  if MainDataModel.IsTradeOpen then
    local isQuota = DataModel.CurCityGoodsInfo.b_quota ~= 0 or DataModel.CurCityGoodsInfo.r_quota ~= 0
    local textId
    if DataModel.BargainBuff ~= nil then
      if isQuota then
        textId = 80602318
      else
        textId = 80602317
      end
    elseif isQuota then
      textId = 80600682
    end
    if textId then
      CommonTips.OnPrompt(textId, nil, nil, function()
        cb()
      end, nil, nil, nil, nil, {showDanger = true})
      return true
    end
  end
  return false
end

function Controller:ReturnToMain(isShowPrompt)
  local function cb()
    if MainDataModel.decodeParams.autoOpenTrade then
      UIManager:GoBack()
      
      return
    end
    View.Group_Trade.self:SetActive(false)
    View.Group_Main.self:SetActive(true)
    DataModel.CurTradeType = 0
    DataModel.BargainBuff = nil
    MainDataModel.IsTradeOpen = false
    View.Group_Trade.Group_Tips.self:SetActive(false)
    Controller:ShowQuestInfoChild(false)
    View.self:PlayAnim("Main")
  end
  
  if isShowPrompt and Controller:OutTradePreCheck(cb) then
    return
  end
  cb()
end

function Controller:GoHome()
  if not Controller:OutTradePreCheck(function()
    UIManager:GoHome()
  end) then
    UIManager:GoHome()
  end
end

return Controller
