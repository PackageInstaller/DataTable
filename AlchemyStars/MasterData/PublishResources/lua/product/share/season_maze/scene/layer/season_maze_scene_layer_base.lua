_class("SeasonMazeSceneLayerBase", Object)
SeasonMazeSceneLayerBase = SeasonMazeSceneLayerBase

function SeasonMazeSceneLayerBase:Constructor(sceneRoot)
  self._sceneRootTransform = sceneRoot.transform
  self._maxMapCount = 12
  self._map = {}
  self._renderers = {}
end

function SeasonMazeSceneLayerBase:Dispose()
  table.clear(self._renderers)
end

function SeasonMazeSceneLayerBase:UnLock(zoneMask, zoneID2Animation)
end

function SeasonMazeSceneLayerBase:ChangeMap(ids, openID, closeID)
end

function SeasonMazeSceneLayerBase:InsertMeshRender(zoneid, renderer)
  if zoneid and renderer then
    if not self._renderers[zoneid] then
      self._renderers[zoneid] = {}
    end
    table.insert(self._renderers[zoneid], renderer)
  end
end
