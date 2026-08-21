require("skill_effect_result_base")
_class("SkillEffectConvertAndDamageByLinkLineResult", SkillEffectResultBase)
SkillEffectConvertAndDamageByLinkLineResult = SkillEffectConvertAndDamageByLinkLineResult

function SkillEffectConvertAndDamageByLinkLineResult:Constructor()
  self._chainPath = {}
  self._teleportResult = nil
  self._convertResult = nil
  self._damageResult = nil
end

function SkillEffectConvertAndDamageByLinkLineResult:GetEffectType()
  return SkillEffectType.ConvertAndDamageByLinkLine
end

function SkillEffectConvertAndDamageByLinkLineResult:SetChainPath(chainPath)
  self._chainPath = chainPath
end

function SkillEffectConvertAndDamageByLinkLineResult:SetTeleportResult(teleportRes)
  self._teleportResult = teleportRes
end

function SkillEffectConvertAndDamageByLinkLineResult:SetConvertResult(convertResult)
  self._convertResult = convertResult
end

function SkillEffectConvertAndDamageByLinkLineResult:SetDamageResult(damageResult)
  self._damageResult = damageResult
end

function SkillEffectConvertAndDamageByLinkLineResult:GetChainPath()
  return self._chainPath
end

function SkillEffectConvertAndDamageByLinkLineResult:GetTeleportResult()
  return self._teleportResult
end

function SkillEffectConvertAndDamageByLinkLineResult:GetConvertResult()
  return self._convertResult
end

function SkillEffectConvertAndDamageByLinkLineResult:GetDamageResult()
  return self._damageResult
end
