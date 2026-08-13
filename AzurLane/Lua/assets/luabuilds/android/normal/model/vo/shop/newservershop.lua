class = var_0_10000

local var_0_0 = "NewServerShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.stopTime = arg_1_1.stop_time
	arg_1_0.goods = {}
	arg_1_0.phases = {}
	arg_1_0.activityId = arg_1_1.id

	local var_1_0 = {}

	ipairs = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10003(arg_1_1.goods) do
		local var_1_1 = iter_1_1.id

		NewServerCommodity = var_1_10009
		var_1_0[var_1_1] = var_1_10009.New(iter_1_1)
	end

	getProxy = var_3
	ActivityProxy = var_4

	local var_1_2 = var_3(var_4)
	local var_1_3 = var_3.getActivityById(var_1_2, arg_1_0.activityId)
	local var_1_4 = {}

	ipairs = var_5

	for iter_1_2, iter_1_3 in var_5(var_1_3:getConfig("config_data")) do
		var_1_4[iter_1_3] = true
	end

	pg = var_5

	local var_1_5 = var_5.newserver_shop_template.get_id_list_by_unlock_time

	pairs = var_6

	for iter_1_4, iter_1_5 in var_6(var_1_5) do
		local var_1_6

		var_1_6[iter_1_4], var_1_6 = arg_1_0:WrapPhaseGoods(iter_1_5, var_1_0, var_1_4), arg_1_0.goods
		table = var_1_6

		var_1_6.insert(arg_1_0.phases, iter_1_4)
	end

	return
end

function var_0_1.GetPtId(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityById(var_2_0, arg_2_0.activityId)
	local var_2_2 = var_1.getConfig(var_2_1, "config_data")

	pg = var_2_1

	return var_2_1.newserver_shop_template[var_2_2[1]].resource_type
end

function var_0_1.WrapPhaseGoods(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = {}

	ipairs = var_1_10005

	for iter_3_0, iter_3_1 in var_1_10005(arg_3_1) do
		if arg_3_3[iter_3_1] then
			if not arg_3_2[iter_3_1] then
				::label_3_0::

				NewServerCommodity = var_1_10011
				var_1_10011 = var_1_10011.New({
					id = iter_3_1
				})
			end

			var_3_0[var_1_10011.id] = var_1_10011
		end
	end

	return var_3_0
end

function var_0_1.GetStartTime(arg_4_0)
	return arg_4_0.startTime
end

function var_0_1.GetEndTime(arg_5_0)
	return arg_5_0.stopTime
end

function var_0_1.GetCommodityById(arg_6_0, arg_6_1)
	pairs = var_1_10002

	for iter_6_0, iter_6_1 in var_1_10002(arg_6_0.goods) do
		pairs = var_1_10007

		for iter_6_2, iter_6_3 in var_1_10007(iter_6_1) do
			if iter_6_2 == arg_6_1 then
				return iter_6_3
			end
		end
	end

	return
end

function var_0_1.GetOpeningGoodsList(arg_7_0, arg_7_1)
	local var_7_0 = {}
	local var_7_1 = arg_7_0.goods[arg_7_1]

	pairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(var_7_1) do
		table = var_1_10009

		var_1_10009.insert(var_7_0, iter_7_1)
	end

	return var_7_0
end

function var_0_1.IsOpenPhase(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.phases[arg_8_1]
	local var_8_1 = arg_8_0
	local var_8_2 = arg_8_0.GetStartTime(var_8_1) + var_8_0

	pg = var_8_1

	local var_8_3 = var_8_1.TimeMgr.GetInstance()

	return var_8_2 <= var_4.GetServerTime(var_8_3)
end

function var_0_1.GetPhases(arg_9_0)
	return arg_9_0.phases
end

return var_0_1
