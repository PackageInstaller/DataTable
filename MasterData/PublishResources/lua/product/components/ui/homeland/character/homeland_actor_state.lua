_class("HomelandActorState", Object)
HomelandActorState = HomelandActorState

function HomelandActorState:Constructor(fsm)
  self._fsm = fsm
  self._mcc = fsm:GetMainCharacterController()
  self._handlerMap = {}
  self:RegisterEventHandler()
end

function HomelandActorState:RegisterEventHandler()
  self._handlerMap[HomelandActorStateEventType.Move] = self.HandleEventMove
  self._handlerMap[HomelandActorStateEventType.Dash] = self.HandleEventDash
end

function HomelandActorState:Dispose()
end

function HomelandActorState:GetType()
  return HomelandActorStateType.NotDefined
end

function HomelandActorState:Enter()
end

function HomelandActorState:Exit()
end

function HomelandActorState:Update(deltaTimeMS)
end

function HomelandActorState:HandleEvent(eventType, ...)
  local handler = self._handlerMap[eventType]
  if handler then
    handler(self, ...)
  else
    Log.fatal("[HomelandActorState] handler missing:" .. tostring(eventType))
  end
end

function HomelandActorState:HandleEventDash(callback)
  if self._mcc:IsForbiddenMove() then
    return
  end
  self._fsm:SwitchState(HomelandActorStateType.Dash, callback)
end

function HomelandActorState:HandleEventMove(movement, moveState, deltaTimeMS)
  if moveState == HomelandCharMoveType.Idle then
    self._fsm:SwitchState(HomelandActorStateType.Idle)
  else
    self._fsm:SwitchState(HomelandActorStateType.Run, movement, moveState, deltaTimeMS)
  end
end
