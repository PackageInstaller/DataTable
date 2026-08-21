require("skill_effect_param_base")
_class("SkillEffectRideOnParam", SkillEffectParamBase)
SkillEffectRideOnParam = SkillEffectRideOnParam

function SkillEffectRideOnParam:Constructor(t)
  self._trapID = t.trapID
  self._trapHeight = t.trapHeight or 0
  self._monsterClassID = t.monsterClassID
  self._monsterHeight = t.monsterHeight or 0
  self._monsterOffset = Vector2.zero
  if t.offset and #t.offset == 2 then
    self._monsterOffset = Vector2(t.offset[1], t.offset[2])
  end
end

function SkillEffectRideOnParam:GetEffectType()
  return SkillEffectType.RideOn
end

function SkillEffectRideOnParam:GetTrapID()
  return self._trapID
end

function SkillEffectRideOnParam:GetTrapHeight()
  return self._trapHeight
end

function SkillEffectRideOnParam:GetMonsterClassID()
  return self._monsterClassID
end

function SkillEffectRideOnParam:GetMonsterHeight()
  return self._monsterHeight
end

function SkillEffectRideOnParam:GetMonsterOffset()
  return self._monsterOffset
end
