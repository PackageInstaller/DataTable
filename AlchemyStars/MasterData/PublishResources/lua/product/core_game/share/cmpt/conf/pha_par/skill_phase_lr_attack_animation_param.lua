require("skill_phase_param_base")
_class("SkillPhaseLRAttackAnimationParam", SkillPhaseParamBase)
SkillPhaseLRAttackAnimationParam = SkillPhaseLRAttackAnimationParam

function SkillPhaseLRAttackAnimationParam:Constructor(t)
  self._castEffectID = t.castEffectID
  local castAnimationStrs = string.split(t.castAnimationStr, ",")
  self._castLAnimation = castAnimationStrs[1]
  self._castRAnimation = castAnimationStrs[2]
  self._blurDelay = tonumber(t.blurDelay)
  local blurStrs = string.split(t.blurEffectId, ",")
  self._lBlurEffectID = tonumber(blurStrs[1])
  self._rBlurEffectID = tonumber(blurStrs[2])
  self._hitPointDelay = t.hitPointDelay
  self._hitAnimation = t.onHitAnimation
  self._hitEffectID = t.hitEffectID
  self._overDelay = t.overDelay
end

function SkillPhaseLRAttackAnimationParam:GetCacheTable()
  local t = {}
  if self._castEffectID and self._castEffectID ~= 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._castEffectID].ResPath,
      1
    }
  end
  if self._lBlurEffectID and self._lBlurEffectID ~= 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._lBlurEffectID].ResPath,
      1
    }
  end
  if self._rBlurEffectID and self._rBlurEffectID ~= 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._rBlurEffectID].ResPath,
      1
    }
  end
  if self._hitEffectID and self._hitEffectID ~= 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseLRAttackAnimationParam:GetPhaseType()
  return SkillViewPhaseType.LRAttackAnimation
end

function SkillPhaseLRAttackAnimationParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseLRAttackAnimationParam:GetLAnimationName()
  return self._castLAnimation
end

function SkillPhaseLRAttackAnimationParam:GetRAnimationName()
  return self._castRAnimation
end

function SkillPhaseLRAttackAnimationParam:GetBlurDelay()
  return self._blurDelay
end

function SkillPhaseLRAttackAnimationParam:GetLBlurEffectID()
  return self._lBlurEffectID
end

function SkillPhaseLRAttackAnimationParam:GetRBlurEffectID()
  return self._rBlurEffectID
end

function SkillPhaseLRAttackAnimationParam:GetHitPointDelay()
  return self._hitPointDelay
end

function SkillPhaseLRAttackAnimationParam:GetHitAnimation()
  return self._hitAnimation
end

function SkillPhaseLRAttackAnimationParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseLRAttackAnimationParam:GetOverDelay()
  return self._overDelay
end
