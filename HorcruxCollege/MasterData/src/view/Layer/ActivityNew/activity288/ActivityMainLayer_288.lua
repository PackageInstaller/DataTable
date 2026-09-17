require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_288 = class("ActivityMainLayer_288", function(...)
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
local var_0_13 = "activitiesRes/activity288/effect/main_000%02d.png"
local var_0_14

function ActivityMainLayer_288:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_288.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_288:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_288:initOther(arg_4_1)
	return
end

function ActivityMainLayer_288:playStar(arg_5_1)
	local var_5_0 = 0

	self:scheduleUpdateWithPriorityLua(function(arg_6_0)
		if var_5_0 <= 40 then
			self.imgArm:loadTexture(string.format(var_0_13, var_5_0))

			var_5_0 = var_5_0 + 1
		else
			self:unscheduleUpdate()

			if arg_5_1 then
				arg_5_1()
			end
		end
	end, 0)
end

function ActivityMainLayer_288:playInEffect()
	local var_7_0 = {
		{
			self.btnRecharge,
			"gift",
			-21,
			-10
		},
		{
			self.btnTwist,
			"kuozhao",
			30,
			-40
		},
		{
			self.btnSign,
			"sign",
			-4
		},
		{
			self.btnRandfight,
			"boss",
			10,
			3
		},
		{
			self.btnBp,
			"support",
			-27,
			-3
		},
		{
			self.imgTime,
			"time",
			-24,
			0
		},
		{
			self.btnExplore,
			"tanxian",
			-7,
			1
		},
		{
			self.btnMultipt,
			"exchange",
			-19,
			-8
		},
		{
			self.btnTotalTask,
			"leichou",
			5
		},
		{
			self.btnReturn,
			"back",
			-18,
			-10
		},
		{
			self.btnShop,
			"pifu",
			-55,
			-6
		},
		{
			self.btnDailyLevel,
			"tiaozhan"
		}
	}

	self.imgArm = ccui.ImageView:create(string.format(var_0_13, 1))

	self.imgArm:setPosition(cc.p(GameDisplay.width / 2, GameDisplay.height / 2 - GameDisplay.fix_y))
	self:addChild(self.imgArm)

	local function var_7_1()
		for iter_8_0, iter_8_1 in pairs(var_7_0) do
			local var_8_0 = iter_8_1[1]:getParent()
			local var_8_1 = iter_8_1[3] or 0
			local var_8_2 = iter_8_1[4] or 0
			local var_8_3 = L2Skeleton:create(string.format("spine/ui/tianqi/%s.json", iter_8_1[2]), string.format("spine/ui/tianqi/%s.atlas", iter_8_1[2]))

			var_8_3:refreshSkeleton()
			var_8_3:setPosition(cc.p(iter_8_1[1]:getPositionX() + var_8_1, iter_8_1[1]:getPositionY() + var_8_2))
			var_8_3:setName(iter_8_1[2])
			var_8_0:addChild(var_8_3, iter_8_0 == 1 and 1 or 9)
			var_8_3:play("animation", false)
			iter_8_1[1]:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
				iter_8_1[1]:setVisible(true)
				var_8_3:setVisible(tag)
			end)))
		end
	end

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		iter_7_1[1]:setVisible(false)
	end

	if DeviceManager:getChannelID() == "palmpi" then
		if var_0_14 then
			self.imgArm:setVisible(false)
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
			self.imgArm:setVisible(false)
			var_7_1()
		end
	end

	local var_7_5 = L2Skeleton:create("spine/ui/tianqi/black.json", "spine/ui/tianqi/black.atlas")

	var_7_5:refreshSkeleton()
	var_7_5:setTimeScale(0.7)
	var_7_5:setPosition(cc.p(70, -50 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_7_5, 1)
	var_7_5:play("animation", true)
end

return ActivityMainLayer_288
