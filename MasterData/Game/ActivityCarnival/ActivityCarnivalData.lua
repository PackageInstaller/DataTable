local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityCarnivalData = class("ActivityCarnivalData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActivityCarnivalEnum = require("Game.ActivityCarnival.ActivityCarnivalEnum")
local ActTechData = require("Game.ActivitySectorII.Tech.Data.ActTechData")
local GameWatermelonData = require("Game.ActivityCarnival.GameWatermelonData")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local cs_MessageCommon = CS.MessageCommon
local CurActType = ActivityFrameEnum.eActivityType.Carnival

function ActivityCarnivalData:InitActivityCarnival(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_carnival[msg.actId]
  self._expCfg = ConfigData.activity_carnival_exp[self._mainCfg.exp_logic]
  self._cycleExpNeed = self._expCfg[#self._expCfg].need_exp
  self._levelTypeCfg = ConfigData.activity_carnival_level[self._mainCfg.hard_level_type]
  self._envCfg = {}
  for k, v in pairs(ConfigData.activity_carnival_env[msg.actId]) do
    table.insert(self._envCfg, v)
  end
  table.sort(self._envCfg, function(a, b)
    return a.id < b.id
  end)
  self._level = 0
  self._exp = 0
  self._maxLevel = #self._expCfg
  self._rewardMaskDic = {}
  self._techDataDic = {}
  self._unlockEnvDic = {}
  self._lockedConditionEnvDic = {}
  self._lockedLevelEnvDic = {}
  self._questDic = {}
  self._questCompleteDic = {}
  self._nextRefreshTm = 0
  self._curStage = 0
  self._curDifficuty = 0
  self._techRowDic = {}
  self._lockedStageList = {}
  self._lockedAvgList = {}
  self._unComplectStageDic = {}
  self._unlookAvgDic = {}
  self._newUnlockInfoList = {}
  self._gameWatermelon = GameWatermelonData.New(msg.tinyGameUid, self._mainCfg.game_mash_up)
  self:__GenTech()
  self:UpdateCarnival(msg)
  ExplorationManager:AddEpNewEpBuffSelect(self._mainCfg.main_stage, self._mainCfg.initial_protocol_all)
end

function ActivityCarnivalData:UpdateCarnival(msg)
  self._curStage = msg.stage
  self._curDifficuty = msg.difficulty
  self._dungeonFrame = msg.dungeonFrame
  self:__UpdateTech(msg.tech)
  self:__UpdateExpAndReward(msg)
  self:__UpdateTask(msg)
  if self._lastCalEnvLevel == nil then
    self:__InitUnlockEnv()
    self:__InitCarnivalStageAndAvgState()
  else
    self:__CalCarnivalEnvByLevel()
  end
end

function ActivityCarnivalData:__GenTech()
  local techType = self:GetCarnivalTechType()
  local techTypeCfg = ConfigData.activity_tech.actTechTypeList[techType]
  if techTypeCfg == nil then
    error("activity tech type is NIL,type is " .. tostring(techType))
  end
  for _, techId in ipairs(techTypeCfg.techIds) do
    local techCfg = ConfigData.activity_tech[techId]
    local branchDic = self._techDataDic[techCfg.branch]
    if branchDic == nil then
      branchDic = {}
      self._techDataDic[techCfg.branch] = branchDic
    end
    local tech = ActTechData.CreatAWTechData(techId, CurActType, self:GetActId())
    branchDic[techId] = tech
    if not tech:IsActTechAutoUnlock() then
      local rowId = techCfg.row
      self._techRowDic[rowId] = true
    end
  end
  for branchId, branchDic in pairs(self._techDataDic) do
    for techId, techData in pairs(branchDic) do
      local previousTechId = techData:GetPreTechId()
      if previousTechId ~= nil then
        local previousTech = self._techDataDic[branchId][previousTechId]
        techData:SetPreTechData(previousTech)
      end
    end
  end
end

function ActivityCarnivalData:__InitUnlockEnv()
  self._lastCalEnvLevel = self._level
  for _, singleEnv in pairs(self._envCfg) do
    local unlock = true
    if not CheckCondition.CheckLua(singleEnv.pre_condition, singleEnv.pre_para1, singleEnv.pre_para1) then
      unlock = false
      for _, condition in ipairs(singleEnv.pre_condition) do
        local conditionDic = self._lockedConditionEnvDic[condition]
        if conditionDic == nil then
          conditionDic = {}
          self._lockedConditionEnvDic[condition] = conditionDic
        end
        conditionDic[singleEnv.id] = true
      end
    elseif singleEnv.exp_level > self._level then
      unlock = false
      local levelList = self._lockedLevelEnvDic[singleEnv.exp_level]
      if levelList == nil then
        levelList = {}
        self._lockedLevelEnvDic[singleEnv.exp_level] = levelList
      end
      table.insert(levelList, singleEnv.id)
    end
    if unlock then
      self._unlockEnvDic[singleEnv.id] = true
    end
  end
end

function ActivityCarnivalData:CalCarnivalEnvByCondition(precondition)
  local conditionDic = self._lockedConditionEnvDic[precondition]
  if conditionDic == nil then
    return
  end
  local reddot = self:GetActivityReddot()
  if reddot ~= nil then
    reddot = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
  end
  local activityIsRuning = self:IsActivityRunning()
  local hasUnlockEnv = false
  for envId, _ in pairs(conditionDic) do
    local singleEnv = self:GetCarnivalEnvCfgById(envId)
    local unlock = CheckCondition.CheckLua(singleEnv.pre_condition, singleEnv.pre_para1, singleEnv.pre_para1)
    if unlock then
      for _, condition in ipairs(singleEnv.pre_condition) do
        local conditionDic = self._lockedConditionEnvDic[condition]
        if conditionDic ~= nil then
          conditionDic[envId] = nil
        end
      end
      if singleEnv.exp_level > self._level then
        local levelList = self._lockedLevelEnvDic[singleEnv.exp_level]
        if levelList == nil then
          levelList = {}
          self._lockedLevelEnvDic[singleEnv.exp_level] = levelList
        end
        table.insert(levelList, singleEnv.id)
      elseif activityIsRuning then
        self:__AddNewUnlockInfo(ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Env, singleEnv.id)
        self._unlockEnvDic[singleEnv.id] = true
        if reddot ~= nil then
          local childReddot = reddot:AddChild(tostring(singleEnv.id))
          childReddot:SetRedDotCount(1)
        end
        hasUnlockEnv = true
      end
    end
  end
  if hasUnlockEnv then
    MsgCenter:Broadcast(eMsgEventId.ActivityCarnivalEnvUnlock)
  end
end

function ActivityCarnivalData:__CalCarnivalEnvByLevel()
  local reddot = self:GetActivityReddot()
  if reddot ~= nil then
    reddot = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
  end
  local activityIsRuning = self:IsActivityRunning()
  local hasUnlockEnv = false
  if activityIsRuning then
    for i = self._lastCalEnvLevel + 1, self._level do
      local levelList = self._lockedLevelEnvDic[i]
      if levelList ~= nil then
        self._lockedLevelEnvDic[i] = nil
        for _, envId in ipairs(levelList) do
          self._unlockEnvDic[envId] = true
          self:__AddNewUnlockInfo(ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Env, envId)
          if reddot ~= nil then
            local childReddot = reddot:AddChild(tostring(envId))
            childReddot:SetRedDotCount(1)
          end
          hasUnlockEnv = ture
        end
      end
    end
  end
  self._lastCalEnvLevel = self._level
  if hasUnlockEnv then
    MsgCenter:Broadcast(eMsgEventId.ActivityCarnivalEnvUnlock)
  end
end

function ActivityCarnivalData:__InitCarnivalStageAndAvgState()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  
  local function Local_DealAvg(avgCfg)
    if avgCfg == nil then
      return
    end
    if avgPlayCtrl:IsAvgPlayed(avgCfg.id) then
      return
    end
    if avgPlayCtrl:IsAvgUnlock(avgCfg.id) then
      self._unlookAvgDic[avgCfg.id] = true
    else
      table.insert(self._lockedAvgList, avgCfg.id)
    end
  end
  
  local function Local_DealStage(stageId)
    if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
      return
    end
    if PlayerDataCenter.sectorStage:IsStageUnlock(stageId) then
      self._unComplectStageDic[stageId] = true
    else
      table.insert(self._lockedStageList, stageId)
    end
  end
  
  local sectorId = self._mainCfg.story_stage
  local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
  for _, stageId in ipairs(sectorStageCfg) do
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
      Local_DealAvg(avgCfg)
    end
    Local_DealStage(stageId)
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
      Local_DealAvg(avgCfg)
    end
  end
  self:__UpdateReviewStageReddot()
end

function ActivityCarnivalData:CalCarnivalStageAndAvgState(precondition)
  if precondition ~= CheckerTypeId.CompleteStage and precondition ~= CheckerTypeId.ActivityLevel then
    return
  end
  local hasChange = false
  while #self._lockedStageList > 0 do
    local stageId = self._lockedStageList[1]
    if not PlayerDataCenter.sectorStage:IsStageUnlock(stageId) then
      break
    end
    hasChange = true
    table.remove(self._lockedStageList, 1)
    self._unComplectStageDic[stageId] = true
    self:__AddNewUnlockInfo(ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Stage, stageId)
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  while 0 < #self._lockedAvgList do
    local avgId = self._lockedAvgList[1]
    if not avgPlayCtrl:IsAvgUnlock(avgId) then
      break
    end
    hasChange = true
    table.remove(self._lockedAvgList, 1)
    self._unlookAvgDic[avgId] = true
    self:__AddNewUnlockInfo(ActivityCarnivalEnum.eActivityCarnivalUnlockNew.AVG, avgId)
  end
  for stageId, _ in pairs(self._unComplectStageDic) do
    if PlayerDataCenter.sectorStage:IsStageComplete(stageId) then
      hasChange = true
      self._unComplectStageDic[stageId] = nil
    end
  end
  if hasChange then
    self:__UpdateReviewStageReddot()
  end
end

function ActivityCarnivalData:CalCarnivalAvgState(playedAvgId)
  if self._unlookAvgDic[playedAvgId] ~= nil then
    self._unlookAvgDic[playedAvgId] = nil
    self:__UpdateReviewStageReddot()
  end
end

function ActivityCarnivalData:UpgradLevelTech(techData, callback)
  local flag, noEnoughItemId = techData:IsLeveUpResEnough()
  if not flag then
    local tip
    if noEnoughItemId == self._mainCfg.norTechItem then
      tip = ConfigData:GetTipContent(7114)
    elseif noEnoughItemId == self._mainCfg.speTechItem then
      tip = ConfigData:GetTipContent(7115)
    end
    if tip ~= nil then
      local itemName = ConfigData:GetItemName(noEnoughItemId)
      tip = string.format(tip, itemName, itemName)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(tip)
    end
    return
  end
  if not techData:IsCouldLevelUp() then
    return
  end
  local activityFrameNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNetwork:CS_ActivityTech_Upgrade(self:GetActFrameId(), techData:GetTechId(), function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local upgradedTechElement = args[0]
    for i, elemt in ipairs(upgradedTechElement) do
      local techId = elemt.id
      local techCfg = ConfigData.activity_tech[techId]
      local techDataElemt = self._techDataDic[techCfg.branch][techId]
      if techDataElemt ~= nil then
        if techDataElemt:IsActTechAutoUnlock() then
          self:__UpdateAutoTechReddot(techDataElemt, techDataElemt:GetCurLevel(), elemt.level)
        end
        techDataElemt:UpdateWATechByMsg(elemt)
      end
    end
    self:__UpdateTechReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityCarnivalData:ResetLevelTech(branchId, callback)
  local branchTypeCfg = ConfigData.activity_tech_branch[self._mainCfg.tech_id]
  if branchTypeCfg == nil then
    error("techType is NIL ")
    return
  end
  local branchCfg = branchTypeCfg[branchId]
  if branchCfg == nil then
    error("techBranchId is NIL ")
    return
  end
  for i, itemId in ipairs(branchCfg.revertCostIds) do
    if PlayerDataCenter:GetItemCount(itemId) < branchCfg.revertCostNums[i] then
      local itemName = ConfigData:GetItemName(itemId)
      local tip = ConfigData:GetTipContent(7116)
      tip = string.format(tip, itemName, itemName)
      cs_MessageCommon.ShowMessageTipsWithErrorSound(tip)
      return
    end
  end
  local activityFrameNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNetwork:CS_ActivityTech_ResetBranch(self:GetActFrameId(), branchId, function()
    local techDataDic = self._techDataDic[branchId]
    local levelMsg = {level = 0}
    for _, techData in pairs(techDataDic) do
      if techData:IsActTechAutoUnlock() then
        self:__UpdateAutoTechReddot(techData, techData:GetCurLevel(), levelMsg.level)
      end
      techData:UpdateWATechByMsg(levelMsg)
    end
    self:__UpdateTechReddot()
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityCarnivalData:__UpdateTech(techMsg)
  if techMsg == nil then
    return
  end
  for techId, singleMsg in pairs(techMsg.techData) do
    local techCfg = ConfigData.activity_tech[techId]
    local techData = self._techDataDic[techCfg.branch][techId]
    techData:UpdateWATechByMsg(singleMsg)
  end
  self:__UpdateTechReddot()
end

function ActivityCarnivalData:__UpdateTask(msg)
  self._questDic = msg.quests
  self._questCompleteDic = msg.completedQuests
  self._questNextRefreshTm = msg.nextExpiredTm
  local questList = {}
  for taskId, _ in pairs(self._questDic) do
    table.insert(questList, taskId)
  end
  table.sort(questList, function(a, b)
    local qualityA = self:GetCarnivalTaskQuality(a)
    local qualityB = self:GetCarnivalTaskQuality(b)
    if qualityA ~= qualityB then
      return qualityA < qualityB
    end
    return a < b
  end)
  for i, taskId in ipairs(questList) do
    self._questDic[taskId] = i
  end
  self:UpdateCarnivalTaskReddot()
end

function ActivityCarnivalData:__UpdateTasksFronServer(newTaskId, oriQuestId)
  local oriPos = self._questDic[oriQuestId]
  self._questDic[oriQuestId] = nil
  self._questDic[newTaskId] = oriPos
  self:UpdateCarnivalTaskReddot()
end

function ActivityCarnivalData:__UpdateExpAndReward(msg)
  if self._level ~= msg.level or self._exp ~= msg.exp then
    self._level = msg.level
    self._exp = msg.exp
    MsgCenter:Broadcast(eMsgEventId.ActivityCarnivalExpLevelChange)
    MsgCenter:Broadcast(eMsgEventId.PreCondition, CheckerTypeId.ActivityLevel)
  end
  for level = 1, self._level do
    if not self._rewardMaskDic[level] then
      local index = math.floor(level / 32)
      local mask = msg.rewardsMask[index + 1]
      if mask ~= nil then
        self._rewardMaskDic[level] = 0 ~= mask & 1 << level % 32
      end
    end
  end
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local canReceive = false
  for level = 1, self._level do
    if not self._rewardMaskDic[level] then
      canReceive = true
      break
    end
  end
  local reddotChild = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Reward)
  reddotChild:SetRedDotCount(canReceive and 1 or 0)
end

function ActivityCarnivalData:UpdateCarnivalTaskReddot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local canComplete = false
  if self:IsActivityRunning() then
    for taskId, _ in pairs(self._questDic) do
      local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
      if taskData ~= nil and taskData:CheckComplete() then
        canComplete = true
        break
      end
    end
  end
  local reddotChild = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Task)
  reddotChild:SetRedDotCount(canComplete and 1 or 0)
end

function ActivityCarnivalData:__UpdateTechReddot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local reddotChild = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Tech)
  if not self:IsActivityRunning() then
    reddotChild:ClearChild()
    return
  end
  for branchId, branchDic in pairs(self._techDataDic) do
    local hasLeveUpTech = false
    for k, techData in pairs(branchDic) do
      if techData:IsCouldLevelUp() then
        hasLeveUpTech = true
        break
      end
    end
    local reddotChildPage = reddotChild:AddChild(branchId)
    reddotChildPage:SetRedDotCount(hasLeveUpTech and 1 or 0)
  end
end

function ActivityCarnivalData:__UpdateAutoTechReddot(actTech, lastLevel, curLevel)
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local branchId = actTech:GetActTechCfg().branch
  local reddotChild = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.AutoTech)
  reddotChild = reddotChild:AddChild(branchId)
  if curLevel < lastLevel then
    reddotChild:RemoveChild(actTech:GetTechId())
  elseif lastLevel < curLevel then
    reddotChild:AddChild(actTech:GetTechId()):SetRedDotCount(1)
  end
end

function ActivityCarnivalData:__UpdateReviewStageReddot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local reddotChild = reddot:AddChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockStage)
  if table.count(self._unlookAvgDic) > 0 or 0 < table.count(self._unComplectStageDic) then
    reddotChild:SetRedDotCount(1)
  else
    reddotChild:SetRedDotCount(0)
  end
