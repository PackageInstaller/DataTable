local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivitySpringData = class("ActivitySpringData", ActivityBase)
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local eActInteract = require("Game.ActivityLobby.Activity.2023Spring.eActInteract")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Spring
local ActivitySpringEnum = require("Game.ActivitySpring.Data.ActivitySpringEnum")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local TaskEnum = require("Game.Task.TaskEnum")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataOne = require("Game.ActivityFrame.ActTermTaskDataOne")
local ActivitySeasonDungeonData = require("Game.ActivityChristmas.ActivitySeasonDungeonData")
local WarChessSeasonAddtionData = require("Game.WarChessSeason.WarChessSeasonAddtionData")
local ActTechTree = require("Game.ActivityFrame.ActTechTree")
local ActInternalUnlockInfo = require("Game.Common.Activity.ActInternalUnlockInfo")
local ActSpringStoryData = require("Game.ActivitySpring.Data.ActivitySpringStoryData")

function ActivitySpringData:InitSpringData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_spring_main[msg.actId]
  self._levelTypeCfg = ConfigData.activity_spring_level[self._mainCfg.hard_level_type]
  self._timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  self._frameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:__InitTechData()
  self:UpdateSpringMsg(msg)
  self._storyData = ActSpringStoryData.New()
  self._storyData:InitStoryData(self:GetActFrameId())
  self:AddRefreshRedTalk()
  self:RefreshSpring23LevelUnlockBuleDot()
  self:__InitUnlockInfo()
  self:RefreshRedSpringTech()
  self:RefreshRedSpringDailyTask()
  self:RefreshRedSpringOnceTask()
  self:RefreshRedBrotato()
  ExplorationManager:AddEpNewEpBuffSelect(self._mainCfg.main_stage, self._mainCfg.initial_protocol_all)
end

function ActivitySpringData:UpdateSpringMsg(msg)
  self._dungeonFrame = msg.dungeonFrame or {}
  if self._actTechTree ~= nil and msg.tech ~= nil then
    self._actTechTree:UpdateActTechTree(msg.tech)
  end
  self:UpdataBrotatoData(msg)
end

function ActivitySpringData:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedSpringDailyTaskCallback = BindCallback(self, self.RefreshRedSpringDailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedSpringDailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedSpringDailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedSpringDailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivitySpringData:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataOne.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedSpringOnceTaskCallback = BindCallback(self, self.RefreshRedSpringOnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedSpringOnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedSpringOnceTaskCallback)
end

function ActivitySpringData:UpdateDungeonFrameByDunId(dungeonId, frame)
  if not self._dungeonFrame[dungeonId] or frame < self._dungeonFrame[dungeonId] or frame >= CommonUtil.UInt32Max then
    self._dungeonFrame[dungeonId] = frame
  end
end

function ActivitySpringData:AddSpringRefDailyTask(taskIds, nextExpireTm)
  if taskIds[1] ~= nil then
    table.insertto(self._refreshTaskIds, taskIds)
  end
  self._nextExpireTm = nextExpireTm
  if self._nextExpireTm == 0 then
    self._nextExpireTm = self._mainCfg.task_time
  end
  self:RefreshRedDailyTask()
end

function ActivitySpringData:__InitTechData()
  self._actTechTree = ActTechTree.New()
  self._actTechTree:InitTechTree(self._mainCfg.tech_id, self)
  local RefreshRedTechCallback = BindCallback(self, self.RefreshRedSpringTech)
  self._actTechTree:BindActTechUpdateFunc(RefreshRedTechCallback)
  self._actTechTree:BindActTechAllResetFunc(RefreshRedTechCallback)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  actFrameCtrl:AddActivityTech(self._actTechTree)
end

function ActivitySpringData:__InitUnlockInfo()
  self._unlockInfo = ActInternalUnlockInfo.New()
  local storyInteractCfgDic = self._storyData:GetStoryMain()
  local avgList = {}
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for _, storyInteractCfg in pairs(storyInteractCfgDic) do
    if storyInteractCfg.story > 0 and not avgPlayCtrl:IsAvgPlayed(storyInteractCfg.story) then
      table.insert(avgList, storyInteractCfg.story)
    end
  end
  self._unlockInfo:InitAvgPlayedUnlockInfo(avgList)
  local envIds = self._mainCfg.env_list
  local envIdDic = {}
  for i, envId in ipairs(envIds) do
    if not self:IsSpring23EnvUnlock(envId) then
      envIdDic[envId] = true
    end
  end
  self._unlockInfo:InitEnvUnlockInfo(envIdDic)
end

function ActivitySpringData:CalSpringAvgState()
end

function ActivitySpringData:SetSpringHardLevelLooked()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetSpring23HardLevelLooked(self:GetActId())
  self:RefreshRedHardLevel()
end

function ActivitySpringData:SetSpringBrotatoStageId(stageId)
  self._brotatoStageId = stageId
end

function ActivitySpringData:RefreshRedSpringOnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySpringData:AddRefreshRedTalk()
  if self._redTalkTimer then
    return
  end
  self._redTalkTimer = TimerManager:StartTimer(1, function()
    self:RefreshRedTalk()
    self._redTalkTimer = nil
  end, nil, true, true)
end

function ActivitySpringData:RefreshRedTeamPerformance()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.TeamPerformance)
  local nowLevel, targetLevel = self._storyData:GetNextCanGetRewardLevel()
  if targetLevel <= nowLevel then
    if childReddot:GetRedDotCount() == 0 then
      childReddot:SetRedDotCount(1)
    end
    return
  end
  if childReddot:GetRedDotCount() > 0 then
    childReddot:SetRedDotCount(0)
  end
