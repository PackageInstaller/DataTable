_class("HandleInputSystem_Render", Object)
HandleInputSystem_Render = HandleInputSystem_Render

function HandleInputSystem_Render:Constructor(world)
  self._world = world
  self._timeService = self._world:GetService("Time")
  self._inputComponent = world:Input()
  self._pickUpCmpt = world:PickUp()
  self._chessPickUpCmpt = world:ChessPickUp()
  self._popStarPickUpCmpt = self._world:PopStarPickUp()
  self._miragePickUpCmpt = world:MiragePickUp()
  self._click = false
  self._doubleClick = false
  self._lastDoubleClickTime = 0
  self._heldDown = false
  self._lastClickTime = 0
  self._heldDownPos = nil
  self._longPress = false
  self._beginDrag = false
  self._dragging = false
  self._endDrag = false
  self._lastHeldDownTime = 0
  self._hitInfo = nil
  self._rayCastMaxDistance = 2000
  self._lastMousePosition = nil
  self._lastFramePosArray = {}
  self._inputUIArray = {"black_mask", "GuideMask"}
  self._hitPointOffset = Vector3(0, 0, 0)
  self._cancelChainPathFunc = GameHelper:GetInstance():CreateCallback(self.CancelChainPath, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.CancelChainPath, self._cancelChainPathFunc)
end

function HandleInputSystem_Render:TearDown()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.CancelChainPath, self._cancelChainPathFunc)
end

function HandleInputSystem_Render:Execute()
  local touchCount = UnityEngine.Input.touchCount
  if 1 < touchCount then
    return
  end
  local hasInput = self:_UpdateInputState()
  local isWaitInputState = self:_IsWaitInputState()
  local isActiveSkillInputState = self:_IsActiveSkillInputState()
  local isMirageWaitInputState = self:_IsMirageWaitInputState()
  if self._world:MatchType() == MatchType.MT_Chess then
    self:_UpdateChessInputState()
  elseif isMirageWaitInputState then
    self:_UpdateMirageInputState()
  elseif isWaitInputState == true then
    if (self._world:MatchType() == MatchType.MT_PopStar or self._world:MatchType(GetMatchTypeType.NoLinkLine) == MatchType.MT_PopStarPro) and not self._inputComponent:IsPreviewActiveSkill() then
      self:_UpdatePopStarInputState()
    else
      local utilStatSvc = self._world:GetService("UtilData")
      if not utilStatSvc:GetStatAutoFight() then
        self:_UpdateMultiDragState(hasInput)
      end
    end
  else
    if isActiveSkillInputState == true then
      self:_UpdateActiveSkillInputState()
    else
    end
  end
end

function HandleInputSystem_Render:_UpdateDragState(hasInput)
  self:_UpdateTouchState()
  if hasInput ~= true then
    return
  end
  local castRes = self:_DoRayCast()
  if castRes ~= true then
    return
  end
  local originalHitPoint = self._hitInfo.point
  local hitPoint = Vector3(originalHitPoint.x + self._hitPointOffset.x, originalHitPoint.y, originalHitPoint.z + self._hitPointOffset.z)
  self:_CreateTestObj(hitPoint)
  self:_SetInputComponent(hitPoint)
  self:InputDirty()
end

function HandleInputSystem_Render:_UpdateMultiDragState(hasInput)
  self:_UpdateTouchState()
  if hasInput ~= true then
    return
  end
  local castRes = self:_DoMultiPointRayCast()
  if castRes ~= true then
  end
  self:_RefreshInputData()
  self:InputDirty()
end

function HandleInputSystem_Render:_UpdateActiveSkillInputState()
  local mouseClick = UnityEngine.Input.GetMouseButtonDown(0)
  if not mouseClick then
    return
  end
  local castRes = self:_DoRayCast()
  if castRes ~= true then
    return
  end
  self:_CreateTestObj(self._hitInfo.point)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {
    input = "PickUp",
    hitPoint = self._hitInfo.point
  })
  self._pickUpCmpt:SetClickPos(self._hitInfo.point)
  self:_PickUpDirty()
end

function HandleInputSystem_Render:_UpdateChessInputState()
  local mouseClick = UnityEngine.Input.GetMouseButtonDown(0)
  if not mouseClick then
    return
  end
  local castRes = self:_DoRayCast()
  if castRes ~= true then
    return
  end
  self:_CreateTestObj(self._hitInfo.point)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {
    input = "PickUp",
    hitPoint = self._hitInfo.point
  })
  self._chessPickUpCmpt:SetChessClickPos(self._hitInfo.point)
  self:_ChessPickUpDirty()
