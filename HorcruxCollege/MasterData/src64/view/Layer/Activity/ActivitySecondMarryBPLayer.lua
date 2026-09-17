ActivitySecondMarryBPLayer = class("ActivitySecondMarryBPLayer", function()
	return ActivityBattlePassBaseLayer:create()
end)

function ActivitySecondMarryBPLayer.create(arg_2_0)
	local var_2_0 = ActivitySecondMarryBPLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivitySecondMarryBPLayer.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityBianhuaBP"
	arg_3_0.activityId = 112
	arg_3_0.addPosY = 30
end

function ActivitySecondMarryBPLayer:setUIPosition()
	local var_4_0 = self.rootLayer:getChildByName("panel_up"):getChildByName("level_bg"):getChildByName("cur_level")

	var_4_0:setScale(1.5)
	var_4_0:setPositionY(var_4_0:getPositionY() + 17)
	var_4_0:setPositionX(var_4_0:getPositionX() + 3)
end
