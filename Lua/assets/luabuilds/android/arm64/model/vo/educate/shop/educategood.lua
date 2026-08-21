local var_0_0 = class("EducateGood", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.remainCnt = arg_1_1.num

	arg_1_0:initTime()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_shop_template
end

function var_0_0.IsAlwaysTime(arg_3_0)
	return arg_3_0:getConfig("time") == "always"
end

function var_0_0.initTime(arg_4_0)
	if not arg_4_0:IsAlwaysTime() then
		arg_4_0.startTime, arg_4_0.endTime = EducateHelper.CfgTime2Time((arg_4_0:getConfig("time")))
	end

	return
end

function var_0_0.CanBuy(arg_5_0)
	return arg_5_0:GetRemainCnt() > 0
end

function var_0_0.GetRemainCnt(arg_6_0)
	return arg_6_0.remainCnt
end

function var_0_0.ReduceRemainCnt(arg_7_0, arg_7_1)
	arg_7_0.remainCnt = arg_7_0.remainCnt - arg_7_1

	return
end

function var_0_0.GetCost(arg_8_0, arg_8_1)
	return {
		id = arg_8_0:getConfig("resource"),
		num = arg_8_0:GetPrice(arg_8_1)
	}
end

function var_0_0.GetPrice(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getConfig("resource_num")

	if not arg_9_1 then
		return var_9_0
	end

	return math.floor(var_9_0 * (1 - arg_9_1 / 16))
end

function var_0_0.GetShowInfo(arg_10_0)
	return {
		type = EducateConst.DROP_TYPE_ITEM,
		id = arg_10_0:getConfig("item_id"),
		number = arg_10_0:getConfig("buy_num")
	}
end

function var_0_0.InTime(arg_11_0, arg_11_1)
	if not arg_11_0:IsAlwaysTime() then
		return EducateHelper.InTime(arg_11_1, arg_11_0.startTime, arg_11_0.endTime)
	else
		return true
	end

	return
end

return var_0_0
