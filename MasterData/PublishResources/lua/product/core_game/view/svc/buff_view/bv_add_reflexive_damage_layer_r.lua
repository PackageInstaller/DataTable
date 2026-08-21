_class("BuffViewAddReflexiveDamageLayer", BuffViewBase)
BuffViewAddReflexiveDamageLayer = BuffViewAddReflexiveDamageLayer

function BuffViewAddReflexiveDamageLayer:PlayView(TT)
  if not self._entity:PetPstID() then
    return
  end
  local res = self:GetBuffResult()
  local layer = res:GetLayer()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), layer)
end
