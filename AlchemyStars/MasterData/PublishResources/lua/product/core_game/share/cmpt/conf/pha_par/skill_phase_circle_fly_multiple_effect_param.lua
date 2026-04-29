require("skill_phase_param_base")
_class("SkillPhaseCircleFlyMultipleEffectParam", SkillPhaseParamBase)
SkillPhaseCircleFlyMultipleEffectParam = SkillPhaseCircleFlyMultipleEffectParam

function SkillPhaseCircleFlyMultipleEffectParam:Constructor(t)
  self._radius = t.radius
  self._high = t.high
  self._angle = t.angle
  self._gridEffectID = t.gridEffectID
  self._flyEffectID = t.flyEffectID
  self._hitEffectID = t.hitEffectID
  self._waitFlyTime = t.waitFlyTime
  self._flyTime = t.flyTime
end

function SkillPhaseCircleFlyMultipleEffectParam:GetCacheTable()
  local t = {}
  if self._gridEffectID and self._gridEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._gridEffectID].ResPath,
      3
    })
  end
  if self._flyEffectID and 0 < self._flyEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      3
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      3
    })
  end
  return t
end

function SkillPhaseCircleFlyMultipleEffectParam:GetPhaseType()
  return SkillViewPhaseType.CircleFlyMultipleEffect
end

function SkillPhaseCircleFlyMultipleEffectParam:GetRadius()
  return self._radius
end

function SkillPhaseCircleFlyMultipleEffectParam:GetHigh()
  return self._high
end

function SkillPhaseCircleFlyMultipleEffectParam:GetAngle()
  return self._angle
end

function SkillPhaseCircleFlyMultipleEffectParam:GetGridEffectID()
  return self._gridEffectID
end

function SkillPhaseCircleFlyMultipleEffectParam:GetFlyEffectID()
  return self._flyEffectID
end

function SkillPhaseCircleFlyMultipleEffectParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseCircleFlyMultipleEffectParam:GetWaitFlyTime()
  return self._waitFlyTime
end

function SkillPhaseCircleFlyMultipleEffectParam:GetFlyTime()
  return self._flyTime
end
