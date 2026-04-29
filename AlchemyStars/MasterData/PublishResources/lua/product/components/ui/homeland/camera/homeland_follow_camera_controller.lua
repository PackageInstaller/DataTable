_class("HomelandFollowCameraController", Object)
HomelandFollowCameraController = HomelandFollowCameraController

function HomelandFollowCameraController:Constructor()
  self._navmeshLayer = 6291456
  self._resName = "HomelandFollowCamControl"
  self._OffsetYStart = 1.28
  self._rotateFacorX = 5
  self._rotateFacorY = 5
  self._minXAngle = -20
  self._maxXAngle = 60
  self._minScale = -9.5
  self._maxScale = -3.5
  self._transparentStartScale = -3
  self._transparentZeroScale = -1
  self._buildTransparentNear = 1
  self._buildTransparentFar = 5
  self._petTransparentNear = 0.5
  self._petTransparentFar = 4
  self._fovInit = 0
  self._near = 0.3
  self._offsetYReduceStartScale = -8
  self._offsetYMin = 1.1
  self._offsetYScaleRange = self._maxScale - self._offsetYReduceStartScale
  self._fovReduceStartScale = -8
  self._fovMin = 25
  self._fovScaleRange = self._maxScale - self._fovReduceStartScale
  self._dashFovIncrementBase = 0
  self._zOffsetIncrementBase = 0
  self._focusOffset = Vector3(0, self._OffsetYStart, 0)
  self._focusPos = nil
  self._xAngle = 0
  self._fov = 0
  self._zOffset = 0
  self._dashFovIncrement = 0
  self._zOffsetIncrement = 0
  self._fadeCmptDic = {}
  self._defaultFocusTime = 0.5
  self._focusState = false
  self._camPosBeforeFocus = nil
  self._camRotBeforeFocus = nil
  self._camAnglesBeforeFocus = nil
  self._needSyncCamPos = false
  self._isTransparent = false
end

function HomelandFollowCameraController:Init(homelandClient)
  self._resReq = ResourceManager:GetInstance():SyncLoadAsset(self._resName .. ".prefab", LoadType.GameObject)
  self._camRootGO = self._resReq.Obj
  self._camRootTrans = self._camRootGO.transform
  self._camAxisXTrans = self._camRootTrans:GetChild(0)
  self._camTrans = self._camAxisXTrans:GetChild(0)
  self._camActorLightDirTrans = self._camTrans:GetChild(0)
  self._camPosTrans = self._camAxisXTrans:GetChild(1)
  self._camNearPlanePos = self._camPosTrans:GetChild(0)
  self._camNearPlaneBottomPos = self._camNearPlanePos:GetChild(0)
  self._camPosTrans.localPosition = self._camTrans.localPosition
  local positionz = LocalDB.GetInt("homeland_follow_camera_position", -455)
  self._camPosTrans.localPosition = Vector3(0, 0, positionz / 100)
  self._zOffset = self._camPosTrans.localPosition.z
  self._vecNearCenter2Botton = self._camNearPlaneBottomPos.position - self._camNearPlanePos.position
  self._xAngle = self._camAxisXTrans.localEulerAngles.x
  self._ori_xAngle = self._xAngle
  self._char = homelandClient:CharacterManager():MainCharacterController()
  local mainCharTrans = self._char:Transform()
  self._focusPos = mainCharTrans.position
  self._camRootTrans.position = self._focusPos + self._focusOffset
  self._camRootTrans.rotation = mainCharTrans.rotation
  self._sceneManager = homelandClient:SceneManager(self._camActorLightDirTrans)
  self._sceneManager:SetCustomLightTransform(self._camActorLightDirTrans)
  local runtimeRootTrans = self._sceneManager:RuntimeRootTrans()
  self._camRootTrans:SetParent(runtimeRootTrans)
  self._camRootGO:SetActive(true)
  self._camera = self._camRootGO:GetComponentInChildren(typeof(UnityEngine.Camera))
  self._fovInit = self._camera.fieldOfView
  self._fov = self._fovInit
  self._near = self._camera.nearClipPlane
  self._camNearPlanePos.localPosition = Vector3(0, 0, self._near)
  self:SyncCamLocalPos(self._camPosTrans.localPosition)
  self._HomelandBuildManager = homelandClient:BuildManager()
