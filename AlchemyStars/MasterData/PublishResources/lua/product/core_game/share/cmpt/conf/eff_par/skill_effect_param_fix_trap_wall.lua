require("skill_effect_param_base")
_class("SkillEffectParamFixTrapWall", SkillEffectParamBase)
SkillEffectParamFixTrapWall = SkillEffectParamFixTrapWall
local FixTrapWallType = {
  AddSelectPos = 1,
  AddSelectRange = 2,
  AddSelectRangeOut = 3,
  AddSkillRange = 4,
  AddSkillRangeOut = 5,
  DeleteSelectPos = 101,
  DeleteSelectRange = 102,
  DeleteSelectRangeIn = 103,
  DeleteSkillRange = 104,
  DeleteSkillRangeIn = 105,
  MAX = 9
}
_enum("FixTrapWallType", FixTrapWallType)

function SkillEffectParamFixTrapWall:Constructor(t)
  self._type = t.type
  self._posList = t.pos
end

function SkillEffectParamFixTrapWall:GetEffectType()
  return SkillEffectType.FixTrapWall
end

function SkillEffectParamFixTrapWall:GetFixTrapWallType()
  return self._type
end

function SkillEffectParamFixTrapWall:GetFixTrapWallPosList()
  return self._posList
end
