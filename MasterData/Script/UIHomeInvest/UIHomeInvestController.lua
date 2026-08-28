local View = require("UIHomeInvest/UIHomeInvestView")
local DataModel = require("UIHomeInvest/UIHomeInvestDataModel")
local NPCDialog = require("Common/NPCDialog")
local MainUIDataModel = require("UIMainUI/UIMainUIDataModel")
local HomeTUDModel = require("UIHomeTradeUpgrade/UIHomeTradeUpgradeDataModel")
local HomeDrinkPanel = require("Common/HomeDrinkPanel")
local Controller = {}

local function GetDrinkPanelContext()
  return {
    View = View,
    DataModel = DataModel,
    Controller = Controller,
    mainGroup = View.Group_Main.Group_Btn,
    drinkGroup = View.Group_Main.Group_Drink,
    enableVideo = false,
    enableReplaceTip = true,
    drinkBuffUiPath = "UI/Home/BarStore/DrinkBuff",
    onReturnToMain = function()
      Controller:RefreshDrinkButtonShow()
    end
  }
end

function Controller:Init()
  View.self:PlayAnim("In")
  View.Group_Invest.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.Group_Main.Group_Drink.self:SetActive(false)
  View.Group_Main.Group_Btn.self:SetActive(true)
  View.Group_TishiWindow.self:SetActive(false)
  View.Img_BG:SetSprite(DataModel.BgPath)
  View.Img_BG:SetColor(DataModel.BgColor)
  local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
  DataModel.StationCA = stationCA
  View.Group_Main.Group_NpcInfo.Group_Dingwei.Txt_Station:SetText(stationCA.name)
  View.Group_Main.Group_Btn.Btn_BattleBoss.self:SetActive(stationCA.turntableId > -1)
  View.Group_Main.Group_Btn.Btn_shop.self:SetActive(stationCA.turnExchangeBuildId ~= nil and stationCA.turnExchangeBuildId > 0)
  Controller:SetNPC()
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  Controller:CheckQuestProcess()
  local investCfg = PlayerData:GetFactoryData("80305428")
  if investCfg and investCfg.investorRankList and 0 < #investCfg.investorRankList then
    View.Group_Main.Btn_Rank:SetActive(true)
  else
    View.Group_Main.Btn_Rank:SetActive(false)
  end
  local isWuLin = DataModel.GetCurrentCityIsWuLin()
  if isWuLin then
    UIManager:LoadSplitPrefab(View, "UI/HomeInvest/HomeInvest", "Group_GoodInvest")
    UIManager:LoadSplitPrefab(View, "UI/HomeInvest/HomeInvest", "Group_Goods")
    View.Group_Goods.self:SetActive(false)
    View.Group_GoodInvest.self:SetActive(false)
    View.Group_Main.Btn_Rank:SetActive(false)
    View.Group_Main.Group_Btn.Btn_Invest:SetActive(false)
    Controller:RefreshDrinkButtonShow()
    View.Group_Main.Group_Btn.Btn_GoodsOut:SetActive(true)
    View.Group_Main.Group_Btn.Btn_GoodsTag:SetActive(true)
    local isTaskFinish = DataModel.GetIsTaskFinish(81003287)
    View.Group_Main.Group_Btn.Btn_GoodsInvest:SetActive(isTaskFinish)
  else
    View.Group_Main.Group_Btn.Btn_GoodsOut:SetActive(false)
    View.Group_Main.Group_Btn.Btn_GoodsTag:SetActive(false)
    View.Group_Main.Group_Btn.Btn_Drink:SetActive(false)
    View.Group_Main.Group_Btn.Btn_Invest:SetActive(true)
  end
end

