local CameraManager, Super = System.NewClass("CameraManager", Manager)

function CameraManager:Awake()
  Super.Awake(self)
  self.uiCamera = nil
  self.refCount = 0
  self.isRepeate = false
  self.isOrthographic = false
end

function CameraManager:GetUICamera()
  if not self.uiCamera then
    self.uiCamera = CS.UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(CS.UnityEngine.Camera))
  end
  return self.uiCamera
end

function CameraManager:IsOrthographic()
  self:GetUICamera()
  return self.uiCamera.orthographic
end

function CameraManager:SetCameraChangeOnce(isRepeate, isOrthographic)
  self.isRepeate = isRepeate
  self.isOrthographic = isOrthographic
  if not self.refCount then
    self.refCount = 0
  end
  if isOrthographic then
    self.refCount = self.refCount + 1
  else
    self.refCount = self.refCount - 1
  end
  if not self.uiCamera then
    self:GetUICamera()
  end
  if self.uiCamera.orthographic == isOrthographic then
    return
  end
  self:SetCameraAndClickEffect(self.isOrthographic)
end

function CameraManager:SetUICameraModel(isOrthographic)
  if self.isRepeate then
    return
  end
  if not self.refCount then
    self.refCount = 0
  end
  if isOrthographic then
    self.refCount = self.refCount + 1
  else
    self.refCount = self.refCount - 1
  end
  local isChangeOrthographic = isOrthographic and 1 == self.refCount
  local isChangePerspective = not isOrthographic and 0 == self.refCount
  if isChangeOrthographic or isChangePerspective then
    self:SetCameraAndClickEffect(self.refCount > 0)
  end
end

function CameraManager:SetCameraAndClickEffect(isOrthographic)
  if not self.uiCamera then
    self:GetUICamera()
  end
  self.uiCamera.orthographic = isOrthographic
  local clickEffect = Main.Instance.coreContainer:GetComponent(ClickEffectComponent)
  if not clickEffect then
    return
  end
  if isOrthographic then
    clickEffect:ScaleDown()
  else
    clickEffect:RestoreScale()
  end
end

return CameraManager
