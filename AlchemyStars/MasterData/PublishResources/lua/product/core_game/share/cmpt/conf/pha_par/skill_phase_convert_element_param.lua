require("skill_phase_param_base")
_class("SkillPhaseConvertElementParam", SkillPhaseParamBase)
SkillPhaseConvertElementParam = SkillPhaseConvertElementParam

function SkillPhaseConvertElementParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._bestEffectTime = t.bestEffectTime
  self._finishDelayTime = t.finishDelayTime
  self._notifyPreview = t.notifyPreview
end

function SkillPhaseConvertElementParam:GetCacheTable()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseConvertElementParam:GetPhaseType()
  return SkillViewPhaseType.ConvertElment
end

function SkillPhaseConvertElementParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseConvertElementParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseConvertElementParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseConvertElementParam:GetNotifyPreview()
  return self._notifyPreview
end
