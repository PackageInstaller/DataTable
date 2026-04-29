_class("SkillScopeFilterDevice", Object)
SkillScopeFilterDevice = SkillScopeFilterDevice
SkillScopeFilterType = {
  CasterOccupied = 1,
  ObstacleTrap = 3,
  MonsterOccupied = 4,
  ObstacleTrapByID = 5,
  SkillTargetSelectionMode = 6,
  MAX = 99
}
_enum("SkillScopeFilterType", SkillScopeFilterType)

function SkillScopeFilterDevice:Constructor()
  self._filters = {
    [SkillScopeFilterType.CasterOccupied] = SkillScopeFilter_CasterOccupied:New(),
    [SkillScopeFilterType.ObstacleTrap] = SkillScopeFilter_ObstacleTrap:New(),
    [SkillScopeFilterType.MonsterOccupied] = SkillScopeFilter_MonsterOccupied:New(),
    [SkillScopeFilterType.ObstacleTrapByID] = SkillScopeFilter_ObstacleTrapByID:New(),
    [SkillScopeFilterType.SkillTargetSelectionMode] = SkillScopeFilter_SkillTargetSelectionMode:New()
  }
  self._filterSwitch = {
    [SkillScopeFilterType.CasterOccupied] = "GetCasterOccupiedPosFilter",
    [SkillScopeFilterType.ObstacleTrap] = "GetObstructingTrapFilter",
    [SkillScopeFilterType.MonsterOccupied] = "GetMonsterOccupiedPosFilter",
    [SkillScopeFilterType.ObstacleTrapByID] = "GetObstructingTrapByIDFilter",
    [SkillScopeFilterType.SkillTargetSelectionMode] = "GetTargetSelectionMode"
  }
end

function SkillScopeFilterDevice:DoFilter(scopeResult, filterParam, passParam)
  for enumKey, filter in pairs(self._filters) do
    local switchFuncName = self._filterSwitch[enumKey]
    if switchFuncName and type(filterParam[switchFuncName]) == "function" then
      local switchFunc = filterParam[switchFuncName]
      if switchFunc(filterParam) then
        filter:DoModifyRange(scopeResult, filterParam, passParam)
      end
    else
      Log.error(self._className, "filter [", enumKey, "] do not have a switch in SkillScopeFilterParam")
    end
  end
end