end

function HomelandFollowCameraController:Dispose()
  self._resReq:Dispose()
  self._resReq = nil
  self._camRootGO = nil
  self._camRootTrans = nil
  self._camAxisXTrans = nil
end

function HomelandFollowCameraController:Update()
  self._sceneManager:UpdateH3DRenderSetting()
  if self._focusState then
    return
  end
  if self._needSyncCamPos then
    local camFocusPos = self._camAxisXTrans.position
    local nearPlaneBottomPos = self._camNearPlaneBottomPos.position
    local cameraPos = camFocusPos + self._vecNearCenter2Botton
    local hitList = self:GetHitList(cameraPos, nearPlaneBottomPos)
    local reversHitList = self:GetHitList(nearPlaneBottomPos, cameraPos)
    local j = #reversHitList
    
    local function CompareDistance(hitInfo1, hitInfo2)
      local dis1 = Vector3.Distance(hitInfo1.point, cameraPos)
      local dis2 = Vector3.Distance(hitInfo2.point, cameraPos)
      return dis1 < dis2
    end
    
    table.sort(hitList, CompareDistance)
    local pushed = false
    if 0 < #hitList then
      for i = 1, #hitList do
        if 0 < j and reversHitList[j].transform == hitList[i].transform then
          j = j - 1
        elseif self:ProcessRaycastPushCamera(hitList[i], hitList, cameraPos) then
          pushed = true
          break
        end
      end
      if not pushed then
        self:SyncCamLocalPos(self._camPosTrans.localPosition)
      end
    else
      self:SyncCamLocalPos(self._camPosTrans.localPosition)
    end
    for fadeCmpt, _ in pairs(self._fadeCmptDic) do
      self._fadeCmptDic[fadeCmpt] = false
    end
    hitList = UnityEngine.Physics.RaycastAll(self._camPosTrans.position, camFocusPos - self._camPosTrans.position, -self._zOffset)
    if 0 < hitList.Length then
      for i = 0, hitList.Length - 1 do
        self:ProcessRaycastTransparent(hitList[i])
      end
    end
    for fadeCmpt, bValue in pairs(self._fadeCmptDic) do
      if not bValue then
        self._fadeCmptDic[fadeCmpt] = nil
        fadeCmpt.Alpha = 1
      end
    end
  end
end

