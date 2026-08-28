local CardPackDataModel = require("UICardPack_Open/UICardPack_OpenDataModel")
local ServerProgressDataModel = require("UIServerProgress/UIServerProgressDataModel")
local PersonalProgressDataModel = require("UIPersonalProgress/UIPersonalProgressDataModel")
local AchievementDataModel = require("UIActivityAchievement/UIActivityAchievementDataModel")
local ServerConstructionDataModel = require("UIServerConstruction/UIServerConstructionDataModel")
local EngineCoreRewardDataModel = require("UIEngineCoreReward/UIEngineCoreRewardDataModel")
local FastBattleDataModel = require("UIFastBattle/UIFastBattleDataModel")
local View = require("UIActivityMain/UIActivityMainView")
local DataModel = {
  NotJoinReward = {},
  LeftList = {},
  LeftActivityCA = {},
  TimeList = {},
  MainList = {},
  PlotList = {},
  OperateList = {},
  LeftListNow = {},
  BlackTeaType = 1,
  BlackTeaTypeList = {
    NotEnabled = 1,
    Finish = 2,
    NotFinish = 3,
    Lock = 4
  },
  CoinId = 11400231,
  ClosePageList = {},
  ActivityCA = {},
  SignInConfig = {},
  CardPackInfo = {},
  ChooseLeftIndex = 1,
  ActivitySignInStateType = {
    NotInTime = 1,
    CanSign = 2,
    Signed = 3
  },
  ActivitySignInStateList = {},
  ActivitySignInCA = {},
  ActivitySignInRewardCA = {},
  ActivitySignNextRefreshTimeStamp = 0,
  Plot1NowQuestId = nil,
  Plot2NowQuestId = nil,
  Plot1Type = 1,
  Plot2Type = 1,
  PlotType = {
    Enabled = 1,
    NotEnabled = 2,
    Lock = 3,
    AllNotFinish = 4,
    AllFinish = 5,
    Quest = 6
  },
  ConstructionType = 1,
  ConstructionTypeList = {
    NotEnabled = 1,
    Enabled = 2,
    Lock = 3
  },
  ConstructionPreviewList = {},
  posXMin = -403,
  posXMax = 391,
  pbLength = 797,
  backToHome = false,
  TabIndex = 1,
  TabType = {
    Time = 1,
    Main = 2,
    Plot = 3,
    Operate = 4
  },
  TabScrollNow = nil
}

function DataModel.Init()
  DataModel.isRefresh = true
  DataModel.backToHome = false
  DataModel.isGoback = false
  DataModel.ChooseLeftIndex = nil
  DataModel.isCityMapIn = false
  DataModel.ActiveList = {}
  local activityTimeList = PlayerData:GetFactoryData(99900059).activityTimeList
  local activityMainList = PlayerData:GetFactoryData(99900059).activityMainList
  local activityPlotList = PlayerData:GetFactoryData(99900059).activityPlotList
  local activityOperateList = PlayerData:GetFactoryData(99900059).activityOperateList
  for k, v in ipairs(activityTimeList) do
    local row = Clone(v)
    row.tabType = "Time"
    table.insert(DataModel.ActiveList, row)
  end
  for k, v in ipairs(activityMainList) do
    local row = Clone(v)
    row.tabType = "Main"
    table.insert(DataModel.ActiveList, row)
  end
  for k, v in ipairs(activityPlotList) do
    local row = Clone(v)
    row.tabType = "Plot"
    table.insert(DataModel.ActiveList, row)
  end
  for k, v in ipairs(activityOperateList) do
    local row = Clone(v)
    row.tabType = "Operate"
    table.insert(DataModel.ActiveList, row)
  end
  DataModel.ClosePageList = {}
  DataModel.LeftConfigList = {}
  DataModel.TabIndex = 1
  DataModel.TabScrollNow = nil
  DataModel.LeftTimeList = {}
end

