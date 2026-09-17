ActivityBattlePassLayer_137 = class("ActivityBattlePassLayer_137", function()
	return ActivityBattlePassBaseLayer:create()
end)

function ActivityBattlePassLayer_137.create(arg_2_0)
	local var_2_0 = ActivityBattlePassLayer_137.new()

	var_2_0:init()

	return var_2_0
end

function ActivityBattlePassLayer_137.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityBattlePassLayer_137"
	arg_3_0.activityId = 137
	arg_3_0.bottombgPath = "ActivityBattlePassLayer_137/bottom_bg.png"
	arg_3_0.bottomconf = {
		img = "ActivityBattlePassLayer_137/return_btn.png"
	}
end

function ActivityBattlePassLayer_137:setUIPosition()
	local var_4_0 = self.rootLayer:getChildByName("panel_up")
	local var_4_1 = var_4_0:getChildByName("title_detial")

	var_4_1:setAnchorPoint(cc.p(0, 1))
	var_4_1:setPosition(230, var_4_0:getContentSize().height)

	local var_4_2 = var_4_0:getChildByName("btn_detail")

	var_4_2:setPosition(360, 220)
	var_4_2:setVisible(false)

	local var_4_3 = var_4_0:getChildByName("lbl_time")

	var_4_3:setPosition(332 + 90, 190)
	var_4_3:setColor(cc.c3b(255, 255, 255))

	local var_4_4 = var_4_0:getChildByName("upup")

	var_4_4:setScale(0.65)
	var_4_4:setPosition(250 + 90, 123)

	self.progress_banner_pos = cc.p(370 + 90, 110)

	local var_4_5 = var_4_0:getChildByName("level_bg")

	var_4_5:setScale(0.8)
	var_4_5:setPosition(495 + 90, 125)

	local var_4_6 = var_4_5:getChildByName("cur_level")

	var_4_6:setFontSize(30)
	var_4_6:setPosition(var_4_5:getContentSize().width / 2, var_4_5:getContentSize().height / 2 - 10)
	var_4_6:setColor(cc.c3b(109, 31, 214))

	local var_4_7 = ccui.Helper:seekWidgetByName(var_4_0, "cur_exp")

	var_4_7:setFontSize(20)
	var_4_7:setColor(cc.c3b(255, 255, 255))
	var_4_7:setPosition(331 + 90, 123)

	self.BtnBuyPt_pos = cc.p(410 + 90, 130)

	var_4_0:getChildByName("button_jump_to"):setPosition(375 + 90, 60)

	self.curLevelLbl_fontsize = 36
	self.curLevelLbl_color = cc.c3b(109, 31, 214)
	self.curLevelLbl_offset_Y = -10
	self.ptNum_color = cc.c3b(242, 105, 152)
	self.itemsp_wordbg = "ActivityBattlePassLayer_137/item_num_bg.png"

	self.rootLayer:getChildByName("big_gift_bg"):setPositionX(320)

	local var_4_8 = self.rootLayer:getChildByName("panel_up")

	var_4_8:getChildByName("btn_detail"):setVisible(false)
	var_4_8:getChildByName("title_detial"):setTouchEnabled(false)
end

function ActivityBattlePassLayer_137:initBtnFurnitureBox()
	local var_5_0 = self.rootLayer:getChildByName("panel_up"):getChildByName("fornitureBoxPanel")

	var_5_0:setVisible(true)

	local var_5_1, var_5_2 = var_5_0:getPosition()

	var_5_0:setPosition(cc.p(var_5_1, var_5_2 - 10))

	local var_5_3, var_5_4 = var_5_0:getPosition()
	local var_5_5 = var_5_0:getChildByName("btn_furniture")
	local var_5_6 = var_5_0:getChildByName("btn_furnitureBox")

	var_5_6.status = 1

	var_5_6:setScaleX(1)
	var_5_5:setVisible(true)
	var_5_5:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = 1713741
		})
	end)

	local function var_5_7(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_2 == true and arg_7_0.status == 1 then
			var_5_0:stopAllActions()
			var_5_0:runAction((cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_5_3 - 245, var_5_4)), cc.CallFunc:create(function()
				var_5_6:setScaleX(-1)

				arg_7_0.status = 0
			end))))
		elseif arg_7_2 == true and arg_7_0.status ~= 1 then
			-- block empty
		elseif arg_7_2 ~= true and arg_7_0.status == 1 then
			var_5_0:stopAllActions()
			var_5_0:runAction((cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(var_5_3 - 245, var_5_4)), cc.CallFunc:create(function()
				var_5_6:setScaleX(-1)

				arg_7_0.status = 0
			end))))
		elseif arg_7_2 ~= true and arg_7_0.status ~= 1 then
			var_5_0:stopAllActions()
			var_5_0:runAction((cc.Sequence:create(cc.CallFunc:create(function()
				var_5_6:setScaleX(1)

				arg_7_0.status = 1
			end), cc.MoveTo:create(0.5, cc.p(var_5_3, var_5_4)))))
		end
	end

	var_5_6:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_5_7(arg_11_0, arg_11_1)
	end)
	var_5_0:getChildByName("Panel_22"):addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_5_7(arg_12_0, arg_12_1)
	end)
	self:useSchedule(3, function()
		var_5_7(var_5_6, ccui.TouchEventType.ended, true)
		self:removeSchedule()
	end, false)
end
