local base = require("Game.ActivityFrame.ActivityBase")
local HeroGrowV3Data = class("ActivityHeroGrow", base)
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")
local HeroGrowV3NormalData = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3NormalData")
local DungeonLevelActHGV3Repeat = require("Game.ActivityHeroGrowV3.Data.DungeonLevelActHGV3Repeat")
local ActHGV3Enum = require("Game.ActivityHeroGrowV3.Data.ActHGV3Enum")
local TaskEnum = require("Game.Task.TaskEnum")

function HeroGrowV3Data:ctor()
  self.actId = nil
  self.__mainCfg = nil
  self.__uiCfg = nil
  self.__rebrush_dungeonCfg = nil
  self.dunRepeat = nil
  self.__normalDataDic = nil
end

function HeroGrowV3Data:InitHeroGrowV3Data(actFrameData)
  self:SetActFrameData(actFrameData)
  self.actId = actFrameData:GetActId()
  self.__mainCfg = ConfigData.activity_herolite_main[self.actId]
  self.__uiCfg = ConfigData.activity_herolite_ui_config[self.actId]
  self.__tokenCfg = ConfigData.activity_herolite_token_reward[self.actId]
  self.__rebrush_dungeonCfg = ConfigData.activity_herolite_rebrush_dungeon[self.actId]
  self.__taskCfg = ConfigData.activity_herolite_task_daily[self.actId]
  self:InitDunRepeat()
  self:InitNormalData()
  self:RefreshNormalNewRed()
  self:RefreshChallengeNewRed()
  self:RefreshRepeatHaveTicketRed()
end

function HeroGrowV3Data:InitNormalData()
  self.__normalDataDic = {}
  local normalCfgDic = ConfigData.activity_herolite_normal_dungeon[self.actId]
  for _, type in pairs(HeroGrowV3Enum.HGV3NormalQuestType) do
    local cfg = normalCfgDic[type]
    self.__normalDataDic[type] = HeroGrowV3NormalData.New(cfg, self.actId)
  end
end

function HeroGrowV3Data:RefreshHeroGrowV3Data(msg)
  self._costNum = msg.costNum
  self._dailyTaskFullRewardDic = {}
  for index, dailyTaskState in ipairs(msg.dailyTaskFullReward) do
    self._dailyTaskFullRewardDic[index] = 0 < dailyTaskState
  end
  self._finishedDailyTaskDic = {}
  for _, taskId in ipairs(msg.FinishedDailyTask) do
    self._finishedDailyTaskDic[taskId] = true
  end
  self._tokenRewardLevelDic = {}
  for i, level in ipairs(msg.tokenRewardLevel) do
    self._tokenRewardLevelDic[level] = true
  end
  MsgCenter:Broadcast(eMsgEventId.HeroGrowActivityUpdate, self)
  self:RefreshHeroGrowV3AllReddot()
end

function HeroGrowV3Data:RefreshHeroGrowV3AllReddot()
  self:RefreshDailyTaskNewRed()
  self:RefreshDailyTaskComRed()
  self:RefreshBPRewardComRed()
end

function HeroGrowV3Data:RefreshDailyTaskNewRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.DailyTaskNew)
  if redDot == nil then
    return
  end
  local reddotNum = 0
  for day, _ in pairs(self._dailyTaskFullRewardDic) do
    if not self:IsLookedHeroGrowDailyTask(day) then
      reddotNum = 1
      break
    end
  end
  redDot:SetRedDotCount(reddotNum)
end

