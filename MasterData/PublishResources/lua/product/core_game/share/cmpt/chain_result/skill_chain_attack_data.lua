require("skill_effect_result_container")
_class("SkillChainAttackData", SkillEffectResultContainer)
SkillChainAttackData = SkillChainAttackData

function SkillChainAttackData:Constructor(timeIndex, stageindex, chainSkillID)
  self._chainTimeIndex = timeIndex
  self._chainStageIndex = stageindex
  self._chainSkillID = chainSkillID
end

function SkillChainAttackData:GetChainSkillTimeIndex()
  return self._chainTimeIndex
end

function SkillChainAttackData:GetChainSkillStageIndex()
  return self._chainStageIndex
end

function SkillChainAttackData:GetChainAttackDataSkillID()
  return self._chainSkillID
end

function SkillChainAttackData:GetTotalDamage()
  local val = 0
  local ress = self:GetEffectResultsAsArray(SkillEffectType.Damage)
  if ress then
    for _, res in ipairs(ress) do
      if 0 < res:GetTotalDamage() then
        val = val + res:GetTotalDamage()
      end
    end
  end
  return val
end
