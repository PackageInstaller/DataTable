local View = require("UIBarStore/UIBarStoreView")
local DataModel = require("UIBarStore/UIBarStoreDataModel")
local StoreDataModel = require("UIStore/UIStoreDataModel")
local NPCDialog = require("Common/NPCDialog")
local HomeDrinkPanel = require("Common/HomeDrinkPanel")
local Controller = {}

local function GetDrinkPanelContext()
  return {
    View = View,
    DataModel = DataModel,
    Controller = Controller,
    mainButtons = {
      View.Group_Main.Btn_Drink,
      View.Group_Main.Btn_Store,
      View.Group_Main.Btn_Talk
    },
    drinkGroup = View.Group_Main.Group_Drink,
    openAnim = "Drink_In",
    closeAnim = "Drink_Out",
    enableVideo = true,
    enableReplaceTip = true,
    replaceTipPrefabPath = "UI/Home/BarStore/BarStore",
    drinkBuffUiPath = "UI/Home/BarStore/DrinkBuff"
  }
end

function Controller:Init()
  View.Group_Main.self:SetActive(true)
  View.Group_Main.Btn_Drink.self:SetActive(true)
  View.Group_Main.Btn_Store.self:SetActive(true)
  View.Group_Main.Btn_Talk.self:SetActive(true)
  View.Group_Main.Group_Drink.self:SetActive(false)
  View.Group_LocalStore.self:SetActive(false)
  View.Img_Backgroud:SetSprite(DataModel.BgPath)
  View.Img_Backgroud:SetColor(DataModel.BgColor)
  Controller:InitNPC()
  Controller:CheckQuestProcess()
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  View.Group_Main.Btn_Store.Img_RedPoint:SetActive(RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity) > 0)
end

function Controller:CheckQuestProcess()
  local params = {}
  params.url = View.self.url
  local status = {
    Current = "Chapter",
    squadIndex = PlayerData.BattleInfo.squadIndex,
    hasOpenThreeView = false
  }
  local t = {}
  if DataModel.decodeParams then
    t = Clone(DataModel.decodeParams)
  else
    t.buildingId = DataModel.BuildingId
    t.npcId = DataModel.NpcId
  end
  status.extraUIParamData = t
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #DataModel.CacheEventList
  View.Group_Main.Btn_Talk.Img_RedPoint:SetActive(0 < count)
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    if count == 1 then
      local questCA = PlayerData:GetFactoryData(DataModel.CacheEventList[1].questId)
      View.Group_Main.Btn_Talk.Txt_:SetText(questCA.name)
    else
      View.Group_Main.Btn_Talk.Txt_:SetText(GetText(80602502))
    end
  else
    View.Group_Main.Btn_Talk.Txt_:SetText(GetText(80602502))
  end
end

function Controller:OpenDrink()
  return HomeDrinkPanel.OpenDrink(GetDrinkPanelContext())
end

function Controller:CheckTimeDrinkCountRefresh()
  return HomeDrinkPanel.CheckTimeDrinkCountRefresh()
end

function Controller:OpenStore()
  DataModel.isStoreOpened = true
  DataModel.CacheOpenStore = {}
  DataModel.List = {}
  DataModel.AutoRefreshTime = {}
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.StoreText)
  DataModel.CurIndex = 1
  View.Group_Main.self:SetActive(false)
  UIManager:LoadSplitPrefab(View, "UI/Home/BarStore/BarStore", "Group_LocalStore")
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  View.Group_LocalStore.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  local homeCommon = require("Common/HomeCommon")
  homeCommon.SetReputationElement(View.Group_LocalStore.Group_Reputation, DataModel.StationId)
  Controller:ChooseTab(1, true)
  View.self:PlayAnim("StoreList")
end

function Controller:DrinkReturnToMain()
  return HomeDrinkPanel.DrinkReturnToMain(GetDrinkPanelContext())
end

