local this = class("pagePhotographPlayable", G_UIPageBase)
local IsDragging = false

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {angle = 0}
end

function this.bind()
  return {
    main = true,
    goWhiteCut = false,
    photo = false,
    playerInfo = true,
    playerId = "",
    playerName = "",
    txt_inRangeTip = "",
    txt_outRangeTip = "",
    dim = false,
    targetSearchTipNode = false,
    targetAniActive = false,
    searchActive = false,
    joystickCamera = true,
    moduleCommonTop = {
      moduleName = "modulePages/moduleCommonTop"
    },
    txt_mul = "1x",
    txt_focal = "26mm",
    txt_focal_active = false,
    txt_title = L_WordsTpl:getValue("residual_code_pagephotographplayable_01"),
    txt_left_mm = true,
    txt_mid_mm = true,
    txt_right_mm = true
  }
end

function this.methods()
  return {
    onClick_screenCapture = function(self)
      self.bind.goWhiteCut = true
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Take")
      L_PhotoManager:capture(function(t2d)
        local t2 = {rt = t2d, isPhotoTask = true}
        L_UI:open("pagePhotoPreview", t2, function()
          self.bind.goWhiteCut = false
          if self.isInTarget then
            self.isRecord = true
            local args = CS.Lens.Gameplay.Modules.BigWorld.CommonIntDriveArgs()
            args.intVal = 1
            C_DriveManager.DispatchDrive(C_EExternalDrive.ProtoPlayableEnd, args)
            L_UI:close(self.pageName)
          end
        end)
        local sceneId = AzurWorldInstance.CurWorldId
        local worldAreaId = AzurWorld.areaManager:GetMapAreaId()
        L_AchievementUtil.req_clientBehaviourRecord(L_Const.commonCondition.RegionPhotoTimes, {
          sceneId,
          worldAreaId,
          1
        }, function()
        end)
      end)
    end,
    onClick_closePhoto = function(self)
    end,
    onClick_savePhoto = function(self)
    end,
    onClick_preBtn = function(self)
      self:setPreCameraPos()
    end,
    onClick_nextBtn = function(self)
      self:setNextCameraPos()
    end,
    onValuedChanged_slider = function(self)
      self:onValuedChangedSlider()
    end,
    onBeginDrag_slider = function(self)
      IsDragging = true
    end,
    onEndDrag_slider = function(self)
      IsDragging = false
    end
  }
end

function this:fadeIn()
  local data = {
    coverdTime = 0.9,
    fadeOut = true,
    fadeIn = false,
    isCompleteClose = true
  }
  L_GameUtil.openMask(data)
end

function this:check(options, callback)
  if L_BattleDataManager:checkPlayerBattle() then
    L_FlyMsgManager:showNormalMsg(L_BattleDataManager:getBattleBlockTips(L_Const.BattleBlockType.PhotographEntrance))
    callback(false)
    return
  end
  local result = true
  if result then
    result = not L_BattleStore:getIsInBattle() and L_PhotoManager:getMainControlIsFree() and not L_PlayerStore:getIsNewPlayer()
    if not result then
      L_FlyMsgManager:showNormalMsgByKey("notice_pagePhoto_04")
    end
  end
  if result then
    self:fadeIn()
  end
  callback(result)
end

