require("skill_phase_param_base")
_class("SkillPhaseSummonChessSoldierParam", SkillPhaseParamBase)
SkillPhaseSummonChessSoldierParam = SkillPhaseSummonChessSoldierParam

function SkillPhaseSummonChessSoldierParam:Constructor(t)
  self._birthEffectID = t.birthEffectID
  self._turnWaitTime = t.turnWaitTime
end

function SkillPhaseSummonChessSoldierParam:GetCacheTable()
  local t = {}
  if self._birthEffectID and self._birthEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._birthEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseSummonChessSoldierParam:GetPhaseType()
  return SkillViewPhaseType.SummonChessSoldier
end

function SkillPhaseSummonChessSoldierParam:GetBirthEffectID()
  return self._birthEffectID
end

function SkillPhaseSummonChessSoldierParam:GetTurnWaitTime()
  return self._turnWaitTime
end
