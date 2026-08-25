local _TryRemoveDirector = CS.AMTimeline.AMResourcesCache.TryRemoveDirector
local UnityTime = CS.UnityEngine.Time
local DelayAutoDestroyTime = 10
local BattleKeeperSkillAssetCache = System.NewClass("BattleKeeperSkillAssetCache")

function BattleKeeperSkillAssetCache:ctor()
  self._skillTimelines = {}
  self._residentSkillTimelinesMap = {}
end

function BattleKeeperSkillAssetCache:SetAsResident(skillPath)
  self._residentSkillTimelinesMap[skillPath] = true
end

function BattleKeeperSkillAssetCache:ChangeKeeperSkill(skillTid)
  local skillFile = KeeperSkillUtils.GetSkillTimelinePath(skillTid)
  if not skillFile then
    return
  end
  local skillList = {}
  for skillPath, isResident in pairs(self._residentSkillTimelinesMap) do
    if isResident and skillPath ~= skillFile then
      table.insert(skillList, skillPath)
    end
  end
  table.clear(self._residentSkillTimelinesMap)
  self:SetAsResident(skillFile)
  for i = #self._skillTimelines, 1, -1 do
    if self._skillTimelines[i].timeline == skillFile then
      table.remove(self._skillTimelines, i)
    end
  end
  for i = 1, #skillList do
    self:PlayKeeperSkill(skillList[i])
  end
end

function BattleKeeperSkillAssetCache:PlayKeeperSkill(skillPath)
  if not _TryRemoveDirector or not skillPath then
    return
  end
  if self._residentSkillTimelinesMap[skillPath] then
    return
  end
  for i = 1, #self._skillTimelines do
    if self._skillTimelines[i].timeline == skillPath then
      self._skillTimelines[i].time = UnityTime.time
      return
    end
  end
  table.insert(self._skillTimelines, {
    timeline = skillPath,
    time = UnityTime.time
  })
end

function BattleKeeperSkillAssetCache:Update()
  if not _TryRemoveDirector or 0 == #self._skillTimelines then
    return
  end
  local curTime = UnityTime.time
  for i = #self._skillTimelines, 1, -1 do
    local time = self._skillTimelines[i].time
    if curTime - time >= DelayAutoDestroyTime then
      _TryRemoveDirector(self._skillTimelines[i].timeline)
      table.remove(self._skillTimelines, i)
    end
  end
end

function BattleKeeperSkillAssetCache:Dispose()
  if not _TryRemoveDirector then
    return
  end
  table.clear(self._skillTimelines)
  table.clear(self._residentSkillTimelinesMap)
end

BattleKeeperSkillAssetCache.Instance = BattleKeeperSkillAssetCache()
return BattleKeeperSkillAssetCache
