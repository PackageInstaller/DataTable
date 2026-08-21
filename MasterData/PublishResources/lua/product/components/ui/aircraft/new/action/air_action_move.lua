_class("AirActionMove", AirActionBase)
AirActionMove = AirActionMove

function AirActionMove:Constructor(pet, target, floor, main, des)
  if target == nil then
    Log.fatal("[AircraftMove] 移动目标点为空，星灵:", pet:TemplateID(), "，描述:", des)
  end
  self._main = main
  self._des = des
  self._pet = pet
  local speed = self._pet:GetMoveSpeed()
  self._id = pet:TemplateID()
  if not self._pet:IsAlive() then
    self:Log("星灵已被销毁：", self._pet:TemplateID())
  end
  self._transform = self._pet:Transform()
  self._target = target
  self._navMeshAgent = self._pet:NaviMesh()
  self._navMeshObstacle = self._pet:NaviObstacle()
  self._navMeshAgent.speed = speed
  self._navMeshAgent.areaMask = 1 << floor + 2
  self._navMeshAgent.enabled = false
  self._navMeshObstacle.enabled = false
  self._velocityCheckTimer = 0
  self._lowVelocity = false
  self._pauseDone = false
  self._velocityCheckInterval = 1500
  self._velocitySqrThreshold = speed * speed
  self._movePauseTimeMin = 1000
  self._movePauseTimeMax = 3000
  self._movePauseCount = 3
  self._state = AirPetMoveState.NONE
end

function AirActionMove:Start()
  self._running = true
  self._navMeshObstacle.enabled = false
  self._velocityCheckTimer = 0
  self._lowVelocity = false
  self._movePauseCount = 3
  self._pauseDone = false
  self._readyToMove = true
  self:LogStart()
  self._state = AirPetMoveState.Prepare
end

function AirActionMove:Update(deltaTimeMS)
  if not self._running then
    return
  end
  if self._state == AirPetMoveState.Prepare then
    self._navMeshObstacle.enabled = false
    self._pet:Anim_Walk()
    self._state = AirPetMoveState.Prepare1
  elseif self._state == AirPetMoveState.Prepare1 then
    self._navMeshAgent.enabled = true
    self._navMeshAgent.isStopped = false
    self._navMeshAgent.destination = self._target
    self._state = AirPetMoveState.Moving
  elseif self._state == AirPetMoveState.Moving then
    if self:checkEnd() then
      self._running = false
      self:Stop()
      self._state = AirPetMoveState.Arrived
      return
    end
    local velocitySqr = self._navMeshAgent.velocity:SqrMagnitude()
    if self._velocitySqrThreshold - velocitySqr > 0.1 then
      self._state = AirPetMoveState.Blocked
      return
    end
  elseif self._state == AirPetMoveState.Blocked then
    local velocitySqr = self._navMeshAgent.velocity:SqrMagnitude()
    if velocitySqr < self._velocitySqrThreshold then
      self._velocityCheckTimer = self._velocityCheckTimer + deltaTimeMS
      if self._velocityCheckTimer > self._velocityCheckInterval then
        self._navMeshAgent.isStopped = true
        self._navMeshAgent.enabled = false
        self._navMeshObstacle.enabled = true
        self._velocityCheckTimer = 0
        self._pet:Anim_Stand()
        self._state = AirPetMoveState.Pausing
        self._main:OnPetNaviBlocked(self._pet, self)
      end
    else
      self._velocityCheckTimer = 0
      self._state = AirPetMoveState.Moving
    end
  else
    if self._state == AirPetMoveState.Pausing then
    else
    end
  end
end

function AirActionMove:checkEnd()
  local delta = self._pet:WorldPosition() - self._target
  if delta.y < 1 then
    delta.y = 0
    return delta:SqrMagnitude() < 0.05
  end
  return false
end

function AirActionMove:Resume()
  if self._state == AirPetMoveState.Pausing then
    self._movePauseCount = self._movePauseCount - 1
    if self._movePauseCount <= 0 then
      if self._pet:IsWorkingPet() then
        AirLog("工作星灵没有路径，直接回工作房间")
        self._main:PetStartWork(self._pet:TemplateID(), self._pet:GetSpace())
      elseif self._pet:IsLeavingPet() then
        AirLog("离开星灵没有路径，直接销毁")
        self._main:RemoveRestPet(self._pet:TemplateID())
      else
        self._state = AirPetMoveState.NONE
        self:Stop()
        self._pet:TryStopFloorTargetAction()
        self._main:StopSocialByPet(self._pet)
        self._main:RandomActionForPet(self._pet)
      end
      return
    end
    self._state = AirPetMoveState.Prepare
  else
    Log.exception("寻路行为状态错误，无法继续：", self._state)
  end
end

function AirActionMove:IsOver()
  return not self._running
end

function AirActionMove:Stop()
  if self._running then
    self._running = false
  end
  self._pet:Anim_Stand()
  self._navMeshAgent.isStopped = true
  self._navMeshAgent.enabled = false
  self._navMeshObstacle.enabled = true
end

function AirActionMove:GetPets()
  return {
    self._pet
  }
end

function AirActionMove:GetPet()
  return self._pet
end

function AirActionMove:GetMovePauseCount()
  return self._movePauseCount
end

function AirActionMove:GetTarget()
  return self._target
end
