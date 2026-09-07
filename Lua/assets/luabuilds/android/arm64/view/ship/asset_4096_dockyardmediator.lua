local DockyardMediator = class("DockyardMediator", import("..base.ContextMediator"))

DockyardMediator.ON_DESTROY_SHIPS = "DockyardMediator:ON_DESTROY_SHIPS"
DockyardMediator.ON_SHIP_DETAIL = "DockyardMediator:ON_SHIP_DETAIL"
DockyardMediator.ON_SHIP_REPAIR = "DockyardMediator:ON_SHIP_REPAIR"
DockyardMediator.OPEN_DOCKYARD_INDEX = "DockyardMediator:OPEN_DOCKYARD_INDEX"
DockyardMediator.CHANGE_SKIN = "DockyardMediator.CHANGE_SKIN"
DockyardMediator.CHANGE_RANDOM_FLAG = "DockyardMediator.CHANGE_RANDOM_FLAG"

function DockyardMediator:register()
	local var_1_0 = getProxy(BayProxy)

	if self.contextData.shipVOs then
		self.shipsById = {}

		for iter_1_0, iter_1_1 in ipairs(self.contextData.shipVOs) do
			self.shipsById[iter_1_1.id] = iter_1_1
		end
	elseif self.contextData.mode == DockyardScene.MODE_WORLD then
		self.shipsById = {}

		for iter_1_2, iter_1_3 in ipairs(nowWorld():GetShipVOs()) do
			self.shipsById[iter_1_3.id] = iter_1_3
		end
	else
		self.shipsById = {}

		for iter_1_4, iter_1_5 in pairs(var_1_0.data) do
			self.shipsById[iter_1_4] = iter_1_5
		end
	end

	if self.contextData.mode == DockyardScene.MODE_MOD then
		self.viewComponent:setModShip(self.shipsById[self.contextData.ignoredIds[1]]:clone())
	end

	self.fleetProxy = getProxy(FleetProxy)
	self.fleetShipIds = self.fleetProxy:getAllShipIds()

	if self.contextData.ignoredIds then
		for iter_1_6, iter_1_7 in ipairs(self.contextData.ignoredIds) do
			self.shipsById[iter_1_7] = nil
		end
	end

	self.viewComponent:setShips(self.shipsById)
	self.viewComponent:setShipsCount(var_1_0:getShipCount())
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self:bind(DockyardMediator.ON_DESTROY_SHIPS, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.DESTROY_SHIPS, {
			destroyEquipment = arg_2_2,
			shipIds = arg_2_1
		})

		return
	end)
	self:bind(DockyardMediator.ON_SHIP_DETAIL, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_3_1.id,
			shipVOs = arg_3_2,
			selectContextData = arg_3_3
		})

		return
	end)
	self:bind(DockyardMediator.ON_SHIP_REPAIR, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.WORLD_SHIP_REPAIR, {
			shipIds = arg_4_1,
			totalCost = arg_4_2
		})

		return
	end)
	self:bind(DockyardMediator.OPEN_DOCKYARD_INDEX, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_5_1
		}))

		return
	end)
	self:bind(DockyardMediator.CHANGE_SKIN, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = SwitchSkinMediator,
			viewComponent = SwitchSkinLayer,
			data = {
				shipVO = arg_6_1
			}
		}))

		return
	end)
	self:bind(DockyardMediator.CHANGE_RANDOM_FLAG, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = {}

		var_7_0.addList = arg_7_2 and {
			arg_7_1
		} or {}
		var_7_0.deleteList = not arg_7_2 and {
			arg_7_1
		} or {}

		self:sendNotification(GAME.CHANGE_RANDOM_SHIPS, var_7_0)

		return
	end)

	return
end

function DockyardMediator:listNotificationInterests()
	return {
		GAME.DESTROY_SHIP_DONE,
		FleetProxy.FLEET_UPDATED,
		GAME.EXIT_SHIP_DONE,
		GAME.UPDATE_EXERCISE_FLEET_DONE,
		GAME.CANCEL_LEARN_TACTICS_DONE,
		PlayerProxy.UPDATED,
		GAME.WORLD_SHIP_REPAIR_DONE,
		GAME.UPDATE_LOCK_DONE,
		GAME.WORLD_FLEET_REDEPLOY_DONE,
		SetShipSkinCommand.SKIN_UPDATED,
		GAME.CHANGE_SKIN_UPDATE
	}
end

function DockyardMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.DESTROY_SHIP_DONE then
		if not pg.m02:hasMediator(ShipMainMediator.__cname) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_dockyardMediator_destroy"))
		end

		for iter_9_0, iter_9_1 in ipairs(var_9_1.destroiedShipIds) do
			self.viewComponent:removeShip(iter_9_1)
		end

		self.viewComponent:updateShipCount()
		self.viewComponent:setShipsCount(getProxy(BayProxy):getShipCount())
		self.viewComponent:updateBarInfo()
		self.viewComponent:updateSelected()
		self.viewComponent:updateDestroyRes()
		self.viewComponent:emit(BaseUI.ON_AWARD, {
			items = var_9_1.bonus,
			title = AwardInfoLayer.TITLE.ITEM,
			removeFunc = function()
				if table.getCount(var_9_1.equipments) > 0 then
					local var_10_0 = {}

					for iter_10_0, iter_10_1 in pairs(var_9_1.equipments) do
						table.insert(var_10_0, iter_10_1)
					end

					self:addSubLayers(Context.New({
						viewComponent = ResolveEquipmentLayer,
						mediator = ResolveEquipmentMediator,
						data = {
							Equipments = var_10_0
						}
					}))
				end

				return
			end
		})
		self.viewComponent:closeDestroyPanel()
	elseif var_9_0 == FleetProxy.FLEET_UPDATED then
		self.fleetShipIds = self.fleetProxy:getAllShipIds()

		local var_9_2 = {}

		for iter_9_2, iter_9_3 in ipairs(self.fleetShipIds) do
			var_9_2[iter_9_3] = 1
		end

		for iter_9_4, iter_9_5 in ipairs(self.fleetShipIds) do
			var_9_2[iter_9_5] = var_9_2[iter_9_5] == 1 and 2 or 3
		end

		for iter_9_6, iter_9_7 in ipairs(self.fleetShipIds) do
			if var_9_2[iter_9_7] == 1 then
				var_9_2[iter_9_7] = 0
			end
		end

		for iter_9_8, iter_9_9 in pairs(var_9_2) do
			if iter_9_9 == 0 then
				self:setShipFlag(iter_9_8, "inFleet", false)
			elseif iter_9_9 == 3 then
				self:setShipFlag(iter_9_8, "inFleet", true)
			end

			self.viewComponent:updateShipStatusById(iter_9_8)
		end
	elseif var_9_0 == GAME.EXIT_SHIP_DONE then
		self:setShipFlag(var_9_1.id, "inBackyard", false)
		self.viewComponent:updateShipStatusById(var_9_1.id)
	elseif var_9_0 == GAME.UPDATE_LOCK_DONE then
		self.shipsById[var_9_1.id].lockState = var_9_1.lockState

		self.viewComponent:updateShipStatusById(var_9_1.id)
	elseif var_9_0 == GAME.CANCEL_LEARN_TACTICS_DONE then
		self:setShipFlag(var_9_1.shipId, "inTactics", false)
		self.viewComponent:updateShipStatusById(var_9_1.shipId)
	elseif var_9_0 == GAME.UPDATE_EXERCISE_FLEET_DONE then
		for iter_9_10, iter_9_11 in ipairs(var_9_1.oldFleet.ships) do
			self:setShipFlag(iter_9_11, "inExercise", false)
			self.viewComponent:updateShipStatusById(iter_9_11)
		end

		for iter_9_12, iter_9_13 in ipairs(var_9_1.newFleet.ships) do
			self:setShipFlag(iter_9_13, "inExercise", true)
			self.viewComponent:updateShipStatusById(iter_9_13)
		end
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == GAME.WORLD_SHIP_REPAIR_DONE then
		_.each(var_9_1.shipIds, function(arg_11_0)
			self.viewComponent:updateShipStatusById(arg_11_0)

			return
		end)
	elseif var_9_0 == GAME.WORLD_FLEET_REDEPLOY_DONE then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_9_0 == SetShipSkinCommand.SKIN_UPDATED then
		if self.shipsById[var_9_1.ship.id] then
			self.shipsById[var_9_1.ship.id] = getProxy(BayProxy):RawGetShipById(var_9_1.ship.id)
		end

		self.viewComponent:OnShipSkinChanged(var_9_1.ship:GetShipPhantomMark())
	elseif var_9_0 == GAME.CHANGE_SKIN_UPDATE then
		local var_9_3, var_9_4 = ShipPhantom.UnpackMark(var_9_1)

		if self.shipsById[var_9_3] then
			self.shipsById[var_9_3] = getProxy(BayProxy):RawGetShipById(var_9_3)
		end

		self.viewComponent:OnShipSkinChanged(var_9_1)
	end

	return
end

function DockyardMediator:setShipFlag(arg_12_1, arg_12_2, arg_12_3)
	if self.shipsById[arg_12_1] then
		self.shipsById[arg_12_1][arg_12_2] = arg_12_3
	end

	return
end

return DockyardMediator
