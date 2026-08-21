local var_0_0 = class("ShipPhantom", import(".Ship"))

function var_0_0.Change(arg_1_0, arg_1_1)
	assert(arg_1_0.__cname == "Ship")
	setmetatable(arg_1_0, var_0_0)

	arg_1_0.class = var_0_0
	arg_1_0.phantomId = arg_1_1

	return arg_1_0
end

function var_0_0.Revert(arg_2_0)
	assert(arg_2_0.__cname == "ShipPhantom")
	setmetatable(arg_2_0, Ship)

	arg_2_0.class = Ship
	arg_2_0.phantomId = nil

	return arg_2_0
end

function var_0_0.Create(arg_3_0, arg_3_1)
	assert(arg_3_0.__cname == "Ship")

	local var_3_0 = cloneRawTableFormClass(arg_3_0)

	var_3_0.phantomId = arg_3_1

	setmetatable(var_3_0, var_0_0)

	var_3_0.class = var_0_0

	return var_3_0
end

function var_0_0.getSkinId(arg_4_0, arg_4_1)
	return var_0_0.super.getSkinId(arg_4_0, arg_4_1 or arg_4_0.phantomId)
end

function var_0_0.GetShipPhantomMark(arg_5_0, arg_5_1)
	return var_0_0.super.GetShipPhantomMark(arg_5_0, arg_5_1 or arg_5_0.phantomId)
end

function var_0_0.getRandomFlag(arg_6_0)
	return var_0_0.super.getRandomFlag(arg_6_0, arg_6_0.phantomId)
end

function var_0_0.GetSelectMark(arg_7_0)
	return arg_7_0:GetShipPhantomMark()
end

function var_0_0.PackMark(arg_8_0, arg_8_1)
	return arg_8_0 .. "_" .. (arg_8_1 or 0)
end

function var_0_0.UnpackMark(arg_9_0)
	return unpack(underscore.map(string.split(arg_9_0, "_"), function(arg_10_0)
		return tonumber(arg_10_0)
	end))
end

return var_0_0
