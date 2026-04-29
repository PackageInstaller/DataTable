require("homeland_actor_state")
_class("HomelandActorStateInteract", HomelandActorState)
HomelandActorStateInteract = HomelandActorStateInteract

function HomelandActorStateInteract:Constructor()
end

function HomelandActorStateInteract:GetType()
  return HomelandActorStateType.Interact
end

function HomelandActorStateInteract:HandleEventDash()
  if self._mcc:IsInteracting() then
    self._mcc._interactContext.InterruptInteraction = true
  end
end

function HomelandActorStateInteract:HandleEventMove()
  if self._mcc:IsInteracting() then
    self._mcc._interactContext.InterruptInteraction = true
  end
end
