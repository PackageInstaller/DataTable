local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local discount_manager = require("controller.discount_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_bachelor_envelope_data = require("data.activity_envelope.activity_bachelor_envelope_data")
local var_0_6 = 2
local var_0_8 = 1
local var_0_9 = 2

function ACTIVITY_OBJ_NEW:initModuleCoupons(arg_1_1)
	activity_manager:registerEventListener("activity_rob_coupons" .. self._id, activity_manager.activityEventId.JOIN_IN_MAIN_LAYER, function(arg_2_0)
		self:get_rob_stage()
		activity_manager:releaseEventListenerByName("activity_rob_coupons" .. self._id)
	end)
end

function ACTIVITY_OBJ_NEW:get_rob_stage()
	network:rpc("get_rob_stage", {
		id = self._id
	}, function(arg_4_0)
		hx_print("get_rob_stage")
		print_lua_table(arg_4_0)
		print(self._id)

		if arg_4_0.result ~= 1 then
			global_ShowBlockWords(L_GET_ACTIVITY_ERROR)
		elseif arg_4_0.time ~= nil then
			self:updateRobBtn(arg_4_0.stat, arg_4_0.time)

			self.robScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(arg_4_0.time, function(arg_5_0)
				if arg_5_0 <= 0 and self.robScheduler then
					self:get_rob_stage(arg_4_0.stat)
					time_check_manager:removeUpdatePool(self.robScheduler)

					self.robScheduler = nil
				end
			end)))
		end
	end)
end

function ACTIVITY_OBJ_NEW:rob_coupons()
	network:rpc("rob_coupons", {
		id = self._id
	}, function(arg_7_0)
		print(dump(arg_7_0))

		if arg_7_0.result ~= 1 or arg_7_0.stat ~= 1 then
			global_ShowBlockWords(L_ROB_BOUPONS_RESULT[arg_7_0.stat])
		else
			global_gain(arg_7_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:clearRobScheduler()
	if self.robScheduler then
		time_check_manager:removeUpdatePool(self.robScheduler)

		self.robScheduler = nil
	end
end

function ACTIVITY_OBJ_NEW:updateRobBtn(arg_9_1, arg_9_2)
	local var_9_0 = cc.Director:getInstance()
	local var_9_1 = var_9_0:getRunningScene()

	if var_9_0 then
		var_9_1:getChildByName("rob_panel"):runAction(cc.RemoveSelf:create())
	end

	if arg_9_1 == var_0_6 then
		local var_9_2 = self:createRobPanel(arg_9_2)

		var_9_2:setPosition(cc.p(645, 640))
		var_9_1:addChild(var_9_2, 10000)
	end
end

function ACTIVITY_OBJ_NEW:createRobPanel(arg_10_1)
	local var_10_0 = ccui.ImageView:create("mainScenebg/other/rob_bg.png")

	var_10_0:setAnchorPoint(cc.p(1, 0.5))
	var_10_0:setName("rob_panel")

	local var_10_1 = ccui.Button:create("mainScenebg/other/rob_btn_" .. self._id .. ".png", nil, "mainScenebg/other/rob_btn_" .. self._id .. ".png")

	var_10_1:setPosition(cc.p(70, 55))
	var_10_0:addChild(var_10_1)
	var_10_1:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.Repeat:create(cc.Sequence:create(cc.RotateTo:create(0.1, -8), cc.RotateTo:create(0.1, 8)), 5), cc.RotateTo:create(0.1, 0), cc.DelayTime:create(0.3))))
	var_10_1:addTouchEventListener(function(arg_11_0, arg_11_1)
		if arg_11_1 ~= ccui.TouchEventType.ended then
			return
		end

		self:rob_coupons()
		var_10_1:stopAllActions()
		var_10_0:runAction(cc.RemoveSelf:create())
	end)

	local var_10_2 = ccui.Button:create("mainScenebg/other/rob_visible_btn.png", nil, "mainScenebg/other/rob_visible_btn.png")

	var_10_2:setPosition(cc.p(16, 55))
	var_10_0:addChild(var_10_2)

	var_10_2.stat = var_0_9

	var_10_2:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		if not arg_12_0:isBright() then
			return
		end

		arg_12_0:setBright(false)

		if arg_12_0.stat == var_0_8 then
			var_10_0:runAction(cc.Sequence:create(cc.MoveBy:create(0.22, cc.p(-120, 0)), cc.MoveBy:create(0.08, cc.p(20, 0)), cc.CallFunc:create(function()
				arg_12_0:setScaleX(1)

				arg_12_0.stat = var_0_9

				arg_12_0:setBright(true)
			end)))
		elseif arg_12_0.stat == var_0_9 then
			var_10_0:runAction(cc.Sequence:create(cc.MoveBy:create(0.22, cc.p(100, 0)), cc.CallFunc:create(function()
				arg_12_0:setScaleX(-1)

				arg_12_0.stat = var_0_8

				arg_12_0:setBright(true)
			end)))
		end
	end)

	local var_10_3 = cc.Label:createWithTTF("", FONT_NAME, 18)

	var_10_3:setPosition(cc.p(44, 60))
	var_10_3:setColor(cc.c3b(255, 254, 200))
	var_10_1:addChild(var_10_3)

	if not arg_10_1 then
		return var_10_0
	end

	var_10_0.robTimeScheduler = time_check_manager:addUpdatePool((time_check_manager:createTimeCountDownHandler(arg_10_1, function(arg_15_0)
		var_10_3:setString(arg_15_0 .. "s")

		if arg_15_0 <= 0 and var_10_0.robTimeScheduler then
			var_10_3:setString("")
			time_check_manager:removeUpdatePool(var_10_0.robTimeScheduler)

			var_10_0.robTimeScheduler = nil
		end
	end)))

	var_10_0:registerScriptHandler(function(arg_16_0)
		if arg_16_0 == "exit" then
			var_10_0:setVisible(false)

			if var_10_0.robTimeScheduler then
				time_check_manager:removeUpdatePool(var_10_0.robTimeScheduler)

				var_10_0.robTimeScheduler = nil
			end
		end
	end)

	return var_10_0
end
