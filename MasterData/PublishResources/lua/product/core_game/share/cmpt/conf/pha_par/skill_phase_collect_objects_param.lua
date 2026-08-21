require("skill_phase_param_base")
_class("SkillPhaseCollectObjectsParam", SkillPhaseParamBase)
SkillPhaseCollectObjectsParam = SkillPhaseCollectObjectsParam

function SkillPhaseCollectObjectsParam:Constructor(t)
  self._duaration = t.duaration
end

function SkillPhaseCollectObjectsParam:GetPhaseType()
  return SkillViewPhaseType.CollectObjects
end

function SkillPhaseCollectObjectsParam:GetCacheTable()
end

function SkillPhaseCollectObjectsParam:GetDuaration()
  return self._duaration
end
