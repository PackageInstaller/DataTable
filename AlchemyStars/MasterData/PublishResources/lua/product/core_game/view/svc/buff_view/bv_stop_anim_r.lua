_class("BuffViewStopAnim", BuffViewBase)
BuffViewStopAnim = BuffViewStopAnim

function BuffViewStopAnim:PlayView(TT)
  local param = self._viewInstance:BuffConfigData():GetViewParams()
  local ownerEntity = self:Entity()
  local materialAnim = param.MaterialAnim
  ownerEntity:StopMaterialAnim(materialAnim)
end