function Controller:StoreReturnToMain()
  DataModel.isStoreOpened = false
  View.Group_LocalStore.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.self:PlayAnim("Main")
  Controller:InitNPC()
end

function Controller:RefreshTopTab(idx)
  local isSelect = DataModel.CurIndex == idx
  local element
  if idx == 1 then
    element = View.Group_LocalStore.Group_StoreList.Group_Tab.Group_Headquarters
  else
    element = View.Group_LocalStore.Group_StoreList.Group_Tab.Group_Local
  end
  element.Group_Off:SetActive(not isSelect)
  element.Group_On:SetActive(isSelect)
  local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  local isShow = idx <= table.count(stationConfig.barStoreList)
  element.self:SetActive(isShow)
  if isShow then
    local shopId = stationConfig.barStoreList[idx].id
    local storeConfig = PlayerData:GetFactoryData(shopId, "StoreFactory")
    element.Group_On.Img_1.Txt_Name:SetText(storeConfig.storeName)
    element.Group_On.Img_1.Img_Select:SetSprite(storeConfig.pngSelect)
    element.Group_Off.Txt_Name:SetText(storeConfig.storeName)
    element.Group_Off.Img_Select:SetSprite(storeConfig.pngNotSelect)
    if element.Img_RedPoint then
      element.Img_RedPoint:SetActive(RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. shopId) > 0)
    end
  end
end

function Controller:ChooseTab(idx, notAni)
  local function detailDo()
    View.Group_LocalStore.self:SetActive(true)
    
    DataModel.CurIndex = idx
    Controller:RefreshTopTab(1)
    Controller:RefreshTopTab(2)
    Controller:ResetBatchInfo()
    DataModel.Now_List = DataModel.List[idx]
    DataModel.ShopId = DataModel.Now_List.shopId
    Controller:RefreshResource()
    DataModel.RefreshShopDataDetail()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:MoveToTop()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
    local storeFactory = PlayerData:GetFactoryData(DataModel.Now_List.shopId, "StoreFactory")
    local isShow = #storeFactory.moneyList > 0
    View.Group_LocalStore.Group_StoreList.Btn_ShuaXin.self:SetActive(isShow)
    local isAutoRefresh = storeFactory.autoRefresh
    View.Group_LocalStore.Group_StoreList.Group_Time.self:SetActive(isAutoRefresh)
    if isAutoRefresh then
      local time = storeFactory.refreshTimeList[1]
      local h = tonumber(string.sub(time.refreshTime, 1, 2))
      local m = tonumber(string.sub(time.refreshTime, 4, 5))
      local textId
      if storeFactory.refreshType == "Daily" then
        textId = 80600463
      elseif storeFactory.refreshType == "Weekly" then
        textId = 80600786
      elseif storeFactory.refreshType == "Monthly" then
        textId = 80600787
      end
      View.Group_LocalStore.Group_StoreList.Group_Time.Txt_Time:SetText(string.format(GetText(textId), h, m))
    end
    if not notAni then
      View.self:PlayAnimOnce("Switch")
    end
  end
  
  if DataModel.CacheOpenStore[idx] == nil then
    local stationConfig = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    local storeId = stationConfig.barStoreList[idx].id
    Net:SendProto("shop.info", function(json)
      DataModel.CacheOpenStore[idx] = 0
      DataModel.InitShopData(idx)
      detailDo()
    end, storeId)
  else
    detailDo()
  end
end

function Controller:RefreshResource()
  View.Group_LocalStore.Group_Ding.StaticGrid_Coin.grid.self:RefreshAllElement()
end