function this:preOpen(options)
  self.cameraRotateSpeed = 4
  self.cameraMoveSpeed = 0.1
  self.pinchSpeedPc = 0.8
  self.pinchSpeedMobile = 0.055
  self.isPc = L_DeviceTpl:getIsPc()
  self.showPlayerInfo = true
  self.bind.playerId = tostring(L_PlayerStore:getPlayerId())
  self.bind.playerName = L_PlayerStore:getPlayerName()
  C_CameraManager.ActivateTactics(C_ECameraType.Photo, C_CinemachineBlendType.EaseInOut, 1000)
  L_PlayerManager:stopIdleAnim()
  self.playableObjectList = nil
  self.playableObjectIndex = 1
  self.cameraAngleList = nil
  if options then
    self.bind.txt_inRangeTip = L_WordsTpl:getTplById(options.keyInRange)
    self.bind.txt_outRangeTip = L_WordsTpl:getTplById(options.keyOutRange)
    self.playableObjectList = options.playableObjectList
    self.cameraAngleList = options.cameraAngleList
    self.cameraOffsetList = options.cameraOffsetList
    self.cameraFovRangeList = options.cameraFovRangeList
    self.isSearchTarget = options.isSearchTarget
    self.targetPos = options.targetPos
    self.otherParams = options.otherParams
    self.targetGo = options.targetGo
    self.keyTitle = options.keyTitle
    self.cameraRotateSpeed = options.cameraRotateSpeed
    self.cameraMoveSpeed = options.cameraMoveSpeed
    if self.isSearchTarget then
      self.bind.targetSearchTipNode = self.isSearchTarget
    end
    if self.otherParams[4] then
      self.cameraRotateSpeed = self.otherParams[4]
    end
    if self.otherParams[5] then
      self.cameraMoveSpeed = self.otherParams[5]
    end
  end
  self:updateCameraPos()
  self:bindScreenTouch("+")
  AzurWorld.HomeMgr:LockAllEffect(true)
  local data = {
    name = L_GameTpl:getWordsTpl():getTplById(self.keyTitle or "notice_umi_lookingfor_02"),
    helpBtnBool = false,
    mainBtnBool = false,
    closeCurPage = function()
      L_UI:close(self.pageName)
    end,
    helpBtn = function()
    end,
    mainBtn = function()
      L_UI:backToRoot()
    end
  }
  self.modules.moduleCommonTop:initModule(data)
  local page = C_UIMgr.GetPage(self.pageName)
  if page and C_InputManager_MapType and C_InputManager_MapType.PagePhotoTask then
    page.overrideInputMap = C_InputManager_MapType.PagePhotoTask
  end
end

function this:open(options)
  this.super.open(self, options)
  self._mouseScrollWheelHandle = handler(self, self.onListen_mouseScrollWheel)
  if L_DeviceTpl:getIsPc() then
    C_InputManager.AddSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  end
end

function this:escHandle()
  L_UI:close(self.pageName)
end

function this:close(options)
  this.super.close(self, options)
  L_PhotoManager:releasePendingCaptureRTs()
  self:unbindCameraJoystick()
  if self.cameraJoystickTimer then
    Timer.remove(self.cameraJoystickTimer)
  end
  self:DisableCurVirCam()
  self.virtualCamera = nil
  self.photographCamera = nil
  AzurWorld.HomeMgr:LockAllEffect(false)
  self:bindScreenTouch("-")
  C_CameraManager.DeactivateTactics(C_ECameraType.Photo)
  L_PlayerManager:initIdleAnim()
  if not self.isRecord then
    local args = CS.Lens.Gameplay.Modules.BigWorld.CommonIntDriveArgs()
    args.intVal = 2
    C_DriveManager.DispatchDrive(C_EExternalDrive.ProtoPlayableEnd, args)
  end
  self.isRecord = false
  C_InputManager.RemoveSingleAxisListener(C_InputManager.EInputSingleAxisType.EMainMouseScroll, self._mouseScrollWheelHandle)
  self._mouseScrollWheelHandle = nil
end

function this:show(options)
  this.super.show(self, options)
  self.oldJoyStick = L_GameUtil.getJoyStick()
  self:bindCameraJoystick()
end

function this:onListen_mouseScrollWheel(dv)
  local slider = self.bindComponents.sliderFov
  slider.value = slider.value - dv / 2 / 1200
end

function this:onCameraJoystickDragStart()
  if not self.cameraJoystickTimer then
    self.cameraJoystickTimer = Timer.repeated(0, function()
      local joystick = self.bindComponents.joystickCamera
      self:moveCamera(-joystick.Horizontal * self.cameraMoveSpeed, joystick.Vertical * self.cameraMoveSpeed)
    end)
  else
    self.cameraJoystickTimer:resume()
  end
end

function this:onCameraJoystickDragEnd()
  if self.cameraJoystickTimer then
    self.cameraJoystickTimer:pause()
  end
end

function this:moveCamera(x, y)
  print("moveCamera x：" .. x .. " y: " .. y)
  if self.virtualCamera and self.xNormalized and self.yNormalized then
    print("xOffset x：" .. self.xOffset .. " y: " .. self.yOffset)
    print("maxOffset x：" .. self.maxOffset .. " y: " .. self.maxOffset)
    print("xNormalized x：" .. self.xNormalized.x .. " y: " .. self.xNormalized.y .. " z: " .. self.xNormalized.z)
    self.xOffset = self.xOffset + x
    self.yOffset = self.yOffset + y
    if self.xOffset < -self.maxOffset then
      self.xOffset = -self.maxOffset
    end
    if self.xOffset > self.maxOffset then
      self.xOffset = self.maxOffset
    end
    if self.yOffset < -self.maxOffset then
      self.yOffset = -self.maxOffset
    end
    if self.yOffset > self.maxOffset then
      self.yOffset = self.maxOffset
    end
    local newPos = self.oriPos + L_Vector3.new(self.xOffset * self.xNormalized.x, self.xOffset * self.xNormalized.y, self.xOffset * self.xNormalized.z) + L_Vector3.new(self.yOffset * self.yNormalized.x, self.yOffset * self.yNormalized.y, self.yOffset * self.yNormalized.z)
    print("newPos x：" .. newPos.x .. " y: " .. newPos.y .. " z: " .. newPos.z)
    self.virtualCamera.transform.position = newPos
  end