function HeroGrowV3Data:RefreshDailyTaskComRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.DailyTaskCom)
  if redDot == nil then
    return
  end
  local isHaveCom = self:IsHeroGrowExistTaskReceive()
  local redDotNum = isHaveCom and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function HeroGrowV3Data:RefreshBPRewardComRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.BPRewardCom)
  if redDot == nil then
    return
  end
  local isHaveReward = self:IsHeroGrowExistLvReward()
  local redDotNum = isHaveReward and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function HeroGrowV3Data:RefreshNormalNewRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.NormalNew)
  if redDot == nil then
    return
  end
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLooked = userData:GetHeroGrowV3IsLookedNormalNew(self:GetActId())
  local redDotNum = not isLooked and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function HeroGrowV3Data:RefreshChallengeNewRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.ChallengeNew)
  if redDot == nil then
    return
  end
  local userData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isLooked = userData:GetHeroGrowV3IsLookedChallengeNew(self:GetActId())
  local redDotNum = not isLooked and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function HeroGrowV3Data:RefreshChallengeRewardRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.ChallengeReward)
  if redDot == nil then
    return
  end
  local isHaveReward = self:GetChallengeAchievementCanPick()
  local redDotNum = isHaveReward and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function HeroGrowV3Data:RefreshRepeatHaveTicketRed()
  local redDot = self:GetActChildRedDot(ActHGV3Enum.reddotType.RepeatHaveTicket)
  if redDot == nil then
    return
  end
  local itemId = self:GetHGV3RepeatTicketId()
  local num = PlayerDataCenter:GetItemCount(itemId)
  local redDotNum = 0 < num and 1 or 0
  redDot:SetRedDotCount(redDotNum)
end

function HeroGrowV3Data:LookedHeroGrowDailyTaskNewReddot(day)
  if self:IsLookedHeroGrowDailyTask(day) then
    return
  end
  self._dailyTaskLookDic[day] = true
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetHeroGrowV3DailyTask(self:GetActId(), day)
  self:RefreshDailyTaskNewRed()
end

function HeroGrowV3Data:LookedHGV3NormalNewReddot()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetHeroGrowV3IsLookedNormalNew(self:GetActId())
  self:RefreshNormalNewRed()
end

function HeroGrowV3Data:LookedHGV3ChallengeNewReddot()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetHeroGrowV3IsLookedChallengeNew(self:GetActId())
  self:RefreshChallengeNewRed()
end

function HeroGrowV3Data:GetIsHaveRedDotByType(type)
  local redDot = self:GetActChildRedDot(type)
  if redDot == nil then
    return false
  end
  return redDot:GetRedDotCount() > 0
end

function HeroGrowV3Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActHGV3Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function HeroGrowV3Data:GetActId()
  return self.actId
end

function HeroGrowV3Data:GetMainCfg()
  return self.__mainCfg
end

function HeroGrowV3Data:GetUIConfig()
  return self.__uiCfg
end

function HeroGrowV3Data:GetTokenConfig()
  return self.__tokenCfg
end

function HeroGrowV3Data:InitDunRepeat()
  local cfg = self:GetHGV3ReBrushCfg()
  local dungeonId = cfg.dungeon_id
  self.dunRepeat = DungeonLevelActHGV3Repeat.New(dungeonId, self)
  self.dunRepeat:SetRepeatDgLvReturnFunc(function()
    local mainWin = UIManager:GetWindow(UIWindowTypeID.CharDunVer3)
    if mainWin then
      mainWin:OnClickRepeat()
    end
    local aftertTeatmentCtrl = ControllerManager:GetController(ControllerTypeId.BattleResultAftertTeatment)
    if aftertTeatmentCtrl ~= nil then
      aftertTeatmentCtrl:TeatmentBengin()
    end
  end)
end

function HeroGrowV3Data:GetTaskConfig()
  return self.__taskCfg
end

function HeroGrowV3Data:GetHGV3DunRepeatData()
  return self.dunRepeat
end

function HeroGrowV3Data:GetHGV3ReBrushCfg()
  return self.__rebrush_dungeonCfg
end

function HeroGrowV3Data:GetHGV3HeroId()
  return self.__mainCfg.hero_id
end

function HeroGrowV3Data:GetHGV3FriendShipUpPercent()
  return tostring(self.__mainCfg.friendship_display)
end

function HeroGrowV3Data:GetHGV3RuleDes()
  return self.__mainCfg.task_rule_title, self.__mainCfg.task_rule_id
end

