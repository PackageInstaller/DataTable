local this = class("pagePhotographScene", G_UIPageBase)
local targetBgSize = {widthLen = 265.5, heightLen = 187}

function this.bind()
  return {
    main = true,
    targetAniActive = false,
    indicatorActive = false,
    indicatorAngle = C_Vector3(0, 0, 180),
    searchActive = false,
    txt_forbidden = ""
  }
end

function this.methods()
  return {}
end

function this:check(options, callback)
  local result = true
  callback(result)
end

function this:preOpen(options)
  if options then
    self.photographCallback = options.callback
    self.targetEntityId = options.targetEntityId
    self.targetRange = options.targetRange
    self.npcId = options.npcId
    self.oriPos = options.oriPos
    self.targetPos = options.targetPos
  end
  L_UI:addListener(L_UI.pageEvent.closed, self.onEvent_hidePage, self)
  C_PlayerUnitHelper.SetPetEntityVisible(false)
  C_PlayerUnitHelper.SetHeroEntityVisibleRender(false)
  AzurWorld.visbleMgr:SetEntityVisibleForLuaPhotograph(false, AzurWorld.playerMgr.myPlayerData.mountData.mountEntityId)
  C_CameraManager.isNeedShowFace = false
end

function this:show(options)
  this.super.show(self, options)
end

function this:update()
  self:updateTargetTip()
end

function this:close(options)
  this.super.close(self, options)
  L_UI:removeListener(L_UI.pageEvent.closed, self.onEvent_hidePage)
  if self.targetIsInRangeTimer then
    Timer.remove(self.targetIsInRangeTimer)
  end
  C_PlayerUnitHelper.SetPetEntityVisible(true)
  C_PlayerUnitHelper.SetHeroEntityVisibleRender(true)
  AzurWorld.visbleMgr:SetEntityVisibleForLuaPhotograph(true, AzurWorld.playerMgr.myPlayerData.mountData.mountEntityId)
  AzurWorld.TaskMgr:GetTaskUIModule():RemovePhotographFinish()
  self.targetIsInRangeTimer = nil
  self.targetIsInRange = false
  C_CameraManager.isNeedShowFace = true
end

function this:onEvent_hidePage(pageName)
  if pageName == "pagePhoto" and L_UI:getPage("pagePhotographScene") ~= nil then
    L_UI:close("pagePhotographScene")
  end
end

function this:getSearchTargetStates()
  local curPos = self:getCameraPos()
  if curPos == nil then
    return
  end
  local camera = C_CameraManager.mainCamera
  local view = camera:WorldToScreenPoint(self.targetPos)
  local mainCamera = C_CameraManager.mainCamera
  local trans = mainCamera.transform
  local forward = trans.forward
  local dir = Unity.Vector3.ProjectOnPlane(self.targetPos - curPos, forward)
  local targetAngle = Unity.Vector3.SignedAngle(trans.up, dir, forward)
  self.bind.indicatorAngle = C_Vector3(0, 0, targetAngle)
  local targetDir = self.targetPos - curPos
  local dirDot = L_Vector3.dot(targetDir, forward)
  local angle = C_Vector3.Angle(forward, targetDir)
  local distance = L_Vector3.distance(L_PlayerManager:getMainControlEntityPos(), self.oriPos)
  local maxAngle = C_TaskHelper.GetPhotoAngle(self.targetEntityId)
  local isInTarget = angle < maxAngle
  local isBlocked = false
  if isInTarget then
    isBlocked = C_TaskHelper.RaycastCamera2Target(self.targetPos, self.targetEntityId)
  end
  local isOutOfRange = distance > self.targetRange
  return isInTarget, dirDot, isOutOfRange, isBlocked
end

function this:updateTargetTip()
  local curPos = self:getCameraPos()
  if curPos == nil then
    return
  end
  local needUpdate = false
  local mainCamera = C_CameraManager.mainCamera
  local curRot = mainCamera.transform.rotation.eulerAngles
  if not self.lastUpdatCamPos or (self.lastUpdatCamPos - curPos).magnitude > 0.1 then
    needUpdate = true
    print("[任务拍照]位置差大于0.1,update!")
  end
  if not needUpdate and (not self.lastUpdatCamRot or 0.1 < (self.lastUpdatCamRot - curRot).magnitude) then
    needUpdate = true
    print("[任务拍照]角度差大于0.1,update!")
  end
  if not needUpdate then
    if self.updateTargetTimer == nil then
      print("[任务拍照]无上次计时,update!")
      needUpdate = true
    else
      self.updateTargetTimer = self.updateTargetTimer - C_Time.deltaTime
      if self.updateTargetTimer <= 0 then
        needUpdate = true
        print("[任务拍照]计时归零,update!")
      end
    end
  end
  if needUpdate then
    self.updateTargetTimer = 0.5
    self.lastUpdatCamPos = curPos
    self.lastUpdatCamRot = curRot
  else
    return
  end
  local isInTarget, dirDot, isOutOfRange, isBlocked = self:getSearchTargetStates()
  if isInTarget == nil then
    return
  end
  local isValid = isInTarget and not isBlocked
  if self.photographCallback then
    self.photographCallback(isValid)
  end
  self.bind.indicatorActive = not isValid and not isBlocked
  self.bind.searchActive = isValid
  self.bind.targetAniActive = isValid
  if isInTarget and isBlocked then
    self.bind.txt_outRange = L_WordsTpl:getValue("ui_photograph_lens_blocked")
  else
    self.bind.txt_outRange = L_WordsTpl:getValue("ui_photograph_out_range")
  end
  if isValid then
    self.bind.txt_forbidden = L_WordsTpl:getValue("ui_photograph_forbidden")
  end
  if isOutOfRange and L_UI:getPage("pagePhoto") ~= nil then
    L_UI:close("pagePhoto")
  end
end

function this:playTargetinRangeAni()
  if self.targetIsInRangeTimer then
    return
  end
  self.bind.go_targetInRange = true
  self.bindComponents.targetAni:Play()
  local clip = self.bindComponents.targetAni.clip
  local time = clip.length
  self.targetIsInRangeTimer = Timer.once(time, self.onTargetAniFinish, self)
end

function this:onTargetAniFinish()
  self.bind.go_targetInRange = false
  self.targetIsInRangeTimer = nil
end

function this:getCameraPos()
  local camera = C_CameraManager.mainCamera
  if camera == nil then
    return
  end
  local pos = camera.transform.position
  return pos
end

return this
