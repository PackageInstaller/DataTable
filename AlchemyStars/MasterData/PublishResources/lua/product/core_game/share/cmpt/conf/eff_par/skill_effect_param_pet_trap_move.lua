require("skill_effect_param_base")
_class("SkillEffectParamPetTrapMove", SkillEffectParamBase)
SkillEffectParamPetTrapMove = SkillEffectParamPetTrapMove

function SkillEffectParamPetTrapMove:Constructor(t)
  self._moveStep = t.moveStep
  self._moveType = t.moveType
  self._moveParam = t.moveParam
  self._canMoveTrapLevel = t.canMoveTrapLevel
end

function SkillEffectParamPetTrapMove:GetEffectType()
  return SkillEffectType.PetTrapMove
end

function SkillEffectParamPetTrapMove:GetMoveStep()
  return self._moveStep
end

function SkillEffectParamPetTrapMove:GetMoveType()
  return self._moveType
end

function SkillEffectParamPetTrapMove:GetMoveParam()
  return self._moveParam
end

function SkillEffectParamPetTrapMove:GetCanMoveTrapLevel()
  return self._canMoveTrapLevel
end

local PetTrapMoveType = {
  CloseToTeam = 1,
  AwayFromTeam = 2,
  FixedPos = 3,
  SkillPos = 4,
  Loop = 5,
  MAX = 9
}
_enum("PetTrapMoveType", PetTrapMoveType)
