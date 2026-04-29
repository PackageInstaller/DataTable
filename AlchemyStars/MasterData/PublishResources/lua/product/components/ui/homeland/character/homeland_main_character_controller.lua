_class("HomelandMainCharacterController", Object)
HomelandMainCharacterController = HomelandMainCharacterController

function HomelandMainCharacterController:Constructor()
  self._baseResName = "1000011"
  self._resName = "1000011"
  self._fsm = HomelandActorStateMachine:New()
  self._rotateSpeed = 1
  self._targetForward = nil
  self._currentForward = nil
  self._meshRenderers = nil
  self._forbiddenMove = false
  self._isFishMatch = false
  self._defaultInteractLerpTime = 0.5
  self._defaultInteractDuration = 1
  self._attachedModel = nil
  self._attachedEffect = {}
  self._storyLayerIdx = 1
  self._receiveMoveInput = true
  self._floatEffectName = "eff_yyc_yy_shuihua01.prefab"
  self._swimEffectName = "eff_yyc_yy_shuihua02.prefab"
  self._floatEffect = nil
  self._swimEffect = nil
end

function HomelandMainCharacterController:Init(homelandClient)
  self._inputManager = homelandClient:InputManager()
  self._followCamCon = homelandClient:CameraManager():FollowCameraController()
  self._effMng = homelandClient:GetHomelandSceneEffectManager()
  self._homelandClient = homelandClient
  self:OnInitAssetModelComponent()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, HomelandMapIconType.Player, 1, self._charTrans, nil)
  self._saveBuildingCallback = GameHelper:GetInstance():CreateCallback(self.OnSaveBuilding, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._saveBuildingCallback)
  self._onNavmeshUpdated = GameHelper:GetInstance():CreateCallback(self.UpdateFollowCamPos, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.OnHomelandNavmeshUpdated, self._onNavmeshUpdated)
  self._onSetReceiveMoveInput = GameHelper:GetInstance():CreateCallback(self.OnSetReceiveMoveInput, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomelandSetMainCharReceiveMoveInput, self._onSetReceiveMoveInput)
  self._fsm:Init(self)
  self._fsm:SwitchState(HomelandActorStateType.Idle)
end

function HomelandMainCharacterController:OnInitAssetModelComponent()
  self._resReq = ResourceManager:GetInstance():SyncLoadAsset(self._resName .. ".prefab", LoadType.GameObject)
  self._charGO = self._resReq.Obj
  self._charTrans = self._charGO.transform
  self._root = GameObjectHelper.FindChild(self._charTrans, "Root")
  self._renders = self._root:GetComponentsInChildren(typeof(UnityEngine.Renderer), true)
  self._headSlot = GameObjectHelper.FindChild(self._charTrans, "Bip001 Head")
  if not self._headSlot then
    Log.error("Homeland Chara Bip001 Head Not Found.")
  end
  local face_name = self._resName .. "_face"
  local face = GameObjectHelper.FindChild(self._charTrans, face_name)
  if face then
    local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
    if not render then
      Log.error("面部表情节点上找不到SkinnedMeshRenderer：", face_name)
    else
      self._faceMat = render.material
    end
  else
    Log.error("找不到面部表情节点：", face_name)
  end
  self._charTrans:SetParent(self._homelandClient:SceneManager():RuntimeRootTrans(), false)
  self._currentForward = self._charTrans.forward
  self._charGO:SetActive(true)
  local mrSharpArray = self._charGO:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
  self._meshRenderers = mrSharpArray:ToTable()
  self._fadeCmp = self._charGO:AddComponent(typeof(FadeComponent))
  self._aniResReq = ResourceManager:GetInstance():SyncLoadAsset(1000011 .. "_battle.prefab", LoadType.GameObject)
  local anim = self._aniResReq.Obj:GetComponent(typeof(UnityEngine.Animator))
  self._animator = self._charGO:GetComponentInChildren(typeof(UnityEngine.Animator))
  self._animator.runtimeAnimatorController = anim.runtimeAnimatorController
  self._navMeshAgent = self._charGO:AddComponent(typeof(UnityEngine.AI.NavMeshAgent))
  self._navMeshAgent.agentTypeID = HelperProxy:GetInstance():GetNavAgentID(AircraftNavAgent.Normal)
  self._navMeshAgent.avoidancePriority = 40
  self._navMeshAgent.radius = 0.15
  self._navMeshAgent.speed = 5
  self._navMeshAgent.areaMask = 1
  self._shadow = self._charGO:GetComponent(typeof(ShadowmapCheckPoint))
  if not self._shadow then
    self._shadow = self._charGO:AddComponent(typeof(ShadowmapCheckPoint))
  end
end

function HomelandMainCharacterController:Dispose()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandBuildOnSaveBuilding, self._saveBuildingCallback)
  self._saveBuildingCallback = nil
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.OnHomelandNavmeshUpdated, self._onNavmeshUpdated)
  self._onNavmeshUpdated = nil
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomelandSetMainCharReceiveMoveInput, self._onSetReceiveMoveInput)
  self._onSetReceiveMoveInput = nil
  if self._interactTaskID then
    local task = GameGlobal.TaskManager():FindTask(self._interactTaskID)
    if task and task.state ~= TaskState.Stop then
      GameGlobal.TaskManager():KillTask(self._interactTaskID)
      self._interactTaskID = nil
      self:ClearInteractRes()
    end
  end
  self._fsm:Dispose()
  self._fsm = nil
  self:ReleaseAttachedModel()
  self:ReleaseAttachedEffectAll()
  self._aniResReq:Dispose()
  self._resReq:Dispose()
  self._resReq = nil
  self._charGO = nil
  self._charTrans = nil
  self._animator = nil
  self._meshRenderers = nil
  self:DisposeSwimEffect()
end

