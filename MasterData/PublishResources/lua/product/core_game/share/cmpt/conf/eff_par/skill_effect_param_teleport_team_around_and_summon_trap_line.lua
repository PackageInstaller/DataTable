require("skill_effect_param_base")
_class("SkillEffectParamTeleportTeamAroundAndSummonTrapLine", SkillEffectParamBase)
SkillEffectParamTeleportTeamAroundAndSummonTrapLine = SkillEffectParamTeleportTeamAroundAndSummonTrapLine

function SkillEffectParamTeleportTeamAroundAndSummonTrapLine:Constructor(t)
  self._trapID = t.trapID
  self._limitCount = t.limitCount
  self._squareRingStart = t.squareRingStart or 1
end

function SkillEffectParamTeleportTeamAroundAndSummonTrapLine:GetEffectType()
  return SkillEffectType.TeleportTeamAroundAndSummonTrapLine
end

function SkillEffectParamTeleportTeamAroundAndSummonTrapLine:GetTrapID()
  return self._trapID
end

function SkillEffectParamTeleportTeamAroundAndSummonTrapLine:GetLimitCount()
  return self._limitCount
end

function SkillEffectParamTeleportTeamAroundAndSummonTrapLine:GetSquareRingStart()
  return self._squareRingStart
end
