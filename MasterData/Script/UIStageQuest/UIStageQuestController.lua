local CommonItem = require("Common/BtnItem")
local View = require("UIStageQuest/UIStageQuestView")
local DataModel = require("UIStageQuest/UIStageQuestDataModel")
local CommonItem = require("Common/BtnItem")
local ActivitySafeDataModel = require("UIActivitySafe/UIActivitySafeDataModel")
local FastBattleDataModel = require("UIFastBattle/UIFastBattleDataModel")
local Controller = {}

function Controller:Init()
  Controller:ClickTopTitle()
end

local function showPage()
  View.Btn_Daily.Group_Off.self:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Daily)
  View.Btn_Stage.Group_Off.self:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Stage)
  View.Btn_Battle.Group_Off.self:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Battle)
  View.Btn_Order.Group_Off.self:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Order)
  View.Btn_Daily.Group_On.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Daily)
  View.Btn_Stage.Group_On.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Stage)
  View.Btn_Battle.Group_On.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Battle)
  View.Btn_Order.Group_On.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Order)
  View.Group_Daily.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Daily)
  View.Group_Stage.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Stage)
  View.Group_Battle.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Battle)
  View.Group_Order.self:SetActive(DataModel.TitleChoose == DataModel.TitleType.Order)
  View.Btn_Daily.Group_Off.Img_Red:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Daily and DataModel:GetRedPoint(nil, DataModel.TitleType.Daily))
  View.Btn_Stage.Group_Off.Img_Red:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Stage and DataModel:GetRedPoint(nil, DataModel.TitleType.Stage))
  View.Btn_Battle.Group_Off.Img_Red:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Battle and DataModel:GetRedPoint(nil, DataModel.TitleType.Battle))
  View.Btn_Order.Group_Off.Img_Red:SetActive(DataModel.TitleChoose ~= DataModel.TitleType.Order and DataModel:GetRedPoint(nil, DataModel.TitleType.Order))
end

function Controller:OpenDaily()
  local function callback()
    showPage()
    
    Controller:RefreshDailyPage()
  end
  
  if DataModel.IsRefreshDaily then
    Net:SendProto("quest.list", function(json)
      if PlayerData.ServerData.items["11400013"] then
        PlayerData.ServerData.items["11400013"].num = 0
      end
      if json.quests.activity_day_quests then
        PlayerData.ServerData.quests.activity_day_quests = json.quests.activity_day_quests
      end
      PlayerData.ServerData.liveness_rewards = json.liveness_rewards
      DataModel.DailyInit()
      callback()
      DataModel.IsRefreshDaily = false
    end, EnumDefine.QuestListDefine.BattlePassQuest)
  else
    callback()
  end
end

function Controller:OpenStage()
  local function callback()
    showPage()
    
    for k, v in pairs(DataModel.TopList) do
      local obj = "Group_" .. k
      View.Group_Stage[obj].self:SetActive(false)
    end
    View.Group_Stage.Group_Btn.StaticGrid_TopList.grid.self:RefreshAllElement()
    Controller:ClickTopBtn(DataModel.TopIndex or 1, true)
    local UIActivityMainDataModel = require("UIActivityMain/UIActivityMainDataModel")
    View.Group_Stage.Btn_LevelReward.Img_RedPoint:SetActive(UIActivityMainDataModel.GetLevelRewardRedPoint())
  end
  
  if DataModel.IsRefreshSatage then
    Net:SendProto("quest.stage_quests", function(json)
      DataModel.StageInit()
      callback()
      DataModel.IsRefreshSatage = false
    end)
  else
    callback()
  end
end

function Controller:OpenBattle()
  local function callback()
    showPage()
    
    PlayerData:SetPlayerPrefs("int", "BattleInfoTimeStamp", TimeUtil:GetServerTimeStamp())
    View.Group_Battle.Group_Left.ScrollGrid_Left.grid.self:SetDataCount(#DataModel.BattleList)
    View.Group_Battle.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
    View.Group_Battle.Group_Left.ScrollGrid_Left.grid.self:MoveToTop()
    Controller:ClickBattleLeftList(DataModel.BattleLeftIndex)
    Controller:RefreshSafeBtnShow()
  end
  
  if DataModel.IsRefreshBattle then
    Net:SendProto("battle.chapter_level", function(json)
      DataModel.BattleInit()
      callback()
      DataModel.IsRefreshBattle = false
    end)
  else
    callback()
  end
end

function Controller:OpenOrder()
  if DataModel.IsRefreshOrder then
    Net:SendProto("future.main", function(json)
      if json.future_base_info then
        PlayerData.ServerData.user_info.future_base_info = json.future_base_info
      end
      if json.join_my_orders then
        PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
      end
      if json.join_other_orders then
        PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
      end
      if json.all_user_future_activity then
        PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
      end
      View.Group_Order.Group_Left.Group_OrderOption.Group_OptionSpecial:SetActive(table.count(json.all_user_future_activity) > 0)
      Controller:RefreshOrderPanel(true)
      DataModel.IsRefreshOrder = false
    end)
  end
end

function Controller:ClickTopTitle()
  DataModel.IsRefreshDaily = DataModel.GetRefreshDaily()
  if DataModel.TitleChoose == DataModel.TitleType.Daily then
    Controller:OpenDaily()
  end
  if DataModel.TitleChoose == DataModel.TitleType.Stage then
    Controller:OpenStage()
  end
  if DataModel.TitleChoose == DataModel.TitleType.Battle then
    DataModel.IsRefreshBattle = DataModel.GetRefreshBattle()
    if DataModel.IsBattleReturnRefresh then
      DataModel.IsRefreshBattle = true
    end
    Controller:OpenBattle()
  end
  if DataModel.TitleChoose == DataModel.TitleType.Order then
    DataModel.IsRefreshOrder = true
    Controller:OpenOrder()
  end
end

function Controller:RefreshDailyPage()
  local dailyVitality = PlayerData:GetDailyVitality()
  View.Group_Daily.Group_Activity.Txt_Num:SetText(dailyVitality)
  View.Group_Daily.Group_Activity.Group_Progress.StaticGrid_Reward.grid.self:RefreshAllElement()
  local fill = dailyVitality / DataModel.MaxApNum
  fill = 1 < fill and 1 or fill
  View.Group_Daily.Group_Activity.Group_Progress.Img_Bar:SetFilledImgAmount(fill)
  View.Group_Daily.ScrollGrid_Quest.grid.self:SetDataCount(#DataModel.DailyQuestList)
  View.Group_Daily.ScrollGrid_Quest.grid.self:RefreshAllElement()
  View.Group_Daily.ScrollGrid_Quest.grid.self:MoveToTop()
end

function Controller:DailyRewardShow(index)
  if DataModel.RewardShowIndex and DataModel.RewardShowIndex ~= index then
    View.Group_Daily.Group_Activity.Group_Progress.StaticGrid_Reward.grid[tonumber(DataModel.RewardShowIndex)].Group_Show:SetActive(false)
  end
  local Group_Show = View.Group_Daily.Group_Activity.Group_Progress.StaticGrid_Reward.grid[tonumber(index)].Group_Show
  Group_Show:SetActive(not Group_Show.IsActive)
  DataModel.RewardShowIndex = index
  if Group_Show.IsActive == true then
    CommonItem:SetItem(Group_Show.Group_Item, DataModel.ApRewardList[index])
  end
end

function Controller:ClickDailyReward(index)
  local row = DataModel.ApRewardList[index]
  if row.state == DataModel.DailyStateE.lock or row.state == DataModel.DailyStateE.receive then
    Controller:DailyRewardShow(index)
  else
    Net:SendProto("item.recv_liveness_rewards", function(json)
      CommonTips.OpenShowItem(json.reward)
      if PlayerData.ServerData.liveness_rewards == nil then
        PlayerData.ServerData.liveness_rewards = {}
      end
      DataModel.UpdateApRewardList()
      Controller:RefreshDailyPage()
    end, 0, 1)
  end
end

function Controller:DailyQuestGet()
  local finishCount = 0
  local ap = 0
  local finishList = {}
  for k, v in pairs(DataModel.DailyQuestList) do
    if v.type == EnumDefine.EQuestState.Finish then
      finishCount = finishCount + 1
      ap = ap + v.ap
      table.insert(finishList, v.id)
    end
  end
  if 0 < finishCount then
    Net:SendProto("quest.rec_all_daily_quests", function(json)
      View.Group_Success.self:SetActive(true)
      View.Group_Success.Txt_Title:SetText(string.format(GetText(80609814), ap))
      View.self:SelectPlayAnim(View.Group_Success.self, "Success", function()
        View.Group_Success.self:SetActive(false)
      end)
      for k, v in pairs(finishList) do
        PlayerData:GetActivityDaily()[tostring(v)].recv = TimeUtil:GetServerTimeStamp()
        GuideManager:CompleteQuestCallBack({
          [1] = v
        })
        QuestTrace.CompleteQuestOne(v)
      end
      DataModel:DailyInit()
      Controller:RefreshDailyPage()
    end)
  end
end

function Controller:SetTopGridElelment(element, elementIndex)
  local row = DataModel.TopList[elementIndex]
  element:SetActive(false)
  if row == nil then
    return
  end
  element:SetActive(true)
  element.Btn_Item:SetClickParam(elementIndex)
  element.Btn_Item.Group_Off:SetActive(DataModel.TopIndex ~= elementIndex)
  element.Btn_Item.Group_On:SetActive(DataModel.TopIndex == elementIndex)
  element.Btn_Item.Group_Off.Txt_T:SetText(row.text)
  element.Btn_Item.Group_On.Txt_T:SetText(row.text)
  element.Btn_Item.Group_Off.Img_Red:SetActive(row.isHaveRed)
end

function Controller:ClickTopBtn(index, isRefesh)
  if index == DataModel.TopIndex and isRefesh == nil then
    return
  end
  if DataModel.TopList[index] then
    local stageQuestList = DataModel.TopList[index].config.stageQuestList
    if PlayerData:GetStageQuest()[tostring(stageQuestList[1].id)] == nil then
      CommonTips.OpenTips(string.format(GetText(80608884), DataModel.TopList[index].level))
      return
    end
  end
  if DataModel.TopIndex then
    local group = View.Group_Stage.Group_Btn.StaticGrid_TopList.grid[DataModel.TopIndex]
    group.Btn_Item.Group_Off:SetActive(true)
    group.Btn_Item.Group_Off.Img_Red:SetActive(DataModel.TopList[DataModel.TopIndex].isHaveRed)
    group.Btn_Item.Group_On:SetActive(false)
    local obj = "Group_" .. DataModel.TopIndex
    View.Group_Stage[obj].self:SetActive(false)
  end
  Controller:RefreshRightGrid(index)
  local obj = View.Group_Stage.Group_Btn.StaticGrid_TopList.grid[DataModel.TopIndex]
  obj.Btn_Item.Group_Off:SetActive(false)
  obj.Btn_Item.Group_On:SetActive(true)
  local obj = "Group_" .. DataModel.TopIndex
  View.Group_Stage[obj].self:SetActive(true)
  Controller:RefreshStageInfo()
end

function Controller:ChangeLeft()
  DataModel.CurrentStageIndex = DataModel.CurrentStageIndex - 1
  Controller:RefreshStageInfo()
end

function Controller:ChangeRight()
  if DataModel.CurrentStageIndex + 1 > DataModel.CurrentStageMax then
    CommonTips.OpenTips(80608781)
    return
  end
  DataModel.CurrentStageIndex = DataModel.CurrentStageIndex + 1
  Controller:RefreshStageInfo()
end

function Controller:RefreshStageInfo()
  DataModel:RefreshStageInfo()
  View.Group_Stage.Group_Quest.ScrollGrid_Quest.grid.self:SetDataCount(table.count(DataModel.QuestList))
  View.Group_Stage.Group_Quest.ScrollGrid_Quest.grid.self:RefreshAllElement()
  View.Group_Stage.Group_Quest.ScrollGrid_Quest.grid.self:MoveToTop()
  if DataModel.CurrentData.id == 80304015 then
    Controller:OpenBattleManual()
  end
  if DataModel.CurrentData.id == 80304016 then
    Controller:OpenTradeManual()
  end
  if DataModel.CurrentData.id == 80304019 then
    Controller:OpenPassengerManual()
  end
  if DataModel.CurrentData.id == 80304017 then
    Controller:OpenManufactureManual()
  end
  if DataModel.CurrentData.id == 80304018 then
    Controller:OpenIndustryManual()
  end
end

function Controller:OpenBattleManual()
  local row = DataModel.CurrentInfo
  local Group_Stage = View.Group_Stage.Group_1.Group_Stage
  Group_Stage.Txt_T:SetText(row.stageName)
  local Group_Progress = View.Group_Stage.Group_1.Group_Stage.Group_Progress
  Group_Progress.Txt_Progress:SetText(DataModel.CurrentStageNum .. "/" .. table.count(DataModel.QuestList))
  Group_Progress.Img_Progress:SetFilledImgAmount(DataModel.CurrentStageNum / table.count(DataModel.QuestList))
  local Group_Reward = View.Group_Stage.Group_1.Group_Stage.Group_Reward
  Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  Group_Stage.Group_Reward.Btn_Get.Group_Got.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.receive)
  Group_Stage.Group_Reward.Btn_Get.Group_Off.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.lock)
  Group_Stage.Group_Reward.Btn_Get.Group_On.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.finish)
  Group_Stage.Btn_L:SetActive(DataModel.CurrentStageIndex - 1 > 0)
  Group_Stage.Btn_R:SetActive(DataModel.CurrentStageIndex + 1 <= table.count(DataModel.CurrentData.config.stageQuestList))