function Controller:RefreshResourceElement(element, elementIndex)
  local currency = DataModel.Now_List.currencyShow[elementIndex]
  local isShow = currency ~= nil
  element:SetActive(isShow)
  if isShow then
    local itemCA = PlayerData:GetFactoryData(currency.id)
    element.Img_Icon:SetSprite(itemCA.buyPath)
    element.Group_Num.Txt_Num:SetText(PlayerData:GetGoodsById(currency.id).num)
    element.Btn_GoldCoin:SetClickParam(elementIndex)
    local isShowBtnAdd = currency.click == "Hua"
    element.Group_Num.Btn_Add:SetActive(isShowBtnAdd)
    if isShowBtnAdd then
      element.Group_Num.Btn_Add:SetClickParam(elementIndex)
    end
  end
end

function Controller:ClickResourceElement(str)
  local currency = DataModel.Now_List.currencyShow[tonumber(str)]
  if currency.click == "Tips" then
    CommonTips.OpenPreRewardDetailTips(currency.id)
  elseif currency.click == "Hua" then
    Net:SendProto("shop.info", function(json)
      json.shopId = 80300003
      UIManager:Open("UI/Store/Store", Json.encode(json))
    end)
  end
end

function Controller:RefreshShop()
  local storeFactory = PlayerData:GetFactoryData(DataModel.Now_List.shopId, "StoreFactory")
  local isShow = #storeFactory.moneyList > 0
  if isShow then
    local info = storeFactory.moneyList[1]
    local t = {}
    t.itemId = info.moneyID
    t.useNum = info.moneyNum
    local itemCA = PlayerData:GetFactoryData(t.itemId, "ItemFactory")
    CommonTips.OnItemPrompt(string.format(GetText(80600586), itemCA.name), t, function()
      Net:SendProto("shop.refresh", function()
        DataModel.InitShopData(DataModel.CurIndex)
        Controller:ChooseTab(DataModel.CurIndex)
        local use = {}
        use[t.itemId] = t.useNum
        PlayerData:RefreshUseItems(use)
      end, DataModel.ShopId)
      Controller:RefreshResource()
    end)
  end
end

