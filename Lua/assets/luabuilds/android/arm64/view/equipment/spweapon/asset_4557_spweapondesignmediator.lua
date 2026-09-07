local SpWeaponDesignMediator = class("SpWeaponDesignMediator", import("view.base.ContextMediator"))

SpWeaponDesignMediator.ON_COMPOSITE = "SpWeaponDesignMediator:ON_COMPOSITE"
SpWeaponDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX = "SpWeaponDesignMediator:OPEN_EQUIPMENTDESIGN_INDEX"

function SpWeaponDesignMediator:register()
	self:BindEvent()
	self.viewComponent:setItems(getProxy(BagProxy):getRawData())

	local var_1_0 = getProxy(EquipmentProxy)
	local var_1_1 = {}

	_.each(SpWeapon.bindConfigTable().all, function(arg_2_0)
		local var_2_0 = SpWeapon.New({
			id = arg_2_0
		})

		if var_2_0:IsCraftable() then
			table.insert(var_1_1, var_2_0)
		end

		return
	end)
	self.viewComponent:SetCraftList(var_1_1)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getRawData()))

	local var_1_2 = self:getFacade():retrieveMediator(EquipmentMediator.__cname):getViewComponent()

	self.viewComponent:SetParentTF(var_1_2._tf)
	self.viewComponent:SetTopContainer(var_1_2.topPanel)
	self.viewComponent:SetTopItems(var_1_2.topItems)
	self:UpdateSpWeapons()

	return
end

function SpWeaponDesignMediator:BindEvent()
	self:bind(SpWeaponDesignMediator.ON_COMPOSITE, function(arg_4_0, arg_4_1)
		self:addSubLayers(Context.New({
			mediator = SpWeaponUpgradeMediator,
			viewComponent = SpWeaponUpgradeLayer,
			data = {
				spWeaponConfigId = arg_4_1
			}
		}))

		return
	end)
	self:bind(SpWeaponDesignMediator.OPEN_EQUIPMENTDESIGN_INDEX, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_5_1
		}))

		return
	end)

	return
end

function SpWeaponDesignMediator:UpdateSpWeapons()
	local var_6_0 = getProxy(BayProxy):GetSpWeaponsInShips()

	for iter_6_0, iter_6_1 in ipairs((_.values(getProxy(EquipmentProxy):GetSpWeapons()))) do
		table.insert(var_6_0, iter_6_1)
	end

	self.viewComponent:SetSpWeapons(var_6_0)

	return
end

function SpWeaponDesignMediator:listNotificationInterests()
	return {
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		GAME.COMPOSITE_SPWEAPON_DONE,
		GAME.EQUIP_SPWEAPON_TO_SHIP_DONE,
		EquipmentProxy.SPWEAPONS_UPDATED
	}
end

function SpWeaponDesignMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setItems(getProxy(BagProxy):getRawData())
	elseif var_8_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())
	elseif var_8_0 == GAME.COMPOSITE_SPWEAPON_DONE then
		local var_8_2 = getProxy(ContextProxy):getContextByMediator(EquipmentMediator):getContextByMediator(SpWeaponUpgradeMediator)

		if var_8_2 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_8_2
			})
		end
	elseif var_8_0 == GAME.EQUIP_SPWEAPON_TO_SHIP_DONE or var_8_0 == EquipmentProxy.SPWEAPONS_UPDATED then
		self:UpdateSpWeapons()
		self.viewComponent:filter()
	end

	return
end

return SpWeaponDesignMediator
