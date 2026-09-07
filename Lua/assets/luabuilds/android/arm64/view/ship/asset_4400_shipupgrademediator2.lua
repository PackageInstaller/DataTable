local ShipUpgradeMediator2 = class("ShipUpgradeMediator2", import("..base.ContextMediator"))

ShipUpgradeMediator2.UPGRADE_SHIP = "ShipUpgradeMediator2:UPGRADE_SHIP"
ShipUpgradeMediator2.ON_SELECT_SHIP = "ShipUpgradeMediator2:ON_SELECT_SHIP"
ShipUpgradeMediator2.NEXTSHIP = "ShipUpgradeMediator2:NEXTSHIP"

function ShipUpgradeMediator2:register()
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))
	self.viewComponent:setItems(getProxy(BagProxy):getData())

	local var_1_0 = getProxy(BayProxy)

	self.viewComponent:setShip((var_1_0:getShipById(self.contextData.shipId)))
	self:bind(ShipUpgradeMediator2.UPGRADE_SHIP, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.UPGRADE_STAR, {
			shipId = self.contextData.shipId,
			shipIds = arg_2_1
		})

		return
	end)
	self:bind(ShipUpgradeMediator2.ON_SELECT_SHIP, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = var_1_0:getUpgradeShips(arg_3_1)
		local var_3_1 = pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_3, underscore.map(var_3_0, function(arg_4_0)
			return arg_4_0.id
		end))

		table.insert(var_3_1, arg_3_1.id)

		local var_3_2 = {
			destroyCheck = true,
			leftTopInfo = i18n("word_upgrade"),
			mode = DockyardScene.MODE_UPGRADE,
			selectedMax = arg_3_2 or 1,
			selectedMin = arg_3_2 or 1,
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

		var_3_2.hideTagFlags = ShipStatus.TAG_HIDE_DESTROY

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, var_3_2)

		return
	end)
	self:bind(ShipUpgradeMediator2.NEXTSHIP, function(arg_8_0, arg_8_1)
		self:sendNotification(ShipUpgradeMediator2.NEXTSHIP, arg_8_1)

		return
	end)

	return
end

function ShipUpgradeMediator2:listNotificationInterests()
	return {
		GAME.UPGRADE_STAR_DONE,
		BagProxy.ITEM_UPDATED,
		BayProxy.SHIP_REMOVED,
		PlayerProxy.UPDATED
	}
end

function ShipUpgradeMediator2:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_10_1)
	elseif var_10_0 == GAME.UPGRADE_STAR_DONE then
		self.contextData.materialShipIds = nil

		self.viewComponent:setShip(var_10_1.newShip)
		self.viewComponent:updateStagesScrollView()
		self:addSubLayers(Context.New({
			viewComponent = ShipBreakResultLayer,
			mediator = ShipBreakResultMediator,
			data = {
				newShip = var_10_1.newShip,
				oldShip = var_10_1.oldShip
			}
		}))
	elseif var_10_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setItems(getProxy(BagProxy):getRawData())
	end

	return
end

return ShipUpgradeMediator2
