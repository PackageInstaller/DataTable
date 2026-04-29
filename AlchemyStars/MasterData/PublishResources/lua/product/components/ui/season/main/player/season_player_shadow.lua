_class("SeasonPlayerShadow", Object)
SeasonPlayerShadow = SeasonPlayerShadow

function SeasonPlayerShadow:Constructor(model)
  self._model = model
  self:_LoadShadow()
end

function SeasonPlayerShadow:Update(deltaTime)
  self:UpdateMaterialProperty()
end

function SeasonPlayerShadow:Dispose()
  if self._resRequest then
    self._resRequest:Dispose()
    self._resRequest = nil
  end
  self._renderers = nil
  self._materialPropertyBlock = nil
end

function SeasonPlayerShadow:_LoadShadow()
  self._resRequest = ResourceManager:GetInstance():SyncLoadAsset("SCShadowPlane.prefab", LoadType.GameObject)
  if not self._resRequest then
    Log.error("SeasonPlayerShadow add shadow fail. SCShadowPlane.prefab load fail.")
    return
  end
  self._shadowGO = self._resRequest.Obj
  self._shadowPlane = self._shadowGO.transform
  self._shadowPlane.parent = self._model:RootTransform()
  self._shadowGO.transform.localPosition = Vector3.zero
  self._shadowGO.transform.localRotation = Quaternion.Euler(0, 0, 0)
  if APPVER_EXPLORE then
    local planeShadowComponent = self._model:RootTransform().gameObject:AddComponent(typeof(PlaneShadowComponent))
    planeShadowComponent.shadowPlane = self._shadowPlane
    planeShadowComponent.maxDistanceToMainCamera = 50
  end
  SeasonTool:GetInstance():DisenableMeshRender(self._shadowGO)
  self._materialPropertyBlock = UnityEngine.MaterialPropertyBlock:New()
  self._renderers = self._model:RootTransform().gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
  SeasonTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  self._shadowGO:SetActive(true)
  self:UpdateMaterialProperty()
end

function SeasonPlayerShadow:UpdateMaterialProperty()
  if not APPVER_EXPLORE and self._shadowPlane and self._renderers and self._materialPropertyBlock then
    SeasonTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  end
end
