_class("UIAircraft3DPet", Object)
UIAircraft3DPet = UIAircraft3DPet
local AircraftPetActionState = {
  Idle = 0,
  Moving = 1,
  Pressing = 2,
  Dragging = 3,
  Dropping = 4,
  Responding = 5,
  Interacting = 6,
  ReadyToMove = 7,
  Stop = 8
}
_enum("AircraftPetActionState", AircraftPetActionState)
local AircraftPetState = {
  Normal = 0,
  Selected = 1,
  Interactive = 2
}
_enum("AircraftPetState", AircraftPetState)
local AircraftPetFaceID = {Blink = 1, Click = 1}
_enum("AircraftPetFaceID", AircraftPetFaceID)

function UIAircraft3DPet:Constructor(resRequest, petGameObject, petData, room)
  self._aircraftPetState = AircraftPetState.Normal
  self._resRequests = resRequest
  self._petGO = petGameObject
  self._petData = petData
  self._standIdle = self._petData:GetPetAircraftIdle()
  self._room = room
  self._animator = petGameObject.transform:Find("Root"):GetComponent(typeof(UnityEngine.Animator))
  self._bubbleOffset = Vector3(0, 3, 0)
  self._bubbleCfgOffset = Vector3.zero
  local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(self._petGO)
  if skinnedMeshRender ~= nil then
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(self._petGO)
    self._bubbleOffset = Vector3(0, meshExtents.x * 2 * self._petGO.transform.localScale.y, 0)
  end
  self._nextActionCountdown = 0
  self._currentActionState = AircraftPetActionState.Stop
  self._interactFaceCountdown = 0
  self._interactIdleCountdown = 0
  self._nextActionCountdownMin = 1
  self._nextActionCountdownMax = 6
  self._interactCountdownMin = 10
  self._interactCountdownMax = 20
  self._interactIdleTime = 1
  self.animName = {}
  self.animName.walk = "Walk"
  self.animName.click = "Click01"
  local collider = self._petGO:AddComponent(typeof(UnityEngine.BoxCollider))
  collider.size = Vector3(0.5, 1.2, 0.5)
  collider.center = Vector3(0, 0.6, 0)
  self.respondTime = -1
  self.lastState = nil
  self.pickUpHeight = Cfg.cfg_aircraft_camera.petPickupHeight.Value
  self.clickWaitTime = Cfg.cfg_aircraft_camera.clickWaitTime.Value * 1000
  self._MaterialAnimation = self._petGO:GetComponent(typeof(MaterialAnimation))
  if not self._MaterialAnimation then
    self._MaterialAnimation = self._petGO:AddComponent(typeof(MaterialAnimation))
  end
  self._MaterialAnimationContainer = ResourceManager:GetInstance():SyncLoadAsset("globalShaderEffects.asset", LoadType.Asset)
  self._MaterialAnimation:AddClips(self._MaterialAnimationContainer.Obj)
  self._navMeshAgent = self._petGO:AddComponent(typeof(UnityEngine.AI.NavMeshAgent))
  self._navMeshAgent.angularSpeed = 1000
  self._navMeshAgent.stoppingDistance = 0.1
  self._navMeshAgent.speed = 1.1
  self._navMeshAgent.radius = 0.5
  self._navMeshAgent.autoBraking = false
  self._navMeshAgent.areaMask = 1 << self._room:GetNavLayerBySpaceID(self._room:SpaceID())
  self._navMeshObstacle = self._petGO:AddComponent(typeof(UnityEngine.AI.NavMeshObstacle))
  self._navMeshObstacle.shape = UnityEngine.AI.NavMeshObstacleShape.Capsule
  self._navMeshObstacle.radius = 0.5
  self._navMeshObstacle.carving = true
  self._navMeshObstacle.enabled = false
  self._velocityCheckTimer = 0
  self._lowVelocity = false
  self._movePauseTimer = 0
  self._pauseDone = false
  self._velocityCheckInterval = 500
  self._velocitySqrThreshold = self._navMeshAgent.speed * self._navMeshAgent.speed * 0.5
  self._movePauseTimeMin = 1000
  self._movePauseTimeMax = 2000
  self._hasOccupiedPoint = false
  self._occupiedArea = nil
  self._occupiedPoint = nil
  self._arrivedAreaAndPoint = {}
  self.clickEffCfg = Cfg.cfg_aircraft_click_eff[self._petData:GetTemplateID()]
  if self.clickEffCfg and self.clickEffCfg.EffName then
    self.clickEffReq = ResourceManager:GetInstance():SyncLoadAsset(self.clickEffCfg.EffName .. ".prefab", LoadType.GameObject)
    self.clickEff = self.clickEffReq.Obj
    self.clickEff.transform:SetParent(self._petGO.transform)
    self.clickEff.transform.localRotation = Quaternion.identity
    self.clickEff.transform.localScale = Vector3.one
    local cfgPos = self.clickEffCfg.PosOffset
    self.clickEff.transform.localPosition = Vector3(cfgPos[1], cfgPos[2], cfgPos[3])
    self.clickEffEvent = nil
  end
  self._addAffinityEffectName = "ui_click.prefab"
  self._addAffinityEffectReq = ResourceManager:GetInstance():SyncLoadAsset(self._addAffinityEffectName, LoadType.GameObject)
  self._addAffinityEffect = self._addAffinityEffectReq.Obj
  self._addAffinityEffect:SetActive(false)
  local face_name = tostring(self._petData:GetTemplateID()) .. "_face"
  local face = GameObjectHelper.FindChild(self._petGO.transform, face_name)
  if face then
    local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
    if not render then
      Log.fatal("星灵" .. self._petData:GetTemplateID() .. "面部mesh缺失，无法正确显示表情")
    else
      self._faceMat = self:GetMaterial(render)
    end
  end
  self._mainCamera = UnityEngine.GameObject.Find("Main Camera"):GetComponent("Camera")
  self:SetPetFace(AircraftPetFaceID.Blink)
  self._interactFaceID = AircraftPetFaceID.Blink
  self._petDataChangeHandler = GameHelper:GetInstance():CreateCallback(self._petDataChange, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.PetDataChangeEvent, self._petDataChangeHandler)