end

function this:bindCameraJoystick()
  local joystick = self.bindComponents.joystickCamera
  joystick.onPointerDownHandler = L_CommonUtil.handle(self.onCameraJoystickDragStart, self)
  joystick.onPointerUpHandler = L_CommonUtil.handle(self.onCameraJoystickDragEnd, self)
end

function this:unbindCameraJoystick()
  local joystick = self.bindComponents.joystickCamera
  joystick.onPointerDownHandler = nil
  joystick.onPointerUpHandler = nil
end

function this:on_TouchPinch(gesture)
  local delta = math.clamp(gesture.deltaPinch, -1, 1)
  local normalizedValue = 0
  if self.isPc then
    normalizedValue = self.bindComponents.sliderFov.value - delta * self.pinchSpeedPc
  else
    normalizedValue = self.bindComponents.sliderFov.value - delta * self.pinchSpeedMobile
  end
  normalizedValue = math.clamp(normalizedValue, 0, 1)
  self.bindComponents.sliderFov.value = normalizedValue
end

function this:onValuedChangedSlider()
  if not IsDragging then
    self.bindComponents.sliderFov.value = self.bindComponents.sliderFov.value
  end
  local slider = self.bindComponents.sliderFov
  local lens = self.virtualCamera.m_Lens
  lens.FieldOfView = math.max(0, self.fovRange * ((0.5 - self:reverseScrollValue(self:calculateScrollValue(slider.value))) / 0.5) + self.oriFov)
  self.virtualCamera.m_Lens = lens
  local absSliderValue = self:reverseScrollValue(self:calculateScrollValue(slider.value))
  local zRotation = self:calculateCoronaRotation(absSliderValue)
  self.bindComponents.img_blur_trans.localRotation = zRotation
  local mulText = tostring(self:calculateMulNum(absSliderValue)) .. "x"
  self.bind.txt_mul = mulText
  local focalText = tostring(self:calculateFocalNum(absSliderValue)) .. "mm"
  self.bind.txt_focal = focalText
  self:calculateNumsScale()
  self:rotateGear(absSliderValue)
end

function this:calculateCoronaRotation(value)
  local oriRotation = 90
  local zEuler = 0
  local zRotationMin = -55.7
  local zRotationMax = 86.7
  value = math.max(0, math.min(1, value))
  if value <= 0.5 then
    zEuler = value * 111.4 - 55.7
  else
    zEuler = (value - 0.5) * 173.4
  end
  local zRotation = C_Quaternion.Euler(0, 0, zEuler + oriRotation)
  return zRotation
end

function this:rotateGear(value)
  local oriRotation = 0
  local littleGearNum = 16
  local bigGearNum = 24
  local zEuler = 0
  value = math.max(0, math.min(1, value))
  if value <= 0.5 then
    zEuler = (value - 0.5) / 0.5 * 720
  else
    zEuler = (0.5 - value) / 0.5 * -720
  end
  local bigRotation = C_Quaternion.Euler(0, 0, zEuler + oriRotation)
  local littleRotation = C_Quaternion.Euler(0, 0, -zEuler * littleGearNum / bigGearNum + oriRotation)
  self.bindComponents.img_1_little.localRotation = littleRotation
  self.bindComponents.img_2_big.localRotation = bigRotation
end

function this:calculateMulNum(value)
  local retNum = 1
  local oriNumMax = 3
  local oriNumMin = 0.5
  value = math.max(0, math.min(1, value))
  if value <= 0.5 then
    retNum = value * 1 + 0.5
  else
    retNum = (value - 0.5) * 4 + 1
  end
  retNum = math.floor(retNum * 10 + 0.5) / 10
  return retNum
end

