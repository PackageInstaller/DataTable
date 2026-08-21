require("skill_effect_result_base")
_class("SkillEffectResultMoyeMove", SkillEffectResultBase)
SkillEffectResultMoyeMove = SkillEffectResultMoyeMove

function SkillEffectResultMoyeMove:Constructor()
  self._teleportResult = nil
end

function SkillEffectResultMoyeMove:GetEffectType()
  return SkillEffectType.MoyeMove
end

function SkillEffectResultMoyeMove:SetTeleportResult(teleportRes)
  self._teleportResult = teleportRes
end

function SkillEffectResultMoyeMove:GetTeleportResult()
  return self._teleportResult
end
