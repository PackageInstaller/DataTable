_class("EnlightenInfo", Object)
EnlightenInfo = EnlightenInfo

function EnlightenInfo:Constructor(attack, defence, hp, exElementParam, activeSkillIncreaseParam, supplyPieceWeights)
  self._attackFix = attack or 0
  self._defenceFix = defence or 0
  self._maxHPFix = hp or 0
  self._exElementParam = exElementParam / 100 or 0
  self._activeSkillIncreaseParam = activeSkillIncreaseParam / 100 or 0
  self._supplyPieceWeights = supplyPieceWeights or {}
end

function EnlightenInfo:GetAttackFixValue()
  return self._attackFix
end

function EnlightenInfo:GetDefenceFixValue()
  return self._defenceFix
end

function EnlightenInfo:GetMaxHPFixValue()
  return self._maxHPFix
end

function EnlightenInfo:GetExElementParam()
  return self._exElementParam
end

function EnlightenInfo:GetActiveSkillIncreaseParam()
  return self._activeSkillIncreaseParam
end

function EnlightenInfo:GetSupplyPieceWeights()
  return self._supplyPieceWeights
end
