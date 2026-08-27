local DungeonCenterData = class("DungeonCenterData")

function DungeonCenterData:ctor()
  self._dgChallengeQuestDic = {}
end

function DungeonCenterData:IsDgChallengeTaskComplete(dungeonId, questId)
  local key = dungeonId << 32 | questId
  return self._dgChallengeQuestDic[key] ~= nil
end

function DungeonCenterData:SetDgChallengeTaskComplete(dungeonId, questId)
  local key = dungeonId << 32 | questId
  self._dgChallengeQuestDic[key] = true
end

function DungeonCenterData:HasDungeonChallengeTask(dungeonId)
  local dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  if dungeonCfg == nil then
    error("cant get dungeonCfg, id = " .. tostring(dungeonId))
    return false
  end
  return #dungeonCfg.hard_task > 0
end

function DungeonCenterData:IsDungeonChallengeTaskOpen(dungeonId)
  if not self:HasDungeonChallengeTask(dungeonId) then
    return false
  end
  return true
end

function DungeonCenterData:IsDgChallengeTaskCompleteAll(dungeonId)
  local dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  if dungeonCfg == nil then
    error("cant get dungeonCfg, id = " .. tostring(dungeonId))
    return false
  end
  local completeAll = true
  for k, taskId in ipairs(dungeonCfg.hard_task) do
    if not self:IsDgChallengeTaskComplete(dungeonId, taskId) then
      completeAll = false
      break
    end
  end
  return completeAll
end

function DungeonCenterData:GetDgChallengeTaskCompleteNum(dungeonId)
  local dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  if dungeonCfg == nil then
    error("cant get dungeonCfg, id = " .. tostring(dungeonId))
    return 0
  end
  local num = 0
  for k, taskId in ipairs(dungeonCfg.hard_task) do
    if self:IsDgChallengeTaskComplete(dungeonId, taskId) then
      num = num + 1
    end
  end
  return num
end

function DungeonCenterData:GetDgChallengeTaskNum(dungeonId)
  local dungeonCfg = ConfigData.battle_dungeon[dungeonId]
  if dungeonCfg == nil then
    error("cant get dungeonCfg, id = " .. tostring(dungeonId))
    return 0
  end
  return #dungeonCfg.hard_task
end

return DungeonCenterData