function DataModel.RefreshActivityData()
  DataModel.LeftList = {}
  DataModel.ClosePageList = {}
  local needCloseActivity = {}
  for k, v in ipairs(DataModel.ActiveList) do
    local activeCA = PlayerData:GetFactoryData(v.id, "ActivityFactory")
    local tagCA = PlayerData:GetFactoryData(v.tag)
    local isOpen = false
    isOpen = DataModel.GetTagTimeIsActive(k)
    local isCountDownNow = false
    local isShowLvNow = false
    local showLv = 1
    local isTaskNow = false
    local taskIndex = 0
    local isShowTradeLvNow
    local showTradeLv = 1
    local remainingTime = 0
    if 0 < activeCA.countDownMax then
      if activeCA.isTriggerTime and activeCA.isJoin and PlayerData:GetActivityAct(activeCA.id) then
        isOpen = true
        isCountDownNow = false
      elseif activeCA.isTriggerTime and (not PlayerData:GetActivityAct(activeCA.id) or not activeCA.isJoin) then
        local timeList = DataModel.IsActiveNewTimeOpen(nil, k)
        remainingTime = timeList.startTime - TimeUtil:GetServerTimeStamp()
        if 0 < remainingTime then
          table.insert(DataModel.LeftTimeList, {
            time = remainingTime,
            countDownMaxTime = v.countDownMax * 86400,
            id = v.id
          })
          if remainingTime < v.countDownMax * 86400 then
            isOpen = true
            isCountDownNow = true
          end
        end
      end
    end
    if activeCA then
      if 1 < activeCA.openLv then
        local openLv = activeCA.openLv
        if openLv > PlayerData:GetPlayerLevel() then
          isShowLvNow = true
          showLv = openLv
        end
      end
      if activeCA.questId ~= -1 then
        local isFinish = PlayerData.IsQuestComplete(activeCA.questId)
        if isFinish == false then
          taskIndex = activeCA.taskIndex
          isTaskNow = true
        end
      end
      if 1 < activeCA.openTradeLv then
        local openTradeLv = activeCA.openTradeLv
        if openTradeLv > PlayerData:GetHomeInfo().trade_lv then
          isShowTradeLvNow = true
          showTradeLv = openTradeLv
        end
      end
    end
    if activeCA.joinLimit and 0 < activeCA.joinLimit then
      isOpen = isOpen and PlayerData.GetPlayerLevel() >= activeCA.joinLimit
    end
    if isOpen and v.isShow == true then
      local row = Clone(v)
      row.tagCA = tagCA
      row.activeCA = activeCA
      row.index = k
      row.timeIndex = 1
      row.finish_index = 1
      row.isCountDownNow = isCountDownNow
      row.remainingTime = remainingTime
      row.isShowLvNow = isShowLvNow
      row.showLv = showLv
      row.isTaskNow = isTaskNow
      row.taskIndex = taskIndex
      row.isShowTradeLvNow = isShowTradeLvNow
      row.showTradeLv = showTradeLv
      if v.isCompleteBottom then
        local isFinish = DataModel.GetLeftActicityIsFinish(activeCA)
        if isFinish then
          row.finish_index = 2
        end
      end
      if row.isCountDownNow then
        row.timeIndex = remainingTime
        row.finish_index = 4
      elseif row.isShowLvNow then
        row.finish_index = 5
      elseif row.isTaskNow then
        row.finish_index = 6
      elseif row.isShowTradeLvNow then
        row.finish_index = 7
      end
      if v.tag == 12601503 then
        local ActivityRandomBattleController = require("UIActivityRandomBattle/UIActivityRandomBattleController")
        local isInTime = ActivityRandomBattleController:JudgeInTime()
        if not isInTime and row.finish_index == 1 then
          row.finish_index = 3
        end
      end
      table.insert(DataModel.LeftList, row)
      needCloseActivity[activeCA.isOnly] = 1
    end
    table.insert(DataModel.ClosePageList, activeCA.showUI)
  end
  local startActivityList = {}
  for i, v in ipairs(DataModel.LeftList) do
    if not needCloseActivity[v.id] then
      table.insert(startActivityList, v)
    end
  end
  DataModel.LeftList = startActivityList
  table.sort(DataModel.LeftList, function(a, b)
    if a.finish_index == b.finish_index then
      if a.timeIndex == b.timeIndex then
        if a.showLv == b.showLv then
          if a.taskIndex == b.taskIndex then
            if a.showTradeLv == b.showTradeLv then
              return a.index < b.index
            end
            return a.showTradeLv < b.showTradeLv
          end
          return a.taskIndex < b.taskIndex
        end
        return a.showLv < b.showLv
      end
      return a.timeIndex < b.timeIndex
    end
    return a.finish_index < b.finish_index
  end)
  if #DataModel.LeftList == 0 then
    UIManager:GoHome()
    return
  end
  DataModel.TimeList = {}
  DataModel.MainList = {}
  DataModel.PlotList = {}
  DataModel.OperateList = {}
  for i, v in ipairs(DataModel.LeftList) do
    if v.tabType == "Main" then
      table.insert(DataModel.MainList, v)
    elseif v.tabType == "Plot" then
      table.insert(DataModel.PlotList, v)
    elseif v.tabType == "Time" then
      table.insert(DataModel.TimeList, v)
    elseif v.tabType == "Operate" then
      table.insert(DataModel.OperateList, v)
    end
  end
  DataModel.LeftListNow = {}
  if DataModel.TabIndex == DataModel.TabType.Main then
    DataModel.LeftListNow = DataModel.MainList
  elseif DataModel.TabIndex == DataModel.TabType.Plot then
    DataModel.LeftListNow = DataModel.PlotList
  elseif DataModel.TabIndex == DataModel.TabType.Time then
    DataModel.LeftListNow = DataModel.TimeList
  elseif DataModel.TabIndex == DataModel.TabType.Operate then
    DataModel.LeftListNow = DataModel.OperateList
  end
