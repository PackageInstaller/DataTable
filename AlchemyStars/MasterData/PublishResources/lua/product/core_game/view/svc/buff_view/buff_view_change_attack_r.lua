_class("BuffViewChangeAttack", BuffViewBase)
BuffViewChangeAttack = BuffViewChangeAttack

function BuffViewChangeAttack:PlayView(TT)
  local entity = self._entity
  if entity:HasMaterialAnimationComponent() then
    entity:MaterialAnimationComponent():PlayAtkup()
  end
  local cfg = self._viewInstance:BuffConfigData()
  local effectID = cfg:GetExecEffectID()
  if effectID then
    self._world:GetService("Effect"):CreateEffect(effectID, self._entity)
  end
  local result = self._buffResult
  if result:GetIsLight() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, self._entity:PetPstID():GetPstID(), true)
  end
end

_class("BuffViewChangeAttackUndo", BuffViewBase)
BuffViewChangeAttackUndo = BuffViewChangeAttackUndo

function BuffViewChangeAttackUndo:PlayView(TT)
  local result = self._buffResult
  if result:GetIsBlack() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, self._entity:PetPstID():GetPstID(), false)
  end
  local casterId = result:GetCasterID()
  local caster = self._world:GetEntityByID(casterId)
  if result:GetCasterBlack() and caster and caster:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, caster:PetPstID():GetPstID(), false)
  end
end
