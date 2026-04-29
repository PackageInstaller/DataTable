require("skill_effect_result_base")
_class("SkillEffectResultSummonMeantimeLimit", SkillEffectResultBase)
SkillEffectResultSummonMeantimeLimit = SkillEffectResultSummonMeantimeLimit

function SkillEffectResultSummonMeantimeLimit:Constructor(trapID, summonPosList)
  self._trapID = trapID
  self._summonPosList = summonPosList
  self._destroyEntityID = {}
  self._replaceAttr = {}
end

function SkillEffectResultSummonMeantimeLimit:GetEffectType()
  return SkillEffectType.SummonMeantimeLimit
end

function SkillEffectResultSummonMeantimeLimit:GetTrapID()
  return self._trapID
end

function SkillEffectResultSummonMeantimeLimit:GetSummonPosList()
  return self._summonPosList
end

function SkillEffectResultSummonMeantimeLimit:SetReplaceAttr(replaceAttr)
  self._replaceAttr = replaceAttr
end

function SkillEffectResultSummonMeantimeLimit:GetReplaceAttr()
  return self._replaceAttr
end

function SkillEffectResultSummonMeantimeLimit:GetDestroyEntityID()
  return self._destroyEntityID
end

function SkillEffectResultSummonMeantimeLimit:SetDestroyEntityID(destroyEntityID)
  self._destroyEntityID = destroyEntityID
end

function SkillEffectResultSummonMeantimeLimit:SetTrapIDList(trapIDList)
  self._trapIDList = trapIDList
end

function SkillEffectResultSummonMeantimeLimit:GetTrapIDList()
  return self._trapIDList
end

function SkillEffectResultSummonMeantimeLimit:SetTrapDieSkillResult(trapDieSkillResult)
  self._trapDieSkillResult = trapDieSkillResult
end

function SkillEffectResultSummonMeantimeLimit:GetTrapDieSkillResult()
  return self._trapDieSkillResult
end
