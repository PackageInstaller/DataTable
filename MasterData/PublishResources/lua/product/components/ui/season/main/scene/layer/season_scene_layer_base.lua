_class("SeasonSceneLayerBase", Object)
SeasonSceneLayerBase = SeasonSceneLayerBase

function SeasonSceneLayerBase:Constructor(sceneRoot)
  self._sceneRootTransform = sceneRoot.transform
  self._maxMapCount = 12
  self._map = {}
  self._renderers = {}
end

function SeasonSceneLayerBase:Dispose()
  table.clear(self._renderers)
end

function SeasonSceneLayerBase:OnAfterInit()
end

function SeasonSceneLayerBase:UnLock(zoneMask, zoneID2Animation)
end

function SeasonSceneLayerBase:ChangeMap(ids, openID, closeID)
end

function SeasonSceneLayerBase:InsertMeshRender(zoneid, renderer)
  if zoneid and renderer then
    if not self._renderers[zoneid] then
      self._renderers[zoneid] = {}
    end
    table.insert(self._renderers[zoneid], renderer)
  end
end