end

function UIAircraft3DPet:GetMaterial(render)
  return render.material
end

function UIAircraft3DPet:_Init()
  self:_ReleaseCurrentPoint()
  local areaList, pointList = self._room:GetAvailableAreaAndPoints()
  local sum = #areaList + #pointList
  if 0 < sum then
    self._hasOccupiedPoint = true
    local ran = math.random(1, sum)
    if ran <= #areaList then
      self._occupiedArea = areaList[ran]
      self._occupiedPoint = self._occupiedArea:GetAndOccupyAvailablePoint()
      self._petGO.transform.position = self._occupiedPoint:GetPos()
      self._petGO.transform.forward = self._occupiedPoint:GetForward()
      self._arrivedAreaAndPoint[#self._arrivedAreaAndPoint + 1] = self._occupiedArea
    else
      self._occupiedPoint = pointList[ran - #areaList]
      self._petGO.transform.position = self._occupiedPoint:GetPos()
      self._room:OccupyRestPoint(self._occupiedPoint:GetIndex())
      local randomRot = math.random(-180, 180)
      self._petGO.transform.rotation = Quaternion.Euler(0, randomRot, 0)
      self._arrivedAreaAndPoint[#self._arrivedAreaAndPoint + 1] = self._occupiedPoint
    end
  else
    Log.fatal("风船房间(space id：" .. self._room:GetRoomLogicData():SpaceId() .. ")没有足够的点位初始化宝宝")
  end
  self._nextActionCountdown = math.random(self._nextActionCountdownMin, self._nextActionCountdownMax)
  self._currentActionState = AircraftPetActionState.Idle
end

function UIAircraft3DPet:Dispose()
  self._MaterialAnimationContainer:Dispose()
  for _, req in ipairs(self._resRequests) do
    req:Dispose()
  end
  if self.clickEffEvent then
    GameGlobal.Timer():CancelEvent(self.clickEffEvent)
    self.clickEffEvent = nil
  end
  if self.clickEffReq then
    self.clickEffReq:Dispose()
  end
  if self._addAffinityEffectReq then
    self._addAffinityEffectReq:Dispose()
  end
  self:UnloadBubbleEffect()
  if self._petDataChangeHandler then
    GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.PetDataChangeEvent, self._petDataChangeHandler)
  end
end

function UIAircraft3DPet:StartNavi()
  self:_Init()
end

function UIAircraft3DPet:ForceInitAnimator()
  self:SetPetAnim(AircraftPetActionState.Idle)
  if self._standIdle and self._standIdle ~= "" then
    self._animator:CrossFade("stand", 0)
  end
end

function UIAircraft3DPet:StopNavi()
  self._currentActionState = AircraftPetActionState.Stop
end

function UIAircraft3DPet:Update(deltaTimeMS)
  self:_UpdateFace(deltaTimeMS)
  if self._aircraftPetState == AircraftPetState.Selected then
    return
  end
  if self._aircraftPetState == AircraftPetState.Interactive then
    if self._currentActionState == AircraftPetActionState.Responding then
      if self.respondTime < 0 then
        local animStateInfo = self._animator:GetNextAnimatorStateInfo(0)
        if animStateInfo:IsName("click01") then
          self.respondTime = animStateInfo.length + 0.1
        end
      else
        self.respondTime = self.respondTime - deltaTimeMS / 1000
        if self.respondTime < 0 then
          self._currentActionState = AircraftPetActionState.Idle
          self.respondTime = -1
        end
      end
    end
    return
  end
  if self._currentActionState == AircraftPetActionState.Stop then
    return
  end
  if self._currentActionState == AircraftPetActionState.Moving then
    if 0 < self._movePauseTimer then
      self._movePauseTimer = self._movePauseTimer - deltaTimeMS
      if 0 >= self._movePauseTimer then
        self._pauseDone = true
        self._navMeshObstacle.enabled = false
      end
    elseif self._pauseDone then
      self._navMeshAgent.enabled = true
      self._navMeshAgent.isStopped = false
      self._navMeshAgent.destination = self._occupiedPoint:GetPos()
      if not self._navMeshAgent.destination then
        Log.error("1111")
      end
      self._pauseDone = false
      self:SetPetAnim(AircraftPetActionState.Moving)
    elseif self._petGO.activeInHierarchy and self._navMeshAgent.enabled and self._navMeshAgent.remainingDistance < self._navMeshAgent.stoppingDistance then
      local forward = self._occupiedPoint:GetForward()
      if forward then
        self._petGO.transform.forward = forward
      end
      self._navMeshAgent.isStopped = true
      self._navMeshAgent.enabled = false
      self._navMeshObstacle.enabled = true
      self:_SwitchToInteractState()
    else
      self._velocityCheckTimer = self._velocityCheckTimer + deltaTimeMS
      if self._velocityCheckTimer > self._velocityCheckInterval then
        self._velocityCheckTimer = 0
        local velocitySqr = self._navMeshAgent.velocity:SqrMagnitude()
        if velocitySqr < self._velocitySqrThreshold then
          if self._lowVelocity then
            self._movePauseTimer = Mathf.Lerp(self._movePauseTimeMin, self._movePauseTimeMax, math.random())
            self._navMeshAgent.isStopped = true
            self._navMeshAgent.enabled = false
            self._navMeshObstacle.enabled = true
            self._lowVelocity = false
            self._velocityCheckTimer = 0
            self._pauseDone = false
            self:SetPetAnim(AircraftPetActionState.Idle)
          else
            self._lowVelocity = true
          end
        end
      end
    end
  elseif self._currentActionState == AircraftPetActionState.Idle then
    self._nextActionCountdown = self._nextActionCountdown - deltaTimeMS / 1000
    if 0 >= self._nextActionCountdown and self._petGO.activeInHierarchy then
      self._navMeshObstacle.enabled = false
      self._currentActionState = AircraftPetActionState.ReadyToMove
    end
  elseif self._currentActionState == AircraftPetActionState.Responding then
    if self.respondTime < 0 then
      local animStateInfo = self._animator:GetNextAnimatorStateInfo(0)
      if animStateInfo:IsName("click01") then
        self.respondTime = animStateInfo.length - 0.25
      end
    else
      self.respondTime = self.respondTime - deltaTimeMS / 1000
      if self.respondTime < 0 then
        self._currentActionState = self.lastState
        if self.lastState == AircraftPetActionState.Moving then
          self._movePauseTimer = self.clickWaitTime
        end
        self:SetPetFace(AircraftPetFaceID.Blink)
        self.lastState = nil
        self.respondTime = -1
        if self.clickEff then
          self.clickEff:SetActive(false)
        end
      end
    end
  elseif self._currentActionState == AircraftPetActionState.Interacting then
    local deltaTime = deltaTimeMS / 1000
    self._nextActionCountdown = self._nextActionCountdown - deltaTime
    if 0 >= self._nextActionCountdown and self._petGO.activeInHierarchy then
      self:SetPetFace(AircraftPetFaceID.Blink)
      self._navMeshObstacle.enabled = false
      self._currentActionState = AircraftPetActionState.ReadyToMove
    elseif 0 < self._interactFaceCountdown then
      self._interactFaceCountdown = self._interactFaceCountdown - deltaTime
      if 0 > self._interactFaceCountdown then
        self:SetPetFace(1)
        self._interactIdleCountdown = self._interactIdleTime
      end
    elseif 0 < self._interactIdleCountdown then
      self._interactIdleCountdown = self._interactIdleCountdown - deltaTime
      if 0 > self._interactIdleCountdown then
        self._interactFaceCountdown = self:SetPetFace(self._interactFaceID) or 0
      end
    end
  elseif self._currentActionState == AircraftPetActionState.ReadyToMove then
    self:_MoveToNextPoint()
  end
  self:_UpdateBubble()
end

function UIAircraft3DPet:_ReleaseCurrentPoint()
  if self._hasOccupiedPoint then
    if self._occupiedArea then
      self._occupiedArea:ReleasePoint(self._occupiedPoint:GetIndex())
      self._occupiedArea = nil
    else
      self._room:ReleaseRestPoint(self._occupiedPoint:GetIndex())
    end
    self._occupiedPoint = nil
  end
end

function UIAircraft3DPet:_MoveToNextPoint()
  self:_ReleaseCurrentPoint()
  if #self._arrivedAreaAndPoint >= self._room:GetAreaAndRestPointCount() then
    self._arrivedAreaAndPoint = {}
  end
  local areaList, pointList = self._room:GetAvailableAreaAndPoints()
  local filteredAreaList, filteredPointList = self:_FilterAreaPointList(areaList, pointList)
  local sum = #filteredAreaList + #filteredPointList
  if sum ~= 0 then
    areaList = filteredAreaList
    pointList = filteredPointList
  else
    sum = #areaList + #pointList
  end
  if 0 < sum then
    self._navMeshAgent.enabled = true
    local ran = math.random(1, sum)
    if ran <= #areaList then
      self._occupiedArea = areaList[ran]
      self._occupiedPoint = self._occupiedArea:GetAndOccupyAvailablePoint()
      self._navMeshAgent.destination = self._occupiedPoint:GetPos()
      if not self._navMeshAgent.destination then
        Log.error("1111")
      end
      self._arrivedAreaAndPoint[#self._arrivedAreaAndPoint + 1] = self._occupiedArea
    else
      self._occupiedPoint = pointList[ran - #areaList]
      self._navMeshAgent.destination = self._occupiedPoint:GetPos()
      if not self._navMeshAgent.destination then
        Log.error("1111")
      end
      self._room:OccupyRestPoint(self._occupiedPoint:GetIndex())
      self._arrivedAreaAndPoint[#self._arrivedAreaAndPoint + 1] = self._occupiedPoint
    end
    self._navMeshAgent.isStopped = false
    self:_SwitchToMovingState()
  else
    Log.fatal("风船房间(space id：" .. self._room:GetRoomLogicData():SpaceId() .. ")没有足够的点位给宝宝移动 待机30秒")
    self._nextActionCountdown = 30
  end
end

function UIAircraft3DPet:_FilterAreaPointList(areaList, pointList)
  local filteredAreaList = {}
  local filteredPointList = {}
  for i = 1, #areaList do
    local area = areaList[i]
    if not table.icontains(self._arrivedAreaAndPoint, area) then
      filteredAreaList[#filteredAreaList + 1] = area
    end
  end
  for i = 1, #pointList do
    local point = pointList[i]
    if not table.icontains(self._arrivedAreaAndPoint, point) then
      filteredPointList[#filteredPointList + 1] = point
    end
  end
  return filteredAreaList, filteredPointList
end

function UIAircraft3DPet:_SwitchToIdleState()
  self._currentActionState = AircraftPetActionState.Idle
  self:SetPetAnim(AircraftPetActionState.Idle)
  self._nextActionCountdown = math.random(self._nextActionCountdownMin, self._nextActionCountdownMax)
end

function UIAircraft3DPet:_SwitchToMovingState()
  self._currentActionState = AircraftPetActionState.Moving
  self:SetPetAnim(AircraftPetActionState.Moving)
  self:SetPetFace(AircraftPetFaceID.Blink)
  self._velocityCheckTimer = 0
  self._movePauseTimer = 0
end

function UIAircraft3DPet:_SwitchToInteractState()
  self._currentActionState = AircraftPetActionState.Interacting
  self:SetPetAnim(AircraftPetActionState.Idle)
  self._nextActionCountdown = math.random(self._interactCountdownMin, self._interactCountdownMax)
  self._interactIdleCountdown = self._interactIdleTime
  if self._occupiedPoint then
    local faceIDList = self._occupiedPoint:GetFaceIDList()
    local randomRes = math.random(1, #faceIDList)
    self._interactFaceID = faceIDList[randomRes]
    self._interactFaceCountdown = self:SetPetFace(self._interactFaceID) or 0
  end
end

function UIAircraft3DPet:PetGameObject()
  return self._petGO
end

function UIAircraft3DPet:GetPetData()
  return self._petData
end

function UIAircraft3DPet:PstID()
  return self._petData:GetPstID()
end

function UIAircraft3DPet:CurrentState()
  return self._currentActionState
end

function UIAircraft3DPet:InteractiveClick()
  if self._currentActionState == AircraftPetActionState.Responding then
    return
  end
  self:_CreateClickInteractiveEffect(self._petGO.transform.position)
  self._currentActionState = AircraftPetActionState.Responding
  self:SetPetAnim(AircraftPetActionState.Idle)
  self:SetPetAnim(AircraftPetActionState.Responding)
  self.respondTime = -1
  local tplID = self._petData:GetTemplateID()
  local pm = GameGlobal.GetModule(PetAudioModule)
  pm:PlayPetAudio("AircraftInteract", tplID)
  if self.clickEff then
    GameGlobal.Timer():AddEvent(self.clickEffCfg.DelayTime, function()
      self.clickEff:SetActive(false)
      self.clickEff:SetActive(true)
    end)
  end
  GameGlobal.TaskManager():StartTask(self.SendPetAddAffinity, self)
end

function UIAircraft3DPet:_CreateAddAffinityEffect()
  self._addAffinityEffect:SetActive(false)
  self._addAffinityEffect.transform.position = self._petGO.transform.position
  self._addAffinityEffect:SetActive(true)
end

function UIAircraft3DPet:_CreateClickInteractiveEffect(pos)
  local effectName = "ui_click_01.prefab"
  local delayTime = 1000
  local effectReq = ResourceManager:GetInstance():SyncLoadAsset(effectName, LoadType.GameObject)
  local effect = effectReq.Obj
  effect.transform.position = pos
  effect:SetActive(true)
  GameGlobal.Timer():AddEvent(delayTime, function()
    effectReq:Dispose()
  end)
end

function UIAircraft3DPet:SendPetAddAffinity(TT)
  if not self._petModule then
    self._petModule = GameGlobal.GetModule(PetModule)
  end
  local res, addValue = self._petModule:RequestPetAddAffinity(TT, self._petData:GetPstID())
  if res:GetSucc() then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftAddPetFavorable, addValue)
    self:_CreateAddAffinityEffect()
  end
end

function UIAircraft3DPet:EnterInteractiveState()
  self._aircraftPetState = AircraftPetState.Interactive
  self.lastState = self._currentActionState
  self._currentActionState = AircraftPetActionState.Idle
  self:SetPetAnim(AircraftPetActionState.Idle)
  local delta = self._mainCamera.transform.position - self._petGO.transform.position
  delta.y = 0
  self._petGO.transform.rotation = Quaternion.LookRotation(delta)
  self:HidFaceBubble()
  if self._navMeshAgent.enabled then
    if not self._navMeshAgent.isStopped then
      self._navMeshAgent.isStopped = true
    end
    self._navMeshAgent.enabled = false
  end
  if not self._navMeshObstacle.enabled then
    self._navMeshObstacle.enabled = true
  end
end

function UIAircraft3DPet:ExitInteractiveState()
  self._aircraftPetState = AircraftPetState.Normal
  self._addAffinityEffect:SetActive(false)
  self:RefreshFaceBubble()
end

function UIAircraft3DPet:_petDataChange()
  if self._faceId == 1001 or self._faceId == 2001 or self._faceId == 2002 or self._faceId == 2003 then
    self:RefreshFaceBubble()
    return
  end
end

function UIAircraft3DPet:RefreshFaceBubble()
  self:SetPetFace(AircraftPetFaceID.Blink)
  if self._bubbleGo then
    self._bubbleGo:SetActive(true)
  end
end

function UIAircraft3DPet:HidFaceBubble()
  if self._bubbleGo then
    self._bubbleGo:SetActive(false)
  end
end

function UIAircraft3DPet:OnClick()
  self:EnterSelectedState()
end

function UIAircraft3DPet:EnterSelectedState()
  self._aircraftPetState = AircraftPetState.Selected
  self._currentActionState = AircraftPetActionState.Idle
  self:SetPetAnim(AircraftPetActionState.Idle)
  local delta = self._mainCamera.transform.position - self._petGO.transform.position
  delta.y = 0
  self._petGO.transform.rotation = Quaternion.LookRotation(delta)
  self:HidFaceBubble()
  if self._navMeshAgent.enabled then
    if not self._navMeshAgent.isStopped then
      self._navMeshAgent.isStopped = true
    end
    self._navMeshAgent.enabled = false
  end
  if not self._navMeshObstacle.enabled then
    self._navMeshObstacle.enabled = true
  end
  local tplID = self._petData:GetTemplateID()
  local pm = GameGlobal.GetModule(PetAudioModule)
  pm:PlayPetAudio("AircraftClick", tplID)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftSelectPetEvent, self._room, self)
end

function UIAircraft3DPet:ExitSelectedState()
  self._aircraftPetState = AircraftPetState.Normal
  self:RefreshFaceBubble()
end

function UIAircraft3DPet:OnPressBegin()
  self.lastState = self._currentActionState
  self._currentActionState = AircraftPetActionState.Pressing
  if self._navMeshAgent.enabled and not self._navMeshAgent.isStopped then
    self._navMeshAgent.isStopped = true
  end
  self:SetPetAnim(AircraftPetActionState.Pressing)
  self:SetPetFace(AircraftPetFaceID.Blink)
end

function UIAircraft3DPet:CalSliderWorldPos()
  local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(self._petGO)
  local offset = Vector3(0, self._petData:GetHPOffset(), 0)
  if skinnedMeshRender ~= nil then
    local skinnedMeshPosition = skinnedMeshRender.transform.position + offset
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(self._petGO)
    local convertExtents = Vector3(0, meshExtents.x * 2 * self._petGO.transform.localScale.y, 0)
    local targetPos = skinnedMeshPosition + convertExtents
    return targetPos
  else
    Log.fatal("Pet", self._petGO.name, "has no skinned mesh")
    return self._petGO.transform.position + offset
  end
end

function UIAircraft3DPet:PickUp()
  self._navMeshAgent.enabled = false
  self._navMeshObstacle.enabled = false
  self._petGO.transform.localPosition = self._petGO.transform.localPosition + Vector3(0, self.pickUpHeight, 0)
  self._MaterialAnimation:Play("common_select")
  self._animator.speed = 0
end

function UIAircraft3DPet:OnDrag(_worldPos)
  self._petGO.transform.position = _worldPos + Vector3(0, self.pickUpHeight, 0)
end

function UIAircraft3DPet:OnCountEnd()
  self._currentActionState = self.lastState
  if self.lastState == AircraftPetActionState.Moving then
    self._navMeshAgent.isStopped = false
    self:SetPetAnim(AircraftPetActionState.Moving)
  end
  self.lastState = nil
end

function UIAircraft3DPet:OnPressEnd()
  self._MaterialAnimation:Stop()
  self._navMeshAgent.enabled = true
  self._petGO.transform.localPosition = self._petGO.transform.localPosition + Vector3(0, -self.pickUpHeight, 0)
  self:_SwitchToIdleState()
  self._animator.speed = 1
end

function UIAircraft3DPet:OnDrop()
  self._MaterialAnimation:Stop()
  self._animator.speed = 1
  self._navMeshAgent.enabled = true
  self._petGO.transform.localPosition = self._petGO.transform.localPosition + Vector3(0, -self.pickUpHeight, 0)
  self._navMeshAgent:Move(Vector3.zero)
  self._navMeshAgent.enabled = false
  self._navMeshObstacle.enabled = true
  self:_SwitchToIdleState()
end

function UIAircraft3DPet:SetPetAnim(state)
  if state == AircraftPetActionState.Idle then
    if self._standIdle and self._standIdle ~= "" then
      self._animator:SetBool(self._standIdle, true)
    end
    self._animator:SetBool(self.animName.walk, false)
  elseif state == AircraftPetActionState.Moving then
    if self._standIdle and self._standIdle ~= "" then
      self._animator:SetBool(self._standIdle, false)
    end
    self._animator:SetBool(self.animName.walk, true)
  elseif state == AircraftPetActionState.Responding then
    self._animator:SetTrigger(self.animName.click)
  else
    if state == AircraftPetActionState.Pressing then
      if self._standIdle and self._standIdle ~= "" then
        self._animator:SetBool(self._standIdle, true)
      end
      self._animator:SetBool(self.animName.walk, false)
    else
    end
  end
end

function UIAircraft3DPet:SetPetFace(id)
  local taskId = self._petData:GetTriggeredTaskId()
  local storyId = self._petData:GetTriggeredStoryId()
  local hasPlot = storyId and storyId ~= 0
  local hasEvent = taskId and taskId ~= 0
  if hasPlot then
    id = 1001
  elseif hasEvent then
    local taskInfo = self._petData:GetFirstTaskInfo()
    if taskInfo then
      local state = taskInfo.state
      if state == PetTaskState.PetTS_Active then
        id = 2001
      elseif state == PetTaskState.PetTS_Accept then
        id = 2002
      elseif state == PetTaskState.PetTS_Finish then
        id = 2003
      end
    else
      id = 2001
    end
  end
  local cfg = Cfg.cfg_aircraft_pet_face[id]
  if not cfg then
    Log.fatal("[Aircraft] SetPetFace config id not find ", id)
    return
  end
  if self._faceId == id then
    return
  end
  self:UnloadBubbleEffect()
  if cfg.BubbleEffect then
    local bubbleRequest = self:LoadBubbleEffect(cfg.BubbleEffect)
    if bubbleRequest then
      local bubble = bubbleRequest.Obj
      local effectParentName = cfg.BubbleNode
      local effectParent
      if effectParentName then
        effectParent = GameObjectHelper.FindChild(self._petGO.transform, effectParentName)
      end
      if effectParent then
        bubble.transform:SetParent(effectParent)
        local pos = Vector3(table.unpack(cfg.BubbleOffset))
        bubble.transform.position = effectParent.position + pos
      else
        bubble.transform:SetParent(self._petGO.transform)
        bubble.transform.position = self:CalcBubblePos()
      end
      bubble.transform.rotation = self:CalcBubbleRotation()
      self._bubbleGo = bubble
      self._bubbleReq = bubbleRequest
    end
    self._bubbleCfgOffset = Vector3(table.unpack(cfg.BubbleOffset))
  end
  self._faceId = id
  self._faceSeqIdx = 1
  self._faceSeqIdxTime = 0
  self._faceLastTime = 100
  return cfg.Length / 1000
end

function UIAircraft3DPet:_UpdateFace(deltaTimeMS)
  if not (self._faceId and self._faceMat) or self._faceLastTime <= 0 then
    return
  end
  self._faceSeqIdxTime = self._faceSeqIdxTime + deltaTimeMS
  if self._faceSeqIdxTime > self._faceLastTime then
    self._faceSeqIdxTime = 0
    local cfg = Cfg.cfg_aircraft_pet_face[self._faceId]
    self._faceSeqIdx = self._faceSeqIdx + 1
    if self._faceSeqIdx > #cfg.FaceSeq then
      self._faceSeqIdx = 1
    end
    local seq = cfg.FaceSeq[self._faceSeqIdx]
    local face_frame = seq[1]
    self._faceLastTime = seq[2]
    self._faceMat:SetInt("_Frame", face_frame)
  end
end

function UIAircraft3DPet:_UpdateBubble()
  local bubble = self._bubbleGo
  if bubble then
    bubble.transform.rotation = self:CalcBubbleRotation()
  end
end

function UIAircraft3DPet:LoadBubbleEffect(resPath)
  local request = ResourceManager:GetInstance():SyncLoadAsset(resPath, LoadType.GameObject)
  if request == nil then
    Log.fatal("Load Effect failed", resPath)
    return
  end
  local u3dGo = request.Obj
  u3dGo:SetActive(true)
  return request
end

function UIAircraft3DPet:UnloadBubbleEffect()
  if self._bubbleReq then
    self._bubbleReq:Dispose()
    self._bubbleReq = nil
  end
  self._bubbleGo = nil
end

function UIAircraft3DPet:CalcBubbleRotation()
  local qbase = self._mainCamera.transform.rotation
  local vforward = self._mainCamera.transform.forward
  local vplane_normal = Vector3(0, 1, 0)
  local vproject = Vector3.ProjectOnPlane(vforward, vplane_normal)
  local target = qbase * Quaternion.FromToRotation(vforward, vproject)
  return target
end

function UIAircraft3DPet:CalcBubblePos()
  local slot = GameObjectHelper.FindChild(self._petGO.transform, "EffectSlot")
  local pos = slot.position + self._bubbleOffset + self._bubbleCfgOffset
  return pos
end

function UIAircraft3DPet:CalcBubblePos2(bubble_offset)
  local pos = self._petGO.transform.position
  local skinnedMeshRender = GameObjectHelper.FindFirstSkinedMeshRender(self._petGO)
  if skinnedMeshRender ~= nil then
    local skinnedMeshPosition = skinnedMeshRender.transform.position + Vector3(bubble_offset.x, bubble_offset.y, 0)
    local meshExtents = GameObjectHelper.FindFirstSkinedMeshRenderBoundsExtent(self._petGO)
    local convertExtents = Vector3(0, meshExtents.x * 2, 0)
    pos = skinnedMeshPosition + convertExtents
  else
    Log.fatal("pet ", self._petGO.name, " has no skinned mesh")
  end
  return pos
end
