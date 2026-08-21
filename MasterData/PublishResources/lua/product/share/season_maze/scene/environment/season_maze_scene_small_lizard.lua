_class("SeasonMazeSceneSmallLizard", SeasonMazeSceneEnvironmentBase)
SeasonMazeSceneSmallLizard = SeasonMazeSceneSmallLizard

function SeasonMazeSceneSmallLizard:Constructor(sceneRoot, param)
  self._transform = sceneRoot.transform:Find(SeasonSceneLayer.Building .. "/zone1/S1_pfb_xiaoxiyi_line" .. param[1])
  if not self._transform then
    Log.error("SeasonMazeSceneSmallLizard S1_pfb_xiaoxiyi_line1 not exist.")
    return
  end
  self._gameObject = self._transform.gameObject
  self._dummyTransform = self._transform:Find("Dummy001")
  self:_AddShadow()
end

function SeasonMazeSceneSmallLizard:Update(deltaTime)
  if not APPVER_EXPLORE and self._shadowPlane and self._renderers and self._materialPropertyBlock then
    SeasonMazeTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  end
end

function SeasonMazeSceneSmallLizard:Dispose()
  if self._shadowReq then
    self._shadowReq:Dispose()
    self._shadowReq = nil
  end
  self._materialPropertyBlock = nil
  self._renderers = nil
end

function SeasonMazeSceneSmallLizard:_AddShadow()
  self._shadowReq = ResourceManager:GetInstance():SyncLoadAsset("SCShadowPlane.prefab", LoadType.GameObject)
  if not self._shadowReq then
    Log.error("SeasonMazeSceneSmallLizard add shadow fail. SCShadowPlane.prefab load fail.")
    return
  end
  local shadowGO = self._shadowReq.Obj
  self._shadowPlane = shadowGO.transform
  self._shadowPlane.parent = self._dummyTransform
  self._shadowPlane.localPosition = Vector3.zero
  self._shadowPlane.localEulerAngles = Vector3.zero
  self._shadowPlane.localScale = Vector3.one
  if APPVER_EXPLORE then
    local planeShadowComponent = self._transform.gameObject:AddComponent(typeof(PlaneShadowComponent))
    planeShadowComponent.shadowPlane = self._shadowPlane
    planeShadowComponent.maxDistanceToMainCamera = 50
  end
  SeasonMazeTool:GetInstance():DisenableMeshRender(shadowGO)
  self._materialPropertyBlock = UnityEngine.MaterialPropertyBlock:New()
  self._renderers = self._gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))
  SeasonMazeTool:GetInstance():SetMaterialProperty(self._shadowPlane, self._renderers, self._materialPropertyBlock)
  shadowGO:SetActive(true)
end
