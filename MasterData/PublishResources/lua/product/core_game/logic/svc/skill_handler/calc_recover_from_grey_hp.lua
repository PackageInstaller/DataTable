_class("SkillEffectCalc_RecoverFromGreyHP", SkillEffectCalc_Base)
SkillEffectCalc_RecoverFromGreyHP = SkillEffectCalc_RecoverFromGreyHP

function SkillEffectCalc_RecoverFromGreyHP:CalculateOnSingleTarget(calcParam, targetID)
  local casterEntity = self._world:GetEntityByID(calcParam:GetCasterEntityID())
  local effectParam = calcParam:GetSkillEffectParam()
  local buffLogicService = self._world:GetService("BuffLogic")
  local damageInfo = buffLogicService:GetRecoverFromGreyHPDamageInfo(casterEntity, effectParam:GetRecoverRate())
  if not damageInfo then
    return
  end
  return SkillEffectResult_RecoverFromGreyHP:New(calcParam:GetCasterEntityID(), damageInfo)
end
