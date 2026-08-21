require("skill_phase_param_base")
_class("SkillPhaseGridArrayParam", SkillPhaseParamBase)
SkillPhaseGridArrayParam = SkillPhaseGridArrayParam

function SkillPhaseGridArrayParam:Constructor(phaseParam)
  self._gridEffectID = phaseParam.gridEffectID
  self._bestEffectTime = phaseParam.bestEffectTime
  self._finishTime = phaseParam.finishTime
  self._castEffectID = phaseParam.castEffectID
  self._atkEffectID = phaseParam.atkEffectID
  self._hitDelay = phaseParam.hitDelay
  self._hitAnimation = phaseParam.hitAnimation
  self._castAnimation = phaseParam.castAnimation
end

function SkillPhaseGridArrayParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      1
    },
    {
      Cfg.cfg_effect[self._atkEffectID].ResPath,
      1
    }
  }
  if self._gridEffectID and self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    })
  end
end

function SkillPhaseGridArrayParam:GetPhaseType()
  return SkillViewPhaseType.GridArray
end

function SkillPhaseGridArrayParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseGridArrayParam:GetFinishTime()
  return self._finishTime
end

function SkillPhaseGridArrayParam:GetBestEffectTime()
  return self._bestEffectTime
end

function SkillPhaseGridArrayParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseGridArrayParam:GetAtkEffectID()
  return self._atkEffectID
end

function SkillPhaseGridArrayParam:GetHitDelayTime()
  return self._hitDelay
end

function SkillPhaseGridArrayParam:GetHitAnimation()
  return self._hitAnimation
end
