_class("BuffLogicShowChainDamage", BuffLogicBase)
BuffLogicShowChainDamage = BuffLogicShowChainDamage

function BuffLogicShowChainDamage:Constructor(buffInstance, logicParam)
  self._show = logicParam.show
  self._lineEffectID = logicParam.lineEffectID
end

function BuffLogicShowChainDamage:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local casterEntity = context.casterEntity
  if casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:GetSuperEntity()
  end
  if not casterEntity then
    return
  end
  local attacker = self._world:GetEntityByID(casterEntity:GetID())
  if not attacker then
    return
  end
  if attacker:HasDeadMark() then
    return
  end
  local isShow = self._show == 1
  local buffResult = BuffResultShowChainDamage:New(casterEntity:GetID(), entity:GetID(), self._lineEffectID, isShow)
  return buffResult
end
