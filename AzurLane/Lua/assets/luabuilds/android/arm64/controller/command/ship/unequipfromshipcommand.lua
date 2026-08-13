class = var_0_10000

local var_0_0 = "UnequipFromShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.pos
	local var_1_2 = var_2.callback

	getProxy = var_1_10006
	BayProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getShipById(var_1_3, var_1_0)

	getProxy = var_1_10008
	PlayerProxy = var_10

	local var_1_5 = var_1_10008(var_10)
	local var_1_6 = var_8.getData(var_1_5)

	getProxy = var_1_3
	EquipmentProxy = var_1_10011

	local var_1_7 = var_1_3(var_1_10011)
	local var_1_8 = var_9.getCapacity(var_1_7)
	local var_1_9 = var_1_6

	if var_1_6.getMaxEquipmentBag(var_1_9) <= var_1_8 then
		NoPosMsgBox = var_10
		i18n = var_1_9

		local var_1_10 = var_1_9("switch_to_shop_tip_noPos")

		openDestroyEquip = var_1_10013
		gotoChargeScene = var_1_10014

		var_10(var_1_10, var_1_10013, var_1_10014)

		if var_1_2 then
			var_1_2()
		end

		return
	end

	if var_1_4 == nil then
		pg = var_10

		local var_1_11 = var_10.TipsMgr.GetInstance()
		local var_1_12 = var_10.ShowTips

		i18n = var_1_10013

		var_1_12(var_1_11, var_1_10013("ship_error_noShip", var_1_0))

		if var_1_2 then
			var_1_2()
		end

		return
	end

	if not var_1_4:getEquip(var_1_1) then
		pg = var_1_7

		local var_1_13 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10014

		var_1_7(var_1_13, var_1_10014("ship_unequipFromShip_error_noEquip"))

		if var_1_2 then
			var_1_2()
		end

		return
	end

	pg = var_1_7

	local var_1_14 = var_1_7.ConnectionMgr.GetInstance()

	var_11.Send(var_1_14, 12006, {
		type = 0,
		equip_id = 0,
		ship_id = var_1_0,
		pos = var_1_1
	}, 12007, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			EquipmentProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			var_2_10004 = var_1_4

			var_2.updateEquip(var_2_10004, var_1_1, nil)

			var_2_10004 = var_0

			var_2.updateShip(var_2_10004, var_1_4)

			var_2_10004 = var_0

			var_2.setSkinId(var_2_10004, 0)

			var_2_10004 = var_2_0

			var_2_0.addEquipment(var_2_10004, var_0)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.UNEQUIP_FROM_SHIP_DONE, var_1_4)

			pg = var_2_1
			var_2_10004 = var_2_1.TipsMgr.GetInstance()

			local var_2_2 = var_2.ShowTips

			i18n = var_5

			local var_2_3 = "ship_unequipFromShip_ok"
			local var_2_4 = var_0

			var_2_2(var_2_10004, var_5(var_2_3, var_8.getConfig(var_2_4, "name")), "red")

			var_2_10004 = var_1_4

			if var_2.getEquipSkin(var_2_10004, var_1_1) > 0 then
				var_2_10004 = var_1_4

				local var_2_5 = var_2.checkCanEquipSkin
				local var_2_6 = var_1_1
				local var_2_7 = var_1_4

				if not var_2_5(var_2_10004, var_2_6, var_6.getEquipSkin(var_2_7, var_1_1)) then
					var_2_10004 = arg_1_0

					local var_2_8 = var_2.sendNotification

					GAME = var_2_6

					var_2_8(var_2_10004, var_2_6.EQUIP_EQUIPMENTSKIN_TO_SHIP, {
						equipmentSkinId = 0,
						shipId = var_1_0,
						pos = var_1_1
					})
				end
			end
		else
			pg = var_2_0

			local var_2_9 = var_2_0.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_10(var_2_9, var_2_10004("ship_unequipFromShip", arg_2_0.result))
		end

		if var_1_2 then
			var_1_2()
		end

		return
	end)

	return
end

return var_0_1
