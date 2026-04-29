_class("BuffLogicAddBurn", BuffLogicBase)
BuffLogicAddBurn = BuffLogicAddBurn

function BuffLogicAddBurn:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
  self._triggerBuffEffect = logicParam.triggerBuffEffect
end

function BuffLogicAddBurn:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:Attributes() then
    return
  end
  local turn = e:BuffComponent():GetBuffValue("BurnTurn")
  local round = self._world:BattleStat():GetLevelTotalRoundCount()
  if turn == round and self._triggerBuffEffect == nil then
    return
  end
  e:BuffComponent():SetBuffValue("BurnTurn", round)
  local attrCmpt = e:Attributes()
  local curHP = attrCmpt:GetCurrentHP()
  local layer = self._buffInstance:GetLayerCount()
  if self._triggerBuffEffect then
    layer = self._buffLogicService:GetBuffLayer(e, self._triggerBuffEffect)
  end
  if layer == 0 then
    return
  end
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local blsvc = self._world:GetService("BuffLogic")
  local damageParam = {
    percent = self._damagePercent,
    layer = layer,
    formulaID = 14
  }
  if blsvc:IsEnableSpecialDotFormula(casterEntity, e) then
    local cfgParam = blsvc:GetSpecialDotFormulaParamByID(FormulaNumberType.BurnDamage)
    if cfgParam then
      damageParam.percent = cfgParam.percent
      damageParam.formulaID = cfgParam.formulaID
    end
  end
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, e, damageParam)
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Burn)
  end
  local buffResult = BuffResultDamage:New(damageInfo)
  return buffResult
end
