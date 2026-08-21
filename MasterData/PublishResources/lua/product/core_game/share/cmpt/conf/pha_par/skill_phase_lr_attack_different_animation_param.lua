require("skill_phase_param_base")
_class("SkillPhaseLRAttackDifferentAnimationParam", SkillPhaseParamBase)
SkillPhaseLRAttackDifferentAnimationParam = SkillPhaseLRAttackDifferentAnimationParam

function SkillPhaseLRAttackDifferentAnimationParam:Constructor(t)
  self._castEffectID = t.castEffectID
  local castAnimationStrs = string.split(t.castAnimationStr, ",")
  self._castLAnimation = castAnimationStrs[1]
  self._castRAnimation = castAnimationStrs[2]
  self._blurDelay = t.blurDelay
  local blurStrs = string.split(t.blurEffectId, ",")
  self._lBlurEffectID = tonumber(blurStrs[1])
  self._rBlurEffectID = tonumber(blurStrs[2])
  self._hitPointDelay = t.hitPointDelay
  self._hitAnimation = t.onHitAnimation
  self._hitEffectID = t.hitEffectID
  self._overDelay = t.overDelay
  if t.audioID ~= nil then
    self._lAudioID = tonumber(t.audioID[1])
    self._rAudioID = tonumber(t.audioID[2])
    if t.audioDelay ~= nil then
      self._lAudioDelay = tonumber(t.audioDelay[1])
      self._rAudioDelay = tonumber(t.audioDelay[2])
    end
  end
end

function SkillPhaseLRAttackDifferentAnimationParam:GetCacheTable()
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
  if self._hitEffectID and self._hitEffectID[1] and self._hitEffectID[1] ~= 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID[1]].ResPath,
      1
    }
  end
  if self._hitEffectID and self._hitEffectID[2] and self._hitEffectID[2] ~= 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID[2]].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseLRAttackDifferentAnimationParam:GetSoundCacheTable()
  local t = {}
  if self._lAudioID and self._lAudioID ~= 0 then
    t[#t + 1] = self._lAudioID
  end
  if self._rAudioID and self._rAudioID ~= 0 then
    t[#t + 1] = self._rAudioID
  end
  return t
end

function SkillPhaseLRAttackDifferentAnimationParam:GetPhaseType()
  return SkillViewPhaseType.LRAttackDifferentAnimation
end

function SkillPhaseLRAttackDifferentAnimationParam:GetCastEffectID()
  return self._castEffectID
end

function SkillPhaseLRAttackDifferentAnimationParam:GetLAnimationName()
  return self._castLAnimation
end

function SkillPhaseLRAttackDifferentAnimationParam:GetRAnimationName()
  return self._castRAnimation
end

function SkillPhaseLRAttackDifferentAnimationParam:GetBlurDelay()
  return self._blurDelay
end

function SkillPhaseLRAttackDifferentAnimationParam:GetLBlurEffectID()
  return self._lBlurEffectID
end

function SkillPhaseLRAttackDifferentAnimationParam:GetRBlurEffectID()
  return self._rBlurEffectID
end

function SkillPhaseLRAttackDifferentAnimationParam:GetHitPointDelay()
  return self._hitPointDelay
end

function SkillPhaseLRAttackDifferentAnimationParam:GetHitAnimation()
  return self._hitAnimation
end

function SkillPhaseLRAttackDifferentAnimationParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseLRAttackDifferentAnimationParam:GetOverDelay()
  return self._overDelay
end

function SkillPhaseLRAttackDifferentAnimationParam:GetLeftAudioID()
  return self._lAudioID
end

function SkillPhaseLRAttackDifferentAnimationParam:GetLeftAudioDelay()
  return self._rAudioDelay
end

function SkillPhaseLRAttackDifferentAnimationParam:GetRightAudioID()
  return self._rAudioID
end

function SkillPhaseLRAttackDifferentAnimationParam:GetRightAudioDelay()
  return self._rAudioDelay
end
