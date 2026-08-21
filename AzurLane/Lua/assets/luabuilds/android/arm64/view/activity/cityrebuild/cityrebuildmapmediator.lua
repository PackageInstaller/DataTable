local var_0_0 = class("CityRebuildMapMediator", import("view.base.ContextMediator"))

var_0_0.GET_DATA = "CityRebuildMapMediator.GET_DATA"
var_0_0.OPEN_BOOK = "CityRebuildMapMediator.OPEN_BOOK"
var_0_0.OPEN_BATTLE = "CityRebuildMapMediator.OPEN_BATTLE"
var_0_0.OPEN_STORY = "CityRebuildMapMediator.OPEN_STORY"
var_0_0.OPEN_TASKS = "CityRebuildMapMediator.OPEN_TASKS"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GET_DATA, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.GET_DATA,
			activityId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_BOOK, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = CityRebuildBookMediator,
			viewComponent = CityRebuildBookLayer,
			data = {
				page = arg_3_1,
				showId = arg_3_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_TASKS, function(arg_4_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = CityRebuildTasksMediator,
			viewComponent = CityRebuildTasksLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_BATTLE, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = CityRebuildGameMediator,
			viewComponent = CityRebuildGameLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_STORY, function(arg_6_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = CityRebuildStoryMediator,
			viewComponent = CityRebuildStoryLayer
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.CITY_REBUILD_DONE,
		GAME.STORY_UPDATE_DONE,
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == GAME.CITY_REBUILD_DONE then
		if var_8_1.operation == CityRebuildProxy.GET_DATA or var_8_1.operation == CityRebuildProxy.REBUILD_OR_START_RECRUIT or var_8_1.operation == CityRebuildProxy.END_RECRUIT or var_8_1.operation == CityRebuildProxy.CHOOSE_LEVEL or var_8_1.operation == CityRebuildProxy.INIT_TIME then
			arg_8_0.viewComponent:Refresh()
		end
	elseif var_8_0 == GAME.STORY_UPDATE_DONE or var_8_0 == GAME.SUBMIT_TASK_AWARD_DOWN then
		arg_8_0.viewComponent:Refresh()
	end

	return
end

return var_0_0
