local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_bestcombo_conf(arg_1_1, arg_1_2)
	return self.activities[arg_1_1]:get_bestcombo_conf(arg_1_2)
end

function activity_base_manager:set_bestcombo_combo(arg_2_1, arg_2_2, arg_2_3)
	return self.activities[arg_2_1]:set_bestcombo_combo(arg_2_2, arg_2_3)
end