end

function HandleInputSystem_Render:_UpdatePopStarInputState()
  local mouseClick = UnityEngine.Input.GetMouseButtonDown(0)
  if not mouseClick then
    return
  end
  local castRes = self:_DoRayCast()
  if castRes ~= true then
    return
  end
  self:_CreateTestObj(self._hitInfo.point)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {
    input = "PickUp",
    hitPoint = self._hitInfo.point
  })
  self._popStarPickUpCmpt:SetPopStarClickPos(self._hitInfo.point)
  self:_PopStarPickUpDirty()
end

function HandleInputSystem_Render:_UpdateMirageInputState()
  local mouseClick = UnityEngine.Input.GetMouseButtonDown(0)
  if not mouseClick then
    return
  end
  local castRes = self:_DoRayCast()
  if castRes ~= true then
    return
  end
  self:_CreateTestObj(self._hitInfo.point)
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {
    input = "PickUp",
    hitPoint = self._hitInfo.point
  })
  self._miragePickUpCmpt:SetClickPos(self._hitInfo.point)
  self:_MiragePickUpDirty()
end

function HandleInputSystem_Render:_SetInputComponent(hitPoint)
  if self._doubleClick then
    self._inputComponent:SetDoubleClickPos(hitPoint)
  elseif self._dragging then
    self._inputComponent:SetTouchMovePosition(hitPoint)
  elseif self._beginDrag then
    self._inputComponent:SetTouchBeginPosition(hitPoint)
  elseif self._endDrag then
    self._inputComponent:SetTouchEndPosition(hitPoint)
    self._endDrag = false
    self._doubleClick = false
  end
end

function HandleInputSystem_Render:_RefreshInputData()
  local currentTimeMS = self._timeService:GetCurrentTimeMs()
  if self._doubleClick then
    local deltaLength = currentTimeMS - self._lastDoubleClickTime
    if #self._lastFramePosArray > 0 and deltaLength > HelperProxy:GetInstance():GetFixTimeLen(27) then
      local firstHitPoint = self._lastFramePosArray[1]
      self._inputComponent:SetDoubleClickPos(firstHitPoint)
      GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {
        input = "DoubleClick",
        hitPoint = firstHitPoint
      })
    end
  elseif self._dragging then
    if #self._lastFramePosArray > 0 then
      self._inputComponent:SetTouchMovePositionList(self._lastFramePosArray)
      GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {
        input = "Dragging",
        hitPoint = self._lastFramePosArray[1]
      })
    end
  elseif self._beginDrag then
    if #self._lastFramePosArray > 0 then
      local firstHitPoint = self._lastFramePosArray[1]
      self._inputComponent:SetTouchBeginPosition(firstHitPoint)
      GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {input = "BeginDrag", hitPoint = firstHitPoint})
    end
  elseif self._endDrag then
    self._inputComponent:SetTouchEndPosition(nil)
    self._endDrag = false
    self._doubleClick = false
    GameGlobal.GameRecorder():RecordAction(GameRecordAction.TouchInput, {input = "EndDrag"})
  end
end

function HandleInputSystem_Render:_UpdateInputState()
  local mouseClick = UnityEngine.Input.GetMouseButtonDown(0)
  local mouseHoldDown = UnityEngine.Input.GetMouseButton(0)
  local mouseRelease = UnityEngine.Input.GetMouseButtonUp(0)
  if mouseClick then
    self:_OnMouseClick()
  else
    self._click = false
  end
  if mouseHoldDown then
    self:_OnMouseHoldDown()
  end
  if mouseRelease then
    self:_OnMouseUp()
  end
  if self._doubleClick or self._click or self._dragging or self._beginDrag or self._endDrag or self._longPress then
    return true
  end
  return false
end

function HandleInputSystem_Render:_OnMouseClick()
  local currentTimeMS = self._timeService:GetCurrentTimeMs()
  if currentTimeMS - self._lastClickTime < HelperProxy:GetInstance():GetFixTimeLen(222) then
    self._doubleClick = true
    self._lastDoubleClickTime = currentTimeMS
  else
    self._click = true
  end
  self._lastClickTime = currentTimeMS
end

function HandleInputSystem_Render:_OnMouseHoldDown()
  local currentInputPos = UnityEngine.Input.mousePosition
  local currentTimeMS = self._timeService:GetCurrentTimeMs()
  if self._heldDown ~= true then
    self._lastHeldDownTime = currentTimeMS
    self._heldDownPos = currentInputPos
    self._heldDown = true
  end
  local deltaTime = currentTimeMS - self._lastHeldDownTime
  if 10 < deltaTime then
    self._longPress = true
    self._click = false
    if self._dragging == false then
      if self._beginDrag == false and self._doubleClick == false then
        self._beginDrag = true
      elseif currentInputPos ~= self._heldDownPos then
        self._dragging = true
        self._beginDrag = false
      end
    end
  end
