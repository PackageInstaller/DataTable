require("homeland_actor_state")
_class("HomelandActorStateDash", HomelandActorState)
HomelandActorStateDash = HomelandActorStateDash

function HomelandActorStateDash:Constructor()
  self._callback = nil
  self._curDashTime = 0
  self._dashForward = nil
  self._dashSpeed = 15
  self._dashTime = 0.3
  self._movement = nil
  self._dashMoveState = nil
end

function HomelandActorStateDash:GetType()
  return HomelandActorStateType.Dash
end

function HomelandActorStateDash:Enter(callback)
  self._mcc._navMeshAgent.isStopped = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnMainCharacterStartMove)
  self._movement = nil
  self._dashMoveState = nil
  self._curDashTime = 0
  self._callback = callback
  local targetForward = self._mcc:GetTargetForward()
  if targetForward then
    self._dashForward = targetForward
  else
    self._dashForward = self._mcc:GetCurrentForward()
  end
  self._mcc:SetAnimatorTrigger("Dash")
  self._mcc:SetAnimatorBool("DashState", true)
  if not self._HomelandInputControllerChar then
    local uiModule = GameGlobal.GetUIModule(HomelandModule)
    local homelandClient = uiModule:GetClient()
    self._HomelandInputControllerChar = homelandClient:InputManager():GetControllerChar()
  end
end

function HomelandActorStateDash:Exit()
  self._mcc:SetAnimatorBool("DashState", false)
end

function HomelandActorStateDash:Update(deltaTimeMS)
  self._curDashTime = self._curDashTime + deltaTimeMS / 1000
  self._mcc._navMeshAgent:Move(self._dashForward * self._dashSpeed * deltaTimeMS / 1000)
  self._callback()
  if self._curDashTime > self._dashTime then
    if self._movement then
      self._HomelandInputControllerChar:DashEnd()
      if self._HomelandInputControllerChar:IsRushing() then
        self._dashMoveState = HomelandCharMoveType.Rush
      end
      self._fsm:SwitchState(HomelandActorStateType.Run, self._movement, self._dashMoveState, deltaTimeMS)
    else
      self._HomelandInputControllerChar:DashEnd()
      self._fsm:SwitchState(HomelandActorStateType.Idle)
    end
  end
  self._mcc._followCamCon:UpdateDashProgress(self._curDashTime / self._dashTime)
  self._movement = nil
end

function HomelandActorStateDash:HandleEventDash()
  return
end

function HomelandActorStateDash:HandleEventMove(movment, moveState)
  self._movement = movment
  self._dashMoveState = moveState
end