function HomelandFollowCameraController:GetHitList(startPoint, endPoint)
  local hitList = {}
  local rayStart = startPoint:Clone()
  local direction = Vector3.Normalize(endPoint - startPoint)
  while true do
    local dist = Vector3.Distance(rayStart, endPoint)
    if dist < 0.01 then
      return hitList
    end
    local res, hit = UnityEngine.Physics.Raycast(rayStart, direction, nil, dist, self._navmeshLayer)
    if res then
      hitList[#hitList + 1] = hit
      rayStart = hit.point + direction / 100
    else
      return hitList
    end
  end
end

function HomelandFollowCameraController:ProcessRaycastTransparent(raycastHit)
  local go = raycastHit.transform.gameObject
  local name = go.name
  if name == "Bip001" then
    local root = go.transform.parent
    while root.gameObject.name ~= "Root" do
      root = root.parent
      if not root then
        break
      end
    end
    if root then
      local fadeCmpt = root.gameObject:GetComponent(typeof(FadeComponent))
      fadeCmpt = fadeCmpt or root.gameObject:AddComponent(typeof(FadeComponent))
      if raycastHit.distance < self._petTransparentNear then
        fadeCmpt.Alpha = 0
      elseif raycastHit.distance > self._petTransparentFar then
        fadeCmpt.Alpha = 1
      else
        fadeCmpt.Alpha = (raycastHit.distance - self._petTransparentNear) / (self._petTransparentFar - self._petTransparentNear)
      end
      self._fadeCmptDic[fadeCmpt] = true
    end
  end
end

function HomelandFollowCameraController:ProcessRaycastPushCamera(raycastHit, hitList, cameraPos)
  local targetHit
  for i = 1, #hitList do
    local hit = hitList[i]
    if hit ~= raycastHit then
      local collider = hit.collider
      local closestPoint = collider:ClosestPoint(self._camTrans.position)
      local dir = Vector3.Distance(closestPoint, self._camTrans.position)
      local hitDis = Vector3.Distance(hit.point, cameraPos)
      local raycastHitDis = Vector3.Distance(raycastHit.point, cameraPos)
      if dir <= 0 and hitDis < raycastHitDis then
        targetHit = hit
        break
      end
    end
  end
  if targetHit then
    raycastHit = targetHit
  end
  self._camTrans.position = raycastHit.point - self._vecNearCenter2Botton
  self:SyncCamLocalPos(Vector3(0, 0, self._camTrans.localPosition.z + 0.01))
  return true
end

function HomelandFollowCameraController:SyncCamLocalPos(pos)
  self._camTrans.localPosition = pos
  local z = pos.z
  if z > self._transparentStartScale then
    local alpha = (lmathext.clamp(z, self._transparentStartScale, self._transparentZeroScale) - self._transparentZeroScale) / (self._transparentStartScale - self._transparentZeroScale)
    self._char:SetAlpha(alpha)
    self._isTransparent = true
  elseif self._isTransparent then
    self._char:SetAlpha(1)
    self._isTransparent = false
  end
  local offsetY = lmathext.lerp(self._offsetYMin, self._OffsetYStart, (self._maxScale - z) / self._offsetYScaleRange)
  self._focusOffset.y = offsetY
  self:_UpdatePosInternal()
  local fov = lmathext.lerp(self._fovMin, self._fovInit, (self._maxScale - z) / self._fovScaleRange)
  self._fov = fov
  self:_UpdateFovInternal()
  self._needSyncCamPos = false
end

function HomelandFollowCameraController:SetHandleOffset(offsetPos)
  self._camAxisXTrans.localPosition = offsetPos
end

function HomelandFollowCameraController:HandleRotate(mx, my)
  if self._focusState then
    return
  end
  if mx == 0.0 and my == 0.0 then
    return
  end
  if mx ~= 0 and self._camRootTrans then
    self._camRootTrans:Rotate(0, mx * self._rotateFacorX, 0)
  end
  if my ~= 0 and self._camRootTrans then
    local xAngle = self._xAngle - my * self._rotateFacorY
    if xAngle > self._maxXAngle then
      xAngle = self._maxXAngle
    elseif xAngle < self._minXAngle then
      xAngle = self._minXAngle
    end
    self._camAxisXTrans.localRotation = Quaternion.Euler(xAngle, 0, 0)
    self._xAngle = xAngle
  end
  self._needSyncCamPos = true
end

function HomelandFollowCameraController:SetXRotation(xAngle)
  if self._focusState then
    return
  end
  local _xAngle = xAngle
  if _xAngle > self._maxXAngle then
    _xAngle = self._maxXAngle
  elseif _xAngle < self._minXAngle then
    _xAngle = self._minXAngle
  end
  self._camAxisXTrans.localRotation = Quaternion.Euler(_xAngle, 0, 0)
  self._xAngle = _xAngle
end

function HomelandFollowCameraController:HandleScale(scale)
  if self._stopScale or self._focusState then
    return
  end
  local newZ = self._zOffset + scale
  if newZ < self._minScale then
    newZ = self._minScale
  elseif newZ > self._maxScale then
    newZ = self._maxScale
  end
  self._zOffset = newZ
  LocalDB.SetInt("homeland_follow_camera_position", newZ * 100)
  self:_UpdateScaleInternal()
end

function HomelandFollowCameraController:HandleScaleForStory(z)
  local newZ = z
  if newZ < self._minScale then
    newZ = self._minScale
  elseif newZ > self._maxScale then
    newZ = self._maxScale
  end
  self._zOffset = newZ
  self:_UpdateScaleInternal()
end

function HomelandFollowCameraController:CalcMovement(inputVec)
  return self._camRootTrans:TransformDirection(inputVec)
end

function HomelandFollowCameraController:GetFocusPos()
  return self._focusPos
end

function HomelandFollowCameraController:UpdatePos(pos)
  if self._focusState then
    return
  end
  self._focusPos = pos
  self:_UpdatePosInternal()
end

function HomelandFollowCameraController:_UpdatePosInternal()
  if self._focusPos then
    self._camRootTrans.position = self._focusPos + self._focusOffset
  end
  self._needSyncCamPos = true
end

function HomelandFollowCameraController:_UpdateFovInternal()
  self._camera.fieldOfView = self._fov + self._dashFovIncrement
end

function HomelandFollowCameraController:_UpdateScaleInternal()
  self._camPosTrans.localPosition = Vector3(0, 0, self._zOffset + self._zOffsetIncrement)
  self._needSyncCamPos = true
end

function HomelandFollowCameraController:SetActive(active)
  self._camRootGO:SetActive(active)
  if active then
    self._sceneManager:SetCustomLightTransform(self._camActorLightDirTrans)
  end
end

function HomelandFollowCameraController:Rotation()
  return self._camRootTrans.rotation
end

function HomelandFollowCameraController:Position()
  return self._camRootTrans.position
end

function HomelandFollowCameraController:CamPosition()
  return self._camTrans.position
end

function HomelandFollowCameraController:CameraCmp()
  return self._camera
end

function HomelandFollowCameraController:CurrentScale()
  return self._zOffset
end

function HomelandFollowCameraController:StopCameraScale(hide)
  self._stopScale = hide
end

function HomelandFollowCameraController:OriXAngle()
  return self._ori_xAngle
end

function HomelandFollowCameraController:NowXAngle()
  return self._xAngle
end

function HomelandFollowCameraController:SetRotation(rot)
  self._camRootTrans.rotation = rot
end

function HomelandFollowCameraController:SetCamLocation(angleX, angelY, scale)
  local _xAngle = angleX
  if _xAngle > self._maxXAngle then
    _xAngle = self._maxXAngle
  elseif _xAngle < self._minXAngle then
    _xAngle = self._minXAngle
  end
  self._camAxisXTrans.localRotation = Quaternion.Euler(_xAngle, 0, 0)
  self._xAngle = _xAngle
  self._camRootTrans.localRotation = Quaternion.Euler(0, angelY, 0)
  local newZ = scale
  if newZ < self._minScale then
    newZ = self._minScale
  elseif newZ > self._maxScale then
    newZ = self._maxScale
  end
  self._zOffset = newZ
  self:_UpdateScaleInternal()
end

function HomelandFollowCameraController:UpdateDashProgress(progress)
  self._dashFovIncrement = lmathext.lerp(self._dashFovIncrementBase, 0, progress)
  self._zOffsetIncrement = lmathext.lerp(self._zOffsetIncrementBase, 0, progress)
  self:_UpdateFovInternal()
  self:_UpdateScaleInternal()
end

function HomelandFollowCameraController:Focus(transform, time, rotateCompleteCallback)
  if self._focusState then
    return
  end
  self._focusState = true
  self._camPosBeforeFocus = self._camTrans.transform.position
  self._camRotBeforeFocus = self._camTrans.transform.rotation
  local focusTime = time
  focusTime = focusTime or self._defaultFocusTime
  if focusTime <= 0 then
    self._camTrans.transform.position = transform.position
    self._camTrans.transform.rotation = transform.rotation
    if rotateCompleteCallback then
      rotateCompleteCallback()
    end
    return
  end
  GameGlobal.UIStateManager():Lock("HomelandFollowCameraController:Focus")
  self._camTrans:DOMove(transform.position, focusTime, false)
  self._camTrans:DORotateQuaternion(transform.rotation, focusTime):OnComplete(function()
    GameGlobal.UIStateManager():UnLock("HomelandFollowCameraController:Focus")
    if rotateCompleteCallback then
      rotateCompleteCallback()
    end
  end)
end

function HomelandFollowCameraController:LeaveFocus(time, callback)
  if not self._focusState then
    return
  end
  local focusTime = time
  focusTime = focusTime or self._defaultFocusTime
  if focusTime <= 0 then
    self._camTrans.transform.position = self._camPosBeforeFocus
    self._camTrans.transform.rotation = self._camRotBeforeFocus
    self._focusState = false
    if callback then
      callback()
    end
    return
  end
  GameGlobal.UIStateManager():Lock("HomelandFollowCameraController:LeaveFocus")
  self._camTrans:DOMove(self._camPosBeforeFocus, focusTime, false)
  self._camTrans:DORotateQuaternion(self._camRotBeforeFocus, focusTime):OnComplete(function()
    self._focusState = false
    if callback then
      callback()
    end
    GameGlobal.UIStateManager():UnLock("HomelandFollowCameraController:LeaveFocus")
  end)
end

function HomelandFollowCameraController:DoShake()
  self._camTrans:DOShakePosition(0.3, Vector3(0.1, 0.1, 0.1), 30, 45, false, true)
end

function HomelandFollowCameraController:FocusUseAngles(transform, time, rotateCompleteCallback)
  if self._focusState then
    return
  end
  self._focusState = true
  self._camPosBeforeFocus = self._camTrans.transform.position
  self._camRotBeforeFocus = self._camTrans.transform.rotation
  self._camAnglesBeforeFocus = self._camTrans.transform.eulerAngles
  local focusTime = time
  focusTime = focusTime or self._defaultFocusTime
  if focusTime <= 0 then
    self._camTrans.transform.position = transform.position
    self._camTrans.transform.rotation = transform.rotation
    if rotateCompleteCallback then
      rotateCompleteCallback()
    end
    return
  end
  GameGlobal.UIStateManager():Lock("HomelandFollowCameraController:Focus")
  self._camTrans:DOMove(transform.position, focusTime, false)
  self._camTrans:DORotate(transform.eulerAngles, focusTime):OnComplete(function()
    GameGlobal.UIStateManager():UnLock("HomelandFollowCameraController:Focus")
    if rotateCompleteCallback then
      rotateCompleteCallback()
    end
  end)
end

function HomelandFollowCameraController:LeaveFocusUseAngles(time, callback)
  if not self._focusState then
    return
  end
  local focusTime = time
  focusTime = focusTime or self._defaultFocusTime
  if focusTime <= 0 then
    self._camTrans.transform.position = self._camPosBeforeFocus
    self._camTrans.transform.rotation = self._camRotBeforeFocus
    self._focusState = false
    if callback then
      callback()
    end
    return
  end
  GameGlobal.UIStateManager():Lock("HomelandFollowCameraController:LeaveFocus")
  self._camTrans:DOMove(self._camPosBeforeFocus, focusTime, false)
  self._camTrans:DORotate(self._camAnglesBeforeFocus, focusTime):OnComplete(function()
    self._focusState = false
    if callback then
      callback()
    end
    GameGlobal.UIStateManager():UnLock("HomelandFollowCameraController:LeaveFocus")
  end)
end