end

function ActivityCarnivalData:__AddNewUnlockInfo(unlockType, unlockId)
  local data = {unlockType = unlockType, unlockId = unlockId}
  table.insert(self._newUnlockInfoList, data)
end

function ActivityCarnivalData:ClearNewUnlockInfo()
  table.removeall(self._newUnlockInfoList)
end

function ActivityCarnivalData:DealCarnivalWhenEnd()
  local reddot = self:GetActivityReddot()
  if reddot ~= nil then
    reddot:RemoveChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Task)
    reddot:RemoveChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockEnv)
    reddot:RemoveChild(ActivityCarnivalEnum.eActivityCarnivalReddot.TaskPeriod)
    reddot:RemoveChild(ActivityCarnivalEnum.eActivityCarnivalReddot.Tech)
    reddot:RemoveChild(ActivityCarnivalEnum.eActivityCarnivalReddot.UnlockHardDun)
    reddot:RemoveChild(ActivityCarnivalEnum.eActivityCarnivalReddot.AutoTech)
  end
  local count = #self._newUnlockInfoList
  for i = count, 1, -1 do
    local item = self._newUnlockInfoList[i]
    if item.unlockType == ActivityCarnivalEnum.eActivityCarnivalUnlockNew.Env then
      table.remove(self._newUnlockInfoList, i)
    end
  end
  ExplorationManager:RemoveEpNewEpBuffSelect(self._mainCfg.main_stage)