end

function Controller:OpenTradeManual()
  local row = DataModel.CurrentInfo
  local Group_Stage = View.Group_Stage.Group_2.Group_Stage
  Group_Stage.Txt_T:SetText(row.stageName)
  local Group_Progress = View.Group_Stage.Group_2.Group_Stage.Group_Progress
  Group_Progress.Txt_Progress:SetText(DataModel.CurrentStageNum .. "/" .. table.count(DataModel.QuestList))
  Group_Progress.Img_Progress:SetFilledImgAmount(DataModel.CurrentStageNum / table.count(DataModel.QuestList))
  local Group_Reward = View.Group_Stage.Group_2.Group_Stage.Group_Reward
  Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  Group_Stage.Group_Lv.Txt_Num:SetText(DataModel.tradeLv)
  Group_Stage.Group_Capacity.Txt_Num:SetText(DataModel.nowGoodsNum .. "/" .. DataModel.totalGoods)
  Group_Stage.Group_Reward.Btn_Get.Group_Got.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.receive)
  Group_Stage.Group_Reward.Btn_Get.Group_Off.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.lock)
  Group_Stage.Group_Reward.Btn_Get.Group_On.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.finish)
  Group_Stage.Btn_L:SetActive(DataModel.CurrentStageIndex - 1 > 0)
  Group_Stage.Btn_R:SetActive(DataModel.CurrentStageIndex + 1 <= table.count(DataModel.CurrentData.config.stageQuestList))
end

function Controller:OpenPassengerManual()
  local row = DataModel.CurrentInfo
  local Group_Stage = View.Group_Stage.Group_4.Group_Stage
  Group_Stage.Txt_T:SetText(row.stageName)
  local Group_Progress = View.Group_Stage.Group_4.Group_Stage.Group_Progress
  Group_Progress.Txt_Progress:SetText(DataModel.CurrentStageNum .. "/" .. table.count(DataModel.QuestList))
  Group_Progress.Img_Progress:SetFilledImgAmount(DataModel.CurrentStageNum / table.count(DataModel.QuestList))
  local Group_Reward = View.Group_Stage.Group_4.Group_Stage.Group_Reward
  Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  Group_Stage.Group_Lv.Txt_Num:SetText(DataModel.passengerLv)
  Group_Stage.Group_Capacity.Txt_Num:SetText(DataModel.passengersNum .. "/" .. DataModel.totalPassengersNum)
  Group_Stage.Group_ComfortLv.Txt_Num:SetText(DataModel.comfortScore)
  Group_Stage.Group_TasteLv.Txt_Num:SetText(DataModel.foodScore)
  Group_Stage.Group_EntertainmentLv.Txt_Num:SetText(DataModel.entScore)
  Group_Stage.Group_GreenLv.Txt_Num:SetText(DataModel.plantScore)
  Group_Stage.Group_PetLv.Txt_Num:SetText(DataModel.petScore)
  Group_Stage.Group_FishLv.Txt_Num:SetText(DataModel.fishScore)
  Group_Stage.Group_Reward.Btn_Get.Group_Got.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.receive)
  Group_Stage.Group_Reward.Btn_Get.Group_Off.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.lock)
  Group_Stage.Group_Reward.Btn_Get.Group_On.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.finish)
  Group_Stage.Btn_L:SetActive(DataModel.CurrentStageIndex - 1 > 0)
  Group_Stage.Btn_R:SetActive(DataModel.CurrentStageIndex + 1 <= table.count(DataModel.CurrentData.config.stageQuestList))
end

function Controller:OpenManufactureManual()
  local row = DataModel.CurrentInfo
  local Group_Stage = View.Group_Stage.Group_3.Group_Stage
  Group_Stage.Txt_T:SetText(row.stageName)
  local Group_Progress = View.Group_Stage.Group_3.Group_Stage.Group_Progress
  Group_Progress.Txt_Progress:SetText(DataModel.CurrentStageNum .. "/" .. table.count(DataModel.QuestList))
  Group_Progress.Img_Progress:SetFilledImgAmount(DataModel.CurrentStageNum / table.count(DataModel.QuestList))
  local Group_Reward = View.Group_Stage.Group_3.Group_Stage.Group_Reward
  Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  Group_Stage.Group_Lv.Txt_Num:SetText(DataModel.compoundLv)
  Group_Stage.Group_Reward.Btn_Get.Group_Got.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.receive)
  Group_Stage.Group_Reward.Btn_Get.Group_Off.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.lock)
  Group_Stage.Group_Reward.Btn_Get.Group_On.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.finish)
  Group_Stage.Btn_L:SetActive(DataModel.CurrentStageIndex - 1 > 0)
  Group_Stage.Btn_R:SetActive(DataModel.CurrentStageIndex + 1 <= table.count(DataModel.CurrentData.config.stageQuestList))
end

function Controller:OpenIndustryManual()
  local row = DataModel.CurrentInfo
  local Group_Stage = View.Group_Stage.Group_5.Group_Stage
  Group_Stage.Txt_T:SetText(row.stageName)
  local Group_Progress = View.Group_Stage.Group_5.Group_Stage.Group_Progress
  Group_Progress.Txt_Progress:SetText(DataModel.CurrentStageNum .. "/" .. table.count(DataModel.QuestList))
  Group_Progress.Img_Progress:SetFilledImgAmount(DataModel.CurrentStageNum / table.count(DataModel.QuestList))
  local Group_Reward = View.Group_Stage.Group_5.Group_Stage.Group_Reward
  Group_Reward.StaticGrid_Reward.grid.self:RefreshAllElement()
  Group_Stage.Group_Lv.Txt_Num:SetText(DataModel.industryLv)
  Group_Stage.ScrollView_Lv.Viewport.Content.Group_TJLY.Txt_Num:SetText(DataModel.disneylandLv)
  Group_Stage.ScrollView_Lv.Viewport.Content.Group_SXD.Txt_Num:SetText(DataModel.islandLv)
  Group_Stage.ScrollView_Lv.Viewport.Content.Group_ZDZX.Txt_Num:SetText(DataModel.prisonLv)
  Group_Stage.Group_Reward.Btn_Get.Group_Got.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.receive)
  Group_Stage.Group_Reward.Btn_Get.Group_Off.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.lock)
  Group_Stage.Group_Reward.Btn_Get.Group_On.self:SetActive(DataModel.CurrentStageState == DataModel.StageStateE.finish)
  Group_Stage.Btn_L:SetActive(DataModel.CurrentStageIndex - 1 > 0)
  Group_Stage.Btn_R:SetActive(DataModel.CurrentStageIndex + 1 <= table.count(DataModel.CurrentData.config.stageQuestList))
