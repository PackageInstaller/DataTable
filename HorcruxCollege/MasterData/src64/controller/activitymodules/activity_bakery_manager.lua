local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_activity_bakery_data(arg_1_1, arg_1_2)
	return self.activities[arg_1_1]:get_activity_bakery_data(arg_1_2)
end

function activity_base_manager:activity_bakery_device_levelup(arg_2_1, arg_2_2, arg_2_3)
	return self.activities[arg_2_1]:activity_bakery_device_levelup(arg_2_2, arg_2_3)
end

function activity_base_manager:activity_bakery_pass_level(arg_3_1, arg_3_2, arg_3_3)
	return self.activities[arg_3_1]:activity_bakery_pass_level(arg_3_2, arg_3_3)
end

function activity_base_manager:activity_bakery_game_start(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	return self.activities[arg_4_1]:activity_bakery_game_start(arg_4_2, arg_4_3, arg_4_4)
end

function activity_base_manager:activity_get_bakery_conf(arg_5_1)
	return self.activities[arg_5_1]:activity_get_bakery_conf()
end

function activity_base_manager:activity_get_bakery_level_conf(arg_6_1)
	return self.activities[arg_6_1]:activity_get_bakery_level_conf()
end

function activity_base_manager:activity_get_bakery_cur_data(arg_7_1)
	return self.activities[arg_7_1]:activity_get_bakery_cur_data()
end

function activity_base_manager:activity_get_bakery_device_levelinfo(arg_8_1, arg_8_2)
	return self.activities[arg_8_1]:activity_get_bakery_device_levelinfo(arg_8_2)
end
