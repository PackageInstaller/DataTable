require("skill_phase_param_base")
_class("SkillPhaseGridSpreadParam", SkillPhaseParamBase)
SkillPhaseGridSpreadParam = SkillPhaseGridSpreadParam

function SkillPhaseGridSpreadParam:Constructor(t)
  self._gridEffectID = t.gridEffectID
  self._hitEffectID = t.hitEffectID
  self._hitAnimationName = t.hitAnimationName
  self._spreadIntervalTime = t.spreadIntervalTime
  self._spreadLayerCount = t.spreadLayerCount or 1
  self._spreadShape = t.spreadShape
end

function SkillPhaseGridSpreadParam:GetCacheTable()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    t[#t + 1] = {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      1
    }
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    t[#t + 1] = {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    }
  end
  return t
end

function SkillPhaseGridSpreadParam:GetPhaseType()
  return SkillViewPhaseType.GridSpread
end

function SkillPhaseGridSpreadParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseGridSpreadParam:GetHitAnimationName()
  return self._hitAnimationName
end

function SkillPhaseGridSpreadParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseGridSpreadParam:GetSpreadIntervalTime()
  return self._spreadIntervalTime
end

function SkillPhaseGridSpreadParam:GetSpreadLayerCount()
  return self._spreadLayerCount
end

function SkillPhaseGridSpreadParam:GetSpreadShape()
  return self._spreadShape
end
