require("view.Layer.ActivityNew.BaseLayer.ActivityMainLayerBaseLayer")

local ActivityMainLayer_737 = class("ActivityMainLayer_737", function(...)
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

function ActivityMainLayer_737:create(arg_2_1)
	local var_2_0 = ActivityMainLayer_737.new(arg_2_1)

	var_2_0:init(arg_2_1)
	var_2_0:buildUiFromConf()
	var_2_0:call_base_func()
	var_2_0:playInEffect()
	var_2_0:initOther(arg_2_1)

	return var_2_0
end

function ActivityMainLayer_737:init(arg_3_1)
	self.rootLayer = ccui.Layout:create()

	self:addChild(self.rootLayer)
end

function ActivityMainLayer_737:initOther(arg_4_1)
	self:initGroupFightBtn()
end

function ActivityMainLayer_737:playInEffect()
	return
end

function ActivityMainLayer_737:initGroupFightBtn()
	self.bp = self.rootLayer:getChildByName("btnBp")

	self.bp:setPositionY(self.bp:getPositionY() - 33)
	self.rootLayer:getChildByName("btnGroupFight"):setPositionY(self.rootLayer:getChildByName("btnGroupFight"):getPositionY() - 20)
end

return ActivityMainLayer_737
