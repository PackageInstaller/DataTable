_class("BuffLogicAddPoisonByAttack", BuffLogicBase)
BuffLogicAddPoisonByAttack = BuffLogicAddPoisonByAttack

function BuffLogicAddPoisonByAttack:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
end

function BuffLogicAddPoisonByAttack:DoLogic()
  local e = self._buffInstance:Entity()
  local attrCmpt = e:Attributes()
  local maxHp = attrCmpt:CalcMaxHp()
  if maxHp <= 0 then
    return
  end
  local buffCmpt = e:BuffComponent()
  if not buffCmpt then
    return
  end
  local casterID = buffCmpt:GetPoisonByAttackCasterID()
  local caster = self._world:GetEntityByID(casterID)
  if not caster then
    return
  end
  local turn = buffCmpt:GetBuffValue("PoisonByAttackTurn")
  local round = self._world:BattleStat():GetLevelTotalRoundCount()
  if turn == round then
    return
  end
  buffCmpt:SetBuffValue("PoisonByAttackTurn", round)
  local layer = self._buffInstance:GetLayerCount()
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local casterAttack = buffLogicSvc:GetEntityAttackValue(caster)
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = e
  end
  local damageInfo = buffLogicSvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, e, {
    percent = self._damagePercent,
    layer = layer,
    attack = casterAttack,
    formulaID = FormulaNumberType.PoisonByAttackDamage
  })
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Poison)
  end
  local buffResult = BuffResultAddPoison:New(damageInfo)
  return buffResult
end
