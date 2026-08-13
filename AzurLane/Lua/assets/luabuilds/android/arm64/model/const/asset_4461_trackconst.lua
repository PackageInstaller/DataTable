class = var_0_10000

local var_0_0 = var_0_10000("TrackConst")

function var_0_0.GetTrackData(arg_1_0, arg_1_1, ...)
	return {
		system = arg_1_0,
		id = arg_1_1,
		desc = var_0_0.GetDesc(arg_1_0, arg_1_1, ...)
	}
end

function var_0_0.GetDesc(arg_2_0, arg_2_1, ...)
	local var_2_0 = var_0_0["Build" .. arg_2_0 .. "Action" .. arg_2_1 .. "Desc"]

	unpack = var_4

	return var_2_0(var_4({
		...
	}))
end

var_0_0.SYSTEM_SHOP = 1
var_0_0.ACTION_ENTER_MAIN = 1
var_0_0.ACTION_ENTER_GIFT = 2
var_0_0.ACTION_BUY_RECOMMEND = 3
var_0_0.ACTION_LOOKUP_RECOMMEND = 4

function var_0_0.Build1Action1Desc(arg_3_0)
	return arg_3_0 and "1" or "0"
end

function var_0_0.Build1Action2Desc(arg_4_0)
	return arg_4_0 and "1" or "0"
end

function var_0_0.Build1Action3Desc(arg_5_0)
	return arg_5_0 .. ""
end

function var_0_0.Build1Action4Desc(arg_6_0)
	return arg_6_0 .. ""
end

return var_0_0
