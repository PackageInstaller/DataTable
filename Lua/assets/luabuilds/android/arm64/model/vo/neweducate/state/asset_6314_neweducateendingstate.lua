local NewEducateEndingState = class("NewEducateEndingState", import(".NewEducateStateBase"))

function NewEducateEndingState:Ctor(arg_1_1)
	self.endings = arg_1_1.ends or {}
	self.selEnding = arg_1_1.select or 0

	return
end

function NewEducateEndingState:SetEndings(arg_2_1)
	self.endings = arg_2_1

	return
end

function NewEducateEndingState:GetEndings()
	return self.endings
end

function NewEducateEndingState:SelEnding(arg_4_1)
	self.selEnding = arg_4_1

	return
end

function NewEducateEndingState:IsFinish()
	return self.selEnding ~= 0
end

function NewEducateEndingState:Reset()
	self.endings = {}
	self.selEnding = 0

	return
end

return NewEducateEndingState
