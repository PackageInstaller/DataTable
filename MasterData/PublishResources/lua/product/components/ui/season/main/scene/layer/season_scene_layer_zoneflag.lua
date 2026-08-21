_class("SeasonSceneLayerZoneFlag", SeasonSceneLayerBase)
SeasonSceneLayerZoneFlag = SeasonSceneLayerZoneFlag

function SeasonSceneLayerZoneFlag:Constructor(sceneRoot)
  self._transforms = {}
  self._zoneFlagLayer = self._sceneRootTransform:Find(SeasonSceneLayer.ZoneFlag)
  self:_CacheTransform()
end

function SeasonSceneLayerZoneFlag:Dispose()
  table.clear(self._renderers)
end

function SeasonSceneLayerZoneFlag:UnLock(zoneMask, zoneID2Animation)
end

function SeasonSceneLayerZoneFlag:GetZoneID(gameObject)
  if gameObject then
    for zoneID, transform in pairs(self._transforms) do
      for _, t in pairs(transform) do
        if gameObject.transform == t then
          return true, zoneID
        end
      end
    end
  end
  return false, nil
end

function SeasonSceneLayerZoneFlag:_CacheTransform()
  if self._zoneFlagLayer then
    local zoneCount = self._zoneFlagLayer.childCount
    if 0 < zoneCount then
      for i = 0, zoneCount - 1 do
        local zone = self._zoneFlagLayer:GetChild(i)
        if zone then
          local zoneid = i + 1
          local childCount = zone.childCount
          for j = 0, childCount - 1 do
            local trans = zone:GetChild(j)
            if not self._transforms[zoneid] then
              self._transforms[zoneid] = {}
            end
            table.insert(self._transforms[zoneid], trans)
          end
        end
      end
    end
  end
end
