local base = require("Game.StageChallenge.Data.StageChallengeData")
local DungeonChallengeData = class("DungeonChallengeData", base)

function DungeonChallengeData.Create(dungeonId)
  local dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  if dungeonCfg == nil then
    error("cant get dungeonCfg, id = " .. tostring(dungeonId))
    return
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local isOpen
  if PlayerDataCenter.dungeonCenterData:IsDungeonChallengeTaskOpen(dungeonId) then
    isOpen = saveUserData:GetChallengeDgSwitch(dungeonId)
  else
    isOpen = false
  end
  local lastOpenTaskDic = saveUserData:GetChallengeDgTaskOptDic(dungeonId)
  local challengeTaskIdOptDic = {}
  for k, taskId in ipairs(dungeonCfg.hard_task) do
    if dungeonCfg.is_optional[k] and lastOpenTaskDic[taskId] then
      challengeTaskIdOptDic[taskId] = true
    end
  end
  local data = DungeonChallengeData.New(dungeonCfg, isOpen, challengeTaskIdOptDic)
  return data
end

function DungeonChallengeData:ctor(dungeonCfg, isOpen, optionalTaskOpenDic)
  self._dungeonCfg = dungeonCfg
  self:SetStageChallengeOpen(isOpen)
  self:SetStgClgOptionalTaskOpenDic(optionalTaskOpenDic)
  self.isDgChallenge = true
  self:SetClgCustomLeftTip(ConfigData:GetTipContent(4008))
end

function DungeonChallengeData:GetStgChallengeTaskList()
  return self._dungeonCfg.hard_task
end

function DungeonChallengeData:IsStgChallengeTaskComplete(taskId)
  return PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskComplete(self._dungeonCfg.id, taskId)
end

function DungeonChallengeData:GetStgChallengeTaskRewardNum()
  if not self._isOpen then
    return 0
  end
  local taskNum = 0
  for k, taskId in ipairs(self:GetStgChallengeTaskList()) do
    local isOptional = self._dungeonCfg.is_optional[k]
    local isOpen = true
    if isOptional then
      isOpen = self._optionalTaskOpenDic[taskId]
    end
    if isOpen and not self:IsStgChallengeTaskComplete(taskId) then
      taskNum = taskNum + 1
    end
  end
  local rewardNum = ConfigData.game_config.stageChallengeTaskRewardPerNum * taskNum
  return rewardNum
end

function DungeonChallengeData:TrySaveStgChallengeTask()
  local dungeonId = self._dungeonCfg.id
  if not PlayerDataCenter.dungeonCenterData:IsDgChallengeTaskCompleteAll(dungeonId) then
    local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    saveUserData:SetChallengeDgSwitch(dungeonId, self._isOpen)
    if self._isOpen then
      local challengeTaskIdOptDic = self:GetStgClgOptionalTaskOpenDic()
      saveUserData:SetChallengeDgTaskOptDic(dungeonId, challengeTaskIdOptDic)
    end
  end
end

function DungeonChallengeData:GetDgStgClgTaskDungeonId()
  return self._dungeonCfg.id
end

function DungeonChallengeData:GetStgClgTaskOpenList()
  if not self:IsStageChallengeOpen() then
    return table.emptytable
  end
  local list = {}
  for k, taskId in ipairs(self:GetStgChallengeTaskList()) do
    local isOptional = self._dungeonCfg.is_optional[k]
    if isOptional then
      local isOpen = self._optionalTaskOpenDic[taskId]
      if isOpen then
        table.insert(list, taskId)
      end
    else
      table.insert(list, taskId)
    end
  end
  return list
end

return DungeonChallengeData