end

function Controller:RefreshRightGrid(index)
  DataModel:RefreshCurrentData(index)
  View.Group_Stage.Group_Quest.ScrollGrid_Quest.grid.self:SetDataCount(table.count(DataModel.QuestList))
  View.Group_Stage.Group_Quest.ScrollGrid_Quest.grid.self:RefreshAllElement()
  View.Group_Stage.Group_Quest.ScrollGrid_Quest.grid.self:MoveToTop()
end

function Controller:SetQuestGridElelment(element, elementIndex)
  local row = DataModel.QuestList[elementIndex]
  element.Group_On.Btn_Get:SetClickParam(elementIndex)
  element.Group_Off:SetActive(row.type == EnumDefine.EQuestState.Lock or row.type == EnumDefine.EQuestState.UnFinish)
  element.Group_On:SetActive(row.type == EnumDefine.EQuestState.Finish)
  element.Group_Got:SetActive(row.type == EnumDefine.EQuestState.Receive)
  element.Group_Off.Txt_T:SetText(row.des)
  element.Group_On.Txt_T:SetText(row.des)
  element.Group_Got.Txt_T:SetText(row.des)
  element.Img_Mask:SetActive(row.type == EnumDefine.EQuestState.Receive)
  element.ScrollGrid_Reward.grid.self:SetParentParam(elementIndex)
  element.ScrollGrid_Reward.grid.self:SetDataCount(table.count(row.rewardsList))
  element.ScrollGrid_Reward.grid.self:RefreshAllElement()
  element.ScrollGrid_Reward.grid.self:MoveToTop()
  element.ScrollGrid_Reward.grid.self.ScrollRect.enabled = false
  element.Group_Off.Group_Progress.Txt_Num:SetText(row.numNow .. "/" .. row.numMax)
  element.Group_Off.Group_Progress.Img_Bar:SetLocalScale(Vector3(1 * row.numNow / row.numMax, 1, 1))
  if row.type == EnumDefine.EQuestState.Lock or row.type == EnumDefine.EQuestState.UnFinish then
    if row.isSwitchUI and not string.nilorempty(row.switchUI) then
      element.Group_Off.Group_Goto:SetActive(true)
      element.Group_Off.Group_UnGet:SetActive(false)
      element.Group_Off.Group_Goto.Btn_Goto:SetClickFunction(function()
        Controller:OnGoToFastBattleBtnClick(row)
      end)
    else
      element.Group_Off.Group_Goto:SetActive(false)
      element.Group_Off.Group_UnGet:SetActive(true)
    end
  end
end

function Controller:SetQuestGridRewardElelment(element, elementIndex)
  local index = tonumber(element.ParentParam)
  local questCA = PlayerData:GetFactoryData(DataModel.QuestList[index].id)
  local rewardList = questCA.rewardsList
  CommonItem:SetItem(element.Group_Item, {
    id = rewardList[elementIndex].id,
    num = rewardList[elementIndex].num
  }, EnumDefine.ItemType.Item)
  element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
end

function Controller:SetLeftGridRewardElelment(element, elementIndex)
  local rewardList = DataModel.CurrentInfo.stageReward
  element:SetActive(false)
  if rewardList[elementIndex] == nil then
    return
  end
  element:SetActive(true)
  CommonItem:SetItem(element.Group_Item, {
    id = rewardList[elementIndex].id,
    num = rewardList[elementIndex].num
  }, EnumDefine.ItemType.Item)
  element.Group_Item.Btn_Item:SetClickParam(rewardList[elementIndex].id)
end

function Controller:QuestGet(index)
  local row = DataModel.QuestList[index]
  if row.type == EnumDefine.EQuestState.Finish then
    Net:SendProto("quest.recv_rewards", function(json)
      CommonTips.OpenShowItem(json.reward)
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
      GuideManager:CompleteQuestCallBack({
        [1] = row.id
      })
      QuestTrace.CompleteQuestOne(row.id)
      Controller:ClickTopBtn(DataModel.TopIndex, true)
    end, row.id)
  end
end

function Controller:StageGet()
  if DataModel.CurrentStageState == DataModel.StageStateE.finish then
    Net:SendProto("quest.rec_stage", function(json)
      if PlayerData:GetStageQuest()[tostring(DataModel.CurrentStageId)] then
        PlayerData:GetStageQuest()[tostring(DataModel.CurrentStageId)].status = 1
      end
      CommonTips.OpenShowItem(json.reward)
      Controller:ClickTopBtn(DataModel.TopIndex, true)
    end, DataModel.TopIndex - 1, DataModel.CurrentStageId)
  end
end

function Controller:SetBattleInfoReduceTime()
  local data = DataModel.BattleList[DataModel.BattleLeftIndex]
  local timeTable = TimeUtil:SecondToTable(data.targetTime - PlayerData:GetSeverTime())
  if timeTable.day >= 1 then
    View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80607630), timeTable.day, timeTable.hour))
  elseif 1 <= timeTable.hour then
    View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80607631), timeTable.hour))
  elseif 1 <= timeTable.minute then
    View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80607736), timeTable.minute))
  else
    View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Time:SetText(string.format(GetText(80607736), 0))
  end
end

