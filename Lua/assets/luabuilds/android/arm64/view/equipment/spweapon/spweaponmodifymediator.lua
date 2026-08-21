local var_0_0 = class("SpWeaponModifyMediator", ContextMediator)

var_0_0.ON_REFORGE = "ON_REFORGE"
var_0_0.ON_CONFIRM_REFORGE = "ON_CONFIRM_REFORGE"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()

	local var_1_0, var_1_1 = EquipmentProxy.StaticGetSpWeapon(arg_1_0.contextData.shipId, arg_1_0.contextData.spWeaponUid)

	arg_1_0.viewComponent:SetSpweaponVO(var_1_0)
	arg_1_0.viewComponent:SetItems(getProxy(BagProxy):getRawData())

	return
end

function var_0_0.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_0.ON_REFORGE, function(arg_3_0)
		arg_2_0:sendNotification(GAME.REFORGE_SPWEAPON, {
			shipId = arg_2_0.contextData.shipId,
			uid = arg_2_0.contextData.spWeaponUid
		})

		return
	end)
	arg_2_0:bind(var_0_0.ON_CONFIRM_REFORGE, function(arg_4_0, arg_4_1)
		arg_2_0:sendNotification(GAME.CONFIRM_REFORGE_SPWEAPON, {
			shipId = arg_2_0.contextData.shipId,
			uid = arg_2_0.contextData.spWeaponUid,
			op = arg_4_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		GAME.REFORGE_SPWEAPON_DONE,
		GAME.CONFIRM_REFORGE_SPWEAPON_DONE,
		BagProxy.ITEM_UPDATED
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == GAME.REFORGE_SPWEAPON_DONE then
		arg_6_0.viewComponent:SetSpweaponVO(var_6_1)
		arg_6_0.viewComponent:ResetMaterialMask()
		arg_6_0.viewComponent:UpdateView()
	elseif var_6_0 == GAME.CONFIRM_REFORGE_SPWEAPON_DONE then
		arg_6_0.viewComponent:SetSpweaponVO(var_6_1)
		arg_6_0.viewComponent:UpdateView()
	elseif var_6_0 == BagProxy.ITEM_UPDATED then
		arg_6_0.viewComponent:SetItems(getProxy(BagProxy):getRawData())
	end

	return
end

return var_0_0
