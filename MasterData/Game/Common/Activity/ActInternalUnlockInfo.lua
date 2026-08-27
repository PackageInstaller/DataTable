local ActInternalUnlockInfo = class("ActInternalUnlockInfo")
local ActCommonEnum = require("Game.Common.Activity.ActCommonEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")

function ActInternalUnlockInfo:ctor()
  self._newUnlockInfoList = {}
end

function ActInternalUnlockInfo:InitActAvgUnlockInfo(sectorId)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local avgList = ConfigData.story_avg.sectorAvgDic[sectorId]
  if avgList == nil then
    return
  end
  self._lockedAvgList = {}
  for _, avgId in pairs(avgList) do
    if not avgPlayCtrl:IsAvgPlayed(avgId) and not avgPlayCtrl:IsAvgUnlock(avgId) then
      table.insert(self._lockedAvgList, avgId)
    end
  end
end

function ActInternalUnlockInfo:UpdateActAvgUnlockInfo()
  if self._lockedAvgList == nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  while #self._lockedAvgList > 0 do
    local avgId = self._lockedAvgList[1]
    if not avgPlayCtrl:IsAvgUnlock(avgId) then
      break
    end
    table.remove(self._lockedAvgList, 1)
    self:__AddNewUnlockInfo(ActCommonEnum.ActUnlockType.NormalAvg, avgId)
  end
end

function ActInternalUnlockInfo:InitActEnvDiffUnlockInfo(diffLockDic)
  self._diffLockDic = diffLockDic
end

function ActInternalUnlockInfo:GetActEnvDiffUnlockInfo()
  return self._diffLockDic
end

function ActInternalUnlockInfo:AddActEnvDiffUnlockInfo(diff)
  if self._diffLockDic == nil then
    return
  end
  local envId = self._diffLockDic[diff]
  if envId == nil then
    return
  end
  self:__AddNewUnlockInfo(ActCommonEnum.ActUnlockType.EnvDifficulty, diff, envId)
  self._diffLockDic[diff] = nil
end

function ActInternalUnlockInfo:InitActDunRepeatUnlockInfo(dunLockDic)
  self._dunLockDic = dunLockDic
end

function ActInternalUnlockInfo:UpdateActDunRepeatUnlockInfo()
  if self._dunLockDic == nil then
    return
  end
  for dungeonId, dungeonData in pairs(self._dunLockDic) do
    if dungeonData:GetIsLevelUnlock() then
      self:__AddNewUnlockInfo(ActCommonEnum.ActUnlockType.DunRepeat, dungeonId)
      self._dunLockDic[dungeonId] = nil
    end
  end
end

function ActInternalUnlockInfo:InitAvgPlayedUnlockInfo(avgList)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  self._avgPlayedList = {}
  for _, avgId in pairs(avgList) do
    if not avgPlayCtrl:IsAvgPlayed(avgId) then
      table.insert(self._avgPlayedList, avgId)
    end
  end
end

function ActInternalUnlockInfo:UpdateAvgPlayedUnlockInfo()
  if self._avgPlayedList == nil or self._avgPlayedList[1] == nil then
    return
  end
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for i = #self._avgPlayedList, 1, -1 do
    if not avgPlayCtrl:IsAvgPlayed(self._avgPlayedList[i]) then
      break
    end
    table.remove(self._avgPlayedList, i)
  end
  if self._avgPlayedList[1] == nil then
    self:__AddNewUnlockInfo(ActCommonEnum.ActUnlockType.AVGAllPlayed, 0, 0)
  end
end

function ActInternalUnlockInfo:InitEnvUnlockInfo(envIdDic)
  self._envDic = envIdDic
end

function ActInternalUnlockInfo:AddEnvUnlockInfo(envId)
  if self._envDic == nil or self._envDic[envId] == nil then
    return
  end
  self._envDic[envId] = nil
  self:__AddNewUnlockInfo(ActCommonEnum.ActUnlockType.Env, envId, 0)
end

function ActInternalUnlockInfo:GetEnvUnlockInfo()
  return self._envDic
end

function ActInternalUnlockInfo:InitInteractUnlockInfo(interactIdDic)
  self._interactIdDic = interactIdDic
end

function ActInternalUnlockInfo:AddInteractUnlockInfo(interactId)
  if self._interactIdDic == nil or self._interactIdDic[interactId] == nil then
    return
  end
  self._interactIdDic[interactId] = nil
  self:__AddNewUnlockInfo(ActCommonEnum.ActUnlockType.InteractId, interactId, 0)
end

function ActInternalUnlockInfo:GetInteractUnlockInfo()
  return self._interactIdDic
end

function ActInternalUnlockInfo:__AddNewUnlockInfo(unlockType, unlockId, unlockPara)
  local data = {
    unlockType = unlockType,
    unlockId = unlockId,
    unlockPara = unlockPara
  }
  table.insert(self._newUnlockInfoList, data)
  if type(data.unlockId) == "number" then
    table.sort(self._newUnlockInfoList, function(a, b)
      return a.unlockId < b.unlockId
    end)
  end
end

function ActInternalUnlockInfo:ClearActUnlockInfo()
  table.removeall(self._newUnlockInfoList)
end

function ActInternalUnlockInfo:GetActUnlockInfoList()
  return self._newUnlockInfoList
end

function ActInternalUnlockInfo:IsExistActUnlockInfo()
  return #self._newUnlockInfoList > 0
end

function ActInternalUnlockInfo:ClearFirstActUnlockInfo()
  if self:IsExistActUnlockInfo() then
    table.remove(self._newUnlockInfoList, 1)
  end
end

function ActInternalUnlockInfo:ResetAllUnlockData()
  self:ClearActUnlockInfo()
  self._diffLockDic = nil
  self._lockedAvgList = nil
  self._dunLockDic = nil
  self._envDic = nil
  self._avgPlayedList = nil
  self._interactIdDic = nil
end

return ActInternalUnlockInfo
