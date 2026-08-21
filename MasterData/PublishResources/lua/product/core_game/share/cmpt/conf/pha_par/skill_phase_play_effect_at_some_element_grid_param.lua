require("skill_phase_param_base")
_class("SkillPhasePlayEffectAtSomeElementGridParam", SkillPhaseParamBase)
SkillPhasePlayEffectAtSomeElementGridParam = SkillPhasePlayEffectAtSomeElementGridParam

function SkillPhasePlayEffectAtSomeElementGridParam:Constructor(t)
  self._targetElementArray = t.targetElements
  self._effectIDArray = t.effectID
end

function SkillPhasePlayEffectAtSomeElementGridParam:GetPhaseType()
  return SkillViewPhaseType.PlayEffectAtSomeElementGrid
end

function SkillPhasePlayEffectAtSomeElementGridParam:GetEffectIDArray()
  return self._effectIDArray
end

function SkillPhasePlayEffectAtSomeElementGridParam:GetTargetElementArray()
  return self._targetElementArray
end

function SkillPhasePlayEffectAtSomeElementGridParam:GetCacheTable()
  local t = {}
  if self._effectIDArray then
    for _, effectID in ipairs(self._effectIDArray) do
      t[#t + 1] = {
        Cfg.cfg_effect[effectID].ResPath,
        1
      }
    end
  end
  return t
end
