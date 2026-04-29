_class("SeasonSceneLayers", Object)
SeasonSceneLayers = SeasonSceneLayers

function SeasonSceneLayers:Constructor(sceenRoot)
  self._sceenRoot = sceenRoot
  self._layers = {}
  self._layers[SeasonSceneLayer.SoundMaterial] = SeasonSceneLayerMaterial:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.ZoneFlag] = SeasonSceneLayerZoneFlag:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.Ground] = SeasonSceneLayerGround:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.Building] = SeasonSceneLayerBuilding:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.HighBuilding] = SeasonSceneLayerHighBuilding:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.FogMask] = SeasonSceneLayerFogMask:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.Ambient] = SeasonSceneLayerAmbient:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.AmbientMap] = SeasonSceneLayerAmbientMap:New(self._sceenRoot)
end

function SeasonSceneLayers:OnAfterInit()
  for k, subLyaer in pairs(self._layers) do
    subLyaer:OnAfterInit()
  end
end

function SeasonSceneLayers:Update(deltaTime)
end

function SeasonSceneLayers:Dispose()
  for key, layer in pairs(self._layers) do
    layer:Dispose()
  end
  table.clear(self._layers)
end

function SeasonSceneLayers:GetLayer(layerType)
  return self._layers[layerType]
end

function SeasonSceneLayers:UnLockZone(zoneMask, zoneID2Animation)
  for _, layer in pairs(self._layers) do
    layer:UnLock(zoneMask, zoneID2Animation)
  end
end

function SeasonSceneLayers:ChangeMap(ids, openingID, closeID)
  for _, layer in pairs(self._layers) do
    layer:ChangeMap(ids, openingID, closeID)
  end
end
