require("homeland_actor_state")
_class("HomelandActorStateRun", HomelandActorState)
HomelandActorStateRun = HomelandActorStateRun

function HomelandActorStateRun:Constructor()
  self._runSpeed = 5
  self._walkSpeed = 1
  self._rushSpeed = 15
  self._fastSwimSpeed = 2.5
  self._swimSpeed = 0.7
  self._moveType = nil
  self._movement = nil
end

function HomelandActorStateRun:GetType()
  return HomelandActorStateType.Run
end

function HomelandActorStateRun:Enter(movement, moveState, deltaTimeMS)
  self._mcc._navMeshAgent.isStopped = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCharacterStartMove)
  self:HandleEventMove(movement, moveState, deltaTimeMS)
  if moveState == HomelandCharMoveType.Run then
    self._mcc:SetAnimatorBool("Run", true)
  elseif moveState == HomelandCharMoveType.Walk then
    self._mcc:SetAnimatorBool("Walk", true)
  elseif moveState == HomelandCharMoveType.Rush then
    self._mcc:SetAnimatorBool("Rush", true)
  end
end

function HomelandActorStateRun:Exit()
  self._mcc:SetAnimatorBool("Run", false)
  self._mcc:SetAnimatorBool("Walk", false)
  self._mcc:SetAnimatorBool("Rush", false)
  self._moveType = nil
end

function HomelandActorStateRun:Update(deltaTimeMS)
  if not self._movement then
    self._fsm:SwitchState(HomelandActorStateType.Idle)
  end
  self._movement = nil
end

function HomelandActorStateRun:HandleEventMove(movement, moveState, deltaTimeMS)
  if self._moveType ~= moveState then
    if moveState == HomelandCharMoveType.Run then
      self._mcc:SetAnimatorBool("Walk", false)
      self._mcc:SetAnimatorBool("Run", true)
      self._mcc:SetAnimatorBool("Rush", false)
    elseif moveState == HomelandCharMoveType.Walk then
      self._mcc:SetAnimatorBool("Walk", true)
      self._mcc:SetAnimatorBool("Run", false)
      self._mcc:SetAnimatorBool("Rush", false)
    elseif moveState == HomelandCharMoveType.Rush then
      self._mcc:SetAnimatorBool("Walk", false)
      self._mcc:SetAnimatorBool("Run", false)
      self._mcc:SetAnimatorBool("Rush", true)
    end
    self._moveType = moveState
  end
  if moveState == HomelandCharMoveType.Run then
    if self._mcc:GetAnimatorBool("InWater") then
      self._mcc._navMeshAgent:Move(movement * self._fastSwimSpeed * deltaTimeMS / 1000)
    else
      self._mcc._navMeshAgent:Move(movement * self._runSpeed * deltaTimeMS / 1000)
    end
  elseif moveState == HomelandCharMoveType.Walk then
    if self._mcc:GetAnimatorBool("InWater") then
      self._mcc._navMeshAgent:Move(movement * self._swimSpeed * deltaTimeMS / 1000)
    else
      self._mcc._navMeshAgent:Move(movement * self._walkSpeed * deltaTimeMS / 1000)
    end
  elseif moveState == HomelandCharMoveType.Rush then
    self._mcc._navMeshAgent:Move(movement * self._rushSpeed * deltaTimeMS / 1000)
  end
  self._mcc:SetTargetForward(movement)
  self._movement = movement
  self._mcc:UpdateFollowCamPos()
end
