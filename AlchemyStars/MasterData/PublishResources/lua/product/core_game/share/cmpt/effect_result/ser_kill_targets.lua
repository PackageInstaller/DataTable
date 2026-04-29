require("skill_effect_result_base")
_class("SkillEffectKillTargetsResult", SkillEffectResultBase)
SkillEffectKillTargetsResult = SkillEffectKillTargetsResult

function SkillEffectKillTargetsResult:GetEffectType()
  return SkillEffectType.KillTargets
end

function SkillEffectKillTargetsResult:Constructor(targetList)
  self._targetList = targetList or {}
end

function SkillEffectKillTargetsResult:AddTargetID(targetID)
  table.insert(self._targetList, targetID)
end

function SkillEffectKillTargetsResult:GetTargetList()
  return self._targetList
end
