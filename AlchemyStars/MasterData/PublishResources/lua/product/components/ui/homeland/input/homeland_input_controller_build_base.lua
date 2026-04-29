_class("HomelandInputControllerBuildBase", Object)
HomelandInputControllerBuildBase = HomelandInputControllerBuildBase

function HomelandInputControllerBuildBase:Constructor()
  self._curBuildingInfo = nil
  self._touchBuilding = false
  self._speedMin = BuildConfig.Camera.SpeedMin
  self._speedMax = BuildConfig.Camera.SpeedMax
  self._dragInBuildingID = nil
  self._moveLimitCircleCenter = BuildConfig.MaxCircle.Center
  self._moveLimitCircleRadiusSqr = BuildConfig.MaxCircle.Radius * BuildConfig.MaxCircle.Radius
end

function HomelandInputControllerBuildBase:Init(mainCharacterController, globalCameraController)
  self._mainCharacterController = mainCharacterController
  self._globalCameraController = globalCameraController
end

function HomelandInputControllerBuildBase:Dispose()
end

function HomelandInputControllerBuildBase:Update(deltaTimeMS)
end

function HomelandInputControllerBuildBase:HandleMove(moveVec)
end

function HomelandInputControllerBuildBase:HandleRotate(rotateVec)
end

function HomelandInputControllerBuildBase:HandleScale(scale)
end

function HomelandInputControllerBuildBase:Enter()
  local guideModule = GameGlobal.GetModule(GuideModule)
  if guideModule:IsGuideProcessKey("guide_dormitory_edit") then
    local cfg = Cfg.cfg_guide_const.guide_dormitory_edit
    local guides = guideModule:GetCurGuides()
    if guides then
      for _, guide in pairs(guides) do
        if guide.data.id == cfg.IntValue then
          local curStep = guide:GetCurStep()
          if curStep and curStep.show and curStep.data and curStep.data.guideType == GuideType.OperationFinish then
            local param = curStep:GetGuideParams()
            self._globalCameraController:UpdatePos(Vector3(param[1], 0, param[2]))
            self._globalCameraController:ForceSetRotation(param[3], param[4])
            GameGlobal.EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.OperationFinish)
            return
          end
        end
      end
    end
  end
  local checkValid = true
  self._globalCameraController:UpdatePos(self._mainCharacterController:Position(), checkValid)
end

function HomelandInputControllerBuildBase:HandleBuildAreaDown(pos)
end

function HomelandInputControllerBuildBase:HandleBuildAreaMove(pos)
end

function HomelandInputControllerBuildBase:HandleBuildAreaClick(pos)
end

function HomelandInputControllerBuildBase:TouchBuilding()
end

function HomelandInputControllerBuildBase:ReleaseTouch()
end

function HomelandInputControllerBuildBase:SetCurrentBuilding(info)
end

function HomelandInputControllerBuildBase:HandleDragIn(buildingID)
end

function HomelandInputControllerBuildBase:MoveDragInFinger(pos)
end

function HomelandInputControllerBuildBase:CheckAndLimitMovePos()
  local pos = self._globalCameraController:GetFocusPos()
  local pos2D = Vector2(pos.x, pos.z)
  local disSqr = (pos2D - self._moveLimitCircleCenter):SqrMagnitude()
  if disSqr > self._moveLimitCircleRadiusSqr then
    local lerpPos = Vector2.Lerp(self._moveLimitCircleCenter, pos2D, math.sqrt(self._moveLimitCircleRadiusSqr / disSqr))
    self._globalCameraController:UpdatePosXZ(lerpPos.x, lerpPos.y)
  end
end

function HomelandInputControllerBuildBase:_GetMoveSpeed()
  return self._speedMin + self._globalCameraController:ScalePercent() * (self._speedMax - self._speedMin)
end
