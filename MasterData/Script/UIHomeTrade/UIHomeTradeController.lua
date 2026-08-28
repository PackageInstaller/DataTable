local View = require("UIHomeTrade/UIHomeTradeView")
local DataModel = require("UIHomeTrade/UIHomeTradeDataModel")
local TradeDataModel = require("UIHomeTrade/UITradeDataModel")
local WarehouseDataModel = require("UIHomeTrade/UIWarehouseDataModel")
local Controller = {}

function Controller:ShowInitView()
  View.Group_Main.self:SetActive(true)
  View.Group_Trade.self:SetActive(false)
  View.Group_Warehouse.self:SetActive(false)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  local TradeController = require("UIHomeTrade/UITradeController")
  TradeController:RefreshBuyTradeMode(2)
  TradeController:RefreshSaleTradeMode(2)
  DataModel.Init()
  DataModel.RefreshSpecialGoodsInfo()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationCA.name)
  Controller:SetNPC()
  Controller:RefreshWarehouseUnlock()
  Controller:RefreshManufactureRedPoint()
  Controller:RefreshPddRedPoint()
  Controller:CheckQuestProcess()
  Controller:RefreshTradeUpdateUnlock()
end

function Controller:CheckQuestProcess()
  local params = {}
  params.url = View.self.url
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  status.extraUIParamData = Clone(DataModel.decodeParams)
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #DataModel.CacheEventList
  View.Group_Main.Btn_Talk.Img_RedPoint:SetActive(0 < count)
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    if count == 1 then
      local questCA = PlayerData:GetFactoryData(DataModel.CacheEventList[1].questId)
      View.Group_Main.Btn_Talk.Txt_Name:SetText(questCA.name)
    else
      View.Group_Main.Btn_Talk.Txt_Name:SetText(GetText(80602502))
    end
  else
    View.Group_Main.Btn_Talk.Txt_Name:SetText(GetText(80602502))
  end
end

function Controller:BackInit()
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  Controller:SetNPC()
  Controller:RefreshWarehouseUnlock()
  Controller:RefreshManufactureRedPoint()
  Controller:RefreshPddRedPoint()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Main.Group_NpcInfo.Group_Station.Txt_Station:SetText(stationCA.name)
  Controller:CheckQuestProcess()
  Controller:RefreshTradeUpdateUnlock()
end

function Controller:RefreshManufactureRedPoint()
  local machiningData = require("UIHome_MachiningMenu/UIHome_MachiningMenuDataModel")
  machiningData.InitData()
  View.Group_Main.Btn_Manufacture.Img_RedPoint:SetActive(machiningData.GetRedPointState())
end

function Controller:RefreshPddRedPoint()
  local red = require("UIStageQuest/UIStageQuestDataModel"):GetRedPoint(nil, 4)
  View.Group_Main.Btn_PddOrder.Img_RedPoint:SetActive(red)
end

function Controller:RefreshWarehouseUnlock()
  local stationId = DataModel.StationId
  local stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
  if stationCA.isWarehouse then
    if stationCA.attachedToCity > 0 then
      stationId = stationCA.attachedToCity
      stationCA = PlayerData:GetFactoryData(stationId, "HomeStationFactory")
    end
    local curRepLv = PlayerData:GetHomeInfo().stations[tostring(stationId)].rep_lv
    View.Group_Main.Btn_Warehouse.Img_Rep.self:SetActive(curRepLv < stationCA.warehousePrestige)
    View.Group_Main.Btn_Warehouse.Img_Rep.Txt_Rep:SetText(string.format(GetText(80601100), stationCA.warehousePrestige))
    View.Group_Main.Btn_Warehouse.Btn.interactable = curRepLv >= stationCA.warehousePrestige
  else
    View.Group_Main.Btn_Warehouse.Img_Rep.self:SetActive(true)
    View.Group_Main.Btn_Warehouse.Img_Rep.Txt_Rep:SetText(GetText(80610102))
    View.Group_Main.Btn_Warehouse.Btn.interactable = false
  end
end

