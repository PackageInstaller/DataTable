local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_recruit_info(arg_1_1)
	local var_1_0 = self:getActivityObj(arg_1_1)

	if not var_1_0 then
		return
	end

	return var_1_0:get_recruit_info()
end

function activity_base_manager:complete_recurit_task(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = self:getActivityObj(arg_2_1)

	if not var_2_0 then
		return
	end

	return var_2_0:complete_recurit_task(arg_2_2, arg_2_3)
end

function activity_base_manager:get_recurit_reward(arg_3_1, arg_3_2)
	local var_3_0 = self:getActivityObj(arg_3_1)

	if not var_3_0 then
		return
	end

	return var_3_0:get_recurit_reward(arg_3_2)
end

function activity_base_manager:get_recurit_tasks(arg_4_1, arg_4_2)
	local var_4_0 = self:getActivityObj(arg_4_1)

	if not var_4_0 then
		return
	end

	return var_4_0:get_recurit_tasks(arg_4_2)
end

function activity_base_manager:get_recurit_roles(arg_5_1)
	local var_5_0 = self:getActivityObj(arg_5_1)

	if not var_5_0 then
		return
	end

	return var_5_0:get_recurit_roles()
end

function activity_base_manager:get_recurit_data(arg_6_1, arg_6_2)
	local var_6_0 = self:getActivityObj(arg_6_1)

	if not var_6_0 then
		return
	end

	return var_6_0:get_recurit_data(arg_6_2)
end
