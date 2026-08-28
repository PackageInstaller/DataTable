local View = require("UIHomeTradeUpgrade/UIHomeTradeUpgradeView")
local DataModel = require("UIHomeTradeUpgrade/UIHomeTradeUpgradeDataModel")
local Controller = {}

function Controller.Init()
  Net:SendProto("station.good_lv_dt", function(json)
    if json and string.nilorempty(json.rc) then
      DataModel.Init()
      DataModel.UpdatePlayerSidGoodProtoInfo(json.sid_good_lv, json.sid_used_funds)
      DataModel.SidTotalInvestMoney = json.currency_funds or {}
      Controller.RefreshTradeLv()
      Controller.RefreshActionValue()
      Controller.RefreshStationList()
      Controller.OnStationElementClick(1)
      Controller.RefreshGoldValue()
      View.ScrollGrid_down.grid.self:MoveToTop()
    end
  end)
end

function Controller.Release()
  DataModel.CurSelectGoodIndex = 0
  DataModel.CurSelectStationIndex = 0
  DataModel.CurStationCa = nil
  DataModel.CurStationSellList = {}
  DataModel.UpLv = 1
  DataModel.SidTotalInvestMoney = {}
  DataModel.CurStaSellPriceList = nil
  DataModel.GoodAddPercentList = nil
end

function Controller.RefreshTradeLv()
  View.Group_Trade.Group_TradeLv.Txt_Num:SetText(string.format(GetText(80600599), PlayerData:GetHomeInfo().trade_lv))
end

function Controller.RefreshActionValue()
  if View.Group_Trade and View.Group_Trade.self and View.Group_Trade.self.IsActive then
    local homeCommon = require("Common/HomeCommon")
    local maxHomeEnergy = homeCommon.GetMaxHomeEnergy()
    View.Group_Trade.Group_Energy.Txt_Num:SetText(DataModel.GetActionValue() .. "/" .. maxHomeEnergy)
    View.Group_Trade.Group_Energy.Img_PB:SetFilledImgAmount(DataModel.GetActionValue() / maxHomeEnergy)
  end
end

function Controller.RefreshGoldValue()
  if not DataModel.CurStationCa then
    return
  end
  local currency = DataModel.GetStationCurrency(DataModel.CurStationCa.id)
  local goldNum = PlayerData:GetGoodsById(currency).num or 0
  View.Group_Trade.Group_GoldCoin.Txt_Num:SetText(goldNum)
  local itemCa = PlayerData:GetFactoryData(DataModel.GetStationCurrency(DataModel.CurStationCa.id), "ItemFactory")
  if itemCa and not string.nilorempty(itemCa.buyPath) then
    View.Group_Trade.Group_GoldCoin.Img_Icon:SetSprite(itemCa.buyPath)
  end
end

