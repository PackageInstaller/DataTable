local var_0_0 = class("NewEducateFSM")

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
	arg_1_0.curNode = arg_1_2.current_node or 0

	local var_1_0 = arg_1_2.cache[1]

	arg_1_0.states = {}
	arg_1_0.states[var_0_0.SYSTEM.INIT] = NewEducateStateBase.New()
	arg_1_0.states[var_0_0.SYSTEM.EVENT] = NewEducateStateBase.New()

	if #var_1_0.cache_talent > 0 then
		arg_1_0.states[var_0_0.SYSTEM.TALENT] = NewEducateTalentState.New(var_1_0.cache_talent[1])
	end

	arg_1_0.states[var_0_0.SYSTEM.CHOOSE] = NewEducateStateBase.New()

	if #var_1_0.cache_chat > 0 then
		arg_1_0.states[var_0_0.SYSTEM.TOPIC] = NewEducateTopicState.New(var_1_0.cache_chat[1])
	end

	if #var_1_0.cache_site > 0 then
		arg_1_0.states[var_0_0.SYSTEM.MAP] = NewEducateMapState.New(arg_1_1, var_1_0.cache_site[1])
	end

	local var_1_1 = arg_1_0.states
	local var_1_2 = var_0_0.SYSTEM.PLAN

	if #var_1_0.cache_plan > 0 then
		local var_1_4 = var_1_0.cache_plan[1] or {}

		var_1_1[var_1_2] = var_1_3(var_1_4)

		if #var_1_0.cache_eval > 0 then
			arg_1_0.states[var_0_0.SYSTEM.ASSESS] = NewEducateAssessState.New(var_1_0.cache_eval[1])
		elseif arg_1_0.systemNo == var_0_0.SYSTEM.ASSESS and #var_1_0.cache_eval == 0 then
			arg_1_0.states[var_0_0.SYSTEM.ASSESS] = NewEducateAssessState.New({
				is_finished = 0
			})
		end

		arg_1_0.states[var_0_0.SYSTEM.PHASE] = NewEducateStateBase.New()

		if #var_1_0.cache_end > 0 then
			arg_1_0.states[var_0_0.SYSTEM.ENDING] = NewEducateEndingState.New(var_1_0.cache_end[1])
		end

		if #var_1_0.cache_mind > 0 then
			arg_1_0.states[var_0_0.SYSTEM.MIND] = NewEducateStateBase.New(var_1_0.cache_mind[1])
		end

		return
	end
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
	return arg_7_0.states[arg_7_1] or nil
end

function var_0_0.GetCurState(arg_8_0)
	return arg_8_0.states[arg_8_0.systemNo]
end

function var_0_0.CheckStystem(arg_9_0)
	warning(arg_9_0.curNode, arg_9_0.systemNo)

	if arg_9_0.curNode ~= 0 then
		return arg_9_0.systemNo
	end

	if not arg_9_0.states[arg_9_0.systemNo]:IsFinish() then
		return arg_9_0.systemNo
	end

	return switch(arg_9_0.systemNo, {
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
			local var_17_0 = getProxy(NewEducateProxy):GetCurChar():GetRoundData()

			if var_17_0:IsEndlessFail() then
				return var_0_0.SYSTEM.FAIL
			elseif not var_17_0:IsEndRound() or var_17_0:IsEndless() then
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
	for iter_21_0, iter_21_1 in pairs(arg_21_0.states) do
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
	return not table.contains(var_0_0.BENEFIT_PENDING, arg_22_0.systemNo)
end

return var_0_0
