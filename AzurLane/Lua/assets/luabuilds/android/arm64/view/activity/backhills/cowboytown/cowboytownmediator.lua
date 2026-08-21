local var_0_0 = class("CowboyTownMediator", import("..TemplateMV.BackHillMediatorTemplate"))

var_0_0.MINI_GAME = "MINI_GAME"
var_0_0.TASK = "TASK"
var_0_0.EXPANSION = "EXPANSION"
var_0_0.STORY = "STORY"
var_0_0.SKIN = "SKIN"
var_0_0.MINI_GAME_ID = 28

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN)

	assert(var_1_0, "Building Activity Not Found")

	arg_1_0.activity = var_1_0

	arg_1_0.viewComponent:UpdateActivity(var_1_0)

	return
end

function var_0_0.BindEvent(arg_2_0)
	var_0_0.super.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.MINI_GAME, function()
		arg_2_0:sendNotification(GAME.GO_MINI_GAME, var_0_0.MINI_GAME_ID)

		return
	end)
	arg_2_0:bind(var_0_0.STORY, function()
		arg_2_0:addSubLayers(Context.New({
			mediator = TownSkinMediator,
			viewComponent = TownSkinPage
		}))

		return
	end)
	arg_2_0:bind(var_0_0.SKIN, function()
		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_2_0:bind(var_0_0.EXPANSION, function()
		arg_2_0:sendNotification(GAME.GO_SCENE, SCENE.TOWN)

		return
	end)
	arg_2_0:bind(var_0_0.TASK, function(arg_7_0, arg_7_1)
		arg_2_0:addSubLayers(Context.New({
			mediator = SixYearUsTaskMediator,
			viewComponent = SixYearUsTaskScene
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if arg_9_1:getBody():getConfig("type") == ActivityConst.ACTIVITY_TYPE_TownSkinStory then
			arg_9_0.viewComponent:UpdateStoryView()
		end
	elseif var_9_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_9_0.viewComponent:UpdateTaskTips()
	end

	return
end

return var_0_0