end

function DataModel.GetIndex(id)
  if id then
    for i, v in ipairs(DataModel.LeftListNow) do
      if v.id == id then
        return i
      end
    end
    for i, v in ipairs(DataModel.TimeList) do
      if v.id == id then
        DataModel.TabIndex = DataModel.TabType.Time
        return i
      end
    end
    for i, v in ipairs(DataModel.MainList) do
      if v.id == id then
        DataModel.TabIndex = DataModel.TabType.Main
        return i
      end
    end
    for i, v in ipairs(DataModel.PlotList) do
      if v.id == id then
        DataModel.TabIndex = DataModel.TabType.Plot
        return i
      end
    end
    for i, v in ipairs(DataModel.OperateList) do
      if v.id == id then
        DataModel.TabIndex = DataModel.TabType.Operate
        return i
      end
    end
  end
  return 1
end

function DataModel.GetAchievementRed()
  local typeList = AchievementDataModel.AchieveType
  for k, v in pairs(typeList) do
    if AchievementDataModel.GetRedPointStateByType(v) then
      return true
    end
  end
  return false
end

function DataModel.GetLeftActicityIsFinish(activeCA)
  if activeCA.showUI == "Group_SignIn" then
    local isRed, isFinish = PlayerData:GetSignInfoRedState()
    return isFinish
  end
  if activeCA.showUI == "Group_Construction" then
    return ServerConstructionDataModel:GetConstructionIsFinish(activeCA.id)
  end
  if activeCA.id == 86000004 then
    return PlayerData:GetUserInfo().lv > 40 and not DataModel.GetLevelRewardRedPoint()
  end
  if activeCA.id == 86000092 then
    return EngineCoreRewardDataModel.GetIsAllRewardHasGet()
  end
  if activeCA.mod == "\231\153\187\229\189\149\232\167\163\233\148\129\230\140\145\230\136\152" then
    return require("UISignBattleLevel/UISignBattleLevelDataModel"):GetFinish(activeCA.id)
  end
  return false
end

function DataModel.IsLevelRewardAllReceived()
  if not PlayerData:GetHomeInfo().rank_reward then
    return false
  end
  local hasRewardNum = 0
  local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
  for i, v in ipairs(cfg.Playerranklist) do
    local levelCfg = PlayerData:GetFactoryData(v.id, "ListFactory")
    if 0 < table.count(levelCfg.reward) then
      hasRewardNum = hasRewardNum + 1
    end
  end
  return hasRewardNum <= table.count(PlayerData:GetHomeInfo().rank_reward)
end