function HomelandMainCharacterController:Update(deltaTimeMS)
  self:LerpForward(deltaTimeMS)
  self:OnCheckRoleInSwimmingArea()
  self:OnCheckRoleOutSwimmingPoolArea()
  self._fsm:Update(deltaTimeMS)
  if self._playFace then
    self._curTime = self._curTime + deltaTimeMS
    if self._faceSeq and table.count(self._faceSeq) > 0 and self._faceIdx <= #self._faceSeq and self._curTime > self._faceSeq[self._faceIdx].time then
      self._faceIdx = self._faceIdx + 1
      if self._faceIdx <= #self._faceSeq then
        self:SetFace(self._faceSeq[self._faceIdx].frame)
      end
    end
    if self._type == HomePetBubbleType.Tex then
      if self._talkUnit then
        local pos = self:HeadPos()
        self._talkUnit:SetPos(pos)
        local rot = self._camera:Rotation()
        self._talkUnit:SetRotation(rot)
      end
    elseif self._type == HomePetBubbleType.Bubble and self._bubbleEffectID then
      self:UpdateBubblePos()
    end
    if self._curTime >= self._duration then
      self._playFace = false
      self:DisposeBubble()
    end
  end
  for i = 0, self._renders.Length - 1 do
    if self._renders[i].material.shader.renderQueue < 2500 then
      self._renders[i].sortingOrder = 10
    else
      self._renders[i].sortingOrder = 0
    end
  end
end

function HomelandMainCharacterController:OnSaveBuilding(updateBuildings, deleteBuildings)
  if not self._interactContext then
    return
  end
  for _, building in ipairs(updateBuildings) do
    if self._interactContext.InteractingBuilding == building then
      self:InterruptInteract()
      return
    end
  end
  for _, building in ipairs(deleteBuildings) do
    if self._interactContext.InteractingBuilding == building then
      self:InterruptInteract()
      return
    end
  end
end

function HomelandMainCharacterController:UpdateFollowCamPos()
  self._followCamCon:UpdatePos(self._charTrans.position)
end

function HomelandMainCharacterController:OnSetReceiveMoveInput(canReceive)
  self._receiveMoveInput = canReceive
end

function HomelandMainCharacterController:CanReceiveMoveInput()
  return self._receiveMoveInput
end

function HomelandMainCharacterController:IsInteracting()
  return self._interactContext ~= nil
end

function HomelandMainCharacterController:GetTargetForward()
  return self._targetForward
end

function HomelandMainCharacterController:GetCurrentForward()
  return self._currentForward
end

function HomelandMainCharacterController:ClearInteractRes()
  self:ReleaseInteractEffRole()
  self:ReleaseInteractEffBuilding()
end

function HomelandMainCharacterController:InterruptInteract()
  self._interactContext.InterruptInteraction = true
  self._animator:Play("idle")
  local redius = 10
  local hit = false
  local navMeshHit
  while not hit do
    hit, navMeshHit = UnityEngine.AI.NavMesh.SamplePosition(self._charTrans.position, nil, redius, 1)
    redius = redius + 10
  end
  local task = GameGlobal.TaskManager():FindTask(self._interactTaskID)
  if task and task.state ~= TaskState.Stop then
    GameGlobal.TaskManager():KillTask(self._interactTaskID)
    self._interactTaskID = nil
  end
  if self._interactContext.TrFollowBuilding ~= nil then
    self._charTrans:SetParent(self._homelandClient:SceneManager():RuntimeRootTrans(), true)
    self._charTrans:SetSiblingIndex(0)
  end
  self:SetAnimatorBool("Interact", false)
  if self._interactContext.CfgRoleAnim.In.functionEnum then
    self:OnSetReceiveMoveInput(true)
  end
  self._charTrans.position = navMeshHit.position
  self._followCamCon:UpdatePos(navMeshHit.position)
  self._navMeshAgent.enabled = true
  self._fsm:SwitchState(HomelandActorStateType.Idle)
  self._interactContext.InteractPoint:SetInteractObject(nil)
  self._interactContext.InteractingBuilding:RemoveInteractObject(tonumber(self._baseResName))
  self._interactContext.InteractingBuilding:TryStopAnimation()
  self._interactTaskID = nil
  self._interactContext.TrFollowBuilding = nil
  self._interactContext.InteractPoint = nil
  self._interactContext.InteractingBuilding = nil
  self:ClearInteractRes()
  self._interactContext = nil
end

function HomelandMainCharacterController:NavigateToPos(TT, pos)
  local moveHold = false
  local currentStateType = self._fsm:CurrenStateType()
  if currentStateType == HomelandActorStateType.Run or currentStateType == HomelandActorStateType.Swim then
    moveHold = true
  end
  self._fsm:SwitchState(HomelandActorStateType.Navigate, pos, moveHold)
  while self._fsm:CurrenStateType() == HomelandActorStateType.Navigate do
    YIELD(TT)
  end
  return self._fsm:CurrenStateType() == HomelandActorStateType.Idle
end

function HomelandMainCharacterController:Move(movement, moveState, deltaTimeMS)
  if not self._receiveMoveInput then
    return
  end
  if self._forbiddenMove then
    return
  end
  self._fsm:HandleEvent(HomelandActorStateEventType.Move, movement, moveState, deltaTimeMS)
end

function HomelandMainCharacterController:SetTargetForward(forward)
  self._targetForward = forward
end

function HomelandMainCharacterController:LerpForward(deltaTimeMS)
  if not self._targetForward then
    return
  end
  if self._targetForward == self._currentForward then
    self._targetForward = nil
    return
  end
  local angle = math.abs(Vector3.Angle(self._currentForward, self._targetForward))
  local deltaRotateAngle = self._rotateSpeed * deltaTimeMS
  if angle <= deltaRotateAngle then
    self._currentForward = self._targetForward
    self._targetForward = nil
  else
    self._currentForward = Vector3.Slerp(self._currentForward, self._targetForward, deltaRotateAngle / angle)
  end
  self._charTrans.forward = self._currentForward
end

function HomelandMainCharacterController:SetForward(forward, immediately)
  forward.y = 0
  if immediately then
    self._currentForward = forward:SetNormalize()
    self._charTrans.forward = self._currentForward
    self._targetForward = nil
  else
    self._targetForward = forward:SetNormalize()
  end
end

function HomelandMainCharacterController:Dash(callback)
  self._fsm:HandleEvent(HomelandActorStateEventType.Dash, callback)
end

function HomelandMainCharacterController:SetLocation(position, rotation)
  self._navMeshAgent:Warp(position)
  self._charTrans.rotation = rotation
  self._targetForward = self._charTrans.forward
  self._currentForward = self._targetForward
  self._followCamCon:UpdatePos(self._charTrans.position)