function Controller:OpenExchangeBuild()
  local buildingCA = PlayerData:GetFactoryData(DataModel.StationCA.turnExchangeBuildId, "BuildingFactory")
  if PlayerData:GetUserInfo().lv < (buildingCA.playerLevel or 0) then
    return
  end
  local storeList = buildingCA.exchangeStoreList
  local storeId, remainTime, isOpen
  for i = 1, #storeList do
    isOpen, remainTime = PlayerData:IsStoreOpen(storeList[i].id)
    if isOpen then
      storeId = storeList[i].id
      break
    end
  end
  if not isOpen then
    return
  end
  Net:SendProto("shop.info", function(json)
    UIManager:Open(buildingCA.uiPath, Json.encode({
      buildingId = DataModel.StationCA.turnExchangeBuildId,
      isCityMapIn = false,
      name = buildingCA.name,
      stationId = DataModel.StationId,
      bgPath = DataModel.BgPath,
      npcId = DataModel.NpcId,
      initMode = "Exchange"
    }))
    PlayerData:TryPlayPlotByParagraphID(buildingCA.firstPlotId)
  end, storeId)
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
  for k, v in pairs(DataModel.initParams) do
    t[k] = v
  end
  status.extraUIParamData = t
  params.status = status
  DataModel.CacheEventList = QuestProcess.CheckEventOpen(DataModel.BuildingId, params)
  local count = #DataModel.CacheEventList
  View.Group_Main.Group_Btn.Btn_Talk.Img_RedPoint:SetActive(0 < count)
  if 0 < count then
    QuestProcess.AddQuestCallBack(View.self.url, Controller.CheckQuestProcess)
    if count == 1 then
      local questCA = PlayerData:GetFactoryData(DataModel.CacheEventList[1].questId)
      View.Group_Main.Group_Btn.Btn_Talk.Txt_:SetText(questCA.name)
    else
      View.Group_Main.Group_Btn.Btn_Talk.Txt_:SetText(GetText(80602502))
    end
  else
    View.Group_Main.Group_Btn.Btn_Talk.Txt_:SetText(GetText(80602502))
  end
end

function Controller:ShowInvest()
  Net:SendProto("station.refresh", function(json)
    for k, v in pairs(json.stations) do
      for k1, v1 in pairs(v) do
        PlayerData:GetHomeInfo().stations[k][k1] = v1
      end
    end
    View.self:PlayAnim("InvestList")
    DataModel.serverStationData = PlayerData:GetHomeInfo().stations[tostring(DataModel.StationId)]
    DataModel.DevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.StationId)].dev_degree or 0
    if DataModel.serverStationData.invest == nil then
      DataModel.serverStationData.invest = {}
    end
    DataModel.TotalTZ = DataModel.GetTotalTZ()
    DataModel.InitData()
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.investText)
    View.Group_Main.self:SetActive(false)
    UIManager:LoadSplitPrefab(View, "UI/HomeInvest/HomeInvest", "Group_Invest")
    View.Group_Invest.self:SetActive(true)
    local stationCA = PlayerData:GetFactoryData(DataModel.StationId, "HomeStationFactory")
    View.Group_Invest.Group_Zhu.Group_Dingwei.Txt_Station:SetText(stationCA.name)
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetReputationElement(View.Group_Invest.Group_Zhu.Group_Reputation, DataModel.StationId)
    View.Group_Invest.Group_Ding.Img_BG.Group_TZZE.Txt_Tips:SetText(DataModel.TotalTZ)
    View.Group_Invest.ScrollGrid_Level.grid.self:SetDataCount(#DataModel.InvestList)
    View.Group_Invest.ScrollGrid_Level.grid.self:RefreshAllElement()
    Controller:RefreshResource()
  end, DataModel.StationId)
end

function Controller:ReturnToMain()
  View.self:PlayAnim("Main")
  View.Group_Invest.self:SetActive(false)
  View.Group_Main.self:SetActive(true)
  View.Group_Main.Group_Drink.self:SetActive(false)
  Controller:ShowNPCTalk(DataModel.NPCDialogEnum.enterText)
  View.Group_Goods.self:SetActive(false)
  View.Group_GoodInvest.self:SetActive(false)
end

function Controller:OpenDrink()
  HomeDrinkPanel.OpenDrink(GetDrinkPanelContext())
end

function Controller:RefreshDrinkButtonShow()
  if not DataModel.GetCurrentCityIsWuLin() then
    View.Group_Main.Group_Btn.Btn_Drink:SetActive(false)
    return
  end
  View.Group_Main.Group_Btn.Btn_Drink:SetActive(not HomeDrinkPanel.IsDrinkCountExhausted())
end

function Controller:DrinkReturnToMain()
  HomeDrinkPanel.DrinkReturnToMain(GetDrinkPanelContext())
end

function Controller:CheckTimeDrinkCountRefresh()
  return HomeDrinkPanel.CheckTimeDrinkCountRefresh()
end

function Controller:RefreshDrinkInfo()
  HomeDrinkPanel.RefreshDrinkInfo(GetDrinkPanelContext())
end

function Controller:RefreshDrinkElement(element, elementIndex)
  HomeDrinkPanel.RefreshDrinkElement(GetDrinkPanelContext(), element, elementIndex)
