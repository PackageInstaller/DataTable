require("skill_phase_param_base")
local SkillPhaseParam_ShowType = {
  Hide = 0,
  Show = 1,
  Replace = 2,
  Fade = 3
}
_enum("SkillPhaseParam_ShowType", SkillPhaseParam_ShowType)
_class("SkillPhaseParam_ShowHideRole", SkillPhaseParamBase)
SkillPhaseParam_ShowHideRole = SkillPhaseParam_ShowHideRole

function SkillPhaseParam_ShowHideRole:Constructor(t)
  self._beginDelay = t.beginDelay
  self._showType = t.showType
  self._showParam = t.showParam
  self._endDelay = t.endDelay
end

function SkillPhaseParam_ShowHideRole:GetCacheTable()
  local t = {}
  if SkillPhaseParam_ShowType.Replace == self._showType and self._showParam then
    local resPrefab = self._showParam
    t[#t + 1] = {resPrefab, 1}
  end
  return t
end

function SkillPhaseParam_ShowHideRole:GetPhaseType()
  return SkillViewPhaseType.ShowHideRole
end

function SkillPhaseParam_ShowHideRole:GetBeginDelay()
  return self._beginDelay
end

function SkillPhaseParam_ShowHideRole:GetEndDelay()
  return self._endDelay
end

function SkillPhaseParam_ShowHideRole:GetShowData()
  return self._showType, self._showParam
end
