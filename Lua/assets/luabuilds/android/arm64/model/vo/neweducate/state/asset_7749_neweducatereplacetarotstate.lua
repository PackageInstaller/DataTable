local NewEducateReplaceTarotState = class("NewEducateReplaceTarotState", import(".NewEducateStateBase"))

function NewEducateReplaceTarotState:Ctor(arg_1_1)
	self.queueIds = arg_1_1
	self.holdId = 0

	return
end

function NewEducateReplaceTarotState:GetSystemNo()
	return NewEducatePriorityFSM.SYSTEM.REPLACE_TAROT
end

function NewEducateReplaceTarotState:IsPriorityType()
	return true
end

function NewEducateReplaceTarotState:ClearIds()
	self.queueIds = {}
	self.holdId = 0

	return
end

function NewEducateReplaceTarotState:IsFinish()
	return #self.queueIds == 0
end

function NewEducateReplaceTarotState:GetFirstId()
	return self.queueIds[1]
end

function NewEducateReplaceTarotState:PushId(arg_7_1)
	table.insert(self.queueIds, arg_7_1)

	return
end

function NewEducateReplaceTarotState:PopId()
	table.remove(self.queueIds, 1)

	return
end

function NewEducateReplaceTarotState:SetHoldId(arg_9_1)
	self.holdId = arg_9_1

	return
end

function NewEducateReplaceTarotState:GetHoldId()
	return self.holdId
end

function NewEducateReplaceTarotState:Reset()
	self.queueIds = {}
	self.holdId = 0

	return
end

return NewEducateReplaceTarotState
