require("skill_phase_param_base")
_class("SkillPhaseCastAnimationParam", SkillPhaseParamBase)
SkillPhaseCastAnimationParam = SkillPhaseCastAnimationParam

function SkillPhaseCastAnimationParam:Constructor(t)
  self._castAnimationName = t.castAnimationName
  self._finishDelayTime = t.finishDelayTime
  self._buffDelayTime = t.buffDelayTime
  self._hideRoleTime = t.hideRoleTime
  self._buffNeedImmediatelyEffect = t.buffNeedImmediatelyEffect
  self._skipBuff = t.skipBuff or 0
  local castEffectIDArray = {}
  local effectparam = t.effectparam
  if effectparam then
    local effectarray = string.split(effectparam, ",")
    for k, idStr in ipairs(effectarray) do
      local params = string.split(idStr, ";")
      local effectid = 0
      local delay = 0
      if table.count(params) >= 1 then
        effectid = tonumber(params[1])
      end
      if table.count(params) >= 2 then
        delay = tonumber(params[2])
      end
      castEffectIDArray[#castEffectIDArray + 1] = SkillCommonParam:New(effectid, delay)
    end
  end
  self._castEffectIDArray = castEffectIDArray
  local castGridEffectIDArray = {}
  effectparam = t.grideffectparam
  if effectparam then
    local effectarray = string.split(effectparam, ",")
    for k, idStr in ipairs(effectarray) do
      local params = string.split(idStr, ";")
      local effectid = 0
      local delay = 0
      if table.count(params) >= 1 then
        effectid = tonumber(params[1])
      end
      if table.count(params) >= 2 then
        delay = tonumber(params[2])
      end
      castGridEffectIDArray[#castGridEffectIDArray + 1] = SkillCommonParam:New(effectid, delay)
    end
  end
  self._castGridEffectIDArray = castGridEffectIDArray
  self._rotateToCenter = t.rotateToCenter == 1
end

function SkillPhaseCastAnimationParam:GetCacheTable()
  local t = {}
  for i, eff in ipairs(self._castEffectIDArray) do
    local effid = eff:GetSkillEffectID()
    local cfg = Cfg.cfg_effect[effid]
    if cfg then
      table.insert(t, {
        cfg.ResPath,
        1
      })
    end
  end
  for i, eff in ipairs(self._castGridEffectIDArray) do
    local effid = eff:GetSkillEffectID()
    local cfg = Cfg.cfg_effect[effid]
    if cfg then
      table.insert(t, {
        cfg.ResPath,
        1
      })
    end
  end
  return t
end

function SkillPhaseCastAnimationParam:GetPhaseType()
  return SkillViewPhaseType.CastAnimation
end

function SkillPhaseCastAnimationParam:GetSkillCastEffectIDArray()
  return self._castEffectIDArray
end

function SkillPhaseCastAnimationParam:GetSkillCastGridEffectIDArray()
  return self._castGridEffectIDArray
end

function SkillPhaseCastAnimationParam:GetSkillCastEffectAnimationName()
  return self._castAnimationName
end

function SkillPhaseCastAnimationParam:GetFinishDelayTime()
  return self._finishDelayTime
end

function SkillPhaseCastAnimationParam:GetBuffDelayTime()
  return self._buffDelayTime
end

function SkillPhaseCastAnimationParam:GetHideRoleTime()
  return self._hideRoleTime
end

function SkillPhaseCastAnimationParam:GetBuffNeedImmediatelyEffect()
  if self._buffNeedImmediatelyEffect then
    return self._buffNeedImmediatelyEffect
  else
    return 1
  end
end

function SkillPhaseCastAnimationParam:GetSkipBuff()
  return self._skipBuff or 0
end

function SkillPhaseCastAnimationParam:GetRotateToCenter()
  return self._rotateToCenter
end