function Controller.RefreshStationList()
  if not DataModel.StationList then
    return
  end
  View.ScrollGrid_down.grid.self:SetDataCount(#DataModel.StationList)
  View.ScrollGrid_down.grid.self:RefreshAllElement()
  View.ScrollGrid_down.grid.self:SetActive(#DataModel.StationList > 1)
end

function Controller.RefreshStationListElementShow(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  if not DataModel.StationList then
    return
  end
  local stationCa = DataModel.StationList[elementIndex]
  if not stationCa then
    return
  end
  element.Txt_NameON:SetText(stationCa.name)
  element.Txt_NameOFF:SetText(stationCa.name)
  element.Img_:SetSprite(stationCa.cityMapIconPath)
  element.Img_Select:SetActive(elementIndex == DataModel.CurSelectStationIndex)
  local isNowSt = stationCa.id == DataModel.NowStationId
  element.Txt_NameLocal:SetActive(isNowSt)
  element.Txt_NameON:SetActive(isNowSt)
  element.Txt_NameOFF:SetActive(not isNowSt)
  element.Btn_:SetClickFunction(function()
    Controller.OnStationElementClick(elementIndex)
  end)
end

function Controller.OnStationElementClick(elementIndex)
  if not DataModel.StationList then
    return
  end
  local stationCa = DataModel.StationList[elementIndex]
  if not stationCa then
    return
  end
  DataModel.CurSelectStationIndex = elementIndex
  DataModel.CurStationCa = stationCa
  local isCurSta = stationCa.id == DataModel.NowStationId
  
  local function refList(sellList)
    Controller.RefreshGoodList(sellList)
    View.ScrollGrid_down.grid.self:RefreshAllElement()
    View.Group_Right.Group_NotMax.Btn_confirm:SetActive(isCurSta)
    View.Group_Right.Group_NotMax.Txt_confirm:SetActive(isCurSta)
  end
  
  if isCurSta then
    if DataModel.CurStaSellPriceList then
      refList(DataModel.CurStaSellPriceList)
    else
      Net:SendProto("station.goods_info", function(json)
        if json and string.nilorempty(json.rc) and json.goods_price and json.goods_price.sell_price then
          DataModel.CurStaSellPriceList = json.goods_price.sell_price
          refList(DataModel.CurStaSellPriceList)
        end
      end)
    end
  else
    refList()
  end
end

function Controller.RefreshGoodList(sellProtoList)
  DataModel.CurStationSellList = {}
  if not DataModel.CurStationCa then
    return
  end
  local sellList
  if not sellProtoList then
    sellList = DataModel.CurStationCa.sellList
    if not sellList then
      return
    end
    DataModel.CurStationSellList = Clone(sellList)
  else
    local tempList = {}
    for id, _ in pairs(sellProtoList) do
      local temp = {}
      temp.id = tonumber(id)
      table.insert(tempList, temp)
    end
    DataModel.CurStationSellList = tempList
  end
  table.sort(DataModel.CurStationSellList, function(a, b)
    local goodCaA = PlayerData:GetFactoryData(a.id, "HomeGoodsQuotationFactory")
    local goodCaB = PlayerData:GetFactoryData(b.id, "HomeGoodsQuotationFactory")
    if goodCaA.price ~= goodCaB.price then
      return goodCaA.price < goodCaB.price
    else
      return a.id < b.id
    end
  end)
  View.Group_Left.ScrollGrid_Left.grid.self:SetDataCount(#DataModel.CurStationSellList)
  View.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
  Controller.OnGoodItemClick(1)
end

function Controller.RefreshGoodElementShow(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  if not DataModel.CurStationSellList then
    return
  end
  local goodInfo = DataModel.CurStationSellList[elementIndex] or {}
  local goodId = goodInfo.id
  if not goodId then
    return
  end
  local goodQuotationCa = PlayerData:GetFactoryData(goodId, "HomeGoodsQuotationFactory")
  if not goodQuotationCa then
    return
  end
  local goodCa = PlayerData:GetFactoryData(goodQuotationCa.goodsId, "HomeGoodsFactory")
  if goodCa then
    element.Img_Item:SetSprite(goodCa.imagePath)
    element.Img_Bottom:SetSprite(UIConfig.BottomConfig[goodCa.qualityInt + 1])
    element.Img_Mask:SetSprite(UIConfig.MaskConfig[goodCa.qualityInt + 1])
  end
  element.Img_OnMask:SetActive(elementIndex == DataModel.CurSelectGoodIndex)
  element.Txt_On:SetActive(elementIndex == DataModel.CurSelectGoodIndex)
  element.Btn_:SetClickFunction(function()
    Controller.OnGoodItemClick(elementIndex)
  end)
  local isRepUnlock = DataModel.GetIsGoodLvUnlockByIndex(elementIndex)
  element.Img_lock:SetActive(not isRepUnlock)
  local isLvMax = DataModel.GetGoodLvIsMax(DataModel.CurStationCa.id, goodQuotationCa.goodsId)
  element.Group_Max:SetActive(isLvMax)
end

function Controller.OnGoodItemClick(index)
  if not index then
    return
  end
  if not DataModel.CurStationSellList then
    return
  end
  local goodInfo = DataModel.CurStationSellList[index] or {}
  local goodId = goodInfo.id
  if not goodId then
    return
  end
  local goodQuotationCa = PlayerData:GetFactoryData(goodId, "HomeGoodsQuotationFactory")
  if not goodQuotationCa then
    return
  end
  local goodCa = PlayerData:GetFactoryData(goodQuotationCa.goodsId, "HomeGoodsFactory")
  DataModel.CurGoodCa = goodCa
  DataModel.CurGoodQuotCa = goodQuotationCa
  DataModel.CurSelectGoodIndex = index
  View.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
  DataModel.UpLv = 1
  Controller.RefreshGoodDetailShow()
end

function Controller.RefreshGoodDetailShow()
  if not DataModel.CurStationCa then
    return
  end
  if not DataModel.CurGoodCa or not DataModel.CurGoodQuotCa then
    return
  end
  if DataModel.CurGoodCa then
    View.Group_Right.Img_Item:SetSprite(DataModel.CurGoodCa.tipsPath)
    View.Group_Right.Img_Item.Txt_Name:SetText(DataModel.CurGoodCa.name)
  end
  local rate = DataModel.GetTradeGoldRate() or 1
  if DataModel.CurGoodQuotCa then
    View.Group_Right.Img_Item.Txt_Price:SetText(math.ceil(DataModel.CurGoodQuotCa.price * rate))
  end
  View.Group_Right.Img_Item.Btn_:SetClickFunction(function()
    CommonTips.OpenGoodsTips(DataModel.CurGoodCa.id, 1)
  end)
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  View.Group_Right.Img_Item.Txt_Lv:SetText("LV." .. tostring(lv))
  local canInvestMaxNum = DataModel.GetMaxInvestNumByStationId(DataModel.CurStationCa.id) or 0
  local hasInvestNum = DataModel.GetStationHasInvestNum(DataModel.CurStationCa.id) or 0
  local canInvestNum = canInvestMaxNum - hasInvestNum
  canInvestNum = canInvestNum < 0 and 0 or canInvestNum
  View.Group_Right.Img_BarBG.Txt_Num:SetText(tostring(DataModel.GetRoundNum(canInvestNum)) .. "/" .. tostring(DataModel.GetRoundNum(canInvestMaxNum)))
  canInvestMaxNum = canInvestMaxNum == 0 and 1 or canInvestMaxNum
  DataModel.CurCanInvestMoney = canInvestNum
  local ratio = canInvestNum / canInvestMaxNum
  View.Group_Right.Img_BarBG.Img_BarU:SetFilledImgAmount(ratio)
  local itemCa = PlayerData:GetFactoryData(DataModel.GetStationCurrency(DataModel.CurStationCa.id), "ItemFactory")
  if itemCa and not string.nilorempty(itemCa.buyPath) then
    View.Group_Right.Img_BarBG.Img_Icon:SetSprite(itemCa.buyPath)
    View.Group_Right.Img_Item.Img_Icon:SetSprite(itemCa.buyPath)
  end
  View.Group_Right.Img_BarBG.Txt_percent:SetText(DataModel.GetMoneyBuffRate() .. "%")
  Controller.RefreshDetailLvInfoShow()
end

function Controller.RefreshDetailLvInfoShow()
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  local isLvMax = DataModel.GetGoodLvIsMax(DataModel.CurStationCa.id, DataModel.CurGoodCa.id)
  local repNum = DataModel.GetStationRepNum(DataModel.CurStationCa.id) or 0
  local inventoryBaseNum = DataModel.CurGoodQuotCa.num or 0
  local inventoryPercent = DataModel.TradeUpdateCa.inventory or 0
  local minInventory = DataModel.CurGoodQuotCa.stockMultipleMin or 0
  if isLvMax then
    View.Group_Right.Group_NotMax:SetActive(false)
    View.Group_Right.Group_Max:SetActive(true)
    View.Group_Right.Group_Max.Txt_Lv2:SetText("LV." .. lv)
    View.Group_Right.Group_Max.Txt_ShengWangNum1:SetText(tostring(repNum))
  else
    View.Group_Right.Group_NotMax:SetActive(true)
    View.Group_Right.Group_Max:SetActive(false)
    View.Group_Right.Group_NotMax.Txt_Lv1:SetText("LV." .. tostring(lv))
    View.Group_Right.Group_NotMax.Txt_Lv2:SetText("LV." .. tostring(lv + DataModel.UpLv))
    local allCost = DataModel.GetUpgradeCostMoney(DataModel.UpLv) or 0
    View.Group_Right.Group_NotMax.Txt_GoldNumNum:SetText(tostring(allCost))
    local rate = DataModel.GetTradeGoldRate() or 1
    local addRep = math.floor(allCost / (DataModel.TradeUpdateCa.tradeRate * rate)) or 0
    View.Group_Right.Group_NotMax.Txt_ShengWangNum1:SetText(string.format(GetText(80611847), repNum, addRep))
    DataModel.CostMoney = allCost
    local itemCa = PlayerData:GetFactoryData(DataModel.GetStationCurrency(DataModel.CurStationCa.id), "ItemFactory")
    if itemCa and not string.nilorempty(itemCa.buyPath) then
      View.Group_Right.Group_NotMax.Img_GoldIcon:SetSprite(itemCa.buyPath)
    end
  end
  
  local function refreshQuantityShow(buyPercent, extNum, extraStock, tagBuff, extraPercent)
    local curLvAddNum = DataModel.GetGoodComeNumByOffsetLv(0, buyPercent, extNum, nil, nil, tagBuff, extraPercent)
    if isLvMax then
      View.Group_Right.Group_Max.Txt_QuantityNum2:SetText(tostring(DataModel.GetRoundNum(curLvAddNum)))
      View.Group_Right.Group_Max.Txt_InventoryNum2:SetText(tostring(DataModel.GetRoundNum(inventoryBaseNum)) .. "x" .. tostring(DataModel.GetRoundNum(minInventory + lv * inventoryPercent + extraStock / inventoryBaseNum)))
    else
      View.Group_Right.Group_NotMax.Txt_QuantityNum1:SetText(tostring(DataModel.GetRoundNum(curLvAddNum)))
      local nextLvAddNum = DataModel.GetGoodComeNumByOffsetLv(DataModel.UpLv, buyPercent, extNum, nil, nil, tagBuff, extraPercent)
      View.Group_Right.Group_NotMax.Txt_QuantityNum2:SetText(tostring(DataModel.GetRoundNum(nextLvAddNum)))
      View.Group_Right.Group_NotMax.Txt_InventoryNum1:SetText(tostring(DataModel.GetRoundNum(inventoryBaseNum)) .. "x" .. tostring(DataModel.GetRoundNum(minInventory + lv * inventoryPercent + extraStock / inventoryBaseNum)))
      View.Group_Right.Group_NotMax.Txt_InventoryNum2:SetText(tostring(DataModel.GetRoundNum(inventoryBaseNum)) .. "x" .. tostring(DataModel.GetRoundNum(minInventory + (lv + DataModel.UpLv) * inventoryPercent + extraStock / inventoryBaseNum)))
    end
  end
  
  local buyPercent, extNum, extraStock, tagBuff, extraPercent = DataModel.GetGoodAddPercent(DataModel.CurStationCa.id, DataModel.CurGoodQuotCa.id)
  if not buyPercent then
    Net:SendProto("station.goods", function(json)
      if json and string.nilorempty(json.rc) then
        local buy_Percent = json.buy_percent or 0
        local ext_Num = json.ext_num or 0
        local extra_stock = json.extra_stock or 0
        local extra_Percent = json.extra_percent or 0
        local questTagBuff = json.quest_tag_bf or {}
        local tag_Buff = questTagBuff[tostring(DataModel.CurGoodCa.goodsType)] or 0
        DataModel.SaveGoodAddPercent(DataModel.CurStationCa.id, DataModel.CurGoodQuotCa.id, buy_Percent, ext_Num, extra_stock, tag_Buff)
        refreshQuantityShow(buy_Percent, ext_Num, extra_stock, tag_Buff, extra_Percent)
      end
    end, DataModel.CurStationCa.id, DataModel.CurGoodQuotCa.id)
  else
    refreshQuantityShow(buyPercent, extNum, extraStock, tagBuff, extraPercent)
  end
end

function Controller.OnLvMinBtnClick()
  DataModel.UpLv = 1
  Controller.RefreshDetailLvInfoShow()
end

function Controller.OnLvDownBtnClick()
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  DataModel.UpLv = DataModel.UpLv - 1
  if DataModel.UpLv < 1 then
    DataModel.UpLv = 1
  end
  Controller.RefreshDetailLvInfoShow()
end

function Controller.OnLvUpBtnClick()
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  local canUpLv = DataModel.GetGoodCanUpMaxLv() or 0
  DataModel.UpLv = DataModel.UpLv + 1
  local maxOffsetLv = canUpLv - lv
  if maxOffsetLv < DataModel.UpLv then
    DataModel.UpLv = maxOffsetLv
  end
  if 0 >= DataModel.UpLv then
    DataModel.UpLv = 1
  end
  if DataModel.UpLv + lv > DataModel.GoodMaxLv then
    DataModel.UpLv = DataModel.GoodMaxLv - lv
  end
  Controller.RefreshDetailLvInfoShow()
end

function Controller.OnLvMaxBtnClick()
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  local canUpLv = DataModel.GetGoodCanUpMaxLv() or 0
  DataModel.UpLv = canUpLv <= 0 and 1 or canUpLv - lv
  if 0 >= DataModel.UpLv then
    DataModel.UpLv = 1
  end
  if DataModel.UpLv + lv > DataModel.GoodMaxLv then
    DataModel.UpLv = DataModel.GoodMaxLv - lv
  end
  Controller.RefreshDetailLvInfoShow()
end

function Controller.OnConfirmUpBtnClick()
  if not DataModel.CurGoodCa then
    return
  end
  if not DataModel.CurGoodQuotCa then
    return
  end
  if DataModel.UpLv == 0 then
    return
  end
  local isLastUnlock, lastGoodName = DataModel.GetIsLastGoodUnlockByIndex(DataModel.CurSelectGoodIndex)
  if not isLastUnlock then
    if not string.nilorempty(lastGoodName) then
      CommonTips.OpenTips(string.format(GetText(80611963), lastGoodName, DataModel.TradeUpdateCa.NextLock))
    end
    return
  end
  local isRepUnlock, repLockNum = DataModel.GetIsGoodRepUnlock(DataModel.CurSelectGoodIndex)
  if not isRepUnlock then
    if 0 < repLockNum then
      CommonTips.OpenTips(string.format(GetText(80611964), repLockNum))
    end
    return
  end
  DataModel.CostMoney = DataModel.CostMoney or 0
  DataModel.CurCanInvestMoney = DataModel.CurCanInvestMoney or 0
  if DataModel.CurCanInvestMoney < DataModel.CostMoney then
    CommonTips.OpenTips(80611810)
    return
  end
  local currency = DataModel.GetStationCurrency(DataModel.CurStationCa.id)
  local goldNum = PlayerData:GetGoodsById(currency).num or 0
  if goldNum < DataModel.CostMoney then
    CommonTips.OpenTips(80611809)
    return
  end
  local lv = DataModel.GetGoodLv(DataModel.CurStationCa.id, DataModel.CurGoodCa.id) or 0
  local nextLv = lv + DataModel.UpLv
  Net:SendProto("station.good_lv_up", function(json)
    if json and string.nilorempty(json.rc) then
      CommonTips.OpenTips(80611927)
      DataModel.AddSidTotalInvestMoney(DataModel.GetStationCurrency(DataModel.CurStationCa.id), DataModel.CostMoney)
      DataModel.UpLv = 1
      DataModel.RefreshStationRepNum(DataModel.CurStationCa.id, json.rep_num, json.rep_lv)
      DataModel.RemoveGoodAddPercent(DataModel.CurStationCa.id, DataModel.CurGoodQuotCa.id)
      DataModel.UpdatePlayerSidGoodProtoInfo(json.sid_good_lv, json.sid_used_funds)
      Controller.RefreshGoodDetailShow()
      Controller.RefreshGoldValue()
      View.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
    end
  end, DataModel.CurGoodQuotCa.id, nextLv)
end

return Controller
