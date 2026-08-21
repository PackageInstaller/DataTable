_class("BuffViewAddLayerByFeatureStep", BuffViewBase)
BuffViewAddLayerByFeatureStep = BuffViewAddLayerByFeatureStep

function BuffViewAddLayerByFeatureStep:PlayView(TT)
  local result = self:GetBuffResult()
  local curMarkLayer = result:GetLayer()
  local buffSeq = result:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffSeq)
  local dontDisplay = result:GetDonotDisplay()
  viewInstance:SetLayerCount(TT, curMarkLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if dontDisplay then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curMarkLayer)
  end
end
