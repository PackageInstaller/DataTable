_class("UIHomelandBuildEditRotate", UIController)
UIHomelandBuildEditRotate = UIHomelandBuildEditRotate

function UIHomelandBuildEditRotate:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.rotateAngleStep = Cfg.cfg_global.ui_homeland_build_rotate_step.IntValue or 10
  self.quaternion = Quaternion.identity
  self.dishRect = Vector2(360, 210)
  self.offsetX = self.dishRect.x * 0.5
  self.offsetY = self.dishRect.y * 0.5
  self.offset = 50
  self.center = Vector2(UnityEngine.Screen.width * 0.5, UnityEngine.Screen.height * 0.5)
  self.showAnchorPositions = {
    Vector2(-self.offset - self.offsetX, -self.offset - self.offsetY),
    Vector2(self.offset + self.offsetX, -self.offset - self.offsetY),
    Vector2(self.offset + self.offsetX, self.offset + self.offsetY),
    Vector2(-self.offset - self.offsetX, self.offset + self.offsetY)
  }
end

function UIHomelandBuildEditRotate:OnShow(uiParams)
  self.circle = self:GetUIComponent("RectTransform", "circle")
  self.arrow = self:GetUIComponent("RectTransform", "arrow")
  self.txtDegree = self:GetUIComponent("UILocalizationText", "txtDegree")
  self.goCircle = self:GetGameObject("circle")
  local etl = UICustomUIEventListener.Get(self.goCircle)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    Log.debug("### BeginDrag")
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    self:Rotate()
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    Log.debug("### EndDrag")
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self:Rotate()
  end)
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  local angle = homeBuilding:RotY()
  self:FlushCirclePos()
  self:FlushArrow(angle)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeBuildRotateOpen, true)
end

function UIHomelandBuildEditRotate:OnHide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeBuildRotateOpen, false)
end

function UIHomelandBuildEditRotate:FlushCirclePos()
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  local pos = homeBuilding:Pos()
  local cameraController = self.homelandClient:CameraManager():GlobalCameraController()
  local camera = cameraController:CameraCmp()
  local posScreen = camera:WorldToScreenPoint(pos)
  local index = 0
  local isRight = posScreen.x > self.center.x
  local isUp = posScreen.y > self.center.y
  if isRight then
    if isUp then
      index = 1
    else
      index = 4
    end
  elseif isUp then
    index = 2
  else
    index = 3
  end
  self.circle.anchoredPosition = Vector2(self.circle.anchoredPosition.x + self.showAnchorPositions[index].x, self.circle.anchoredPosition.y + self.showAnchorPositions[index].y)
end

function UIHomelandBuildEditRotate:FlushArrow(angle)
  self.quaternion:SetEuler(0, 0, -angle)
  self.arrow.localRotation = self.quaternion
  self.txtDegree:SetText(StringTable.Get("str_homeland_build_degree", angle))
end

function UIHomelandBuildEditRotate:bgOnClick(go)
  self:CloseDialog()
end

function UIHomelandBuildEditRotate:Rotate()
  local angle = self:CalcAngle()
  angle = self:FormatAngle(angle)
  self:FlushArrow(angle)
  self.homeBuildManager:Rotate(angle)
end

function UIHomelandBuildEditRotate:CalcAngle()
  local mousePosition = UnityEngine.Input.mousePosition
  local screenPos = Vector2(mousePosition.x, mousePosition.y)
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local pos = UIHelper.ScreenPointToWorldPointInRectangle(self.circle.parent, screenPos, camera)
  local posCircle = self.circle.position
  local v3 = pos - posCircle
  local angle = Vector2.Angle(Vector2.up, Vector2(v3.x, v3.y))
  if v3.x < 0 then
    angle = 360 - angle
  end
  return angle
end

function UIHomelandBuildEditRotate:FormatAngle(angle)
  local div = math.floor((angle + self.rotateAngleStep * 0.5) / self.rotateAngleStep) * self.rotateAngleStep
  return div
end
