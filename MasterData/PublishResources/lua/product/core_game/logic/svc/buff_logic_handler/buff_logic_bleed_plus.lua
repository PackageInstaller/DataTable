_class("BuffLogicAddBleedPlus", BuffLogicBase)
BuffLogicAddBleedPlus = BuffLogicAddBleedPlus

function BuffLogicAddBleedPlus:Constructor(buffInstance, logicParam)
  self._formulaID = logicParam.formulaID
  self._bleedRatio = logicParam.bleedRatio
  self._layerIncRatio = logicParam.layerIncRatio
  self._layerIncMax = logicParam.layerIncMax
  self._baseHPPercent = logicParam.baseHPPercent
  self._hpDamageRatio = logicParam.hpDamageRatio
  self._triggerBuffEffect = logicParam.triggerBuffEffect
end

function BuffLogicAddBleedPlus:DoLogic()
  local ownerEntity = self:GetEntity()
  local buffComp = ownerEntity:BuffComponent()
  if not buffComp then
    return
  end
  local turn = buffComp:GetBuffValue("BleedTurn")
  local round = self._world:BattleStat():GetLevelTotalRoundCount()
  if turn == round and self._triggerBuffEffect == nil then
    return
  end
  buffComp:SetBuffValue("BleedTurn", round)
  local layer = self._buffInstance:GetLayerCount()
  if self._triggerBuffEffect then
    layer = self._buffLogicService:GetBuffLayer(ownerEntity, self._triggerBuffEffect)
  end
  if layer == 0 then
    return
  end
  local layerIncrease = layer * self._layerIncRatio
  if layerIncrease > self._layerIncMax then
    layerIncrease = self._layerIncMax
  end
  local damageParam = {
    bleedRatio = self._bleedRatio,
    layerIncrease = layerIncrease,
    baseHPPercent = self._baseHPPercent,
    hpDamageRatio = self._hpDamageRatio,
    formulaID = self._formulaID
  }
  local buffSvc = self._world:GetService("BuffLogic")
  local casterEntity = self:GetCasterEntity()
  if casterEntity:EntityType() == nil then
    casterEntity = ownerEntity
  end
  local damageInfo = buffSvc:DoBuffDamage(self._buffInstance:BuffID(), casterEntity, ownerEntity, damageParam)
  if damageInfo:GetDamageType() == DamageType.Real then
    damageInfo:SetDamageType(DamageType.Bleed)
  end
  local buffResult = BuffResultDamage:New(damageInfo)
  return buffResult
end
