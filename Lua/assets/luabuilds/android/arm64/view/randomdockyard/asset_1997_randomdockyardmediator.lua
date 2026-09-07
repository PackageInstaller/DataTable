local RandomDockYardMediator = class("RandomDockYardMediator", import("view.base.ContextMediator"))

RandomDockYardMediator.OPEN_INDEX = "RandomDockYardMediator:OPEN_INDEX"
RandomDockYardMediator.ON_ADD_SHIPS = "RandomDockYardMediator:ON_ADD_SHIPS"
RandomDockYardMediator.ON_REMOVE_SHIPS = "RandomDockYardMediator:ON_REMOVE_SHIPS"
RandomDockYardMediator.OPEN_PHANTOM_LAYER = "RandomDockYardMediator.OPEN_PHANTOM_LAYER"

function RandomDockYardMediator:register()
	self:bind(RandomDockYardMediator.ON_ADD_SHIPS, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.CHANGE_RANDOM_SHIPS, {
			addList = underscore.map(arg_2_1, function(arg_3_0)
				return ShipPhantom.PackMark(arg_3_0, 0)
			end),
			deleteList = {}
		})

		return
	end)
	self:bind(RandomDockYardMediator.ON_REMOVE_SHIPS, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.CHANGE_RANDOM_SHIPS, {
			addList = {},
			deleteList = underscore.map(arg_4_1, function(arg_5_0)
				return ShipPhantom.PackMark(arg_5_0, 0)
			end)
		})

		return
	end)
	self:bind(RandomDockYardMediator.OPEN_INDEX, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = RandomDockYardIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	self:bind(RandomDockYardMediator.OPEN_PHANTOM_LAYER, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			mediator = DockyardMediator,
			viewComponent = DockyardScene,
			data = {
				mode = DockyardScene.MODE_SHIP_PHANTOM
			}
		}))

		return
	end)

	return
end

function RandomDockYardMediator:listNotificationInterests()
	return {
		GAME.CHANGE_RANDOM_SHIPS_DONE
	}
end

function RandomDockYardMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getBody()

	if arg_9_1:getName() == GAME.CHANGE_RANDOM_SHIPS_DONE then
		self.viewComponent:OnChangeRandomShips()
	end

	return
end

return RandomDockYardMediator
