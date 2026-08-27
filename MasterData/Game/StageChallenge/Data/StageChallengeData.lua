local StageChallengeData = class("StageChallengeData")

function StageChallengeData.Create(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    error("cant get stageCfg, id = " .. tostring(stageId))
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isOpen
  if PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(stageId) then
    isOpen = saveUserData:GetChallengeStageSwitch(stageId)
  else
    isOpen = false
  end
  local lastOpenTaskDic = saveUserData:GetChallengeStageTaskOptDic(stageId)
  local challengeTaskIdOptDic = {}
  for k, taskId in ipairs(stageCfg.hard_task) do
    if stageCfg.is_optional[k] and lastOpenTaskDic[taskId] then
      challengeTaskIdOptDic[taskId] = true
    end
  end
  local data = StageChallengeData.New(stageCfg, isOpen, challengeTaskIdOptDic)
  return data
end

function StageChallengeData:ctor(stageCfg, isOpen, optionalTaskOpenDic)
  self._stageCfg = stageCfg
  self:SetStageChallengeOpen(isOpen)
  self:SetStgClgOptionalTaskOpenDic(optionalTaskOpenDic)
end

function StageChallengeData:SetStageChallengeOpen(isOpen)
  self._isOpen = isOpen
end

function StageChallengeData:IsStageChallengeOpen()
  return self._isOpen
end

function StageChallengeData:SetStgClgOptionalTaskOpenDic(optionalTaskOpenDic)
  self._optionalTaskOpenDic = optionalTaskOpenDic
end

function StageChallengeData:GetStgClgOptionalTaskOpenDic(isCopy)
  if isCopy then
    local dic = {}
    for k, v in pairs(self._optionalTaskOpenDic) do
      dic[k] = v
    end
    return dic
  end
  return self._optionalTaskOpenDic
end

function StageChallengeData:GetStgClgOptionalTaskOpenList()
  if self._optionalTaskOpenDic == nil then
    return table.emptytable
  end
  local list = {}
  for taskId, v in pairs(self._optionalTaskOpenDic) do
    table.insert(list, taskId)
  end
  return list
end

function StageChallengeData:GetStgChallengeTaskList()
  return self._stageCfg.hard_task
end

function StageChallengeData:IsStgChallengeTaskComplete(taskId)
  return PlayerDataCenter.sectorAchievementDatas:IsChallengeTaskComplete(self._stageCfg.id, taskId)
end

function StageChallengeData:IsStgAllChallengeTaskComplete()
  local taskIdList = self:GetStgChallengeTaskList()
  for _, taskId in pairs(taskIdList) do
    if not self:IsStgChallengeTaskComplete(taskId) then
      return false
    end
  end
  return true
end

function StageChallengeData:GetStgChallengePowerLimitCfg()
  local sctPowerLimitCfg = ConfigData.power_limit[self._stageCfg.power_limit]
  if sctPowerLimitCfg == nil then
    error("Cant get power_limit, id = " .. tostring(self._stageCfg.power_limit))
    return
  end
  return sctPowerLimitCfg
end

function StageChallengeData:GetStgChallengeTaskRewardNum()
  if not self._isOpen then
    return 0
  end
  local taskNum = 0
  for k, taskId in ipairs(self:GetStgChallengeTaskList()) do
    local isOptional = self._stageCfg.is_optional[k]
    local isOpen = true
    if isOptional then
      isOpen = self._optionalTaskOpenDic[taskId]
    end
    if isOpen and not PlayerDataCenter.sectorAchievementDatas:IsChallengeTaskComplete(self._stageCfg.id, taskId) then
      taskNum = taskNum + 1
    end
  end
  local rewardNum = ConfigData.game_config.stageChallengeTaskRewardPerNum * taskNum
  return rewardNum
end

function StageChallengeData:TrySaveStgChallengeTask()
  local stageId = self._stageCfg.id
  if not PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskCompleteAll(stageId) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetChallengeStageSwitch(stageId, self._isOpen)
    if self._isOpen then
      local challengeTaskIdOptDic = self:GetStgClgOptionalTaskOpenDic()
      saveUserData:SetChallengeStageTaskOptDic(stageId, challengeTaskIdOptDic)
    end
  end
end

function StageChallengeData:SetClgCustomLeftTip(tipStr)
  self._customLeftTip = tipStr
end

function StageChallengeData:GetClgCustomLeftTip()
  return self._customLeftTip
end

function StageChallengeData:IsChallengeTaskUnlcok()
  local stageId = self._stageCfg.id
  return PlayerDataCenter.sectorAchievementDatas:IsStageChallengeTaskOpen(stageId)
end

return StageChallengeData
