ActivityFlopDuanWuLayer = class("ActivityFlopDuanWuLayer", function()
	return ActivityFlopBaseLayer:create()
end)

function ActivityFlopDuanWuLayer.create(arg_2_0)
	local var_2_0 = ActivityFlopDuanWuLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityFlopDuanWuLayer.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityFlopDuanWuLayer"
	arg_3_0.activityId = 118
	arg_3_0.texturePath = "ActivityFlopDuanwu/"
end
