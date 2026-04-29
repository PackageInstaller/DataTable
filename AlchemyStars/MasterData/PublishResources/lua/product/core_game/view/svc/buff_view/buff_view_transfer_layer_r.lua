_class("BuffViewTransferLayer", BuffViewBase)
BuffViewTransferLayer = BuffViewTransferLayer

function BuffViewTransferLayer:PlayView(TT, notify, trace)
  local res = self._buffResult
  local curLayer = res:GetLayer()
  local buffseq = res:GetBuffSeq()
  local addLayer = res:GetAddLayer()
  local targetID = res:GetEntityID()
  local targetEntity = self._world:GetEntityByID(targetID)
  local buffView = targetEntity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffseq)
  if not viewInstance then
    Log.error("BuffViewTransferLayer not find viewInstance! entity=", targetEntity:GetID(), " layer=", curLayer)
    return
  end
  Log.debug("BuffViewTransferLayer entity=", targetEntity:GetID(), " layer=", curLayer)
  viewInstance:SetLayerCount(TT, curLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end

function BuffViewTransferLayer:IsNotifyMatch(notify)
  return true
end
