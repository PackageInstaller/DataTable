_class("SeasonSceneLayerFogMask", SeasonSceneLayerBase)
SeasonSceneLayerFogMask = SeasonSceneLayerFogMask

function SeasonSceneLayerFogMask:Constructor(sceneRoot)
  self._fogMaskLayer = self._sceneRootTransform:Find(SeasonSceneLayer.FogMask)
  self._time = 1
  self._fogEffects = {}
  self._fogMatCtrFlog = "_matfog"
  self._fogMatRenderers = {}
  self._fogMatObjects = {}
  self:_CacheHighBuildingRenderer()
end

function SeasonSceneLayerFogMask:Dispose()
  SeasonSceneLayerFogMask.super.Dispose(self)
  if self._hideTask then
    GameGlobal.TaskManager():KillTask(self._hideTask)
    self._hideTask = nil
  end
  table.clear(self._fogEffects)
  table.clear(self._fogMatObjects)
  table.clear(self._fogMatRenderers)
end

function SeasonSceneLayerFogMask:UnLock(zoneMask, zoneID2Animation)
  local unlockZoneIDs = SeasonTool:GetInstance():GetZonesByZoneMask(zoneMask)
  for zoneid, effects in pairs(self._fogEffects) do
    if zoneid ~= zoneID2Animation then
      for key, effect in pairs(effects) do
        effect:SetActive(not table.icontains(unlockZoneIDs, zoneid))
      end
    end
  end
  for zoneid, zoneRenderers in pairs(self._renderers) do
    local alpha = 1
    if table.icontains(unlockZoneIDs, zoneid) then
      alpha = 0
    end
    for key, renderer in pairs(zoneRenderers) do
      if zoneid == zoneID2Animation then
        if renderer.material then
          renderer.material:DOFloat(alpha, "AlphaValue", self._time)
        end
        self:HideEffect(zoneid)
      elseif renderer.material then
        renderer.material:SetFloat("AlphaValue", alpha)
      end
    end
  end
  for _, go in pairs(self._fogMatObjects) do
    go:SetActive(true)
  end
  if self._fogMatRenderers and 0 < #self._fogMatRenderers then
    local vec4 = Vector4(0, 1, 1, 1)
    for _, zone in pairs(unlockZoneIDs) do
      if zone == 2 then
        vec4.y = 0
      elseif zone == 3 then
        vec4.z = 0
      elseif zone == 4 then
        vec4.w = 0
      end
    end
    for _, renderer in pairs(self._fogMatRenderers) do
      if renderer.material then
        renderer.material:SetVector("_AreaUnlockMask", vec4)
      end
    end
  end
end

function SeasonSceneLayerFogMask:_CacheHighBuildingRenderer()
  if self._fogMaskLayer then
    local zoneCount = self._fogMaskLayer.childCount
    if 0 < zoneCount then
      for i = 0, zoneCount - 1 do
        local zone = self._fogMaskLayer:GetChild(i)
        if zone then
          local zoneid = i + 1
          local childCount = zone.childCount
          for j = 0, childCount - 1 do
            local fogMask = zone:GetChild(j)
            if not self._fogEffects[zoneid] then
              self._fogEffects[zoneid] = {}
            end
            table.insert(self._fogEffects[zoneid], fogMask.gameObject)
            local renderers = fogMask.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
            if 0 < renderers.Length then
              for k = 0, renderers.Length - 1 do
                self:InsertMeshRender(zoneid, renderers[k])
              end
            end
            local gcount = fogMask.childCount
            for k = 0, gcount - 1 do
              local dump = fogMask:GetChild(k)
              if string.find(dump.name, self._fogMatCtrFlog) then
                self:_InsertMagFog(fogMask)
                break
              end
            end
          end
        end
      end
    end
  end
end

function SeasonSceneLayerFogMask:_InsertMagFog(trans)
  table.insert(self._fogMatObjects, trans.gameObject)
  local renderers = trans.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
  if renderers.Length > 0 then
    for k = 0, renderers.Length - 1 do
      table.insert(self._fogMatRenderers, renderers[k])
    end
  end
end

function SeasonSceneLayerFogMask:HideEffect(zoneid)
  self._hideTask = GameGlobal.TaskManager():StartTask(function(TT)
    YIELD(TT, self._time * 1000)
    local effects = self._fogEffects[zoneid]
    if effects then
      for _, effect in pairs(effects) do
        effect:SetActive(false)
      end
    end
  end)
end
