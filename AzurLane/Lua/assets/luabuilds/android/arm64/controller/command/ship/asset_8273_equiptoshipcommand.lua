class = var_0_10000

local var_0_0 = "EquipToShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().equipmentId
	local var_1_1 = var_2.shipId
	local var_1_2 = var_2.pos
	local var_1_3 = var_2.callback

	getProxy = var_1_10007
	BayProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5

	if var_7.getShipById(var_1_4, var_1_1) == nil then
		pg = var_1_10009
		var_1_5 = var_1_10009.TipsMgr.GetInstance()
		var_1_10009 = var_1_10009.ShowTips
		i18n = var_1_10012

		var_1_10009(var_1_5, var_1_10012("ship_error_noShip", var_1_1))

		if var_1_3 then
			var_1_3(100)
		end

		return
	end

	getProxy = var_1_10009
	EquipmentProxy = var_1_5

	local var_1_6 = var_1_10009(var_1_5)
	local var_1_7 = var_9.getEquipmentById(var_1_6, var_1_0)
	local var_1_8 = var_8
	local var_1_9, var_1_10 = var_8.canEquipAtPos(var_1_8, var_1_7, var_1_2)

	if not var_1_9 then
		pg = var_1_8

		local var_1_11 = var_1_8.TipsMgr.GetInstance()

		var_1_8.ShowTips(var_1_11, var_1_10)

		return
	end

	if not var_1_7 or var_1_7.count == 0 then
		pg = var_1_8

		local var_1_12 = var_1_8.TipsMgr.GetInstance()

		var_1_8 = var_1_8.ShowTips
		i18n = var_1_10016

		var_1_8(var_1_12, var_1_10016("ship_equipToShip_error_noEquip"))

		if var_1_3 then
			var_1_3(101)
		end

		return
	end

	pg = var_1_8

	local var_1_13 = var_1_8.ConnectionMgr.GetInstance()

	var_13.Send(var_1_13, 12006, {
		type = 0,
		equip_id = var_1_0,
		ship_id = var_1_1,
		pos = var_1_2
	}, 12007, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.getEquip(var_2_0, var_1_2)
			var_2_10004 = var_0

			local var_2_2 = var_2.getEquipmentById(var_2_10004, var_1_0)

			assert = var_2_0

			var_2_0(var_2_2 and var_2_2.count > 0)

			var_2_2.count = 1

			if var_2_1 then
				local var_2_3 = var_0

				var_3.addEquipment(var_2_3, var_2_1)
			end

			local var_2_4 = var_0

			var_3.updateEquip(var_2_4, var_1_2, var_2_2)

			local var_2_5 = var_0

			var_3.updateShip(var_2_5, var_0)

			local var_2_6 = var_0

			var_3.removeEquipmentById(var_2_6, var_1_0, 1)

			local var_2_7 = arg_1_0
			local var_2_8 = var_3.sendNotification

			GAME = var_6

			var_2_8(var_2_7, var_6.EQUIP_TO_SHIP_DONE, var_0)

			pg = var_2_8

			local var_2_9 = var_2_8.TipsMgr.GetInstance()
			local var_2_10 = var_3.ShowTips

			i18n = var_6

			var_2_10(var_2_9, var_6("ship_equipToShip_ok", var_2_2:getConfig("name")), "green")

			pg = var_2_10

			local var_2_11 = var_2_10.CriMgr.GetInstance()
			local var_2_12 = var_3.PlaySoundEffect_V3

			SFX_UI_DOCKYARD_EQUIPON = var_6

			var_2_12(var_2_11, var_6)

			if var_1_3 then
				var_1_3()
			end
		else
			pg = var_2_1

			local var_2_13 = var_2_1.TipsMgr.GetInstance()
			local var_2_14 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_14(var_2_13, var_2_10004("ship_equipToShip", arg_2_0.result))

			if var_1_3 then
				var_1_3()
			end
		end

		return
	end)

	return
end

return var_0_1
