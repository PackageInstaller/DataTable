require("skill_phase_param_base")
local SkillPhaseParam_GridDark_Type = {Dark = 0, Resume = 1}
_enum("SkillPhaseParam_GridDark_Type", SkillPhaseParam_GridDark_Type)
_class("SkillPhaseParam_GridDark", SkillPhaseParamBase)
SkillPhaseParam_GridDark = SkillPhaseParam_GridDark

function SkillPhaseParam_GridDark:Constructor(t)
  self._darkType = t.darkType
end

function SkillPhaseParam_GridDark:GetCacheTable()
  local t = {}
  return t
end

function SkillPhaseParam_GridDark:GetPhaseType()
  return SkillViewPhaseType.GridDark
end

function SkillPhaseParam_GridDark:GetDarkType()
  return self._darkType
end