function Controller:RefreshCommodityShow(element, elementIndex)
  local idx = tonumber(elementIndex)
  if DataModel.isBatch then
    element.Group_Select.self:SetActive(DataModel.batchList[idx] ~= nil)
  else
    element.Group_Select.self:SetActive(false)
  end
  element.Group_Item.Btn_Item:SetClickParam(idx)
  local row = DataModel.Now_List.shopList[idx]
  local data = PlayerData:GetFactoryData(row.id)
  element.Group_Item.Btn_Item.Img_ItemRole.self:SetActive(false)
  element.Group_Item.Btn_Item.Txt_ItemName:SetText(data.commodityName)
  element.Group_Item.Btn_Item.Img_ItemBG.Img_Item:SetSprite(data.commodityView)
  element.Group_Item.Btn_Item.Img_ItemBG.Txt_Num:SetText(data.commodityNum)
  local qualityInt = data.qualityInt
  element.Group_Item.Btn_Item.Img_ItemBG.self:SetSprite(UIConfig.BottomConfig[qualityInt + 1])
  element.Group_Item.Btn_Item.Img_Mask:SetSprite(UIConfig.MaskConfig[qualityInt + 1])
  if data.purchase then
    element.Group_Item.Btn_Item.Img_ItemBG.Img_Residue:SetActive(true)
    element.Group_Item.Btn_Item.Img_ItemBG.Img_ResidueNum:SetActive(true)
    local textId = 0
    if data.limitBuyType == "Forever" then
      textId = 80600430
    elseif data.limitBuyType == "Daily" then
      textId = 80600798
    elseif data.limitBuyType == "Weekly" then
      textId = 80600800
    elseif data.limitBuyType == "Monthly" then
      textId = 80600801
    end
    local maxNum = StoreDataModel:GetPurchaseNum(data)
    element.Group_Item.Btn_Item.Img_ItemBG.Img_ResidueNum.Txt_ResidueNum:SetText(string.format(GetText(textId), row.residue, maxNum))
    if row.residue == 0 then
      element.Group_Item.Btn_Item.Img_Sold.self:SetActive(true)
    else
      element.Group_Item.Btn_Item.Img_Sold.self:SetActive(false)
    end
  else
    element.Group_Item.Btn_Item.Img_ItemBG.Img_Residue:SetActive(false)
    element.Group_Item.Btn_Item.Img_ItemBG.Img_ResidueNum:SetActive(false)
    element.Group_Item.Btn_Item.Img_Sold.self:SetActive(false)
  end
  element.Group_Item.Btn_Item.Group_Discount.self:SetActive(0 < data.discountVariable)
  if 0 < data.discountVariable then
    element.Group_Item.Btn_Item.Group_Discount.Txt_Discount:SetText(string.format(GetText(80601651), data.discountVariable))
  end
  local money = data.moneyList[1]
  if money then
    element.Group_Item.Btn_Item.Group_Money.self:SetActive(true)
    local left_money = PlayerData:GetFactoryData(tonumber(data.moneyList[1].moneyID))
    local path = left_money.buyPath
    if path == "" then
      path = left_money.iconPath
    end
    element.Group_Item.Btn_Item.Group_Money.Img_Money:SetSprite(path)
    local moneyNum = data.moneyList[1].moneyNum
    if data.isChange and 0 < data.moneyList[1].correspondPrice then
      local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
      local buyCount = (row.py_cnt or 0) + 1
      local priceCount = #listCA.priceList
      if buyCount > priceCount then
        buyCount = priceCount
      end
      moneyNum = listCA.priceList[buyCount].num
    end
    element.Group_Item.Btn_Item.Group_Money.Txt_MoneyNum:SetText(moneyNum)
  else
    element.Group_Item.Btn_Item.Group_Money.self:SetActive(false)
  end
  local commodity = data.commodityItemList[1]
  local factoryName = DataManager:GetFactoryNameById(commodity.id)
  if factoryName == "EquipmentFactory" then
    local detailData = PlayerData:GetFactoryData(commodity.id)
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.self:SetActive(true)
    local index = PlayerData:GetTypeInt("enumEquipTypeList", detailData.equipTagId)
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[detailData.qualityInt])
  else
    element.Group_Item.Btn_Item.Img_ItemBG.Group_EType.self:SetActive(false)
  end
  element.Group_Item.Btn_Item.Img_Limit.self:SetActive(false)
  element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetActive(false)
  element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetActive(false)
  if row.buyLimit then
    if 0 < row.limitRep then
      element.Group_Item.Btn_Item.Img_Limit.self:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Rep:SetText(string.format(GetText(80601109), row.limitRep))
    end
    if 0 < row.limitGrade then
      element.Group_Item.Btn_Item.Img_Limit.self:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetActive(true)
      element.Group_Item.Btn_Item.Img_Limit.Group_1.Txt_Grade:SetText(string.format(GetText(80601022), row.limitGrade))
    end
  end
  element.Group_Item.Btn_Item.Group_Time.self:SetActive(false)
  if data.isTriggerTime and row.endTime then
    local remainTime = row.endTime - TimeUtil:GetServerTimeStamp()
    element.Group_Item.Btn_Item.Group_Time.self:SetActive(0 < remainTime)
    if 0 < remainTime then
      local day = math.modf(remainTime / 86400)
      remainTime = remainTime - day * 86400
      local hour = math.ceil(remainTime / 3600)
      if hour == 24 then
        hour = 23
      elseif hour == 0 then
        hour = 23
        day = day - 1
      end
      element.Group_Item.Btn_Item.Group_Time.Txt_Time:SetText(string.format(GetText(80600954), day, hour))
    end
  end
  if DataModel.Now_List.shopId == DataModel.redPointShopId and DataModel.redPointCommodityIds[row.id] then
    element.Group_Item.Btn_Item.Img_RedPoint:SetActive(0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Now_List.shopId .. "|" .. row.id))
  else
    element.Group_Item.Btn_Item.Img_RedPoint:SetActive(false)
  end
  element.Group_Item.Btn_Item.Img_special:SetActive(data.isSpecial)
