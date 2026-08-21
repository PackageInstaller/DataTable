_class("BuffViewTransferLayerShieldToTarget", BuffViewBase)
BuffViewTransferLayerShieldToTarget = BuffViewTransferLayerShieldToTarget

function BuffViewTransferLayerShieldToTarget:PlayView(TT)
  self._buffResult = self._buffResult
  local casterEntity = self._world:GetEntityByID(self._buffResult:GetCasterID())
  local targetEntity = self._world:GetEntityByID(self._buffResult:GetTargetID())
  local targetNewLayer = self._buffResult:GetTargetNewLayer()
  local layerName = self._viewInstance:ParseBuffLayerName(BuffEffectType.LayerShield)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTNotifyLayerChange:New(layerName))
  casterEntity:BuffView():SetBuffValue(layerName, 0)
  self._entity:PlayMaterialAnim("common_shieldactive")
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
  targetEntity:BuffView():SetBuffValue(layerName, targetNewLayer)
  self._entity:PlayMaterialAnim("common_shield")
  self._world:EventDispatcher():Dispatch(GameEventType.ChangeBuff)
end
