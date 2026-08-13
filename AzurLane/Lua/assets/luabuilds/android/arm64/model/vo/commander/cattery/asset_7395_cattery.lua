class = var_0_10000

local var_0_0 = "Cattery"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseVO"))

var_0_1.STATE_LOCK = 1
var_0_1.STATE_EMPTY = 2
var_0_1.STATE_OCCUPATION = 3
var_0_1.OP_CLEAR = 1
var_0_1.OP_FEED = 2
var_0_1.OP_PLAY = 4

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.home = arg_1_1
	arg_1_0.id = arg_1_2.id

	local var_1_0

	if not arg_1_2.op_flag then
		var_1_0 = 0
	end

	arg_1_0.op = var_1_0
	arg_1_0.expSettlementTime = arg_1_2.exp_time

	local var_1_1

	if not arg_1_2.commander_id then
		var_1_1 = 0
	end

	arg_1_0.commanderId = var_1_1

	local var_1_2

	if not arg_1_2.style then
		var_1_2 = 1
	end

	arg_1_0.style = var_1_2
	bit = var_1_2
	arg_1_0.opClean = var_1_2.band(arg_1_0.op, var_0_1.OP_CLEAR) > 0
	bit = var_3
	arg_1_0.opFeed = var_3.band(arg_1_0.op, var_0_1.OP_FEED) > 0
	bit = var_3
	arg_1_0.opPlay = var_3.band(arg_1_0.op, var_0_1.OP_PLAY) > 0

	local var_1_3

	if not arg_1_2.cache_exp then
		var_1_3 = 0
	end

	arg_1_0.cacheExp = var_1_3

	return
end