end

function HomelandMainCharacterController:Position()
  return self._charTrans.position
end

function HomelandMainCharacterController:Transform()
  return self._charTrans
end

function HomelandMainCharacterController:State()
  return self._fsm:CurrenStateType()
end

function HomelandMainCharacterController:IsForbiddenMove()
  return self._forbiddenMove
end

function HomelandMainCharacterController:SetForbiddenMove(forbidden, keepState)
  if self._forbiddenMove == forbidden or self._isFishMatch then
    return
  end
  self._forbiddenMove = forbidden
  if forbidden then
    self._animator:SetBool("Run", false)
    self._animator:SetBool("Walk", false)
    self._animator:SetBool("DashState", false)
    self._inputManager:ResetCurController()
    if not keepState then
      self._fsm:SwitchState(HomelandActorStateType.Idle)
    end
  end
end

function HomelandMainCharacterController:SetHoldAxe()
  self._fsm:SwitchState(HomelandActorStateType.Axe)
end

function HomelandMainCharacterController:SetHoldPick()
  self._fsm:SwitchState(HomelandActorStateType.Pick)
end

function HomelandMainCharacterController:SetAnimatorTrigger(triggerName)
  self._animator:SetTrigger(triggerName)
end

function HomelandMainCharacterController:SetAnimatorBool(triggerName, triggerValue)
  self._animator:SetBool(triggerName, triggerValue)
end

function HomelandMainCharacterController:GetAnimatorBool(boolName)
  return self._animator:GetBool(boolName)
end

function HomelandMainCharacterController:ResetStateAndAnim()
  self._fsm:SwitchState(HomelandActorStateType.Idle)
end

function HomelandMainCharacterController:OnModeChanged(TT, mode)
  local visible = mode == HomelandMode.Normal
  local state = self._fsm:CurrenStateType()
  if visible then
    self._charGO:SetActive(visible)
    for k, v in pairs(self._meshRenderers) do
      v.enabled = visible
    end
  elseif state == HomelandActorStateType.Interact then
    for k, v in pairs(self._meshRenderers) do
      v.enabled = visible
    end
    if self._interactContext and self._interactContext.RoleEffReq and self._interactContext.RoleEffReq.Obj then
      self._interactContext.RoleEffReq.Obj:SetActive(false)
    end
  else
    self._charGO:SetActive(visible)
  end
  if visible then
    if self._fsm:CurrenStateType() == HomelandActorStateType.Interact then
      if self._interactContext and self._interactContext.RoleEffReq and self._interactContext.RoleEffReq.Obj then
        self._interactContext.RoleEffReq.Obj:SetActive(true)
      end
    else
      self._fsm:SwitchState(HomelandActorStateType.Idle)
      self._inputManager:ResetCurController()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCharacterStartMove)
      YIELD(TT)
      self:UpdateFollowCamPos()
      if not self._navMeshAgent.isOnNavMesh then
        local hit, navMeshHit = UnityEngine.AI.NavMesh.SamplePosition(self._charTrans.position, nil, 10, 1)
        if hit then
          self._charTrans.position = navMeshHit.position
          self._navMeshAgent.enabled = false
          self._navMeshAgent.enabled = true
          self:UpdateFollowCamPos()
        end
      end
    end
  end
end

function HomelandMainCharacterController:Interact(homeBuilding, index, interactPoint)
  if self._fsm:CurrenStateType() ~= HomelandActorStateType.Idle then
    return
  end
  local cfgArchitecture = Cfg.cfg_item_architecture[homeBuilding:GetBuildId()]
  local roleInteractID = cfgArchitecture.LeadRoleInteraction
  if not roleInteractID then
    Log.fatal("建筑未配置主角交互表现 建筑id:", cfgArchitecture.ID)
    return
  end
  local cfgRoleAnim = Cfg.cfg_homeland_building_role[cfgArchitecture.LeadRoleInteraction]
  if not cfgRoleAnim then
    Log.fatal("cfg_homeland_building_role 中未找到交互配置 id:", cfgArchitecture.ID, " 建筑id:", cfgArchitecture.ID)
    return
  end
  self._interactTaskID = GameGlobal.TaskManager():StartTask(self.InteractCoro, self, homeBuilding, index, interactPoint, cfgRoleAnim)
end

function HomelandMainCharacterController:InteractCoro(TT, homeBuilding, index, interactPoint, cfgRoleAnim)
  self._fsm:SwitchState(HomelandActorStateType.Interact)
  self._interactContext = HomelandMainCharacterInteractContext:New()
  self._interactContext.InteractingBuilding = homeBuilding
  self._interactContext.Index = index
  self._interactContext.InteractPoint = interactPoint
  self._interactContext.CfgRoleAnim = cfgRoleAnim
  self._interactContext.InterruptInteraction = false
  self._interactContext.TrFollowBuilding = nil
  self._interactContext.TargetTransform = homeBuilding:GetInteractTransform(index)
  self._interactContext.AttachTransform = self._interactContext.TargetTransform:GetChild(0)
  self:InteractCoroStart(TT)
  self:InteractCoroIn(TT)
  self:InteractCoroLoop(TT)
  self:InteractCoroOut(TT)
  self:InteractCoroEnd(TT)
end

function HomelandMainCharacterController:InteractCoroStart(TT)
  self._interactContext.InteractPoint:SetInteractObject(self)
  self._interactContext.InteractingBuilding:AddInteractObject(tonumber(self._baseResName))
  self._navMeshAgent.enabled = false
  self:SetForward(self._interactContext.TargetTransform.forward)
  local tweener = self._charTrans:DOMove(self._interactContext.TargetTransform.position, 0.1):OnUpdate(function()
  end)
  while self._targetForward or tweener.active do
    YIELD(TT)
  end
  self._interactContext.CamLerpMs = 200
  self:SetForward(self._interactContext.AttachTransform.forward, true)
end