end

function ActivitySpringData:RefreshRedTalk()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.Talk)
  local haveTalk = self._storyData:CheckHaveTalk()
  if haveTalk then
    if childReddot:GetRedDotCount() == 0 then
      childReddot:SetRedDotCount(1)
    end
    return
  end
  if childReddot:GetRedDotCount() > 0 then
    childReddot:SetRedDotCount(0)
  end
end

function ActivitySpringData:RefreshRedHardLevel()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.HardLevel)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local haveLooked = userDataCache:GetSpring23HardLevelLooked(self:GetActId())
  if not haveLooked then
    if childReddot:GetRedDotCount() == 0 then
      childReddot:SetRedDotCount(1)
    end
    return
  end
  if childReddot:GetRedDotCount() > 0 then
    childReddot:SetRedDotCount(0)
  end
end

function ActivitySpringData:RefreshRedSpringDailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySpringData:RefreshRedSpringTech()
  if self._actTechTree == nil then
    return
  end
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local reddotChild = reddot:AddChild(ActivitySpringEnum.reddotType.Tech)
  local itemReddot = reddot:AddChild(ActivitySpringEnum.reddotType.TechItemLimit)
  if not self:IsActivityRunning() then
    reddotChild:ClearChild()
    itemReddot:SetRedDotCount(0)
    return
  end
  local treeDic = self._actTechTree:GetTechDataDic()
  local branchDic = treeDic[self._mainCfg.tech_special_branch]
  local hasLeveUpTech = false
  for k, techData in pairs(branchDic) do
    if techData:IsCouldLevelUp() then
      hasLeveUpTech = true
      break
    end
  end
  local reddotChildPage = reddotChild:AddChild(self._mainCfg.tech_special_branch)
  reddotChildPage:SetRedDotCount(hasLeveUpTech and 1 or 0)
  local flag, itemId = self._actTechTree:GetTreeResetReturnItemId()
  if flag then
    if PlayerDataCenter:GetItemCount(itemId) >= 16000 then
      if not hasLeveUpTech then
        for k, techDataDic in pairs(treeDic) do
          if k ~= self._mainCfg.tech_special_branch then
            for k, techData in pairs(techDataDic) do
              if techData:IsCouldLevelUp() then
                hasLeveUpTech = true
                break
              end
            end
          end
        end
      end
      itemReddot:SetRedDotCount(hasLeveUpTech and 1 or 0)
    else
      itemReddot:SetRedDotCount(0)
    end
  end
end

