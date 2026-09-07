local SpWeaponInfoMediator = class("SpWeaponInfoMediator", import("view.base.ContextMediator"))

SpWeaponInfoMediator.ON_DESTROY = "SpWeaponInfoMediator:ON_DESTROY"
SpWeaponInfoMediator.ON_EQUIP = "SpWeaponInfoMediator:ON_EQUIP"
SpWeaponInfoMediator.ON_INTENSIFY = "SpWeaponInfoMediator.ON_INTENSIFY"
SpWeaponInfoMediator.ON_CHANGE = "SpWeaponInfoMediator.ON_CHANGE"
SpWeaponInfoMediator.ON_UNEQUIP = "SpWeaponInfoMediator:ON_UNEQUIP"
SpWeaponInfoMediator.ON_MOVE = "SpWeaponInfoMediator:ON_MOVE"
SpWeaponInfoMediator.ON_MODIFY = "SpWeaponInfoMediator:ON_MODIFY"

function SpWeaponInfoMediator:register()
	self:BindEvent()

	if getProxy(ContextProxy):getCurrentContext().scene == SCENE.SPWEAPON_STOREHOUSE then
		self.viewComponent.fromEquipmentView = true
	end

	local var_1_0 = getProxy(BayProxy):getShipById()
	local var_1_1, var_1_2 = unpack(self.contextData.shipVO and {
		self.contextData.shipVO:GetSpWeapon(),
		self.contextData.shipVO
	} or {
		EquipmentProxy.StaticGetSpWeapon(self.contextData.shipId, self.contextData.spWeaponUid)
	})

	if self.contextData.spWeaponConfigId then
		var_1_1 = SpWeapon.New({
			id = self.contextData.spWeaponConfigId
		})
	end

	local var_1_3, var_1_4 = EquipmentProxy.StaticGetSpWeapon(self.contextData.oldShipId, self.contextData.oldSpWeaponUid)

	self.viewComponent:setShip(var_1_2, var_1_4)
	self.viewComponent:setEquipment(var_1_1, var_1_3)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function SpWeaponInfoMediator:BindEvent()
	self:bind(SpWeaponInfoMediator.ON_EQUIP, function(arg_3_0)
		if self.contextData.oldShipId then
			self:sendNotification(GAME.EQUIP_SPWEAPON_FROM_SHIP, {
				spWeaponUid = self.contextData.oldSpWeaponUid,
				oldShipId = self.contextData.oldShipId,
				shipId = self.contextData.shipId
			})
		else
			self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
				spWeaponUid = self.contextData.oldSpWeaponUid,
				shipId = self.contextData.shipId
			})
		end

		return
	end)
	self:bind(SpWeaponInfoMediator.ON_UNEQUIP, function(arg_4_0)
		self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
			shipId = self.contextData.shipId
		})
		self.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)
	self:bind(SpWeaponInfoMediator.ON_MODIFY, function(arg_5_0)
		self:addSubLayers(Context.New({
			mediator = SpWeaponModifyMediator,
			viewComponent = SpWeaponModifyLayer,
			data = {
				spWeaponUid = self.contextData.spWeaponUid,
				shipId = self.contextData.shipId
			}
		}), true)
		self.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)
	self:bind(SpWeaponInfoMediator.ON_INTENSIFY, function(arg_6_0)
		local var_6_0 = getProxy(BayProxy):getShipById(self.contextData.shipId)

		if var_6_0 then
			local var_6_1, var_6_2 = ShipStatus.ShipStatusCheck("onModify", var_6_0)

			if not var_6_1 then
				pg.TipsMgr.GetInstance():ShowTips(var_6_2)

				return
			end
		end

		self:addSubLayers(Context.New({
			mediator = SpWeaponUpgradeMediator,
			viewComponent = SpWeaponUpgradeLayer,
			data = {
				spWeaponUid = self.contextData.spWeaponUid,
				shipId = self.contextData.shipId
			}
		}), true, function()
			self.viewComponent:emit(BaseUI.ON_CLOSE)

			return
		end)

		return
	end)
	self:bind(SpWeaponInfoMediator.ON_CHANGE, function(arg_8_0)
		local var_8_0, var_8_1 = ShipStatus.ShipStatusCheck("onModify", (getProxy(BayProxy):getShipById(self.contextData.shipId)))

		if not var_8_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_8_1)

			return
		end

		self.viewComponent:emit(BaseUI.ON_CLOSE)
		self:sendNotification(GAME.GO_SCENE, SCENE.SPWEAPON_STOREHOUSE, {
			lock = true,
			shipId = self.contextData.shipId,
			warp = StoreHouseConst.WARP_TO_WEAPON,
			mode = StoreHouseConst.EQUIPMENT
		})

		return
	end)
	self:bind(SpWeaponInfoMediator.ON_MOVE, function(arg_9_0, arg_9_1)
		self.viewComponent:emit(BaseUI.ON_CLOSE)
		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			page = 2,
			shipId = arg_9_1
		})

		return
	end)

	return
end

function SpWeaponInfoMediator:listNotificationInterests()
	return {
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE
	}
end

function SpWeaponInfoMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getBody()

	if arg_11_1:getName() == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE then
		self.viewComponent:emit(BaseUI.ON_CLOSE)
	end

	return
end

return SpWeaponInfoMediator
