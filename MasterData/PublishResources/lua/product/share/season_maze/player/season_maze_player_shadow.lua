_class("SeasonMazePlayerShadow", Object)
SeasonMazePlayerShadow = SeasonMazePlayerShadow

function SeasonMazePlayerShadow:Constructor(parent, yOffset)
  self._parent = parent
  self:_LoadShadow(yOffset or 0)
end

function SeasonMazePlayerShadow:Update(deltaTime)
  self:UpdateMaterialProperty()
end

function SeasonMazePlayerShadow:Dispose()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  self._renderers = nil
  self._materialPropertyBlock = nil
end

function SeasonMazePlayerShadow:_LoadShadow(yOffset)
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset("SCShadowPlane.prefab", LoadType.GameObject)
  if not self._resRequest then
    Log.error("SeasonMazePlayerShadow add shadow fail. SCShadowPlane.prefab load fail.")
    return
  end
  self._shadowGO = self._resRequest.Obj
  self._shadowPlane = self._shadowGO.transform
  self._shadowPlane.parent = self._parent
  self._shadowGO.transform.localPosition = Vector3(0, yOffset, 0)
  self._shadowGO.transform.localRotation = Quaternion.Euler(0, 0, 0)
  if APPVER_EXPLORE then
    local planeShadowComponent = self._parent.gameObject:AddComponent(typeof(PlaneShadowComponent))
    planeShadowComponent.shadowPlane = self._shadowPlane
    planeShadowComponent.maxDistanceToMainCamera = 50
  end
  SeasonTool:GetInstance():DisenableMeshRender(self._shadowGO)
  self._materialPropertyBlock = UnityEngine.MaterialPropertyBlock:New()
  self._renderers = self._parent.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
  SeasonTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  self._shadowGO:SetActive(true)
  self:UpdateMaterialProperty()
end

function SeasonMazePlayerShadow:UpdateMaterialProperty()
  if not APPVER_EXPLORE and self._shadowPlane and self._renderers and self._materialPropertyBlock then
    SeasonTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  end
end
