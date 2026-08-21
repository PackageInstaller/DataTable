require("skill_phase_param_base")
_class("SkillPhaseFireAnimationParam", SkillPhaseParamBase)
SkillPhaseFireAnimationParam = SkillPhaseFireAnimationParam

function SkillPhaseFireAnimationParam:Constructor(t)
  self._effFireId = tonumber(t.effFireId)
  self._bombDelayMS = tonumber(t.bombDelayMS)
  self._effBombId = tonumber(t.effBombId)
  local effectDatas = string.split(t.castEffectData, ",")
  self._effectId = tonumber(effectDatas[1])
  self._effectCount = tonumber(effectDatas[2])
  self._flyTime = tonumber(t.flyTime)
  self._castAnimation = t.castAnimation
end

function SkillPhaseFireAnimationParam:GetCacheTable()
  local t = {
    {
      Cfg.cfg_effect[self._effFireId].ResPath,
      1
    },
    {
      Cfg.cfg_effect[self._effBombId].ResPath,
      1
    },
    {
      Cfg.cfg_effect[self._effectId].ResPath,
      self._effectCount
    }
  }
  return t
end

function SkillPhaseFireAnimationParam:GetPhaseType()
  return SkillViewPhaseType.FireAnimation
end

function SkillPhaseFireAnimationParam:GetEffectFireID()
  return self._effFireId
end

function SkillPhaseFireAnimationParam:GetBombDelayMS()
  return self._bombDelayMS
end

function SkillPhaseFireAnimationParam:GetEffectBombID()
  return self._effBombId
end

function SkillPhaseFireAnimationParam:GetCastEffectID()
  return self._effectId
end

function SkillPhaseFireAnimationParam:GetCastEffectCount()
  return self._effectCount
end

function SkillPhaseFireAnimationParam:GetAnimationName()
  return self._castAnimation
end

function SkillPhaseFireAnimationParam:GetFlyTime()
  return self._flyTime
end

function SkillPhaseFireAnimationParam:GetStartDelayType()
  return 0
end

function SkillPhaseFireAnimationParam:GetStartDelayTime()
  return 0
end
