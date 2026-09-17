local ActivityBakeryHelpLayer = class("ActivityBakeryHelpLayer", (require("view.Layer.BaseUILayer")))
local texture_manager = require("controller.texture_manager")
local TempWidget = require("view.Sprite.TempWidget")
local var_0_3 = config._DEBUG and 0 or 1
local component_manager = require("controller.component_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local model_data = require("data.model_data")
local item_data = require("data.item_data")
local activity_manager = require("controller.activity_manager")
local activity_bakery_level_conf = require("data.activity_bakery_level_conf")
local activity_bakery_device_data = require("data.activity_bakery_device_data")

require("view.Sprite.ItemSprite")

function ActivityBakeryHelpLayer:ctor()
	ActivityBakeryHelpLayer.super.ctor(self)
	self:setAutoAdapt(true)
end

function ActivityBakeryHelpLayer:create(arg_2_1)
	self.activityId = arg_2_1.activityId
	self.resPath = "ActivityBakeryHelpLayer/"

	local var_2_0 = ActivityBakeryHelpLayer.new()

	if var_2_0 and var_2_0:init(arg_2_1) then
		return var_2_0
	end

	return nil
end

function ActivityBakeryHelpLayer:onEnter()
	ActivityBakeryHelpLayer.super.onEnter(self)
end

function ActivityBakeryHelpLayer:onExit()
	ActivityBakeryHelpLayer.super.onExit(self)
end

function ActivityBakeryHelpLayer:init(arg_5_1)
	self.helpinfo = {
		time_speedup = false,
		auto_commit = false,
		double_gold = false,
		no_burning = false
	}

	self:initLayer(arg_5_1)
	self:initListener(arg_5_1)

	self.cancelCallBack = arg_5_1.cancelCallBack

	return true
end

function ActivityBakeryHelpLayer:initLayer(arg_6_1)
	local var_6_0 = TempWidget:CreateTempLayout(self)

	var_6_0:_setBack()
	var_6_0:setBackGroundColor(cc.c3b(0, 0, 0))
	var_6_0:setBackGroundColorOpacity(100)
	var_6_0:setContentSize(GameDisplay.getUiScreenSize())

	self._root = var_6_0

	var_6_0:_addEvent(function()
		return
	end)

	local var_6_1 = ccui.ImageView:create(self.resPath .. "bg.png", var_0_3)

	var_6_0:addChild(var_6_1)
	var_6_1:setPosition(320, 640)

	local var_6_2 = {
		"auto_commit.png",
		"time_speedup.png",
		"no_burning.png",
		"double_gold.png"
	}
	local var_6_3 = {
		"auto_commit",
		"time_speedup",
		"no_burning",
		"double_gold"
	}
	local var_6_4 = {
		"自动送货",
		"时间减半",
		"防止烤糊",
		"收益翻倍"
	}

	for iter_6_0, iter_6_1 in ipairs({
		cc.p(90, 380),
		cc.p(195, 380),
		cc.p(300, 380),
		cc.p(405, 380)
	}) do
		local var_6_5 = ccui.ImageView:create(self.resPath .. "item_bg.png", var_0_3)

		var_6_1:addChild(var_6_5)
		var_6_5:setPosition(iter_6_1)

		local var_6_6 = ccui.ImageView:create(self.resPath .. "label_bg.png", var_0_3)

		var_6_5:addChild(var_6_6)
		var_6_6:setAnchorPoint(0, 0)

		local var_6_7 = cc.Label:createWithTTF("x" .. item_manager:getItemNumber(activity_manager:activity_get_bakery_conf(self.activityId)[var_6_3[iter_6_0] .. "_item"]), FONT_DES, 16)

		var_6_6:addChild(var_6_7)
		var_6_7:setPosition(var_6_6:getContentSize().width / 2, 8)

		local var_6_8 = ccui.ImageView:create(self.resPath .. var_6_2[iter_6_0], var_0_3)

		var_6_5:addChild(var_6_8)
		var_6_8:setPosition(var_6_5:getContentSize().width / 2, var_6_5:getContentSize().height / 2)

		local var_6_9 = cc.Label:createWithTTF(var_6_4[iter_6_0], FONT_NEW, 20)

		var_6_1:addChild(var_6_9)
		var_6_9:setPosition(var_6_5:getPositionX(), var_6_5:getPositionY() - 60)
		var_6_9:setColor(cc.c3b(173, 64, 50))

		local var_6_10 = ccui.ImageView:create(self.resPath .. "choose_icon.png", var_0_3)

		var_6_5:addChild(var_6_10)
		var_6_10:setAnchorPoint(0, 0)
		var_6_10:setPosition(-5, -5)
		var_6_10:setVisible(false)
		var_6_5:setTouchEnabled(true)
		var_6_5:addTouchEventListener(function(arg_8_0, arg_8_1)
			if arg_8_1 ~= ccui.TouchEventType.ended then
				return
			end

			if item_manager:getItemNumber(activity_manager:activity_get_bakery_conf(self.activityId)[var_6_3[iter_6_0] .. "_item"]) <= 0 then
				global_ShowBlockWords("道具不足")
				var_6_10:setVisible(false)

				return
			end

			self.helpinfo[var_6_3[iter_6_0]] = not self.helpinfo[var_6_3[iter_6_0]]

			var_6_10:setVisible(self.helpinfo[var_6_3[iter_6_0]])
		end)
	end

	local var_6_11 = ccui.Button:create(self.resPath .. "btn_start.png", nil, self.resPath .. "btn_start.png", var_0_3)

	var_6_11:setPosition(245, 240)
	var_6_1:addChild(var_6_11)

	self.btn_start = var_6_11

	local var_6_12 = ccui.Button:create(self.resPath .. "btn_close.png", nil, self.resPath .. "btn_close.png", var_0_3)

	var_6_12:setPosition(450, 630)
	var_6_1:addChild(var_6_12)

	self.btn_close = var_6_12
end

function ActivityBakeryHelpLayer:initListener(arg_9_1)
	if self.btn_start then
		self.btn_start:addTouchEventListener(function(arg_10_0, arg_10_1)
			if arg_10_1 ~= ccui.TouchEventType.ended then
				return
			end

			local var_10_0 = self.helpinfo

			activity_manager:activity_bakery_game_start(self.activityId, self.helpinfo, function(arg_11_0)
				local var_11_0 = arg_9_1.activityId * 100 + math.min(arg_11_0.level, activity_manager:activity_get_bakery_conf(arg_9_1.activityId).max_level)
				local var_11_1 = {
					target_gold = arg_11_0.target_gold
				}

				var_11_1.max_ongoing_order_num = activity_bakery_level_conf[var_11_0].max_ongoing_order_num or 3
				var_11_1.refresh_order_time = activity_bakery_level_conf[var_11_0].refresh_order_time
				var_11_1.level_time = activity_bakery_level_conf[var_11_0].level_time
				var_11_1.max_wait_time = activity_bakery_level_conf[var_11_0].max_wait_time
				var_11_1.first_order_time = activity_bakery_level_conf[var_11_0].first_order_time or activity_bakery_level_conf[var_11_0].refresh_order_time
				var_11_1.no_order_refresh_time = activity_bakery_level_conf[var_11_0].no_order_refresh_time or activity_bakery_level_conf[var_11_0].refresh_order_time
				var_11_1.order_create = {
					cake_need_max = activity_bakery_level_conf[var_11_0].cake_need_max,
					cake_need_min = activity_bakery_level_conf[var_11_0].cake_need_min,
					milktea_need_max = activity_bakery_level_conf[var_11_0].milktea_need_max,
					milktea_need_min = activity_bakery_level_conf[var_11_0].milktea_need_min,
					taroballs_need_max = activity_bakery_level_conf[var_11_0].taroballs_need_max,
					taroballs_need_min = activity_bakery_level_conf[var_11_0].taroballs_need_min
				}
				var_11_1.oven_num = activity_bakery_device_data.oven_num["levelValue" .. (arg_11_0.equipment_level.oven_num or 1)]
				var_11_1.tray_num = activity_bakery_device_data.tray_num["levelValue" .. (arg_11_0.equipment_level.tray_num or 1)]
				var_11_1.chopping_num = activity_bakery_device_data.chopping_num["levelValue" .. (arg_11_0.equipment_level.chopping_num or 1)]
				var_11_1.milktea_num = activity_bakery_device_data.milktea_num["levelValue" .. (arg_11_0.equipment_level.milktea_num or 1)]
				var_11_1.taroballs_num = activity_bakery_device_data.taroballs_num["levelValue" .. (arg_11_0.equipment_level.taroballs_num or 1)]
				var_11_1.oventime = activity_bakery_device_data.oventime["levelValue" .. (arg_11_0.equipment_level.oventime or 1)]
				var_11_1.burningtime = activity_bakery_device_data.burningtime["levelValue" .. (arg_11_0.equipment_level.burningtime or 1)]
				var_11_1.choptime = activity_bakery_device_data.choptime["levelValue" .. (arg_11_0.equipment_level.choptime or 1)]
				var_11_1.milkteatime = activity_bakery_device_data.milkteatime["levelValue" .. (arg_11_0.equipment_level.milkteatime or 1)]
				var_11_1.taroballstime = activity_bakery_device_data.taroballstime["levelValue" .. (arg_11_0.equipment_level.taroballstime or 1)]
				var_11_1.fruitPoolNum = activity_bakery_device_data.fruitPoolNum["levelValue" .. (arg_11_0.equipment_level.fruitPoolNum or 1)]

				local var_11_2 = {}

				var_11_2.cake_prize = activity_bakery_device_data.cake_prize["levelValue" .. (arg_11_0.equipment_level.cake_prize or 1)]
				var_11_2.cream_prize = activity_bakery_device_data.cream_prize["levelValue" .. (arg_11_0.equipment_level.cream_prize or 1)]
				var_11_2.fruit_prize_1 = activity_bakery_device_data.fruit_prize_1["levelValue" .. (arg_11_0.equipment_level.fruit_prize_1 or 1)]
				var_11_2.fruit_prize_2 = activity_bakery_device_data.fruit_prize_2["levelValue" .. (arg_11_0.equipment_level.fruit_prize_2 or 1)]
				var_11_2.fruit_prize_3 = activity_bakery_device_data.fruit_prize_3["levelValue" .. (arg_11_0.equipment_level.fruit_prize_3 or 1)]
				var_11_2.pearl_prize = activity_bakery_device_data.pearl_prize["levelValue" .. (arg_11_0.equipment_level.pearl_prize or 1)]
				var_11_2.milktea_prize = activity_bakery_device_data.milktea_prize["levelValue" .. (arg_11_0.equipment_level.milktea_prize or 1)]
				var_11_2.taroballs_prize = activity_bakery_device_data.taroballs_prize["levelValue" .. (arg_11_0.equipment_level.taroballs_prize or 1)]
				var_11_2.excipients_prize_1 = activity_bakery_device_data.excipients_prize_1["levelValue" .. (arg_11_0.equipment_level.excipients_prize_1 or 1)]
				var_11_2.excipients_prize_2 = activity_bakery_device_data.excipients_prize_2["levelValue" .. (arg_11_0.equipment_level.excipients_prize_2 or 1)]
				var_11_1.prize = var_11_2
				var_11_1.usingHelpItem = var_10_0

				if arg_9_1.callback then
					arg_9_1.callback(var_11_1)
				end
			end, self.cancelCallBack)
			KeyCodeManager:onKeyReleasedCallFunc()
		end)
	end

	if self.btn_close then
		self.btn_close:addTouchEventListener(function(arg_12_0, arg_12_1)
			if arg_12_1 ~= ccui.TouchEventType.ended then
				return
			end

			KeyCodeManager:onKeyReleasedCallFunc()

			if self.cancelCallBack then
				self.cancelCallBack()
			end
		end)
	end
end

function ActivityBakeryHelpLayer:updateLayer()
	return
end

function ActivityBakeryHelpLayer:updateRed()
	return
end

return ActivityBakeryHelpLayer