function HomelandMainCharacterController:InteractCoroIn(TT)
  local gameGlobal = GameGlobal:GetInstance()
  local lerpTime = self._defaultInteractLerpTime
  self:SetAnimatorBool("Interact", true)
  if self._interactContext.InteractingBuilding:IsMultiInteract() and not self._interactContext.InteractingBuilding:IsFirstInteractObject(tonumber(self._baseResName)) then
    self._charTrans.position = self._interactContext.AttachTransform.position
  else
    local inData = self._interactContext.CfgRoleAnim.In
    if inData and inData.lerp then
      lerpTime = inData.lerp
    end
    if lerpTime <= 0 then
      self._charTrans.position = self._interactContext.AttachTransform.position
    else
      self._charTrans:DOMove(self._interactContext.AttachTransform.position, lerpTime):OnUpdate(function()
      end)
    end
    if inData then
      if inData.anim then
        self:SetAnimatorTrigger(inData.anim)
      end
      if inData.roleEff then
        self:LoadInteractEffRole(TT, inData.roleEff, inData.roleEffHangPath)
      end
      if inData.buildingEff then
        self:LoadInteractEffBuilding(TT, inData.buildingEff, inData.buildingEffHangPath, self._interactContext.InteractingBuilding)
      end
      if inData.buildingAnim then
        if self._interactContext.InteractingBuilding:IsFirstInteractObject(tonumber(self._baseResName)) then
          self._interactContext.InteractingBuilding:PlayAnimation(inData.buildingAnim, self._baseResName, HomelandInteractAnimationType.In)
        end
        self._interactContext.InteractingBuilding:UpdateInteractObject(tonumber(self._baseResName), inData.buildingAnim)
      end
      if inData.followBuilding then
        self._interactContext.TrFollowBuilding = HomeBuilding.FindRecursively(self._interactContext.InteractingBuilding, inData.followBuilding)
      end
      if inData.camLookAt then
        self._interactContext.TrLookAt = HomeBuilding.FindRecursively(nil, inData.camLookAt, self._charTrans)
      else
        self._interactContext.TrLookAt = nil
      end
      if inData.camLerp ~= nil then
        self._interactContext.CamLerpMs = inData.camLerp * 1000
      end
      if inData.functionEnum then
        self:OnSetReceiveMoveInput(false)
      end
    end
    if self._interactContext.TrFollowBuilding then
      self._charTrans:SetParent(self._interactContext.TrFollowBuilding, true)
    end
    if self._interactContext.TrLookAt ~= nil then
      self:InteractCoroSmoothCam(TT, self._interactContext.TrLookAt, self._interactContext.CamLerpMs)
    end
    local duration = self._defaultInteractDuration
    if inData and inData.duration then
      duration = inData.duration
    end
    local waitTime = duration
    local loopDuration = waitTime
    while 0 < loopDuration do
      if self._interactContext.TrLookAt ~= nil then
        self._followCamCon:UpdatePos(self._interactContext.TrLookAt.position)
      end
      local deltaMS = gameGlobal:GetDeltaTime()
      loopDuration = loopDuration - deltaMS * 0.001
      YIELD(TT)
    end
    self:ReleaseInteractEffRole()
    self:ReleaseInteractEffBuilding()
    if inData.functionEnum == HomelandRoleInteractingFunction.ChangeSwimsuit then
      self._interactContext.InterruptInteraction = true
      self:OnChangeSwimsuit(self._interactContext.InteractingBuilding)
      self._navMeshAgent.enabled = false
      self:SetAnimatorBool("Interact", true)
    end
  end
end

function HomelandMainCharacterController:InteractCoroLoop(TT)
  local loopData = self._interactContext.CfgRoleAnim.Loop
  local loopDuration = math.maxinteger
  if loopData then
    if loopData.roleEff then
      self:LoadInteractEffRole(TT, loopData.roleEff, loopData.roleEffHangPath)
    end
    if loopData.buildingEff then
      self:LoadInteractEffBuilding(TT, loopData.buildingEff, loopData.buildingEffHangPath, self._interactContext.InteractingBuilding)
    end
    if loopData.anim then
      self._interactContext.InteractingBuilding:UpdateInteractObject(tonumber(self._baseResName), loopData.buildingAnim)
      if self._interactContext.InteractingBuilding:IsMultiInteract() then
        if self._interactContext.InteractingBuilding:IsFirstInteractObject(tonumber(self._baseResName)) then
          self:SetAnimatorTrigger(loopData.anim)
        else
          while self._interactContext.InteractingBuilding:GetCurAnimationType() ~= HomelandInteractAnimationType.Loop do
            YIELD(TT)
          end
          local animationState = self._interactContext.InteractingBuilding:GetCurAnimationState()
          if animationState and loopData.buildingAnim then
            local percent = animationState.time % animationState.length / animationState.length
            self._animator:Play(loopData.buildingAnim, 0, percent)
          else
            self:SetAnimatorTrigger(loopData.anim)
          end
        end
      else
        self:SetAnimatorTrigger(loopData.anim)
      end
    else
      self._interactContext.InteractingBuilding:UpdateInteractObject(tonumber(self._baseResName), loopData.buildingAnim)
      if self._interactContext.InteractingBuilding:IsMultiInteract() then
        while self._interactContext.InteractingBuilding:GetCurAnimationType() ~= HomelandInteractAnimationType.Loop and not self._interactContext.InteractingBuilding:IsFirstInteractObject(tonumber(self._baseResName)) do
          YIELD(TT)
        end
        local animationState = self._interactContext.InteractingBuilding:GetCurAnimationState()
        if animationState and loopData.buildingAnim then
          local percent = animationState.time % animationState.length / animationState.length
          self._animator:Play(loopData.buildingAnim, 0, percent)
        end
      end
    end
    if loopData.buildingAnim and self._interactContext.InteractingBuilding:IsFirstInteractObject(tonumber(self._baseResName)) then
      self._interactContext.InteractingBuilding:PlayAnimation(loopData.buildingAnim, self._baseResName, HomelandInteractAnimationType.Loop)
    end
    if loopData.duration then
      loopDuration = loopData.duration
    end
    if loopData.camLookAt then
      self._interactContext.TrLookAt = HomeBuilding.FindRecursively(nil, loopData.camLookAt, self._charTrans)
    else
      self._interactContext.TrLookAt = nil
    end
    if loopData.camLerp ~= nil then
      self._interactContext.CamLerpMs = loopData.camLerp * 1000
    end
  end
  if self._interactContext.TrLookAt ~= nil then
    self:InteractCoroSmoothCam(TT, self._interactContext.TrLookAt, self._interactContext.CamLerpMs)
  end
  local gameGlobal = GameGlobal:GetInstance()
  while not self._interactContext.InterruptInteraction and 0 < loopDuration do
    if self._interactContext.TrLookAt ~= nil then
      self._followCamCon:UpdatePos(self._interactContext.TrLookAt.position)
    end
    local deltaMS = gameGlobal:GetDeltaTime()
    loopDuration = loopDuration - deltaMS * 0.001
    YIELD(TT)
  end
  self:ReleaseInteractEffRole()
  self:ReleaseInteractEffBuilding()