end

function Controller:ClickCommodity(btn, str)
  local idx = tonumber(str)
  local row = DataModel.Now_List.shopList[idx]
  local redPointInfo = DataModel.redPointCommodityIds[row.id]
  if DataModel.Now_List.shopId == DataModel.redPointShopId and redPointInfo then
    local key = "BarStoreShopRedPoint|" .. DataModel.Now_List.shopId .. "|" .. row.id
    if TimeUtil:GetServerTimeStamp() >= PlayerData:GetPlayerPrefs("int", key) then
      local nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Now_List.shopId .. "|" .. row.id
      RedpointTree:ChangeRedpointCnt(nodeName, -1)
      StoreDataModel:UpdateStoreRedState(DataModel.Now_List.shopId, row.id)
      local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
      local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
      local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
      local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
      local nextRefreshTime = 0
      if redPointInfo == 1 then
        nextRefreshTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
      elseif redPointInfo == 2 then
        nextRefreshTime = TimeUtil:GetNextWeekTime(1, h)
      elseif redPointInfo == 3 then
        nextRefreshTime = TimeUtil:GetNextMonthTime(1, h, m, s)
      end
      PlayerData:SetPlayerPrefs("int", key, nextRefreshTime)
      View.Group_Main.Btn_Store.Img_RedPoint:SetActive(0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity))
      View.Group_LocalStore.Group_StoreList.Group_Tab.Group_Headquarters.Img_RedPoint:SetActive(0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Now_List.shopId))
      local redPointElement = View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:GetElementByIndex(idx - 1)
      if redPointElement then
        redPointElement.Group_Item.Btn_Item.Img_RedPoint:SetActive(false)
      end
    end
  end
  if row.residue == 0 then
    CommonTips.OpenTips(80600077)
    return
  end
  if row.buyLimit then
    CommonTips.OpenTips(80601023)
    return
  end
  if DataModel.isBatch then
    if row.residue == 0 then
      CommonTips.OpenTips(80608827)
    else
      local data = PlayerData:GetFactoryData(row.id)
      local moneyNum = 0
      if data.moneyList[1] then
        if data.moneyList[1].moneyID ~= 11400001 then
          CommonTips.OpenTips(80611083)
          return
        end
        if data.isChange and 0 < data.moneyList[1].correspondPrice then
          local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
          local buyCount = (row.py_cnt or 0) + 1
          local priceCount = #listCA.priceList
          if buyCount > priceCount then
            buyCount = priceCount
            moneyNum = row.residue * listCA.priceList[buyCount].num
          else
            local maxBuyCount = row.residue + buyCount - 1
            local minMax = math.min(priceCount, maxBuyCount)
            for i = buyCount, minMax do
              moneyNum = moneyNum + listCA.priceList[i].num
            end
            if priceCount < maxBuyCount then
              moneyNum = moneyNum + (maxBuyCount - priceCount) * listCA.priceList[buyCount].num
            end
          end
        else
          moneyNum = data.moneyList[1].moneyNum * row.residue
        end
      end
      if DataModel.batchList[idx] == nil then
        DataModel.batchList[idx] = row.residue
        DataModel.batchMoney = DataModel.batchMoney + moneyNum
      else
        DataModel.batchList[idx] = nil
        DataModel.batchMoney = DataModel.batchMoney - moneyNum
      end
      Controller:RefreshBatchMoney()
      local element = View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:GetElementByIndex(idx - 1)
      Controller:RefreshCommodityShow(element, idx)
    end
    View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_On.self:SetActive(table.count(DataModel.batchList) == DataModel.Now_List.batchCount)
    View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_Off.self:SetActive(table.count(DataModel.batchList) ~= DataModel.Now_List.batchCount)
    return
  end
  if row.endTime and TimeUtil:GetServerTimeStamp() > row.endTime then
    CommonTips.OpenTips(80601523)
    DataModel.RefreshShopDataDetail()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
    return
  end
  row.commoditData = PlayerData:GetFactoryData(row.id)
  row.index = row.idx - 1
  row.shopid = DataModel.ShopId
  row.name = row.commoditData.commodityName
  row.image = row.commoditData.commodityView
  row.qualityInt = row.commoditData.qualityInt + 1
  CommonTips.OpenBuyTips(row, function(cnt)
    Controller:RefreshResource()
    DataModel.Now_List.server = PlayerData.ServerData.shops[tostring(DataModel.ShopId)]
    DataModel.RefreshShopDataDetail()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
  end)
