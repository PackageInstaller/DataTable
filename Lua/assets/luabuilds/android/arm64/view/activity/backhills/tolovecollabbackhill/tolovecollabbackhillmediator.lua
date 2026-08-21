local var_0_0 = class("ToLoveCollabBackHillMediator", import("..TemplateMV.BackHillMediatorTemplate"))

var_0_0.MINI_GAME = "MINI_GAME"
var_0_0.TASK = "TASK"
var_0_0.PUZZLE = "PUZZLE"
var_0_0.TROPHY = "TROPHY"
var_0_0.MINI_GAME_ID = 69

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	return
end

function var_0_0.BindEvent(arg_2_0)
	var_0_0.super.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.MINI_GAME, function()
		arg_2_0:sendNotification(GAME.GO_MINI_GAME, var_0_0.MINI_GAME_ID)

		return
	end)
	arg_2_0:bind(var_0_0.PUZZLE, function()
		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.PUZZLE_CONNECT, {})

		return
	end)
	arg_2_0:bind(var_0_0.TASK, function(arg_5_0, arg_5_1)
		arg_2_0:addSubLayers(Context.New({
			mediator = ToLoveCollabTaskMediator,
			viewComponent = ToLoveCollabTaskScene
		}))

		return
	end)
	arg_2_0:bind(var_0_0.TROPHY, function(arg_6_0, arg_6_1)
		arg_2_0:addSubLayers(Context.New({
			mediator = MedalCollectionTemplateMediator,
			viewComponent = ToLoveCollabMedalView
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		-- block empty
	elseif var_8_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_8_0.viewComponent:UpdateView()
	end

	return
end

return var_0_0
