local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_subsystem_time(arg_1_1, arg_1_2)
	if not self.activities[arg_1_1] then
		return
	end

	return self.activities[arg_1_1]:get_subsystem_time(arg_1_2)
end

function activity_base_manager:getSystemTimeTbl(arg_2_1)
	if not self.activities[arg_2_1] then
		return
	end

	return self.activities[arg_2_1]:getSystemTimeTbl()
end

function activity_base_manager:getSystemTime(arg_3_1)
	if not self.activities[arg_3_1] then
		return
	end

	return self.activities[arg_3_1]:getSystemTime()
end
