require("skill_phase_param_base")
_class("SkillPhaseRoundGridParam", SkillPhaseParamBase)
SkillPhaseRoundGridParam = SkillPhaseRoundGridParam

function SkillPhaseRoundGridParam:Constructor(t)
  local gridEffectIdArr = string.split(t.gridEffectIdArr, ",")
  local gridEffectIds = {}
  for i, id in ipairs(gridEffectIdArr) do
    table.insert(gridEffectIds, tonumber(id))
  end
  self._gridEffectIds = gridEffectIds
  self._atk = t.atk
  self._atkEffectId = t.atkEffectId
  self._gridEffectDelayTime = t.gridEffectDelayTime
  self._hit = t.hit
  self._hitEffectId = t.hitEffectId
  self._finishDelayTime = t.finishDelayTime
end

function SkillPhaseRoundGridParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._atkEffectId].ResPath,
      1
    }
  }
  for i, id in ipairs(self._gridEffectIds) do
    table.insert(t, {
      Cfg.cfg_effect[id].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseRoundGridParam:GetPhaseType()
  return SkillViewPhaseType.RoundGridDifferent
end

function SkillPhaseRoundGridParam:GetAnimationName()
  return self._atk
end

function SkillPhaseRoundGridParam:GetHitAnimationName()
  return self._hit
end

function SkillPhaseRoundGridParam:GetHitEffectID()
  return self._hitEffectId
end

function SkillPhaseRoundGridParam:GetCastEffectID()
  return self._atkEffectId
end

function SkillPhaseRoundGridParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseRoundGridParam:GetGridEffectDelayTime()
  return self._gridEffectDelayTime
end

function SkillPhaseRoundGridParam:GetGridEffectID(centerPos, gridPos)
  if centerPos.x == gridPos.x and centerPos.y + 2 == gridPos.y then
    return self._gridEffectIds[1]
  end
  if centerPos.x + 1 == gridPos.x and centerPos.y + 2 == gridPos.y then
    return self._gridEffectIds[1]
  end
  if centerPos.x - 1 == gridPos.x and centerPos.y + 2 == gridPos.y then
    return self._gridEffectIds[1]
  end
  if centerPos.x == gridPos.x and centerPos.y - 2 == gridPos.y then
    return self._gridEffectIds[5]
  end
  if centerPos.x + 1 == gridPos.x and centerPos.y - 2 == gridPos.y then
    return self._gridEffectIds[5]
  end
  if centerPos.x - 1 == gridPos.x and centerPos.y - 2 == gridPos.y then
    return self._gridEffectIds[5]
  end
  if centerPos.x + 2 == gridPos.x and centerPos.y + 1 == gridPos.y then
    return self._gridEffectIds[3]
  end
  if centerPos.x + 2 == gridPos.x and centerPos.y == gridPos.y then
    return self._gridEffectIds[3]
  end
  if centerPos.x + 2 == gridPos.x and centerPos.y - 1 == gridPos.y then
    return self._gridEffectIds[3]
  end
  if centerPos.x - 2 == gridPos.x and centerPos.y + 1 == gridPos.y then
    return self._gridEffectIds[7]
  end
  if centerPos.x - 2 == gridPos.x and centerPos.y == gridPos.y then
    return self._gridEffectIds[7]
  end
  if centerPos.x - 2 == gridPos.x and centerPos.y - 1 == gridPos.y then
    return self._gridEffectIds[7]
  end
  if centerPos.x + 2 == gridPos.x and centerPos.y + 2 == gridPos.y then
    return self._gridEffectIds[2]
  end
  if centerPos.x + 2 == gridPos.x and centerPos.y - 2 == gridPos.y then
    return self._gridEffectIds[4]
  end
  if centerPos.x - 2 == gridPos.x and centerPos.y - 2 == gridPos.y then
    return self._gridEffectIds[6]
  end
  if centerPos.x - 2 == gridPos.x and centerPos.y + 2 == gridPos.y then
    return self._gridEffectIds[8]
  end
end
