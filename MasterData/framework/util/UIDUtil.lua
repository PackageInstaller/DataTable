module("framework.util.UIDUtil", package.seeall)

local var_0_0 = 0
local var_0_1 = 100000000000
local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = 1000000
local var_0_5 = 1

function getUID()
	var_0_3 = var_0_3 + 1

	return var_0_3
end

function getDispatcherUID()
	var_0_0 = var_0_0 + 1

	return var_0_0
end

function getEventUID(arg_3_0)
	var_0_1 = var_0_1 + (arg_3_0 or 1)

	return var_0_1
end

function getModuleUID()
	var_0_2 = var_0_2 + 1

	return var_0_2
end

function getChannelId()
	var_0_4 = var_0_4 + 1

	return var_0_4
end

function getUidWithSum(arg_6_0, arg_6_1)
	return arg_6_0 + arg_6_1
end

function getUidJoint(arg_7_0, arg_7_1)
	return arg_7_0 .. arg_7_1
end
