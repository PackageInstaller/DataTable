require("skill_effect_result_base")
_class("SkillEffectResultFixTrapWall", SkillEffectResultBase)
SkillEffectResultFixTrapWall = SkillEffectResultFixTrapWall

function SkillEffectResultFixTrapWall:Constructor(isAdd, fixTrapWallPosList, stageIndex)
  self._isAdd = isAdd
  self._fixTrapWallPosList = fixTrapWallPosList
  self._stageIndex = stageIndex
end

function SkillEffectResultFixTrapWall:GetEffectType()
  return SkillEffectType.FixTrapWall
end

function SkillEffectResultFixTrapWall:GetIsAdd()
  return self._isAdd
end

function SkillEffectResultFixTrapWall:GetFixTrapWallPosList()
  return self._fixTrapWallPosList
end

function SkillEffectResultFixTrapWall:GetStageIndex()
  return self._stageIndex
end

function SkillEffectResultFixTrapWall:GetDamageStageIndex()
  return self._stageIndex
end
