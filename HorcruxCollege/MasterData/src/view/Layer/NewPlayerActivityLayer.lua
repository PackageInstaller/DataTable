NewPlayerActivityLayer = class("NewPlayerActivityLayer", function()
	return cc.Layer:create()
end)

local item_data = require("data.item_data")
local novice_pass_level_data = require("data.novice_pass_level_data")
local texture_manager = require("controller.texture_manager")
local time_check_manager = require("controller.time_check_manager")
local activity_manager = require("controller.activity_manager")
local activity_return_manager = require("controller.activity_return_manager")
local level_manager = require("controller.level_manager")
local playermodel = require("model.playermodel")
local alert_manager = require("controller.alert_manager")
local network = require("network.network")
local var_0_10 = config._DEBUG and 0 or 1
local var_0_11 = "NewPlayerActivityLayer/"

function NewPlayerActivityLayer.create(arg_2_0)
	local var_2_0 = NewPlayerActivityLayer.new()

	var_2_0:init()

	return var_2_0
end

function NewPlayerActivityLayer:init()
	self:initUI()
	self:addTouchEvent()
	self:updateRedAlert()
	self:updateActivityStat()
end

local var_0_12 = 3
local var_0_13 = 2

function NewPlayerActivityLayer:initUI()
	self.rootLayer = ccui.ImageView:create(var_0_11 .. "bg.png", var_0_10)

	self:addChild(self.rootLayer)
	self.rootLayer:setAnchorPoint(0, 1)
	self.rootLayer:setPosition(0, 0)
	self.rootLayer:setPositionY(GameDisplay.height - GameDisplay.fix_y)

	local var_4_0 = ccui.Button:create(var_0_11 .. "title.png", nil, var_0_11 .. "title.png", var_0_10)

	self.rootLayer:addChild(var_4_0)
	var_4_0:setAnchorPoint(0.5, 1)
	var_4_0:setPosition(320, self.rootLayer:getContentSize().height)
	var_4_0:addTouchEventListener(function(arg_5_0, arg_5_1)
		if arg_5_1 ~= ccui.TouchEventType.ended then
			return
		end
	end)

	self.remainTime = cc.Label:createWithTTF("", FONT_DES, 30)

	self.remainTime:setPosition(262, 0)
	var_4_0:addChild(self.remainTime)

	self.return_btn = ccui.Button:create(var_0_11 .. "return_btn.png", nil, var_0_11 .. "return_btn.png", var_0_10)

	self.rootLayer:addChild(self.return_btn)
	self.return_btn:setAnchorPoint(0, 0)
	self.return_btn:setPosition(0, 280 - 2 * GameDisplay.fix_y)

	self.sign_base_btn = ccui.Button:create(var_0_11 .. "sign_base_btn.png", nil, var_0_11 .. "sign_base_btn.png", var_0_10)

	self.rootLayer:addChild(self.sign_base_btn)
	self.sign_base_btn:setAnchorPoint(0, 0)
	self.sign_base_btn:setPosition(0, self.return_btn:getPositionY() + 150)

	self.bp_btn = ccui.Button:create(var_0_11 .. "bp_btn.png", nil, var_0_11 .. "bp_btn.png", var_0_10)

	self.rootLayer:addChild(self.bp_btn)
	self.bp_btn:setAnchorPoint(0, 0)
	self.bp_btn:setPosition(0, self.sign_base_btn:getPositionY() + 120)

	self.sign_btn = ccui.Button:create(var_0_11 .. "sign_btn.png", nil, var_0_11 .. "sign_btn.png", var_0_10)

	self.rootLayer:addChild(self.sign_btn)
	self.sign_btn:setAnchorPoint(0, 0)
	self.sign_btn:setPosition(20, self.bp_btn:getPositionY() + 340)

	self.guide_btn = ccui.Button:create(var_0_11 .. "guide_btn.png", nil, var_0_11 .. "guide_btn.png", var_0_10)

	self.rootLayer:addChild(self.guide_btn)
	self.guide_btn:setAnchorPoint(1, 0)
	self.guide_btn:setPosition(640, self.return_btn:getPositionY() + 210)

	self.gift_buy_btn = ccui.Button:create(var_0_11 .. "gift_buy_btn.png", nil, var_0_11 .. "gift_buy_btn.png", var_0_10)

	self.rootLayer:addChild(self.gift_buy_btn)
	self.gift_buy_btn:setAnchorPoint(1, 0)
	self.gift_buy_btn:setPosition(640, self.guide_btn:getPositionY() + 120)

	self.twist_btn = ccui.Button:create(var_0_11 .. "twist_btn.png", nil, var_0_11 .. "twist_btn.png", var_0_10)

	self.rootLayer:addChild(self.twist_btn)
	self.twist_btn:setAnchorPoint(1, 0)
	self.twist_btn:setPosition(640, self.gift_buy_btn:getPositionY() + 120)
