_class("SeasonSceneLayerHighBuilding", SeasonSceneLayerBase)
SeasonSceneLayerHighBuilding = SeasonSceneLayerHighBuilding

function SeasonSceneLayerHighBuilding:Constructor(sceneRoot)
  self._time = 1
  self._zoneMask = nil
  self._highBuildingLayer = self._sceneRootTransform:Find(SeasonSceneLayer.HighBuilding)
  self._manualAnimations = {}
  self:_CacheHighBuildingRenderer()
end

function SeasonSceneLayerHighBuilding:Dispose()
  SeasonSceneLayerHighBuilding.super.Dispose(self)
end

function SeasonSceneLayerHighBuilding:OnAfterInit()
  for k, subAniamtion in pairs(self._manualAnimations) do
    subAniamtion:Play()
  end
end

function SeasonSceneLayerHighBuilding:GetManualAnimations()
  return self._manualAnimations
end

function SeasonSceneLayerHighBuilding:UnLock(zoneMask, zoneID2Animation)
  local v4 = SeasonTool:GetInstance():GetV4ByZoneMask(zoneMask, zoneID2Animation)
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

function SeasonSceneLayerHighBuilding:_CacheHighBuildingRenderer()
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
            if string.endwith(building.gameObject.name, "_AniAfterLoad") then
              local animations = building.gameObject:GetComponentsInChildren(typeof(UnityEngine.Animation))
              if 0 < animations.Length then
                for k = 0, animations.Length - 1 do
                  table.insert(self._manualAnimations, animations[i])
                end
              end
            end
          end
        end
      end
    end
  end
end

function SeasonSceneLayerHighBuilding:TweenV4()
  self._tweenTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT)
    local v4 = SeasonTool:GetInstance():GetV4ByZoneMask(self._zoneMask)
    for zoneID, zoneRenderers in pairs(self._renderers) do
      for _, renderer in pairs(zoneRenderers) do
        if renderer.material then
          renderer.material:DOVector(v4, "_AreaUnlockMask", self._time)
        end
      end
    end
  end)
end