function Controller:ClickBattleLeftList(index)
  if DataModel.BattleLeftIndex then
    local data = DataModel.BattleList[DataModel.BattleLeftIndex]
    View.Group_Battle.Group_Right[data.nodeName]:SetActive(false)
  end
  DataModel:SetBattleLeftListIndex(index)
  local data = DataModel.BattleList[DataModel.BattleLeftIndex]
  View.Group_Battle.Group_Right[data.nodeName]:SetActive(true)
  View.Group_Battle.Group_Left.ScrollGrid_Left.grid.self:RefreshAllElement()
  View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Name:SetText(data.nameText)
  View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Des:SetText(data.desText)
  View.Group_Battle.Group_Right[data.nodeName].Group_Level.ScrollGrid_Level.grid.self:SetDataCount(#DataModel.ChooseLeftData)
  View.Group_Battle.Group_Right[data.nodeName].Group_Level.ScrollGrid_Level.grid.self:RefreshAllElement()
  View.Group_Battle.Group_Right[data.nodeName].Group_Level.ScrollGrid_Level.grid.self:MoveToTop()
  local reduice = DataModel.BattleList[DataModel.BattleLeftIndex].materialLevelTimes - DataModel.BattleCurrentNum
  reduice = reduice < 0 and 0 or reduice
  View.Group_Battle.Group_Right[data.nodeName].Group_Info.Txt_Times:SetText(reduice .. "/" .. DataModel.BattleList[DataModel.BattleLeftIndex].materialLevelTimes)
  Controller:SetBattleInfoReduceTime()
end

function Controller:RefreshOrderPanel(isInit)
  View.Group_Order.Group_TeamOrderWindow:SetActive(false)
  View.Group_Order.Group_TeamArray:SetActive(false)
  View.Group_Order.Group_Left.Btn_GoHall.Group_Lcok:SetActive(DataModel.compoundLv < 20)
  showPage()
  if isInit then
    DataModel.OrderInit()
    if DataModel.IsFromActivity then
      Controller:SelectOrderTab(3)
    elseif DataModel.TargetOrderIndex and tonumber(DataModel.TargetOrderIndex) ~= nil then
      Controller:SelectOrderTab(tonumber(DataModel.TargetOrderIndex))
      if DataModel.TargetOrderSelect and tonumber(DataModel.TargetOrderSelect) ~= nil then
        Controller:SelectOrder(tonumber(DataModel.TargetOrderSelect))
      end
    else
      Controller:SelectOrderTab(1)
    end
    Controller:RefreshLeftOrder()
  else
    Controller:RefreshLeftOrder()
    Controller:RefreshRightOrderInfo()
  end
  DataModel.TargetOrderIndex = nil
  DataModel.TargetOrderSelect = nil
end

function Controller:SelectOrderTab(index)
  View.Group_Order.Group_Left.Btn_GoHall.Img_RedPoint:SetActive(DataModel.GetInviteOrderRedPoint())
  if index == 1 then
    PlayerData:SetPlayerPrefs("int", "OrderMyInfoTimeStamp", TimeUtil:GetServerTimeStamp())
  end
  if index == 3 then
    PlayerData:SetPlayerPrefs("int", "OrderSpecialInfoTimeStamp", TimeUtil:GetServerTimeStamp())
    local activityList = PlayerData.ServerData.user_info.all_user_future_activity
    if not activityList or table.count(activityList) == 0 then
      View.Group_Order.Group_Left.Btn_GoActivity.Img_RedPoint:SetActive(false)
    else
      View.Group_Order.Group_Left.Btn_GoActivity.Img_RedPoint:SetActive(DataModel.GetActivityRedPoint())
    end
  end
  View.Group_Order.Group_Left.Group_OrderOption.Img_RedPoint_Mine:SetActive(DataModel.GetMyOrderRedPoint())
  View.Group_Order.Group_Left.Group_OrderOption.Img_RedPoint_Special:SetActive(DataModel.GetSpecialOrderRedPoint() or DataModel.GetActivityRedPoint())
  DataModel.CurrentOrderTab = index
  View.Group_Order.Group_Left.Group_OrderOption.Group_OptionMine.Group_Mine:SetActive(index == 1)
  View.Group_Order.Group_Left.Group_OrderOption.Group_OptionOther.Group_Other:SetActive(index == 2)
  View.Group_Order.Group_Left.Group_OrderOption.Group_OptionSpecial.Group_Other:SetActive(index == 3)
  View.Group_Order.Group_Left.Btn_GoActivity:SetActive(index == 3)
  Controller:RefreshResetTimes()
  Controller:RefreshLeftOrder()
  Controller:SelectOrder(0)
end

function Controller:SelectOrder(index)
  DataModel.CurrentOrderIndex = index
  Controller:RefreshLeftOrder()
  Controller:RefreshRightOrderInfo()
end

function Controller:RefreshResetTimes()
  local currentCount = PlayerData.ServerData.user_info.future_base_info.weekly_refreshed_count
  local totalCount = PlayerData:GetFactoryData(99900134).refreshLimit
  View.Group_Order.Group_Right.Img_SingleOrder.Group_Reresh.Txt_Num:SetText(currentCount .. "/" .. totalCount)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_Reresh.Txt_Num:SetText(currentCount .. "/" .. totalCount)
  View.Group_Order.Group_Right.Img_SingleOrder.Group_Reresh.Btn_Refresh.Txt_Num:SetText(currentCount .. "/" .. totalCount)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_Reresh.Btn_Refresh.Txt_Num:SetText(currentCount .. "/" .. totalCount)
end

function Controller:SetMyOrderInfo(order)
  local orderCfg = PlayerData:GetFactoryData(order.id)
  local production = PlayerData:GetFactoryData(orderCfg.requireProduction)
  local formulaCfg = PlayerData:GetFactoryData(production.condition[1].id)
  View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet:SetActive(false)
  View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet:SetActive(false)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet:SetActive(false)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet:SetActive(false)
  if not orderCfg.isTeam then
    View.Group_Order.Group_Right.Img_SingleOrder:SetActive(true)
    View.Group_Order.Group_Right.Img_SingleOrder.Txt_Title:SetText(string.format(GetText(80607880), orderCfg.name))
    View.Group_Order.Group_Right.Img_SingleOrder.Txt_Des:SetText(string.format(orderCfg.des, DataModel.GetOrderRequireCount(order.uid, order.id)))
    View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Img_Formula.Txt_Title:SetText(string.format(GetText(80610417), orderCfg.name))
    View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Img_Formula.Txt_Title:SetText(string.format(GetText(80610417), orderCfg.name))
    View.Group_Order.Group_Right.Img_SingleOrder.StaticGrid_Star.grid.self:SetDataCount(5)
    View.Group_Order.Group_Right.Img_SingleOrder.StaticGrid_Star.grid.self:RefreshAllElement()
    local canRefresh = DataModel.CheckOrderCanRefresh(order.uid, order.id)
    View.Group_Order.Group_Right.Img_SingleOrder.Group_Reresh.Btn_Refresh:SetActive(canRefresh)
    View.self:StartC(LuaUtil.cs_generator(function()
      coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
      local rewardList = DataModel.GetOrderReward(order.uid, order.id)
      DataModel.CurrentOrderReward = rewardList
      View.Group_Order.Group_Right.Img_SingleOrder.ScrollGrid_Reward.grid.self:SetDataCount(table.count(rewardList))
      View.Group_Order.Group_Right.Img_SingleOrder.ScrollGrid_Reward.grid.self:RefreshAllElement()
    end))
    if not order.isJoin then
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet:SetActive(true)
      local timeTable = TimeUtil:SecondToTableHMS(orderCfg.timeLimit)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d", timeTable.hour, timeTable.minute))
      local formulaIsUnlock = not orderCfg.isProductionGet or DataModel.CheckFormationUnlock(order.id)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Group_Money:SetActive(formulaIsUnlock)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Img_Formula:SetActive(not formulaIsUnlock)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Btn_Get.Img_NoFormula:SetActive(not formulaIsUnlock)
      local requireItem = orderCfg.requireItemList[1]
      local requireItemCfg = PlayerData:GetFactoryData(requireItem.id)
      local haveNum = PlayerData:GetGoodsById(requireItem.id).num
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Btn_Get.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Btn_Get.Img_Owned.Img_Num.Txt_:SetText(haveNum < requireItem.num and string.format(GetText(80611091), haveNum) or string.format(GetText(80608847), haveNum))
      if not formulaIsUnlock then
        View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Img_Formula.ScrollGrid_Material.grid.self:SetDataCount(table.count(formulaCfg.drawForm))
        View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Img_Formula.ScrollGrid_Material.grid.self:RefreshAllElement()
        View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Img_Formula.Img_Formula:SetSprite(production.iconPath)
      else
        View.Group_Order.Group_Right.Img_SingleOrder.Group_BeforeGet.Group_Money.Txt_Num:SetText(orderCfg.moneyList[1].num)
      end
    else
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet:SetActive(true)
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
        View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Img_Formula.ScrollGrid_Material.grid.self:SetDataCount(table.count(formulaCfg.drawForm))
        View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Img_Formula.ScrollGrid_Material.grid.self:RefreshAllElement()
        View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Img_Formula.Img_Formula:SetSprite(production.iconPath)
      end))
      DataModel.CurOrderEndTime = order.endTime
      local timeTable = TimeUtil:SecondToTableHMS(DataModel.CurOrderEndTime - TimeUtil:GetServerTimeStamp())
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
      local requireItem = orderCfg.requireItemList[1]
      local requireItemCfg = PlayerData:GetFactoryData(requireItem.id)
      local haveNum = PlayerData:GetGoodsById(requireItem.id).num
      local needNum = requireItem.num
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Btn_NotEnough.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Btn_Enough.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Btn_Enough.Img_Owned.Img_Num.Txt_:SetText(string.format(GetText(80608847), haveNum))
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Btn_NotEnough.Img_Owned.Img_Num.Txt_:SetText(string.format(GetText(80608847), haveNum))
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Btn_NotEnough:SetActive(haveNum < needNum)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Btn_Enough:SetActive(haveNum >= needNum)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Img_Formula.Btn_GoGet:SetActive(true)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Img_Formula.Btn_GoTo:SetActive(false)
    end
  else
    View.Group_Order.Group_Right.Img_TeamOrder:SetActive(true)
    View.Group_Order.Group_Right.Img_TeamOrder.Txt_Title:SetText(string.format(GetText(80607880), orderCfg.name))
    View.Group_Order.Group_Right.Img_TeamOrder.Txt_Des:SetText(string.format(orderCfg.des, DataModel.GetOrderRequireCount(order.uid, order.id)))
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Txt_Title:SetText(string.format(GetText(80610417), orderCfg.name))
    View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Formula.Txt_Title:SetText(string.format(GetText(80610417), orderCfg.name))
    View.Group_Order.Group_Right.Img_TeamOrder.StaticGrid_Star.grid.self:SetDataCount(5)
    View.Group_Order.Group_Right.Img_TeamOrder.StaticGrid_Star.grid.self:RefreshAllElement()
    local canRefresh = DataModel.CheckOrderCanRefresh(order.uid, order.id)
    View.Group_Order.Group_Right.Img_TeamOrder.Group_Reresh.Btn_Refresh:SetActive(canRefresh)
    local rewardList = DataModel.GetOrderReward(order.uid, order.id)
    DataModel.CurrentOrderReward = rewardList
    if not order.isJoin then
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet:SetActive(true)
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.ScrollGrid_Reward.grid.self:SetDataCount(table.count(rewardList))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.ScrollGrid_Reward.grid.self:RefreshAllElement()
      end))
      local timeTable = TimeUtil:SecondToTableHMS(orderCfg.timeLimit)
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d", timeTable.hour, timeTable.minute))
      local formulaIsUnlock = not orderCfg.isProductionGet or DataModel.CheckFormationUnlock(order.id)
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Money:SetActive(formulaIsUnlock)
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Formula:SetActive(not formulaIsUnlock)
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Btn_Get.Img_NoFormula:SetActive(not formulaIsUnlock)
      local requireItem = orderCfg.requireItemList[1]
      local requireItemCfg = PlayerData:GetFactoryData(requireItem.id)
      local haveNum = PlayerData:GetGoodsById(requireItem.id).num
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Btn_Get.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
      View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Btn_Get.Img_Owned.Img_Num.Txt_:SetText(haveNum < requireItem.num and string.format(GetText(80611091), haveNum) or string.format(GetText(80608847), haveNum))
      if not formulaIsUnlock then
        View.self:StartC(LuaUtil.cs_generator(function()
          coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
          View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Formula.ScrollGrid_Material.grid.self:SetDataCount(table.count(formulaCfg.drawForm))
          View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Formula.ScrollGrid_Material.grid.self:RefreshAllElement()
          View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Formula.Img_Formula:SetSprite(production.iconPath)
        end))
      else
        View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet.Img_Money.Txt_Num:SetText(orderCfg.moneyList[1].num)
      end
    else
      View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet:SetActive(true)
      View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_LeaveTeam:SetActive(false)
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.ScrollGrid_Reward.grid.self:SetDataCount(table.count(rewardList))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.ScrollGrid_Reward.grid.self:RefreshAllElement()
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.ScrollGrid_Material.grid.self:SetDataCount(table.count(formulaCfg.drawForm))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.ScrollGrid_Material.grid.self:RefreshAllElement()
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Img_Formula:SetSprite(production.iconPath)
      end))
      DataModel.CurOrderEndTime = order.endTime
      do
        local timeTable = TimeUtil:SecondToTableHMS(DataModel.CurOrderEndTime - TimeUtil:GetServerTimeStamp())
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
        local requireItem = orderCfg.requireItemList[1]
        local requireItemCfg = PlayerData:GetFactoryData(requireItem.id)
        local haveNum = PlayerData:GetGoodsById(requireItem.id).num
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_NotEnough.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_Enough.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_Enough.Img_Owned.Img_Num.Txt_:SetText(string.format(GetText(80608847), haveNum))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_NotEnough.Img_Owned.Img_Num.Txt_:SetText(string.format(GetText(80608847), haveNum))
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_NotEnough:SetActive(haveNum == 0)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_Enough:SetActive(0 < haveNum)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Btn_GoGet:SetActive(true)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Btn_GoTo:SetActive(false)
        Controller:RefreshTeamMember()
        local requireCount = DataModel.GetOrderRequireCount(order.uid, order.id)
        local curDeliver = DataModel.GetOrderDeliverCount(order.uid)
        local percent = curDeliver / requireCount
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Circle:SetActive(percent < 1)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_GetReward:SetActive(1 <= percent)
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Circle.Txt_1:SetText(math.floor(percent * 100) .. "%")
        View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Circle.Img_Circle:SetFilledImgAmount(percent)
      end
    end
  end