function DataModel.GetLeftListRedState(id)
  local index, data = DataModel.GetActivityListIndex(id)
  if data == nil then
    local activityCAList = DataModel:GetActivityCAList()
    local activeList = DataModel.ActiveList or activityCAList
    data = activeList[index]
  end
  local activityCfg = PlayerData:GetFactoryData(data.id, "ActivityFactory")
  if activityCfg.countDownMax > 0 then
    local closeRedState = DataModel.GetActivityCloseDownState(data.id, index)
    if closeRedState then
      return true
    end
    local state, remainingTime = DataModel.GetActivityCountDownState(data, index)
    if state or 0 < remainingTime then
      return state
    end
  end
  if id == 86000007 then
    return DataModel.GetGoldWeekRedDotStatus()
  end
  if id == 86000009 then
    return require("UIMonsterActivity/UIMonsterActivityController").PanelRedDotStatus(id)
  end
  if id == 86000038 then
    return require("UIHotelActivity/UIHotelActivityController").PanelRedDotStatus(id)
  end
  if id == 86000044 then
    return require("UIAnniversaryActivity/UIAnniversaryActivityController").PanelRedDotStatus(id)
  end
  if id == 86000031 then
    return require("UIKabaneriActivity/UIKabaneriActivityController").PanelRedDotStatus(id)
  end
  if id == 86000014 then
    return require("UIAnecdoteActivity/UIAnecdoteActivityDataModel").GetRedDotStatus()
  end
  if id == 86000010 then
    return require("UIGroup_EventWeek/UIGroup_EventWeekDataModel").GetRedDotStatus()
  end
  if id == 86000005 then
    local abyssStarFlag, abyssRewardFlag = PlayerData:GetAbyssRedPoint()
    return require("UIActivityBattleBossNew/UIActivityBattleBossNewController"):GetRedDotStatus(id) or abyssStarFlag or abyssRewardFlag
  end
  if id == 86000016 then
    return require("UIIslandActivity/UIIslandActivityDataModel").GetIsLandRedState(id)
  end
  if id == 86000003 then
    return PlayerData:GetSignInfoRedState()
  end
  if id == 86000001 then
    return DataModel.GetAllRedState(id)
  end
  if id == 86000002 then
    return DataModel.GetServerConstructionRedState(id)
  end
  if id == 86000004 then
    return DataModel.GetLevelRewardRedPoint()
  end
  local type
  if 0 < data.tag then
    type = PlayerData:GetFactoryData(data.tag).tagName
  end
  local activeCA = PlayerData:GetFactoryData(id)
  if activeCA.mod == "\230\180\187\229\138\168\231\173\190\229\136\176" then
    return DataModel.GetActivitySignInRedPoint(id)
  end
  if id == 86000017 then
    return require("UIRegression/UIRegressionDataModel").GetReturnRedPoint()
  end
  if id == 86000037 then
    local isInTime = require("UIActivityRandomBattle/UIActivityRandomBattleController"):JudgeInTime()
    local rbConfigCA = PlayerData:GetFactoryData(99900113)
    local isItemEnough = PlayerData:GetGoodsById(rbConfigCA.randomBattleTicketId).num >= rbConfigCA.randomBattleTicketCost
    local needLv = rbConfigCA.randomBattleLv
    local isLvRecive = needLv <= PlayerData:GetPlayerLevel()
    return isLvRecive and isInTime and (isItemEnough or PlayerData.ServerData.rb_id ~= nil and PlayerData.ServerData.rb_id ~= "")
  end
  if activeCA.mod == "\230\151\160\233\153\144\230\183\177\230\184\138" then
    local ebData = PlayerData.ServerData.all_endless_activity[tostring(id)]
    if ebData ~= nil then
      local maxReviveNum = activeCA.endlessRefresh or 0
      local reset_count = ebData.reset_count or 0
      local fail_team = ebData.fail_team
      local diff = ebData.difficulty_level or 1
      return diff <= #activeCA.endlessLevelList and (maxReviveNum > reset_count or table.count(fail_team) < 4)
    end
  end
  if activeCA.mod == "\231\180\175\229\133\133" then
    return require("UIActivityRecharge/UIActivityRechargeController"):InitData(id)
  end
  if activeCA.mod == "\231\153\187\229\189\149\232\167\163\233\148\129\230\140\145\230\136\152" then
    return require("UISignBattleLevel/UISignBattleLevelDataModel"):GetRedState(id)
  end
  if id == 86000069 then
    return require("UIActivityMonthlyCard/UIActivityMonthlyCardDataModel").GetRedState(id)
  end
  if id == 86000026 then
    return require("UIActivityCubeRogue/UIActivityCubeRogueDataModel").GetRedState(id)
  end
  if id == 86000092 then
    return EngineCoreRewardDataModel.GetCoreRewardRedState()
  end
  if id == 86000096 then
    return FastBattleDataModel.GetMainActivityRedDotState()
  end
  if id == 86000117 then
    return PlayerData.GetWorldBossRedDotState(id)
  end
  if id == 86000067 then
    return require("UIIronSagaActivity/UIIronSagaActivityController").PanelRedDotStatus(id)
  end
  if id == 86000173 then
    return require("UIMistSequenceActivity/UIMistSequenceActivityController").PanelRedDotStatus(id)
  end
  if activeCA.mod == "\232\189\172\231\155\152\230\180\187\229\138\168" then
    return require("UIActivityTurntable/UIActivityTurntableDataModel").GetTurntableAcyRedDotState(id)
  end
  if id == 86000139 then
    return require("UIBulletTrainActivity/UIBulletTrainActivityController").PanelRedDotStatus(id)
  end
  if id == 86000253 then
    return require("UIFireActivity/UIFireActivityController").PanelRedDotStatus(id)
  end
  if id == 86000283 then
    return require("UIFlameActivity/UIFlameActivityController").PanelRedDotStatus(id)
  end
  if id == 86000305 then
    return require("UIVacationActivity/UIVacationActivityController").PanelRedDotStatus(id)
  end
  if id == 86000321 then
    return require("UIWulinActivity/UIWulinActivityController").PanelRedDotStatus(id)
  end
  if id == 86000334 then
    return require("UIWulinActivity/UIWulinActivityController").PanelRedDotStatus(id)
  end