function HeroGrowV3Data:GetHGV3HeroName()
  local heroId = self:GetHGV3HeroId()
  local heroCfg = ConfigData.hero_data[heroId]
  return LanguageUtil.GetLocaleText(heroCfg.name_en), LanguageUtil.GetLocaleText(heroCfg.name)
end

function HeroGrowV3Data:GetHGV3DecoColor()
  local cc = self.__uiCfg.main_color
  return Color.New(cc[1] / 255, cc[2] / 255, cc[3] / 255)
end

function HeroGrowV3Data:GetHGV3ResFrontName()
  return self.__uiCfg.home_skin, self.__uiCfg.skin_type
end

function HeroGrowV3Data:GetHGV3ResBackName()
  return self.__uiCfg.home_background_skin, self.__uiCfg.home_background_point
end

function HeroGrowV3Data:GetHGV3NormalName()
  return LanguageUtil.GetLocaleText(self.__uiCfg.normal_name)
end

function HeroGrowV3Data:GetHGV3ChallengeName()
  return LanguageUtil.GetLocaleText(self.__uiCfg.challenge_name)
end

function HeroGrowV3Data:GetHGV3RepeatName()
  return LanguageUtil.GetLocaleText(self.__uiCfg.rebrush_name)
end

function HeroGrowV3Data:GetGetHGV3NormalDataDic()
  return self.__normalDataDic
end

function HeroGrowV3Data:GetHGV3medicineItemId()
  return self.__mainCfg.medicine_id, self.__mainCfg.medicinemax
end

function HeroGrowV3Data:GetHGV3RepeatTicketId()
  return self.__mainCfg.daily_ticket_id
end

function HeroGrowV3Data:GetHGV3RepeatMaxTicketNum()
  return self.__mainCfg.ticket_max
end

function HeroGrowV3Data:GetChallengeAchievementCanPick()
  local achivDatas = self:GetChallengeAchievementDatas()
  local canPick = false
  for i, data in pairs(achivDatas) do
    if data.state == TaskEnum.eTaskState.Completed then
      canPick = true
      break
    end
  end
  return canPick
end

function HeroGrowV3Data:GetChallengeAchievementDatas()
  local achivDatas = {}
  if self.__mainCfg == nil then
    return achivDatas
  end
  local achieveCfgs = ConfigData.activity_herolite_challenge_reward[self.__mainCfg.id]
  if achieveCfgs == nil then
    return achivDatas
  end
  local rewardMask = self:GetChallengeScoreRewardMask()
  local maxScore = self:GetChallengeMaxScore()
  for id, cfg in pairs(achieveCfgs) do
    local state = 1
    if 1 << cfg.level & rewardMask ~= 0 then
      state = TaskEnum.eTaskState.Picked
    elseif maxScore >= cfg.need_socre then
      state = TaskEnum.eTaskState.Completed
    else
      state = TaskEnum.eTaskState.InProgress
    end
    table.insert(achivDatas, {achiveCfg = cfg, state = state})
  end
  return achivDatas
end

function HeroGrowV3Data:GetChallengeMaxScore()
  return self.maxChallengeScore or 0
end

function HeroGrowV3Data:GetChallengeMaxDamage()
  return self.maxChallengeDamage or 0
end

function HeroGrowV3Data:GetChallengeScoreRewardMask()
  return self.challengeScoreRewardMask or 0
end

function HeroGrowV3Data:GetHeroGrowTokenId()
  return self.__mainCfg.token_id
end

function HeroGrowV3Data:GetHeroGrowTokenCount()
  local tokenId = self:GetHeroGrowTokenId()
  local itemCount = PlayerDataCenter:GetItemCount(tokenId)
  return itemCount
end

function HeroGrowV3Data:IsHeroGrowExistLvReward()
  local actId = self:GetActId()
  local tokenRewardCfg = ConfigData.activity_herolite_token_reward[actId]
  if tokenRewardCfg == nil then
    return false
  end
  local isCanReq = false
  local tokenCount = self:GetHeroGrowTokenCount()
  for level, tokenCfg in ipairs(tokenRewardCfg) do
    if tokenCount < tokenCfg.need_token then
      break
    end
    if not self._tokenRewardLevelDic[level] then
      return true
    end
  end
  return false
