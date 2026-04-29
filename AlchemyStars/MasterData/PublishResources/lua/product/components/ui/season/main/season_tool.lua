_class("SeasonTool", Singleton)
SeasonTool = SeasonTool

function SeasonTool:Constructor()
  self._id_position = UnityEngine.Shader.PropertyToID("_PlaneShadowPosition")
  self._id_normal = UnityEngine.Shader.PropertyToID("_PlaneShadowNormal")
end

function SeasonTool:GetV4ByZoneMask(zoneMask, zoneID2Animation)
  if not zoneMask then
    return Vector4.zero
  end
  local seasonID = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local v4 = Vector4(zoneMask & 1, zoneMask >> 1 & 1, zoneMask >> 2 & 1, zoneMask >> 3 & 1)
  if seasonID == UISeasonID.S1 then
    v4 = Vector4(zoneMask >> 2 & 1, zoneMask & 1, zoneMask >> 1 & 1, 0)
  end
  if zoneID2Animation then
    if seasonID == UISeasonID.S1 then
      if zoneID2Animation == SeasonZone.One then
        v4.y = 0
      elseif zoneID2Animation == SeasonZone.Two then
        v4.z = 0
      elseif zoneID2Animation == SeasonZone.Three then
        v4.x = 0
      end
    elseif zoneID2Animation == SeasonZone.One then
      v4.x = 0
    elseif zoneID2Animation == SeasonZone.Two then
      v4.y = 0
    elseif zoneID2Animation == SeasonZone.Three then
      v4.z = 0
    elseif zoneID2Animation == SeasonZone.Four then
      v4.w = 0
    end
  end
  return v4
end

function SeasonTool:GetZonesByZoneMask(zoneMask)
  local zone = {}
  if zoneMask & 1 == 1 then
    table.insert(zone, SeasonZone.One)
  end
  if zoneMask >> 1 & 1 == 1 then
    table.insert(zone, SeasonZone.Two)
  end
  if zoneMask >> 2 & 1 == 1 then
    table.insert(zone, SeasonZone.Three)
  end
  if zoneMask >> 3 & 1 == 1 then
    table.insert(zone, SeasonZone.Four)
  end
  return zone
end

function SeasonTool:SetMaterialProperty(shadowPlane, renderers, materialPropertyBlock)
  if shadowPlane ~= nil and materialPropertyBlock then
    local v4_position = Vector4(shadowPlane.position.x, shadowPlane.position.y, shadowPlane.position.z, 0)
    local v4_normal = Vector4(shadowPlane.up.normalized.x, shadowPlane.up.normalized.y, shadowPlane.up.normalized.z, 0)
    if 0 < renderers.Length then
      for i = 0, renderers.Length - 1 do
        local render = renderers[i]
        if 0 < render.materials.Length then
          for j = 0, render.materials.Length - 1 do
            materialPropertyBlock:Clear()
            render:GetPropertyBlock(materialPropertyBlock, j)
            materialPropertyBlock:SetVector(self._id_position, v4_position)
            materialPropertyBlock:SetVector(self._id_normal, v4_normal)
            render:SetPropertyBlock(materialPropertyBlock, j)
          end
        end
      end
    end
  end
end

function SeasonTool:DisenableMeshRender(gameObject)
  if gameObject then
    local shadowRenderers = gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
    if shadowRenderers.Length > 0 then
      for i = 0, shadowRenderers.Length - 1 do
        local render = shadowRenderers[i]
        render.enabled = false
      end
    end
  end
end

function SeasonTool:GetProgressByExpressType(cfg, expressType)
  local function check(expresses)
    if expresses then
      for _, id in pairs(expresses) do
        local cfgExpress = Cfg.cfg_season_map_express[id]
        
        if cfgExpress and cfgExpress.ExpressType == expressType then
          return true
        end
      end
    end
    return false
  end
  
  local result
  for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
    local expressCfg = cfg["Express" .. progress]
    if check(expressCfg) then
      if not result then
        result = progress
      elseif progress < result then
        result = progress
      end
    end
  end
  return result
end

function SeasonTool:SetLocalDBFloat(key, value)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if campaignModule and not campaignModule:IsDisposed() then
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    if seasonModule:IsOpen() then
      local pstid = GameGlobal.GetModule(LoginModule):GetRoleShowID()
      LocalDB.SetFloat(pstid .. seasonModule:GetCurSeasonID() .. key, value)
    end
  end
end

function SeasonTool:GetLocalDBFloat(key, defaultValue)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  if campaignModule and not campaignModule:IsDisposed() then
    local seasonModule = GameGlobal.GetModule(SeasonModule)
    if seasonModule:IsOpen() then
      local pstid = GameGlobal.GetModule(LoginModule):GetRoleShowID()
      return LocalDB.GetFloat(pstid .. seasonModule:GetCurSeasonID() .. key, defaultValue)
    end
  end
  return defaultValue
end

function SeasonTool:TryAddCover(parent, cover)
  if parent and cover then
    local coverManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonCoverManager()
    local rawName = string.sub(cover.name, 1, string.len(cover.name) - string.len(coverManager:CoverFlag()))
    if rawName then
      if parent.name == rawName then
        coverManager:AddCover(parent, cover)
      else
        local rawTransform = parent:Find(rawName)
        if rawTransform then
          coverManager:AddCover(rawTransform, cover)
        else
          Log.warn("SeasonTool TryAddCover error.", cover.name)
        end
      end
    end
  end
end

function SeasonTool:TryClearCover(parent, cover)
  if parent and cover then
    local coverManager = GameGlobal.GetUIModule(SeasonModule):SeasonManager():SeasonCoverManager()
    local rawName = string.sub(cover.name, 1, string.len(cover.name) - string.len(coverManager:CoverFlag()))
    if rawName then
      if parent.name == rawName then
        coverManager:ClearCover(parent)
      else
        local rawTransform = parent:Find(rawName)
        if rawTransform then
          coverManager:ClearCover(rawTransform)
          coverManager:AddCover(rawTransform, cover)
        end
      end
    end
  end
end

function SeasonTool:IsLastProgress(cfg, targetProgress)
  local lastProgress = SeasonEventPointProgress.SEPP_Begin
  for progress = SeasonEventPointProgress.SEPP_Begin + 1, SeasonEventPointProgress.SEPP_End - 1 do
    local express = cfg["Express" .. progress]
    if express and progress >= lastProgress then
      lastProgress = progress
    end
  end
  return targetProgress == lastProgress
end
