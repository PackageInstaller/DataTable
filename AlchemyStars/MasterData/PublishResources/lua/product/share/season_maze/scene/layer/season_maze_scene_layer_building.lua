_class("SeasonMazeSceneLayerBuilding", SeasonMazeSceneLayerBase)
SeasonMazeSceneLayerBuilding = SeasonMazeSceneLayerBuilding

function SeasonMazeSceneLayerBuilding:Constructor(sceneRoot)
  self._time = 1
  self._zoneMask = nil
  self._buildingLayer = self._sceneRootTransform:Find(SeasonSceneLayer.Building)
  self._animationRenders = {}
  local seasonMazeManager = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager()
  self._coverManager = seasonMazeManager:SeasonMazeCoverManager()
  self:_CreateBuildingCover()
end

function SeasonMazeSceneLayerBuilding:Dispose()
  SeasonMazeSceneLayerBuilding.super.Dispose(self)
  if self._tweenTask then
    GameGlobal.TaskManager():KillTask(self._tweenTask)
    self._tweenTask = nil
  end
  table.clear(self._animationRenders)
end

function SeasonMazeSceneLayerBuilding:UnLock(zoneMask, zoneID2Animation)
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

function SeasonMazeSceneLayerBuilding:_CreateBuildingCover()
  if self._buildingLayer then
    local zoneCount = self._buildingLayer.childCount
    if 0 < zoneCount then
      for i = 0, zoneCount - 1 do
        local zone = self._buildingLayer:GetChild(i)
        if zone then
          local zoneid = i + 1
          local childCount = zone.childCount
          for j = 0, childCount - 1 do
            local building = zone:GetChild(j)
            if string.find(string.lower(building.name), self._coverManager:CoverFlag()) then
              SeasonMazeTool:GetInstance():TryAddCover(zone, building)
            else
              local renderers = building.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
              if 0 < renderers.Length then
                for k = 0, renderers.Length - 1 do
                  self:InsertMeshRender(zoneid, renderers[k])
                end
              end
            end
            local grandChildCount = building.childCount
            if 0 < grandChildCount then
              for k = 0, grandChildCount - 1 do
                local grandChild = building:GetChild(k)
                if string.find(string.lower(grandChild.name), self._coverManager:CoverFlag()) then
                  SeasonMazeTool:GetInstance():TryAddCover(building, grandChild)
                end
              end
            end
          end
        end
      end
    end
  end
end

function SeasonMazeSceneLayerBuilding:TweenV4()
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