end

function Controller:SetOtherOrderInfo(order)
  local orderCfg = PlayerData:GetFactoryData(order.id)
  local production = PlayerData:GetFactoryData(orderCfg.requireProduction)
  local formulaCfg = PlayerData:GetFactoryData(production.condition[1].id)
  View.Group_Order.Group_Right.Img_TeamOrder:SetActive(true)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet:SetActive(true)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_BeforeGet:SetActive(false)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Txt_Title:SetText(string.format(GetText(80610417), orderCfg.name))
  View.Group_Order.Group_Right.Img_TeamOrder.Txt_Title:SetText(string.format(GetText(80607880), orderCfg.name))
  View.Group_Order.Group_Right.Img_TeamOrder.Txt_Des:SetText(string.format(orderCfg.des, DataModel.GetOrderRequireCount(order.uid, order.id)))
  View.Group_Order.Group_Right.Img_TeamOrder.Group_Reresh.Btn_Refresh:SetActive(false)
  View.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
    local rewardList = DataModel.GetOrderReward(order.uid, order.id)
    DataModel.CurrentOrderReward = rewardList
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.ScrollGrid_Reward.grid.self:SetDataCount(table.count(rewardList))
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.ScrollGrid_Reward.grid.self:RefreshAllElement()
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.ScrollGrid_Material.grid.self:SetDataCount(table.count(formulaCfg.drawForm))
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.ScrollGrid_Material.grid.self:RefreshAllElement()
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Img_Formula:SetSprite(production.iconPath)
  end))
  DataModel.CurOrderEndTime = order.endTime
  local timeTable = TimeUtil:SecondToTableHMS(DataModel.CurOrderEndTime - TimeUtil:GetServerTimeStamp())
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
  local requireItem = orderCfg.requireItemList[1]
  local requireItemCfg = PlayerData:GetFactoryData(requireItem.id)
  local haveNum = PlayerData:GetGoodsById(requireItem.id).num
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_NotEnough.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_Enough.Img_Owned.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_Enough.Img_Owned.Img_Num.Txt_:SetText(string.format(GetText(80608847), haveNum))
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_NotEnough.Img_Owned.Img_Num.Txt_:SetText(string.format(GetText(80608847), haveNum))
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_NotEnough:SetActive(haveNum == 0)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Btn_Enough:SetActive(0 < haveNum)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Btn_GoGet:SetActive(true)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Img_Formula.Btn_GoTo:SetActive(false)
  Controller:RefreshTeamMember()
  local requireCount = DataModel.GetOrderRequireCount(order.uid, order.id)
  local curDeliver = DataModel.GetOrderDeliverCount(order.uid)
  local percent = curDeliver / requireCount
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Circle:SetActive(percent < 1)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_GetReward:SetActive(1 <= percent)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Circle.Txt_1:SetText(math.floor(percent * 100) .. "%")
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Circle.Img_Circle:SetFilledImgAmount(percent)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_LeaveTeam:SetActive(order.isKick)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_LeaveTeam.Group_Exit:SetActive(false)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_LeaveTeam.Group_KickOut:SetActive(true)
  if order.isKick then
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_LeaveTeam.Btn_GetReturnReward.Img_Return.Img_:SetSprite(requireItemCfg.iconPath or requireItemCfg.imagePath)
    View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_LeaveTeam.Btn_GetReturnReward.Img_Return.Img_Num.Txt_:SetText(order.myDeliverCount)
  end
end

function Controller:RefreshRightOrderInfo()
  DataModel.CurOrderEndTime = -1
  DataModel.CurrentSelectOrderUId = ""
  View.Group_Order.Group_Right.Img_NoOrder:SetActive(true)
  View.Group_Order.Group_Right.Group_RefreshOrder:SetActive(false)
  View.Group_Order.Group_Right.Img_SingleOrder:SetActive(false)
  View.Group_Order.Group_Right.Img_TeamOrder:SetActive(false)
  local requireLevel = PlayerData:GetFactoryData(99900134).openlevel
  local playerLevel = PlayerData.ServerData.user_info.lv
  View.Group_Order.Group_Right.Img_OrderLock:SetActive(requireLevel > playerLevel)
  if requireLevel > playerLevel then
    View.Group_Order.Group_Right.Img_OrderLock.Img_1.Txt_:SetText(string.format(GetText(80611092), requireLevel))
    return
  end
  if DataModel.CurrentOrderIndex == 0 then
    View.Group_Order.Group_Right.Img_NoOrder:SetActive(true)
    return
  end
  local order = DataModel.GetOrderInfo()
  if not order or next(order) == nil then
    return
  end
  DataModel.CurrentSelectOrderUId = order.uid
  View.Group_Order.Group_Right.Img_NoOrder:SetActive(false)
  if DataModel.CurrentOrderTab == 1 then
    Controller:SetMyOrderInfo(order)
  elseif DataModel.CurrentOrderTab == 2 then
    Controller:SetOtherOrderInfo(order)
  elseif DataModel.CurrentOrderTab == 3 then
    Controller:SetMyOrderInfo(order)
  end
end

function Controller:SetLeftOrderElement(element, elementIndex)
  local order = DataModel.GetOrderInfo(elementIndex)
  element.Img_Pick:SetActive(DataModel.CurrentOrderIndex == elementIndex)
  element.Group_Lock:SetActive(DataModel.CurrentOrderTab == 1 and elementIndex > DataModel.UnlockOrderGridCount)
  if not order or next(order) == nil then
    element.Group_Empty:SetActive(true)
    element.Group_Single:SetActive(false)
    element.Group_Team:SetActive(false)
    element.Group_Special:SetActive(false)
    element.Group_Condition:SetActive(false)
    element.Img_Up:SetActive(false)
  else
    local state = DataModel.GetOrderState(elementIndex)
    element.Group_Condition:SetActive(true)
    element.Group_Condition.Img_NotPick:SetActive(state == DataModel.OrderState.Doing)
    element.Group_Condition.Img_CanSubmit:SetActive(state == DataModel.OrderState.CanSubmit)
    element.Group_Condition.Img_Complete:SetActive(state == DataModel.OrderState.Complete)
    element.Img_Up:SetActive(DataModel.OrderBuffList[tostring(order.id)] ~= nil)
    element.Group_Empty:SetActive(false)
    local cfg = PlayerData:GetFactoryData(order.id)
    element.Group_Single:SetActive((DataModel.CurrentOrderTab == 1 or DataModel.CurrentOrderTab == 3) and cfg.isTeam == false)
    element.Group_Team:SetActive(DataModel.CurrentOrderTab == 1 and cfg.isTeam == true or DataModel.CurrentOrderTab == 2)
    element.Group_Team.Img_GetRewardMask:SetActive(cfg.isTeam and order.isFinish)
    element.Group_Single.Img_bg.Txt_Item:SetText(cfg.name)
    element.Group_Special:SetActive(cfg.isSpecial)
    local requireItem = cfg.requireItemList[1]
    local itemCfg = PlayerData:GetFactoryData(requireItem.id)
    local factor = DataModel.GetOrderFactorValue(order.uid)
    local num = requireItem.num * factor
    local orderType = DataModel.GetOrderType(order.id)
    local group
    if orderType == DataModel.OrderType.Single then
      group = element.Group_Single
    elseif orderType == DataModel.OrderType.Team then
      group = element.Group_Team
    elseif orderType == DataModel.OrderType.Special then
      group = element.Group_Special
    end
    DataModel.CurrentRefreshOrderId = order.id
    group.Img_bg.Img_Item:SetSprite(itemCfg.iconPath or itemCfg.imagePath)
    group.Img_bg.Txt_Item:SetText(itemCfg.name)
    group.Img_bg.Txt_Num:SetText(num)
    group.Img_bg.StaticGrid_Star.grid.self:SetDataCount(5)
    group.Img_bg.StaticGrid_Star.grid.self:RefreshAllElement()
  end
  if DataModel.CurrentOrderTab == 1 and elementIndex > DataModel.UnlockOrderGridCount then
    local repList = PlayerData:GetFactoryData(99900134).repCountList
    for i, v in ipairs(repList) do
      if elementIndex <= v.orderNum then
        element.Group_Lock.Txt_2:SetText(string.format(GetText(80610715), v.repNum))
        break
      end
    end
  end
  element.Btn_:SetClickParam(elementIndex)
end

