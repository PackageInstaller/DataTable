_class("BuffViewChangeAnimatorLayerWeight", BuffViewBase)
BuffViewChangeAnimatorLayerWeight = BuffViewChangeAnimatorLayerWeight

function BuffViewChangeAnimatorLayerWeight:PlayView(TT)
  local entity = self._entity
  local changeInfo = self._buffResult:GetChangeInfo()
  if entity and changeInfo then
    entity:SetAnimatorLayerWeight(changeInfo)
    entity:SetKeepAnimatorLayerWeight(true)
  end
end