end

function HomelandMainCharacterController:InteractCoroOut(TT)
  local outData = self._interactContext.CfgRoleAnim.Out
  self:SetAnimatorTrigger("InteractEnd")
  if outData and outData.byLoopEnd then
    local stateNameHash = self._animator:GetCurrentAnimatorStateInfo(0).shortNameHash
    while true do
      YIELD(TT)
      if stateNameHash ~= self._animator:GetCurrentAnimatorStateInfo(0).shortNameHash then
        break
      end
    end
  end
  local lerpTime = self._defaultInteractLerpTime
  local leaveTime = self._defaultInteractDuration
  local leaveTransform = self._interactContext.TargetTransform
  if outData then
    if outData.roleEff then
      self:LoadInteractEffRole(TT, outData.roleEff, outData.roleEffHangPath)
    end
    if outData.buildingEff then
      self:LoadInteractEffBuilding(TT, outData.buildingEff, outData.buildingEffHangPath, self._interactContext.InteractingBuilding)
    end
    if outData.anim then
      self:SetAnimatorTrigger(outData.anim)
    end
    if outData.lerp then
      lerpTime = outData.lerp
    end
    if outData.buildingAnim and self._interactContext.InteractingBuilding:IsLastInteractObject(tonumber(self._baseResName)) then
      self._interactContext.InteractingBuilding:PlayAnimation(outData.buildingAnim, self._baseResName, HomelandInteractAnimationType.Out)
    end
    self._interactContext.InteractingBuilding:RemoveInteractObject(tonumber(self._baseResName))
    if outData.duration then
      leaveTime = outData.duration
    end
    if outData.leaveTransform then
      leaveTransform = self._interactContext.InteractingBuilding:GetInteractLeaveNode(self._interactContext.Index, outData.leaveTransform)
    end
    if leaveTransform == nil then
      leaveTransform = self._interactContext.TargetTransform
    end
  end
  local gameGlobal = GameGlobal:GetInstance()
  local waitTime = leaveTime - lerpTime
  while 0 < waitTime do
    if self._interactContext.TrLookAt ~= nil then
      self._followCamCon:UpdatePos(self._interactContext.TrLookAt.position)
    end
    local deltaMS = gameGlobal:GetDeltaTime()
    waitTime = waitTime - deltaMS * 0.001
    YIELD(TT)
  end
  self:ReleaseInteractEffRole()
  self:ReleaseInteractEffBuilding()
  if self._interactContext.TrFollowBuilding ~= nil then
    self._interactContext.TrFollowBuilding = nil
    self._charTrans:SetParent(self._homelandClient:SceneManager():RuntimeRootTrans(), true)
    self._charTrans:SetSiblingIndex(0)
  end
  if lerpTime <= 0 then
    local state = self._animator:GetCurrentAnimatorStateInfo(0)
    while not state:IsName("idle") do
      if state.normalizedTime >= 1 then
        self:SetAnimatorBool("Interact", false)
        self._charTrans.position = leaveTransform.position
        self:SetForward(leaveTransform.forward, true)
        break
      end
      YIELD(TT)
      state = self._animator:GetCurrentAnimatorStateInfo(0)
    end
  else
    self._charTrans:DOMove(leaveTransform.position, lerpTime):OnUpdate(function()
    end)
    self:SetForward(leaveTransform.forward)
    self:SetAnimatorBool("Interact", false)
    YIELD(TT, lerpTime * 1000)
  end
  self:InteractCoroSmoothCam(TT, self._charTrans, 200)
  self._followCamCon:UpdatePos(self._charTrans.position)
end

function HomelandMainCharacterController:InteractCoroEnd(TT)
  if self._interactContext.CfgRoleAnim.In.functionEnum then
    self:OnSetReceiveMoveInput(true)
  end
  self._navMeshAgent.enabled = true
  self._fsm:SwitchState(HomelandActorStateType.Idle)
  self._interactTaskID = nil
  self._interactContext.InteractPoint:SetInteractObject(nil)
  self._interactContext.InteractPoint = nil
  self._interactContext.InteractingBuilding = nil
  self._interactContext = nil
end

function HomelandMainCharacterController:InteractCoroSmoothCam(TT, followTrans, durationMS)
  local gameGlobal = GameGlobal:GetInstance()
  while 0 < durationMS do
    local oldFocusPos = self._followCamCon:GetFocusPos()
    local targetFocusPos = followTrans.position
    local moveSpeed = (targetFocusPos - oldFocusPos) / durationMS
    local deltaMS = gameGlobal:GetDeltaTime()
    deltaMS = math.min(deltaMS, durationMS)
    durationMS = durationMS - deltaMS
    local newFocusPos = oldFocusPos + moveSpeed * deltaMS
    self._followCamCon:UpdatePos(newFocusPos)
    YIELD(TT)
  end
end

function HomelandMainCharacterController:LoadInteractEffRole(TT, effName, hangPath)
  self:ReleaseInteractEffRole()
  self._interactContext.RoleEffReq = ResourceManager:GetInstance():AsyncLoadAsset(TT, effName, LoadType.GameObject)
  local trans
  if hangPath then
    trans = self._charTrans:Find(hangPath)
  else
    trans = self._charTrans
  end
  self._interactContext.RoleEffReq.Obj.transform:SetParent(trans, false)
  self._interactContext.RoleEffReq.Obj:SetActive(self._homelandClient:CurrentMode() == HomelandMode.Normal)
end

