class = var_0_10000

local var_0_0 = "ToLoveCollabBackHillMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillMediatorTemplate"))

var_0_1.MINI_GAME = "MINI_GAME"
var_0_1.TASK = "TASK"
var_0_1.PUZZLE = "PUZZLE"
var_0_1.TROPHY = "TROPHY"
var_0_1.MINI_GAME_ID = 69

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

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
	arg_2_0:bind(var_0_1.PUZZLE, function()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_4_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.PUZZLE_CONNECT, {})

		return
	end)
	arg_2_0:bind(var_0_1.TASK, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_2_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		ToLoveCollabTaskMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		ToLoveCollabTaskScene = var_2_10006
		var_5_3.viewComponent = var_2_10006

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_2_0:bind(var_0_1.TROPHY, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		MedalCollectionTemplateMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		ToLoveCollabMedalView = var_2_10006
		var_6_3.viewComponent = var_2_10006

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	ActivityProxy = var_1_10002
	var_7_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_7_0[2] = var_2.SUBMIT_ACTIVITY_TASK_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	ActivityProxy = var_8_1

	if var_8_0 == var_8_1.ACTIVITY_UPDATED then
		-- block empty
	else
		GAME = var_4

		if var_8_0 == var_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_8_3 = arg_8_0.viewComponent

			var_4.UpdateView(var_8_3)
		end
	end

	return
end

return var_0_1
