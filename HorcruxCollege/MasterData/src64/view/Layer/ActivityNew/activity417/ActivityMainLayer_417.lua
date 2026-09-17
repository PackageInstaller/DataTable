require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_417 = class("ActivityMainLayer_417", function(...)
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
local var_0_14

function ActivityMainLayer_417:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_417.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_417:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_417:initOther(arg_4_1)
	return
end

function ActivityMainLayer_417:playStar(arg_5_1)
	self.jinruSpine:play("texiao", true)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(1.3), cc.CallFunc:create(function()
		self.jinruSpine:setVisible(false)
	end)))
end

function ActivityMainLayer_417:playInEffect()
	self.jinruSpine = L2Skeleton:create(UI_SPINE_PATH .. "baifenzhiyi/texiao.json", UI_SPINE_PATH .. "baifenzhiyi/texiao.atlas")

	self.jinruSpine:refreshSkeleton()
	self.jinruSpine.skeletonAnimation:setPositionX(self.imgBg:getContentSize().width / 2)
	self.jinruSpine.skeletonAnimation:setPositionY(self.imgBg:getContentSize().height / 2 - GameDisplay.fix_y)
	self.jinruSpine:setName("texiao")
	self:addChild(self.jinruSpine, 10000)

	local function var_7_1()
		return
	end

	if DeviceManager:getChannelID() == "palmpi" then
		if var_0_14 then
			self.jinruSpine:setVisible(false)
			var_7_1()
		else
			var_0_14 = true

			self:playStar(var_7_1)
		end
	else
		local var_7_2 = RoleDefault:getInstance():getIntegerForKey("act_288_effect", 0)
		local var_7_3 = time_check_manager:getCurTime()

		if var_7_2 < var_7_3 then
			self:playStar(var_7_1)

			local var_7_4 = os.date("*t", var_7_3)

			RoleDefault:getInstance():setIntegerForKey("act_288_effect", os.time({
				hour = 0,
				min = 0,
				sec = 0,
				year = var_7_4.year,
				month = var_7_4.month,
				day = var_7_4.day
			}) + 86400)
		else
			self.jinruSpine:setVisible(false)
			var_7_1()
		end
	end
end

return ActivityMainLayer_417
