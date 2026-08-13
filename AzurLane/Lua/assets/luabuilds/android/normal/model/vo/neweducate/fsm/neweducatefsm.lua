class = var_0_10000

local var_0_0 = var_0_10000("NewEducateFSM")

var_0_0.SYSTEM = {
	PLAN = 5,
	MIND = 9,
	FAIL = 999,
	EVENT = 1,
	ENDING = 8,
	PHASE = 7,
	ASSESS = 6,
	MAP = 4,
	TOPIC = 3,
	CHOOSE = 10,
	TALENT = 2,
	INIT = 0
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.systemNo = arg_1_2.system_no

	local var_1_0

	if not arg_1_2.current_node then
		var_1_0 = 0
	end

	arg_1_0.curNode = var_1_0

	local var_1_1 = arg_1_2.cache[1]

	arg_1_0.states = {}

	local var_1_2 = arg_1_0.states
	local var_1_3 = var_0_0.SYSTEM.INIT

	NewEducateStateBase = var_1_10006
	var_1_2[var_1_3] = var_1_10006.New()

	local var_1_4 = arg_1_0.states
	local var_1_5 = var_0_0.SYSTEM.EVENT

	NewEducateStateBase = var_6
	var_1_4[var_1_5] = var_6.New()

	if #var_1_1.cache_talent > 0 then
		local var_1_6 = arg_1_0.states
		local var_1_7 = var_0_0.SYSTEM.TALENT

		NewEducateTalentState = var_6
		var_1_6[var_1_7] = var_6.New(var_1_1.cache_talent[1])
	end

	local var_1_8 = arg_1_0.states
	local var_1_9 = var_0_0.SYSTEM.CHOOSE

	NewEducateStateBase = var_6
	var_1_8[var_1_9] = var_6.New()

	if #var_1_1.cache_chat > 0 then
		local var_1_10 = arg_1_0.states
		local var_1_11 = var_0_0.SYSTEM.TOPIC

		NewEducateTopicState = var_6
		var_1_10[var_1_11] = var_6.New(var_1_1.cache_chat[1])
	end

	if #var_1_1.cache_site > 0 then
		local var_1_12 = arg_1_0.states
		local var_1_13 = var_0_0.SYSTEM.MAP

		NewEducateMapState = var_6
		var_1_12[var_1_13] = var_6.New(arg_1_1, var_1_1.cache_site[1])
	end

	local var_1_14 = arg_1_0.states
	local var_1_15 = var_0_0.SYSTEM.PLAN

	NewEducatePlanState = var_6

	local var_1_16 = var_6.New
	local var_1_17

	if not (#var_1_1.cache_plan > 0) or not var_1_1.cache_plan[1] then
		var_1_17 = {}
	end

	var_1_14[var_1_15] = var_1_16(var_1_17)

	if #var_1_1.cache_eval > 0 then
		local var_1_18 = arg_1_0.states
		local var_1_19 = var_0_0.SYSTEM.ASSESS

		NewEducateAssessState = var_6
		var_1_18[var_1_19] = var_6.New(var_1_1.cache_eval[1])
	elseif arg_1_0.systemNo == var_0_0.SYSTEM.ASSESS and #var_1_1.cache_eval == 0 then
		local var_1_20 = arg_1_0.states
		local var_1_21 = var_0_0.SYSTEM.ASSESS

		NewEducateAssessState = var_6
		var_1_20[var_1_21] = var_6.New({
			is_finished = 0
		})
	end

	local var_1_22 = arg_1_0.states
	local var_1_23 = var_0_0.SYSTEM.PHASE

	NewEducateStateBase = var_6
	var_1_22[var_1_23] = var_6.New()

	if #var_1_1.cache_end > 0 then
		local var_1_24 = arg_1_0.states
		local var_1_25 = var_0_0.SYSTEM.ENDING

		NewEducateEndingState = var_6
		var_1_24[var_1_25] = var_6.New(var_1_1.cache_end[1])
	end

	if #var_1_1.cache_mind > 0 then
		local var_1_26 = arg_1_0.states
		local var_1_27 = var_0_0.SYSTEM.MIND

		NewEducateStateBase = var_6
		var_1_26[var_1_27] = var_6.New(var_1_1.cache_mind[1])
	end

	return
end

function var_0_0.SetState(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.states[arg_2_1] = arg_2_2

	return
end

function var_0_0.GetCurNode(arg_3_0)
	return arg_3_0.curNode
end

function var_0_0.SetCurNode(arg_4_0, arg_4_1)
	arg_4_0.curNode = arg_4_1

	return
end

function var_0_0.GetSystemNo(arg_5_0)
	return arg_5_0.systemNo
end

function var_0_0.SetSystemNo(arg_6_0, arg_6_1)
	arg_6_0.systemNo = arg_6_1

	return
end

function var_0_0.GetState(arg_7_0, arg_7_1)
	local var_7_0

	if not arg_7_0.states[arg_7_1] then
		var_7_0 = nil
	end

	return var_7_0
end

function var_0_0.GetCurState(arg_8_0)
	return arg_8_0.states[arg_8_0.systemNo]
end

function var_0_0.CheckStystem(arg_9_0)
	warning = var_1_10001

	var_1_10001(arg_9_0.curNode, arg_9_0.systemNo)

	if arg_9_0.curNode ~= 0 then
		return arg_9_0.systemNo
	end

	local var_9_0 = arg_9_0.states[arg_9_0.systemNo]

	if not var_1.IsFinish(var_9_0) then
		return arg_9_0.systemNo
	end

	switch = var_1

	return var_1(arg_9_0.systemNo, {
		[var_0_0.SYSTEM.INIT] = function()
			return var_0_0.SYSTEM.EVENT
		end,
		[var_0_0.SYSTEM.EVENT] = function()
			return var_0_0.SYSTEM.TALENT
		end,
		[var_0_0.SYSTEM.TALENT] = function()
			return var_0_0.SYSTEM.CHOOSE
		end,
		[var_0_0.SYSTEM.CHOOSE] = function()
			return var_0_0.SYSTEM.MAP
		end,
		[var_0_0.SYSTEM.TOPIC] = function()
			return var_0_0.SYSTEM.MAP
		end,
		[var_0_0.SYSTEM.MAP] = function()
			return var_0_0.SYSTEM.MAP
		end,
		[var_0_0.SYSTEM.PLAN] = function()
			return var_0_0.SYSTEM.ASSESS
		end,
		[var_0_0.SYSTEM.ASSESS] = function()
			getProxy = var_2_10000
			NewEducateProxy = var_2_10001

			local var_17_0 = var_2_10000(var_2_10001)
			local var_17_1 = var_0.GetCurChar(var_17_0)
			local var_17_2 = var_0.GetRoundData(var_17_1)

			if var_0.IsEndlessFail(var_17_2) then
				return var_0_0.SYSTEM.FAIL
			elseif not var_0:IsEndRound() or var_0:IsEndless() then
				return var_0_0.SYSTEM.PHASE
			else
				return var_0_0.SYSTEM.ENDING
			end

			return
		end,
		[var_0_0.SYSTEM.PHASE] = function()
			return var_0_0.SYSTEM.EVENT
		end,
		[var_0_0.SYSTEM.ENDING] = function()
			return var_0_0.SYSTEM.ENDING
		end
	}, function()
		return arg_9_0.systemNo
	end)
end

function var_0_0.Reset(arg_21_0)
	pairs = var_1_10001

	for iter_21_0, iter_21_1 in var_1_10001(arg_21_0.states) do
		iter_21_1:Reset()
	end

	arg_21_0.states[var_0_0.SYSTEM.TALENT] = nil
	arg_21_0.states[var_0_0.SYSTEM.TOPIC] = nil
	arg_21_0.states[var_0_0.SYSTEM.MAP] = nil
	arg_21_0.states[var_0_0.SYSTEM.ENDING] = nil
	arg_21_0.states[var_0_0.SYSTEM.MIND] = nil

	return
end

var_0_0.BENEFIT_PENDING = {
	var_0_0.SYSTEM.PLAN,
	var_0_0.SYSTEM.ASSESS,
	var_0_0.SYSTEM.PHASE
}

function var_0_0.IsImmediateBenefit(arg_22_0)
	table = var_1_10001

	return not var_1_10001.contains(var_0_0.BENEFIT_PENDING, arg_22_0.systemNo)
end

return var_0_0