function ActivitySpringData:RefreshRedBrotato()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._mainCfg.game_brotato == 0 then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.Brotato)
  local flagReward = self.brotatoRewardPickedLevel < self.brotatoRewardLevel
  local flagTask = false
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  local taskDataDic, _ = taskCtrl:GetDatas4Task(self:GetSpringBrotatoTaskType())
  for _, data in pairs(taskDataDic) do
    if data:CheckComplete() then
      flagTask = true
      break
    end
  end
  local flag = flagReward or flagTask
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySpringData:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivitySpringEnum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivitySpringData:RefreshSpringUnlockAvgPlayed()
  if self._unlockInfo == nil then
    return
  end
  self._unlockInfo:UpdateAvgPlayedUnlockInfo()
end

function ActivitySpringData:RefreshSpringUnlockEnv(precondition, isForce)
  if self._unlockInfo == nil then
    return
  end
  local playEndTime = self:GetActivityEndTime()
  if playEndTime < PlayerDataCenter.timestamp then
    return
  end
  if not isForce and ConfigData.activity_spring_advanced_env.preconditionDic[precondition] == nil then
    return
  end
  local envIdDic = self._unlockInfo:GetEnvUnlockInfo()
  if envIdDic == nil then
    return
  end
  local actId = self:GetActId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isNeedUpdateBlueDot = false
  for envId, _ in pairs(envIdDic) do
    if self:IsSpring23EnvUnlock(envId) then
      self._unlockInfo:AddEnvUnlockInfo(envId)
      userDataCache:SetSpring23IsNotEnteredNewEnv(actId, envId, true)
      isNeedUpdateBlueDot = true
    end
  end
  if isNeedUpdateBlueDot then
    self:RefreshSpring23LevelUnlockBuleDot()
  end
end

function ActivitySpringData:RefreshSpring23LevelUnlockBuleDot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpringEnum.reddotType.EpEnv)
  local actId = self:GetActId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local envList = self:GetSpringLevelEnvs()
  for _, envId in pairs(envList) do
    local isHaveNotEnteredNewEnv = userDataCache:GetSpring23IsNotEnteredNewEnv(actId, envId)
    if isHaveNotEnteredNewEnv then
      childReddot:SetRedDotCount(1)
      ActLbUtil.UpdLbEnttBluedot(eActInteract.eLbIntrctEntityId.EnvSelect)
      return
    end
  end
  childReddot:SetRedDotCount(0)
  ActLbUtil.UpdLbEnttBluedot(eActInteract.eLbIntrctEntityId.EnvSelect)
end

function ActivitySpringData:IsSpring23EnvUnlock(envId)
  if self._tempUnlockEnvDic == nil then
    self._tempUnlockEnvDic = {}
  end
  if self._tempUnlockEnvDic[envId] then
    return true
  end
  local cfg = ConfigData.activity_spring_advanced_env[envId]
  if cfg == nil then
    return false
  end
  if #cfg.pre_condition == 0 and 0 >= cfg.need_interact then
    self._tempUnlockEnvDic[envId] = true
    return true
  end
  if CheckCondition.CheckLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2) then
    local need_interact = cfg.need_interact
    if 0 < need_interact then
      local actId = self:GetActId()
      local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
      local spring23InteractElement = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleActivitySpringInteractNum, actId)
      if spring23InteractElement == nil then
        return false
      elseif need_interact > spring23InteractElement.times then
        return false
      end
    end
    self._tempUnlockEnvDic[envId] = true
    return true
  end
  return false
end

function ActivitySpringData:IsSpring23DiffUnlock(envId, diffId, index)
  local envCfg = ConfigData.activity_spring_advanced_env[envId]
  local stageList = envCfg.stage_id
  local stageId = stageList[index]
  local stageCfg = ConfigData.sector_stage[stageId]
  local isUnlock = CheckCondition.CheckLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
  local unlockDes = CheckCondition.GetUnlockInfoLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
  return isUnlock, unlockDes
end

function ActivitySpringData:IsSpring23EnvHaveDiff(envId, diff, index)
  local envCfg = ConfigData.activity_spring_advanced_env[envId]
  local stageList = envCfg.stage_id
  local stageCount = #stageList
  if index <= stageCount then
    return true
  end
  return false