end

function ActivityCarnivalData:ReqCarnivalSingleTaskRefresh(taskId, callback)
  local activityCarnivalNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityCarnival)
  activityCarnivalNetwork:CS_ACTIVITY_Carnival_RefreshQuestSingle(self:GetActId(), taskId, function(args)
    if (args == nil or args.Count == 0) and isGameDev then
      error("args.Count == 0")
    end
    local msg = args[0]
    local newTaskId
    for k, v in pairs(msg.quests) do
      if self._questDic[k] == nil then
        newTaskId = k
        break
      end
    end
    if newTaskId == nil then
      if isGameDev then
        error(" change task not found ")
      end
      return
    end
    self:__UpdateTasksFronServer(newTaskId, taskId)
    if callback ~= nil then
      callback(newTaskId, taskId)
    end
  end)
end

function ActivityCarnivalData:ReqCarnivalCycleReward(callback)
  if not self:IsCanCarnivalCycleReward() then
    return
  end
  local rewardIds = {}
  local rewardNums = {}
  local mul = self._exp // self._cycleExpNeed
  for id, count in pairs(self._mainCfg.cir_reward) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, count * mul)
  end
  local crtransdIC = PlayerDataCenter:CalCrItemTransDic(rewardIds, rewardNums)
  local activityCarnivalNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityCarnival)
  activityCarnivalNetwork:CS_ACTIVITY_Carnival_PickCirCleReward(self:GetActId(), function(args)
    if args == nil or args.Count == 0 then
      if isGameDev then
        error("args.Count == 0")
      end
      return
    end
    local msg = args[0]
    local rewards = msg.rewards
    UIUtil.ShowCommonReward(rewards, crtransdIC)
    self._exp = self._exp % self._cycleExpNeed
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityCarnivalData:ReqCarnivalAllReward(callback)
  local rewardIds = {}
  local rewardNums = {}
  local mul = self._exp // self._cycleExpNeed
  for id, count in pairs(self._mainCfg.cir_reward) do
    table.insert(rewardIds, id)
    table.insert(rewardNums, count * mul)
  end
  for level = 1, self._level do
    if not self:IsReceivedLevelReward(level) then
      local cfg = self._expCfg[level]
      for i, itemId in ipairs(cfg.rewardIds) do
        local itemCount = cfg.rewardNums[i]
        local index = table.indexof(rewardIds, itemId)
        if index then
          rewardNums[index] = rewardNums[index] + itemCount
        else
          table.insert(rewardIds, itemId)
          table.insert(rewardNums, itemCount)
        end
      end
    end
  end
  local crtransdIC = PlayerDataCenter:CalCrItemTransDic(rewardIds, rewardNums)
  local activityCarnivalNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityCarnival)
  activityCarnivalNetwork:CS_ACTIVITY_Carnival_PickAllLevelReward(self:GetActId(), function(args)
    if args == nil or args.Count == 0 then
      if isGameDev then
        error("args.Count == 0")
      end
      return
    end
    local msg = args[0]
    local rewards = msg.rewards
    UIUtil.ShowCommonReward(rewards, crtransdIC)
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityCarnivalData:ReqCarnivalLevelReward(level, callback)
  if self:IsReceivedLevelReward(level) or level > self._level then
    return
  end
  local cfg = self._expCfg[level]
  local crtransdIC = PlayerDataCenter:CalCrItemTransDic(cfg.rewardIds, cfg.rewardNums)
  local activityCarnivalNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityCarnival)
  activityCarnivalNetwork:CS_ACTIVITY_Carnival_PickLevelReward(self:GetActId(), level, function(args)
    if args == nil or args.Count == 0 then
      if isGameDev then
        error("args.Count == 0")
      end
      return
    end
    local msg = args[0]
    local rewards = msg.rewards
    UIUtil.ShowCommonReward(rewards, crtransdIC)
    if callback ~= nil then
      callback()
    end
  end)