end

function Controller:Drink(idx)
  HomeDrinkPanel.Drink(GetDrinkPanelContext(), idx)
end

function Controller:ConfirmDrink()
  HomeDrinkPanel.ConfirmDrink(GetDrinkPanelContext())
end

function Controller:ConfirmReplaceBuff()
  HomeDrinkPanel.ConfirmReplaceBuff(GetDrinkPanelContext())
end

function Controller:DoInvest(idx)
  local info = DataModel.InvestList[idx]
  local costInfo = info.costList[1]
  if PlayerData:GetGoodsById(costInfo.id).num < costInfo.num then
    Controller:ShowNPCTalk(DataModel.NPCDialogEnum.ItemText)
    return
  end
  Net:SendProto("station.invest", function(json)
    if PlayerData.TempCache.repLvUpCache ~= nil then
      DataModel.CurRepLv = PlayerData.TempCache.repLvUpCache.repLv
    end
    CommonTips.OpenShowItem(json.reward, function()
      CommonTips.OpenRepLvUp()
    end)
    DataModel.InvestList[idx].remainNum = DataModel.InvestList[idx].remainNum - 1
    DataModel.AllNoInvest = false
    DataModel.DevDegree = PlayerData:GetHomeInfo().dev_degree[tostring(DataModel.StationId)].dev_degree or 0
    local enum = DataModel.NPCDialogEnum.investOneText
    if costInfo.num >= 1000000 then
      enum = DataModel.NPCDialogEnum.investSixText
    elseif costInfo.num >= 500000 then
      enum = DataModel.NPCDialogEnum.investFiveText
    elseif costInfo.num >= 400000 then
      enum = DataModel.NPCDialogEnum.investFourText
    elseif costInfo.num >= 300000 then
      enum = DataModel.NPCDialogEnum.investThreeText
    elseif costInfo.num >= 200000 then
      enum = DataModel.NPCDialogEnum.investTwoText
    elseif costInfo.num >= 100000 then
      enum = DataModel.NPCDialogEnum.investOneText
    end
    Controller:ShowNPCTalk(enum)
    local serverDetail = DataModel.serverStationData.invest[tostring(idx - 1)]
    if serverDetail == nil then
      serverDetail = {}
      serverDetail.cost = 0
      serverDetail.cnt = 0
      DataModel.serverStationData.invest[tostring(idx - 1)] = serverDetail
    end
    serverDetail.cost = serverDetail.cost + costInfo.num
    serverDetail.cnt = serverDetail.cnt + 1
    DataModel.TotalTZ = DataModel.GetTotalTZ()
    local needSort = false
    for _, v in ipairs(DataModel.TradePermissionGoods) do
      if not v.checkNeedItemNum then
        v.checkNeedItemNum = DataModel.TotalTZ >= v.needItemNum
        if v.checkNeedItemNum then
          v.unLock = v.checkNeedItemNum and v.checkDevelopNum
          needSort = true
        end
      end
    end
    if needSort then
      DataModel.SortTradePermissionGoods()
    end
    Controller:RefreshResource()
    View.Group_Invest.Group_Ding.Img_BG.Group_TZZE.Txt_Tips:SetText(DataModel.TotalTZ)
    View.Group_Invest.ScrollGrid_Level.grid.self:RefreshAllElement()
    local homeCommon = require("Common/HomeCommon")
    homeCommon.SetReputationElement(View.Group_Invest.Group_Zhu.Group_Reputation, DataModel.StationId)
  end, idx - 1)
end

function Controller:ItemUseRefresh()
  local homeConfig = PlayerData:GetFactoryData(99900014, "ConfigFactory")
  local info = homeConfig.investMoneyList[1]
  local t = {}
  t.itemId = info.id
  t.useNum = info.num
  t.itemNum = PlayerData:GetGoodsById(info.id).num
  local itemCA = PlayerData:GetFactoryData(t.itemId, "ItemFactory")
  CommonTips.OnItemPrompt(string.format(GetText(80600688), itemCA.name), t, function()
    if t.itemNum < t.useNum then
      CommonTips.OpenTips(80600488)
      return
    end
    if DataModel.AllNoInvest then
      CommonTips.OpenTips(80600689)
      return
    end
    Net:SendProto("station.refresh_invest", function(json)
      local t = {}
      t[info.id] = info.num
      PlayerData:RefreshUseItems(t)
      for k, v in pairs(DataModel.InvestList) do
        v.remainNum = v.limitNum
      end
      for k, v in pairs(DataModel.serverStationData.invest) do
        v.cnt = 0
      end
      View.Group_Invest.ScrollGrid_Level.grid.self:RefreshAllElement()
    end)
  end)
