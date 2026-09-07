local NewEducatePriorityFSM = class("NewEducatePriorityFSM")

NewEducatePriorityFSM.SYSTEM = {
	UPGRADE_ENTRY = 101,
	REPLACE_TAROT = 999,
	CHOOSE = 100
}

function NewEducatePriorityFSM:Ctor(arg_1_1, arg_1_2)
	self.stateStack = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_2.priority_fsm or {}) do
		table.insert(self.stateStack, self:CreatPriorityState(iter_1_1))
	end

	self.replaceTarotState = NewEducateReplaceTarotState.New(arg_1_2.tarot_selects)

	if not self.replaceTarotState:IsFinish() then
		self:PushReplaceTarotState()
	end

	return
end

function NewEducatePriorityFSM:CreatPriorityState(arg_2_1)
	local var_2_0 = arg_2_1.cache[1]

	return switch(arg_2_1.system_no, {
		[NewEducatePriorityFSM.SYSTEM.CHOOSE] = function()
			return NewEducateChooseState.New(var_2_0.cache_nin1[1])
		end,
		[NewEducatePriorityFSM.SYSTEM.UPGRADE_ENTRY] = function()
			return NewEducateUpgradeEntryState.New(var_2_0.cache_affix_up[1])
		end
	}, function()
		assert(false, "未定义的priority state, no: " .. arg_2_1.system_no)

		return
	end)
end

function NewEducatePriorityFSM:GetCurState()
	return self.stateStack[1]
end

function NewEducatePriorityFSM:CheckStystem()
	if self.stateStack[1] and self.stateStack[1]:IsFinish() then
		table.remove(self.stateStack, 1)
	end

	return self.stateStack[1]
end

function NewEducatePriorityFSM:IsReplaceStateInStack()
	return underscore.any(self.stateStack, function(arg_9_0)
		return arg_9_0:GetSystemNo() == NewEducatePriorityFSM.SYSTEM.REPLACE_TAROT
	end)
end

function NewEducatePriorityFSM:AddReplaceTarot(arg_10_1)
	self.replaceTarotState:PushId(arg_10_1)

	if not self:IsReplaceStateInStack() then
		self:PushReplaceTarotState()
	end

	return
end

function NewEducatePriorityFSM:PushReplaceTarotState()
	table.insert(self.stateStack, 1, self.replaceTarotState)

	return
end

function NewEducatePriorityFSM:PushChooseState(arg_12_1)
	table.insert(self.stateStack, 1, (NewEducateChooseState.New({
		is_from_shop = false,
		selects = {},
		reroll_count = {}
	})))

	return
end

function NewEducatePriorityFSM:PushUpEntryState()
	table.insert(self.stateStack, 1, NewEducateUpgradeEntryState.New({}))

	return
end

function NewEducatePriorityFSM:Reset()
	self.stateStack = {}

	self.replaceTarotState:Reset()

	return
end

return NewEducatePriorityFSM
