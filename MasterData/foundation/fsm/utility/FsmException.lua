local FsmException = System.NewClass("FsmException")

function FsmException.StateCanOnlyBeAddedOnce(state, TS, TT, TI)
  do return string.format, "A state [%s] has already been added. You can only one add" + " a state with a unique identifier once.", tostring(state.Identifier) end
  return string.format, "A state [%s] has already been added. You can only one add" + " a state with a unique identifier once.", tostring(state.Identifier)
end

function FsmException.TargetStateCannotBeNull()
  return "The target of a transition cannot be null."
end

function FsmException.TransitionCannotBeNull()
  return "The transition cannot be null."
end

function FsmException.StateCannotBeNull()
  return "The state cannot be null."
end

function FsmException.TriggersIsAny()
  return "已经是AnyTrigger."
end

function FsmException.ModelCannotBeNull()
  return "The model cannot be null."
end

function FsmException.TriggerAlreadyDeclared(trigger, TT)
  do return string.format, "The transition already contains the trigger [%s]" end
  return string.format, "The transition already contains the trigger [%s]", trigger
end

function FsmException.HandlerCannotBeNull()
  return "The handler you want to add cannot be null."
end

return FsmException
