local ActivityMainLayer_182 = class("ActivityMainLayer_182", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_conf_data = require("data.activity_conf_data")

function ActivityMainLayer_182:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_182.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_182:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_182:initOther()
	self.textFinishtime:setString((function(arg_5_0)
		if not activity_conf_data[arg_5_0].finishtime then
			return ""
		end

		local var_5_0 = global_get_time_by_date(activity_conf_data[arg_5_0].finishtime) - time_check_manager:getCurTime()

		if var_5_0 < 0 then
			return ""
		end

		local var_5_6 = math.floor(var_5_0 / 24 / 3600)
		local var_5_7 = math.floor((var_5_0 - var_5_6 * 24 * 3600) / 3600)
		local var_5_8 = math.floor((var_5_0 - var_5_6 * 24 * 3600 - var_5_7 * 3600) / 60)

		return 0 ~= 0 and string.format(L_TIME_TEXT[1], var_5_6, var_5_7) or var_5_7 ~= 0 and string.format(L_TIME_TEXT[2], var_5_7, var_5_8) or string.format(L_TIME_TEXT[3], var_5_8)
	end)(self.id))
end

return ActivityMainLayer_182
