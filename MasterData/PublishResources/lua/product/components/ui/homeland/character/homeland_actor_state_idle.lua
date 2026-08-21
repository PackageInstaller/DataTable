require("homeland_actor_state")
_class("HomelandActorStateIdle", HomelandActorState)
HomelandActorStateIdle = HomelandActorStateIdle

function HomelandActorStateIdle:Constructor()
end

function HomelandActorStateIdle:GetType()
  return HomelandActorStateType.Idle
end

function HomelandActorStateIdle:Enter()
end

function HomelandActorStateIdle:Exit()
end
