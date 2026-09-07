local BuildShipRemindMediator = class("BuildShipRemindMediator", import("...base.ContextMediator"))

BuildShipRemindMediator.SHOW_NEW_SHIP = "BuildShipRemindMediator.SHOW_NEW_SHIP"
BuildShipRemindMediator.ON_LOCK = "BuildShipRemindMediator.ON_LOCK"

function BuildShipRemindMediator:register()
	self:bind(BuildShipRemindMediator.SHOW_NEW_SHIP, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_2_1
			}
		}))

		return
	end)
	self:bind(BuildShipRemindMediator.ON_LOCK, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.UPDATE_LOCK, {
			ship_id_list = arg_3_1,
			is_locked = arg_3_2,
			callback = arg_3_3
		})

		return
	end)
	self.viewComponent:setShips(self.contextData.ships)

	return
end

function BuildShipRemindMediator:listNotificationInterests()
	return {}
end

function BuildShipRemindMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return BuildShipRemindMediator