end

function ActivityCarnivalData:GetCarnivalExpCfg()
  return self._expCfg
end

function ActivityCarnivalData:IsCanCarnivalCycleReward()
  return self._exp > self._cycleExpNeed
end

function ActivityCarnivalData:GetCarnivalMainCfg()
  return self._mainCfg
end

function ActivityCarnivalData:GetCarnivalEpStageCfg()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local envId, diffculty = saveUserData:GetCarnivalDiffEnv(self._mainCfg.id)
  local envCfg
  if envId == nil then
    envCfg = self._envCfg[1]
    diffculty = 1
  else
    envCfg = self:GetCarnivalEnvCfgById(envId)
  end
  local stageId = envCfg.stage_id[diffculty]
  local stageCfg = ConfigData.sector_stage[stageId]
  return stageCfg
end

function ActivityCarnivalData:GetCarnivalLevelExp()
  return self._level, self._exp
end

function ActivityCarnivalData:GetCarnivalMaxLevel()
  return self._maxLevel
end

function ActivityCarnivalData:GetCarnivalExpProcess()
  return self._expCfg[self._level].totalExp, self._expCfg[self._maxLevel].totalExp
end

function ActivityCarnivalData:IsReceivedLevelReward(level)
  return self._rewardMaskDic[level]
end

