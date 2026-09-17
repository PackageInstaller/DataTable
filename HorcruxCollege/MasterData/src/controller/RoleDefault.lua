RoleDefault = {}

local account_manager = require("controller.account_manager")
local var_0_1 = {}

function RoleDefault.getInstance(arg_1_0)
	return var_0_1
end

function var_0_1.setIntegerForKey(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = account_manager:getUserPlayerid()

	if not var_2_0 then
		return
	end

	cc.UserDefault:getInstance():setIntegerForKey(arg_2_1 .. "_" .. var_2_0, arg_2_2)
end

function var_0_1.getIntegerForKey(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = account_manager:getUserPlayerid()

	if not var_3_0 then
		return arg_3_2
	end

	return cc.UserDefault:getInstance():getIntegerForKey(arg_3_1 .. "_" .. var_3_0, arg_3_2)
end

function var_0_1.setFloatForKey(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = account_manager:getUserPlayerid()

	if not var_4_0 then
		return
	end

	cc.UserDefault:getInstance():setFloatForKey(arg_4_1 .. "_" .. var_4_0, arg_4_2)
end

function var_0_1.getFloatForKey(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = account_manager:getUserPlayerid()

	if not var_5_0 then
		return arg_5_2
	end

	return cc.UserDefault:getInstance():getFloatForKey(arg_5_1 .. "_" .. var_5_0, arg_5_2)
end

function var_0_1.setDoubleForKey(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = account_manager:getUserPlayerid()

	if not var_6_0 then
		return
	end

	cc.UserDefault:getInstance():setDoubleForKey(arg_6_1 .. "_" .. var_6_0, arg_6_2)
end

function var_0_1.getDoubleForKey(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = account_manager:getUserPlayerid()

	if not var_7_0 then
		return arg_7_2
	end

	return cc.UserDefault:getInstance():getDoubleForKey(arg_7_1 .. "_" .. var_7_0, arg_7_2)
end

function var_0_1.setStringForKey(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = account_manager:getUserPlayerid()

	if not var_8_0 then
		return
	end

	cc.UserDefault:getInstance():setStringForKey(arg_8_1 .. "_" .. var_8_0, arg_8_2)
end

function var_0_1.getStringForKey(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = account_manager:getUserPlayerid()

	if not var_9_0 then
		return arg_9_2
	end

	return cc.UserDefault:getInstance():getStringForKey(arg_9_1 .. "_" .. var_9_0, arg_9_2)
end

function var_0_1.setBoolForKey(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = account_manager:getUserPlayerid()

	if not var_10_0 then
		return
	end

	cc.UserDefault:getInstance():setBoolForKey(arg_10_1 .. "_" .. var_10_0, arg_10_2)
end

function var_0_1.getBoolForKey(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = account_manager:getUserPlayerid()

	if not var_11_0 then
		return arg_11_2
	end

	return cc.UserDefault:getInstance():getBoolForKey(arg_11_1 .. "_" .. var_11_0, arg_11_2)
end

function var_0_1.flush(arg_12_0)
	cc.UserDefault:getInstance():flush()
end

function var_0_1.getXMLFilePath(arg_13_0)
	return cc.UserDefault:getInstance():getXMLFilePath()
end

function var_0_1.isXMLFileExist(arg_14_0)
	return cc.UserDefault:getInstance():getXMLFilePath()
end

function var_0_1.destroyInstance(arg_15_0)
	cc.UserDefault:getInstance():destroyInstancec()
end

return RoleDefault
