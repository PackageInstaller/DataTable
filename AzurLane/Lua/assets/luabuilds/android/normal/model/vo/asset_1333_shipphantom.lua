class = var_0_10000

local var_0_0 = "ShipPhantom"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".Ship"))

function var_0_1.Change(arg_1_0, arg_1_1)
	assert = var_1_10002

	var_1_10002(arg_1_0.__cname == "Ship")

	setmetatable = var_1_10002

	var_1_10002(arg_1_0, var_0_1)

	arg_1_0.class = var_0_1
	arg_1_0.phantomId = arg_1_1

	return arg_1_0
end

function var_0_1.Revert(arg_2_0)
	assert = var_1_10001

	var_1_10001(arg_2_0.__cname == "ShipPhantom")

	setmetatable = var_1_10001

	local var_2_0 = arg_2_0

	Ship = var_1_10003

	var_1_10001(var_2_0, var_1_10003)

	Ship = var_1_10001
	arg_2_0.class = var_1_10001
	arg_2_0.phantomId = nil

	return arg_2_0
end

function var_0_1.Create(arg_3_0, arg_3_1)
	assert = var_1_10002

	var_1_10002(arg_3_0.__cname == "Ship")

	cloneRawTableFormClass = var_1_10002

	local var_3_0 = var_1_10002(arg_3_0)

	var_3_0.phantomId = arg_3_1
	setmetatable = var_3

	var_3(var_3_0, var_0_1)

	var_3_0.class = var_0_1

	return var_3_0
end

function var_0_1.getSkinId(arg_4_0, arg_4_1)
	return var_0_1.super.getSkinId(arg_4_0, arg_4_1 or arg_4_0.phantomId)
end

function var_0_1.GetShipPhantomMark(arg_5_0, arg_5_1)
	return var_0_1.super.GetShipPhantomMark(arg_5_0, arg_5_1 or arg_5_0.phantomId)
end

function var_0_1.getRandomFlag(arg_6_0)
	return var_0_1.super.getRandomFlag(arg_6_0, arg_6_0.phantomId)
end

function var_0_1.GetSelectMark(arg_7_0)
	return arg_7_0:GetShipPhantomMark()
end

function var_0_1.PackMark(arg_8_0, arg_8_1)
	return arg_8_0 .. "_" .. (arg_8_1 or 0)
end

function var_0_1.UnpackMark(arg_9_0)
	unpack = var_1_10001
	underscore = var_1_10002

	local var_9_0 = var_1_10002.map

	string = var_1_10003

	return var_1_10001(var_9_0(var_1_10003.split(arg_9_0, "_"), function(arg_10_0)
		tonumber = var_2_10001

		return var_2_10001(arg_10_0)
	end))
end

return var_0_1