end

function DataModel:QuestIsFinish(questId)
  if questId == nil then
    return false
  end
  local type = PlayerData.GetQuestState(questId)
  if type == EnumDefine.EQuestState.UnFinish or type == EnumDefine.EQuestState.Lock then
    return false
  end
  return true
end

function DataModel.GetAllRedState(activityId)
  local activityCA = PlayerData:GetFactoryData(activityId)
  if activityCA.activityCardPack > 0 then
    DataModel.CardPackInfo = CardPackDataModel.GetCardPackInfo(activityCA.activityCardPack)
    if DataModel.CardPackInfo.extraCardStatus == 1 then
      return true
    end
  end
  local isActive = DataModel.GetTagTimeIsActive(nil, activityId)
  if isActive then
    local timeList = DataModel.IsActiveNewTimeOpen(activityId)
    if timeList.isActive and activityCA.questId ~= -1 and DataModel:QuestIsFinish(activityCA.questId) == true then
      if PlayerData:GetActivityData(activityId) == nil then
        return true
      end
      if PlayerData:GetActivityData(activityId).red ~= nil then
        return PlayerData:GetActivityData(activityId).red
      end
    end
  end
  if ServerProgressDataModel.GetRedPointState() then
    return true
  end
  if PersonalProgressDataModel.GetRedPointState() then
    return true
  end
  if DataModel.GetAchievementRed() then
    return true
  end
  return false
end

function DataModel.GetServerConstructionRedState(activityId)
  if activityId == nil then
    return false
  end
  local activityCA = PlayerData:GetFactoryData(activityId)
  if activityCA.questId ~= "" then
    local type = PlayerData.GetQuestState(activityCA.questId)
    if type ~= EnumDefine.EQuestState.Finish and type ~= EnumDefine.EQuestState.Receive then
      return false
    end
  end
  if activityCA.activityCardPack > 0 then
    DataModel.CardPackInfo = CardPackDataModel.GetCardPackInfo(activityCA.activityCardPack)
    if DataModel.CardPackInfo.extraCardStatus == 1 then
      return true
    end
  end
  local isActive = DataModel.GetTagTimeIsActive(nil, activityId)
  if isActive then
    local timeList = DataModel.IsActiveNewTimeOpen(activityId)
    if timeList.isActive then
      if PlayerData:GetActivityData(activityId) == nil then
        return true
      end
      if PlayerData:GetActivityData(activityId).red ~= nil then
        return PlayerData:GetActivityData(activityId).red
      end
    end
  end
  if ServerConstructionDataModel:GetRedPointState("all", activityId) then
    return true
  end
  if ServerConstructionDataModel:GetRedPointState("one", activityId) then
    return true
  end
  return false
end

function DataModel.GetLevelRewardRedPoint()
  local rankReward = {}
  for i, v in pairs(PlayerData:GetHomeInfo().rank_reward) do
    rankReward[v] = 1
  end
  local userLv = PlayerData:GetUserInfo().lv
  local cfg = PlayerData:GetFactoryData(99900051, "ConfigFactory")
  for i = 1, table.count(cfg.Playerranklist) do
    local info = cfg.Playerranklist[i]
    if userLv >= info.level and not rankReward[info.level] then
      return true
    end
  end
  return false
end

function DataModel.GetActivitySignInRedPoint(id)
  local activeCA
  if not id then
    activeCA = DataModel.ActivityCA
  else
    activeCA = PlayerData:GetFactoryData(id)
  end
  if activeCA and activeCA.mod and activeCA.mod == "\230\180\187\229\138\168\231\173\190\229\136\176" then
    local signInCA = PlayerData:GetFactoryData(activeCA.signinId)
    local totalDay = signInCA.totalDays
    local serverData = PlayerData:GetSignInfo()[tostring(activeCA.signinId)]
    if serverData then
      return serverData.need >= 1 and totalDay > serverData.count
    end
  end
  return false
end

