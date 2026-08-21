require("skill_phase_param_base")
_class("SkillPhaseParam_MiejinRoll", SkillPhaseParamBase)
SkillPhaseParam_MiejinRoll = SkillPhaseParam_MiejinRoll

function SkillPhaseParam_MiejinRoll:Constructor(t)
  self._prerollDelayMS = tonumber(t.prerollDelay)
  self._rolloutTimeMS = tonumber(t.rolloutTime)
  self._standEdgeTimeMS = tonumber(t.standEdgeTime)
  self._rollbackTimeMS = tonumber(t.rollbackTime)
  self._postrollDelayMS = tonumber(t.postrollDelay)
  self._rollEffectID = tonumber(t.rollEffectID)
  self._hitAnimName = t.hitAnimName
  self._summonTrapIDs = t.summonTrapIDs
end

function SkillPhaseParam_MiejinRoll:GetPhaseType()
  return SkillViewPhaseType.MiejinRoll
end

function SkillPhaseParam_MiejinRoll:GetCacheTable()
  local t = {}
  if type(self._rollEffectID) and Cfg.cfg_effect[self._rollEffectID] then
    table.insert(t, {
      Cfg.cfg_effect[self._rollEffectID].ResPath,
      1
    })
  end
  return t
end

function SkillPhaseParam_MiejinRoll:GetPrerollDelayMS()
  return self._prerollDelayMS
end

function SkillPhaseParam_MiejinRoll:GetRolloutTimeMS()
  return self._rolloutTimeMS
end

function SkillPhaseParam_MiejinRoll:GetStandEdgeTimeMS()
  return self._standEdgeTimeMS
end

function SkillPhaseParam_MiejinRoll:GetRollbackTimeMS()
  return self._rollbackTimeMS
end

function SkillPhaseParam_MiejinRoll:GetPostrollDelayMS()
  return self._postrollDelayMS
end

function SkillPhaseParam_MiejinRoll:GetRollEffectID()
  return self._rollEffectID
end

function SkillPhaseParam_MiejinRoll:GetSummonTrapIDs()
  return self._summonTrapIDs
end

function SkillPhaseParam_MiejinRoll:GetHitAnimName()
  return self._hitAnimName
end
