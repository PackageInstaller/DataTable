class = var_0_10000

local var_0_0 = "CommanderBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseVO"))

var_0_1.STATE_EMPTY = -1
var_0_1.STATE_WAITING = 0
var_0_1.STATE_STARTING = 1
var_0_1.STATE_FINISHED = 2

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0.index = arg_1_2 or 99
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.finish_time then
		var_1_0 = 0
	end

	arg_1_0.finishTime = var_1_0

	local var_1_1

	if not arg_1_1.begin_time then
		var_1_1 = 0
	end

	arg_1_0.beginTime = var_1_1

	local var_1_2

	if not arg_1_1.poolId then
		var_1_2 = 0
	end

	if var_1_2 and 0 < var_1_2 then
		getProxy = var_4
		CommanderProxy = var_1_10006

		local var_1_3 = var_4(var_1_10006)

		arg_1_0.pool = var_4.getPoolById(var_1_3, var_1_2)
	end

	return
end

function var_0_1.getPool(arg_2_0)
	return arg_2_0.pool
end

function var_0_1.getFinishTime(arg_3_0)
	return arg_3_0.finishTime
end

function var_0_1.ReduceFinishTime(arg_4_0, arg_4_1)
	math = var_1_10002
	arg_4_0.finishTime = var_1_10002.max(arg_4_0.beginTime, arg_4_0.finishTime - arg_4_1)

	return
end

function var_0_1.costTime(arg_5_0)
	if arg_5_0:getState() == var_0_1.STATE_STARTING or var_1 == var_0_1.STATE_FINISHED then
		return arg_5_0.finishTime - arg_5_0.beginTime
	else
		return 0
	end

	return
end

function var_0_1.getState(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()
	local var_6_1 = var_1.GetServerTime(var_6_0)

	if arg_6_0.finishTime == 0 then
		return var_0_1.STATE_EMPTY
	elseif var_6_1 >= arg_6_0.finishTime then
		return var_0_1.STATE_FINISHED
	elseif arg_6_0.finishTime > 0 and var_6_1 < arg_6_0.beginTime then
		return var_0_1.STATE_WAITING
	elseif arg_6_0.finishTime > 0 and var_6_1 < arg_6_0.finishTime then
		return var_0_1.STATE_STARTING
	end

	return
end

function var_0_1.finish(arg_7_0)
	arg_7_0.finishTime = 0
	arg_7_0.beginTime = 0

	return
end

function var_0_1.getPrefab(arg_8_0)
	if not arg_8_0.rarity2Str then
		arg_8_0.rarity2Str = {
			"",
			"SR",
			"SSR"
		}
	end

	if arg_8_0.pool then
		local var_8_0 = arg_8_0.rarity2Str
		local var_8_1 = arg_8_0.pool
		local var_8_2 = var_8_0[var_2.getRarity(var_8_1)]

		if arg_8_0:getState() == var_0_1.STATE_WAITING then
			return var_8_2 .. "NekoBox1"
		elseif var_2 == var_0_1.STATE_STARTING then
			return var_8_2 .. "NekoBox2"
		elseif var_2 == var_0_1.STATE_FINISHED then
			return var_8_2 .. "NekoBox3"
		end
	else
		return nil
	end

	return
end

function var_0_1.getFetchPrefab(arg_9_0)
	if not arg_9_0.rarity2Str then
		arg_9_0.rarity2Str = {
			"",
			"SR",
			"SSR"
		}
	end

	assert = var_1

	var_1(arg_9_0.pool)

	local var_9_0 = arg_9_0.rarity2Str
	local var_9_1 = arg_9_0.pool

	return var_9_0[var_2.getRarity(var_9_1)] .. "NekoBox4"
end

function var_0_1.IsSsr(arg_10_0)
	local var_10_0 = arg_10_0.pool

	return var_1.getRarity(var_10_0) == 3
end

function var_0_1.IsSr(arg_11_0)
	local var_11_0 = arg_11_0.pool

	return var_1.getRarity(var_11_0) == 2
end

function var_0_1.IsR(arg_12_0)
	local var_12_0 = arg_12_0.pool

	return var_1.getRarity(var_12_0) == 1
end

return var_0_1
