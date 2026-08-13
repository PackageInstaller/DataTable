class = var_0_10000

local var_0_0 = "IslandTicket"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPES = {
	ONE_HOUR = 3,
	TEN_MINUTE = 2,
	ONE_MINUTE = 1
}
var_0_1.TYPE2BG = {
	[var_0_1.TYPES.ONE_MINUTE] = "bg_blue",
	[var_0_1.TYPES.TEN_MINUTE] = "bg_purple",
	[var_0_1.TYPES.ONE_HOUR] = "bg_gold"
}
var_0_1.TYPE2FRAME = {
	[var_0_1.TYPES.ONE_MINUTE] = "rarity_blue",
	[var_0_1.TYPES.TEN_MINUTE] = "rarity_purple",
	[var_0_1.TYPES.ONE_HOUR] = "rarity_orange"
}

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_3
	arg_1_0.endTime = arg_1_2

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_speedup_ticket
end

function var_0_1.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_1.GetTime(arg_4_0)
	return arg_4_0:getConfig("speedup_time")
end

function var_0_1.GetBgName(arg_5_0)
	return var_0_1.TYPE2BG[arg_5_0:GetType()]
end

function var_0_1.GetFrameName(arg_6_0)
	return var_0_1.TYPE2FRAME[arg_6_0:GetType()]
end

function var_0_1.GetIconName(arg_7_0)
	return "island/" .. arg_7_0:getConfig("icon")
end

function var_0_1.GetCount(arg_8_0)
	return arg_8_0.count
end

function var_0_1.AddCount(arg_9_0, arg_9_1)
	arg_9_0.count = arg_9_0.count + arg_9_1

	return
end

function var_0_1.ReduceCount(arg_10_0, arg_10_1)
	arg_10_0.count = arg_10_0.count - arg_10_1

	return
end

function var_0_1.IsEmpty(arg_11_0)
	return arg_11_0.count <= 0
end

function var_0_1.IsForever(arg_12_0)
	return arg_12_0.endTime == 0
end

function var_0_1.GetEndTime(arg_13_0)
	return arg_13_0.endTime
end

function var_0_1.GetRemainTime(arg_14_0)
	local var_14_0 = arg_14_0.endTime

	pg = var_1_10002

	local var_14_1 = var_1_10002.TimeMgr.GetInstance()

	return var_14_0 - var_2.GetServerTime(var_14_1)
end

function var_0_1.IsExpired(arg_15_0)
	if arg_15_0:IsForever() then
		return false
	end

	return arg_15_0:GetRemainTime() < 0
end

function var_0_1.WillExpire(arg_16_0)
	if arg_16_0:IsForever() then
		return false
	end

	return arg_16_0:GetRemainTime() > 0 and var_1 < 0
end

function var_0_1.GetEndTimeById(arg_17_0, arg_17_1)
	pg = var_1_10002

	if var_1_10002.island_speedup_ticket[arg_17_0].expiration_type == 2 then
		if var_2.expiration_time == "always" then
			return 0
		end

		pg = var_1_10004

		local var_17_0 = var_1_10004.TimeMgr.GetInstance()

		return var_4.parseTimeFromConfig(var_17_0, var_3)
	elseif var_2.expiration_type == 1 then
		local var_17_2

		if not arg_17_1 then
			::label_17_0::

			pg = var_17_2

			local var_17_1 = var_17_2.TimeMgr.GetInstance()

			var_17_2 = var_17_2.GetTimeToNextTime(var_17_1) - 0
		end

		return var_17_2 + 0 * var_2.duration - 1
	end

	return 0
end

return var_0_1
