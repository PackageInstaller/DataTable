require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_329 = class("ActivityMainLayer_329", function(...)
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
local var_0_14 = true

function ActivityMainLayer_329:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_329.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_329:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_329:initOther(arg_4_1)
	return
end

function ActivityMainLayer_329:playInEffect()
	local var_5_0 = {}
	local var_5_1 = {
		self.btnRecharge,
		"skeleton"
	}

	var_5_1[3] = -0
	var_5_1[4] = -0
	var_5_0[1] = var_5_1

	;(function()
		for iter_6_0, iter_6_1 in pairs(var_5_0) do
			local var_6_0 = iter_6_1[1]:getParent()
			local var_6_1 = iter_6_1[3] or 0
			local var_6_2 = iter_6_1[4] or 0
			local var_6_3 = L2Skeleton:create(string.format("spine/ui/niaoren/%s.json", iter_6_1[2]), string.format("spine/ui/niaoren/%s.atlas", iter_6_1[2]))

			var_6_3:refreshSkeleton()
			var_6_3:setPosition(cc.p(iter_6_1[1]:getPositionX() + var_6_1, iter_6_1[1]:getPositionY() + var_6_2))
			var_6_3:setName(iter_6_1[2])
			var_6_0:addChild(var_6_3, iter_6_0 == 1 and 100 or 9)
			var_6_3:play("animation", true)
		end
	end)()

	if var_0_14 then
		global_add_alert_tag(self.btnRecharge, cc.p(20, 110), 200)
	else
		global_remove_alert_tag(self.btnRecharge)
	end

	self.btnRecharge:addTouchEventListener(function(arg_7_0, arg_7_1)
		if arg_7_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_0_14 = false

		global_remove_alert_tag(self.btnRecharge)

		local var_7_0 = {}

		var_7_0.jump_to_system = activity_main_conf[329].into_recharge or activity_main_conf[329].into_recharge_1

		goto_complete_system(var_7_0)
	end)
end

function ActivityMainLayer_329:playOutEffect(arg_8_1)
	if arg_8_1 then
		arg_8_1()
	end
end

return ActivityMainLayer_329