function Controller:SetOrderStarElement(element, elementIndex)
  local orderCfg = PlayerData:GetFactoryData(DataModel.CurrentRefreshOrderId)
  if orderCfg then
    local star = orderCfg.rarity
    element.Img_Star:SetActive(elementIndex <= star)
  end
end

function Controller:RefreshLeftOrder()
  View.Group_Order.Group_Left.ScrollGrid_Order.grid.self:SetDataCount(DataModel.OrderGridCount)
  View.Group_Order.Group_Left.ScrollGrid_Order.grid.self:RefreshAllElement()
end

function Controller:SetRightOrderMaterialElement(element, elementIndex)
  local order = DataModel.GetOrderInfo()
  if not order or next(order) == nil then
    return
  end
  local orderCfg = PlayerData:GetFactoryData(order.id)
  local production = PlayerData:GetFactoryData(orderCfg.requireProduction)
  local formulaCfg = PlayerData:GetFactoryData(production.condition[1].id)
  local materialList = formulaCfg.drawForm
  local material = materialList[elementIndex]
  CommonItem:SetItem(element, {
    id = material.id,
    num = material.num
  })
  local materialCfg = PlayerData:GetFactoryData(material.id)
  element.Img_Item:SetSprite(materialCfg.iconPath or materialCfg.imagePath)
  element.Txt_Need:SetText(PlayerData:GetGoodsById(material.id).num .. "/" .. material.num)
  element.Btn_Item:SetClickParam(material.id)
end

function Controller:SetOrderSingleRewardElement(element, elementIndex)
  local reward = DataModel.CurrentOrderReward[elementIndex]
  CommonItem:SetItem(element, reward)
  element.Img_Num.Txt_:SetText(reward.num)
  element.Btn_:SetClickParam(reward.id)
end

function Controller:SetOrderTeamRewardElement(element, elementIndex)
  local reward = DataModel.CurrentOrderReward[elementIndex]
  CommonItem:SetItem(element, reward)
  element.Img_Num.Txt_:SetText(reward.num)
  element.Btn_:SetClickParam(reward.id)
end

function Controller:SetTeamMemberElement(element, elementIndex)
  local orderInfo = DataModel.GetOrderInfo()
  local teamData = orderInfo.team or {}
  local teamMemberCount = table.count(teamData)
  local isHave = elementIndex <= teamMemberCount
  element.Img_Empty:SetActive(not isHave)
  element.Img_Member:SetActive(isHave)
  element.Img_Bg:SetActive(isHave)
  local buffValue = DataModel.GetOrderBuffValue(elementIndex + 1)
  element.Img_Empty.Txt_1:SetText(elementIndex + 1)
  element.Img_Empty.Txt_2:SetText("+" .. buffValue .. "%")
  element.Img_Mask.Txt_:SetText(elementIndex + 1)
  element.Img_Mask.Txt_2:SetText("+" .. buffValue .. "%")
  if isHave then
    element.Img_Member:SetSprite(PlayerData:GetFactoryData(teamData[elementIndex].avatar).imagePath)
    CommonTips:SetPlayerHeadShader(element.Img_spAdd, PlayerData:GetFactoryData(teamData[elementIndex].avatar))
  end
end

function Controller:RefreshTeamMember()
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Team.StaticGrid_Team.grid.self:SetDataCount(4)
  View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_Team.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:SetTeamOrderMemberElement(element, elementIndex)
  local orderInfo = DataModel.GetOrderInfo()
  local teamData = orderInfo.team or {}
  local teamMemberCount = table.count(teamData)
  local isHave = elementIndex <= teamMemberCount
  element.Img_Empty:SetActive(not isHave)
  element.Img_Info:SetActive(isHave)
  element.Img_Empty.Txt_PNum:SetText(elementIndex + 1)
  element.Img_Pick:SetActive(elementIndex <= teamMemberCount)
  element.Img_Empty.Btn_:SetActive(true)
  if isHave then
    local data = teamData[elementIndex]
    element.Img_Info.Img_:SetSprite(PlayerData:GetFactoryData(data.avatar).imagePath)
    element.Img_Info.Txt_Name:SetText(data.name)
    element.Img_Info.Txt_FrameNum:SetText(data.rep)
    element.Img_Info.Txt_PNum:SetText(elementIndex + 1)
    element.Img_Info.Btn_Kick:SetActive(data.deliverPercent < 0.2 and DataModel.CurrentOrderTab == 1)
    element.Img_Info.Btn_Kick:SetClickParam(elementIndex)
    element.Img_Info.Txt_SubmitPercent:SetText(math.floor(data.deliverPercent * 100) .. "%")
    if data.deliverPercent < 0.2 then
      element.Img_Info.Txt_SubmitPercent:SetColor("#D86666")
    else
      element.Img_Info.Txt_SubmitPercent:SetColor("#1D1D1D")
    end
    CommonTips:SetPlayerHeadShader(element.Img_Info.Img_spAdd, PlayerData:GetFactoryData(data.avatar))
  else
    element.Img_Empty.Btn_:SetActive(DataModel.CurrentOrderTab == 1)
  end
end

function Controller:RefreshTeamOrderMember()
  View.Group_Order.Group_TeamOrderWindow.StaticGrid_Team.grid.self:SetDataCount(4)
  View.Group_Order.Group_TeamOrderWindow.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:ShowRefreshPanel()
  local orderInfo = DataModel.GetOrderInfo()
  if DataModel.CurrentOrderTab == 2 or DataModel.CurrentOrderTab == 3 then
    View.Group_Order.Group_Right.Group_RefreshOrder:SetActive(false)
    return
  end
  local canRefresh = DataModel.CheckOrderCanRefresh(orderInfo.uid, orderInfo.id)
  if not canRefresh then
    View.Group_Order.Group_Right.Group_RefreshOrder:SetActive(false)
    return
  end
  Controller:RefreshResetPanel()
  View.Group_Order.Group_Right.Group_RefreshOrder:SetActive(true)
end

function Controller:RefreshResetPanel()
  local cfg = PlayerData:GetFactoryData(99900134)
  local item1 = cfg.refreshItem[1]
  local item2 = cfg.refreshItemOther[1]
  local item2Cfg = PlayerData:GetFactoryData(item2.id)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupItem.Img_Item:SetSprite(item2Cfg.iconPath or item2Cfg.imagePath)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupItem.Txt_Name:SetText(item2Cfg.name)
  local item1HaveNum = PlayerData:GetGoodsById(item1.id).num or 0
  local item2HaveNum = PlayerData:GetGoodsById(item2.id).num or 0
  local item1CanRefreshCount = math.min(cfg.refreshLimit - PlayerData.ServerData.user_info.future_base_info.weekly_refreshed_count, math.floor(item1HaveNum / item1.num))
  local item2CanRefreshCount = item2HaveNum
  View.Group_Order.Group_Right.Group_RefreshOrder.Btn_Diamond.Txt_:SetText(item1HaveNum)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupDiamond.Txt_Num:SetText(item1.num)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupItem.Txt_Num:SetText(item2.num)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupDiamond.Txt_Left:SetText(string.format(GetText(80600686), item1CanRefreshCount))
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupItem.Txt_Left:SetText(string.format(GetText(80600686), item2CanRefreshCount))
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupDiamond.Img_Pick:SetActive(DataModel.CurrentOrderResetSelect == 1)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupItem.Img_Pick:SetActive(DataModel.CurrentOrderResetSelect == 2)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupDiamond.Img_Btn:SetActive(DataModel.CurrentOrderResetSelect == 1)
  View.Group_Order.Group_Right.Group_RefreshOrder.GroupItem.Img_Btn:SetActive(DataModel.CurrentOrderResetSelect == 2)
end

function Controller:TryRefreshOrder()
  if DataModel.CurrentOrderTab == 2 then
    return
  end
  if DataModel.CurrentOrderIndex == 0 then
    return
  end
  if DataModel.CurrentOrderIndex > DataModel.UnlockOrderGridCount then
    return
  end
  local order = DataModel.CurrentOrderTab == 1 and DataModel.MyOrderInfo[DataModel.CurrentOrderIndex] or DataModel.SpecialOrderInfo[DataModel.CurrentOrderIndex]
  local canRefresh = DataModel.CheckOrderCanRefresh(order.uid, order.id)
  if not canRefresh then
    return
  end
  local ca = PlayerData:GetFactoryData(99900134)
  local item1 = ca.refreshItem[1]
  local item1HaveNum = PlayerData:GetGoodsById(item1.id).num or 0
  local item1CanRefreshCount = math.min(ca.refreshLimit - PlayerData.ServerData.user_info.future_base_info.weekly_refreshed_count, math.floor(item1HaveNum / item1.num))
  if item1CanRefreshCount <= 0 and DataModel.CurrentOrderResetSelect == 1 then
    CommonTips.OpenTips("80600143")
    return
  end
  local haveNum = 0
  local needNum = 0
  if DataModel.CurrentOrderResetSelect == 1 then
    local cfg = PlayerData:GetFactoryData(99900134).refreshItem[1]
    haveNum = PlayerData:GetGoodsById(cfg.id).num
    needNum = cfg.num
  else
    local cfg = PlayerData:GetFactoryData(99900134).refreshItemOther[1]
    haveNum = PlayerData:GetGoodsById(cfg.id).num
    needNum = cfg.num
  end
  if haveNum < needNum then
    CommonTips.OpenTips("80600488")
    return
  end
  local gridId
  if DataModel.CurrentOrderTab == 1 then
    gridId = tostring(DataModel.CurrentOrderIndex)
  elseif DataModel.CurrentOrderTab == 3 then
    gridId = tostring(order.gridId)
  end
  Net:SendProto("future.reset_order", function(json)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    if DataModel.CurrentOrderResetSelect == 2 then
      local itemId = PlayerData:GetFactoryData(99900134).refreshItemOther[1].id
      PlayerData:RefreshUseItems({
        [itemId] = 1
      })
    end
    View.Group_Order.Group_Right.Group_RefreshOrder:SetActive(false)
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
    Controller:RefreshResetTimes()
  end, gridId, DataModel.CurrentOrderResetSelect)
