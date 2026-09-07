local SpWeaponUpgradeMediator = class("SpWeaponUpgradeMediator", import("view.base.ContextMediator"))

SpWeaponUpgradeMediator.EQUIPMENT_UPGRADE = "SpWeaponUpgradeMediator:EQUIPMENT_UPGRADE"
SpWeaponUpgradeMediator.EQUIPMENT_COMPOSITE = "SpWeaponUpgradeMediator:EQUIPMENT_COMPOSITE"
SpWeaponUpgradeMediator.OPEN_EQUIPMENT_INDEX = "SpWeaponUpgradeMediator:OPEN_EQUIPMENT_INDEX"
SpWeaponUpgradeMediator.ON_SKILLINFO = "SpWeaponUpgradeMediator:ON_SKILLINFO"

function SpWeaponUpgradeMediator:register()
	self:BindEvent()
	self.viewComponent:setItems((getProxy(BagProxy):getData()))
	self.viewComponent:updateRes(getProxy(PlayerProxy):getData())

	local var_1_0 = EquipmentProxy.StaticGetSpWeapon(self.contextData.shipId, self.contextData.spWeaponUid)

	self.viewComponent:SetSpWeapon((self.contextData.spWeaponConfigId or nil) and SpWeapon.New({
		id = self.contextData.spWeaponConfigId
	}))
	self:UpdateSpWeapons()

	return
end

function SpWeaponUpgradeMediator:UpdateSpWeapons()
	local var_2_0 = getProxy(BayProxy):GetSpWeaponsInShips()

	for iter_2_0, iter_2_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		table.insert(var_2_0, iter_2_1)
	end

	self.viewComponent:SetSpWeaponList(var_2_0)

	return
end

function SpWeaponUpgradeMediator:BindEvent()
	self:bind(SpWeaponUpgradeMediator.EQUIPMENT_UPGRADE, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:sendNotification(GAME.UPGRADE_SPWEAPON, {
			shipId = self.contextData.shipId,
			uid = arg_4_1,
			items = arg_4_2,
			consumes = arg_4_3
		})

		return
	end)
	self:bind(SpWeaponUpgradeMediator.EQUIPMENT_COMPOSITE, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		self:sendNotification(GAME.COMPOSITE_SPWEAPON, {
			id = arg_5_1,
			consumeItems = arg_5_2,
			consumeSpweapons = arg_5_3
		})

		return
	end)
	self:bind(SpWeaponUpgradeMediator.OPEN_EQUIPMENT_INDEX, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_6_1
		}))

		return
	end)
	self:bind(SpWeaponUpgradeMediator.ON_SKILLINFO, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		self:addSubLayers(Context.New({
			mediator = SkillInfoMediator,
			viewComponent = SpWeaponSkillInfoLayer,
			data = {
				unlock = arg_7_2,
				skillId = arg_7_1,
				skillOnShip = {
					level = arg_7_3
				}
			}
		}))

		return
	end)

	return
end

function SpWeaponUpgradeMediator:listNotificationInterests()
	return {
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		EquipmentProxy.SPWEAPONS_UPDATED,
		GAME.COMPOSITE_SPWEAPON_DONE,
		GAME.UPGRADE_SPWEAPON_DONE,
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE
	}
end

function SpWeaponUpgradeMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == GAME.COMPOSITE_SPWEAPON_DONE then
		self.viewComponent:SetSpWeapon(var_9_1)
		self.viewComponent:ClearSelectMaterials()
		self.viewComponent:UpdateAll()

		if self.contextData.shipId and self.contextData.shipId > 0 then
			self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP, {
				spWeaponUid = var_9_1:GetUID(),
				shipId = self.contextData.shipId
			})
		end
	elseif var_9_0 == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE then
		self.viewComponent:emit(BaseUI.ON_BACK)
	elseif var_9_0 == GAME.UPGRADE_SPWEAPON_DONE then
		self.viewComponent:SetSpWeapon(var_9_1)
		self.viewComponent:ClearSelectMaterials()
		self.viewComponent:UpdateAll()
	elseif var_9_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setItems(getProxy(BagProxy):getData())
	elseif var_9_0 == PlayerProxy.UPDATED then
		self.viewComponent:updateRes(getProxy(PlayerProxy):getData())
	elseif var_9_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		self:UpdateSpWeapons()
		self.viewComponent:UpdateCraftTargetCount()
	end

	return
end

return SpWeaponUpgradeMediator
