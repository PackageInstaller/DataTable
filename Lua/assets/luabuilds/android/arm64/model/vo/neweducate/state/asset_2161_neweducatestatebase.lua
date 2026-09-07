local NewEducateStateBase = class("NewEducateStateBase")

function NewEducateStateBase:Ctor()
	return
end

function NewEducateStateBase:IsPriorityType()
	return false
end

function NewEducateStateBase:IsFinish()
	return true
end

function NewEducateStateBase:Reset()
	return
end

return NewEducateStateBase