function DataModel.RefreshSignInStateList()
  local serverData = PlayerData:GetSignInfo()[tostring(DataModel.ActivityCA.signinId)]
  if serverData then
    local totalDay = DataModel.ActivitySignInCA.totalDays
    for i = 1, totalDay do
      if i <= serverData.count then
        DataModel.ActivitySignInStateList[i] = DataModel.ActivitySignInStateType.Signed
      elseif i <= serverData.count + serverData.need then
        DataModel.ActivitySignInStateList[i] = DataModel.ActivitySignInStateType.CanSign
      else
        DataModel.ActivitySignInStateList[i] = DataModel.ActivitySignInStateType.NotInTime
      end
    end
  end
end

function DataModel.SetNextRefreshListTime()
  DataModel.ActivitySignNextRefreshTimeStamp = 0
  local activeList = DataModel:GetActivityCAList()
  for k, v in pairs(activeList) do
    local activityCA = PlayerData:GetFactoryData(v.id)
    if activityCA.mod == "\230\180\187\229\138\168\231\173\190\229\136\176" and TimeUtil:IsActive(activityCA.startTime, activityCA.rewardEndTime) then
      local rewardEndTimeStamp = TimeUtil:TimeStamp(activityCA.rewardEndTime)
      if DataModel.ActivitySignNextRefreshTimeStamp == 0 or rewardEndTimeStamp <= DataModel.ActivitySignNextRefreshTimeStamp then
        DataModel.ActivitySignNextRefreshTimeStamp = rewardEndTimeStamp
      end
    end
  end
  if View.timer ~= nil then
    if DataModel.ActivitySignNextRefreshTimeStamp > 0 then
      View.timer:Resume()
    else
      View.timer:Stop()
      View.timer = nil
    end
  end
end

function DataModel.GetActivityCountDownState(data, key)
  local remainingTime = 0
  local timeList = DataModel.IsActiveNewTimeOpen(nil, key)
  remainingTime = timeList.startTime - TimeUtil:GetServerTimeStamp()
  if 0 < remainingTime and remainingTime < data.countDownMax * 86400 and PlayerData:GetPlayerPrefs("int", "ActivityCountDown" .. data.id) == 0 then
    return true, remainingTime
  end
  return false, remainingTime
end

function DataModel.GetActivityCloseDownState(id, key)
  local defaultConfig = PlayerData:GetFactoryData(99900059)
  if not defaultConfig then
    return false
  end
  local dayRedPoint = defaultConfig.dayRedPoint or 0
  local remainingTime = 0
  local timeList = DataModel.IsActiveNewTimeOpen(nil, key)
  remainingTime = timeList.startTime - TimeUtil:GetServerTimeStamp()
  if remainingTime <= 0 then
    return false
  end
  local remainTimeTab = TimeUtil:SecondToTable(remainingTime)
  if dayRedPoint >= remainTimeTab.day then
    local day = 0
    local timeTable = TimeUtil:GetLogicServerDayTable()
    if timeTable then
      day = timeTable.day or 0
    end
    if timeTable.hour >= 5 and 0 < day then
      local lastDay = PlayerData:GetPlayerPrefs("int", "LastActivityLoginDay" .. id)
      if lastDay == 0 or lastDay ~= day then
        PlayerData:SetPlayerPrefs("int", "ActivityCloseCountDown" .. id, 0)
      end
      if PlayerData:GetPlayerPrefs("int", "ActivityCloseCountDown" .. id) == 0 then
        return true
      end
    end
  end
  return false
end

function DataModel.GetMainAllRedState()
  local ActivityCA = DataModel:GetActivityCAList()
  DataModel.ActivityCA = {}
  for k, v in pairs(ActivityCA) do
    if DataModel.GetLeftListRedState(v.id) then
      return true
    end
  end
  return false
end

function DataModel.GetMainRed()
  for i, v in ipairs(DataModel.MainList) do
    if DataModel.GetLeftListRedState(v.id) then
      return true
    end
  end
  return false
end

function DataModel.GetPlotRed()
  for i, v in ipairs(DataModel.PlotList) do
    if DataModel.GetLeftListRedState(v.id) then
      return true
    end
  end
  return false
end

function DataModel.GetTimeRed()
  for i, v in ipairs(DataModel.TimeList) do
    if DataModel.GetLeftListRedState(v.id) then
      return true
    end
  end
  return false
end

function DataModel.GetOperateRed()
  for i, v in ipairs(DataModel.OperateList) do
    if DataModel.GetLeftListRedState(v.id) then
      return true
    end
  end
  return false
end

