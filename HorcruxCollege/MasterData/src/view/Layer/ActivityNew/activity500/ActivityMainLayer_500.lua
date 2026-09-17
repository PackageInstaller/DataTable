require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_500 = class("ActivityMainLayer_500", function(...)
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

function ActivityMainLayer_500:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_500.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_500:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_500:playInEffect()
	return
end

function ActivityMainLayer_500:initOther(arg_5_1)
	self.showType = RoleDefault:getInstance():getIntegerForKey("activity_main_type", 2)

	local var_5_0 = ccui.Button:create(self._path .. "btn_switch_1.png", nil, self._path .. "btn_switch_1.png")

	var_5_0:setAnchorPoint(cc.p(1, 0.5))
	var_5_0:setPosition(cc.p(640, 800 + GameDisplay.fix_y))
	self.rootLayer:addChild(var_5_0, 100)

	self.btnSwitch = var_5_0

	var_5_0:addTouchEventListener(function(arg_6_0, arg_6_1)
		if arg_6_1 ~= ccui.TouchEventType.ended then
			return
		end

		self.showType = self.showType == 1 and 2 or 1

		RoleDefault:getInstance():setBoolForKey("activity_main_switch500", true)
		RoleDefault:getInstance():setIntegerForKey("activity_main_type", self.showType)
		self:switchShowType()
	end)
	self:switchShowType()
end

function ActivityMainLayer_500:switchShowType()
	for iter_7_0, iter_7_1 in ipairs({
		{
			self.btnCollect,
			self.btnFightCollection,
			self.btnTwist,
			self.btnMultipt,
			self.btnFlop
		},
		{
			self.btnSwim,
			self.btnRoulette,
			self.btnRandfight,
			self.btnArt,
			self.btnTwist2
		}
	}) do
		if iter_7_0 == self.showType then
			for iter_7_2, iter_7_3 in pairs(iter_7_1) do
				iter_7_3:setVisible(true)
			end
		else
			for iter_7_4, iter_7_5 in pairs(iter_7_1) do
				iter_7_5:setVisible(false)
			end
		end
	end

	self.imgBg:loadTexture(self._path .. "img_bg_" .. self.showType .. ".png")
	self.btnSwitch:loadTextures(self._path .. "btn_switch_" .. self.showType .. ".png", nil, self._path .. "btn_switch_" .. self.showType .. ".png")
	self:updateSwithBtnAlert()
end

function ActivityMainLayer_500:updateSwithBtnAlert()
	if not RoleDefault:getInstance():getBoolForKey("activity_main_switch500", false) then
		global_add_alert_tag(self.btnSwitch)
	else
		global_remove_alert_tag(self.btnSwitch)
	end
end

return ActivityMainLayer_500
