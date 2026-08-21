_class("BuffViewChangeAttackByCaster", BuffViewBase)
BuffViewChangeAttackByCaster = BuffViewChangeAttackByCaster

function BuffViewChangeAttackByCaster:PlayView(TT)
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
  if result:GetLight() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, result:GetCasterPstID(), true)
  end
end

_class("BuffViewUndoChangeAttackByCaster", BuffViewBase)
BuffViewUndoChangeAttackByCaster = BuffViewUndoChangeAttackByCaster

function BuffViewUndoChangeAttackByCaster:PlayView(TT)
  local result = self._buffResult
  if result:GetBlack() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivatePassive, result:GetCasterPstID(), false)
  end
end
