local CityRebuildBookMediator = class("CityRebuildBookMediator", import("view.base.ContextMediator"))

CityRebuildBookMediator.REBUILD_OR_START_RECRUIT = "CityRebuildBookMediator.REBUILD_OR_START_RECRUIT"
CityRebuildBookMediator.END_RECRUIT = "CityRebuildBookMediator.END_RECRUIT"
CityRebuildBookMediator.UPGRADE_BUFF = "CityRebuildBookMediator.UPGRADE_BUFF"

function CityRebuildBookMediator:register()
	self:bind(CityRebuildBookMediator.REBUILD_OR_START_RECRUIT, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.REBUILD_OR_START_RECRUIT,
			activityId = arg_2_1,
			buildingId = arg_2_2,
			cost = arg_2_3,
			ptCost = arg_2_4
		})

		return
	end)
	self:bind(CityRebuildBookMediator.END_RECRUIT, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.END_RECRUIT,
			activityId = arg_3_1,
			roles = arg_3_2
		})

		return
	end)
	self:bind(CityRebuildBookMediator.UPGRADE_BUFF, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		self:sendNotification(GAME.CITY_REBUILD, {
			operation = CityRebuildProxy.UPGRADE_BUFF,
			activityId = arg_4_1,
			group = arg_4_2,
			count = arg_4_3,
			ptCost = arg_4_4
		})

		return
	end)

	return
end

function CityRebuildBookMediator:listNotificationInterests()
	return {
		GAME.CITY_REBUILD_DONE
	}
end

function CityRebuildBookMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getBody()

	if arg_6_1:getName() == GAME.CITY_REBUILD_DONE and (var_6_0.operation == CityRebuildProxy.REBUILD_OR_START_RECRUIT or var_6_0.operation == CityRebuildProxy.END_RECRUIT or var_6_0.operation == CityRebuildProxy.UPGRADE_BUFF) then
		self.viewComponent:Refresh()
	end

	return
end

return CityRebuildBookMediator
