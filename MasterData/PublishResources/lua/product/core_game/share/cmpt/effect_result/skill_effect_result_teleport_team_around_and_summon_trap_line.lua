require("skill_effect_result_base")
_class("SkillEffectResultTeleportTeamAroundAndSummonTrapLine", SkillEffectResultBase)
SkillEffectResultTeleportTeamAroundAndSummonTrapLine = SkillEffectResultTeleportTeamAroundAndSummonTrapLine

function SkillEffectResultTeleportTeamAroundAndSummonTrapLine:Constructor(casterEntityID, modifyType, newValue)
  self._casterEntityID = casterEntityID
  self._modifyType = modifyType
  self._newValue = newValue
end

function SkillEffectResultTeleportTeamAroundAndSummonTrapLine:GetEffectType()
  return SkillEffectType.TeleportTeamAroundAndSummonTrapLine
end

function SkillEffectResultTeleportTeamAroundAndSummonTrapLine:GetCasterEntityID()
  return self._casterEntityID
end

function SkillEffectResultTeleportTeamAroundAndSummonTrapLine:GetModifyType()
  return self._modifyType
end

function SkillEffectResultTeleportTeamAroundAndSummonTrapLine:GetNewValue()
  return self._newValue
end
