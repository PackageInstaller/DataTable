local SharedIslandMediator = class("SharedIslandMediator", import("..View.base.IslandBaseMediator"))

SharedIslandMediator.EXIT = "SharedIslandMediator:EXIT"
SharedIslandMediator.RETURN_SELF_ISLAND = "SharedIslandMediator:RETURN_SELF_ISLAND"

function SharedIslandMediator:_register()
	self:bind(IslandMediator.SELECT_GIFT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ISLAND_SELECT_GIFT, {
			islandId = arg_2_1,
			pos = arg_2_2
		})

		return
	end)
	self:bind(SharedIslandMediator.EXIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ISLAND_EXIT_SHARED, {
			id = arg_3_1
		})

		return
	end)
	self:bind(SharedIslandMediator.RETURN_SELF_ISLAND, function(arg_4_0)
		local var_4_0 = getProxy(IslandProxy):GetIsland()

		pg.m02:sendNotification(GAME.ISLAND_EXIT, {
			id = self.viewComponent:GetIsland().id,
			callback = function()
				pg.m02:sendNotification(GAME.ISLAND_ENTER, {
					id = var_4_0.id
				})

				return
			end
		})

		return
	end)

	return
end

function SharedIslandMediator:_listNotificationInterests()
	return {
		GAME.ISLAND_EXIT_SHARED_DONE
	}
end

function SharedIslandMediator:_handleNotification(arg_7_1)
	local var_7_0 = arg_7_1:getBody()

	if arg_7_1:getName() == GAME.ISLAND_EXIT_SHARED_DONE then
		self.viewComponent:emit(BaseUI.ON_HOME)
	end

	return
end

return SharedIslandMediator