end

function HeroGrowV3Data:GetShopCurrentLv()
  local actId = self:GetActId()
  local tokenRewardCfg = ConfigData.activity_herolite_token_reward[actId]
  local maxLevel = #tokenRewardCfg
  if self:IsRewardMax() then
    return maxLevel
  end
  local activityCfg = self.__mainCfg
  local itemCount = self:GetHeroGrowTokenCount()
  local tokenStateCount = activityCfg.token_stage
  local currentLv = Mathf.Ceil(itemCount / tokenStateCount)
  return currentLv
end

function HeroGrowV3Data:GetShopNextRewardCount()
  local activityCfg = self.__mainCfg
  local itemCount = self:GetHeroGrowTokenCount()
  local tokenStateCount = activityCfg.token_stage
  if self:IsRewardMax() then
    return tokenStateCount
  end
  local nextRewardCount = itemCount % tokenStateCount
  return nextRewardCount
end

function HeroGrowV3Data:GetShopNextRewardProgress()
  if self:IsRewardMax() then
    return 1
  end
  local activityCfg = self.__mainCfg
  local itemCount = self:GetHeroGrowTokenCount()
  local tokenStateCount = activityCfg.token_stage
  local nextRewardCount = itemCount % tokenStateCount
  local currentProgress = nextRewardCount / tokenStateCount
  return currentProgress
end

function HeroGrowV3Data:IsHeroGrowExistLvReward()
  local actId = self:GetActId()
  local tokenRewardCfg = ConfigData.activity_herolite_token_reward[actId]
  if tokenRewardCfg == nil then
    return false
  end
  local tokenCount = self:GetHeroGrowTokenCount()
  for level, tokenCfg in ipairs(tokenRewardCfg) do
    if tokenCount < tokenCfg.need_token then
      break
    end
    if not self._tokenRewardLevelDic[level] then
      return true, level
    end
  end
  return false
end

function HeroGrowV3Data:IsHeroGrowLvReceived(level)
  return self._tokenRewardLevelDic[level]
end

