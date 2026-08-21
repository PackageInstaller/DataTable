local var_0_0 = class("CityRebuildGameMediator", import("view.base.ContextMediator"))

var_0_0.INIT_TIME = "CityRebuildGameMediator.INIT_TIME"
var_0_0.RESULT = "CityRebuildGameMediator.RESULT"
var_0_0.CHOOSE_LEVEL = "CityRebuildGameMediator.CHOOSE_LEVEL"
var_0_0.OPEN_BOOK = "CityRebuildGameMediator.OPEN_BOOK"
var_0_0.OPEN_TASKS = "CityRebuildGameMediator.OPEN_TASKS"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.INIT_TIME, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.INIT_TIME,
			activityId = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.RESULT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.RESULT,
			activityId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.CHOOSE_LEVEL, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.CHOOSE_LEVEL,
			activityId = arg_4_1,
			level = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_BOOK, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = CityRebuildBookMediator,
			viewComponent = CityRebuildBookLayer,
			data = {
				page = "buff"
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_TASKS, function(arg_6_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = CityRebuildTasksMediator,
			viewComponent = CityRebuildTasksLayer
		}))

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_7_0)
	return {
		GAME.CITY_REBUILD_DONE
	}
end

function var_0_0.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == GAME.CITY_REBUILD_DONE then
		if var_8_0.operation == CityRebuildProxy.CHOOSE_LEVEL or var_8_0.operation == CityRebuildProxy.INIT_TIME then
			arg_8_0.viewComponent:Refresh()
		elseif var_8_0.operation == CityRebuildProxy.REBUILD_OR_START_RECRUIT or var_8_0.operation == CityRebuildProxy.END_RECRUIT or var_8_0.operation == CityRebuildProxy.UPGRADE_BUFF then
			arg_8_0.viewComponent:Refresh(true)
		elseif var_8_0.operation == CityRebuildProxy.RESULT then
			arg_8_0.viewComponent:Refresh(true)

			local var_8_1 = var_8_0.pt.k + var_8_0.pt.m * 1000000 + var_8_0.pt.b * 0

			if #var_8_0.awards == 0 and var_8_0.pt.k + var_8_0.pt.m * 1000000 + var_8_0.pt.b * 0 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_cant_pickup"))

				return
			end

			arg_8_0.viewComponent:Summary(function()
				if var_8_1 > 0 then
					table.insert(var_0, {
						id = 65103,
						type = 2,
						count = var_8_1
					})
				end

				if #var_0 > 0 then
					arg_8_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_0)
				end

				return
			end, var_8_0.pt.k + var_8_0.pt.m * 1000000 + var_8_0.pt.b * 0)
		end
	end

	return
end

return var_0_0
