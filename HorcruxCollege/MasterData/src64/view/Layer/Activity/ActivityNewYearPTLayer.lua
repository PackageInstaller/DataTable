require("view.Layer.Activity.ActivityPTBaseLayer")

ActivityNewYearPTLayer = class("ActivityNewYearPTLayer", function()
	return ActivityPTBaseLayer:create()
end)

local activity_conf_data = require("data.activity_conf_data")

function ActivityNewYearPTLayer.create(arg_2_0)
	local var_2_0 = ActivityNewYearPTLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityNewYearPTLayer:initDynamicConfig()
	self.layerName = "ActivityNewYearPTLayer"
	self.activityId = 161
	self.addPosY = 30
	self.pointitemid = activity_conf_data[self.activityId].item1 or 123010001
	self.pointmaxnum = activity_conf_data[self.activityId].item_limit1 or 1000000
end

function ActivityNewYearPTLayer.resetValues(arg_4_0)
	arg_4_0.LEVEL_CELL_HEIGHT = 148
	arg_4_0.TASK_CELL_HEIGHT = 130
end

function ActivityNewYearPTLayer:setUIPosition()
	local var_5_0 = self.rootLayer:getChildByName("panel_up")
	local var_5_1 = var_5_0:getChildByName("title_detial")

	var_5_1:setAnchorPoint(cc.p(0, 1))
	var_5_1:setPosition(10, var_5_0:getContentSize().height)
	var_5_0:getChildByName("btn_detail"):setPosition(var_5_1:getContentSize().width, 230)
	var_5_0:getChildByName("upup"):setPosition(60, 128)
	var_5_0:getChildByName("button_jump_to"):setPosition(204, 58)

	local var_5_2 = var_5_0:getChildByName("level_bg")

	var_5_2:setAnchorPoint(cc.p(1, 0.5))
	var_5_2:setPosition(318, 122)
	var_5_2:setScale9Enabled(true)
	var_5_2:setCapInsets(cc.rect(14, 0, 134, 24))

	local var_5_3 = var_5_2:getChildByName("cur_level")

	var_5_3:setAnchorPoint(cc.p(0, 0.5))
	var_5_3:setPositionX(0)
	var_5_3:setColor(cc.c3b(52, 36, 175))

	self.progressBar_pos = cc.p(190, 104)

	local var_5_4 = var_5_0:getChildByName("lbl_time")

	var_5_4:setPosition(190, 170)
	var_5_4:setColor(cc.c3b(52, 36, 160))
end
