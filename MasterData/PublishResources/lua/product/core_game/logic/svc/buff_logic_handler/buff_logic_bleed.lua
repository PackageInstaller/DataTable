_class("BuffLogicAddBleed", BuffLogicBase)
BuffLogicAddBleed = BuffLogicAddBleed

function BuffLogicAddBleed:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
  self._triggerBuffEffect = logicParam.triggerBuffEffect
end

function BuffLogicAddBleed:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:Attributes() then
    return
  end
  local turn = e:BuffComponent():GetBuffValue("BleedTurn")
  local round = self._world:BattleStat():GetLevelTotalRoundCount()
  if turn == round and self._triggerBuffEffect == nil then
    return
  end
  e:BuffComponent():SetBuffValue("BleedTurn", round)
  local layer = self._buffInstance:GetLayerCount()
  if self._triggerBuffEffect then
    layer = self._buffLogicService:GetBuffLayer(e, self._triggerBuffEffect)
  end
  local maxHP = e:Attributes():CalcMaxHp()
  local curHp = e:Attributes():GetCurrentHP()
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
    formulaID = 13
  }
  if blsvc:IsEnableSpecialDotFormula(casterEntity, e) then
    local cfgParam = blsvc:GetSpecialDotFormulaParamByID(FormulaNumberType.BloodDamage)
    if cfgParam then
      damageParam.percent = cfgParam.percent
      damageParam.formulaID = cfgParam.formulaID
    end
  end
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, e, damageParam)
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Bleed)
  end
  local buffResult = BuffResultDamage:New(damageInfo)
  return buffResult
end
