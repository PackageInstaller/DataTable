require("skill_damage_effect_param")
local SwapPetTeamOrderType = {
  TARGET_INDEX = 1,
  TEAM_LEADER = 2,
  TEAM_TAIL = 3,
  CASTER_SELECT_TEAM_POS = 4,
  OFFSET = 5,
  MAX = 99
}
_enum("SwapPetTeamOrderType", SwapPetTeamOrderType)
_class("SkillEffectParam_SwapPetTeamOrder", SkillEffectParamBase)
SkillEffectParam_SwapPetTeamOrder = SkillEffectParam_SwapPetTeamOrder

function SkillEffectParam_SwapPetTeamOrder:Constructor(paramList)
  self._targetOrderIndex = paramList.targetOrderIndex
  self._targetOrderType = paramList.targetOrderType
end

function SkillEffectParam_SwapPetTeamOrder:GetEffectType()
  return SkillEffectType.SwapPetTeamOrder
end

function SkillEffectParam_SwapPetTeamOrder:GetTargetOrderIndex()
  return self._targetOrderIndex
end

function SkillEffectParam_SwapPetTeamOrder:GetTargetOrderType()
  return self._targetOrderType
end
