local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityHeroGrow = class("ActivityHeroGrow", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local DungeonLevelHeroGrow = require("Game.ActivityHeroGrow.DungeonLevelHeroGrow")
local base = ActivityBase
local NoticeData = require("Game.Notice.NoticeData")
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local ActivityCharDunConfig = require("Game.ActivityHeroGrow.ActivityCharDunConfig")

function ActivityHeroGrow:InitHeroGrowData(actInfo)
  self:SetActFrameData(actInfo)
  self._cfg = ConfigData.activity_hero[actInfo:GetActId()]
  if self._cfg == nil then
    error("HeroGrowCfg Miss  id is " .. tostring(actInfo:GetActId()))
  end
  self._costNum = 0
  self._remainTimes = 0
  self._lastExpiredTm = self:GetActivityBornTime()
  self._isHasLimitTimes = false
  local nodeParent = self:GetActivityReddot()
  local node = nodeParent:AddChild(RedDotStaticTypeId.ActivityShop)
  local dynPath = node.nodePath .. "SubItem"
  self.__shopDynPath = dynPath
  self._dungonLevelDic = {}
  for _, dungeonId in ipairs(self._cfg.dungeon_list) do
    local dungeonLevelData = DungeonLevelHeroGrow.New(dungeonId)
    dungeonLevelData:SetDungeonHeroGrowAct(self)
    self._dungonLevelDic[dungeonId] = dungeonLevelData
  end
end

function ActivityHeroGrow:UpdateHeroGrowData(msg, isLogin)
  self._costNum = msg.costNum
  if self._isHasLimitTimes then
    self._remainTimes = msg.remainTimes
    if msg.lastExpiredTm ~= 0 then
      self._lastExpiredTm = msg.lastExpiredTm
    end
    self:__UpdateReddot()
  end
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
  self:__UpdateShopUnlockAndReddot(isLogin)
  self:RefreshHeroGrowDailyTaskComReddot()
  self:RefreshHeroGrowDailyTaskNewReddot()
  self:RefreshHeroGrowLvRewrdReddot()
  self:RefreshHeroGrowChallengeNewReddot()
  self:UpdateActFrameDataSingleMsg(msg)
end

function ActivityHeroGrow:__UpdateShopUnlockAndReddot(isLogin)
  if not self:IsActivityOpen() then
    return
  end
  if self.__conditionListener ~= nil then
    return
  end
  local shopRootNode = self:GetActivityHeroShopReddotNode()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  
  local function unlockShopListener(shopId)
    if not saveUserData:IsActivityHeroShopRead(self.actInfo:GetActId(), shopId) then
      local node = shopRootNode:AddChildWithPath(shopId, self:GetActivityHeroShopPath())
      node:SetRedDotCount(1)
    end
    self:__OnActHeroShopUnlockInfo(shopId)
  end
  
  self.__conditionListener = ConditionListener.New()
  NetworkManager.luaNetworkAgent:AddLogoutAutoDelete(self.__conditionListener)
  if self._cfg == nil then
    return
  end
  for k, shopId in pairs(self._cfg.shop_list) do
    local cfg = ConfigData.shop[shopId]
    if cfg ~= nil then
      if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
        if not saveUserData:IsActivityHeroShopRead(self.actInfo:GetActId(), shopId) then
          local node = shopRootNode:AddChildWithPath(shopId, self:GetActivityHeroShopPath())
          node:SetRedDotCount(1)
        end
        if not isLogin then
          self:__OnActHeroShopUnlockInfo(shopId)
        end
      else
        self.__conditionListener:AddConditionChangeListener(shopId, unlockShopListener, cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
      end
    end
  end
end

function ActivityHeroGrow:__OnActHeroShopUnlockInfo(shopId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg == nil then
    error("shop cfg is null,id:" .. tostring(shopId))
    return
  end
  NoticeManager:AddNotice(NoticeData.CreateNoticeData(PlayerDataCenter.timestamp, NoticeManager.eNoticeType.ActivityHeroShop, nil, {
    LanguageUtil.GetLocaleText(shopCfg.name)
  }, nil))
end

function ActivityHeroGrow:GetActivityHeroShopReddotNode()
  local nodeParent = self:GetActivityReddot()
  local shopRootNode = nodeParent:AddChild(RedDotStaticTypeId.ActivityShop)
  return shopRootNode
end

function ActivityHeroGrow:GetActivityHeroShopPath()
  return self.__shopDynPath
end

function ActivityHeroGrow:__UpdateReddot()
  local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local nodeParent = self:GetActivityReddot()
  local node = nodeParent:AddChild(RedDotStaticTypeId.ActivityChallenge)
  node:SetRedDotCount(self:GetHeroGrowChallengeCount())
end

function ActivityHeroGrow:RefreshHeroGrowStateDailyFlush()
  if not self:IsActivityRunning() then
    return
  end
  self:__UpdateReddot()
end

function ActivityHeroGrow:ReqHeroGrowDailyFullReward(day, callback)
  if not self:IsHeroGrowFullRewardCanReceive(day) then
    return
  end
  local actId = self:GetActId()
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrow)
  network:CS_ACTIVITYSectorHero_DailyTaskFullReward(actId, day, function()
    self:RefreshHeroGrowDailyTaskComReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHeroGrow:ReqHeroGrowDailyTaskAllReward(callback)
  if not self:IsHeroGrowExistTaskReceive() then
    return
  end
  local actId = self:GetActId()
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrow)
  network:CS_ACTIVITYSectorHero_DailyTaskAllReward(actId, function()
    self:RefreshHeroGrowDailyTaskComReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHeroGrow:ReqHeroGrowSingleTokenReward(tokenRewardLv, callback)
  if self._tokenRewardLevelDic[tokenRewardLv] then
    return
  end
  local actId = self:GetActId()
  local tokenRewardCfg = ConfigData.activity_hero_token_reward[actId]
  if tokenRewardCfg == nil then
    return
  end
  local tokenCfg = tokenRewardCfg[tokenRewardLv]
  if tokenCfg == nil then
    return
  end
  if tokenCfg.need_token > PlayerDataCenter:GetItemCount(self._cfg.token) then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrow)
  network:CS_ACTIVITYSectorHero_SingleTokenReward(actId, tokenRewardLv, function()
    self:RefreshHeroGrowLvRewrdReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHeroGrow:ReqHeroGrowAllTokenReward(callback)
  if not self:IsHeroGrowExistLvReward() then
    return
  end
  local actId = self:GetActId()
  local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrow)
  network:CS_ACTIVITYSectorHero_AllTokenReward(actId, function()
    self:RefreshHeroGrowLvRewrdReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityHeroGrow:RefreshHeroGrowDailyTaskComReddot()
  if not self:IsHeroGrowVer2() then
    return
  end
  local nodeParent = self:GetActivityReddot()
  if nodeParent == nil then
    return
  end
  local nodeChild = nodeParent:AddChild(ActivityCharDunConfig.reddotType.dailyTaskCom)
  nodeChild:SetRedDotCount(self:IsHeroGrowExistTaskReceive() and 1 or 0)
end

function ActivityHeroGrow:RefreshHeroGrowDailyTaskNewReddot()
  if not self:IsHeroGrowVer2() then
    return
  end
  local nodeParent = self:GetActivityReddot()
  if nodeParent == nil then
    return
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local dailyTaskLookDic = userDataCache:GetHeroGrowDailyTask(self:GetActId())
  local reddotNum = 0
  for day, _ in pairs(self._dailyTaskFullRewardDic) do
    if not self:IsLookedHeroGrowDailyTask(day) then
      reddotNum = 1
      break
    end
  end
  local nodeChild = nodeParent:AddChild(ActivityCharDunConfig.reddotType.dailyTaskNew)
  nodeChild:SetRedDotCount(reddotNum)
end

function ActivityHeroGrow:RefreshHeroGrowLvRewrdReddot()
  if not self:IsHeroGrowVer2() then
    return
  end
  local nodeParent = self:GetActivityReddot()
  if nodeParent == nil then
    return
  end
  local nodeChild = nodeParent:AddChild(ActivityCharDunConfig.reddotType.lvReward)
  nodeChild:SetRedDotCount(self:IsHeroGrowExistLvReward() and 1 or 0)
end

function ActivityHeroGrow:RefreshHeroGrowChallengeNewReddot()
  if not self:IsHeroGrowVer2() then
    return
  end
  local nodeParent = self:GetActivityReddot()
  if nodeParent == nil then
    return
  end
  local nodeChild = nodeParent:AddChild(ActivityCharDunConfig.reddotType.challengeNew)
  if not self:IsActivityRunning() then
    nodeChild:SetRedDotCount(0)
    return
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local lastLookStageId = userDataCache:GetHeroGrowChallengeStageId(self:GetActId())
  local newLookStageId = PlayerDataCenter.sectorStage:GetSectorUnlockProcess(self._cfg.rechallenge_stage)
  nodeChild:SetRedDotCount(lastLookStageId < newLookStageId and 1 or 0)
end

function ActivityHeroGrow:SetHeroGrowChallengeNew()
  if not self:IsHeroGrowVer2() then
    return
  end
  local nodeParent = self:GetActivityReddot()
  if nodeParent == nil then
    return
  end
  local newLookStageId = PlayerDataCenter.sectorStage:GetSectorUnlockProcess(self._cfg.rechallenge_stage)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetHeroGrowChallengeStageId(self:GetActId(), newLookStageId)
  local nodeChild = nodeParent:AddChild(ActivityCharDunConfig.reddotType.challengeNew)
  nodeChild:SetRedDotCount(0)
end

function ActivityHeroGrow:LookedHeroGrowDailyTaskNewReddot(day)
  if not self:IsHeroGrowVer2() then
    return
  end
  if self:IsLookedHeroGrowDailyTask(day) then
    return
  end
  self._dailyTaskLookDic[day] = true
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetHeroGrowDailyTask(self:GetActId(), day)
  self:RefreshHeroGrowDailyTaskNewReddot()
end

function ActivityHeroGrow:SetHeroGrowDungeonBattle(dungeonId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetHeroGrowBattleDungeon(self:GetActId(), dungeonId)
end

function ActivityHeroGrow:GetHeroGrowDungeonBattle(dungeonId)
  if not self:IsActivityRunning() then
    return false
  end
  if PlayerDataCenter:GetTotalBattleTimes(dungeonId) > 0 then
    return false
  end
  if self._dungonLevelDic[dungeonId] == nil or not self._dungonLevelDic[dungeonId]:GetIsLevelUnlock() then
    return false
  end
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return not userDataCache:GetHeroGrowBattleDungeon(self:GetActId(), dungeonId)
end

function ActivityHeroGrow:IsLookedHeroGrowDailyTask(day)
  if self._dailyTaskLookDic == nil then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    self._dailyTaskLookDic = userDataCache:GetHeroGrowDailyTask(self:GetActId())
    if self._dailyTaskLookDic == nil then
      self._dailyTaskLookDic = {}
    end
  end
  return self._dailyTaskLookDic[day] ~= nil
end

function ActivityHeroGrow:IsHeroGrowExistTaskReceive()
  local allDayCfg = ConfigData.activity_hero_task_daily[self:GetActId()]
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

function ActivityHeroGrow:IsHeroGrowDailyTaskCanComplete(day)
  if self._dailyTaskFullRewardDic[day] then
    return false
  end
  local allDayCfg = ConfigData.activity_hero_task_daily[self:GetActId()]
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

function ActivityHeroGrow:IsHeroGrowDailyTaskReceive(day)
  if self._dailyTaskFullRewardDic[day] then
    return true
  end
  local allDayCfg = ConfigData.activity_hero_task_daily[self:GetActId()]
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

function ActivityHeroGrow:IsHeroGrowFullRewardCanReceive(day)
  if self._dailyTaskFullRewardDic[day] == nil or self._dailyTaskFullRewardDic[day] then
    return false
  end
  local actId = self:GetActId()
  local heroDailyTaskCfg = ConfigData.activity_hero_task_daily[actId]
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

function ActivityHeroGrow:IsHeroGrowFullRewardReceived(day)
  return self._dailyTaskFullRewardDic[day]
end

function ActivityHeroGrow:IsHeroGrowDailyTaskIsUnlock(day)
  return self._dailyTaskFullRewardDic[day] ~= nil
end

function ActivityHeroGrow:IsHeroGrowTaskAllUnlock()
  local actId = self:GetActId()
  local heroDailyTaskCfg = ConfigData.activity_hero_task_daily[actId]
  if heroDailyTaskCfg == nil then
    return true
  end
  return self:IsHeroGrowDailyTaskIsUnlock(#heroDailyTaskCfg)
end

function ActivityHeroGrow:IsHeroGrowExistLvReward()
  local actId = self:GetActId()
  local tokenRewardCfg = ConfigData.activity_hero_token_reward[actId]
  if tokenRewardCfg == nil then
    return false
  end
  local isCanReq = false
  local tokenCount = PlayerDataCenter:GetItemCount(self._cfg.token)
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

function ActivityHeroGrow:IsHeroGrowLvReceived(level)
  return self._tokenRewardLevelDic[level]
end

function ActivityHeroGrow:GetHeroGrowCfg()
  return self._cfg
end

function ActivityHeroGrow:GetHeroGrowCostNum()
  return self._costNum
end

function ActivityHeroGrow:GetHeroGrowCostId()
  return self._cfg.token
end

function ActivityHeroGrow:IsHeroGrowLimiTimes()
  return self._isHasLimitTimes
end

function ActivityHeroGrow:GetHeroGrowChallengeCount()
  if not self:IsActivityRunning() or not self:IsHeroGrowLimiTimes() then
    return 0
  end
  if self._lastExpiredTm >= PlayerDataCenter.timestamp then
    return self._remainTimes
  end
  local nextTime = self:GetHeroGrowChallengeRefrehTime()
  local dayCount = math.ceil((nextTime - self._lastExpiredTm) / CommonUtil.DaySeconds)
  if dayCount <= 0 then
    return 0
  end
  local count = self._cfg.free_times * dayCount + self._remainTimes
  count = math.min(count, self._cfg.max_time)
  return count
end

function ActivityHeroGrow:GetHeroGrowChallengeRefrehTime()
  if not self:IsActivityRunning() then
    return self:GetActivityBornTime()
  end
  local timeCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
  local nextTm = timeCtrl:GetLogicTodayPassTimeStamp()
  local timestamp = PlayerDataCenter.timestamp
  if nextTm < PlayerDataCenter.timestamp then
    nextTm = nextTm + CommonUtil.DaySeconds
  end
  return nextTm
end

function ActivityHeroGrow:GetHeroGrowDungeonDic()
  return self._dungonLevelDic
end

function ActivityHeroGrow:GetHeroGrowReceivedToken()
  return self._tokenRewardLevelDic
end

function ActivityHeroGrow:GetHeroGrowFinishTask()
  return self._finishedDailyTaskDic
end

function ActivityHeroGrow:IsHeroGrowVer2()
  return ConfigData.activity_hero_token_reward[self:GetActId()] ~= nil
end

function ActivityHeroGrow:GetActivityReddotNum()
  if not self:IsActivityOpen() then
    return false, 0
  end
  if not self:IsHeroGrowVer2() then
    local cfgId = ConfigData.activity_entrance.activityIdDic[self.actInfo:GetActivityFrameId()]
    local cfg = ConfigData.activity_entrance[cfgId]
    local nodeParent = self:GetActivityReddot()
    local isRed = cfg.red_dot == 1
    return not isRed, nodeParent:GetRedDotCount()
  end
  local nodeParent = self:GetActivityReddot()
  if nodeParent == nil then
    return false, 0
  end
  local isRed = false
  for reddotId, _ in pairs(ActivityCharDunConfig.reddotIsRedType) do
    local reddot = nodeParent:GetChild(reddotId)
    if reddot ~= nil and 0 < reddot:GetRedDotCount() then
      isRed = true
      break
    end
  end
  return not isRed, nodeParent:GetRedDotCount()
end

return ActivityHeroGrow