function DataModel.GetGoldWeekRedDotStatus()
  local recordTime = PlayerData:GetPlayerPrefs("int", "GoldWeekRedDotInfo")
  local severTime = TimeUtil:GetServerTimeStamp()
  local reallyTime = recordTime == 0 and severTime or recordTime
  local newDate = os.date("*t", reallyTime)
  local resetTime = os.time({
    year = newDate.year,
    month = newDate.month,
    day = newDate.day,
    hour = 0,
    minute = 0,
    second = 0
  })
  local days = (severTime - resetTime) / 24 / 60 / 60
  if 1 <= days or recordTime == 0 then
    return true
  end
  return false
end

function DataModel.GetPlayerFirstLoginTime()
  return PlayerData:GetUserInfo().add_time
end

function DataModel.GetActivityListIndex(activityId)
  local index = 1
  if activityId == nil then
    return index
  end
  local activityCAList = DataModel:GetActivityCAList()
  local activeList = DataModel.ActiveList or activityCAList
  for k, v in pairs(activeList) do
    if v.id == activityId then
      return k, v
    end
  end
  return index
end

function DataModel.GetActivityData(key, activityId)
  if activityId == nil and key == nil then
    return nil
  end
  local index = 1
  local tagCA
  if key then
    index = key
  else
    index, tagCA = DataModel.GetActivityListIndex(activityId)
  end
  if tagCA == nil then
    local activityCAList = DataModel:GetActivityCAList()
    local activeList = DataModel.ActiveList or activityCAList
    tagCA = activeList[index]
  end
  local activeCA = PlayerData:GetFactoryData(tagCA.id)
  return tagCA, activeCA
end

function DataModel.GetTagTimeIsActive(key, activityId)
  local tagCA, activeCA = DataModel.GetActivityData(key, activityId)
  if tagCA == nil or activeCA == nil then
    return false
  end
  local isActive = false
  if activeCA.mod == "\230\180\187\229\138\168\231\173\190\229\136\176" then
    local signinId = activeCA.signinId
    local serverData = PlayerData:GetSignInfo()[tostring(signinId)]
    if serverData and serverData.count + serverData.need > 0 then
      isActive = TimeUtil:IsActive(activeCA.startTime, activeCA.rewardEndTime)
    else
      isActive = TimeUtil:IsActive(activeCA.startTime, activeCA.endTime)
    end
  elseif tonumber(activeCA.id) == 86000017 then
    if PlayerData.ServerData.return_info and PlayerData.ServerData.return_info.ret_ts ~= 0 then
      local delayDay = PlayerData:GetFactoryData(86000017).continueTime
      if PlayerData.ServerData.return_info.ret_reward == false then
        isActive = true
      elseif PlayerData.ServerData.return_info.ret_reward and PlayerData.ServerData.return_info.ret_ts + delayDay * 86400 >= TimeUtil:GetServerTimeStamp() then
        isActive = true
      end
    end
  elseif activeCA.mod == "\231\153\187\229\189\149\232\167\163\233\148\129\230\140\145\230\136\152" then
    local SignBattleLevelDataModel = require("UIActivitySignBattleLevel/UIActivitySignBattleLevelDataModel")
    if SignBattleLevelDataModel.signBattleData[tostring(activeCA.id)] then
      local end_ts = SignBattleLevelDataModel.signBattleData[tostring(activeCA.id)].end_ts
      local end_time = os.time(TimeUtil:GetNewTimeTable(end_ts))
      if SignBattleLevelDataModel.signBattleData[tostring(activeCA.id)].unlock_level_max_index and end_time >= TimeUtil:GetServerTimeStamp() then
        isActive = true
      end
    end
  elseif activeCA.isTriggerTime and (not PlayerData:GetActivityAct(activeCA.id) or not activeCA.isJoin) then
    local startTime = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, DataModel.GetPlayerFirstLoginTime() + activeCA.putTime * 86400)
    if activeCA.continueTime == -1 then
      if startTime <= TimeUtil:GetServerTimeStamp() then
        isActive = true
      end
    else
      local endTime = startTime + activeCA.continueTime * 86400
      local endCloseTime = startTime + activeCA.closeTime * 86400
      local acEndTime = math.max(endTime, endCloseTime)
      if startTime <= TimeUtil:GetServerTimeStamp() and acEndTime >= TimeUtil:GetServerTimeStamp() and startTime <= TimeUtil:GetServerTimeStamp() then
        isActive = true
      end
    end
  else
    isActive = TimeUtil:IsActive(tagCA.startTime, tagCA.endTime)
  end
  if isActive and activeCA.mod == "\231\173\190\229\136\176" then
    local regisTime = PlayerData:GetUserInfo().add_time or 0
    if activeCA.signRegisterStartTime ~= "" then
      local startTime = TimeUtil:TimeStamp(activeCA.signRegisterStartTime)
      isActive = regisTime >= startTime
    end
    if isActive and activeCA.signRegisterEndTime ~= "" then
      local endTime = TimeUtil:TimeStamp(activeCA.signRegisterEndTime)
      isActive = regisTime <= endTime
    end
  end
  return isActive
