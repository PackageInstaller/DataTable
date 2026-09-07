local NewEducateStateMgr = class("NewEducateStateMgr")

function NewEducateStateMgr:Ctor(arg_1_1, arg_1_2)
	self.roundFSM = NewEducateFSM.New(arg_1_1, arg_1_2)
	self.priorityFSM = NewEducatePriorityFSM.New(arg_1_1, arg_1_2)

	return
end

function NewEducateStateMgr:SetState(arg_2_1, arg_2_2)
	self.roundFSM:SetState(arg_2_1, arg_2_2)

	return
end

function NewEducateStateMgr:GetState(arg_3_1)
	return self.roundFSM:GetState(arg_3_1)
end

function NewEducateStateMgr:GetCurState()
	return self.roundFSM:GetCurState()
end

function NewEducateStateMgr:SetCurNode(arg_5_1)
	self.roundFSM:SetCurNode(arg_5_1)

	return
end

function NewEducateStateMgr:GetCurNode()
	return self.roundFSM:GetCurNode()
end

function NewEducateStateMgr:SetSystemNo(arg_7_1)
	self.roundFSM:SetSystemNo(arg_7_1)

	return
end

function NewEducateStateMgr:GetSystemNo()
	return self.roundFSM:GetSystemNo()
end

function NewEducateStateMgr:CheckStystem()
	return self.roundFSM:CheckStystem()
end

function NewEducateStateMgr:IsImmediateBenefit()
	return self.roundFSM:IsImmediateBenefit()
end

function NewEducateStateMgr:GetPriorityState()
	return self.priorityFSM:GetCurState()
end

function NewEducateStateMgr:CheckPriorityStystem()
	return self.priorityFSM:CheckStystem()
end

function NewEducateStateMgr:AddReplaceTarotState(arg_13_1)
	self.priorityFSM:AddReplaceTarot(arg_13_1)

	return
end

function NewEducateStateMgr:AddChooseState(arg_14_1)
	self.priorityFSM:PushChooseState(arg_14_1)

	return
end

function NewEducateStateMgr:AddChooseUpEntryState()
	self.priorityFSM:PushUpEntryState()

	return
end

function NewEducateStateMgr:Reset()
	self.roundFSM:Reset()
	self.priorityFSM:Reset()

	return
end

return NewEducateStateMgr