function HomelandMainCharacterController:LoadInteractEffBuilding(TT, effName, hangPath, building)
  self:ReleaseInteractEffBuilding()
  self._interactContext.BuildingEffReq = ResourceManager:GetInstance():AsyncLoadAsset(TT, effName, LoadType.GameObject)
  local trans
  if hangPath then
    trans = building:Transform():Find(hangPath)
  else
    trans = building:Transform()
  end
  self._interactContext.BuildingEffReq.Obj.transform:SetParent(trans, false)
  self._interactContext.BuildingEffReq.Obj:SetActive(true)
end

function HomelandMainCharacterController:ReleaseInteractEffRole()
  if self._interactContext and self._interactContext.RoleEffReq then
    self._interactContext.RoleEffReq:Dispose()
    self._interactContext.RoleEffReq = nil
  end
end

function HomelandMainCharacterController:ReleaseInteractEffBuilding()
  if self._interactContext and self._interactContext.BuildingEffReq then
    self._interactContext.BuildingEffReq:Dispose()
    self._interactContext.BuildingEffReq = nil
  end
end

function HomelandMainCharacterController:GetAnimLength(animClipName)
  return GameObjectHelper.GetActorAnimationLength(self._charGO, animClipName)
end

function HomelandMainCharacterController:PlayAnimAndReturnTime(animStateName)
  self._animator:CrossFade(animStateName, 0.2, self._storyLayerIdx)
  local stateInfo = self._animator:GetNextAnimatorStateInfo(self._storyLayerIdx)
  local time = stateInfo.length
  return time
end

