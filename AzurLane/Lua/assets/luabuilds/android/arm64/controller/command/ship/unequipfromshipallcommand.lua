class = var_0_10000

local var_0_0 = "UnEquipFromShipAllCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).shipId

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3

	if var_4.getShipById(var_1_2, var_1_1) == nil then
		pg = var_1_10006
		var_1_3 = var_1_10006.TipsMgr.GetInstance()

		local var_1_4 = var_6.ShowTips

		i18n = var_1_10009

		var_1_4(var_1_3, var_1_10009("ship_error_noShip", var_1_1))

		return
	end

	local var_1_5 = #var_5.equipments
	local var_1_6 = 0

	pairs = var_1_3

	for iter_1_0, iter_1_1 in var_1_3(var_5.equipments) do
		if iter_1_1 then
			var_1_6 = var_1_6 + 1
		end
	end

	getProxy = var_8
	PlayerProxy = var_10

	local var_1_7 = var_8(var_10)
	local var_1_8 = var_8.getData(var_1_7)

	getProxy = var_9
	EquipmentProxy = iter_1_0

	local var_1_9 = var_9(iter_1_0)
	local var_1_10 = var_9.getCapacity(var_1_9)
	local var_1_11 = var_1_8

	if var_1_8.getMaxEquipmentBag(var_1_11) < var_1_10 + var_1_6 then
		NoPosMsgBox = var_10
		i18n = var_1_11

		local var_1_12 = var_1_11("switch_to_shop_tip_noPos")

		openDestroyEquip = var_1_10013
		gotoChargeScene = var_1_10014

		var_10(var_1_12, var_1_10013, var_1_10014)

		return
	end

	local var_1_13 = var_5
	local var_1_14 = var_5.GetSpWeapon(var_1_13)

	getProxy = var_11
	EquipmentProxy = var_1_10013

	local var_1_15 = var_11(var_1_10013)
	local var_1_16 = var_11.GetSpWeaponCapacity(var_1_15)

	getProxy = var_1_13
	EquipmentProxy = var_1_10014

	local var_1_17 = var_1_13(var_1_10014)
	local var_1_18 = var_12.GetSpWeaponCount(var_1_17)

	if var_1_14 and var_1_16 <= var_1_18 then
		NoPosMsgBox = var_1_15
		i18n = var_1_10015

		local var_1_19 = var_1_10015("switch_to_shop_tip_noPos")

		OpenSpWeaponPage = var_1_10016
		gotoChargeScene = var_17

		var_1_15(var_1_19, var_1_10016, var_17)

		return
	end

	arg_1_0:fun(var_5, 1, var_1_5, function()
		if var_1_14 then
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.sendNotification

			GAME = var_2_10003

			var_2_1(var_2_0, var_2_10003.EQUIP_SPWEAPON_TO_SHIP, {
				shipId = var_1_1
			})
		end

		return
	end)

	return
end

function var_0_1.fun(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_3 < arg_3_2 then
		pg = var_1_10005
		var_1_10007 = var_1_10005.TipsMgr.GetInstance()
		var_1_10005 = var_1_10005.ShowTips
		i18n = var_1_10008

		var_1_10005(var_1_10007, var_1_10008("ship_unequip_all_success"))

		var_1_10007 = arg_3_0
		var_1_10005 = arg_3_0.sendNotification
		GAME = var_8

		var_1_10005(var_1_10007, var_8.UNEQUIP_FROM_SHIP_DONE, arg_3_1)

		existCall = var_1_10005

		var_1_10005(arg_3_4)

		return
	end

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_3_0 = var_1_10005(var_1_10007)

	if not arg_3_1:getEquip(arg_3_2) then
		arg_3_0:fun(arg_3_1, arg_3_2 + 1, arg_3_3, arg_3_4)

		return
	end

	pg = var_1_10007

	local var_3_1 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_3_1, 12006, {
		type = 0,
		equip_id = 0,
		ship_id = arg_3_1.id,
		pos = arg_3_2
	}, 12007, function(arg_4_0)
		local var_4_0

		if arg_4_0.result == 0 then
			getProxy = var_4_0
			EquipmentProxy = var_2_10003
			var_4_0 = var_4_0(var_2_10003)
			var_2_10004 = arg_3_1

			var_2.updateEquip(var_2_10004, arg_3_2, nil)

			var_2_10004 = var_3_0

			var_2.updateShip(var_2_10004, arg_3_1)

			var_2_10004 = var_4_0

			var_4_0.addEquipment(var_2_10004, var_0)

			var_2_10004 = arg_3_0

			var_2.fun(var_2_10004, arg_3_1, arg_3_2 + 1, arg_3_3, arg_3_4)
		else
			pg = var_4_0

			local var_4_1 = var_4_0.TipsMgr.GetInstance()
			local var_4_2 = var_1.ShowTips

			errorTip = var_2_10004

			var_4_2(var_4_1, var_2_10004("ship_unequipFromShip", arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_1
