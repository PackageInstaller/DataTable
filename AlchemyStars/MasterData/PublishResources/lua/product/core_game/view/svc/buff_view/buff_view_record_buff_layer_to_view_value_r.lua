_class("BuffViewRecordBuffLayerToViewValue", BuffViewBase)
BuffViewRecordBuffLayerToViewValue = BuffViewRecordBuffLayerToViewValue

function BuffViewRecordBuffLayerToViewValue:PlayView(TT)
  local result = self._buffResult
  local layerType = result:GetBuffLayerType()
  local layerCount = result:GetLayerCount()
  local isRevert = result:GetIsRevert()
  local bvcmpt = self._entity:BuffView()
  if not bvcmpt then
    return
  end
  local keyStr = "layerCount" .. tostring(layerType)
  if isRevert then
    bvcmpt:SetBuffValue(keyStr, nil)
  else
    bvcmpt:SetBuffValue(keyStr, layerCount)
  end
end
