local ShipRemouldMediator = class("ShipRemouldMediator", import("..base.ContextMediator"))

ShipRemouldMediator.REMOULD_SHIP = "ShipRemouldMediator:REMOULD_SHIP"
ShipRemouldMediator.ON_SELECTE_SHIP = "ShipRemouldMediator:ON_SELECTE_SHIP"

function ShipRemouldMediator:register()
	local var_1_0 = getProxy(BayProxy)

	self.viewComponent:setShipVO((var_1_0:getShipById(self.contextData.shipId)))
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	self.bagProxy = getProxy(BagProxy)

	self.viewComponent:setItems(self.bagProxy:getData())
	self:bind(ShipRemouldMediator.REMOULD_SHIP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		if self.contextData.materialShipIds and #self.contextData.materialShipIds > 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("remould_ship_count_more"))

			return
		end

		local var_2_0 = {
			shipId = arg_2_1,
			remouldId = arg_2_2
		}

		var_2_0.materialIds = self.contextData.materialShipIds or {}

		self:sendNotification(GAME.REMOULD_SHIP, var_2_0)

		return
	end)
	self:bind(ShipRemouldMediator.ON_SELECTE_SHIP, function(arg_3_0, arg_3_1)
		local var_3_0 = var_1_0:getUpgradeShips(arg_3_1)
		local var_3_1 = pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_3, underscore.map(var_3_0, function(arg_4_0)
			return arg_4_0.id
		end))

		table.insert(var_3_1, arg_3_1.id)

		local var_3_2 = {
			destroyCheck = true,
			selectedMin = 1,
			selectedMax = 1,
			shipVOs = var_3_0,
			ignoredIds = var_3_1
		}

		var_3_2.selectedIds = self.contextData.materialShipIds or {}

		function var_3_2:onShip(arg_5_1)
			if self:getFlag("inAdmiral") then
				local var_5_1 = i18n("confirm_unlock_ship_main")

				return
			elseif self:GetLockState() == Ship.LOCK_STATE_LOCK then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					yseBtnLetf = true,
					content = i18n("confirm_unlock_lv", "Lv." .. self.level, self:getName()),
					onYes = function()
						pg.m02:sendNotification(GAME.UPDATE_LOCK, {
							ship_id_list = {
								self.id
							},
							is_locked = Ship.LOCK_STATE_UNLOCK
						})

						return
					end,
					yesText = i18n("msgbox_text_unlock")
				})

				return false, nil
			else
				return ShipStatus.canDestroyShip(self, arg_5_1)
			end

			return
		end

		function var_3_2.onSelected(arg_7_0)
			self.contextData.materialShipIds = arg_7_0

			return
		end

		var_3_2.mode = DockyardScene.MODE_REMOULD
		var_3_2.hideTagFlags = ShipStatus.TAG_HIDE_DESTROY

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, var_3_2)

		return
	end)

	return
end

function ShipRemouldMediator:listNotificationInterests()
	return {
		GAME.REMOULD_SHIP_DONE,
		PlayerProxy.UPDATED,
		BagProxy.ITEM_UPDATED
	}
end

function ShipRemouldMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.REMOULD_SHIP_DONE then
		self.viewComponent:setShipVO(var_9_1.ship)
		self.viewComponent:updateLines()

		if #var_9_1.awards ~= 0 then
			self:addSubLayers(Context.New({
				mediator = NewShipMediator,
				viewComponent = NewShipLayer,
				data = {
					fromRemould = true,
					ship = var_9_1.ship
				}
			}))
			self.viewComponent:initShipModel()
		end

		self.contextData.materialShipIds = nil

		pg.TipsMgr.GetInstance():ShowTips(i18n("remould_ship_ok"))
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setItems(self.bagProxy:getData())
	end

	return
end

return ShipRemouldMediator
