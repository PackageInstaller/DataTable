_class("SeasonMazeSceneLayerHighBuilding", SeasonMazeSceneLayerBase)
SeasonMazeSceneLayerHighBuilding = SeasonMazeSceneLayerHighBuilding

function SeasonMazeSceneLayerHighBuilding:Constructor(sceneRoot)
  self._time = 1
  self._zoneMask = nil
  self._highBuildingLayer = self._sceneRootTransform:Find(SeasonSceneLayer.HighBuilding)
  self:_CacheHighBuildingRenderer()
end

function SeasonMazeSceneLayerHighBuilding:Dispose()
  SeasonMazeSceneLayerHighBuilding.super.Dispose(self)
end

function SeasonMazeSceneLayerHighBuilding:UnLock(zoneMask, zoneID2Animation)
  local v4 = SeasonMazeTool:GetInstance():GetV4ByZoneMask(zoneMask, zoneID2Animation)
  for zoneID, zoneRenderers in pairs(self._renderers) do
    for _, renderer in pairs(zoneRenderers) do
      if renderer.material then
        renderer.material:SetVector("_AreaUnlockMask", v4)
      end
    end
  end
  self._zoneMask = zoneMask
  self:TweenV4()
end

function SeasonMazeSceneLayerHighBuilding:_CacheHighBuildingRenderer()
  if self._highBuildingLayer then
    local zoneCount = self._highBuildingLayer.childCount
    if 0 < zoneCount then
      for i = 0, zoneCount - 1 do
        local zone = self._highBuildingLayer:GetChild(i)
        if zone then
          local zoneid = i + 1
          local childCount = zone.childCount
          for j = 0, childCount - 1 do
            local building = zone:GetChild(j)
            local renderers = building.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
            if 0 < renderers.Length then
              for k = 0, renderers.Length - 1 do
                self:InsertMeshRender(zoneid, renderers[k])
              end
            end
          end
        end
      end
    end
  end
end

function SeasonMazeSceneLayerHighBuilding:TweenV4()
  self._tweenTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    local v4 = SeasonMazeTool:GetInstance():GetV4ByZoneMask(self._zoneMask)
    for zoneID, zoneRenderers in pairs(self._renderers) do
      for _, renderer in pairs(zoneRenderers) do
        if renderer.material then
          renderer.material:DOVector(v4, "_AreaUnlockMask", self._time)
        end
      end
    end
  end)
end