end

function Controller:RefreshDrinkInfo()
  return HomeDrinkPanel.RefreshDrinkInfo(GetDrinkPanelContext())
end

function Controller:RefreshDrinkElement(element, elementIndex)
  return HomeDrinkPanel.RefreshDrinkElement(GetDrinkPanelContext(), element, elementIndex)
end

function Controller:Drink(idx)
  return HomeDrinkPanel.Drink(GetDrinkPanelContext(), idx)
end

function Controller:ConfirmDrink()
  return HomeDrinkPanel.ConfirmDrink(GetDrinkPanelContext())
end

function Controller:CheckShowDrinkBuffReplace()
  return HomeDrinkPanel.CheckShowDrinkBuffReplace(GetDrinkPanelContext())
end

function Controller:ConfirmReplaceBuff()
  return HomeDrinkPanel.ConfirmReplaceBuff(GetDrinkPanelContext())
end

function Controller:ShowDrinkBuff(buffId, recoverEnergy)
  return HomeDrinkPanel.ShowDrinkBuff(GetDrinkPanelContext(), buffId, recoverEnergy)
end

function Controller:TimeAutoRefresh()
  local curTime = TimeUtil:GetServerTimeStamp()
  for k1, v1 in pairs(DataModel.AutoRefreshTime) do
    if v1 < curTime then
      DataModel.AutoRefreshTime[k1] = v1 + 86400
      Net:SendProto("shop.info", function(json)
        DataModel.InitShopData(DataModel.CurIndex)
        if View.Group_LocalStore and View.Group_LocalStore.self and View.Group_LocalStore.self.IsActive then
          Controller:ChooseTab(DataModel.CurIndex)
        end
      end)
      break
    end
  end
end

function Controller:ShowVideo(cb)
  return HomeDrinkPanel.ShowVideo(GetDrinkPanelContext(), cb)
end

function Controller:VideoSkip()
  HomeDrinkPanel.VideoSkip(GetDrinkPanelContext())
  return
end

function Controller:CloseSkip()
  HomeDrinkPanel.CloseSkip(GetDrinkPanelContext())
  return
end

function Controller:InitNPC()
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  NPCDialog.HandleNPCTxtTable({repLv = repLv})
  Net:SendProto("shop.bar_shop", function(json)
    if json and string.nilorempty(json.rc) then
      DataModel.SpecialShopProto = json.shop
      DataModel.BarSpecialProto = json.bar_special
      DataModel.GBSpecialProto = json.gb_shop
      DataModel.CommodityList = json.commodity_list or {}
      Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
    end
  end, function()
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  end)
end

