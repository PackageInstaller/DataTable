local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:activity_smallgame_startgame(arg_1_1, arg_1_2, arg_1_3)
	return self.activities[arg_1_1]:activity_smallgame_startgame(arg_1_2, arg_1_3)
end

function activity_base_manager:activity_smallgame_data_report(arg_2_1, arg_2_2, arg_2_3)
	return self.activities[arg_2_1]:activity_smallgame_data_report(arg_2_2, arg_2_3)
end

function activity_base_manager:activity_smallgame_use_speacial_item(arg_3_1, arg_3_2, arg_3_3)
	return self.activities[arg_3_1]:activity_smallgame_use_speacial_item(arg_3_2, arg_3_3)
end

function activity_base_manager:activity_musicalnote_refresh(arg_4_1, arg_4_2)
	return self.activities[arg_4_1]:activity_musicalnote_refresh(arg_4_2)
end