function ActivityCarnivalData:GetCarnivalTask()
  return self._questDic
end

function ActivityCarnivalData:GetCarnivalTaskQuality(taskId)
  local quality = self._mainCfg.pool_quality[taskId]
  if quality == nil then
    quality = 0
  end
  return quality
end

function ActivityCarnivalData:GetCarnivalTaskNextTm()
  return self._questNextRefreshTm
end

function ActivityCarnivalData:GetCarnivalTech()
  return self._techDataDic
end

function ActivityCarnivalData:GetCarnivalHardLevelCfg()
  return self._levelTypeCfg
end

function ActivityCarnivalData:GetCarnivalTechType()
  return self._mainCfg.tech_id
end

function ActivityCarnivalData:GetCarnivalStage()
  return self._curStage
end

function ActivityCarnivalData:GetCarnivalUnlockEnv()
  return self._unlockEnvDic
end

function ActivityCarnivalData:IsCarnivalUnlockEnv(envId)
  return self._unlockEnvDic[envId]
end

function ActivityCarnivalData:GetCarnivalTechBranchLevel(branchId)
  local curLevel = 0
  local techDic = self._techDataDic[branchId]
  for k, techData in pairs(techDic) do
    if not techData:IsActTechAutoUnlock() then
      curLevel = curLevel + techData:GetCurLevel()
    end
  end
  return curLevel
