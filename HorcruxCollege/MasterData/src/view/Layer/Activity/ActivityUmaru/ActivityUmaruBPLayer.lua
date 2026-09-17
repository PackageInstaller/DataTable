ActivityUmaruBPLayer = class("ActivityUmaruBPLayer", function()
	return ActivityBattlePassBaseLayer:create()
end)

function ActivityUmaruBPLayer.create(arg_2_0)
	local var_2_0 = ActivityUmaruBPLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityUmaruBPLayer.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivitySummerBPLayer"
	arg_3_0.activityId = 137
	arg_3_0.bottomconf = {
		img = "ActivitySummerBPLayer/return_btn.png"
	}
end

function ActivityUmaruBPLayer:setUIPosition()
	local var_4_0 = self.rootLayer:getChildByName("panel_up")
	local var_4_1 = var_4_0:getChildByName("title_detial")

	var_4_1:setAnchorPoint(cc.p(0, 1))
	var_4_1:setPosition(0, var_4_0:getContentSize().height)
	var_4_0:getChildByName("btn_detail"):setPosition(360, 220)

	local var_4_2 = var_4_0:getChildByName("lbl_time")

	var_4_2:setPosition(142, 176)
	var_4_2:setColor(cc.c3b(63, 48, 103))

	local var_4_3 = var_4_0:getChildByName("upup")

	var_4_3:setScale(0.9)
	var_4_3:setPosition(60, 123)

	self.progress_banner_pos = cc.p(212, 125)

	local var_4_4 = var_4_0:getChildByName("level_bg")

	var_4_4:setPosition(350, 135)

	local var_4_5 = var_4_4:getChildByName("cur_level")

	var_4_5:setPosition(var_4_4:getContentSize().width / 2, var_4_4:getContentSize().height / 2 + 8)
	var_4_5:setColor(cc.c3b(97, 65, 124))

	local var_4_6 = ccui.Helper:seekWidgetByName(var_4_0, "cur_exp")

	var_4_6:setFontSize(20)
	var_4_6:setColor(cc.c3b(97, 65, 124))
	var_4_6:setPosition(156, 140)

	self.BtnBuyPt_pos = cc.p(269, 145)

	var_4_0:getChildByName("button_jump_to"):setPosition(210, 60)

	self.curLevelLbl_color = cc.c3b(84, 58, 71)
	self.curLevelLbl_offset_Y = 5
	self.ptNum_color = cc.c3b(97, 63, 50)
	self.itemsp_wordbg = "ActivitySummerBPLayer/item_num_bg.png"
end