end

function Controller:TryGetMyOrder()
  if DataModel.CurrentOrderTab == 2 then
    return
  end
  local order = DataModel.CurrentOrderTab == 1 and DataModel.MyOrderInfo[DataModel.CurrentOrderIndex] or DataModel.SpecialOrderInfo[DataModel.CurrentOrderIndex]
  if not order or next(order) == nil then
    return
  end
  local orderCfg = PlayerData:GetFactoryData(order.id)
  local formulaUnlock = not orderCfg.isProductionGet or DataModel.CheckFormationUnlock(order.id)
  if not formulaUnlock then
    Controller:OpenGetWayPanel(-250)
    return
  end
  local haveNum = PlayerData:GetGoodsById(11400001).num
  local needNum = orderCfg.moneyList[1].num
  if haveNum < needNum then
    CommonTips.OpenTips("80600260")
    return
  end
  local orderUid = order.uid
  Net:SendProto("future.join_my_order", function(json)
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
  end, orderUid)
end

function Controller:TryDeliverSingleOrder()
  if DataModel.CurrentOrderIndex == 0 then
    return
  end
  if DataModel.CurrentOrderTab == 2 then
    return
  end
  local order = DataModel.CurrentOrderTab == 1 and DataModel.MyOrderInfo[DataModel.CurrentOrderIndex] or DataModel.SpecialOrderInfo[DataModel.CurrentOrderIndex]
  local orderCfg = PlayerData:GetFactoryData(order.id)
  if orderCfg.isTeam then
    return
  end
  local deliverList = {}
  local factor = DataModel.GetOrderFactorValue(order.uid)
  for i, v in ipairs(orderCfg.requireItemList) do
    local haveNum = PlayerData:GetGoodsById(v.id).num
    local needNum = v.num * factor
    if 0 < haveNum then
      if haveNum >= needNum then
        table.insert(deliverList, {
          id = tostring(v.id),
          num = needNum
        })
      else
        return
      end
    else
      return
    end
  end
  if table.count(deliverList) == 0 then
    return
  end
  Net:SendProto("future.deliver_grad_normal_order", function(json)
    CommonTips.OpenTips(80610988)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    DataModel.UpdateOrderData()
    DataModel.RefreshDeliverItems(deliverList)
    Controller:RefreshOrderPanel()
  end, DataModel.CurrentSelectOrderUId)
end

function Controller:TryDeliverTeamOrder()
  if DataModel.CurrentOrderIndex == 0 then
    return
  end
  local order = DataModel.GetOrderInfo()
  local orderCfg = PlayerData:GetFactoryData(order.id)
  if not orderCfg.isTeam then
    return
  end
  local needNum = 0
  local factor = DataModel.GetOrderFactorValue(order.uid)
  for i, v in ipairs(orderCfg.requireItemList) do
    local haveNum = PlayerData:GetGoodsById(v.id).num
    local totalNeed = v.num * factor - DataModel.GetOrderDeliverCount(order.uid)
    if 0 < haveNum then
      if needNum >= haveNum then
        needNum = haveNum
      else
        needNum = totalNeed
      end
    end
  end
  UIManager:Open("UI/StageQuest/Order/OrderTips", Json.encode({
    id = orderCfg.requireItemList[1].id,
    uid = order.uid,
    needNum = needNum
  }))
end

function Controller:DoDeliverTeamOrder(num)
  if DataModel.CurrentOrderIndex == 0 then
    return
  end
  local order = DataModel.GetOrderInfo()
  local orderCfg = PlayerData:GetFactoryData(order.id)
  if not orderCfg.isTeam then
    return
  end
  local haveNum = PlayerData:GetGoodsById(orderCfg.requireItemList[1].id).num
  if num > haveNum then
    return
  end
  local deliverList = {}
  local itemId = orderCfg.requireItemList[1].id
  table.insert(deliverList, {
    id = tostring(itemId),
    num = num
  })
  Net:SendProto("future.deliver_team_order", function(json)
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    DataModel.UpdateOrderData()
    if json.fail then
      if tonumber(json.fail) == 1 then
        CommonTips.OpenTips(80610824)
      elseif tonumber(json.fail) == 2 then
        CommonTips.OpenTips(80610824)
      elseif tonumber(json.fail) == 3 then
        CommonItem.OpenTips(80611022)
      end
    else
      CommonTips.OpenTips(80610988)
      DataModel.RefreshDeliverItems(deliverList)
    end
    Controller:RefreshOrderPanel()
  end, DataModel.CurrentSelectOrderUId, Json.encode(deliverList))
end

function Controller:TryGetTeamOrderReward()
  if DataModel.CurrentOrderIndex == 0 then
    return
  end
  Net:SendProto("future.rec_reward_team_order", function(json)
    if json.reward then
      CommonTips.OpenShowItem(json.reward)
    end
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
  end, DataModel.CurrentSelectOrderUId)
end

function Controller:OpenGetWayPanel(posX)
  local data = {}
  local id = DataModel.GetOrderInfo().id
  local orderCfg = PlayerData:GetFactoryData(id)
  local productionCfg = PlayerData:GetFactoryData(orderCfg.requireProduction)
  if productionCfg.unlock and productionCfg.unlock > 0 then
    data.itemID = productionCfg.unlock
  end
  data.posX = posX or 270
  data.posY = -61
  UIManager:Open("UI/Common/Group_GetWay", Json.encode(data))
end

function Controller:GoToProduct()
  local order = DataModel.GetOrderInfo()
  local orderCfg = PlayerData:GetFactoryData(order.id)
  local productionCfg = PlayerData:GetFactoryData(orderCfg.requireProduction)
  local getWay = productionCfg.Getway[1]
  local uiPath = getWay.UIName
  local jumpParams = getWay.Way3
  if jumpParams ~= "" then
    local data = {jumpParams = jumpParams}
    local id = tonumber(jumpParams)
    local isMake = false
    if id and DataManager:GetFactoryNameById(id) == "ProductionFactory" then
      local getWayDataModel = require("UIGroup_GetWay/UIGroup_GetWayDataModel")
      data = getWayDataModel.GetMakeFurSkipInfo(id)
      if data.notfind then
        UIManager:Open("UI/Home_MachiningMenu/Home_MachiningMenu")
        CommonTips.OpenTips(80609971)
        return
      end
      if data.lock then
        UIManager:Open(uiPath, Json.encode(data))
        CommonTips.OpenTips(80608624)
        return
      end
      isMake = true
    end
    local skipPanel = UIManager:GetPanel(uiPath)
    if isMake and skipPanel and skipPanel.IsActive then
      local path = UIManager:GetCurrentPanelURL()
      if path == uiPath then
        UIManager:CloseTip()
        UIManager:CloseTip()
      else
        UIManager:GoBack(false)
      end
      require("UIHome_MachiningLathe/HomeMakeFurController").OpenChoosePanel(data.productionId)
    else
      UIManager:Open(uiPath, Json.encode(data))
    end
  end
end

function Controller:ShowTeamOrderPanel()
  View.Group_Order.Group_TeamOrderWindow:SetActive(true)
  local isOpen = PlayerData.ServerData.user_info.future_base_info.open_orders[DataModel.CurrentSelectOrderUId] ~= nil
  View.Group_Order.Group_TeamOrderWindow.Group_Public.Btn_NoPublic:SetActive(not isOpen)
  View.Group_Order.Group_TeamOrderWindow.Group_Public.Btn_Public:SetActive(isOpen or DataModel.CurrentOrderTab == 2)
  View.Group_Order.Group_TeamOrderWindow.Group_Public:SetActive(DataModel.CurrentOrderTab == 1)
  View.Group_Order.Group_TeamOrderWindow.Btn_Exit:SetActive(DataModel.CurrentOrderTab == 2)
  local require = PlayerData:GetFactoryData(99900134).teamRepLimit
  View.Group_Order.Group_TeamOrderWindow.Img_Tips.Txt_:SetText(string.format(GetText(80610659), require))
  local orderInfo = DataModel.GetOrderInfo()
  local teamData = orderInfo.team or {}
  local teamMemberCount = table.count(teamData)
  for i = 1, 4 do
    local element = View.Group_Order.Group_TeamOrderWindow.Group_Buff.Img_BuffBG["Img_" .. i]
    local buffValue = DataModel.GetOrderBuffValue(i + 1)
    element.Txt_1:SetText("+" .. buffValue .. "%")
    element.Txt_2:SetText("+" .. buffValue .. "%")
    element.Txt_2:SetActive(i > teamMemberCount)
  end
  Controller:RefreshTeamOrderMember()
end

function Controller:ShowTeamInvitePanel()
  DataModel.OrderChooseFriendList = {}
  DataModel.OrderCanInviteFriendList = {}
  Net:SendProto("future.can_invite_list", function(json)
    DataModel.RefreshInviteFriendData(json.invite_data)
    Controller:RefreshTeamInvite()
  end, DataModel.CurrentSelectOrderUId)
end

function Controller:SetTeamInviteElement(element, elementIndex)
  local data = DataModel.OrderCanInviteFriendList[elementIndex]
  if not data then
    return
  end
  element.Txt_UID:SetText("UID:" .. data.uid)
  if data.avatar and PlayerData:GetFactoryData(data.avatar) and PlayerData:GetFactoryData(data.avatar).imagePath then
    element.Img_Head.Img_Mask.Img_Character:SetSprite(PlayerData:GetFactoryData(data.avatar).imagePath)
  else
    element.Img_Head.Img_Mask.Img_Character:SetSprite("")
  end
  element.Txt_Name:SetText(data.name or "")
  element.Txt_Frame:SetText(string.format(GetText(80610662), data.rep or 0))
  element.Img_Pick:SetActive(DataModel.OrderChooseFriendList[tostring(data.uid)] == 1)
  element.Btn_:SetClickParam(elementIndex)