function this:calculateFocalNum(value)
  local retNum = 26
  local oriNumMax = 13
  local oriNumMin = 77
  value = math.max(0, math.min(1, value))
  if value <= 0.5 then
    retNum = value * 26 + 13
  else
    retNum = (value - 0.5) * 102 + 26
  end
  retNum = math.floor(retNum + 0.5)
  return retNum
end

function this:calculateNumsScale()
  local oriPosition = self.bindComponents.txt_mul.position
  local leftPosition = self.bindComponents.txt_left.position
  local midPosition = self.bindComponents.txt_mid.position
  local rightPosition = self.bindComponents.txt_right.position
  if C_Vector3.Distance(oriPosition, leftPosition) <= 1 and C_Vector3.Distance(oriPosition, leftPosition) >= -1 then
    local scale = L_Vector3.new(math.abs(C_Vector3.Distance(oriPosition, leftPosition)) * 1, math.abs(C_Vector3.Distance(oriPosition, leftPosition)) * 1, 1)
    L_Vector3.setScale(self.bindComponents.txt_left, scale)
    if C_Vector3.Distance(oriPosition, leftPosition) <= 0.45 and C_Vector3.Distance(oriPosition, leftPosition) >= -0.45 then
      self.bind.txt_focal_active = true
      self.bind.txt_left_mm = false
      L_Vector3.setScale(self.bindComponents.txt_left, L_Vector3.zero)
    else
      self.bind.txt_focal_active = false
      self.bind.txt_left_mm = true
    end
  else
    self.bind.txt_left_mm = true
    L_Vector3.setScale(self.bindComponents.txt_left, L_Vector3.one)
  end
  if C_Vector3.Distance(oriPosition, midPosition) <= 1 and C_Vector3.Distance(oriPosition, midPosition) >= -1 then
    local scale = L_Vector3.new(math.abs(C_Vector3.Distance(oriPosition, midPosition)) * 1, math.abs(C_Vector3.Distance(oriPosition, midPosition)) * 1, 1)
    L_Vector3.setScale(self.bindComponents.txt_mid, scale)
    if C_Vector3.Distance(oriPosition, midPosition) <= 0.45 and C_Vector3.Distance(oriPosition, midPosition) >= -0.45 then
      self.bind.txt_focal_active = true
      self.bind.txt_mid_mm = false
      L_Vector3.setScale(self.bindComponents.txt_mid, L_Vector3.zero)
    else
      self.bind.txt_focal_active = false
      self.bind.txt_mid_mm = true
    end
  else
    self.bind.txt_mid_mm = true
    L_Vector3.setScale(self.bindComponents.txt_mid, L_Vector3.one)
  end
  if C_Vector3.Distance(oriPosition, rightPosition) <= 1 and C_Vector3.Distance(oriPosition, rightPosition) >= -1 then
    local scale = L_Vector3.new(math.abs(C_Vector3.Distance(oriPosition, rightPosition)) * 1, math.abs(C_Vector3.Distance(oriPosition, rightPosition)) * 1, 1)
    L_Vector3.setScale(self.bindComponents.txt_right, scale)
    if C_Vector3.Distance(oriPosition, rightPosition) <= 0.65 and C_Vector3.Distance(oriPosition, rightPosition) >= -0.65 then
      self.bind.txt_focal_active = true
      self.bind.txt_right_mm = false
      L_Vector3.setScale(self.bindComponents.txt_right, L_Vector3.zero)
    else
      self.bind.txt_focal_active = false
      self.bind.txt_right_mm = true
    end
  else
    self.bind.txt_right_mm = true
    L_Vector3.setScale(self.bindComponents.txt_right, L_Vector3.one)
  end
end

function this:reverseScrollValue(value)
  return 1 - value
end

function this:calculateScrollValue(value, k, m)
  k = k or 2.0
  m = m or 2.0
  value = math.max(0, math.min(1, value))
  if value <= 0.5 then
    return 2 * value ^ k
  else
    return 1 - 2 * (1 - value) ^ m
  end
end

function this:setPreCameraPos()
  if self.playableObjectList ~= nil then
    self:DisableCurVirCam()
    self.playableObjectIndex = self.playableObjectIndex - 1
    if self.playableObjectIndex <= 0 then
      self.playableObjectIndex = #self.playableObjectList
    end
    self.bind.txt_title = self.playableObjectIndex < 10 and L_WordsTpl:getValue("residual_code_pagephotographplayable_02") .. "0" .. tostring(self.playableObjectIndex) or L_WordsTpl:getValue("residual_code_pagephotographplayable_02") .. tostring(self.playableObjectIndex)
  end
  self:updateCameraPos()
