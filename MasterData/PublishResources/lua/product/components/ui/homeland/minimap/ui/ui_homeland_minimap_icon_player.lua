_class("UIHomelandMinimapIconPlayer", UIHomelandMinimapIconBase)
UIHomelandMinimapIconPlayer = UIHomelandMinimapIconPlayer

function UIHomelandMinimapIconPlayer:OnShow()
  self:AttachEvent(GameEventType.MinimapSwitch, self.OnMinimapSwitch)
  self._area = self:GetGameObject("Area")
  self._view = self:GetUIComponent("Transform", "View")
  local homeLandModule = GameGlobal.GetUIModule(HomelandModule)
  local homelandClient = homeLandModule:GetClient()
  local cameraMgr = homelandClient:CameraManager()
  self._followCameraController = cameraMgr:FollowCameraController()
end

function UIHomelandMinimapIconPlayer:OnHide()
  self:DetachEvent(GameEventType.MinimapSwitch, self.OnMinimapSwitch)
end

function UIHomelandMinimapIconPlayer:OnInitDone(minimapStatus)
  self:OnMinimapSwitch(minimapStatus)
end

function UIHomelandMinimapIconPlayer:OnMinimapSwitch(status)
  if status == MinimapStatus.Mini then
    self._area:SetActive(true)
  else
    self._area:SetActive(false)
  end
end

function UIHomelandMinimapIconPlayer:UpdateArrow(status)
  if status == MinimapStatus.Mini then
    local rotation = self._followCameraController:Rotation()
    local angle = rotation.eulerAngles
    self._view.eulerAngles = Vector3(0, 0, -angle.y + 180)
  end
end

function UIHomelandMinimapIconPlayer:GetAnimationName(animType)
  if not self._animationNames then
    self._animationNames = {}
    self._animationNames[MinimapIconAnimationType.IN] = "UIHomelandMinimapPlayerIcon_in"
    self._animationNames[MinimapIconAnimationType.OUT] = "UIHomelandMinimapPlayerIcon_out"
  end
  return self._animationNames[animType]
end
