_class("BuffViewAddLayerByFeatureStepCost", BuffViewBase)
BuffViewAddLayerByFeatureStepCost = BuffViewAddLayerByFeatureStepCost

function BuffViewAddLayerByFeatureStepCost:PlayView(TT)
  local result = self:GetBuffResult()
  local curMarkLayer = result:GetLayer()
  local dontDisplay = result:GetDonotDisplay()
  local buffSeq = result:GetBuffSeq()
  local buffView = self._entity:BuffView()
  local viewInstance = buffView:GetBuffViewInstance(buffSeq)
  viewInstance:SetLayerCount(TT, curMarkLayer)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  if dontDisplay then
    return
  end
  if self._entity:HasPetPstID() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SetAccumulateNum, self._entity:PetPstID():GetPstID(), curMarkLayer)
  end
end