end

function this:setNextCameraPos()
  if self.playableObjectList ~= nil then
    self:DisableCurVirCam()
    self.playableObjectIndex = self.playableObjectIndex + 1
    if self.playableObjectIndex > #self.playableObjectList then
      self.playableObjectIndex = 1
    end
    self.bind.txt_title = self.playableObjectIndex < 10 and L_WordsTpl:getValue("residual_code_pagephotographplayable_02") .. "0" .. tostring(self.playableObjectIndex) or L_WordsTpl:getValue("residual_code_pagephotographplayable_02") .. tostring(self.playableObjectIndex)
  end
  self:updateCameraPos()
end

function this:DisableCurVirCam()
  if self.virtualCamera then
    self.virtualCamera.enabled = false
    self.virtualCamera.transform.position = self.oriPos
    self.virtualCamera.transform.forward = self.oriForward
    local lens = self.virtualCamera.m_Lens
    lens.FieldOfView = self.oriFov
    self.virtualCamera.m_Lens = lens
    local slider = self.bindComponents.sliderFov
    slider.value = 0.5
  end
  self.xNormalized = nil
  self.zNormalized = nil
  self.oriPos = nil
  self.oriFov = nil
  self.fovRange = nil
  self.oriForward = nil
  self.maxOffset = nil
  self.xOffset = nil
  self.yOffset = nil
  self.cameraValid = nil
end

function this:updateCameraPos()
  self.virtualCamera = nil
  if self.playableObjectList == nil or self.playableObjectList[self.playableObjectIndex] == nil then
  else
    local playableUnitManager = AzurWorld.PlayableUnitMgr
    local playableObjectId = self.playableObjectList[self.playableObjectIndex]
    local playableObject = playableUnitManager.RuningPlayUnit:FindPlayableObject(playableObjectId)
    if playableObject then
      local trans = playableObject.entity:GetTransform()
      self.oriForward = trans.forward
      self.oriPos = trans.position
      self.virtualCamera = trans:GetComponent(typeof(C_CinemachineVirtualCamera))
      self.oriFov = self.virtualCamera.m_Lens.FieldOfView
      local zNormalized = L_Vector3.new(self.oriForward.x, 0, self.oriForward.z):calNormalized()
      local reference = {
        x = 0,
        y = 1,
        z = 0
      }
      self.xNormalized = L_Vector3.cross(zNormalized, reference)
      if self.xNormalized.x == 0 and self.xNormalized.y == 0 and self.xNormalized.z == 0 then
        reference = {
          x = 1,
          y = 0,
          z = 0
        }
        self.xNormalized = L_Vector3.cross(zNormalized, reference)
      end
      self.xNormalized = self.xNormalized:calNormalized()
      self.yNormalized = L_Vector3.cross(self.xNormalized, zNormalized)
      self.yNormalized = self.yNormalized:calNormalized()
      self.xOffset = 0
      self.yOffset = 0
      self.cameraValid = 0 >= self.otherParams[1] or L_Vector3.distance(self.oriPos, self.targetPos) < self.otherParams[1]
      if self.otherParams[2] ~= 0 and self.otherParams[2] ~= self.playableObjectIndex then
        self.cameraValid = false
      end
    end
    self.maxOffset = self.cameraOffsetList[self.playableObjectIndex]
    self.fovRange = self.cameraFovRangeList[self.playableObjectIndex]
    self.data.angle = self.cameraAngleList[self.playableObjectIndex]
    if not self.maxOffset then
      self.maxOffset = 4
    end
    if not self.fovRange then
      self.fovRange = 15
    end
    if not self.data.angle then
      self.data.angle = 30
    end
  end
  self.photographCamera = C_CameraManager.GetTactics(C_ECameraType.Photo).cineMachineCamera
  if self.virtualCamera then
    self.virtualCamera.enabled = true
    self:copyVirtualCamera(self.virtualCamera, self.photographCamera)
  end
end