function Controller:ShowNPCTalk(dialogEnum)
  if dialogEnum == DataModel.NPCDialogEnum.talkText and QuestProcess.CheckTalkDo(DataModel.CacheEventList, View, DataModel.BuildingId, function()
    View.Group_Main:SetActive(true)
  end) == 2 then
    View.Group_Main:SetActive(false)
    return
  end
  local npcConfig = PlayerData:GetFactoryData(DataModel.NpcId, "NPCFactory")
  local textTable = npcConfig[dialogEnum]
  if dialogEnum == DataModel.NPCDialogEnum.enterText and npcConfig.SpecialText and #npcConfig.SpecialText > 0 then
    textTable = Clone(npcConfig[dialogEnum])
    for i = 1, #npcConfig.SpecialText do
      local spInfo = npcConfig.SpecialText[i]
      local shopCa = PlayerData:GetFactoryData(spInfo.store, "StoreFactory")
      if shopCa then
        local specialShopList = shopCa.specialShopList or {}
        for j = 1, #specialShopList do
          if DataModel.GBSpecialProto then
            local listIdDic = DataModel.GBSpecialProto[tostring(spInfo.store)] or {}
            local needInsert = false
            for listId, v in pairs(listIdDic) do
              local remainTime = DataModel.GetSpecialShopRemainRefreshCount(spInfo.store, listId)
              local isSpecialItemNotBuy = DataModel.GetShopIsHasSpecialItemNotBuy(spInfo.store)
              if 0 < remainTime then
                needInsert = true
              elseif remainTime == 0 and isSpecialItemNotBuy then
                needInsert = true
              end
              if needInsert then
                table.insert(textTable, npcConfig.SpecialText[i])
                break
              end
            end
          end
        end
      end
    end
  end
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

function Controller:ResetBatchInfo()
  DataModel.isBatch = false
  DataModel.batchMoney = 0
  DataModel.batchList = {}
  View.Group_LocalStore.Group_StoreList.Btn_PL.Group_On.self:SetActive(DataModel.isBatch)
  View.Group_LocalStore.Group_StoreList.Btn_PL.Group_Off.self:SetActive(not DataModel.isBatch)
  View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_On.self:SetActive(false)
  View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_Off.self:SetActive(true)
  Controller:RefreshBatchMoney()
end

function Controller:ClickBatchBtn()
  DataModel.isBatch = not DataModel.isBatch
  DataModel.batchMoney = 0
  if 0 < table.count(DataModel.batchList) then
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
  end
  DataModel.batchList = {}
  View.Group_LocalStore.Group_StoreList.Btn_PL.Group_On.self:SetActive(DataModel.isBatch)
  View.Group_LocalStore.Group_StoreList.Btn_PL.Group_Off.self:SetActive(not DataModel.isBatch)
  View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_On.self:SetActive(false)
  View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_Off.self:SetActive(true)
  Controller:RefreshBatchMoney()
end

function Controller:RefreshBatchMoney()
  View.Group_LocalStore.Group_StoreList.Group_PL.Group_Money.Txt_Num:SetText(DataModel.batchMoney)
  local color = "#FFFFFF"
  if PlayerData:GetGoodsById(11400001).num < DataModel.batchMoney then
    color = "#FF0000"
  end
  View.Group_LocalStore.Group_StoreList.Group_PL.Group_Money.Txt_Num:SetColor(color)
end

