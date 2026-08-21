_class("SeasonMazeSceneManager", Object)
SeasonMazeSceneManager = SeasonMazeSceneManager

function SeasonMazeSceneManager:Constructor()
  self._mapEventPointRootName = "MapEventPoint"
  self._sceneRootName = "SceneRoot"
end

function SeasonMazeSceneManager:OnInit(seasonID)
  self._sceenRoot = GameObjectHelper.Find(self._sceneRootName)
  if not self._sceenRoot then
    Log.fatal("SeasonMazeSceneManager scene no sceneroot! root name is ", self._sceneRootName)
    return
  end
  self._mapEventPointRoot = GameObjectHelper.CreateEmpty(self._mapEventPointRootName, nil)
  self._mapEventPointRoot.layer = SeasonLayerMask.Stage
  self._scene = self._mapEventPointRoot.scene
  self._sceneLayers = SeasonMazeSceneLayers:New(self._sceenRoot)
  self._environment = SeasonMazeSceneEnvironment:New(self._sceenRoot)
  self:UnLockZone(15)
end

function SeasonMazeSceneManager:GetEventPointRoot()
  return self._mapEventPointRoot
end

function SeasonMazeSceneManager:GetEventPointRootTransform()
  return self._mapEventPointRoot.transform
end

function SeasonMazeSceneManager:Update(deltaTime)
  self._environment:Update(deltaTime)
end

function SeasonMazeSceneManager:Dispose()
  self._sceneLayers:Dispose()
  self._environment:Dispose()
  UnityEngine.Object.Destroy(self._mapEventPointRoot)
end

function SeasonMazeSceneManager:Scene()
  return self._scene
end

function SeasonMazeSceneManager:GetLayer(layerType)
  return self._sceneLayers:GetLayer(layerType)
end

function SeasonMazeSceneManager:UnLockZone(zoneMask, zoneID2Animation)
  self._sceneLayers:UnLockZone(zoneMask, zoneID2Animation)
  self._environment:UnLockZone(zoneMask, zoneID2Animation)
end

function SeasonMazeSceneManager:ChangeMap(ids, openingID, closeID)
  self._sceneLayers:ChangeMap(ids, openingID, closeID)
end
