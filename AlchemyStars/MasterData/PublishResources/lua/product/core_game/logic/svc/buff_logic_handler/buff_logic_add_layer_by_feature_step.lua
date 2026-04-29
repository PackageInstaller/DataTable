require("buff_logic_base")
_class("BuffLogicAddLayerByFeatureStep", BuffLogicBase)
BuffLogicAddLayerByFeatureStep = BuffLogicAddLayerByFeatureStep

function BuffLogicAddLayerByFeatureStep:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._mulValue = logicParam.mulValue or 1
  self._addValue = logicParam.addValue or 0
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByFeatureStep:DoLogic(notify)
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if lsvcFeature:HasFeatureType(FeatureType.StepPoint) then
    local curStep = lsvcFeature:GetCurStepPoint()
    local addLayer = math.floor(curStep * self._mulValue) + self._addValue
    if addLayer == 0 then
      return
    end
    local svc = self._world:GetService("BuffLogic")
    local curMarkLayer, buffInst = svc:AddBuffLayer(self._entity, self._layerType, addLayer)
    local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
    buffResult:SetBuffSeq(buffInst:BuffSeq())
    return buffResult
  end
end
