class = var_0_10000

local var_0_0 = "CommonBuff"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.timestamp = arg_1_1.timestamp

	return
end

function var_0_1.IsActiveType(arg_2_0)
	return false
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.benefit_buff_template
end

function var_0_1.checkShow(arg_4_0)
	return arg_4_0:getConfig("hide") ~= 1
end

function var_0_1.isActivate(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_5_0) <= arg_5_0.timestamp
end

function var_0_1.getLeftTime(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TimeMgr.GetInstance()
	local var_6_1 = var_1.GetServerTime(var_6_0)

	return arg_6_0.timestamp - var_6_1
end

return var_0_1
