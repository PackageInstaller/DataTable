local SpWeaponModifyMediator = class("SpWeaponModifyMediator", ContextMediator)

SpWeaponModifyMediator.ON_REFORGE = "ON_REFORGE"
SpWeaponModifyMediator.ON_CONFIRM_REFORGE = "ON_CONFIRM_REFORGE"

function SpWeaponModifyMediator:register()
	self:BindEvent()

	local var_1_0, var_1_1 = EquipmentProxy.StaticGetSpWeapon(self.contextData.shipId, self.contextData.spWeaponUid)

	self.viewComponent:SetSpweaponVO(var_1_0)
	self.viewComponent:SetItems(getProxy(BagProxy):getRawData())

	return
end

function SpWeaponModifyMediator:BindEvent()
	self:bind(SpWeaponModifyMediator.ON_REFORGE, function(arg_3_0)
		self:sendNotification(GAME.REFORGE_SPWEAPON, {
			shipId = self.contextData.shipId,
			uid = self.contextData.spWeaponUid
		})

		return
	end)
	self:bind(SpWeaponModifyMediator.ON_CONFIRM_REFORGE, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.CONFIRM_REFORGE_SPWEAPON, {
			shipId = self.contextData.shipId,
			uid = self.contextData.spWeaponUid,
			op = arg_4_1
		})

		return
	end)

	return
end

function SpWeaponModifyMediator:listNotificationInterests()
	return {
		GAME.REFORGE_SPWEAPON_DONE,
		GAME.CONFIRM_REFORGE_SPWEAPON_DONE,
		BagProxy.ITEM_UPDATED
	}
end

function SpWeaponModifyMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.REFORGE_SPWEAPON_DONE then
		self.viewComponent:SetSpweaponVO(var_6_1)
		self.viewComponent:ResetMaterialMask()
		self.viewComponent:UpdateView()
	elseif var_6_0 == GAME.CONFIRM_REFORGE_SPWEAPON_DONE then
		self.viewComponent:SetSpweaponVO(var_6_1)
		self.viewComponent:UpdateView()
	elseif var_6_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:SetItems(getProxy(BagProxy):getRawData())
	end

	return
end

return SpWeaponModifyMediator