function Controller:OpenBatchPanel(info, idx, type)
  UIManager:LoadSplitPrefab(View, "UI/HomeTrade/HomeTrade", "Group_Batch")
  View.Group_Batch.self:SetActive(true)
  DataModel.BatchInfo = info
  DataModel.BatchIdx = idx
  DataModel.BatchType = type
  Controller:RefreshItem(info, View.Group_Batch.Group_Panel.Group_Item)
  View.Group_Batch.Group_Panel.Txt_Name:SetText(info.name or info.info.name)
  View.Group_Batch.Group_Panel.ScrollView_Describe.Viewport.Txt_Describe:SetText(info.des or info.info.des)
  if type == 1 then
    View.Group_Batch.Group_Panel.Img_Flat:SetActive(info.percent == 1)
    View.Group_Batch.Group_Panel.Img_Up:SetActive(1 < info.percent)
    View.Group_Batch.Group_Panel.Img_Down:SetActive(1 > info.percent)
    View.Group_Batch.Group_Panel.Img_TrendFlat:SetActive(info.trend == 0)
    View.Group_Batch.Group_Panel.Img_TrendUp:SetActive(info.trend == 1)
    View.Group_Batch.Group_Panel.Img_TrendDown:SetActive(info.trend == -1)
    View.Group_Batch.Group_Panel.Txt_Quotation:SetActive(true)
    View.Group_Batch.Group_Panel.Group_Gold.self:SetActive(true)
    View.Group_Batch.Group_Panel.Group_Price.self:SetActive(true)
    View.Group_Batch.Group_Panel.Group_Average.self:SetActive(false)
    View.Group_Batch.Group_Panel.Txt_Quotation:SetText(string.format("%.0f%%", info.percent * 100))
    View.Group_Batch.Group_Panel.self:SetAnchoredPositionY(-160)
    View.Group_Batch.Btn_Confirm.Group_.Txt_T:SetText(GetText(80601089))
  else
    View.Group_Batch.Group_Panel.Img_Flat:SetActive(false)
    View.Group_Batch.Group_Panel.Img_Up:SetActive(false)
    View.Group_Batch.Group_Panel.Img_Down:SetActive(false)
    View.Group_Batch.Group_Panel.Img_TrendFlat:SetActive(false)
    View.Group_Batch.Group_Panel.Img_TrendUp:SetActive(false)
    View.Group_Batch.Group_Panel.Img_TrendDown:SetActive(false)
    View.Group_Batch.Group_Panel.Txt_Quotation:SetActive(false)
    View.Group_Batch.Group_Panel.Group_Gold.self:SetActive(false)
    View.Group_Batch.Group_Panel.Group_Price.self:SetActive(false)
    View.Group_Batch.Group_Panel.Group_Average.self:SetActive(true)
    View.Group_Batch.Group_Panel.Group_Average.Txt_Num:SetText(math.floor(info.info.price + 0.5))
    View.Group_Batch.Group_Panel.self:SetAnchoredPositionY(-200)
    if type == 2 then
      View.Group_Batch.Btn_Confirm.Group_.Txt_T:SetText(GetText(80601090))
    else
      View.Group_Batch.Btn_Confirm.Group_.Txt_T:SetText(GetText(80601091))
    end
  end
  local maxNum, minNum
  if type == 1 then
    maxNum = TradeDataModel.GetCanBuyOrSaleMaxNum(info)
    minNum = maxNum <= 0 and 0 or 1
  else
    maxNum = info.num
    minNum = maxNum <= 0 and 0 or 1
  end
  View.Group_Batch.Group_Panel.Group_Slider.Group_Num.Txt_Select:SetText(minNum)
  View.Group_Batch.Group_Panel.Group_Slider.Group_Num.Txt_Possess:SetText(maxNum)
  View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.self:SetMinAndMaxValue(minNum, maxNum, true)
  View.Group_Batch.Group_Panel.Group_Slider.Slider_Value.self:SetSliderValue(minNum)
  Controller:RefreshBatchMoney(minNum)
  DataModel.BatchNum = minNum
end

function Controller:RefreshBatchMoney(num)
  View.Group_Batch.Group_Panel.Group_Slider.Group_Num.Txt_Select:SetText(num)
  if DataModel.BatchType == 1 then
    local curBuyPrice = num * DataModel.BatchInfo.newPrice
    local goldIcon, goldNum = TradeDataModel.GetStationGoldIconAndNum()
    View.Group_Batch.Group_Panel.Group_Gold.Img_Coin:SetSprite(goldIcon)
    View.Group_Batch.Group_Panel.Group_Gold.Txt_Num:SetText(curBuyPrice)
    local isBuy = TradeDataModel.CurTradeType == TradeDataModel.TradeType.Buy
    local typeTxtId = isBuy and 80600759 or 80600760
    View.Group_Batch.Group_Panel.Group_Price.Txt_Type:SetText(GetText(typeTxtId))
    local showTotal = 0
    if isBuy then
      local activityTax = (TradeDataModel.ActivityTaxCuts[DataModel.BatchInfo.goodsId] or 0) * curBuyPrice
      showTotal = DataModel.NumRound((TradeDataModel.TempCurCost + curBuyPrice) * (1 + TradeDataModel.GetTax()) + activityTax + TradeDataModel.GetActivityGoodsTax())
    else
      local totalSale = TradeDataModel.TempCurTotalSalePrice + curBuyPrice
      local totalAvg = TradeDataModel.TempCurAvgCost + DataModel.BatchInfo.avgPrice * num
      local profit = totalSale - totalAvg
      local tax = 0
      if 0 < profit then
        local activityTax = TradeDataModel.ActivityTaxCuts[DataModel.BatchInfo.goodsId] or 0
        if activityTax ~= 0 then
          activityTax = activityTax * (DataModel.BatchInfo.newPrice - DataModel.BatchInfo.avgPrice) * num
        end
        local newProfit = profit * TradeDataModel.GetTax() + activityTax + TradeDataModel.GetActivityGoodsTax()
        if newProfit < 0 then
          newProfit = 0
        end
        tax = DataModel.NumRound(newProfit)
      end
      showTotal = totalSale - tax
    end
    View.Group_Batch.Group_Panel.Group_Price.Img_Coin:SetSprite(goldIcon)
    View.Group_Batch.Group_Panel.Group_Price.Txt_Num:SetText(showTotal)
  end
