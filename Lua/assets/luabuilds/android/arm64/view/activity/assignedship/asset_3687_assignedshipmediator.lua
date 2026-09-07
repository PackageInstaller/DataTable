local AssignedShipMediator = class("AssignedShipMediator", import("...base.ContextMediator"))

AssignedShipMediator.ON_USE_ITEM = "AssignedShipMediator:ON_USE_ITEM"

function AssignedShipMediator:register()
	self:bind(AssignedShipMediator.ON_USE_ITEM, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self:sendNotification(GAME.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_2,
			arg = arg_2_3
		})

		return
	end)
	self.viewComponent:setItemVO(self.contextData.itemVO)

	return
end

function AssignedShipMediator:listNotificationInterests()
	return {
		GAME.USE_ITEM_DONE
	}
end

function AssignedShipMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.USE_ITEM_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_4_1:getBody().drops, function()
			triggerButton(self.viewComponent.backBtn)

			return
		end)
	end

	return
end

return AssignedShipMediator