function this:copyVirtualCamera(source, target)
  target.transform.position = source.transform.position
  target.m_Lens = source.m_Lens
  local v = source.transform.localEulerAngles.x
  local h = source.transform.localEulerAngles.y
  local body = target:GetCinemachineComponent(0)
  local aim = target:GetCinemachineComponent(1)
  if aim then
    local m_VerticalAxis = aim.m_VerticalAxis
    m_VerticalAxis.m_MinValue = v - 10
    m_VerticalAxis.m_MaxValue = v + 10
    m_VerticalAxis.Value = v
    aim.m_VerticalAxis = m_VerticalAxis
    local m_HorizontalAxis = aim.m_HorizontalAxis
    m_HorizontalAxis.m_MinValue = h - 10
    m_HorizontalAxis.m_MaxValue = h + 10
    m_HorizontalAxis.Value = h
    aim.m_HorizontalAxis = m_HorizontalAxis
  end
end

function this:bindScreenTouch(sign)
  self.onDragStartHandle = self.onDragStartHandle or L_CommonUtil.handle(self.onTouch_dragStart, self)
  self.onDragHandle = self.onDragHandle or L_CommonUtil.handle(self.onTouch_drag, self)
  self.onDragEndHandle = self.onDragEndHandle or L_CommonUtil.handle(self.onTouch_dragEnd, self)
  self.onPinchHandle = self.onPinchHandle or L_CommonUtil.handle(self.on_TouchPinch, self)
  C_ScreenTouch.OnUI_DragStart(sign, self.onDragStartHandle)
  C_ScreenTouch.OnUI_Drag(sign, self.onDragHandle)
  C_ScreenTouch.OnUI_DragEnd(sign, self.onDragEndHandle)
  C_ScreenTouch.OnUI_Pinch(sign, self.onPinchHandle)
end

function this:onTouch_dragStart(gesture)
  print("onTouch_dragStart " .. tostring(self.virtualCamera.transform.eulerAngles))
  self.touchMain = gesture.go == self.bindComponents.main.gameObject
end

function this:onTouch_drag(gesture)
  if not self.touchMain then
    return
  end
  if self.virtualCamera == nil then
    return
  end
  print("onTouch_drag " .. tostring(self.virtualCamera.transform.eulerAngles))
  local tempForward = self.virtualCamera.transform.forward
  self.virtualCamera.transform.eulerAngles = C_Vector3(self.virtualCamera.transform.eulerAngles.x - 360 * self.cameraRotateSpeed * gesture.deltaTime * (gesture.deltaPosition.y / C_Screen.height), self.virtualCamera.transform.eulerAngles.y + 360 * self.cameraRotateSpeed * gesture.deltaTime * (gesture.deltaPosition.x / C_Screen.width), 0)
  local angle = C_Vector3.Angle(self.oriForward, self.virtualCamera.transform.forward)
  if angle > self.data.angle then
    self.virtualCamera.transform.forward = tempForward
  end
end

function this:onTouch_dragEnd()
  print("onTouch_drag " .. tostring(self.virtualCamera.transform.eulerAngles))
  self.touchMain = nil
end

function this:getSearchTargetStates()
  local curPos = self:getCameraPos()
  if curPos == nil then
    return
  end
  if self.cameraValid == nil or not self.cameraValid then
    return false
  end
  local mainCamera = C_CameraManager.mainCamera
  local trans = mainCamera.transform
  local forward = trans.forward
  local dir = Unity.Vector3.ProjectOnPlane(self.targetPos - curPos, forward)
  local targetAngle = Unity.Vector3.SignedAngle(trans.up, dir, forward)
  self.bind.indicatorAngle = C_Vector3(0, 0, targetAngle)
  local targetDir = self.targetPos - curPos
  local angle = C_Vector3.Angle(forward, targetDir)
  local calibrationAngle = 4.5
  if self.otherParams[3] > 0.001 then
    calibrationAngle = self.otherParams[3]
  end
  local slider = self.bindComponents.sliderFov
  local modifier = math.max(0.1, self.fovRange * ((0.5 - self:reverseScrollValue(self:calculateScrollValue(slider.value))) / 0.5) + self.oriFov) / self.oriFov
  calibrationAngle = calibrationAngle * modifier
  local isInTarget = angle < calibrationAngle
  local isBlock = trans:IsPointToPointBlock(self.targetPos, self.targetGo)
  return isInTarget and not isBlock
end

function this:updateTargetTip()
  self.isInTarget = self:getSearchTargetStates()
  if self.isInTarget == nil then
    return
  end
  self.bind.searchActive = self.isInTarget
  self.bind.targetAniActive = self.isInTarget
end

function this:getCameraPos()
  local camera = C_CameraManager.mainCamera
  if camera == nil then
    return
  end
  local pos = camera.transform.position
  return pos
end

function this:update()
  if self.isSearchTarget then
    self:updateTargetTip()
  end
end

return this