function HeroGrowV3Data:IsRewardMax()
  local actId = self:GetActId()
  local tokenRewardCfg = ConfigData.activity_herolite_token_reward[actId]
  if tokenRewardCfg == nil then
    return true
  end
  local tokenCount = self:GetHeroGrowTokenCount()
  local tokenCfg = tokenRewardCfg[#tokenRewardCfg]
  return tokenCount >= tokenCfg.need_token
end

function HeroGrowV3Data:GetChallengeDungeonCfg()
  if self.__mainCfg == nil then
    return nil
  end
  return ConfigData.activity_herolite_challenge_dungeon[self.__mainCfg.id]
end

function HeroGrowV3Data:GetBattleDungeonCfg()
  local challengeCfg = self:GetChallengeDungeonCfg()
  if challengeCfg == nil then
    return nil
  end
  return ConfigData.battle_dungeon[challengeCfg.dungeon_id]
end

function HeroGrowV3Data:IsHeroGrowDailyTaskIsUnlock(day)
  return self._dailyTaskFullRewardDic[day] ~= nil
end

function HeroGrowV3Data:IsHeroGrowFullRewardReceived(day)
  return self._dailyTaskFullRewardDic[day]
end

function HeroGrowV3Data:IsHeroGrowDailyTaskCanComplete(day)
  if self._dailyTaskFullRewardDic[day] then
    return false
  end
  local allDayCfg = self:GetTaskConfig()
  if allDayCfg == nil then
    return false
  end
  local dayCfg = allDayCfg[day]
  if dayCfg == nil then
    return false
  end
  local hasNoReceiveTask = false
  for _, taskId in ipairs(dayCfg.open_task_list) do
    if self._finishedDailyTaskDic[taskId] == nil then
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        return true
      end
      hasNoReceiveTask = true
    end
  end
  for _, taskId in ipairs(dayCfg.wait_task_list) do
    if self._finishedDailyTaskDic[taskId] == nil then
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        return true
      end
      hasNoReceiveTask = true
    end
  end
  return not hasNoReceiveTask
end

function HeroGrowV3Data:IsHeroGrowExistTaskReceive()
  local allDayCfg = self:GetTaskConfig()
  if allDayCfg == nil then
    return false
  end
  for day, isPicked in pairs(self._dailyTaskFullRewardDic) do
    if not isPicked and self:IsHeroGrowDailyTaskCanComplete(day) then
      return true
    end
  end
  return false
end

function HeroGrowV3Data:IsHeroGrowDailyTaskReceive(day)
  if self._dailyTaskFullRewardDic[day] then
    return true
  end
  local allDayCfg = self:GetTaskConfig()
  if allDayCfg == nil then
    return false
  end
  local dayCfg = allDayCfg[day]
  if dayCfg == nil then
    return false
  end
  for _, taskId in ipairs(dayCfg.open_task_list) do
    if self._finishedDailyTaskDic[taskId] == nil then
      return false
    end
  end
  for _, taskId in ipairs(dayCfg.wait_task_list) do
    if self._finishedDailyTaskDic[taskId] == nil then
      return false
    end
  end
  return true
end

function HeroGrowV3Data:IsHeroGrowFullRewardCanReceive(day)
  if self._dailyTaskFullRewardDic[day] == nil or self._dailyTaskFullRewardDic[day] then
    return false
  end
  local heroDailyTaskCfg = self:GetTaskConfig()
  if heroDailyTaskCfg == nil then
    return false
  end
  local dayCfg = heroDailyTaskCfg[day]
  if dayCfg == nil then
    return false
  end
  for _, taskId in ipairs(dayCfg.open_task_list) do
    if self._finishedDailyTaskDic[taskId] == nil then
      return false
    end
  end
  for _, taskId in ipairs(dayCfg.wait_task_list) do
    if self._finishedDailyTaskDic[taskId] == nil then
      return false
    end
  end
  return true
end

function HeroGrowV3Data:IsLookedHeroGrowDailyTask(day)
  if self._dailyTaskLookDic == nil then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    self._dailyTaskLookDic = userDataCache:GetHeroGrowV3DailyTask(self:GetActId())
    if self._dailyTaskLookDic == nil then
      self._dailyTaskLookDic = {}
    end
  end
  return self._dailyTaskLookDic[day] ~= nil
end

function HeroGrowV3Data:RefreshCommonHardLevelPlayData(msg)
  self.maxChallengeScore = msg.totalScore
  self.challengeScoreRewardMask = msg.scoreRewardMask
  local challengeCfg = self:GetChallengeDungeonCfg()
  if challengeCfg ~= nil then
    local hardDungeonData = msg.hardDungeonDatas[challengeCfg.dungeon_id]
    if hardDungeonData ~= nil then
      self.maxChallengeDamage = hardDungeonData.maxDamage
    end
  end
  self:RefreshChallengeRewardRed()
end

function HeroGrowV3Data:GetStartAvgId()
  if self.__mainCfg ~= nil then
    local avgCfs = ConfigData.activity_herolite_avg[self.actId]
    for k, v in pairs(avgCfs) do
      if v.unlock_condition == 1 then
        return v.avg_id
      end
    end
  end
  return 0
end

function HeroGrowV3Data:GetDungeonCompleteAvgId(dungeonId)
  if self.__mainCfg ~= nil then
    local avgCfs = ConfigData.activity_herolite_avg[self.actId]
    for k, v in pairs(avgCfs) do
      if v.unlock_condition == 2 and v.dungeon_id == dungeonId then
        return v.avg_id
      end
    end
  end
  return 0
end

function HeroGrowV3Data:IsHeroGrowTaskAllUnlock()
  local actId = self:GetActId()
  local heroDailyTaskCfg = ConfigData.activity_herolite_task_daily[actId]
  if heroDailyTaskCfg == nil then
    return true
  end
  return self:IsHeroGrowDailyTaskIsUnlock(#heroDailyTaskCfg)
end

return HeroGrowV3Data
