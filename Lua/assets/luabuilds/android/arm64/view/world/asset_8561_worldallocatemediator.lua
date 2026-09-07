local WorldAllocateMediator = class("WorldAllocateMediator", import("..base.ContextMediator"))

function WorldAllocateMediator:register()
	self.viewComponent:setItem(self.contextData.itemVO)
	self.viewComponent:setFleets(self.contextData.fleetList)
	self.viewComponent:setConfirmCallback(self.contextData.confirmCallback)

	return
end

function WorldAllocateMediator:listNotificationInterests()
	return {
		GAME.WORLD_ITEM_USE_DONE
	}
end

function WorldAllocateMediator:handleNotification(arg_3_1)
	if arg_3_1:getName() == GAME.WORLD_ITEM_USE_DONE then
		self.viewComponent:flush(arg_3_1:getBody().item)
	end

	return
end

return WorldAllocateMediator
