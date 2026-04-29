require("skill_phase_param_base")
_class("SkillPhaseAddGridEffectParam", SkillPhaseParamBase)
SkillPhaseAddGridEffectParam = SkillPhaseAddGridEffectParam

function SkillPhaseAddGridEffectParam:Constructor(t)
  local param1Array = string.split(t.paramArray, ",")
  local castEffectIDArray = {}
  for k, idStr in ipairs(param1Array) do
    local effectID = tonumber(idStr)
    castEffectIDArray[#castEffectIDArray + 1] = effectID
  end
  self._castEffectIDArray = castEffectIDArray
  self._lastTime = t.lastTime
  self._gridEffectDelayTime = t.gridEffectDelayTime
end

function SkillPhaseAddGridEffectParam:GetCacheTable()
  local t = {}
  for i, id in ipairs(self._castEffectIDArray) do
    table.insert(t, {
      Cfg.cfg_effect[id].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseAddGridEffectParam:GetPhaseType()
  return SkillViewPhaseType.AddGridEffect
end

function SkillPhaseAddGridEffectParam:GetEffectIDArray()
  return self._castEffectIDArray
end

function SkillPhaseAddGridEffectParam:GetLastTime()
  return self._lastTime
end

function SkillPhaseAddGridEffectParam:GetGridEffectDelayTime()
  return self._gridEffectDelayTime
end
