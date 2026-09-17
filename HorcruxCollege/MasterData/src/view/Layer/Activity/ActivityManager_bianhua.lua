ActivityManager_bianhua = {}

local activity_conf_data = require("data.activity_conf_data")
local activity_manager = require("controller.activity_manager")
local network = require("network.network")

function ActivityManager_bianhua.registerEventListener(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	activity_manager:registerEventListener(arg_1_1, arg_1_2, arg_1_3)
end

function ActivityManager_bianhua.releaseEventListener(arg_2_0, arg_2_1, arg_2_2)
	activity_manager:releaseEventListener(arg_2_1, arg_2_2)
end

function ActivityManager_bianhua.releaseAllEventListener(arg_3_0, arg_3_1, arg_3_2)
	activity_manager:releaseAllEventListener(arg_3_1)
end

function ActivityManager_bianhua.fireEvent(arg_4_0, arg_4_1, arg_4_2)
	activity_manager:fireEvent(arg_4_1, arg_4_2)
end