function Controller:ClickBatchAll()
  if not DataModel.isBatch then
    Controller:ClickBatchBtn()
  end
  if table.count(DataModel.batchList) == DataModel.Now_List.batchCount then
    DataModel.batchList = {}
    DataModel.batchMoney = 0
    View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_On.self:SetActive(false)
    View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_Off.self:SetActive(true)
  else
    View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_On.self:SetActive(true)
    View.Group_LocalStore.Group_StoreList.Group_PL.Group_SelectAll.Group_Off.self:SetActive(false)
    DataModel.batchMoney = 0
    for idx, row in ipairs(DataModel.Now_List.shopList) do
      if 0 < row.residue and not row.buyLimit then
        local data = PlayerData:GetFactoryData(row.id)
        local moneyNum = 0
        if data.moneyList[1] and data.moneyList[1].moneyID == 11400001 then
          if data.isChange and 0 < data.moneyList[1].correspondPrice then
            local listCA = PlayerData:GetFactoryData(data.moneyList[1].correspondPrice, "ListFactory")
            local buyCount = (row.py_cnt or 0) + 1
            local priceCount = #listCA.priceList
            if buyCount > priceCount then
              buyCount = priceCount
              moneyNum = row.residue * listCA.priceList[buyCount].num
            else
              local minMax = math.min(priceCount, row.residue)
              for i = buyCount, minMax do
                moneyNum = moneyNum + listCA.priceList[i].num
              end
              if priceCount < row.residue then
                moneyNum = moneyNum + (row.residue - priceCount) * listCA.priceList[buyCount].num
              end
            end
          else
            moneyNum = data.moneyList[1].moneyNum * row.residue
          end
          DataModel.batchList[idx] = row.residue
          DataModel.batchMoney = DataModel.batchMoney + moneyNum
          local redPointInfo = DataModel.redPointCommodityIds[row.id]
          if DataModel.Now_List.shopId == DataModel.redPointShopId and redPointInfo then
            local key = "BarStoreShopRedPoint|" .. DataModel.Now_List.shopId .. "|" .. row.id
            if TimeUtil:GetServerTimeStamp() >= PlayerData:GetPlayerPrefs("int", key) then
              local nodeName = RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Now_List.shopId .. "|" .. row.id
              RedpointTree:ChangeRedpointCnt(nodeName, -1)
              StoreDataModel:UpdateStoreRedState(DataModel.Now_List.shopId, row.id)
              local defaultConfig = PlayerData:GetFactoryData(99900001, "ConfigFactory")
              local h = tonumber(string.sub(defaultConfig.dailyRefreshTime, 1, 2))
              local m = tonumber(string.sub(defaultConfig.dailyRefreshTime, 4, 5))
              local s = tonumber(string.sub(defaultConfig.dailyRefreshTime, 7, 8))
              local nextRefreshTime = 0
              if redPointInfo == 1 then
                nextRefreshTime = TimeUtil:GetNextSpecialTimeStamp(h, m, s)
              elseif redPointInfo == 2 then
                nextRefreshTime = TimeUtil:GetNextWeekTime(1, h)
              elseif redPointInfo == 3 then
                nextRefreshTime = TimeUtil:GetNextMonthTime(1, h, m, s)
              end
              PlayerData:SetPlayerPrefs("int", key, nextRefreshTime)
              View.Group_Main.Btn_Store.Img_RedPoint:SetActive(0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity))
              View.Group_LocalStore.Group_StoreList.Group_Tab.Group_Headquarters.Img_RedPoint:SetActive(0 < RedpointTree:GetRedpointCnt(RedPointNodeStr.RedPointNodeStr.BarStoreShopCommodity .. "|" .. DataModel.Now_List.shopId))
            end
          end
        end
      end
    end
  end
  Controller:RefreshBatchMoney()
  View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
end

function Controller:ConfirmBatchBuy()
  if table.count(DataModel.batchList) == 0 then
    CommonTips.OpenTips(80609973)
    return
  end
  if PlayerData:GetGoodsById(11400001).num < DataModel.batchMoney then
    CommonTips.OpenTips(80600539)
    return
  end
  local batchBuyInfo = {}
  for idx, num in pairs(DataModel.batchList) do
    local row = DataModel.Now_List.shopList[idx]
    table.insert(batchBuyInfo, row.idx - 1 .. "_" .. row.id .. "_" .. num)
  end
  Net:SendProto("shop.buy_list", function(json)
    CommonTips.OpenShowItem(json.reward)
    DataModel.batchList = {}
    DataModel.batchMoney = 0
    DataModel.Now_List.server = PlayerData.ServerData.shops[tostring(DataModel.ShopId)]
    DataModel.RefreshShopDataDetail()
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:SetDataCount(table.count(DataModel.Now_List.shopList))
    View.Group_LocalStore.Group_StoreList.ScrollGrid_Commodity.grid.self:RefreshAllElement()
    Controller:RefreshBatchMoney()
    Controller:RefreshResource()
  end, DataModel.Now_List.shopId, table.concat(batchBuyInfo, ","))
end

return Controller