end

function Controller:ConfirmBatchClick()
  if DataModel.BatchType == 1 then
    local TradeController = require("UIHomeTrade/UITradeController")
    if TradeDataModel.CurTradeType == TradeDataModel.TradeType.Buy then
      TradeController:BuyToTemp(DataModel.BatchInfo, DataModel.BatchNum)
    elseif TradeDataModel.CurTradeType == TradeDataModel.TradeType.Sale then
      TradeController:SaleToTemp(DataModel.BatchInfo, DataModel.BatchNum)
    end
  elseif DataModel.BatchType == 2 then
    local WarehouseController = require("UIHomeTrade/UIWarehouseController")
    WarehouseController:CurToStation(DataModel.BatchIdx, DataModel.BatchNum)
  elseif DataModel.BatchType == 3 then
    local WarehouseController = require("UIHomeTrade/UIWarehouseController")
    WarehouseController:StationToCur(DataModel.BatchIdx, DataModel.BatchNum)
  end
  View.Group_Batch.self:SetActive(false)
end

function Controller:RefreshItem(info, element, isShowLock)
  local show
  if info.info then
    show = info.info
  else
    show = TradeDataModel.IdToDetailInfo[info.id]
  end
  element.Img_Item:SetSprite(show.imagePath)
  element.Img_Bottom:SetSprite(UIConfig.BottomConfig[show.qualityInt + 1])
  element.Img_Mask:SetSprite(UIConfig.MaskConfig[show.qualityInt + 1])
  element.Txt_Num:SetText(info.num)
  if isShowLock then
    isShowLock = isShowLock and info.goodsMod == "\229\159\186\231\161\128\232\180\167\231\137\169"
    if isShowLock then
      local goodsServerInfo = PlayerData:GetHomeInfo().warehouse[tostring(info.goodsId)]
      isShowLock = isShowLock and goodsServerInfo and goodsServerInfo.is_locked == 1
    end
  end
  if element.Img_Lock then
    element.Img_Lock:SetActive(isShowLock == true)
  end
end

function Controller:SetNPC()
  local commonNpc = require("Common/NPCDialog")
  commonNpc.SetNPC(View.Group_NPCPos.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  commonNpc.HandleNPCTxtTable({repLv = repLv})
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
end

function Controller:ShowNPCTalk(dialogEnum, checkCache)
  if dialogEnum == DataModel.NPCDialogEnum.talkText then
    local result = QuestProcess.CheckTalkDo(DataModel.CacheEventList, View, DataModel.BuildingId, function()
      View.Group_Main:SetActive(true)
    end)
    if result then
      if result == 2 then
        View.Group_Main:SetActive(false)
      end
      return
    end
  end
  if checkCache then
    if TradeDataModel.cacheNPCTalk[dialogEnum] then
      return
    else
      TradeDataModel.cacheNPCTalk[dialogEnum] = 1
    end
  end
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = {}
  textTable = npcConfig[dialogEnum]
  if textTable == nil then
    return
  end
  local commonNpc = require("Common/NPCDialog")
  commonNpc.SetNPCText(View.Group_NPCPos.Group_NPC, textTable, dialogEnum)
end

function Controller:ClickManufacture()
  UIManager:Open("UI/Home_MachiningMenu/Home_MachiningMenu")
end

function Controller:RefreshTradeUpdateUnlock()
  local isUnlock, numType = TradeDataModel.GetIsStationTradeUpdateOpen(DataModel.StationId)
  if isUnlock then
    View.Group_Main.Btn_invest.Img_Rep:SetActive(false)
    View.Group_Main.Btn_invest.Btn.interactable = true
  else
    View.Group_Main.Btn_invest.Img_Rep:SetActive(true)
    View.Group_Main.Btn_invest.Img_Rep.Txt_loading:SetActive(numType == 1)
    View.Group_Main.Btn_invest.Img_Rep.Txt_Rep:SetActive(numType == 2)
    if numType == 2 then
      View.Group_Main.Btn_invest.Img_Rep.Txt_Rep:SetText(string.format(GetText(80612161), TradeDataModel.GetStationTradeUnlockRepNum()))
    end
    View.Group_Main.Btn_invest.Btn.interactable = false
  end
end

return Controller
