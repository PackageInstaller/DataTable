require("view.Layer.Activity.ActivityPTBaseLayer")

ActivityPreSummerPTLayer = class("ActivityPTBaseLayer", function()
	return ActivityPTBaseLayer:create()
end)

local activity_conf_data = require("data.activity_conf_data")

function ActivityPreSummerPTLayer.create(arg_2_0)
	local var_2_0 = ActivityPreSummerPTLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityPreSummerPTLayer:initDynamicConfig()
	self.layerName = "ActivityPreSummerPTLayer"
	self.activityId = 12301
	self.addPosY = 30
	self.pointitemid = activity_conf_data[self.activityId].item1 or 123010001
	self.pointmaxnum = activity_conf_data[self.activityId].item_limit1 or 1000000
end

function ActivityPreSummerPTLayer.resetValues(arg_4_0)
	arg_4_0.LEVEL_CELL_HEIGHT = 148
	arg_4_0.TASK_CELL_HEIGHT = 130
end

function ActivityPreSummerPTLayer.setUIPosition(arg_5_0)
	return
end
