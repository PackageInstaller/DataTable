_class("BuffViewAddLayerByTeleportDistance", BuffViewBase)
BuffViewAddLayerByTeleportDistance = BuffViewAddLayerByTeleportDistance

function BuffViewAddLayerByTeleportDistance:PlayView(TT)
  local result = self._buffResult
  local curMarkLayer = result:GetLayer()
  self._viewInstance:SetLayerCount(TT, curMarkLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if result:GetDonotDisplay() then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curMarkLayer)
  end
end
