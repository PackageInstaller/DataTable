_class("BuffViewPlayAnim", BuffViewBase)
BuffViewPlayAnim = BuffViewPlayAnim

function BuffViewPlayAnim:PlayView(TT)
  local param = self._viewInstance:BuffConfigData():GetViewParams()
  local materialAnim = param.MaterialAnim
  local ownerEntity = self:Entity()
  ownerEntity:PlayMaterialAnim(materialAnim)
end
