local var_0_0 = class("NewEducatePriorityFSM")

var_0_0.SYSTEM = {
	UPGRADE_ENTRY = 101,
	REPLACE_TAROT = 999,
	CHOOSE = 100
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stateStack = {}

	local var_1_0 = arg_1_2.priority_fsm or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.stateStack, arg_1_0:CreatPriorityState(iter_1_1))
	end

	arg_1_0.replaceTarotState = NewEducateReplaceTarotState.New(arg_1_2.tarot_selects)

	if not arg_1_0.replaceTarotState:IsFinish() then
		arg_1_0:PushReplaceTarotState()
	end

	return
end

function var_0_0.CreatPriorityState(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.cache[1]

	return switch(arg_2_1.system_no, {
		[var_0_0.SYSTEM.CHOOSE] = function()
			return NewEducateChooseState.New(var_2_0.cache_nin1[1])
		end,
		[var_0_0.SYSTEM.UPGRADE_ENTRY] = function()
			return NewEducateUpgradeEntryState.New(var_2_0.cache_affix_up[1])
		end
	}, function()
		assert(false, "未定义的priority state, no: " .. arg_2_1.system_no)

		return
	end)
end

function var_0_0.GetCurState(arg_6_0)
	return arg_6_0.stateStack[1]
end

function var_0_0.CheckStystem(arg_7_0)
	if arg_7_0.stateStack[1] and arg_7_0.stateStack[1]:IsFinish() then
		table.remove(arg_7_0.stateStack, 1)
	end

	return arg_7_0.stateStack[1]
end

function var_0_0.IsReplaceStateInStack(arg_8_0)
	return underscore.any(arg_8_0.stateStack, function(arg_9_0)
		return arg_9_0:GetSystemNo() == var_0_0.SYSTEM.REPLACE_TAROT
	end)
end

function var_0_0.AddReplaceTarot(arg_10_0, arg_10_1)
	arg_10_0.replaceTarotState:PushId(arg_10_1)

	if not arg_10_0:IsReplaceStateInStack() then
		arg_10_0:PushReplaceTarotState()
	end

	return
end

function var_0_0.PushReplaceTarotState(arg_11_0)
	table.insert(arg_11_0.stateStack, 1, arg_11_0.replaceTarotState)

	return
end

function var_0_0.PushChooseState(arg_12_0, arg_12_1)
	table.insert(arg_12_0.stateStack, 1, (NewEducateChooseState.New({
		is_from_shop = false,
		selects = {},
		reroll_count = {}
	})))

	return
end

function var_0_0.PushUpEntryState(arg_13_0)
	table.insert(arg_13_0.stateStack, 1, NewEducateUpgradeEntryState.New({}))

	return
end

function var_0_0.Reset(arg_14_0)
	arg_14_0.stateStack = {}

	arg_14_0.replaceTarotState:Reset()

	return
end

return var_0_0
