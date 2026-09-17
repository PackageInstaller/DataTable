require("view.Layer.Activity.ActivityPTBaseLayer")

ActivityPTLayer_193 = class("ActivityPTLayer_193", function()
	return ActivityPTBaseLayer:create()
end)

local activity_conf_data = require("data.activity_conf_data")

require("view.Sprite.ItemSprite")

local playermodel = require("model.playermodel")
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local item_manager = require("controller.item_manager")
local drop_manager = require("controller.drop_manager")
local var_0_6 = require("controller.time_check_manager")
local activity_proceed_data = require("data.activity_proceed_data")
local var_0_8 = require("data.activity_conf_data")
local task_data = require("data.task_data")

function ActivityPTLayer_193.create(arg_2_0)
	local var_2_0 = ActivityPTLayer_193.new()

	var_2_0:init()

	return var_2_0
end

function ActivityPTLayer_193.initDynamicConfig(arg_3_0)
	arg_3_0.layerName = "ActivityPTLayer_193"
	arg_3_0.activityId = 193
	arg_3_0.addPosY = 30
	arg_3_0.pointitemid = activity_proceed_data["193pt-1"].item1
	arg_3_0.pointmaxnum = 3000
end

function ActivityPTLayer_193.resetValues(arg_4_0)
	arg_4_0.LEVEL_CELL_HEIGHT = 128
	arg_4_0.TASK_CELL_HEIGHT = 130
end