end

function HandleInputSystem_Render:_OnMouseUp()
  if self._dragging == true or self._beginDrag == true then
    self._endDrag = true
  end
  self._lastHeldDownTime = 0
  self._heldDown = false
  self._longPress = false
  self._beginDrag = false
  self._dragging = false
  self._click = false
  self._doubleClick = false
end

function HandleInputSystem_Render:_DoMultiPointRayCast()
  local camera = self._world:MainCamera()
  if not camera then
    return false
  end
  self._lastFramePosArray = {}
  local posData = InputHelper.LastFramePositionArray()
  local inputPos = posData[0]
  local ray = camera:ScreenPointToRay(inputPos)
  local layMask = 2 ^ LayerMask.NameToLayer("Stage")
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, self._rayCastMaxDistance, layMask)
  if castRes == true then
    local isCastUI = self:_CheckInputPosCastUI(inputPos)
    if isCastUI == false then
      self._lastFramePosArray[#self._lastFramePosArray + 1] = hitInfo.point
    end
  end
  local hitInfoCount = #self._lastFramePosArray
  if 0 < hitInfoCount then
    return true
  end
  return false
end

function HandleInputSystem_Render:_DoRayCast()
  local camera = self._world:MainCamera()
  if not camera then
    return false
  end
  local inputPos = UnityEngine.Input.mousePosition
  local ray = camera:ScreenPointToRay(inputPos)
  local layMask = 2 ^ LayerMask.NameToLayer("Stage")
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, self._rayCastMaxDistance, layMask)
  if castRes == true then
    local isCastUI = self:_IsCastUI()
    if isCastUI then
      return false
    end
  end
  self._hitInfo = hitInfo
  return castRes
end

function HandleInputSystem_Render:_CheckInputPosCastUI(inputPos)
  local eventSystem = UnityEngine.EventSystems.EventSystem.current
  if InputHelper.IsPointerOverGameObject() then
    local pointer = UnityEngine.EventSystems.PointerEventData:New(eventSystem)
    pointer.position = inputPos
    local raycastResults = UIHelper.CreateEventSystemRaycastResultList()
    eventSystem:RaycastAll(pointer, raycastResults)
    for i = 1, raycastResults.Count do
      local go = raycastResults:get_Item(i - 1).gameObject
      local isContain = table.icontains(self._inputUIArray, go.name)
      if isContain == false then
        self._inputComponent._touchHasBegin = false
        return true
      end
    end
  end
  return false
end

function HandleInputSystem_Render:_IsCastUI()
  local inputPos = UnityEngine.Input.mousePosition
  local eventSystem = UnityEngine.EventSystems.EventSystem.current
  if InputHelper.IsPointerOverGameObject() then
    local pointer = UnityEngine.EventSystems.PointerEventData:New(eventSystem)
    pointer.position = inputPos
    local raycastResults = UIHelper.CreateEventSystemRaycastResultList()
    eventSystem:RaycastAll(pointer, raycastResults)
    for i = 1, raycastResults.Count do
      local go = raycastResults:get_Item(i - 1).gameObject
      if go.name ~= "black_mask" then
        self._inputComponent._touchHasBegin = false
        return true
      end
    end
  end
end

function HandleInputSystem_Render:InputDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.Input)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.Input, component)
end

function HandleInputSystem_Render:_PickUpDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.PickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.PickUp, component)
end

function HandleInputSystem_Render:TouchDirty()
  local touchCmpt = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.Touch)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.Touch, touchCmpt)
end

function HandleInputSystem_Render:_ChessPickUpDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.ChessPickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.ChessPickUp, component)
end

function HandleInputSystem_Render:_PopStarPickUpDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.PopStarPickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.PopStarPickUp, component)
end

function HandleInputSystem_Render:_MiragePickUpDirty()
  local component = self._world:GetUniqueComponent(self._world.BW_UniqueComponentsEnum.MiragePickUp)
  self._world:SetUniqueComponent(self._world.BW_UniqueComponentsEnum.MiragePickUp, component)
end

