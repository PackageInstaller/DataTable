require("homeland_actor_state")
_class("HomelandActorStateSwim", HomelandActorState)
HomelandActorStateSwim = HomelandActorStateSwim

function HomelandActorStateSwim:Constructor()
end

function HomelandActorStateSwim:GetType()
  return HomelandActorStateType.Swim
end

function HomelandActorStateSwim:Enter()
end

function HomelandActorStateSwim:Exit()
end

function HomelandActorStateSwim:Update(deltaTimeMS)
end
