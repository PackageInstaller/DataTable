require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_707 = class("ActivityMainLayer_707", function(...)
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

function ActivityMainLayer_707:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_707.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_707:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_707:init(arg_4_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_707:playInEffect()
	return
end

function ActivityMainLayer_707:initOther(arg_6_1)
	self:initTwistChosee()
	self.btnTwist:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.selectType = var_0_14

		self:updateTwistChosee(var_0_14)
	end)
end

function ActivityMainLayer_707:initTwistChosee()
	self.twistChoseeLayer = ccui.Layout:create()

	self.twistChoseeLayer:setTouchEnabled(true)
	self.twistChoseeLayer:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	self.twistChoseeLayer:setAnchorPoint(cc.p(0, 0))
	self.twistChoseeLayer:setPosition(cc.p(0, -GameDisplay.fix_y))
	self.twistChoseeLayer:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
	self.twistChoseeLayer:setBackGroundColor(cc.c3b(0, 0, 0))
	self.twistChoseeLayer:setBackGroundColorOpacity(180)
	self:addChild(self.twistChoseeLayer)
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

	self.bg = ccui.ImageView:create("activitiesRes/activity707/main/twistChoseeBg_1.png")

	self.bg:setTouchEnabled(true)
	self.bg:setPosition(cc.p(320, 520 + GameDisplay.fix_y))
	self.twistChoseeLayer:addChild(self.bg)

	self.btn1 = ccui.Button:create("activitiesRes/activity707/main/twistChoseebtn1_1.png", nil, "activitiesRes/activity707/main/twistChoseebtn1_1.png")

	self.btn1:setPosition(cc.p(320, 490))
	self.bg:addChild(self.btn1)
	self.btn1:addTouchEventListener(function(arg_11_0, arg_11_1)
		goto_complete_system({
			jump_to_system = self.selectType == var_0_14 and 1800745 or 1800745
		})
	end)

	self.btn2 = ccui.Button:create("activitiesRes/activity707/main/twistChoseebtn1_2.png", nil, "activitiesRes/activity707/main/twistChoseebtn1_2.png")

	self.btn2:setPosition(cc.p(320, 300))
	self.bg:addChild(self.btn2)
	self.btn2:addTouchEventListener(function(arg_12_0, arg_12_1)
		goto_complete_system({
			jump_to_system = self.selectType == var_0_14 and 1800747 or 1800747
		})
	end)

	self.btn3 = ccui.Button:create("activitiesRes/activity707/main/twistChoseebtn1_3.png", nil, "activitiesRes/activity707/main/twistChoseebtn1_3.png")

	self.btn3:setPosition(cc.p(320, 110))
	self.bg:addChild(self.btn3)
	self.btn3:addTouchEventListener(function(arg_13_0, arg_13_1)
		local var_13_1
		local var_13_0

		if arg_13_1 ~= ccui.TouchEventType.ended then
			do return end

			var_13_0 = goto_complete_system
			var_13_1 = {}
		end

		var_13_1.jump_to_system = self.selectType == var_0_14 and 1800748 or 1800748

		var_13_0(var_13_1)
	end)
end

function ActivityMainLayer_707:updateTwistChosee()
	self.bg:loadTexture("activitiesRes/activity707/main/twistChoseeBg_" .. self.selectType .. ".png")
	self.btn1:loadTextures("activitiesRes/activity707/main/twistChoseebtn" .. self.selectType .. "_1.png", nil, "activitiesRes/activity707/main/twistChoseebtn" .. self.selectType .. "_1.png")
	self.btn2:loadTextures("activitiesRes/activity707/main/twistChoseebtn" .. self.selectType .. "_2.png", nil, "activitiesRes/activity707/main/twistChoseebtn" .. self.selectType .. "_2.png")
	self.twistChoseeLayer:setOpacity(0)
	self.twistChoseeLayer:setVisible(true)
	self.twistChoseeLayer:runAction(cc.Sequence:create(cc.FadeIn:create(0.5)))
end

return ActivityMainLayer_707
