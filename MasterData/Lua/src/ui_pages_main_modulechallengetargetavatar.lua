local this = class("moduleChallengeTargetAvatar", G_UIModuleBase)

function this.bind()
  return {
    avatarActive = false,
    avatarPath = nil,
    fill_num = 0,
    avatarPos = C_Vector3(0, 0, 0),
    indicatorAngle = C_Vector3(0, 0, 0)
  }
end

function this.methods()
  return {}
end

function this:open()
  self.judgeWidth = C_Screen.width * 0.65 / 2
  self.judgeHeight = C_Screen.height * 0.8 / 2
end

function this:close()
end

function this:refreshContent(targetPos, avatarPath, fillNum)
  local mainCamera = C_CameraManager.mainCamera
  if not self:judgeIsOutScreen(mainCamera:WorldToScreenPoint(targetPos)) then
    self.bind.avatarActive = false
    return
  end
  self.bind.avatarActive = true
  local trans = mainCamera.transform
  local forward = trans.forward
  local dir = Unity.Vector3.ProjectOnPlane(targetPos - mainCamera.transform.position, forward)
  local targetAngle = Unity.Vector3.SignedAngle(trans.up, dir, forward)
  self.bind.avatarPos = C_Vector3(self.judgeWidth * math.sin(math.rad(targetAngle)) * -1, self.judgeHeight * math.cos(math.rad(targetAngle)), 0)
  self.bind.indicatorAngle = C_Vector3(0, 0, targetAngle)
end

function this:judgeIsOutScreen(screenPoint)
  return screenPoint.x > C_Screen.width or screenPoint.x < 0 or screenPoint.y > C_Screen.height or 0 > screenPoint.y
end

return this
