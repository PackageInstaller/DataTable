local AnniversaryIslandBuildingUpgrade2023WindowMediator = class("AnniversaryIslandBuildingUpgrade2023WindowMediator", import("view.base.ContextMediator"))

AnniversaryIslandBuildingUpgrade2023WindowMediator.ACTIVITY_OPERATION = "ACTIVITY_OPERATION"

function AnniversaryIslandBuildingUpgrade2023WindowMediator:register()
	self:bind(AnniversaryIslandBuildingUpgrade2023WindowMediator.ACTIVITY_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	self:bind(WorkBenchItemDetailMediator.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		self:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_3_1
			}
		}))

		return
	end)

	return
end

function AnniversaryIslandBuildingUpgrade2023WindowMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function AnniversaryIslandBuildingUpgrade2023WindowMediator:handleNotification(arg_5_1)
	if arg_5_1:getName() == ActivityProxy.ACTIVITY_UPDATED and arg_5_1:getBody():getConfig("type") == ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF_2 then
		self.viewComponent:UpdateView()
	end

	return
end

function AnniversaryIslandBuildingUpgrade2023WindowMediator:remove()
	return
end

return AnniversaryIslandBuildingUpgrade2023WindowMediator
