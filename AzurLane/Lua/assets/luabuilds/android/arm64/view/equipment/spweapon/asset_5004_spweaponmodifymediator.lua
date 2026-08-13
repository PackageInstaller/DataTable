class = var_0_10000

local var_0_0 = "SpWeaponModifyMediator"

ContextMediator = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

var_0_1.ON_REFORGE = "ON_REFORGE"
var_0_1.ON_CONFIRM_REFORGE = "ON_CONFIRM_REFORGE"

function var_0_1.register(arg_1_0)
	arg_1_0:BindEvent()

	EquipmentProxy = var_1

	local var_1_0, var_1_1 = var_1.StaticGetSpWeapon(arg_1_0.contextData.shipId, arg_1_0.contextData.spWeaponUid)
	local var_1_2 = arg_1_0.viewComponent

	var_3.SetSpweaponVO(var_1_2, var_1_0)

	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_3.SetItems

	getProxy = var_6
	BagProxy = var_1_10008

	local var_1_5 = var_6(var_1_10008)

	var_1_4(var_1_3, var_6.getRawData(var_1_5))

	return
end

function var_0_1.BindEvent(arg_2_0)
	arg_2_0:bind(var_0_1.ON_REFORGE, function(arg_3_0)
		local var_3_0 = arg_2_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.REFORGE_SPWEAPON, {
			shipId = arg_2_0.contextData.shipId,
			uid = arg_2_0.contextData.spWeaponUid
		})

		return
	end)
	arg_2_0:bind(var_0_1.ON_CONFIRM_REFORGE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.CONFIRM_REFORGE_SPWEAPON, {
			shipId = arg_2_0.contextData.shipId,
			uid = arg_2_0.contextData.spWeaponUid,
			op = arg_4_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	GAME = var_1_10002
	var_5_0[1] = var_1_10002.REFORGE_SPWEAPON_DONE
	GAME = var_2
	var_5_0[2] = var_2.CONFIRM_REFORGE_SPWEAPON_DONE
	BagProxy = var_2
	var_5_0[3] = var_2.ITEM_UPDATED

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	GAME = var_6_0

	if var_6_1 == var_6_0.REFORGE_SPWEAPON_DONE then
		local var_6_3 = arg_6_0.viewComponent

		var_4.SetSpweaponVO(var_6_3, var_6_2)

		local var_6_4 = arg_6_0.viewComponent

		var_4.ResetMaterialMask(var_6_4)

		local var_6_5 = arg_6_0.viewComponent

		var_4.UpdateView(var_6_5)
	else
		GAME = var_4

		if var_6_1 == var_4.CONFIRM_REFORGE_SPWEAPON_DONE then
			local var_6_6 = arg_6_0.viewComponent

			var_4.SetSpweaponVO(var_6_6, var_6_2)

			local var_6_7 = arg_6_0.viewComponent

			var_4.UpdateView(var_6_7)
		else
			BagProxy = var_4

			if var_6_1 == var_4.ITEM_UPDATED then
				local var_6_8 = arg_6_0.viewComponent
				local var_6_9 = var_4.SetItems

				getProxy = var_1_10007
				BagProxy = var_1_10009

				local var_6_10 = var_1_10007(var_1_10009)

				var_6_9(var_6_8, var_7.getRawData(var_6_10))
			end
		end
	end

	return
end

return var_0_1
