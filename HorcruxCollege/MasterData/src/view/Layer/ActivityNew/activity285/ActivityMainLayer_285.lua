require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_285 = class("ActivityMainLayer_285", function(...)
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

function ActivityMainLayer_285:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_285.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_285:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_285:initOther(arg_4_1)
	return
end

function ActivityMainLayer_285:playInEffect()
	for iter_5_0, iter_5_1 in pairs({
		{
			self.btnRole,
			"role"
		},
		{
			self.btnRecharge,
			"gift",
			-9,
			-9
		},
		{
			self.btnShop,
			"shop",
			-6
		},
		{
			self.btnTwist,
			"danchi",
			-4
		},
		{
			self.btnSign,
			"sign"
		},
		{
			self.btnRandfight,
			"boss",
			-3,
			1
		},
		{
			self.btnBp,
			"support",
			-4,
			-22
		},
		{
			self.btnDetail,
			"title",
			-7,
			22
		},
		{
			self.btnReturn,
			"back",
			-7,
			4
		}
	}) do
		local var_5_0 = iter_5_1[1]:getParent()
		local var_5_1 = iter_5_1[3] or 0
		local var_5_2 = iter_5_1[4] or 0
		local var_5_3 = L2Skeleton:create(string.format("spine/ui/liaoliciyuan/%s.json", iter_5_1[2]), string.format("spine/ui/liaoliciyuan/%s.atlas", iter_5_1[2]))

		var_5_3:refreshSkeleton()
		var_5_3:setPosition(cc.p(iter_5_1[1]:getPositionX() + var_5_1, iter_5_1[1]:getPositionY() + var_5_2))
		var_5_3:setName(iter_5_1[2])
		var_5_0:addChild(var_5_3, iter_5_0 == 1 and 1 or 9)
		var_5_3:play("animation", false)
		iter_5_1[1]:setVisible(false)
		iter_5_1[1]:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			iter_5_1[1]:setVisible(true)
			var_5_3:setVisible(iter_5_0 == 1 and true or false)
		end)))
	end

	local var_5_4 = L2Skeleton:create("spine/ui/liaoliciyuan/wave.json", "spine/ui/liaoliciyuan/wave.atlas")

	var_5_4:refreshSkeleton()
	var_5_4:setTimeScale(0.7)
	var_5_4:setPosition(cc.p(0, GameDisplay.height - GameDisplay.fix_y + 5))
	self.rootLayer:addChild(var_5_4, 10)
	var_5_4:play("animation", true)

	local var_5_5 = L2Skeleton:create("spine/ui/liaoliciyuan/wave.json", "spine/ui/liaoliciyuan/wave.atlas")

	var_5_5:refreshSkeleton()
	var_5_5:setTimeScale(0.7)
	var_5_5:setPosition(cc.p(0, 0 - GameDisplay.fix_y))
	self.rootLayer:addChild(var_5_5, 10)
	var_5_5:play("animation", true)
end

return ActivityMainLayer_285
