_class("BuffViewTransferBuffLayer", BuffViewBase)
BuffViewTransferBuffLayer = BuffViewTransferBuffLayer

function BuffViewTransferBuffLayer:PlayView(TT)
  local res = self._buffResult
  local curLayer = res:GetLayer()
  local buffseq = res:GetBuffSeq()
  local addLayer = res:GetAddLayer()
  local entityID = res:GetEntityID()
  local entity = self._world:GetEntityByID(entityID)
  if entity then
    local buffView = entity:BuffView()
    local viewInstance = buffView:GetBuffViewInstance(buffseq)
    if viewInstance then
      viewInstance:SetLayerCount(TT, curLayer)
    end
  end
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