end

function NewPlayerActivityLayer:addTouchEvent()
	self.return_btn:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		KeyCodeManager:onKeyReleasedCallFunc()
	end)
	self.sign_btn:addTouchEventListener(function(arg_8_0, arg_8_1)
		if arg_8_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_8_0.isfinished then
			global_ShowBlockWords("活动已完成！")

			return
		end

		require("controller.goto_system_manager")
		goto_complete_system({
			jump_to_system = 2500480
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_new_sign30",
			activityid = 480
		})
	end)
	self.bp_btn:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		if arg_9_0.isfinished then
			global_ShowBlockWords("活动已完成！")

			return
		end

		LayerManager:switchShowLayer("NoviceSummaryLayer", {
			isHideOther = true,
			layerName = "ActivityXinxiYaBPLayer"
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_new_bp",
			activityid = 255
		})
	end)
	self.sign_base_btn:addTouchEventListener(function(arg_10_0, arg_10_1)
		if arg_10_1 ~= ccui.TouchEventType.ended then
			return
		end

		local var_10_0

		if arg_10_0.isfinished then
			global_ShowBlockWords("活动已完成！")

			do return end

			var_10_0 = {
				activityid = 2,
				activityUIObjName = "ActivitySignFmlLayer"
			}
		end

		function var_10_0.exit_set_bright_callback()
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("AUTO_POP_SIGN"))
		end

		LayerManager:pushInLayer("ActivitySignBaseLayer", var_10_0)
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_new_sign7",
			activityid = 2
		})
	end)
	self.guide_btn:addTouchEventListener(function(arg_12_0, arg_12_1)
		if arg_12_1 ~= ccui.TouchEventType.ended then
			return
		end

		LayerManager:switchShowLayer("GuidePhoneLayer")
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_new_guide"
		})
	end)
	self.gift_buy_btn:addTouchEventListener(function(arg_13_0, arg_13_1)
		if arg_13_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = 3800005
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_new_giftbuy"
		})
	end)
	self.twist_btn:addTouchEventListener(function(arg_14_0, arg_14_1)
		if arg_14_1 ~= ccui.TouchEventType.ended then
			return
		end

		goto_complete_system({
			jump_to_system = 1800591
		})
		AnalyticManager.ActivityMainLayer({
			event = "on_touch_new_twist"
		})
	end)
end

