require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_538 = class("ActivityMainLayer_538", function(...)
	return ActivityMainLayerBaseLayer:create(...)
end)
local activity_conf_data = require("data.activity_conf_data")
local activity_task_conf = require("data.activity_modules.activity_task_conf")
local activity_main_conf = require("data.activity_modules.activity_main_conf")
local model_data = require("data.model_data")
local servant_data = require("data.servant_data")
local audio_manager = require("controller.audio_manager")
local explore_manager = require("controller.explore_manager")
local activity_manager = require("controller.activity_manager")
local share_manager = require("controller.share_manager")
local time_check_manager = require("controller.time_check_manager")
local ShowGirlLayer = require("view.Layer.ShowGirlLayer")
local var_0_14 = 1
local var_0_15

function ActivityMainLayer_538:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_538.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_538:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_538:playInEffect()
	return
end

function ActivityMainLayer_538:initOther(arg_5_1)
	self:initTwistChosee()
	self.btnTwist:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectType = var_0_14

		self:updateTwistChosee()
	end)

	self.btnSwitchBG = ccui.Button:create("activitiesRes/activity538/main/btn_switchbg.png", nil, "activitiesRes/activity538/main/btn_switchbg.png")

	self.btnSwitchBG:setAnchorPoint(cc.p(0, 0.5))
	self.btnSwitchBG:setPosition(cc.p(0, 550 + GameDisplay.fix_y))
	self:addChild(self.btnSwitchBG)
	self.btnSwitchBG:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_15 = var_0_15 + 1

		if var_0_15 <= 2 then
			var_0_15 = var_0_15 or var_0_15 - 2
		end

		self.imgBg:loadTexture("activitiesRes/activity538/main/img_bg_" .. var_0_15 .. ".png")
	end)

	if not var_0_15 then
		var_0_15 = math.random(1, 2)
	else
		var_0_15 = var_0_15 + 1

		if var_0_15 <= 2 then
			var_0_15 = var_0_15 or var_0_15 - 2
		end
	end

	self.imgBg:loadTexture("activitiesRes/activity538/main/img_bg_" .. var_0_15 .. ".png")
end

function ActivityMainLayer_538:initTwistChosee()
	self.twistChoseeLayer = ccui.Layout:create()

	self.twistChoseeLayer:setTouchEnabled(true)
	self.twistChoseeLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.twistChoseeLayer:setAnchorPoint(cc.p(0, 0))
	self.twistChoseeLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.twistChoseeLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.twistChoseeLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.twistChoseeLayer:setBackGroundColorOpacity(180)
	self:addChild(self.twistChoseeLayer, 99)
	self.twistChoseeLayer:addTouchEventListener(function(arg_9_0, arg_9_1)
		if arg_9_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeOut:create(0.5), cc.CallFunc:create(function()
			self.twistChoseeLayer:setVisible(false)
			self.twistChoseeLayer:setOpacity(255)
		end)))
	end)
	self.twistChoseeLayer:setVisible(false)

	self.bg = ccui.ImageView:create("activitiesRes/activity538/main/twistChoseeBg_1.png")

	self.bg:setTouchEnabled(true)
	self.bg:setPosition(cc.p(320, 520 + GameDisplay.fix_y))
	self.twistChoseeLayer:addChild(self.bg)

	self.btn1 = ccui.Button:create("activitiesRes/activity538/main/twistChoseebtn1_1.png", nil, "activitiesRes/activity538/main/twistChoseebtn1_1.png")

	self.btn1:setPosition(cc.p(320, 420))
	self.bg:addChild(self.btn1)
	self.btn1:addTouchEventListener(function(arg_11_0, arg_11_1)
		local var_11_0
		local var_11_1

		if arg_11_1 ~= ccui.TouchEventType.ended then
			do return end

			var_11_0 = goto_complete_system
			var_11_1 = {}
		end

		var_11_1.jump_to_system = self.selectType == var_0_14 and 1800601 or 1800601

		var_11_0(var_11_1)
	end)

	self.btn2 = ccui.Button:create("activitiesRes/activity538/main/twistChoseebtn1_2.png", nil, "activitiesRes/activity538/main/twistChoseebtn1_2.png")

	self.btn2:setPosition(cc.p(320, 190))
	self.bg:addChild(self.btn2)
	self.btn2:addTouchEventListener(function(arg_12_0, arg_12_1)
		local var_12_1
		local var_12_0

		if arg_12_1 ~= ccui.TouchEventType.ended then
			do return end

			var_12_0 = goto_complete_system
			var_12_1 = {}
		end

		var_12_1.jump_to_system = self.selectType == var_0_14 and 1800602 or 1800602

		var_12_0(var_12_1)
	end)
end

function ActivityMainLayer_538:updateTwistChosee()
	self.bg:loadTexture("activitiesRes/activity538/main/twistChoseeBg_" .. self.selectType .. ".png")
	self.btn1:loadTextures("activitiesRes/activity538/main/twistChoseebtn" .. self.selectType .. "_1.png", nil, "activitiesRes/activity538/main/twistChoseebtn" .. self.selectType .. "_1.png")
	self.btn2:loadTextures("activitiesRes/activity538/main/twistChoseebtn" .. self.selectType .. "_2.png", nil, "activitiesRes/activity538/main/twistChoseebtn" .. self.selectType .. "_2.png")
	self.twistChoseeLayer:setOpacity(0)
	self.twistChoseeLayer:setVisible(true)
	self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.5)))
end

return ActivityMainLayer_538
