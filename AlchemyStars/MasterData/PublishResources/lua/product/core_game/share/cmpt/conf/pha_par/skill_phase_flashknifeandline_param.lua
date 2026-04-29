require("skill_phase_param_base")
_class("SkillPhaseFlashKnifeAndLineParam", SkillPhaseParamBase)
SkillPhaseFlashKnifeAndLineParam = SkillPhaseFlashKnifeAndLineParam

function SkillPhaseFlashKnifeAndLineParam:Constructor(t)
  self._castEffectFlashKnife = t.effectFlashKnife
  self._castEffectFlashLine = t.effectFlashLine
  self._castAnimationName = t.castAnimationName
  self._finishDelayTime = t.finishDelayTime
  self._knifeFlyOneGridMs = t.knifeFlyOneGridMs
  self._hitAnimationName = t.hitAnimationName
  self._effectHit = t.effectHit
  self._lineFlyOneGridMs = t.lineFlyOneGridMs
  self._flashLineWidth = t.flashLineWidth
  self._flashLineHeight = t.flashLineHeight
  self._flashOneGridLinePoint = t.flashOneGridLinePoint
end

function SkillPhaseFlashKnifeAndLineParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._castEffectFlashKnife].ResPath,
      1
    },
    {
      Cfg.cfg_effect[self._castEffectFlashLine].ResPath,
      1
    }
  }
  return t
end

function SkillPhaseFlashKnifeAndLineParam:GetPhaseType()
  return SkillViewPhaseType.FlashKnifeAndLine
end

function SkillPhaseFlashKnifeAndLineParam:GetBodyEffect()
  return self._castEffectBody
end

function SkillPhaseFlashKnifeAndLineParam:GetFingerEffect()
  return self._castEffectFinger
end

function SkillPhaseFlashKnifeAndLineParam:GetFlashKnifeEffect()
  return self._castEffectFlashKnife
end

function SkillPhaseFlashKnifeAndLineParam:GetFlashLineEffect()
  return self._castEffectFlashLine
end

function SkillPhaseFlashKnifeAndLineParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseFlashKnifeAndLineParam:GetAnimationName()
  return self._castAnimationName
end

function SkillPhaseFlashKnifeAndLineParam:GetFlyOneGridMs()
  return self._knifeFlyOneGridMs
end

function SkillPhaseFlashKnifeAndLineParam:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseFlashKnifeAndLineParam:GetHitEffect()
  return self._effectHit
end

function SkillPhaseFlashKnifeAndLineParam:GetLineFlyOneGridMs()
  return self._lineFlyOneGridMs
end

function SkillPhaseFlashKnifeAndLineParam:GetFlashLineWidth()
  return self._flashLineWidth
end

function SkillPhaseFlashKnifeAndLineParam:GetFlashLineHeight()
  return self._flashLineHeight
end

function SkillPhaseFlashKnifeAndLineParam:GetFlashOneGridLinePoint()
  return self._flashOneGridLinePoint
end
