local var_0_0 = class("IslandTicket", import("model.vo.BaseVO"))

var_0_0.TYPES = {
	ONE_HOUR = 3,
	TEN_MINUTE = 2,
	ONE_MINUTE = 1
}
var_0_0.TYPE2BG = {
	[var_0_0.TYPES.ONE_MINUTE] = "bg_blue",
	[var_0_0.TYPES.TEN_MINUTE] = "bg_purple",
	[var_0_0.TYPES.ONE_HOUR] = "bg_gold"
}
var_0_0.TYPE2FRAME = {
	[var_0_0.TYPES.ONE_MINUTE] = "rarity_blue",
	[var_0_0.TYPES.TEN_MINUTE] = "rarity_purple",
	[var_0_0.TYPES.ONE_HOUR] = "rarity_orange"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_0.id
	arg_1_0.count = arg_1_3
	arg_1_0.endTime = arg_1_2

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_speedup_ticket
end

function var_0_0.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_0.GetTime(arg_4_0)
	return arg_4_0:getConfig("speedup_time")
end

function var_0_0.GetBgName(arg_5_0)
	return var_0_0.TYPE2BG[arg_5_0:GetType()]
end

function var_0_0.GetFrameName(arg_6_0)
	return var_0_0.TYPE2FRAME[arg_6_0:GetType()]
end

function var_0_0.GetIconName(arg_7_0)
	return "island/" .. arg_7_0:getConfig("icon")
end

function var_0_0.GetCount(arg_8_0)
	return arg_8_0.count
end

function var_0_0.AddCount(arg_9_0, arg_9_1)
	arg_9_0.count = arg_9_0.count + arg_9_1

	return
end

function var_0_0.ReduceCount(arg_10_0, arg_10_1)
	arg_10_0.count = arg_10_0.count - arg_10_1

	return
end

function var_0_0.IsEmpty(arg_11_0)
	return arg_11_0.count <= 0
end

function var_0_0.IsForever(arg_12_0)
	return arg_12_0.endTime == 0
end

function var_0_0.GetEndTime(arg_13_0)
	return arg_13_0.endTime
end

function var_0_0.GetRemainTime(arg_14_0)
	return arg_14_0.endTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.IsExpired(arg_15_0)
	if arg_15_0:IsForever() then
		return false
	end

	return arg_15_0:GetRemainTime() < 0
end

function var_0_0.WillExpire(arg_16_0)
	if arg_16_0:IsForever() then
		return false
	end

	local var_16_0 = arg_16_0:GetRemainTime()

	return var_16_0 > 0 and var_16_0 < 0
end

function var_0_0.GetEndTimeById(arg_17_0, arg_17_1)
	if pg.island_speedup_ticket[arg_17_0].expiration_type == 2 then
		if pg.island_speedup_ticket[arg_17_0].expiration_time == "always" then
			return 0
		end

		return pg.TimeMgr.GetInstance():parseTimeFromConfig(pg.island_speedup_ticket[arg_17_0].expiration_time)
	elseif pg.island_speedup_ticket[arg_17_0].expiration_type == 1 then
		local var_17_1

		if not arg_17_1 then
			::label_17_0::

			local var_17_0 = pg.TimeMgr.GetInstance()

			var_17_1 = var_17_0:GetTimeToNextTime() - 0
		end

		return var_17_1 + 0 * pg.island_speedup_ticket[arg_17_0].duration - 1
	end

	return 0
end

return var_0_0
