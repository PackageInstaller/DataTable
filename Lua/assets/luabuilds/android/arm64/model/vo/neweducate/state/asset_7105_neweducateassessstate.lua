local NewEducateAssessState = class("NewEducateAssessState", import(".NewEducateStateBase"))

function NewEducateAssessState:Ctor(arg_1_1)
	self.finishFlag = arg_1_1.is_finished == 1

	return
end

function NewEducateAssessState:MarkFinish()
	self.finishFlag = true

	return
end

function NewEducateAssessState:IsFinish()
	if getProxy(NewEducateProxy):GetCurChar():GetAssessRankIdx() == 0 then
		return true
	end

	return self.finishFlag
end

function NewEducateAssessState:Reset()
	self.finishFlag = false

	return
end

return NewEducateAssessState
