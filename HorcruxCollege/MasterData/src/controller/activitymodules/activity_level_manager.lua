local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_level_info(arg_1_1, arg_1_2)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:get_activity_level_info(arg_1_2)
end

function activity_base_manager:get_cur_activity_technology(arg_2_1, arg_2_2)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:get_cur_activity_technology(arg_2_2)
end

function activity_base_manager:get_activity_level_buy_time_cost(arg_3_1)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:get_activity_level_buy_time_cost()
end

function activity_base_manager:add_activity_level_time(arg_4_1)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:add_activity_level_time()
end

function activity_base_manager:getActivityLevelDrop(arg_5_1, arg_5_2)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:getActivityLevelDrop(arg_5_2)
end

function activity_base_manager:getDailyLevelItem(arg_6_1, arg_6_2)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:getDailyLevelItem(arg_6_2)
end

function activity_base_manager:getDailyLevelServant(arg_7_1, arg_7_2)
	local var_7_0 = self:getActivityObj(arg_7_1)

	if not var_7_0 then
		return
	end

	return var_7_0:getDailyLevelServant(arg_7_2)
end

function activity_base_manager:sweep_activity_daily_level(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = self:getActivityObj(arg_8_1)

	if not var_8_0 then
		return
	end

	return var_8_0:sweep_activity_daily_level(arg_8_2, arg_8_3, arg_8_4, arg_8_5)
end
