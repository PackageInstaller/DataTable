local CityRebuildGameMediator = class("CityRebuildGameMediator", import("view.base.ContextMediator"))

CityRebuildGameMediator.INIT_TIME = "CityRebuildGameMediator.INIT_TIME"
CityRebuildGameMediator.RESULT = "CityRebuildGameMediator.RESULT"
CityRebuildGameMediator.CHOOSE_LEVEL = "CityRebuildGameMediator.CHOOSE_LEVEL"
CityRebuildGameMediator.OPEN_BOOK = "CityRebuildGameMediator.OPEN_BOOK"
CityRebuildGameMediator.OPEN_TASKS = "CityRebuildGameMediator.OPEN_TASKS"

function CityRebuildGameMediator:register()
	self:bind(CityRebuildGameMediator.INIT_TIME, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.INIT_TIME,
			activityId = arg_2_1
		})

		return
	end)
	self:bind(CityRebuildGameMediator.RESULT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.RESULT,
			activityId = arg_3_1
		})

		return
	end)
	self:bind(CityRebuildGameMediator.CHOOSE_LEVEL, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.CHOOSE_LEVEL,
			activityId = arg_4_1,
			level = arg_4_2
		})

		return
	end)
	self:bind(CityRebuildGameMediator.OPEN_BOOK, function(arg_5_0)
		self:addSubLayers(Context.New({
			mediator = CityRebuildBookMediator,
			viewComponent = CityRebuildBookLayer,
			data = {
				page = "buff"
			}
		}))

		return
	end)
	self:bind(CityRebuildGameMediator.OPEN_TASKS, function(arg_6_0)
		self:addSubLayers(Context.New({
			mediator = CityRebuildTasksMediator,
			viewComponent = CityRebuildTasksLayer
		}))

		return
	end)

	return
end

function CityRebuildGameMediator:listNotificationInterests()
	return {
		GAME.CITY_REBUILD_DONE
	}
end

function CityRebuildGameMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == GAME.CITY_REBUILD_DONE then
		if var_8_0.operation == CityRebuildProxy.CHOOSE_LEVEL or var_8_0.operation == CityRebuildProxy.INIT_TIME then
			self.viewComponent:Refresh()
		elseif var_8_0.operation == CityRebuildProxy.REBUILD_OR_START_RECRUIT or var_8_0.operation == CityRebuildProxy.END_RECRUIT or var_8_0.operation == CityRebuildProxy.UPGRADE_BUFF then
			self.viewComponent:Refresh(true)
		elseif var_8_0.operation == CityRebuildProxy.RESULT then
			self.viewComponent:Refresh(true)

			local var_8_1 = var_8_0.awards
			local var_8_2 = var_8_0.pt.k + var_8_0.pt.m * 1000000 + var_8_0.pt.b * 0

			if #var_8_0.awards == 0 and var_8_0.pt.k + var_8_0.pt.m * 1000000 + var_8_0.pt.b * 0 == 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ninja_game_cant_pickup"))

				return
			end

			self.viewComponent:Summary(function()
				if var_8_2 > 0 then
					table.insert(var_8_1, {
						id = 65103,
						type = 2,
						count = var_8_2
					})
				end

				if #var_8_1 > 0 then
					self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_8_1)
				end

				return
			end, var_8_0.pt.k + var_8_0.pt.m * 1000000 + var_8_0.pt.b * 0)
		end
	end

	return
end

return CityRebuildGameMediator
