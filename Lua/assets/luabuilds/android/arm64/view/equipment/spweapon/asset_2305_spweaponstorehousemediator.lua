local SpWeaponStoreHouseMediator = class("SpWeaponStoreHouseMediator", import("view.base.ContextMediator"))

SpWeaponStoreHouseMediator.ON_COMPOSITE = "SpWeaponStoreHouseMediator:ON_COMPOSITE"
SpWeaponStoreHouseMediator.ON_UNEQUIP = "SpWeaponStoreHouseMediator:ON_UNEQUIP"
SpWeaponStoreHouseMediator.OPEN_EQUIPMENT_INDEX = "OPEN_EQUIPMENT_INDEX"

function SpWeaponStoreHouseMediator:register()
	self:BindEvent()

	local var_1_0 = getProxy(BayProxy):getShipById(self.contextData.shipId)

	self.viewComponent:setShip(var_1_0)

	if var_1_0 and self.contextData.mode == StoreHouseConst.EQUIPMENT then
		self.contextData.qiutBtn = var_1_0:GetSpWeapon()
	end

	local var_1_1 = {}

	_.each(SpWeapon.bindConfigTable().all, function(arg_2_0)
		local var_2_0 = SpWeapon.New({
			id = arg_2_0
		})

		if var_2_0:IsCraftable() and (not var_1_0 or not var_1_0:IsSpWeaponForbidden(var_2_0)) then
			table.insert(var_1_1, var_2_0)
		end

		return
	end)
	self.viewComponent:SetCraftList(var_1_1)
	self:UpdateSpWeapons()
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function SpWeaponStoreHouseMediator:UpdateSpWeapons()
	local var_3_0 = getProxy(BayProxy):RawGetShipById(self.contextData.shipId)
	local var_3_1 = getProxy(BayProxy):GetSpWeaponsInShips(var_3_0)

	for iter_3_0, iter_3_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		if not var_3_0 or not var_3_0:IsSpWeaponForbidden(iter_3_1) then
			table.insert(var_3_1, iter_3_1)
		end
	end

	self.viewComponent:setEquipments(var_3_1)

	return
end

function SpWeaponStoreHouseMediator:BindEvent()
	self:bind(SpWeaponStoreHouseMediator.ON_UNEQUIP, function(arg_5_0)
		self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
			shipId = self.contextData.shipId
		})

		return
	end)
	self:bind(SpWeaponStoreHouseMediator.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	self:bind(SpWeaponStoreHouseMediator.ON_COMPOSITE, function(arg_7_0, arg_7_1)
		self:addSubLayers(Context.New({
			mediator = SpWeaponUpgradeMediator,
			viewComponent = SpWeaponUpgradeLayer,
			data = {
				spWeaponConfigId = arg_7_1,
				shipId = self.contextData.shipId
			}
		}))

		return
	end)

	return
end

function SpWeaponStoreHouseMediator:listNotificationInterests()
	return {
		PlayerProxy.UPDATED,
		BayProxy.SHIP_UPDATED,
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE,
		EquipmentProxy.SPWEAPONS_UPDATED
	}
end

function SpWeaponStoreHouseMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == BayProxy.SHIP_UPDATED then
		if var_9_1.id == self.contextData.shipId then
			self.viewComponent:setShip(var_9_1)
		end
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_9_1)
	elseif var_9_0 == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_9_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		self:UpdateSpWeapons()
		self.viewComponent:setEquipmentUpdate()
	end

	return
end

return SpWeaponStoreHouseMediator
