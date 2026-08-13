class = var_0_10000

local var_0_0 = "VipCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.MONTH = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.type
	arg_1_0.type = arg_1_1.type
	arg_1_0.leftDate = arg_1_1.left_date
	arg_1_0.data = arg_1_1.data

	return
end

function var_0_1.getLeftDate(arg_2_0)
	if arg_2_0.type == var_0_1.MONTH then
		return arg_2_0.leftDate + 0
	end

	return
end

function var_0_1.GetLeftDay(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getLeftDate(var_3_0)

	pg = var_1_10002

	local var_3_2 = var_1_10002.TimeMgr.GetInstance()
	local var_3_3 = var_2.GetServerTime(var_3_2)

	math = var_3_0

	return (var_3_0.floor((var_3_1 - var_3_3) / 0))
end

function var_0_1.isExpire(arg_4_0)
	if arg_4_0.type == var_0_1.MONTH then
		local var_4_0 = arg_4_0:getLeftDate()

		pg = var_2

		local var_4_1 = var_2.TimeMgr.GetInstance()

		return var_4_0 <= var_2.GetServerTime(var_4_1)
	end

	return
end

return var_0_1
