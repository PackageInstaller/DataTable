require("skill_damage_effect_param")
_class("SkillEffectParam_ShuffleTeamOrder", SkillEffectParamBase)
SkillEffectParam_ShuffleTeamOrder = SkillEffectParam_ShuffleTeamOrder

function SkillEffectParam_ShuffleTeamOrder:Constructor(paramList)
  self._shufflePos = paramList.shufflePos or {
    2,
    3,
    4,
    5
  }
  if table.icontains(self._shufflePos, 1) then
    Log.exception("shufflePos不支持1号位配置")
  end
end

function SkillEffectParam_ShuffleTeamOrder:GetEffectType()
  return SkillEffectType.ShufflePetTeamOrder
end

function SkillEffectParam_ShuffleTeamOrder:GetShufflePos()
  return self._shufflePos
end
