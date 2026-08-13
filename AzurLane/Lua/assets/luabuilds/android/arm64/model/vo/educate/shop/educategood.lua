class = var_0_10000

local var_0_0 = "EducateGood"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.remainCnt = arg_1_1.num

	arg_1_0:initTime()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_shop_template
end

function var_0_1.IsAlwaysTime(arg_3_0)
	return arg_3_0:getConfig("time") == "always"
end

function var_0_1.initTime(arg_4_0)
	if not arg_4_0:IsAlwaysTime() then
		local var_4_0 = arg_4_0:getConfig("time")

		EducateHelper = var_1_10002
		arg_4_0.startTime, arg_4_0.endTime = var_1_10002.CfgTime2Time(var_4_0)
	end

	return
end

function var_0_1.CanBuy(arg_5_0)
	return arg_5_0:GetRemainCnt() > 0
end

function var_0_1.GetRemainCnt(arg_6_0)
	return arg_6_0.remainCnt
end

function var_0_1.ReduceRemainCnt(arg_7_0, arg_7_1)
	arg_7_0.remainCnt = arg_7_0.remainCnt - arg_7_1

	return
end

function var_0_1.GetCost(arg_8_0, arg_8_1)
	return {
		id = arg_8_0:getConfig("resource"),
		num = arg_8_0:GetPrice(arg_8_1)
	}
end

function var_0_1.GetPrice(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getConfig("resource_num")

	if not arg_9_1 then
		return var_9_0
	end

	math = var_1_10003

	return var_1_10003.floor(var_9_0 * (1 - arg_9_1 / 16))
end

function var_0_1.GetShowInfo(arg_10_0)
	local var_10_0 = {}

	EducateConst = var_1_10002
	var_10_0.type = var_1_10002.DROP_TYPE_ITEM
	var_10_0.id = arg_10_0:getConfig("item_id")
	var_10_0.number = arg_10_0:getConfig("buy_num")

	return var_10_0
end

function var_0_1.InTime(arg_11_0, arg_11_1)
	if not arg_11_0:IsAlwaysTime() then
		EducateHelper = var_2

		return var_2.InTime(arg_11_1, arg_11_0.startTime, arg_11_0.endTime)
	else
		return true
	end

	return
end

return var_0_1
