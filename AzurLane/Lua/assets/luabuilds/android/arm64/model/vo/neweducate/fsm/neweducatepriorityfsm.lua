class = var_0_10000

local var_0_0 = var_0_10000("NewEducatePriorityFSM")

var_0_0.SYSTEM = {
	UPGRADE_ENTRY = 101,
	REPLACE_TAROT = 999,
	CHOOSE = 100
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stateStack = {}
	ipairs = var_3

	local var_1_0

	if not arg_1_2.priority_fsm then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_3(var_1_0) do
		table = var_1_10008

		var_1_10008.insert(arg_1_0.stateStack, arg_1_0:CreatPriorityState(iter_1_1))
	end

	NewEducateReplaceTarotState = var_3
	arg_1_0.replaceTarotState = var_3.New(arg_1_2.tarot_selects)

	local var_1_1 = arg_1_0.replaceTarotState

	if not var_3.IsFinish(var_1_1) then
		arg_1_0:PushReplaceTarotState()
	end

	return
end

function var_0_0.CreatPriorityState(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.cache[1]

	switch = var_1_10003

	return var_1_10003(arg_2_1.system_no, {
		[var_0_0.SYSTEM.CHOOSE] = function()
			NewEducateChooseState = var_2_10000

			return var_2_10000.New(var_2_0.cache_nin1[1])
		end,
		[var_0_0.SYSTEM.UPGRADE_ENTRY] = function()
			NewEducateUpgradeEntryState = var_2_10000

			return var_2_10000.New(var_2_0.cache_affix_up[1])
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "未定义的priority state, no: " .. arg_2_1.system_no)

		return
	end)
end

function var_0_0.GetCurState(arg_6_0)
	return arg_6_0.stateStack[1]
end

function var_0_0.CheckStystem(arg_7_0)
	if arg_7_0.stateStack[1] then
		local var_7_0 = arg_7_0.stateStack[1]

		if var_1.IsFinish(var_7_0) then
			table = var_1

			var_1.remove(arg_7_0.stateStack, 1)
		end
	end

	return arg_7_0.stateStack[1]
end

function var_0_0.IsReplaceStateInStack(arg_8_0)
	underscore = var_1_10001

	return var_1_10001.any(arg_8_0.stateStack, function(arg_9_0)
		return arg_9_0:GetSystemNo() == var_0_0.SYSTEM.REPLACE_TAROT
	end)
end

function var_0_0.AddReplaceTarot(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.replaceTarotState

	var_2.PushId(var_10_0, arg_10_1)

	if not arg_10_0:IsReplaceStateInStack() then
		arg_10_0:PushReplaceTarotState()
	end

	return
end

function var_0_0.PushReplaceTarotState(arg_11_0)
	table = var_1_10001

	var_1_10001.insert(arg_11_0.stateStack, 1, arg_11_0.replaceTarotState)

	return
end

function var_0_0.PushChooseState(arg_12_0, arg_12_1)
	NewEducateChooseState = var_1_10002

	local var_12_0 = var_1_10002.New({
		is_from_shop = false,
		selects = {},
		reroll_count = {}
	})

	table = var_1_10003

	var_1_10003.insert(arg_12_0.stateStack, 1, var_12_0)

	return
end

function var_0_0.PushUpEntryState(arg_13_0)
	table = var_1_10001

	local var_13_0 = var_1_10001.insert
	local var_13_1 = arg_13_0.stateStack
	local var_13_2 = 1

	NewEducateUpgradeEntryState = var_1_10005

	var_13_0(var_13_1, var_13_2, var_1_10005.New({}))

	return
end

function var_0_0.Reset(arg_14_0)
	arg_14_0.stateStack = {}

	local var_14_0 = arg_14_0.replaceTarotState

	var_1.Reset(var_14_0)

	return
end

return var_0_0
