local View = require("UIHomeTrade/UIHomeTradeView")
local DataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local Controller = require("UIHomeTrade/UIHomeTradeController")
local TradeDataModel = require("UIHomeTrade/UITradeDataModel")
local TradeController = require("UIHomeTrade/UITradeController")
local WarehouseDataModel = require("UIHomeTrade/UIWarehouseDataModel")
local WarehouseController = require("UIHomeTrade/UIWarehouseController")
local UICityMapController = require("UICityMap/UICityMapController")
local ViewFunction = {
  HomeTrade_Group_Main_Btn_Buy_Click = function(btn, str)
    TradeController:ShowTradeView(TradeDataModel.TradeType.Buy)
  end,
  HomeTrade_Group_Main_Btn_Sell_Click = function(btn, str)
    TradeController:ShowTradeView(TradeDataModel.TradeType.Sale)
  end,
  HomeTrade_Group_Main_Btn_Talk_Click = function(btn, str)
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.talkText)
  end,
  HomeTrade_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_Trade.self.IsActive then
      TradeController:ReturnToMain(true)
    elseif View.Group_Warehouse.self.IsActive then
      WarehouseController:ReturnToMain()
    else
      UIManager:GoBack()
    end
  end,
  HomeTrade_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    if View.Group_Trade.self.IsActive then
      TradeController:GoHome()
    elseif View.Group_Warehouse.self.IsActive then
      WarehouseController:GoHome()
    else
      UIManager:GoHome()
    end
  end,
  HomeTrade_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    UIManager:Open("UI/HomeTrade/TradeHelp")
  end,
  HomeTrade_Group_Trade_Group_Tab_Btn_Buy_Click = function(btn, str)
    TradeController:RefreshTradePanelByType(TradeDataModel.TradeType.Buy)
  end,
  HomeTrade_Group_Trade_Group_Tab_Btn_Sell_Click = function(btn, str)
    TradeController:RefreshTradePanelByType(TradeDataModel.TradeType.Sale)
  end,
  HomeTrade_Group_Trade_Group_Resources_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Batch_Click = function(btn, str)
    TradeController:RefreshBuyTradeMode(1)
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Max_Click = function(btn, str)
    TradeController:RefreshBuyTradeMode(2)
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListL_SetGrid = function(element, elementIndex)
    local info = TradeDataModel.CurSellList[elementIndex]
    Controller:RefreshItem(info, element.Group_Item)
    element.Txt_Name:SetText(info.name)
    local goodsInfo = TradeDataModel.QuestGoodsId[info.goodsId]
    element.Img_Quest:SetActive(goodsInfo ~= nil and goodsInfo.curNum < goodsInfo.needNum)
    local price = info.newPrice
    element.Group_Price.Txt_Price:SetText(price)
    local goldIcon, _ = TradeDataModel.GetStationGoldIconAndNum()
    element.Group_Price.Img_Coin:SetSprite(goldIcon or "")
    element.Img_Flat:SetActive(info.percent == 1)
    element.Img_Up:SetActive(info.percent > 1)
    element.Img_Down:SetActive(info.percent < 1)
    element.Img_TrendFlat:SetActive(info.trend == 0)
    element.Img_TrendUp:SetActive(info.trend == 1)
    element.Img_TrendDown:SetActive(info.trend == -1)
    element.Txt_Quotation:SetText(string.format("%.0f%%", info.percent * 100))
    element.Img_Specialty:SetActive(info.isSpecial)
    element.Img_Ban.self:SetActive(info.isBan)
    if info.isBan then
      element.Img_Ban.Txt_BuildName:SetText(DataModel.CityHallName)
      element.Img_Ban.Group_Num.Txt_Num:SetText(info.needItemNum)
    end
    element.Img_Null:SetActive(info.num == 0)
    element.Img_Null.Btn_Add.self:SetClickParam(elementIndex)
    element.Btn_Goods:SetClickParam(elementIndex)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    if info.isBan then
      local isHasInvestPoint, bubbleId = TradeDataModel.GetIsCityHasInvestPoint()
      element.Img_Ban.Btn_CityHall:SetActive(isHasInvestPoint)
      if isHasInvestPoint then
        element.Img_Ban.Btn_CityHall:SetClickFunction(function()
          UICityMapController:ClickBtn(nil, {bubbleId = bubbleId})
        end)
      else
        element.Img_Ban.Btn_CityHall:SetClickFunction(function()
        end)
      end
    end
    local repUnlock = TradeDataModel.GetStationGoodRepUnLocked(info)
    if info.isBan or repUnlock then
      element.Img_BanRep:SetActive(false)
    else
      element.Img_BanRep:SetActive(true)
      local needRep = info.needRepNum or 0
      element.Img_BanRep.Txt_rep:SetText(string.format(GetText(80612182), needRep))
    end
    local isQuestUnlock = TradeDataModel.GetGoodQuestIsUnlock(info)
    element.Img_BanInv:SetActive(not isQuestUnlock)
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListL_Group_Item_Btn_Goods_Click = function(btn, str)
    local idx = tonumber(str)
    local info = TradeDataModel.CurSellList[idx]
    local goodsInfo = TradeDataModel.QuestGoodsId[info.goodsId]
    TradeController:ShowQuestInfoChild(goodsInfo ~= nil and goodsInfo.curNum < goodsInfo.needNum, info.id)
    if info.isBan then
      return
    end
    local isRepUnlocked = TradeDataModel.GetStationGoodRepUnLocked(info)
    if not isRepUnlocked then
      return
    end
    local isQuestUnlock = TradeDataModel.GetGoodQuestIsUnlock(info)
    if not isQuestUnlock then
      return
    end
    if info.num == 0 then
      CommonTips.OpenTips(80600354)
      return
    end
    local num = TradeDataModel.GetCanBuyOrSaleMaxNum(info, true)
    if num <= 0 then
      return
    end
    if TradeDataModel.BuyBatchMode == 1 then
      Controller:OpenBatchPanel(info, idx, 1)
    elseif TradeDataModel.BuyBatchMode == 2 then
      TradeController:BuyToTemp(info, num)
    end
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListL_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local info = TradeDataModel.CurSellList[tonumber(str)]
    CommonTips.OpenGoodsTips(info.goodsId, 1)
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListL_Group_Item_Img_Null_Btn_Add_Click = function(btn, str)
    local idx = tonumber(str)
    local info = TradeDataModel.CurSellList[idx]
    if info.num == 0 then
      TradeController:RefreshBuyLimit()
    end
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListR_SetGrid = function(element, elementIndex)
    local info = TradeDataModel.TempGoodsList[elementIndex]
    if info == nil then
      return
    end
    local goods = TradeDataModel.IdToDetailInfo[info.id]
    Controller:RefreshItem(info, element.Group_Item)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Img_Specialty:SetActive(goods.isSpecial)
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListR_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    local info = TradeDataModel.TempGoodsList[idx]
    if info == nil then
      return
    end
    local goods = TradeDataModel.IdToDetailInfo[info.id]
    local goodsInfo = TradeDataModel.QuestGoodsId[goods.goodsId]
    TradeController:ShowQuestInfoChild(goodsInfo ~= nil and goodsInfo.curNum < goodsInfo.needNum, info.id)
    TradeController:BuyToTemp(goods, -info.num)
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_AddAll_Click = function(btn, str)
    TradeController:BuyAllToTemp()
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Clear_Click = function(btn, str)
    TradeController:ClearBuy()
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Tips_Click = function(btn, str)
    TradeController:ShowBargainOrRiseTips(TradeDataModel.TradeType.Buy)
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Bargain_Click = function(btn, str)
    TradeController:ConfirmBargain()
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Renegotiate_Click = function(btn, str)
    TradeController:ConfirmBargain()
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Confirm_Click = function(btn, str)
    TradeController:ConfirmBuy()
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Batch_Click = function(btn, str)
    TradeController:RefreshSaleTradeMode(1)
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Max_Click = function(btn, str)
    TradeController:RefreshSaleTradeMode(2)
  end,
  HomeTrade_Group_Trade_Group_Sell_ScrollGrid_GoodsListL_SetGrid = function(element, elementIndex)
    local info = TradeDataModel.CurAcquisitionList[elementIndex]
    Controller:RefreshItem(info, element.Group_Item, true)
    element.Txt_Name:SetText(info.name)
    element.Group_Item.Img_Local:SetActive(info.isLocal == true)
    element.Img_Quest:SetActive(TradeDataModel.QuestGoodsId[info.goodsId] ~= nil)
    local price = info.newPrice
    element.Group_Price.Txt_Price:SetText(price)
    local goldIcon, _ = TradeDataModel.GetStationGoldIconAndNum()
    element.Group_Price.Img_Coin:SetSprite(goldIcon or "")
    element.Img_Flat:SetActive(info.percent == 1)
    element.Img_Up:SetActive(info.percent > 1)
    element.Img_Down:SetActive(info.percent < 1)
    element.Img_TrendFlat:SetActive(info.trend == 0)
    element.Img_TrendUp:SetActive(info.trend == 1)
    element.Img_TrendDown:SetActive(info.trend == -1)
    element.Txt_Quotation:SetText(string.format("%.0f%%", info.percent * 100))
    local priceChangeType = 0
    local comparePrice = info.price * 0.01
    if price < info.avgPrice - comparePrice then
      priceChangeType = 2
    elseif price > info.avgPrice + comparePrice then
      priceChangeType = 1
    end
    if priceChangeType == 2 then
      element.Group_Price.Txt_Price:SetColor("#FF4848")
    elseif priceChangeType == 1 then
      element.Group_Price.Txt_Price:SetColor("#A0FFF5")
    else
      element.Group_Price.Txt_Price:SetColor("#FFFFFF")
    end
    element.Img_Ban:SetActive(not info.isActive)
    element.Img_Specialty:SetActive(info.isSpecial)
    element.Btn_Goods:SetClickParam(elementIndex)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Group_UnitPrice:SetActive(true)
    element.Group_UnitPrice.Txt_Num:SetText(math.floor(info.avgPrice))
  end,
  HomeTrade_Group_Trade_Group_Sell_ScrollGrid_GoodsListL_Group_Item_Btn_Goods_Click = function(btn, str)
    local idx = tonumber(str)
    local info = TradeDataModel.CurAcquisitionList[idx]
    local goodsInfo = TradeDataModel.QuestGoodsId[info.goodsId]
    TradeController:ShowQuestInfoChild(goodsInfo ~= nil, info.id)
    local goodsServerInfo = PlayerData:GetHomeInfo().warehouse[tostring(info.goodsId)]
    if goodsServerInfo and goodsServerInfo.is_locked == 1 then
      CommonTips.OpenTips(80609062)
      return
    end
    if TradeDataModel.SaleBatchMode == 1 then
      Controller:OpenBatchPanel(info, idx, 1)
    elseif TradeDataModel.SaleBatchMode == 2 then
      TradeController:SaleToTemp(info, info.num)
    end
  end,
  HomeTrade_Group_Trade_Group_Sell_ScrollGrid_GoodsListL_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    local info = TradeDataModel.CurAcquisitionList[idx]
    CommonTips.OpenGoodsTips(info.goodsId, 2, true, function()
      local element = View.Group_Trade.Group_Sell.ScrollGrid_GoodsListL.grid.self:GetElementByIndex(idx - 1)
      if element then
        Controller:RefreshItem(info, element.Group_Item, true)
      end
    end)
  end,
  HomeTrade_Group_Trade_Group_Sell_ScrollGrid_GoodsListR_SetGrid = function(element, elementIndex)
    local info = TradeDataModel.TempGoodsList[elementIndex]
    if info == nil then
      return
    end
    local goods = TradeDataModel.IdToDetailInfo[info.id]
    Controller:RefreshItem(info, element.Group_Item)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
    element.Img_Specialty:SetActive(goods.isSpecial)
    element.Group_Item.Img_Local:SetActive(goods.isLocal == true)
  end,
  HomeTrade_Group_Trade_Group_Sell_ScrollGrid_GoodsListR_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    local info = TradeDataModel.TempGoodsList[idx]
    if info == nil then
      return
    end
    local goods = TradeDataModel.IdToDetailInfo[info.id]
    local goodsInfo = TradeDataModel.QuestGoodsId[goods.goodsId]
    TradeController:ShowQuestInfoChild(goodsInfo ~= nil, info.id)
    TradeController:SaleToTemp(goods, -info.num)
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_AddAll_Click = function(btn, str)
    TradeController:SaleAllToTemp()
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Clear_Click = function(btn, str)
    TradeController:ClearSale()
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Tips_Click = function(btn, str)
    TradeController:ShowBargainOrRiseTips(TradeDataModel.TradeType.Sale)
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Bargain_Click = function(btn, str)
    TradeController:ConfirmBargain()
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Renegotiate_Click = function(btn, str)
    TradeController:ConfirmBargain()
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_Confirm_Click = function(btn, str)
    local hadLocal = false
    for k, v in pairs(TradeDataModel.TempGoodsList) do
      if TradeDataModel.IdToDetailInfo[v.id].isLocal then
        hadLocal = true
        break
      end
    end
    if hadLocal then
      local checkTipParam = {}
      checkTipParam.isCheckTip = true
      checkTipParam.checkTipKey = "TradeSaleLocalGoods"
      checkTipParam.checkTipType = 1
      checkTipParam.showDanger = true
      CommonTips.OnPrompt(GetText(80601896), nil, nil, function()
        TradeController:ConfirmSale()
      end, nil, nil, nil, nil, checkTipParam)
    else
      TradeController:ConfirmSale()
    end
  end,
  HomeTrade_Group_Trade_Group_Resources_Group_TradeLv_Btn_Tips_Click = function(btn, str)
    UIManager:Open("UI/TradeLevelTip/TradeLevelTip")
  end,
  HomeTrade_Group_Trade_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Trade.Group_Tips.self:SetActive(false)
  end,
  HomeTrade_Group_Main_Btn_Warehouse_Click = function(btn, str)
    WarehouseController:Init()
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Train_Btn_Batch_Click = function(btn, str)
    WarehouseController:RefreshCurGoodsBatchMode(1)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Train_Btn_Max_Click = function(btn, str)
    WarehouseController:RefreshCurGoodsBatchMode(2)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Train_ScrollGrid_GoodsList_SetGrid = function(element, elementIndex)
    local data = WarehouseDataModel.CurGoods[elementIndex]
    WarehouseController:RefreshElement(element, data, elementIndex)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Train_ScrollGrid_GoodsList_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    WarehouseController:ClickCurGoods(tonumber(str))
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Warehouse_Btn_Batch_Click = function(btn, str)
    WarehouseController:RefreshStationGoodsBatchMode(1)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Warehouse_Btn_Max_Click = function(btn, str)
    WarehouseController:RefreshStationGoodsBatchMode(2)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Warehouse_ScrollGrid_GoodsList_SetGrid = function(element, elementIndex)
    local data = WarehouseDataModel.StationGoods[elementIndex]
    WarehouseController:RefreshElement(element, data, elementIndex)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Warehouse_ScrollGrid_GoodsList_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    WarehouseController:ClickStationGoods(tonumber(str))
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Warehouse_Btn_Add_Click = function(btn, str)
    WarehouseController:ClickExpandSpace()
  end,
  HomeTrade_Group_Warehouse_Group_Tips_Btn_Close_Click = function(btn, str)
    View.Group_Warehouse.Group_Tips.self:SetActive(false)
  end,
  HomeTrade_Group_Warehouse_Group_Reputation_Btn_Reputation_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.ClickReputationBtn(DataModel.StationId, nil, nil, function()
      homeCommon.SetReputationElement(View.Group_Warehouse.Group_Reputation, DataModel.StationId)
    end)
  end,
  HomeTrade_Group_Warehouse_Group_Resources_Group_GoldCoin_Btn_GoldCoin_Click = function(btn, str)
  end,
  HomeTrade_Group_Warehouse_Group_Resources_Group_TradeLv_Btn_Tips_Click = function(btn, str)
    View.Group_Warehouse.Group_Tips.self:SetActive(true)
  end,
  HomeTrade_Group_Batch_Btn_BG_Click = function(btn, str)
    View.Group_Batch.self:SetActive(false)
  end,
  HomeTrade_Group_Batch_Group_Panel_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  HomeTrade_Group_Batch_Group_Panel_Btn_Min_Click = function(btn, str)
    DataModel.BatchNum = 1
    View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.self:SetSliderValue(DataModel.BatchNum)
    Controller:RefreshBatchMoney(DataModel.BatchNum)
  end,
  HomeTrade_Group_Batch_Group_Panel_Btn_Dec_Click = function(btn, str)
    if DataModel.BatchNum - 1 < View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.slider.minValue then
      return
    end
    DataModel.BatchNum = DataModel.BatchNum - 1
    View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.self:SetSliderValue(DataModel.BatchNum)
    Controller:RefreshBatchMoney(DataModel.BatchNum)
  end,
  HomeTrade_Group_Batch_Group_Panel_Group_Slider_Slider_Value_Slider = function(slider, value)
    DataModel.BatchNum = DataModel.NumRound(value)
    Controller:RefreshBatchMoney(DataModel.BatchNum)
  end,
  HomeTrade_Group_Batch_Group_Panel_Group_Slider_Slider_Value_SliderDown = function(slider)
  end,
  HomeTrade_Group_Batch_Group_Panel_Group_Slider_Slider_Value_SliderUp = function(slider)
  end,
  HomeTrade_Group_Batch_Group_Panel_Btn_Add_Click = function(btn, str)
    if DataModel.BatchNum + 1 > View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.slider.maxValue then
      return
    end
    DataModel.BatchNum = DataModel.BatchNum + 1
    View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.self:SetSliderValue(DataModel.BatchNum)
    Controller:RefreshBatchMoney(DataModel.BatchNum)
  end,
  HomeTrade_Group_Batch_Group_Panel_Btn_Max_Click = function(btn, str)
    DataModel.BatchNum = math.floor(View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.slider.maxValue + 0.5)
    View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.self:SetSliderValue(DataModel.BatchNum)
    Controller:RefreshBatchMoney(DataModel.BatchNum)
  end,
  HomeTrade_Group_Batch_Btn_Cancel_Click = function(btn, str)
    View.Group_Batch.self:SetActive(false)
  end,
  HomeTrade_Group_Batch_Btn_Confirm_Click = function(btn, str)
    Controller:ConfirmBatchClick()
  end,
  HomeTrade_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  HomeTrade_Group_Warehouse_Group_Saveget_Group_Warehouse_Btn_NotAdd_Click = function(btn, str)
    CommonTips.OpenTips(80601104)
  end,
  HomeTrade_Group_Trade_Group_Sell_ScrollGrid_GoodsListL_Group_Item_Img_Null_Btn_Add_Click = function(btn, str)
  end,
  HomeTrade_Group_Main_Btn_Rank_Click = function(btn, str)
    local t = {}
    t.stationId = DataModel.StationId
    UIManager:Open("UI/RankList/RankList", Json.encode(t))
  end,
  HomeTrade_Group_Trade_Group_Resources_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeTrade_Group_Trade_Group_Resources_Group_Energy_Btn_Add_Click = function(btn, str)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.OpenMoveEnergyUseItem(function()
      TradeController:RefreshActionValue()
    end)
  end,
  HomeTrade_Group_Trade_Group_Resources_Group_Energy_Btn_Icon_Click = function(btn, str)
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_Refresh_Click = function(btn, str)
    TradeController:RefreshBuyLimit()
  end,
  HomeTrade_Group_Trade_Group_Resources_Group_LifeSkillBtn_Btn_LifeSkill_Click = function(btn, str)
    UIManager:Open("UI/LifeSkill/LifeSkill")
  end,
  HomeTrade_Group_Warehouse_Group_Resources_Group_GoldCoin_Btn_Add_Click = function(btn, str)
  end,
  HomeTrade_Group_Trade_Btn_CloseQuestInfo_Click = function(btn, str)
    TradeController:ShowQuestInfoChild(false)
  end,
  HomeTrade_Group_Trade_Group_NpcInfoL_Group_Buff_Btn_Drink_Click = function(btn, str)
    if TradeDataModel.DrinkBuff then
      if TimeUtil:GetServerTimeStamp() < TradeDataModel.DrinkBuff.endTime then
        local t = {}
        t.posX = -479
        t.posY = -409
        t.drinkBuff = TradeDataModel.DrinkBuff
        UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
      else
        View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_Drink:SetActive(false)
      end
    end
  end,
  HomeTrade_Group_Trade_Group_Buy_Btn_UseItem_Click = function(btn, str)
    TradeController:UseItem()
  end,
  HomeTrade_Group_Trade_Group_Sell_Btn_UseItem_Click = function(btn, str)
    TradeController:UseItem()
  end,
  HomeTrade_Group_CommonTopLeft_Btn__Click = function(btn, str)
    CommonTips.OpenNoteBook(1)
  end,
  HomeTrade_Group_Trade_Group_NpcInfoL_Group_Buff_Btn_Bargain_Click = function(btn, str)
    if TradeDataModel.BargainBuff then
      local t = {}
      t.posX = -479
      t.posY = -409
      t.bargainBuff = TradeDataModel.BargainBuff
      UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
    end
  end,
  HomeTrade_Group_Main_Btn_Manufacture_Click = function(btn, str)
    Controller:ClickManufacture()
  end,
  HomeTrade_Group_Warehouse_Group_Add_Btn__Click = function(btn, str)
  end,
  HomeTrade_Group_Main_Btn_PddOrder_Click = function(btn, str)
    if CommonTips.GuideAsset() then
      return
    end
    UIManager:Open("UI/StageQuest/StageQuest", Json.encode({titleIndex = 4}))
  end,
  HomeTrade_Group_Main_Btn_invest_Click = function(btn, str)
    UIManager:Open("UI/HomeTrade/HomeTradeUpgrade")
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListL_Group_Item_Btn_Upgrade_Click = function(btn, str)
  end,
  HomeTrade_Group_Trade_Group_Buy_ScrollGrid_GoodsListL_Group_Item_Img_Ban_Btn_CityHall_Click = function(btn, str)
  end,
  HomeTrade_Group_Trade_Group_NpcInfoL_Group_Buff_Btn_DrinkWL_Click = function(btn, str)
    if TradeDataModel.DrinkBuff then
      if TimeUtil:GetServerTimeStamp() < TradeDataModel.DrinkBuff.endTime then
        local t = {}
        t.posX = -479
        t.posY = -409
        t.drinkBuff = TradeDataModel.DrinkBuff
        UIManager:Open("UI/Common/HomeBuff", Json.encode(t))
      else
        View.Group_Trade.Group_NpcInfoL.Group_Buff.Btn_DrinkWL:SetActive(false)
      end
    end
  end
}
return ViewFunction
