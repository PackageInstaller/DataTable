require("calc_base")
_class("SkillEffectCalc_MultiplyBuffLayer", SkillEffectCalc_Base)
SkillEffectCalc_MultiplyBuffLayer = SkillEffectCalc_MultiplyBuffLayer

function SkillEffectCalc_MultiplyBuffLayer:CalculateOnSingleTarget(skillEffectCalcParam, targetID)
  if targetID == -1 then
    return
  end
  local eTarget = self._world:GetEntityByID(targetID)
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local buffInstance = self:GetBuffInstanceByParam(param, eTarget)
  if not buffInstance then
    return
  end
  local buffEffectType = buffInstance:GetBuffEffectType()
  local buffSeq = buffInstance:BuffSeq()
  local lsvcBuff = self._world:GetService("BuffLogic")
  local baseVal = lsvcBuff:GetBuffLayer(eTarget, buffEffectType)
  local val = math.floor(baseVal * param:GetMultiplier())
  return SkillEffectResult_MultiplyBuffLayer:New(targetID, buffEffectType, val, buffSeq)
end

function SkillEffectCalc_MultiplyBuffLayer:GetBuffInstanceByParam(param, eTarget)
  local cBuff = eTarget:BuffComponent()
  if not cBuff then
    return nil
  end
  if param:GetLayerBuffID() then
    local buffID = param:GetLayerBuffID()
    return cBuff:GetBuffById(buffID)
  elseif param:GetLayerBuffEffectType() then
    local buffEffectType = param:GetLayerBuffEffectType()
    return cBuff:GetSingleBuffByBuffEffect(buffEffectType)
  end
end
