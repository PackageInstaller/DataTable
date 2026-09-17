ActivityRoutineBPLayer = class("ActivityRoutineBPLayer", function()
	return ActivityBattlePassBaseLayer:create()
end)

function ActivityRoutineBPLayer.create(arg_2_0)
	local var_2_0 = ActivityRoutineBPLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityRoutineBPLayer.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityRoutineBP"
	arg_3_0.activityId = 117
	arg_3_0.addPosY = 30
end