end

function ActivitySpringData:CheckIsSpringChallengeDungeon(dungeonId)
  local dun_levels = self._levelTypeCfg.dungeon_levels
  for i, v in pairs(dun_levels) do
    if v == dungeonId then
      return true
    end
  end
  return false
end

function ActivitySpringData:GetSpringChallengeRecord(dungeonId)
  if dungeonId == nil or self._dungeonFrame == nil then
    error("dungeonFrame NIL or param error")
    return nil
  end
  return self._dungeonFrame[dungeonId]
end

function ActivitySpringData:GetSpringHardLevelCfg()
  return self._levelTypeCfg
end

function ActivitySpringData:GetSpringChallengeDungeonIndex(dungeonId)
  local dun_levels = self._levelTypeCfg.dungeon_levels
  for i, v in pairs(dun_levels) do
    if v == dungeonId then
      return i
    end
  end
  return 1
end

function ActivitySpringData:GetInteractCostNum()
  return PlayerDataCenter:GetItemCount(self._mainCfg.interact_item)
end

function ActivitySpringData:GetInteractCostId()
  return self._mainCfg.interact_item
end

function ActivitySpringData:GetSpringStoryData()
  return self._storyData
end

function ActivitySpringData:GetRankId()
  return self._levelTypeCfg.ranklist_id
end

function ActivitySpringData:GetSpringLevelEnvs()
  return self._mainCfg.env_list
end

function ActivitySpringData:GetSpringTicketID()
  return self._mainCfg.ticket_item
end

function ActivitySpringData:GetSpringMainCfg()
  return self._mainCfg
end

function ActivitySpringData:GetSpringBrotatoStageId()
  return self._brotatoStageId
end

function ActivitySpringData:GetSpringMainSectorId()
  return self._mainCfg.main_stage
end

function ActivitySpringData:GetSpringBrotatoSectorId()
  return self._mainCfg.brotato_sector
end

function ActivitySpringData:GetSpringBrotatoId()
  return self._mainCfg.game_brotato
end

function ActivitySpringData:GetSpringBrotatoTokenId()
  local brotatoCfg = ConfigData.tiny_game_brotato[self._mainCfg.game_brotato]
  if brotatoCfg == nil then
    return 0
  end
  return brotatoCfg.task_item
end

function ActivitySpringData:GetSpringBrotatoTaskType()
  local brotatoCfg = ConfigData.tiny_game_brotato[self._mainCfg.game_brotato]
  if brotatoCfg == nil then
    return 0
  end
  return brotatoCfg.task_type
end

function ActivitySpringData:GetSpringRefreshTaskIds()
  return self._refreshTaskIds
end

function ActivitySpringData:GetSpringDailyTaskData()
  return self._dailyTaskData
end

function ActivitySpringData:GetSpringTermTaskData()
  return self._termTaskData
end

function ActivitySpringData:GetSpringTechTree()
  return self._actTechTree
end

function ActivitySpringData:GetSpringUnlockInfo()
  return self._unlockInfo
end

function ActivitySpringData:UpdataBrotatoData(msg)
  self.brotatoRewardLevel = msg.gameRewardLevel
  self.brotatoRewardPickedLevel = msg.gameReceivedLevel
  self.gameBrotatoItemNum = msg.gameBrotatoItemNum
  local brotatoId = self._mainCfg.game_brotato
  if 0 < brotatoId then
    local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
    activityBrotatoLobbyCtrl:UpdataBrotatoData(msg, brotatoId, self:GetActFrameId())
    self:RefreshRedBrotato()
  end
end

function ActivitySpringData:DealSpringWhenEnd()
  self._actUnlockInfo:ResetAllUnlockData()
  ExplorationManager:RemoveEpNewEpBuffSelect(self._mainCfg.main_stage, self._mainCfg.initial_protocol_all)
end

function ActivitySpringData:ClearTimer()
  if self._redTalkTimer then
    TimerManager:StopTimer(self._redTalkTimer)
    self._redTalkTimer = nil
  end
end

return ActivitySpringData