end

function Controller:RefreshTeamInvite()
  View.self:StartC(LuaUtil.cs_generator(function()
    coroutine.yield(CS.UnityEngine.WaitForSeconds(0.01))
    View.Group_Order.Group_TeamArray:SetActive(true)
    View.Group_Order.Group_TeamArray.ScrollGrid_Friend.grid.self:SetDataCount(table.count(DataModel.OrderCanInviteFriendList))
    View.Group_Order.Group_TeamArray.ScrollGrid_Friend.grid.self:RefreshAllElement()
  end))
end

function Controller:ChooseOrderFriend(idx)
  local uid = DataModel.OrderCanInviteFriendList[idx].uid
  if DataModel.OrderChooseFriendList[tostring(uid)] == 1 then
    DataModel.OrderChooseFriendList[tostring(uid)] = nil
  else
    DataModel.OrderChooseFriendList[tostring(uid)] = 1
  end
  Controller:RefreshTeamInvite()
end

function Controller:TryInviteFriend()
  if table.count(DataModel.OrderChooseFriendList) == 0 then
    return
  end
  local friendStr = ""
  local count = 0
  for i, v in pairs(DataModel.OrderChooseFriendList) do
    count = count + 1
    if count < table.count(DataModel.OrderChooseFriendList) then
      friendStr = friendStr .. i .. ","
    else
      friendStr = friendStr .. i
    end
  end
  local orderCfg = DataModel.GetOrderInfo()
  if not orderCfg or next(orderCfg) == nil then
    View.Group_Order.Group_TeamArray:SetActive(false)
    return
  end
  if orderCfg.endTime and 0 < orderCfg.endTime and orderCfg.endTime < TimeUtil:GetServerTimeStamp() then
    CommonTips.OpenTips(80610824)
    return
  end
  Net:SendProto("future.invite", function(json)
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
    if json.fail then
      if tonumber(json.fail) == 1 then
        CommonTips.OpenTips(80610824)
      elseif tonumber(json.fail) == 2 then
        CommonTips.OpenTips(80610782)
      end
    end
    View.Group_Order.Group_TeamArray:SetActive(false)
  end, DataModel.CurrentSelectOrderUId, friendStr)
end

function Controller:UpdateOrderTime()
  if DataModel.CurOrderEndTime and DataModel.CurOrderEndTime > 0 then
    local remainTime = DataModel.CurOrderEndTime - TimeUtil:GetServerTimeStamp()
    if remainTime <= 0 then
      DataModel.CurOrderEndTime = 0
      Net:SendProto("future.main", function(json)
        if json.future_base_info then
          PlayerData.ServerData.user_info.future_base_info = json.future_base_info
        end
        if json.join_my_orders then
          PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
        end
        if json.join_other_orders then
          PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
        end
        if json.all_user_future_activity then
          PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
        end
        DataModel.UpdateOrderData()
        Controller:RefreshOrderPanel()
      end)
    else
      local timeTable = TimeUtil:SecondToTableHMS(remainTime)
      View.Group_Order.Group_Right.Img_SingleOrder.Group_AfterGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
      View.Group_Order.Group_Right.Img_TeamOrder.Group_AfterGet.Group_TimeLimit.Txt_Time:SetText(string.format("%02d:%02d:%02d", timeTable.hour, timeTable.minute, timeTable.second))
    end
  end
end

function Controller:TryChangeOrderLock(elementIndex, isLock)
  if DataModel.CurrentOrderTab == 2 then
    return
  end
  if not elementIndex or elementIndex == 0 then
    return
  end
  if not DataModel.MyOrderInfo[elementIndex] or next(DataModel.MyOrderInfo[elementIndex]) == nil then
    return
  end
  if DataModel.MyOrderInfo[elementIndex].lock == isLock then
    return
  end
  local orderData = DataModel.MyOrderInfo[elementIndex]
  local cfg = PlayerData:GetFactoryData(orderData.id)
  if cfg.isTeam then
    return
  end
  Net:SendProto("future.lock_normal", function(json)
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.all_user_future_activity then
      PlayerData.ServerData.user_info.all_user_future_activity = json.all_user_future_activity
    end
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
  end, orderData.uid, isLock and 1 or 0)
end

function Controller:TryKickTeamMember(idx)
  if DataModel.CurrentOrderTab ~= 1 then
    return
  end
  local orderInfo = DataModel.GetOrderInfo()
  local teamData = orderInfo.team or {}
  local memberData = teamData[idx]
  if not memberData then
    return
  end
  if orderInfo.endTime and orderInfo.endTime > 0 and orderInfo.endTime < TimeUtil:GetServerTimeStamp() then
    CommonTips.OpenTips(80611016)
    return
  end
  CommonTips.OnPrompt(GetText(80610985), nil, nil, function()
    Net:SendProto("future.kick_queue", function(json)
      if json.join_my_orders then
        PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
      end
      if json.join_other_orders then
        PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
      end
      if json.future_base_info then
        PlayerData.ServerData.user_info.future_base_info = json.future_base_info
      end
      if json.fail and json.fail == 1 then
        CommonTips.OpenTips(80610824)
      end
      DataModel.UpdateOrderData()
      Controller:RefreshOrderPanel()
      Controller:ShowTeamOrderPanel()
    end, orderInfo.uid, memberData.uid)
  end)
end

function Controller:TryExitTeam()
  local orderInfo = DataModel.GetOrderInfo()
  if DataModel.CurrentOrderTab ~= 2 then
    return
  end
  if not orderInfo or next(orderInfo) == nil then
    return
  end
  if orderInfo.endTime and orderInfo.endTime > 0 and orderInfo.endTime < TimeUtil:GetServerTimeStamp() then
    CommonTips.OpenTips(80611016)
    return
  end
  Net:SendProto("future.exit_queue", function(json)
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    if json.fail then
      if json.fail == 1 then
        CommonTips.OpenTips(80611042)
      end
    else
      CommonTips.OpenTips(80611041)
    end
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
    View.Group_Order.Group_TeamOrderWindow:SetActive(false)
  end, orderInfo.uid)
end

function Controller:TryGetKickOutReward()
  if DataModel.CurrentOrderTab ~= 2 then
    return
  end
  local orderInfo = DataModel.GetOrderInfo()
  if not orderInfo or next(orderInfo) == nil then
    return
  end
  Net:SendProto("future.remove_being_kick_order", function(json)
    if json.join_my_orders then
      PlayerData.ServerData.user_info.join_my_orders = json.join_my_orders
    end
    if json.join_other_orders then
      PlayerData.ServerData.user_info.join_other_orders = json.join_other_orders
    end
    if json.future_base_info then
      PlayerData.ServerData.user_info.future_base_info = json.future_base_info
    end
    CommonTips.OpenTips(80611039)
    DataModel.UpdateOrderData()
    Controller:RefreshOrderPanel()
  end, orderInfo.uid)
end

function Controller:RefreshSafeBtnShow()
  if not ActivitySafeDataModel or not FastBattleDataModel then
    return
  end
  local isUnlock = ActivitySafeDataModel.GetSafeIsUnlock()
  if isUnlock then
    View.Group_Battle.Group_Left.Group_Safe:SetActive(true)
    View.Group_Battle.Group_Left.Group_Safe.Img_RedPoint:SetActive(FastBattleDataModel.GetAllLeverRewardRedDotState())
  else
    View.Group_Battle.Group_Left.Group_Safe:SetActive(false)
  end
end

function Controller:OnGoToFastBattleBtnClick(row)
  if not row then
    return
  end
  local openType = 1
  local safeType = 1
  local selectIndex = 1
  local t = {}
  if not string.nilorempty(row.switchParameter) then
    local uiParamList = string.split(row.switchParameter, "|") or {}
    openType = tonumber(uiParamList[1]) or 1
    local buildId = tonumber(uiParamList[2]) or 0
    safeType = tonumber(uiParamList[3]) or 1
    if openType == 1 then
      selectIndex = ActivitySafeDataModel.SafeBuildId2Index(buildId)
      if safeType == 2 then
        local isXSOpen = FastBattleDataModel.GetXSTaskIsUnlock(buildId)
        if not isXSOpen then
          local allSafeList = ActivitySafeDataModel.GetAllSafeStationList() or {}
          local firstId = allSafeList[1]
          if firstId and firstId.id then
            isXSOpen = FastBattleDataModel.GetXSTaskIsUnlock(firstId.id)
            if isXSOpen then
              selectIndex = 1
            end
          end
        end
        if not isXSOpen then
          safeType = 1
          selectIndex = 1
        end
      end
    else
      selectIndex = ActivitySafeDataModel.BattleBuildId2Index(buildId)
      if selectIndex == 0 then
        local allBattleList = ActivitySafeDataModel.GetAllBattleStationList() or {}
        local firstId = allBattleList[1]
        if firstId and firstId.id then
          local isBatOpen = ActivitySafeDataModel.GetBattleStationIsUnlock(firstId.id)
          if isBatOpen then
            selectIndex = 1
          end
        end
        if selectIndex == 0 then
          return
        end
      end
    end
    if selectIndex == 0 then
      selectIndex = 1
    end
  end
  t.openType = openType
  t.curSafeType = safeType
  t.curSelectIndex = selectIndex
  t.curLevelIndex = 1
  t.curXsIndex = 1
  UIManager:Open(row.switchUI, Json.encode(t))
end

return Controller
