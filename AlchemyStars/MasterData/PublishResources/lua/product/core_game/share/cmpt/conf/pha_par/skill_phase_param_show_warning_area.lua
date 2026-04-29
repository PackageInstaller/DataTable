local WarningCenterPosType = {
  CasterPos = 1,
  GridPos = 2,
  CasterPosOffSet = 3,
  EffectPos = 4
}
_enum("WarningCenterPosType", WarningCenterPosType)
require("skill_phase_param_base")
_class("SkillPhaseParam_ShowWarningArea", SkillPhaseParamBase)
SkillPhaseParam_ShowWarningArea = SkillPhaseParam_ShowWarningArea

function SkillPhaseParam_ShowWarningArea:Constructor(t)
  self._warningCenterPosType = t.warningCenterPosType
  self._warningCenterPosParam = t.warningCenterPosParam
  self._warningTextEffectID = t.warningTextEffectID
  self._areaRes = t.areaRes
  self._hasDeadWarning = t.hasDeadWarning
end

function SkillPhaseParam_ShowWarningArea:GetCacheTable()
  local t = {
    {
      self._areaRes,
      1
    }
  }
  return t
end

function SkillPhaseParam_ShowWarningArea:GetTextEffectID()
  return self._warningTextEffectID
end

function SkillPhaseParam_ShowWarningArea:GetAreaRes()
  return self._areaRes
end

function SkillPhaseParam_ShowWarningArea:GetWarningCenterPosType()
  return self._warningCenterPosType
end

function SkillPhaseParam_ShowWarningArea:GetPhaseType()
  return SkillViewPhaseType.ShowWarningArea
end

function SkillPhaseParam_ShowWarningArea:GetGridPosList()
  local gridPosList = {}
  for k, v in ipairs(self._warningCenterPosParam) do
    local gridPos = Vector2(v.x, v.y)
    table.insert(gridPosList, gridPos)
  end
  return gridPosList
end

function SkillPhaseParam_ShowWarningArea:GetOffSet()
  return tonumber(self._warningCenterPosParam)
end

function SkillPhaseParam_ShowWarningArea:HasDeadWaring()
  return self._hasDeadWarning
end
