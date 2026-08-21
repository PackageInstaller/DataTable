_class("BuffLogicShadowChain", BuffLogicBase)
BuffLogicShadowChain = BuffLogicShadowChain

function BuffLogicShadowChain:Constructor(buffInstance, logicParam)
  self._damagePercent = logicParam.damagePercent
  self._shadowPrefab = logicParam.shadowPrefab
  self._shadowCreate = logicParam.shadowCreate or 1
end

function BuffLogicShadowChain:DoLogic()
  local e = self._buffInstance:Entity()
  local buffComponent = e:BuffComponent()
  local entityService = self._world:GetService("LogicEntity")
  local shadowEntity = entityService:_CreateTeamMemberShadow(e)
  buffComponent:SetBuffValue("ShadowChainEntityID", shadowEntity:GetID())
  local damagePercent
  local buffShadowChainSKillPro = buffComponent:GetSingleBuffByBuffEffect(BuffEffectType.ShadowChainSKillPro)
  if self._buffInstance:GetBuffEffectType() == BuffEffectType.ShadowChainSKill and buffShadowChainSKillPro then
    damagePercent = buffComponent:GetBuffValue("ShadowChainDamagePercent") or 1
    damagePercent = damagePercent + self._damagePercent
  else
    damagePercent = self._damagePercent
  end
  buffComponent:SetBuffValue("ShadowChainDamagePercent", damagePercent)
  local buffResult = BuffResultShadowChain:New(shadowEntity:GetID(), e:PetPstID():GetPstID(), self._shadowPrefab, self._shadowCreate, e:GetID())
  return buffResult
end
