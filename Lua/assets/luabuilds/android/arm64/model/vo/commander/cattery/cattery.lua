local var_0_0 = class("Cattery", import("...BaseVO"))

var_0_0.STATE_LOCK = 1
var_0_0.STATE_EMPTY = 2
var_0_0.STATE_OCCUPATION = 3
var_0_0.OP_CLEAR = 1
var_0_0.OP_FEED = 2
var_0_0.OP_PLAY = 4

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.home = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.op = arg_1_2.op_flag or 0
	arg_1_0.expSettlementTime = arg_1_2.exp_time
	arg_1_0.commanderId = arg_1_2.commander_id or 0
	arg_1_0.style = arg_1_2.style or 1
	arg_1_0.opClean = bit.band(arg_1_0.op, var_0_0.OP_CLEAR) > 0
	arg_1_0.opFeed = bit.band(arg_1_0.op, var_0_0.OP_FEED) > 0
	arg_1_0.opPlay = bit.band(arg_1_0.op, var_0_0.OP_PLAY) > 0
	arg_1_0.cacheExp = arg_1_2.cache_exp or 0

	return
end

function var_0_0.AddCommander(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.commanderId = arg_2_1
	arg_2_0.expSettlementTime = arg_2_2

	arg_2_0:ClearCacheExp()

	return
end

function var_0_0.ReplaceCommander(arg_3_0, arg_3_1)
	arg_3_0.commanderId = arg_3_1

	arg_3_0:ClearCacheExp()

	return
end

function var_0_0.RemoveCommander(arg_4_0)
	arg_4_0.commanderId = 0

	arg_4_0:ClearCacheExp()

	return
end

function var_0_0.ExistCommander(arg_5_0)
	if arg_5_0.commanderId ~= 0 then
		local var_5_0 = getProxy(CommanderProxy):RawGetCommanderById(arg_5_0.commanderId) ~= nil

		return var_5_0
	end
end

function var_0_0.GetCommanderId(arg_6_0)
	return arg_6_0.commanderId
end

function var_0_0.GetCommander(arg_7_0)
	if arg_7_0:ExistCommander() then
		return getProxy(CommanderProxy):getCommanderById(arg_7_0.commanderId)
	end

	return
end

function var_0_0.CommanderCanClean(arg_8_0)
	if arg_8_0:ExistCommander() then
		return arg_8_0:GetCommander():ExistCleanFlag()
	end

	return false
end

function var_0_0.CommanderCanFeed(arg_9_0)
	if arg_9_0:ExistCommander() then
		return arg_9_0:GetCommander():ExitFeedFlag()
	end

	return false
end

function var_0_0.CommanderCanPlay(arg_10_0)
	if arg_10_0:ExistCommander() then
		return arg_10_0:GetCommander():ExitPlayFlag()
	end

	return false
end

function var_0_0.CommanderCanOP(arg_11_0, arg_11_1)
	if arg_11_1 == 1 then
		return arg_11_0:CommanderCanClean()
	elseif arg_11_1 == 2 then
		return arg_11_0:CommanderCanFeed()
	elseif arg_11_1 == 3 then
		return arg_11_0:CommanderCanPlay()
	end

	return
end

function var_0_0.GetStyle(arg_12_0)
	return arg_12_0.style
end

function var_0_0._GetStyle_(arg_13_0)
	return CatteryStyle.New({
		own = true,
		id = arg_13_0.style
	})
end

function var_0_0.UpdateStyle(arg_14_0, arg_14_1)
	arg_14_0.style = arg_14_1

	return
end

function var_0_0.IsDirty(arg_15_0)
	return arg_15_0.opClean == true
end

function var_0_0.GetOP(arg_16_0)
	return arg_16_0.op
end

function var_0_0.ExistCleanOP(arg_17_0)
	return arg_17_0.opClean
end

function var_0_0.ClearCleanOP(arg_18_0)
	arg_18_0.opClean = false

	return
end

function var_0_0.ExiseFeedOP(arg_19_0)
	return arg_19_0.opFeed
end

function var_0_0.ClearFeedOP(arg_20_0)
	arg_20_0.opFeed = false

	return
end

function var_0_0.ExistPlayOP(arg_21_0)
	return arg_21_0.opPlay
end

function var_0_0.ClearPlayOP(arg_22_0)
	arg_22_0.opPlay = false

	return
end

function var_0_0.ExistOP(arg_23_0, arg_23_1)
	if arg_23_1 == 1 then
		return arg_23_0:ExistCleanOP()
	elseif arg_23_1 == 2 then
		return arg_23_0:ExiseFeedOP()
	elseif arg_23_1 == 3 then
		return arg_23_0:ExistPlayOP()
	end

	return
end

function var_0_0.ClearOP(arg_24_0, arg_24_1)
	if arg_24_1 == 1 then
		arg_24_0:ClearCleanOP()
	elseif arg_24_1 == 2 then
		arg_24_0:ClearFeedOP()
	elseif arg_24_1 == 3 then
		arg_24_0:ClearPlayOP()
	end

	return
end

function var_0_0.ResetOP(arg_25_0)
	arg_25_0.opPlay = true
	arg_25_0.opFeed = true
	arg_25_0.opClean = true

	return
end

function var_0_0.ResetCleanOP(arg_26_0)
	arg_26_0.opClean = true

	return
end

function var_0_0.ResetFeedOP(arg_27_0)
	arg_27_0.opFeed = true

	return
end

function var_0_0.ResetPlayOP(arg_28_0)
	arg_28_0.opPlay = true

	return
end

function var_0_0.IsLocked(arg_29_0)
	if arg_29_0.home:GetMaxCatteryCnt() >= arg_29_0.id then
		return false
	end

	return true
end

function var_0_0.GetState(arg_30_0)
	if arg_30_0:IsLocked() then
		return var_0_0.STATE_LOCK
	end

	if arg_30_0:ExistCommander() then
		return var_0_0.STATE_OCCUPATION
	end

	return var_0_0.STATE_EMPTY
end

function var_0_0.GetCalcExpTime(arg_31_0)
	return arg_31_0.expSettlementTime
end

function var_0_0.UpdateCalcExpTime(arg_32_0, arg_32_1)
	arg_32_0.expSettlementTime = arg_32_1

	return
end

function var_0_0.CanUse(arg_33_0)
	return arg_33_0:GetState() ~= var_0_0.STATE_LOCK
end

function var_0_0.GetCacheExp(arg_34_0)
	return arg_34_0.cacheExp
end

function var_0_0.ClearCacheExp(arg_35_0)
	arg_35_0.cacheExp = 0

	return
end

function var_0_0.UpdateCacheExp(arg_36_0, arg_36_1)
	arg_36_0.cacheExp = arg_36_0.cacheExp + arg_36_1

	return
end

function var_0_0.ExistCacheExp(arg_37_0)
	return arg_37_0.cacheExp > 0
end

function var_0_0.GetCacheExpTime(arg_38_0)
	if arg_38_0:ExistCacheExp() then
		return (math.ceil(arg_38_0:GetCacheExp() / (arg_38_0.home:getConfig("exp_number") / 16)))
	else
		return 0
	end

	return
end

return var_0_0
