_class("BuffViewAddLayerByScopeGridCount", BuffViewBase)
BuffViewAddLayerByScopeGridCount = BuffViewAddLayerByScopeGridCount

function BuffViewAddLayerByScopeGridCount:PlayView(TT)
  local result = self._buffResult
  local curMarkLayer = result:GetLayer()
  local buffSeq = result:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffSeq)
  viewInstance:SetLayerCount(TT, curMarkLayer, result:GetTotalLayer())
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if result:GetDonotDisplay() then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curMarkLayer)
  end
end