function HandleInputSystem_Render:_CreateTestObj(hitPoint)
  if not EDITOR then
    return
  end
  if self.sphere == nil then
    self.sphere = UnityEngine.GameObject.CreatePrimitive(UnityEngine.PrimitiveType.Sphere)
    self.sphere.name = "Test"
    self.sphere.transform.localScale = Vector3(0.1, 0, 0.1)
  end
  local newPos = Vector3(hitPoint.x, hitPoint.y, hitPoint.z)
  self.sphere.transform.position = newPos
end

function HandleInputSystem_Render:_LookAtPlayer()
  local cameraCmpt = self._world:MainCamera()
  if cameraCmpt == nil then
    return
  end
  if self._boardCenterObj == nil then
    self._boardCenterObj = UnityEngine.GameObject.CreatePrimitive(UnityEngine.PrimitiveType.Sphere)
    self._boardCenterObj.name = "BoardCenter"
    self._boardCenterObj.transform.localScale = Vector3(0.1, 0, 0.1)
    self._boardCenterObj.transform.position = Vector3(0, 0, 1)
  end
  local cameraObj = cameraCmpt:Camera()
  cameraObj.gameObject.transform:LookAt(self._boardCenterObj.transform)
end

function HandleInputSystem_Render:_CreateLookAtObj()
  local cameraCmpt = self._world:MainCamera()
  if cameraCmpt == nil then
    return
  end
  local cameraObj = cameraCmpt:Camera()
  local cameraForward = cameraObj.gameObject.transform.forward
  local cameraPosition = cameraObj.gameObject.transform.position
  local castDistance = 2000
  local layMask = 2 ^ LayerMask.NameToLayer("Stage")
  local castRes, hitInfo = UnityEngine.Physics.Raycast(cameraPosition, cameraForward, nil, castDistance, layMask)
  if castRes ~= true then
    return
  end
  local hitPoint = hitInfo.point
  if self.sphere == nil then
    self.sphere = UnityEngine.GameObject.CreatePrimitive(UnityEngine.PrimitiveType.Sphere)
    self.sphere.name = "LookAt"
    self.sphere.transform.localScale = Vector3(0.1, 0, 0.1)
  end
  local newPos = Vector3(hitPoint.x, hitPoint.y, hitPoint.z)
  self.sphere.transform.position = newPos
  local rayDistance = Vector3.Distance(cameraPosition, hitPoint)
  UnityEngine.Debug.DrawRay(cameraPosition, cameraForward * rayDistance, Color.green)
end

function HandleInputSystem_Render:CancelChainPath()
  self:_OnMouseUp()
  local cameraCmpt = self._world:MainCamera()
  if cameraCmpt:IsFocusPlayer() then
    cameraCmpt:DoMoveCamera(false)
  end
  self._lastMousePosition = nil
  Log.notice("HandleInput CancelChainPath")
end

function HandleInputSystem_Render:_IsWaitInputState()
  local utilDataSvc = self._world:GetService("UtilData")
  local isInput = utilDataSvc:GetMainStateInputEnable()
  if self._inputComponent:IsPreviewActiveSkill() then
    isInput = true
  end
  return isInput
end

function HandleInputSystem_Render:_IsActiveSkillInputState()
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  if gameFsmStateID == GameStateID.PickUpActiveSkillTarget or gameFsmStateID == GameStateID.PreviewActiveSkill then
    return true
  end
  if gameFsmStateID == GameStateID.PickUpChainSkillTarget then
    return true
  end
  return false
end

function HandleInputSystem_Render:_IsMirageWaitInputState()
  local utilDataSvc = self._world:GetService("UtilData")
  local gameFsmStateID = utilDataSvc:GetCurMainStateID()
  if gameFsmStateID == GameStateID.MirageWaitInput and not utilDataSvc:GetStatAutoFight() then
    return true
  end
  return false
end

