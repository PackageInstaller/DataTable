_class("UIActivityN21CCLevelGroupData", Object)
UIActivityN21CCLevelGroupData = UIActivityN21CCLevelGroupData

function UIActivityN21CCLevelGroupData:Constructor(cfgs, missionComponentInfo)
  self._timeModule = GameGlobal.GetModule(SvrTimeModule)
  self._levels = {}
  if not cfgs then
    return
  end
  for i = 1, #cfgs do
    self._levels[#self._levels + 1] = UIActivityN21CCLevelData:New(cfgs[i], missionComponentInfo)
  end
end

function UIActivityN21CCLevelGroupData:Refresh()
  for i = 1, #self._levels do
    self._levels[i]:Refresh()
  end
end

function UIActivityN21CCLevelGroupData:GetLevels()
  return self._levels
end

function UIActivityN21CCLevelGroupData:IsLevelGroupOpen()
  if #self._levels <= 0 then
    return false
  end
  return self._levels[1]:IsLevelOpen()
end

function UIActivityN21CCLevelGroupData:GetIcon()
  if #self._levels <= 0 then
    return ""
  end
  return self._levels[1]:GetMonsterIcon()
end

function UIActivityN21CCLevelGroupData:GetName()
  if #self._levels <= 0 then
    return ""
  end
  return self._levels[1]:GetMonsterName()
end

function UIActivityN21CCLevelGroupData:GetIndex()
  if #self._levels <= 0 then
    return 0
  end
  return self._levels[1]:GetIndex()
end

function UIActivityN21CCLevelGroupData:GetMaxScore()
  if #self._levels <= 0 then
    return 0
  end
  local maxScore = 0
  for i = 1, #self._levels do
    local score = self._levels[i]:GetMaxScore()
    if maxScore < score then
      maxScore = score
    end
  end
  return maxScore
end

function UIActivityN21CCLevelGroupData:GetElementIcon1()
  if #self._levels <= 0 then
    return nil
  end
  return self._levels[1]:GetElementIcon1()
end

function UIActivityN21CCLevelGroupData:GetElementIcon2()
  if #self._levels <= 0 then
    return nil
  end
  return self._levels[1]:GetElementIcon2()
end

function UIActivityN21CCLevelGroupData:GetUnlockTime()
  if #self._levels <= 0 then
    return false
  end
  return self._levels[1]:GetUnlockTime()
end

function UIActivityN21CCLevelGroupData:GetUnlockSeconds()
  local nowTime = self._timeModule:GetServerTime() / 1000
  local unlockTime = self:GetUnlockTime()
  local seconds = unlockTime - nowTime
  if seconds < 0 then
    seconds = 0
  end
  return seconds
end

function UIActivityN21CCLevelGroupData:IsShowRed()
  if self:IsLevelGroupOpen() == false then
    return false
  end
  local result = true
  for i = 1, #self._levels do
    local level = self._levels[i]
    local missionId = level:GetMissionId()
    if not self:GetNewFlagStatus("MISSION_ENTER_STATUS" .. missionId) then
      result = false
      break
    end
  end
  if not result then
    return false
  end
  local index = self:GetIndex()
  local status = UIActivityN21CCConst.GetLevelRedStatus()
  if status[index] then
    return false
  end
  return true
end

function UIActivityN21CCLevelGroupData:ClearOnceRedStatus()
  if self:IsLevelGroupOpen() == false then
    return
  end
  local status = UIActivityN21CCConst.GetLevelRedStatus()
  local index = self:GetIndex()
  status[index] = true
end

function UIActivityN21CCLevelGroupData:IsShowNew()
  if self:IsLevelGroupOpen() == false then
    return false
  end
  return self:GetNewFlagStatus("LEVEL_INDEX" .. self:GetIndex())
end

function UIActivityN21CCLevelGroupData:ClearNewStatus()
  if self:IsLevelGroupOpen() == false then
    return
  end
  self:SetNewFlagStatus("LEVEL_INDEX" .. self:GetIndex())
end

function UIActivityN21CCLevelGroupData:GetNewFlagStatus(id)
  return UIActivityN21CCConst.GetNewFlagStatus(id)
end

function UIActivityN21CCLevelGroupData:SetNewFlagStatus(id, status)
  UIActivityN21CCConst.SetNewFlagStatus(id, status)
end

function UIActivityN21CCLevelGroupData:IsHardOpen(hard)
  for i = 1, #self._levels do
    local level = self._levels[i]
    if level:GetHardId() == hard then
      return level:IsLevelOpen()
    end
  end
  return false
end

_class("UIActivityN21CCLevelGroupsData", Object)
UIActivityN21CCLevelGroupsData = UIActivityN21CCLevelGroupsData

function UIActivityN21CCLevelGroupsData:Constructor(componentId, missionComponentInfo)
  self._levelGroups = {}
  local cfgs = Cfg.cfg_component_challenge_mission({ComponentID = componentId})
  if not cfgs then
    return
  end
  local t = {}
  for _, cfg in pairs(cfgs) do
    local levelIndex = cfg.LeveIndex
    local tmp = t[levelIndex]
    if not tmp then
      tmp = {}
      t[levelIndex] = tmp
    end
    tmp[#tmp + 1] = cfg
  end
  table.sort(t, function(a, b)
    return a[1].LeveIndex < b[1].LeveIndex
  end)
  for i = 1, #t do
    table.sort(t[i], function(a, b)
      return a.HardID < b.HardID
    end)
  end
  for i = 1, #t do
    self._levelGroups[#self._levelGroups + 1] = UIActivityN21CCLevelGroupData:New(t[i], missionComponentInfo)
  end
end

function UIActivityN21CCLevelGroupsData:Refresh()
  for i = 1, #self._levelGroups do
    self._levelGroups[i]:Refresh()
  end
end

function UIActivityN21CCLevelGroupsData:GetLevelGroups()
  return self._levelGroups
end

function UIActivityN21CCLevelGroupsData:GetOpenLevelGroups()
  local t = {}
  for i = 1, #self._levelGroups do
    if self._levelGroups[i]:IsLevelGroupOpen() then
      t[#t + 1] = self._levelGroups[i]
    end
  end
  return t
end

function UIActivityN21CCLevelGroupsData:GetLockLevelGroups()
  local t = {}
  for i = 1, #self._levelGroups do
    if not self._levelGroups[i]:IsLevelGroupOpen() then
      t[#t + 1] = self._levelGroups[i]
    end
  end
  table.sort(t, function(a, b)
    local aTime = a:GetUnlockTime()
    local bTime = b:GetUnlockTime()
    if aTime ~= bTime then
      return aTime > bTime
    end
    return a:GetIndex() > b:GetIndex()
  end)
  return t
end

function UIActivityN21CCLevelGroupsData:GetLevelGroupDataByIndex(index)
  for i = 1, #self._levelGroups do
    if self._levelGroups[i]:GetIndex() == index then
      return self._levelGroups[i]
    end
  end
end
