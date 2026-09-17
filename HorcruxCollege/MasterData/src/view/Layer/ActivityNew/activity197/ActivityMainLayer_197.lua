local ActivityMainLayer_197 = class("ActivityMainLayer_197", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_manager = require("controller.activity_manager")
local explore_manager = require("controller.explore_manager")
local time_check_manager = require("controller.time_check_manager")

function ActivityMainLayer_197:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_197.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther()

	return var_2_0
end

function ActivityMainLayer_197:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_197:initOther()
	return
end

return ActivityMainLayer_197
