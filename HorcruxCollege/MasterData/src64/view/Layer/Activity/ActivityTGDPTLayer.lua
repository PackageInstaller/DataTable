require("view.Layer.Activity.ActivityPTBaseLayer")

ActivityTGDPTLayer = class("ActivityPTBaseLayer", function()
	return ActivityPTBaseLayer:create()
end)

local activity_conf_data = require("data.activity_conf_data")

function ActivityTGDPTLayer.create(arg_2_0)
	local var_2_0 = ActivityTGDPTLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityTGDPTLayer:initDynamicConfig()
	self.layerName = "ActivityTGDPTLayer"
	self.activityId = 146
	self.addPosY = 30
	self.pointitemid = activity_conf_data[self.activityId].item1 or 123010001
	self.pointmaxnum = activity_conf_data[self.activityId].item_limit1 or 1000000
end

function ActivityTGDPTLayer.resetValues(arg_4_0)
	arg_4_0.LEVEL_CELL_HEIGHT = 148
	arg_4_0.TASK_CELL_HEIGHT = 130
end

function ActivityTGDPTLayer:setUIPosition()
	local var_5_0 = self.rootLayer:getChildByName("panel_up")
	local var_5_1 = var_5_0:getChildByName("title_detial")

	var_5_1:setAnchorPoint(cc.p(0, 1))
	var_5_1:setPosition(10, var_5_0:getContentSize().height)
	var_5_0:getChildByName("btn_detail"):setPosition(var_5_1:getContentSize().width - 50, 280)
	var_5_0:getChildByName("upup"):setPosition(60, 98)
	var_5_0:getChildByName("button_jump_to"):setPosition(204, 38)

	local var_5_2 = var_5_0:getChildByName("level_bg")

	var_5_2:setAnchorPoint(cc.p(1, 0.5))
	var_5_2:setPosition(318, 92)
	var_5_2:setScale9Enabled(true)
	var_5_2:setCapInsets(cc.rect(14, 0, 134, 24))

	self.progressBar_pos = cc.p(190, 74)

	local var_5_3 = var_5_0:getChildByName("lbl_time")

	var_5_3:setPosition(190, 150)
	var_5_3:setColor(cc.c3b(0, 0, 0))
end
