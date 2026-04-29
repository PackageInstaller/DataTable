require("skill_effect_param_base")
_class("SkillEffectRefreshGridByBoardIDParam", SkillEffectParamBase)
SkillEffectRefreshGridByBoardIDParam = SkillEffectRefreshGridByBoardIDParam

function SkillEffectRefreshGridByBoardIDParam:Constructor(t)
  self._boardID = t.boardID
end

function SkillEffectRefreshGridByBoardIDParam:GetEffectType()
  return SkillEffectType.RefreshGridByBoardID
end

function SkillEffectRefreshGridByBoardIDParam:GetBoardID()
  return self._boardID
end
