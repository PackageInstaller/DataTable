_class("SeasonMazeSceneLayers", Object)
SeasonMazeSceneLayers = SeasonMazeSceneLayers

function SeasonMazeSceneLayers:Constructor(sceenRoot)
  self._sceenRoot = sceenRoot
  self._layers = {}
  self._layers[SeasonSceneLayer.SoundMaterial] = SeasonMazeSceneLayerMaterial:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.ZoneFlag] = SeasonMazeSceneLayerZoneFlag:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.Ground] = SeasonMazeSceneLayerGround:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.Building] = SeasonMazeSceneLayerBuilding:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.HighBuilding] = SeasonMazeSceneLayerHighBuilding:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.FogMask] = SeasonMazeSceneLayerFogMask:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.Ambient] = SeasonMazeSceneLayerAmbient:New(self._sceenRoot)
  self._layers[SeasonSceneLayer.AmbientMap] = SeasonMazeSceneLayerAmbientMap:New(self._sceenRoot)
end

function SeasonMazeSceneLayers:Update(deltaTime)
end

function SeasonMazeSceneLayers:Dispose()
  for key, layer in pairs(self._layers) do
    layer:Dispose()
  end
  table.clear(self._layers)
end

function SeasonMazeSceneLayers:GetLayer(layerType)
  return self._layers[layerType]
end

function SeasonMazeSceneLayers:UnLockZone(zoneMask, zoneID2Animation)
  for _, layer in pairs(self._layers) do
    layer:UnLock(zoneMask, zoneID2Animation)
  end
end

function SeasonMazeSceneLayers:ChangeMap(ids, openingID, closeID)
  for _, layer in pairs(self._layers) do
    layer:ChangeMap(ids, openingID, closeID)
  end
end
