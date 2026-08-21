require("skill_effect_param_base")
_class("SkillEffectPopStarParam", SkillEffectParamBase)
SkillEffectPopStarParam = SkillEffectPopStarParam

function SkillEffectPopStarParam:Constructor(t)
  self._pieceTypeList = t.pieceTypeList
  self._popCount = t.popCount
  self._random = t.random or false
  self._countRandomTab = t.countRandom
end

function SkillEffectPopStarParam:GetEffectType()
  return SkillEffectType.PopStar
end

function SkillEffectPopStarParam:GetPieceTypeList()
  return self._pieceTypeList
end

function SkillEffectPopStarParam:GetPopCount()
  return self._popCount
end

function SkillEffectPopStarParam:NeedRandom()
  return self._random
end

function SkillEffectPopStarParam:GetCountRandomTab()
  return self._countRandomTab
end
