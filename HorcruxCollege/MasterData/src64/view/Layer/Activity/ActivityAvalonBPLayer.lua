ActivityAvalonBPLayer = class("ActivityAvalonBPLayer", function()
	return ActivityBattlePassBaseLayer:create()
end)

function ActivityAvalonBPLayer.create(arg_2_0)
	local var_2_0 = ActivityAvalonBPLayer.new()

	var_2_0:init()

	return var_2_0
end

function ActivityAvalonBPLayer.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityAvalonBP"
	arg_3_0.activityId = 115
end

function ActivityAvalonBPLayer:setUIPosition()
	local var_4_0 = self.rootLayer:getChildByName("panel_up")
	local var_4_1 = var_4_0:getChildByName("title_detial")

	var_4_1:setAnchorPoint(cc.p(0, 1))
	var_4_1:setPosition(300, 300)

	local var_4_2 = var_4_0:getChildByName("btn_detail")

	var_4_2:setPosition(360, 220)
	var_4_2:setVisible(false)

	local var_4_3 = var_4_0:getChildByName("lbl_time")

	var_4_3:setPosition(142, 176)
	var_4_3:setColor(cc.c3b(63, 48, 103))
	var_4_3:setVisible(false)

	local var_4_4 = var_4_0:getChildByName("upup")

	var_4_4:setScale(0.9)
	var_4_4:setPosition(293, 149)

	self.progress_banner_pos = cc.p(430, 145)

	local var_4_5 = var_4_0:getChildByName("level_bg")

	var_4_5:setPosition(540, 145)
	var_4_5:setScale(0.8)

	local var_4_6 = var_4_5:getChildByName("cur_level")

	var_4_6:setPosition(var_4_5:getContentSize().width / 2, var_4_5:getContentSize().height / 2 + 8)
	var_4_6:setColor(cc.c3b(255, 255, 255))

	local var_4_7 = ccui.Helper:seekWidgetByName(var_4_0, "cur_exp")

	var_4_7:setFontSize(20)
	var_4_7:setColor(cc.c3b(255, 255, 255))
	var_4_7:setPosition(430, 160)

	self.BtnBuyPt_pos = cc.p(460, 165)

	var_4_0:getChildByName("button_jump_to"):setPosition(430, 60)

	self.curLevelLbl_color = cc.c3b(255, 255, 255)
	self.ptNum_color = cc.c3b(255, 255, 255)
	self.itemsp_wordbg = "ActivityXinxiYaBPLayer/item_num_bg.png"
end