function var_0_1.AddCommander(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.commanderId = arg_2_1
	arg_2_0.expSettlementTime = arg_2_2

	arg_2_0:ClearCacheExp()

	return
end

function var_0_1.ReplaceCommander(arg_3_0, arg_3_1)
	arg_3_0.commanderId = arg_3_1

	arg_3_0:ClearCacheExp()

	return
end

function var_0_1.RemoveCommander(arg_4_0)
	arg_4_0.commanderId = 0

	arg_4_0:ClearCacheExp()

	return
end

function var_0_1.ExistCommander(arg_5_0)
	if arg_5_0.commanderId ~= 0 then
		getProxy = var_1
		CommanderProxy = var_1_10003

		local var_5_0 = var_1(var_1_10003)
		local var_5_1

		if var_1.RawGetCommanderById(var_5_0, arg_5_0.commanderId) == nil then
			var_5_1 = false
		else
			var_5_1 = true
		end

		return var_5_1
	end
end

function var_0_1.GetCommanderId(arg_6_0)
	return arg_6_0.commanderId
end

function var_0_1.GetCommander(arg_7_0)
	local var_7_0 = arg_7_0

	if arg_7_0.ExistCommander(var_7_0) then
		getProxy = var_1
		CommanderProxy = var_7_0

		local var_7_1 = var_1(var_7_0)

		return var_1.getCommanderById(var_7_1, arg_7_0.commanderId)
	end

	return
end

function var_0_1.CommanderCanClean(arg_8_0)
	if arg_8_0:ExistCommander() then
		local var_8_0 = arg_8_0:GetCommander()

		return var_1.ExistCleanFlag(var_8_0)
	end

	return false
end

function var_0_1.CommanderCanFeed(arg_9_0)
	if arg_9_0:ExistCommander() then
		local var_9_0 = arg_9_0:GetCommander()

		return var_1.ExitFeedFlag(var_9_0)
	end

	return false
end

function var_0_1.CommanderCanPlay(arg_10_0)
	if arg_10_0:ExistCommander() then
		local var_10_0 = arg_10_0:GetCommander()

		return var_1.ExitPlayFlag(var_10_0)
	end

	return false
end

function var_0_1.CommanderCanOP(arg_11_0, arg_11_1)
	if arg_11_1 == 1 then
		return arg_11_0:CommanderCanClean()
	elseif arg_11_1 == 2 then
		return arg_11_0:CommanderCanFeed()
	elseif arg_11_1 == 3 then
		return arg_11_0:CommanderCanPlay()
	end

	return
end

function var_0_1.GetStyle(arg_12_0)
	return arg_12_0.style
end

function var_0_1._GetStyle_(arg_13_0)
	CatteryStyle = var_1_10001

	return var_1_10001.New({
		own = true,
		id = arg_13_0.style
	})
end

function var_0_1.UpdateStyle(arg_14_0, arg_14_1)
	arg_14_0.style = arg_14_1

	return
end

function var_0_1.IsDirty(arg_15_0)
	return arg_15_0.opClean == true
end

function var_0_1.GetOP(arg_16_0)
	return arg_16_0.op
end

function var_0_1.ExistCleanOP(arg_17_0)
	return arg_17_0.opClean
end

function var_0_1.ClearCleanOP(arg_18_0)
	arg_18_0.opClean = false

	return
end

function var_0_1.ExiseFeedOP(arg_19_0)
	return arg_19_0.opFeed
end

function var_0_1.ClearFeedOP(arg_20_0)
	arg_20_0.opFeed = false

	return
end

function var_0_1.ExistPlayOP(arg_21_0)
	return arg_21_0.opPlay
end

function var_0_1.ClearPlayOP(arg_22_0)
	arg_22_0.opPlay = false

	return
end

function var_0_1.ExistOP(arg_23_0, arg_23_1)
	if arg_23_1 == 1 then
		return arg_23_0:ExistCleanOP()
	elseif arg_23_1 == 2 then
		return arg_23_0:ExiseFeedOP()
	elseif arg_23_1 == 3 then
		return arg_23_0:ExistPlayOP()
	end

	return
end

function var_0_1.ClearOP(arg_24_0, arg_24_1)
	if arg_24_1 == 1 then
		arg_24_0:ClearCleanOP()
	elseif arg_24_1 == 2 then
		arg_24_0:ClearFeedOP()
	elseif arg_24_1 == 3 then
		arg_24_0:ClearPlayOP()
	end

	return
end

function var_0_1.ResetOP(arg_25_0)
	arg_25_0.opPlay = true
	arg_25_0.opFeed = true
	arg_25_0.opClean = true

	return
end

function var_0_1.ResetCleanOP(arg_26_0)
	arg_26_0.opClean = true

	return
end

function var_0_1.ResetFeedOP(arg_27_0)
	arg_27_0.opFeed = true

	return
end

function var_0_1.ResetPlayOP(arg_28_0)
	arg_28_0.opPlay = true

	return
end

function var_0_1.IsLocked(arg_29_0)
	local var_29_0 = arg_29_0.home

	if var_1.GetMaxCatteryCnt(var_29_0) >= arg_29_0.id then
		return false
	end

	return true
end

function var_0_1.GetState(arg_30_0)
	if arg_30_0:IsLocked() then
		return var_0_1.STATE_LOCK
	end

	if arg_30_0:ExistCommander() then
		return var_0_1.STATE_OCCUPATION
	end

	return var_0_1.STATE_EMPTY
end

function var_0_1.GetCalcExpTime(arg_31_0)
	return arg_31_0.expSettlementTime
end

function var_0_1.UpdateCalcExpTime(arg_32_0, arg_32_1)
	arg_32_0.expSettlementTime = arg_32_1

	return
end

function var_0_1.CanUse(arg_33_0)
	return arg_33_0:GetState() ~= var_0_1.STATE_LOCK
end

function var_0_1.GetCacheExp(arg_34_0)
	return arg_34_0.cacheExp
end

function var_0_1.ClearCacheExp(arg_35_0)
	arg_35_0.cacheExp = 0

	return
end

function var_0_1.UpdateCacheExp(arg_36_0, arg_36_1)
	arg_36_0.cacheExp = arg_36_0.cacheExp + arg_36_1

	return
end

function var_0_1.ExistCacheExp(arg_37_0)
	return arg_37_0.cacheExp > 0
end

function var_0_1.GetCacheExpTime(arg_38_0)
	if arg_38_0:ExistCacheExp() then
		local var_38_0 = arg_38_0:GetCacheExp()
		local var_38_1 = arg_38_0.home
		local var_38_2 = var_2.getConfig(var_38_1, "exp_number") / 16

		math = var_38_1

		return (var_38_1.ceil(var_38_0 / var_38_2))
	else
		return 0
	end

	return
end

return var_0_1