end

function Controller:RefreshResource()
  View.Group_Invest.Group_Ding.Btn_YN.Txt_Num:SetText(PlayerData:GetGoodsById(11400001).num)
  View.Group_Invest.Group_Ding.Group_FZ.Group_.Txt_Tips:SetText(string.format("%.0f", DataModel.DevDegree))
end

function Controller:ShowTradePermission()
  View.Group_Invest.Group_XK.self:SetActive(true)
  View.Group_Invest.Group_XK.ScrollGrid_List.grid.self:SetDataCount(#DataModel.TradePermissionGoods)
  View.Group_Invest.Group_XK.ScrollGrid_List.grid.self:RefreshAllElement()
end

function Controller:SetNPC()
  NPCDialog.SetNPC(View.Group_NPC, DataModel.NpcId)
  local HomeCommon = require("Common/HomeCommon")
  local repLv = HomeCommon.GetRepLv(DataModel.StationId)
  NPCDialog.HandleNPCTxtTable({repLv = repLv})
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
  if textTable == nil then
    return
  end
  NPCDialog.SetNPCText(View.Group_NPC, textTable, dialogEnum)
end

function Controller:RefreshXKElement(element, elementIndex)
  local info = DataModel.TradePermissionGoods[elementIndex]
  local btnItem = require("Common/BtnItem")
  btnItem:SetItem(element.Group_Item, {
    id = info.goodsId
  })
  element.Group_Item.Btn_Item:SetClickParam(info.goodsId)
  element.Img_Specialty:SetActive(info.isSpecial)
  local isTZUnLock = info.needItemNum <= DataModel.TotalTZ
  local isUnlock = isTZUnLock and info.checkDevelopNum
  element.Group_Unlock.self:SetActive(isUnlock)
  element.Group_lock.self:SetActive(not isUnlock)
  local showElement
  if isUnlock then
    showElement = element.Group_Unlock
  else
    showElement = element.Group_lock
    showElement.Group_Invest.Img_OK:SetActive(isTZUnLock)
    showElement.Group_DEV.Img_OK:SetActive(info.checkDevelopNum)
  end
  showElement.Group_Invest.Txt_Cost:SetText(info.needItemNumThousands)
  showElement.Group_DEV.Txt_Cost:SetText(info.needDevelopNumThousands)
  showElement.Group_DEV.Txt_Title:SetText(string.format(GetText(80609211), info.stationName))
  showElement.Txt_Huode:SetText(string.format(GetText(80600707), info.name))
end

function Controller:OnGoodsOutBtnClick()
  View.self:PlayAnim("GoodsInvest")
  View.Group_GoodInvest:SetActive(false)
  View.Group_Goods:SetActive(true)
  View.Group_Goods.Group_Tag:SetActive(false)
  View.Group_Goods.Group_Out:SetActive(true)
  View.Group_Main.self:SetActive(false)
  View.Group_Goods.Btn_Change.Txt_:SetText(GetText(80612242))
  local isAllQuestFinished = DataModel.GetWuLinTaskIsAllFinished()
  local curQuestIndex, curQuestId, curTax, nextTax = DataModel.GetCurrentDoingTaskInfo()
  local questCA = PlayerData:GetFactoryData(curQuestId, "QuestFactory")
  local questRatio = 0
  local curValue = 0
  local maxValue = 1
  if questCA then
    maxValue = questCA.num or 1
    View.Group_Goods.Group_Out.Group_Quest.Img_.Txt_:SetText(tostring(questCA.story))
  end
  
  local function refreshQuestProgress()
    View.Group_Goods.Group_Out.Group_Progress.Group_Txt.Txt_:SetText(tostring(curValue) .. "/" .. tostring(maxValue))
    questRatio = curValue / maxValue
    View.Group_Goods.Group_Out.Group_Progress.Img_pro:SetFilledImgAmount(questRatio)
  end
  
  local function refreshOutPartShow()
    if isAllQuestFinished then
      View.Group_Goods.Group_Out.Group_level.Group_Max:SetActive(true)
      View.Group_Goods.Group_Out.Group_Tax.Group_max:SetActive(true)
      View.Group_Goods.Group_Out.Group_Quest.Group_Max:SetActive(true)
      View.Group_Goods.Group_Out.Group_Tax.Txt_nexttitle:SetActive(false)
      View.Group_Goods.Group_Out.Group_Tax.Txt_next:SetActive(false)
      local maxQuestCount = DataModel.GetWuLinTaskMaxCount() or 1
      View.Group_Goods.Group_Out.Group_level.Group_Max.Txt_level:SetText(tostring(maxQuestCount))
      curValue = maxValue
      View.Group_Goods.Group_Out.Group_Tax.Group_max.Txt_now:SetText(string.format(GetText(80612302), tostring(curTax * 100) .. "%"))
      refreshQuestProgress()
    else
      View.Group_Goods.Group_Out.Group_level.Group_Max:SetActive(false)
      View.Group_Goods.Group_Out.Group_Tax.Group_max:SetActive(false)
      View.Group_Goods.Group_Out.Group_Quest.Group_Max:SetActive(false)
      View.Group_Goods.Group_Out.Group_Tax.Txt_nexttitle:SetActive(true)
      View.Group_Goods.Group_Out.Group_Tax.Txt_next:SetActive(true)
      View.Group_Goods.Group_Out.Group_Tax.Txt_now:SetText(string.format(GetText(80612302), tostring(curTax * 100) .. "%"))
      View.Group_Goods.Group_Out.Group_Tax.Txt_next:SetText(string.format(GetText(80612302), tostring(nextTax * 100) .. "%"))
      curValue = DataModel.GetQuestFinishCount(curQuestId)
      refreshQuestProgress()
    end
  end
  
  Net:SendProto("quest.list", function(json)
    if json and string.nilorempty(json.rc) then
      local stationQuests = json.station_quests or {}
      DataModel.AllStationQuests = stationQuests
      refreshOutPartShow()
    end
  end, 8, tostring(DataModel.StationId))
  View.Group_Goods.Group_Out.Group_level.Txt_level:SetText(tostring(curQuestIndex))
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return
  end
  local sellList = stationCa.sellList or {}
  View.Group_Goods.Group_Out.Group_Quest.ScrollGrid_.grid.self:SetDataCount(#sellList)
  View.Group_Goods.Group_Out.Group_Quest.ScrollGrid_.grid.self:RefreshAllElement()
end

function Controller:RefreshGoodsQuestElementShow(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  local stationCa = DataModel.GetCurrentStayCityConfig()
  if not stationCa then
    return
  end
  local sellList = stationCa.sellList or {}
  local goodInfo = sellList[elementIndex]
  if not goodInfo then
    return
  end
  local goodQuaCa = PlayerData:GetFactoryData(goodInfo.id, "HomeGoodsQuotationFactory")
  if not goodQuaCa then
    return
  end
  local goodCa = PlayerData:GetFactoryData(goodQuaCa.goodsId, "HomeGoodsFactory")
  if not goodCa then
    return
  end
  element.Group_change.Txt_:SetText(goodCa.name)
  element.Group_change.Group_Item.Img_Item:SetSprite(goodCa.tipsPath)
  element.Group_change.Group_Item.Btn_Item:SetClickFunction(function()
    CommonTips.OpenGoodsTips(goodCa.id, 1)
  end)
  element.Group_change.self:SetAnchoredPositionY(elementIndex % 2 == 0 and -20 or 0)
end

function Controller:OnGoodsTagBtnClick()
  View.self:PlayAnim("GoodsInvest")
  DataModel.InitGoodsTagConfig()
  View.Group_GoodInvest:SetActive(false)
  View.Group_Goods:SetActive(true)
  View.Group_Goods.Group_Tag:SetActive(true)
  View.Group_Goods.Group_Out:SetActive(false)
  View.Group_Main.self:SetActive(false)
  View.Group_Goods.Btn_Change.Txt_:SetText(GetText(80612238))
  local isAllQuestFinished = DataModel.GetIsGoodsTagAllQuestFinished()
  if isAllQuestFinished then
    View.Group_Goods.Group_Tag.Group_level.Group_Max:SetActive(true)
    local maxCount = DataModel.GetGoodsTagQuestMaxFinishCount() or 0
    View.Group_Goods.Group_Tag.Group_level.Group_Max.Txt_level:SetText(tostring(maxCount))
  else
    View.Group_Goods.Group_Tag.Group_level.Group_Max:SetActive(false)
    local finishQuestCount = DataModel.GetGoodsTagQuestFinishCount() or 0
    View.Group_Goods.Group_Tag.Group_level.Txt_level:SetText(tostring(finishQuestCount))
  end
  
  local function refreshTagItemShow(tagItem, listId, tagId)
    if not tagItem then
      return
    end
    if not listId or not tagId then
      return
    end
    local tagCa = PlayerData:GetFactoryData(tagId, "TagFactory")
    if not tagCa then
      return
    end
    tagItem.Txt_:SetText(tagCa.typeName)
    local finishCount = DataModel.GetTagQuestFinishedProgressByTagId(tagId)
    tagItem.Txt_Num:SetText(tostring(PlayerData:GetPreciseDecimalFloor(finishCount * 100)) .. "%")
  end
  
  refreshTagItemShow(View.Group_Goods.Group_Tag.Group_Goods.Group_Food, DataModel.WuLinGoodTagsList[1].listId, DataModel.WuLinGoodTagsList[1].tagId)
  refreshTagItemShow(View.Group_Goods.Group_Tag.Group_Goods.Group_Make, DataModel.WuLinGoodTagsList[2].listId, DataModel.WuLinGoodTagsList[2].tagId)
  refreshTagItemShow(View.Group_Goods.Group_Tag.Group_Goods.Group_Cloth, DataModel.WuLinGoodTagsList[3].listId, DataModel.WuLinGoodTagsList[3].tagId)
  refreshTagItemShow(View.Group_Goods.Group_Tag.Group_Goods.Group_Like, DataModel.WuLinGoodTagsList[4].listId, DataModel.WuLinGoodTagsList[4].tagId)
  refreshTagItemShow(View.Group_Goods.Group_Tag.Group_Goods.Group_Machine, DataModel.WuLinGoodTagsList[5].listId, DataModel.WuLinGoodTagsList[5].tagId)
  
  local function refreshTagItemsGridShow()
    DataModel.WuLinShowGoodTagQuestList = DataModel.WuLinShowGoodTagQuestList or {}
    View.Group_Goods.Group_Tag.ScrollGrid_item.grid.self:SetDataCount(#DataModel.WuLinShowGoodTagQuestList)
    View.Group_Goods.Group_Tag.ScrollGrid_item.grid.self:RefreshAllElement()
  end
  
  Net:SendProto("quest.list", function(json)
    if json and string.nilorempty(json.rc) then
      local stationQuests = json.station_quests or {}
      DataModel.AllStationQuests = stationQuests
      refreshTagItemsGridShow()
    end
  end, 7, tostring(DataModel.StationId))
end

function Controller:RefreshTagQuestElementShow(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  DataModel.WuLinShowGoodTagQuestList = DataModel.WuLinShowGoodTagQuestList or {}
  local info = DataModel.WuLinShowGoodTagQuestList[elementIndex]
  if not info then
    return
  end
  if info.questCa then
    element.Txt_Quest:SetText(tostring(info.questCa.name))
    local finishCount = DataModel.GetQuestFinishCount(info.questCa.id) or 0
    local allCount = info.questCa.num or 1
    local ratio = finishCount / allCount
    element.Group_Progress.Img_Progress:SetFilledImgAmount(ratio)
    local isFinish = finishCount >= allCount
    if isFinish then
      element.Group_Progress.Img_Max:SetActive(true)
      element.Group_Progress.Txt_:SetActive(false)
    else
      element.Group_Progress.Img_Max:SetActive(false)
      element.Group_Progress.Txt_:SetActive(true)
      element.Group_Progress.Txt_:SetText(tostring(PlayerData:GetPreciseDecimalFloor(ratio * 100, 1) .. "%"))
    end
  end
  if info.nextQuestCa then
    element.Img_:SetActive(true)
    element.Txt_Award:SetActive(true)
    element.Txt_Award:SetText(tostring(info.nextQuestCa.story))
  else
    element.Img_:SetActive(false)
    element.Txt_Award:SetActive(false)
  end
  if info.tagCa then
    element.Btn_.Group_Item.Img_Item:SetSprite(info.tagCa.icon or "")
  end
  
  local function showGoodsListPanel(goodListId)
    local listCa = PlayerData:GetFactoryData(goodListId, "ListFactory")
    if not listCa then
      return
    end
    DataModel.CurTagGoodListId = goodListId
    View.Group_Goods.Group_Goods:SetActive(true)
    if info.tagCa then
      View.Group_Goods.Group_Goods.Img_bg.Txt_:SetText(string.format(GetText(80612294), info.tagCa.typeName or ""))
    end
    local rewardList = listCa.rewardList or {}
    View.Group_Goods.Group_Goods.ScrollGrid_Good.grid.self:SetDataCount(#rewardList)
    View.Group_Goods.Group_Goods.ScrollGrid_Good.grid.self:RefreshAllElement()
  end
  
  element.Btn_:SetClickFunction(function()
    showGoodsListPanel(info.goodListId)
  end)
end

function Controller:RefreshTagGoodListElementShow(element, elementIndex)
  if not element or not elementIndex then
    return
  end
  local listCa = PlayerData:GetFactoryData(DataModel.CurTagGoodListId, "ListFactory")
  if not listCa then
    return
  end
  local rewardList = listCa.rewardList or {}
  local info = rewardList[elementIndex]
  if not info then
    return
  end
  local goodCa = PlayerData:GetFactoryData(info.id, "HomeGoodsFactory")
  if not goodCa then
    return
  end
  element.Group_Item.Img_Item:SetSprite(goodCa.imagePath)
  element.Group_Item.Btn_Item:SetClickFunction(function()
    CommonTips.OpenGoodsTips(goodCa.id, 1)
  end)
end

function Controller:RefreshGoodsInvestPartShow()
  DataModel.InitWuLinGoodsInvestConfig()
  DataModel.InitWuLinAllGoodsInvestMoneyCount()
  local goldNum, goldIcon = MainUIDataModel.GetCityGoldCountAndIcon()
  View.Group_GoodInvest.Group_Ding.Btn_YN.Img_Icon:SetSprite(goldIcon or "")
  View.Group_GoodInvest.Group_Ding.Btn_YN.Txt_Num:SetText(tostring(goldNum))
  local allInvestMoneyCount = DataModel.WuLinInvestGoodsAllCount or 0
  View.Group_GoodInvest.Group_Title.Txt_Num:SetText(tostring(allInvestMoneyCount))
  local goodsProtoInfoDic = {}
  local questTagBuff = {}
  local sidTotalInvestMoney = {}
  local idStr = ""
  for i = 1, #DataModel.WuLinInvestGoodsList do
    local goodInfo = DataModel.WuLinInvestGoodsList[i]
    if goodInfo and goodInfo.goodQuaCa then
      idStr = idStr .. tostring(goodInfo.goodQuaCa.id) .. ","
    end
  end
  
  local function refreshGoodElements()
    local stationCa = DataModel.GetCurrentStayCityConfig()
    
    local function refreshGoodInvestItem(index)
      local element = index == 1 and View.Group_GoodInvest.Group_Good1 or View.Group_GoodInvest.Group_Good2
      if not element then
        return
      end
      DataModel.WuLinInvestGoodsList = DataModel.WuLinInvestGoodsList or {}
      local goodInfo = DataModel.WuLinInvestGoodsList[index]
      if not (goodInfo and goodInfo.goodCa) or not goodInfo.goodQuaCa then
        return
      end
      local costCount = 0
      element.Txt_:SetText(goodInfo.goodCa.name)
      element.Group_Item.Img_Item:SetSprite(goodInfo.goodCa.tipsPath)
      
      local function refreshInvestCostShow(questCA)
        if not questCA then
          return
        end
        local requireItemList = questCA.requireItemList or {}
        local reInfo = requireItemList[1] or {}
        costCount = reInfo.num or 0
        element.Group_Invert.Btn_Invert.Group_.Txt_Num:SetText(costCount)
      end
      
      local questId = 0
      local questIndex = 1
      if goodInfo.isUnlock then
        local curQuestCa, addNum, quest_index = DataModel.GetCurGoodInvestQuestByIndex(index)
        questIndex = quest_index
        if not curQuestCa then
          element.Group_Max:SetActive(true)
          element.Group_Invert:SetActive(false)
        else
          element.Group_Max:SetActive(false)
          element.Group_Invert:SetActive(true)
          element.Group_Invert.Txt_Inverttip:SetText(GetText(index == 1 and 80612298 or 80612300))
          element.Group_Invert.Txt_Invert:SetText(string.format(GetText(80612301), tostring(addNum or 0)))
          questId = curQuestCa.id
          refreshInvestCostShow(curQuestCa)
        end
      else
        element.Group_Max:SetActive(false)
        element.Group_Invert:SetActive(true)
        element.Group_Invert.Txt_Inverttip:SetText(GetText(index == 1 and 80612297 or 80612299))
        if stationCa then
          element.Group_Invert.Txt_Invert:SetText(string.format(GetText(80612296), tostring(stationCa.name), goodInfo.goodCa.name or ""))
        end
        local unlockQuestCa = PlayerData:GetFactoryData(goodInfo.goodQuaCa.unlockedQuest, "QuestFactory")
        questId = goodInfo.goodQuaCa.unlockedQuest
        refreshInvestCostShow(unlockQuestCa)
      end
      element.Group_Item.Btn_Item:SetClickFunction(function()
        CommonTips.OpenGoodsTips(goodInfo.goodCa.id, 1)
      end)
      local goodProtoInfo = goodsProtoInfoDic[tostring(goodInfo.goodQuaCa.id)]
      if goodProtoInfo then
        local buy_Percent = goodProtoInfo.buy_percent or 0
        local ext_Num = goodProtoInfo.ext_num or 0
        local tag_Buff = questTagBuff[tostring(goodInfo.goodCa.goodsType)] or 0
        local moneyId = DataModel.GetStationCurrency(DataModel.StationId)
        sidTotalInvestMoney = sidTotalInvestMoney or {}
        local moneyInvest = sidTotalInvestMoney[tostring(moneyId)] or 0
        local moneyRate = DataModel.GetMoneyBuffRate(moneyInvest) or 0
        local curLvAddNum = DataModel.GetGoodComeNumByOffsetLv(0, buy_Percent, ext_Num, goodInfo.goodQuaCa, goodInfo.goodCa, tag_Buff, moneyRate) or 0
        element.Txt_Num:SetText(tostring(HomeTUDModel.GetRoundNum(curLvAddNum)))
      end
      element.Group_Invert.Btn_Invert:SetClickFunction(function()
        if 0 < questId then
          if goldNum < costCount then
            CommonTips.OpenTips(80600539)
          else
            Net:SendProto("quest.complete_quest", function(json)
              if json and string.nilorempty(json.rc) then
                local enum = DataModel.NPCDialogEnum.investOneText
                if 5 <= questIndex then
                  enum = DataModel.NPCDialogEnum.investFiveText
                elseif questIndex == 4 then
                  enum = DataModel.NPCDialogEnum.investFourText
                elseif questIndex == 3 then
                  enum = DataModel.NPCDialogEnum.investThreeText
                elseif questIndex == 2 then
                  enum = DataModel.NPCDialogEnum.investTwoText
                elseif questIndex == 1 then
                  enum = DataModel.NPCDialogEnum.investOneText
                end
                Controller:ShowNPCTalk(enum)
                if json.current_quests ~= nil then
                  for k, v in pairs(json.current_quests) do
                    local questCA = PlayerData:GetFactoryData(k, "QuestFactory")
                    local serverKey = ""
                    if questCA.questType == "Main" then
                      serverKey = "mq_quests"
                    elseif questCA.questType == "Side" then
                      serverKey = "branch_quests"
                    end
                    if serverKey ~= "" then
                      PlayerData.ServerData.quests[serverKey][k] = v
                    end
                  end
                end
                local costItem = {}
                costItem[DataModel.StationCA.currency] = costCount
                PlayerData:RefreshUseItems(costItem)
                Controller:RefreshGoodsInvestPartShow()
              end
            end, questId)
          end
        end
      end)
    end
    
    refreshGoodInvestItem(1)
    refreshGoodInvestItem(2)
  end
  
  if not string.nilorempty(idStr) then
    Net:SendProto("station.query_goods", function(json)
      if json and string.nilorempty(json.rc) then
        goodsProtoInfoDic = json.goods_bf or {}
        questTagBuff = json.quest_tag_bf or {}
        sidTotalInvestMoney = json.currency_funds or {}
        refreshGoodElements()
      end
    end, DataModel.StationId, idStr)
  end
end

function Controller:OnGoodsInvestBtnClick()
  View.Group_GoodInvest:SetActive(true)
  View.Group_Goods:SetActive(false)
  View.Group_Main.self:SetActive(false)
  View.self:PlayAnim("GoodsInvest")
  Controller:RefreshGoodsInvestPartShow()
end

function Controller:OnGoodsChangeBtnClick()
  if not View.Group_Goods.self then
    return
  end
  if View.Group_Goods.Group_Out.self.IsActive then
    Controller:OnGoodsTagBtnClick()
  elseif View.Group_Goods.Group_Tag.self.IsActive then
    Controller:OnGoodsOutBtnClick()
  end
end

return Controller