function NewPlayerActivityLayer:updateRedAlert()
	(function(arg_16_0)
		if activity_manager:getAlertStatus(2, "sign") then
			alert_manager:add_alert_by_config(arg_16_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				{
					x = arg_16_0:getContentSize().width - 20,
					y = arg_16_0:getContentSize().height - 15
				}
			})
		else
			alert_manager:add_alert_by_config(arg_16_0, false, {
				ALERT_SHOW_REDDOT
			})
		end
	end)(self.sign_base_btn)
	;(function(arg_18_0)
		if not activity_manager:getAlertAllStatus(136) then
			if activity_manager:getAlertStatus(255, "bpg") then
				local var_18_1 = {
					ALERT_SHOW_REDDOT,
					""
				}

				var_18_1[3] = {
					x = arg_18_0:getContentSize().width - 15,
					y = arg_18_0:getContentSize().height / 2 + 30
				} or {
					x = arg_18_0:getContentSize().width - 15,
					y = arg_18_0:getContentSize().height - 10
				}

				alert_manager:add_alert_by_config(arg_18_0, true, var_18_1)

				goto label_18_0
			end
		end

		alert_manager:add_alert_by_config(arg_18_0, false, {
			ALERT_SHOW_REDDOT
		})

		::label_18_0::
	end)(self.bp_btn)
	;(function(arg_17_0)
		local var_17_0 = activity_manager:getActivityObj(480)

		if not var_17_0 then
			return
		end

		local var_17_1 = var_17_0:getMainLayerAlertPos()

		if activity_manager:getAlertAllStatus(480) then
			alert_manager:add_alert_by_config(arg_17_0, true, {
				ALERT_SHOW_REDDOT,
				"",
				{
					x = arg_17_0:getContentSize().width - 15,
					y = arg_17_0:getContentSize().height / 2 + 30
				} or {
					x = arg_17_0:getContentSize().width - 15,
					y = arg_17_0:getContentSize().height - 10
				}
			})
		else
			alert_manager:add_alert_by_config(arg_17_0, false, {
				ALERT_SHOW_REDDOT
			})
		end
	end)(self.sign_btn)
	;(function(arg_19_0)
		network:rpc("get_supermarket_list", {}, function(arg_20_0)
			if not arg_19_0 or tolua.isnull(arg_19_0) then
				return
			end

			if not arg_20_0.list or not arg_20_0.list[2] then
				return
			end

			for iter_20_0, iter_20_1 in ipairs(arg_20_0.list[2].tablist) do
				if iter_20_1.id == 5 and (iter_20_1.reddot == var_0_12 or iter_20_1.reddot == var_0_13) then
					alert_manager:add_alert_by_config(arg_19_0, true, {
						ALERT_SHOW_REDDOT,
						"",
						{
							x = arg_19_0:getContentSize().width - 15,
							y = arg_19_0:getContentSize().height - 10
						}
					})

					return
				end
			end

			alert_manager:add_alert_by_config(arg_19_0, false, {
				ALERT_SHOW_REDDOT
			})
		end)
	end)(self.gift_buy_btn)
end

function NewPlayerActivityLayer:registerEventListener(...)
	self:getEventDispatcher():addEventListenerWithSceneGraphPriority(cc.EventListenerCustom:create("UPDATE_AC_MODULE_STAT", function(arg_22_0)
		self:updateRedAlert()
		self:updateActivityStat()
	end), self)
end

function NewPlayerActivityLayer:updateActivityStat()
	if not activity_manager:is_module_stat_finished(2, "sign") then
		self.sign_base_btn:loadTextures(var_0_11 .. "sign_base_btn.png", nil, var_0_11 .. "sign_base_btn.png", var_0_10)

		self.sign_base_btn.isfinished = false
	else
		self.sign_base_btn:loadTextures(var_0_11 .. "sign_base_btn_off.png", nil, var_0_11 .. "sign_base_btn_off.png", var_0_10)

		self.sign_base_btn.isfinished = true
	end

	if not activity_manager:is_module_stat_finished(480, "sign") then
		self.sign_btn:loadTextures(var_0_11 .. "sign_btn.png", nil, var_0_11 .. "sign_btn.png", var_0_10)

		self.sign_btn.isfinished = false
	else
		self.sign_btn:loadTextures(var_0_11 .. "sign_btn_off.png", nil, var_0_11 .. "sign_btn_off.png", var_0_10)

		self.sign_btn.isfinished = true
	end

	if activity_manager:getActivityObj(136) ~= nil or activity_manager:getActivityObj(255) ~= nil then
		self.bp_btn:loadTextures(var_0_11 .. "bp_btn.png", nil, var_0_11 .. "bp_btn.png", var_0_10)

		self.bp_btn.isfinished = false
	else
		self.bp_btn:loadTextures(var_0_11 .. "bp_btn_off.png", nil, var_0_11 .. "bp_btn_off.png", var_0_10)

		self.bp_btn.isfinished = true
	end
end