function HomelandMainCharacterController:PlayBubble(bubble)
  local cfg = Cfg.cfg_home_pet_bubble[bubble]
  if not cfg then
    Log.error("###[HomelandMainCharacterController] cfg is nil ! id --> ", bubble)
    return
  end
  self._cfg = cfg
  self:StopBubble()
  self._params = cfg.Params
  if cfg.Offset then
    self._offset = Vector3(cfg.Offset[1], cfg.Offset[2], cfg.Offset[3])
  else
    self._offset = Vector3(0, 0, 0)
  end
  if cfg.Scale then
    self._scale = Vector3(cfg.Scale[1], cfg.Scale[2], cfg.Scale[3])
  else
    self._scale = Vector3(1, 1, 1)
  end
  self._type = cfg.Type
  if self._type == HomePetBubbleType.Bubble then
    self:ShowBubble()
  elseif self._type == HomePetBubbleType.Tex then
    self:ShowTex()
  end
  self._duration = cfg.Length or 0
  self._faceSeq = {}
  self._faceIdx = 1
  self._curTime = 0
  if cfg.FaceSeq then
    for i, value in ipairs(cfg.FaceSeq) do
      local face = {}
      face.frame = value[1]
      local time = value[2]
      face.time = time
      self._faceSeq[#self._faceSeq + 1] = face
    end
    self:SetFace(self._faceSeq[1].frame)
    self._playFace = true
  else
    self._playFace = true
  end
  return self._duration
end

function HomelandMainCharacterController:ShowBubble()
  local anis = self._cfg.BubbleAni
  if anis == nil then
    anis = {}
  end
  self._bubbleEffectID = self._effMng:NewEffect(self._params, anis[1], anis[2], anis[3])
  self._effMng:SetScale(self._bubbleEffectID, self._scale)
  self._effMng:Execute(self._bubbleEffectID)
  self:UpdateBubblePos()
end

function HomelandMainCharacterController:ShowTex()
  local homeModule = GameGlobal.GetUIModule(HomelandModule)
  local homeClient = homeModule:GetClient()
  self._camera = homeClient:CameraManager()
  self._3duiMgr = homeClient:Home3DUIManager()
  self._talkUnit = self._3duiMgr:GetTalkUnit()
  if not self._talkUnit then
    return
  end
  self._talkUnit:SetTex(StringTable.Get(self._params))
end

function HomelandMainCharacterController:StopBubble()
  self:DisposeBubble()
end

function HomelandMainCharacterController:UpdateBubblePos()
  local pos = self:HeadPos() + self._offset
  self._effMng:SetPos(self._bubbleEffectID, pos)
end

function HomelandMainCharacterController:SetFace(frame)
  if self._faceMat then
    self._faceMat:SetInt("_Frame", frame)
  end
end

function HomelandMainCharacterController:DisposeBubble()
  if self._bubbleEffectID then
    self._effMng:Exit(self._bubbleEffectID)
  end
  self._bubbleEffectID = nil
  if self._talkUnit then
    self._3duiMgr:ReturnTalkUnit(self._talkUnit)
    self._talkUnit = nil
  end
  self._type = nil
end

function HomelandMainCharacterController:HeadPos()
  if self._headSlot then
    return self._headSlot.position
  else
    return self._charTrans.position + Vector3(0, 1.5, 0)
  end
end

function HomelandMainCharacterController:AttachModel(res, transPath)
  if self._holdRes == res then
    return
  end
  self:ReleaseAttachedModel()
  self._attachedModel = ResourceManager:GetInstance():SyncLoadAsset(res, LoadType.GameObject)
  if not self._attachedModel or not self._attachedModel.Obj then
    Log.fatal("加载资源失败:" .. res)
  end
  self._holdRes = res
  local go = self._attachedModel.Obj
  go:SetActive(true)
  local parent = self._charTrans:Find(transPath)
  local modelTrans = go.transform
  modelTrans:SetParent(parent, false)
  return go
end

function HomelandMainCharacterController:ReleaseAttachedModel()
  if self._attachedModel then
    self._attachedModel:Dispose()
    self._holdRes = nil
  end
end

function HomelandMainCharacterController:AttachEffect(res, transPath)
  if res == nil or res == "" then
    return nil
  end
  self:ReleaseAttachedEffect(res)
  local resObj = ResourceManager:GetInstance():SyncLoadAsset(res, LoadType.GameObject)
  if not resObj or not resObj.Obj then
    Log.fatal("加载资源失败:" .. res)
  end
  self._attachedEffect[res] = resObj
  local go = resObj.Obj
  go:SetActive(true)
  local parent = self._charTrans:Find(transPath)
  local modelTrans = go.transform
  modelTrans:SetParent(parent, false)
  return go
end

function HomelandMainCharacterController:ReleaseAttachedEffect(res)
  if self._attachedEffect[res] ~= nil then
    self._attachedEffect[res]:Dispose()
    self._attachedEffect[res] = nil
  end
end

function HomelandMainCharacterController:ReleaseAttachedEffectAll()
  for k, v in pairs(self._attachedEffect) do
    v:Dispose()
  end
  self._attachedEffect = {}
end

function HomelandMainCharacterController:Action_Water(TT, point)
  self:SetForbiddenMove(true)
  local distance = 3
  local speed = 1
  local target = point.position
  local delta = self._charTrans.position - target
  delta.y = 0
  self:SetForward(-delta)
  YIELD(TT)
  local length = delta:Magnitude()
  if distance < length then
    local target = target + delta * (distance / length)
    local time = (length - distance) / speed
    self._animator:SetBool("Walk", true)
    YIELD(TT, 100)
    self._charTrans:DOMove(target, time)
    local waitTime = math.max(0, time * 1000 - 200)
    YIELD(TT, waitTime)
    self._animator:SetBool("Walk", false)
    YIELD(TT, 500)
  end
  local reqs = {}
  
  local function load(name)
    local req = ResourceManager:GetInstance():SyncLoadAsset(name, LoadType.GameObject)
    reqs[name] = req
    local go = req.Obj
    go:SetActive(true)
    return go
  end
  
  self._animator:SetTrigger("Summon")
  local npc = load("1022001.prefab")
  local npcTr = npc.transform
  npcTr.position = target
  npcTr.forward = delta
  local npcAnim = npc:GetComponentInChildren(typeof(UnityEngine.Animation))
  npcAnim:Play("zhaohuan")
  local eft1 = load("eff_jy_1022001_zhaohuan.prefab").transform
  eft1.position = npcTr.position
  eft1.rotation = npcTr.rotation
  eft1.localScale = npcTr.localScale
  YIELD(TT, 2120)
  npcAnim:CrossFade("jiaoshui", 0.1)
  local eft2 = load("eff_jy_1022001_jiaoshui.prefab").transform
  eft2.position = target
  eft2.forward = delta
  YIELD(TT, 7000)
  local eft4 = load("eff_jy_1022001_xiaoshi.prefab").transform
  eft4.position = target
  eft4.forward = delta
  npc:SetActive(false)
  YIELD(TT, 1000)
  for _, value in pairs(reqs) do
    value:Dispose()
  end
  reqs = nil
  self:SetForbiddenMove(false)
end

function HomelandMainCharacterController:SetStoryLayer(active)
  if not self._animator then
    return
  end
  self._storyLayerIdx = self._animator:GetLayerIndex("HomeStoryLayer")
  local weight
  if active then
    weight = 1
  else
    weight = 0
  end
  self._animator:SetLayerWeight(self._storyLayerIdx, weight)
end

function HomelandMainCharacterController:SetAlpha(alpha)
  self._fadeCmp.Alpha = alpha
end

function HomelandMainCharacterController:IsWearingSwimsuit()
  return self._resName == "1000012"
end

function HomelandMainCharacterController:IsNotWearingSwimsuit()
  return self._resName ~= "1000012"
end

function HomelandMainCharacterController:IsSwimming()
  if not self._roleSwimAreaCollider or not self._charTrans then
    return false
  end
  local closestPoint = self._roleSwimAreaCollider:ClosestPoint(self._charTrans.position)
  local dir = Vector3.Distance(closestPoint, self._charTrans.position)
  if dir <= 0 then
    return true
  end
  return false
end

function HomelandMainCharacterController:OnChangeSwimsuit(homeBuilding)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapRemoveIcon, HomelandMapIconType.Player, 1, self._charTrans, nil)
  self._aniResReq:Dispose()
  self._resReq:Dispose()
  self:DisposeSwimEffect()
  local taegetAgentAreaMask = 1
  if self._resName == "1000011" then
    self._resName = "1000012"
    taegetAgentAreaMask = 5
  elseif self._resName == "1000012" then
    self._resName = "1000011"
    taegetAgentAreaMask = 1
  end
  local lastPos = self._charTrans.position
  local lastEulerAngles = self._charTrans.localEulerAngles
  local walkState = self._animator:GetBool("Walk")
  local runState = self._animator:GetBool("Run")
  local rushState = self._animator:GetBool("Rush")
  local currentForward = self._currentForward
  self:OnInitAssetModelComponent()
  self._navMeshAgent.enabled = false
  self._charTrans.position = lastPos
  self._charTrans.localEulerAngles = lastEulerAngles
  self._animator:SetBool("Walk", walkState)
  self._animator:SetBool("Run", runState)
  self._animator:SetBool("Rush", rushState)
  self._currentForward = currentForward
  self._targetForward = currentForward
  self._charTrans.forward = currentForward
  self._navMeshAgent.enabled = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MinimapAddIcon, HomelandMapIconType.Player, 1, self._charTrans, nil)
  self._navMeshAgent.areaMask = taegetAgentAreaMask
  local homeModule = GameGlobal.GetModule(HomelandModule)
  local uiHomeModule = homeModule:GetUIModule()
  local homeClient = uiHomeModule:GetClient()
  local followList = homeClient:PetManager():GetFollowPets()
  if followList and table.count(followList) > 0 then
    for _, pet in pairs(followList) do
      local behavior = pet:GetPetBehavior()
      local behaviorFollowing = behavior:GetHomelandPetBehavior(HomelandPetBehaviorType.Following)
      if behaviorFollowing then
        behaviorFollowing:ReloadTarget()
      end
    end
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundLevelUp)
  if self._homelandClient:CurrentMode() == HomelandMode.Build then
    for k, v in pairs(self._meshRenderers) do
      v.enabled = false
    end
  else
    GameGlobal.TaskManager():StartTask(function(TT)
      YIELD(TT)
      local req = ResourceManager:GetInstance():SyncLoadAsset("eff_yyc_hz_glow.prefab", LoadType.GameObject)
      if req and self._charTrans then
        req.Obj:SetActive(true)
        local tran = req.Obj.transform
        local targetRoot = GameObjectHelper.FindChild(self._charTrans, "Bip001 Footsteps")
        targetRoot = targetRoot or self._charTrans
        tran.position = targetRoot.position
        tran.localRotation = Quaternion.identity
      end
    end, self)
  end
  local roleSkinID = tonumber(self._resName)
  if roleSkinID == 1000011 then
    self._roleSwimAreaCollider = nil
    self._waterLineHeight = nil
    self._roleSwimChestHeight = nil
    self._swimmingPoolArea = nil
  elseif roleSkinID == 1000012 then
    local homelandSwimmingPool = homeBuilding.Parent
    if not homelandSwimmingPool then
      return
    end
    self._roleSwimAreaCollider = homelandSwimmingPool:GetRoleSwimAreaCollider()
    self._waterLineHeight = homelandSwimmingPool:GetSwimmingPoolWaterHeight()
    local cfgSwimmingPoolPet = Cfg.cfg_homeland_swimming_pool_pet[roleSkinID]
    self._roleSwimChestHeight = cfgSwimmingPoolPet.ChestHeight
    local homeBuildingFatherArea = homelandSwimmingPool._areaList[#homelandSwimmingPool._areaList]
    self._swimmingPoolArea = homeBuildingFatherArea:GetHomeArea()
  end
end

function HomelandMainCharacterController:OnCheckRoleOutSwimmingPoolArea()
  if not self._swimmingPoolArea then
    return
  end
  local pos = self._charTrans.position
  local posWork = Vector2(pos.x, pos.z)
  if self._swimmingPoolArea:OnOutSide(posWork) then
    self:OnChangeSwimsuit()
  end
end

function HomelandMainCharacterController:OnCheckRoleInSwimmingArea()
  if not self._roleSwimAreaCollider then
    return
  end
  if not self._charTrans then
    return
  end
  local inRange = false
  local closestPoint = self._roleSwimAreaCollider:ClosestPoint(self._charTrans.position)
  local dir = Vector3.Distance(closestPoint, self._charTrans.position)
  if dir <= 0 then
    inRange = true
  end
  if not inRange then
    self:OutSideWater()
    return
  end
  local offsetPosY = self:Position().y + self._roleSwimChestHeight - self._waterLineHeight
  if offsetPosY <= 0 then
    self._animator:SetBool("InWater", true)
    if self._root.localPosition.y ~= -offsetPosY then
      local targetLocalPos = Vector3(0, -offsetPosY, 0)
      self._root.localPosition = targetLocalPos
      local cameraMgr = self._homelandClient:CameraManager()
      local followCameraController = cameraMgr:FollowCameraController()
      followCameraController:SetHandleOffset(targetLocalPos)
    end
    if self._animator:GetBool("Walk") == false and self._animator:GetBool("Run") == false then
      self:ShowFloatEffect(true)
      self:ShowSwimEffect(false)
    end
    if self._animator:GetBool("Walk") == true or self._animator:GetBool("Run") == true then
      self:ShowFloatEffect(false)
      self:ShowSwimEffect(true)
    end
  else
    self:OutSideWater()
  end
end

function HomelandMainCharacterController:OutSideWater()
  if self._animator:GetBool("InWater") == true then
    self._animator:SetBool("InWater", false)
  end
  if self._root.localPosition.y ~= 0 then
    self._root.localPosition = Vector3(0, 0, 0)
    local cameraMgr = self._homelandClient:CameraManager()
    local followCameraController = cameraMgr:FollowCameraController()
    followCameraController:SetHandleOffset(Vector3(0, 0, 0))
  end
  self:ShowFloatEffect(false)
  self:ShowSwimEffect(false)
end

function HomelandMainCharacterController:ShowFloatEffect(visible)
  if not self._floatEffect then
    self._floatEffectResRequest = ResourceManager:GetInstance():SyncLoadAsset(self._floatEffectName, LoadType.GameObject)
    if self._floatEffectResRequest then
      self._floatEffect = self._floatEffectResRequest.Obj
      local tran = self._floatEffect.transform
      tran.parent = self._charTrans
      tran.localRotation = Quaternion.identity
    end
  end
  if not self._floatEffect then
    return
  end
  self._floatEffect:SetActive(visible)
  if visible then
    local offsetPosY = self._waterLineHeight - self._charTrans.position.y
    self._floatEffect.transform.localPosition = Vector3(0, offsetPosY, 0)
  end
end

function HomelandMainCharacterController:ShowSwimEffect(visible)
  if not self._swimEffect then
    self._swimEffectResRequest = ResourceManager:GetInstance():SyncLoadAsset(self._swimEffectName, LoadType.GameObject)
    if self._swimEffectResRequest then
      self._swimEffect = self._swimEffectResRequest.Obj
      self._swimEffect:SetActive(true)
      local tran = self._swimEffect.transform
      tran.parent = self._charTrans
      tran.localRotation = Quaternion.identity
    end
  end
  if not self._swimEffect then
    return
  end
  self._swimEffect:SetActive(visible)
  if visible then
    local offsetPosY = self._waterLineHeight - self._charTrans.position.y
    self._swimEffect.transform.localPosition = Vector3(0, offsetPosY, 0)
  end
end

function HomelandMainCharacterController:DisposeSwimEffect()
  if self._floatEffectResRequest then
    self._floatEffect = nil
    self._floatEffectResRequest:Dispose()
    self._floatEffectResRequest = nil
  end
  if self._swimEffectResRequest then
    self._swimEffect = nil
    self._swimEffectResRequest:Dispose()
    self._swimEffectResRequest = nil
  end
end

function HomelandMainCharacterController:ShowHideCharacter(show)
  self._charGO:SetActive(show)
  for _, v in pairs(self._meshRenderers) do
    v.enabled = show
  end
end

function HomelandMainCharacterController:SetIsFishMach(isMatch)
  self._isFishMatch = isMatch
end

function HomelandMainCharacterController:GetIsFishMach()
  return self._isFishMatch
end

function HomelandMainCharacterController:SetCameraForward()
  local rot = self._charTrans.localEulerAngles
  local y = rot.y
  self._followCamCon:SetCamLocation(1.42, y, -7)
end

function HomelandMainCharacterController:ResetPlayerState()
  self._fsm:SwitchState(HomelandActorStateType.Idle)
  self._animator:Play("idle")
end

function HomelandMainCharacterController:GetCurInteractBuilding()
  return self._interactContext and self._interactContext.InteractingBuilding
end

function HomelandMainCharacterController:GetCurInteractTargetTransform()
  return self._interactContext and self._interactContext.TargetTransform
end