function HandleInputSystem_Render:_UpdateTouchState()
  local gridTouchComponent = self._world:GridTouch()
  local touchState = gridTouchComponent:GetGridTouchStateID()
  local mainCameraCmpt = self._world:MainCamera()
  if touchState == GridTouchStateID.Drag and mainCameraCmpt:IsMovingToFocus() then
    mainCameraCmpt:MoveCameraToFocusImmediately()
  end
  local isFocusPlayer = mainCameraCmpt:IsFocusPlayer()
  if not isFocusPlayer then
    self._lastMousePosition = nil
    return
  end
  local curMousePos = UnityEngine.Input.mousePosition
  if self._lastMousePosition == nil then
    self._lastMousePosition = curMousePos
  end
  local mouseHoldDown = UnityEngine.Input.GetMouseButton(0)
  if not mouseHoldDown then
    return
  end
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local cameraParam = levelConfigData:GetCameraParam()
  local moveSpeed = cameraParam:GetTouchMoveCameraSpeed()
  local hitPoint = self:_CalcHitPoint(curMousePos)
  if hitPoint ~= nil then
    local moveEdge = cameraParam:GetMoveCameraEdge()
    local moveEdgeSpeed = cameraParam:GetTouchMoveCameraEdgeSpeed()
    local boardServiceRender = self._world:GetService("BoardRender")
    local gridPos = boardServiceRender:BoardRenderPos2FloatGridPos(hitPoint)
    local x = math.abs(gridPos.x)
    local y = math.abs(gridPos.y)
    if x <= 1 or y <= 1 or moveEdge <= x or moveEdge <= y then
      moveSpeed = moveEdgeSpeed
    end
    local modifiedSpeed = self:_DoModifyCameraMoveFactor(x, y)
    if modifiedSpeed then
      moveSpeed = modifiedSpeed
    end
  end
  local mouseDelta = curMousePos - self._lastMousePosition
  local deltaMove = mouseDelta * moveSpeed
  local mainCameraCmpt = self._world:MainCamera()
  local cameraCmpt = mainCameraCmpt:Camera()
  local targetCameraPos = self:_CalcTargetCameraPos(deltaMove)
  cameraCmpt.transform.position = targetCameraPos
  self._lastMousePosition = curMousePos
end

function HandleInputSystem_Render:_CalcTargetCameraPos(moveDir)
  local mainCameraCmpt = self._world:MainCamera()
  local cameraObj = mainCameraCmpt:Camera()
  local curCameraPos = cameraObj.transform.position
  local worldMoveDir = cameraObj.transform:TransformDirection(moveDir)
  local targetCameraPos = curCameraPos + worldMoveDir
  local targetFocusPos = mainCameraCmpt:GetFocusTargetPos()
  if targetFocusPos ~= nil then
    local deltaDir = targetCameraPos - targetFocusPos
    local localDeltaDir = cameraObj.transform:InverseTransformDirection(deltaDir)
    local configService = self._world:GetService("Config")
    local levelConfigData = configService:GetLevelConfigData()
    local cameraParam = levelConfigData:GetCameraParam()
    local cameraMaxHorizatalLeft = cameraParam:GetCameraMaxHorizatalLeft()
    local cameraMaxHorizatalRight = cameraParam:GetCameraMaxHorizatalRight()
    local cameraMaxVerticalUp = cameraParam:GetCameraMaxVerticalUp()
    local cameraMaxVerticalDown = cameraParam:GetCameraMaxVerticalDown()
    if localDeltaDir.x < 0 and cameraMaxHorizatalLeft < math.abs(localDeltaDir.x) then
      localDeltaDir.x = -cameraMaxHorizatalLeft
    elseif localDeltaDir.x > 0 and cameraMaxHorizatalRight < localDeltaDir.x then
      localDeltaDir.x = cameraMaxHorizatalRight
    end
    if 0 < localDeltaDir.y and cameraMaxHorizatalRight < localDeltaDir.y then
      localDeltaDir.y = cameraMaxHorizatalRight
    elseif 0 > localDeltaDir.y and cameraMaxVerticalDown < math.abs(localDeltaDir.y) then
      localDeltaDir.y = -cameraMaxVerticalDown
    end
    targetCameraPos = targetFocusPos + cameraObj.transform:TransformDirection(localDeltaDir)
  end
  return targetCameraPos
end

function HandleInputSystem_Render:_CalcHitPoint(inputPos)
  local cameraCmpt = self._world:MainCamera()
  if cameraCmpt == nil then
    return nil
  end
  local ray = cameraCmpt:ScreenPointToRay(inputPos)
  local layMask = 2 ^ LayerMask.NameToLayer("Stage")
  local castRes, hitInfo = UnityEngine.Physics.Raycast(ray, nil, self._rayCastMaxDistance, layMask)
  if castRes == true then
    return hitInfo.point
  end
  return nil
end

function HandleInputSystem_Render:_DoModifyCameraMoveFactor(gridX, gridY)
  if not IsPc() then
    return
  end
  local configService = self._world:GetService("Config")
  local levelConfigData = configService:GetLevelConfigData()
  local cameraParam = levelConfigData:GetCameraParam()
  local moveEdgeSpeed = cameraParam:GetTouchMoveCameraEdgeSpeed()
  local baseWidth = 1920
  local rate = baseWidth / UnityEngine.Screen.width
  local edgeFactor = moveEdgeSpeed * rate
  if 5 <= gridY then
    return edgeFactor
  end
end