end

function DataModel.IsActiveNewTimeOpen(activityId, key)
  local tagCA, activeCA = DataModel.GetActivityData(key, activityId)
  if tagCA == nil or activeCA == nil then
    return nil
  end
  local list = {}
  local isActive = false
  local isContinue = false
  local putTime = activeCA.putTime or 0
  local continueTime = activeCA.continueTime
  local closeTime = activeCA.closeTime
  local startTime = ""
  local acEndTime = ""
  if activeCA.isTriggerTime then
    startTime = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, DataModel.GetPlayerFirstLoginTime() + putTime * 86400)
    if continueTime == -1 then
      isContinue = true
      if startTime <= TimeUtil:GetServerTimeStamp() then
        isActive = true
      end
    else
      local endTime = startTime + continueTime * 86400
      local endCloseTime = startTime + closeTime * 86400
      acEndTime = math.max(endTime, endCloseTime)
      if startTime <= TimeUtil:GetServerTimeStamp() and acEndTime >= TimeUtil:GetServerTimeStamp() and startTime <= TimeUtil:GetServerTimeStamp() then
        isActive = true
      end
    end
  else
    startTime = TimeUtil:TimeStamp(activeCA.startTime)
    if activeCA.endTime == "" then
      isContinue = true
    else
      acEndTime = TimeUtil:TimeStamp(activeCA.endTime)
    end
    isActive = TimeUtil:IsActive(activeCA.startTime, activeCA.endTime)
  end
  list.isActive = isActive
  list.isContinue = isContinue
  list.startTime = startTime
  list.acEndTime = acEndTime
  return list
end

function DataModel.GetActivityTipsIndex(activityId)
  local tagCA, activeCA = DataModel.GetActivityData(nil, activityId)
  if tagCA == nil or activeCA == nil then
    return ""
  end
  if activeCA.openTipsType ~= "normal" then
    return ""
  end
  local index = ""
  local isContinue = false
  local putTime = activeCA.putTime or 0
  local continueTime = activeCA.continueTime
  local closeTime = activeCA.closeTime
  local startTime = ""
  local acEndTime = ""
  if activeCA.isTriggerTime then
    local startTime_1 = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, DataModel.GetPlayerFirstLoginTime() + (putTime - 1) * 86400)
    local startTime_2 = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, DataModel.GetPlayerFirstLoginTime() + putTime * 86400)
    startTime = TimeUtil:GetFutureTimeBySomeTimeStamp(0, 5, DataModel.GetPlayerFirstLoginTime() + putTime * 86400)
    if continueTime == -1 then
      isContinue = true
      if startTime_1 <= TimeUtil:GetServerTimeStamp() and startTime_2 > TimeUtil:GetServerTimeStamp() then
        index = 1
      elseif startTime_2 <= TimeUtil:GetServerTimeStamp() then
        index = 2
      end
    else
      local endTime = startTime + continueTime * 86400
      local endCloseTime = startTime + closeTime * 86400
      acEndTime = math.max(endTime, endCloseTime)
      if acEndTime >= TimeUtil:GetServerTimeStamp() then
        if startTime_1 <= TimeUtil:GetServerTimeStamp() and startTime_2 > TimeUtil:GetServerTimeStamp() then
          index = 1
        elseif startTime_2 <= TimeUtil:GetServerTimeStamp() then
          index = 2
        end
      end
    end
  end
  return index
end

function DataModel.GetActivityCAList()
  local list = {}
  local activityTimeList = PlayerData:GetFactoryData(99900059).activityTimeList
  local activityMainList = PlayerData:GetFactoryData(99900059).activityMainList
  local activityPlotList = PlayerData:GetFactoryData(99900059).activityPlotList
  local activityOperateList = PlayerData:GetFactoryData(99900059).activityOperateList
  for k, v in ipairs(activityTimeList) do
    table.insert(list, v)
  end
  for k, v in ipairs(activityMainList) do
    table.insert(list, v)
  end
  for k, v in ipairs(activityPlotList) do
    table.insert(list, v)
  end
  for k, v in ipairs(activityOperateList) do
    table.insert(list, v)
  end
  return list
end

return DataModel
