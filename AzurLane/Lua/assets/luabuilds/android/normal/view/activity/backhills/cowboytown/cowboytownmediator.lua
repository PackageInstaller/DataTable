class = var_0_10000

local var_0_0 = "CowboyTownMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillMediatorTemplate"))

var_0_1.MINI_GAME = "MINI_GAME"
var_0_1.TASK = "TASK"
var_0_1.EXPANSION = "EXPANSION"
var_0_1.STORY = "STORY"
var_0_1.SKIN = "SKIN"
var_0_1.MINI_GAME_ID = 28

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.BindEvent(var_1_0)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_1_3 = var_1_2(var_1_1, var_1_10003.ACTIVITY_TYPE_TOWN)

	assert = var_1_1

	var_1_1(var_1_3, "Building Activity Not Found")

	arg_1_0.activity = var_1_3

	local var_1_4 = arg_1_0.viewComponent

	var_2.UpdateActivity(var_1_4, var_1_3)

	return
end

function var_0_1.BindEvent(arg_2_0)
	var_0_1.super.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.MINI_GAME, function()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10002

		var_3_1(var_3_0, var_2_10002.GO_MINI_GAME, var_0_1.MINI_GAME_ID)

		return
	end)
	arg_2_0:bind(var_0_1.STORY, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.addSubLayers

		Context = var_2_10002

		local var_4_2 = var_2_10002.New
		local var_4_3 = {}

		TownSkinMediator = var_2_10004
		var_4_3.mediator = var_2_10004
		TownSkinPage = var_2_10004
		var_4_3.viewComponent = var_2_10004

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_2_0:bind(var_0_1.SKIN, function()
		local var_5_0 = arg_2_0
		local var_5_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_5_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_5_1(var_5_0, var_5_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_2_0:bind(var_0_1.EXPANSION, function()
		local var_6_0 = arg_2_0
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_6_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_6_1(var_6_0, var_6_2, var_2_10003.TOWN)

		return
	end)
	arg_2_0:bind(var_0_1.TASK, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		SixYearUsTaskMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		SixYearUsTaskScene = var_2_10006
		var_7_3.viewComponent = var_2_10006

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	ActivityProxy = var_1_10002
	var_8_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_8_0[2] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	ActivityProxy = var_9_1

	local var_9_4

	if var_9_0 == var_9_1.ACTIVITY_UPDATED then
		local var_9_3 = var_9_2

		var_9_4 = var_9_2.getConfig(var_9_3, "type")
		ActivityConst = var_9_3

		if var_9_4 == var_9_3.ACTIVITY_TYPE_TownSkinStory then
			local var_9_5 = arg_9_0.viewComponent

			var_9_4.UpdateStoryView(var_9_5)
		end
	else
		GAME = var_9_4

		if var_9_0 == var_9_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_9_6 = arg_9_0.viewComponent

			var_4.UpdateTaskTips(var_9_6)
		end
	end

	return
end

return var_0_1
