local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_share_info(arg_1_1)
	return self:getActivityObj(arg_1_1):get_activity_share_info()
end

function activity_base_manager:choose_activity_newyear2022_reward(arg_2_1, arg_2_2)
	return self:getActivityObj(arg_2_1):choose_activity_newyear2022_reward(arg_2_2)
end

function activity_base_manager:recv_activity_newyear2022_reward(arg_3_1)
	return self:getActivityObj(arg_3_1):recv_activity_newyear2022_reward()
end

function activity_base_manager:write_activity_newyear2022_code(arg_4_1, arg_4_2)
	return self:getActivityObj(arg_4_1):write_activity_newyear2022_code(arg_4_2)
end

function activity_base_manager:get_activity_newyear2022_share(arg_5_1, arg_5_2, arg_5_3)
	return self:getActivityObj(arg_5_1):get_activity_newyear2022_share(arg_5_2, arg_5_3)
end

function activity_base_manager:recv_activity_newyear2022_share(arg_6_1, arg_6_2, arg_6_3)
	return self:getActivityObj(arg_6_1):recv_activity_newyear2022_share(arg_6_2, arg_6_3)
end

function activity_base_manager:getLolShareLockTime(arg_7_1, arg_7_2)
	return self:getActivityObj(arg_7_1):getLolShareLockTime(arg_7_2)
end