end

function ActivityCarnivalData:GetCarnivalRowsDic()
  return self._techRowDic
end

function ActivityCarnivalData:GetCarnivalTechRow(rowIndex)
  local rowCfg = ConfigData.activity_tech_line[rowIndex]
  if rowCfg == nil then
    return 0
  end
  return rowCfg.num
end

function ActivityCarnivalData:GetCarnivalTinyGame()
  return self._gameWatermelon
end

function ActivityCarnivalData:GetNewunlockInfo()
  return self._newUnlockInfoList
end

function ActivityCarnivalData:IsExistCarnivalNewunlock()
  return #self._newUnlockInfoList > 0
end

function ActivityCarnivalData:GetCarnivalChallengeRecord(dungeonId)
  if dungeonId == nil or self._dungeonFrame == nil then
    error("dungeonFrame NIL or param error")
    return nil
  end
  return self._dungeonFrame[dungeonId]
end

function ActivityCarnivalData:GetCarnivalEnvCfg()
  return self._envCfg
end

function ActivityCarnivalData:GetCarnivalEnvCfgById(envId)
  return ConfigData.activity_carnival_env[self:GetActId()][envId]
end

function ActivityCarnivalData:GetActivityReddotNum()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return false, 0
  end
  if reddot:GetRedDotCount() == 0 then
    return false, 0
  end
  local isBule = true
  for _, nodeId in ipairs(ActivityCarnivalEnum.eReddotShowRedTypes) do
    local childReddot = reddot:GetChild(nodeId)
    if childReddot ~= nil and 0 < childReddot:GetRedDotCount() then
      isBule = false
      break
    end
  end
  return isBule, reddot:GetRedDotCount()
end

return ActivityCarnivalData
