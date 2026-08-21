require("skill_phase_param_base")
_class("SkillPhaseMultiRandomTrajectoryParam", SkillPhaseParamBase)
SkillPhaseMultiRandomTrajectoryParam = SkillPhaseMultiRandomTrajectoryParam

function SkillPhaseMultiRandomTrajectoryParam:Constructor(t)
  self._startPosEffectID = t.startPosEffectID
  self._bulletEffectID = t.bulletEffectID
  self._spawnIntervalTime = t.spawnIntervalTime
  self._flyDelayTime = t.flyDelayTime
  self._flyTime = t.flyTime
  local bulletOffSetData = t.bulletOffSet
  if bulletOffSetData then
    self._bulletOffSetV3 = Vector3(bulletOffSetData[1], bulletOffSetData[2], bulletOffSetData[3])
  end
  local startPosListData = t.startPosList
  if startPosListData then
    self._startPosList = {}
    for index, v in ipairs(startPosListData) do
      local v2Pos = Vector2(v[1], v[2])
      table.insert(self._startPosList, v2Pos)
    end
  end
  self._targetHit = t.targetHit
  self._hitAnimName = t.hitAnimName
  self._hitEffectID = t.hitEffectID
  self._hitSoundID = t.hitSoundID or 0
end

function SkillPhaseMultiRandomTrajectoryParam:GetCacheTable()
  local t = {}
  if self._startPosEffectID and self._startPosEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._startPosEffectID].ResPath,
      4
    })
  end
  if self._bulletEffectID and 0 < self._bulletEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._bulletEffectID].ResPath,
      4
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      4
    })
  end
  return t
end

function SkillPhaseMultiRandomTrajectoryParam:GetPhaseType()
  return SkillViewPhaseType.MultiRandomTrajectory
end

function SkillPhaseMultiRandomTrajectoryParam:GetStartPosEffectID()
  return self._startPosEffectID
end

function SkillPhaseMultiRandomTrajectoryParam:GetBulletEffectID()
  return self._bulletEffectID
end

function SkillPhaseMultiRandomTrajectoryParam:GetSpawnIntervalTime()
  return self._spawnIntervalTime
end

function SkillPhaseMultiRandomTrajectoryParam:GetFlyDelayTime()
  return self._flyDelayTime
end

function SkillPhaseMultiRandomTrajectoryParam:GetBulletOffSetV3()
  return self._bulletOffSetV3
end

function SkillPhaseMultiRandomTrajectoryParam:GetStartPosList()
  return self._startPosList
end

function SkillPhaseMultiRandomTrajectoryParam:GetFlyTime()
  return self._flyTime
end

function SkillPhaseMultiRandomTrajectoryParam:GetTargetHit()
  return self._targetHit
end

function SkillPhaseMultiRandomTrajectoryParam:GetHitAnimName()
  return self._hitAnimName
end

function SkillPhaseMultiRandomTrajectoryParam:GetHitEffectID()
  return self._hitEffectID
end

function SkillPhaseMultiRandomTrajectoryParam:GetHitSoundID()
  return self._hitSoundID
end
