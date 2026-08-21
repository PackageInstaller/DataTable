local var_0_0 = class("NewServerShop", import("..BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.stopTime = arg_1_1.stop_time
	arg_1_0.goods = {}
	arg_1_0.phases = {}
	arg_1_0.activityId = arg_1_1.id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.goods) do
		({})[iter_1_1.id] = NewServerCommodity.New(iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(getProxy(ActivityProxy):getActivityById(arg_1_0.activityId):getConfig("config_data")) do
		({})[iter_1_3] = true
	end

	for iter_1_4, iter_1_5 in pairs(pg.newserver_shop_template.get_id_list_by_unlock_time) do
		arg_1_0.goods[iter_1_4] = arg_1_0:WrapPhaseGoods(iter_1_5, {}, {})

		table.insert(arg_1_0.phases, iter_1_4)
	end

	return
end

function var_0_0.GetPtId(arg_2_0)
	return pg.newserver_shop_template[getProxy(ActivityProxy):getActivityById(arg_2_0.activityId):getConfig("config_data")[1]].resource_type
end

function var_0_0.WrapPhaseGoods(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if arg_3_3[iter_3_1] then
			local var_3_0 = arg_3_2[iter_3_1] or NewServerCommodity.New({
				id = iter_3_1
			})
			local var_3_1 = var_3_0.id

			;({})[var_3_1] = var_3_0
		end
	end

	return {}
end

function var_0_0.GetStartTime(arg_4_0)
	return arg_4_0.startTime
end

function var_0_0.GetEndTime(arg_5_0)
	return arg_5_0.stopTime
end

function var_0_0.GetCommodityById(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.goods) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			if iter_6_2 == arg_6_1 then
				return iter_6_3
			end
		end
	end

	return
end

function var_0_0.GetOpeningGoodsList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.goods[arg_7_1]) do
		table.insert({}, iter_7_1)
	end

	return {}
end

function var_0_0.IsOpenPhase(arg_8_0, arg_8_1)
	local var_8_0 = pg.TimeMgr.GetInstance()

	return arg_8_0:GetStartTime() + arg_8_0.phases[arg_8_1] <= var_8_0:GetServerTime()
end

function var_0_0.GetPhases(arg_9_0)
	return arg_9_0.phases
end

return var_0_0
