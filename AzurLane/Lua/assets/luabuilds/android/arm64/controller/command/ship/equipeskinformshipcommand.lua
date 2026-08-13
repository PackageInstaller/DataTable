class = var_0_10000

local var_0_0 = "EquipESkinFormShipCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().oldShipId
	local var_1_1 = var_2.oldShipPos
	local var_1_2 = var_2.newShipId
	local var_1_3 = var_2.newShipPos

	getProxy = var_1_10007
	EquipmentProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)

	getProxy = var_1_10008
	BayProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)

	if not var_8.getShipById(var_1_5, var_1_0) then
		pg = var_1_10010

		local var_1_6 = var_1_10010.TipsMgr.GetInstance()
		local var_1_7 = var_10.ShowTips

		i18n = var_1_10013

		var_1_7(var_1_6, var_1_10013("equipment_skin_no_old_ship"))

		return
	end

	local var_1_8 = var_9

	if var_9.getEquipSkin(var_1_8, var_1_1) == 0 then
		pg = var_1_5

		local var_1_9 = var_1_5.TipsMgr.GetInstance()
		local var_1_10 = var_11.ShowTips

		i18n = var_1_10014

		var_1_10(var_1_9, var_1_10014("equipment_skin_no_old_skinorequipment"))

		return
	end

	local var_1_11 = var_8

	if not var_8.getShipById(var_1_11, var_1_2) then
		pg = var_1_8

		local var_1_12 = var_1_8.TipsMgr.GetInstance()
		local var_1_13 = var_12.ShowTips

		i18n = var_1_10015

		var_1_13(var_1_12, var_1_10015("equipment_skin_no_new_ship"))

		return
	end

	local function var_1_14()
		local var_2_0 = var_1_4

		if not var_0.getEquipmnentSkinById(var_2_0, var_0) or var_0.count == 0 then
			pg = var_2_10001

			local var_2_1 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_2_1, var_2_10004("equipment_skin_count_noenough"))

			return
		end

		pg = var_2_10001

		local var_2_2 = var_2_10001.ConnectionMgr.GetInstance()

		var_1.Send(var_2_2, 12036, {
			ship_id = var_1_2,
			equip_skin_id = var_0,
			pos = var_1_3
		}, 12037, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = var_0

				if var_1.getEquipSkin(var_3_0, var_1_3) ~= 0 then
					var_3_10004 = var_1_4

					var_2.addEquipmentSkin(var_3_10004, var_1, 1)

					pg = var_2
					var_3_10004 = var_2.TipsMgr.GetInstance()

					local var_3_1 = var_2.ShowTips

					i18n = var_5

					var_3_1(var_3_10004, var_5("equipment_skin_unload"))
				end

				var_3_10004 = var_0

				var_2.updateEquipmentSkin(var_3_10004, var_1_3, var_0)

				var_3_10004 = var_0

				var_2.updateShip(var_3_10004, var_0)

				var_3_10004 = var_1_4

				var_2.useageEquipmnentSkin(var_3_10004, var_0)

				pg = var_2
				var_3_10004 = var_2.TipsMgr.GetInstance()

				local var_3_2 = var_2.ShowTips

				i18n = var_5

				var_3_2(var_3_10004, var_5("equipment_skin_replace_done"))

				var_3_10004 = arg_1_0

				local var_3_3 = var_2.sendNotification

				GAME = var_5

				var_3_3(var_3_10004, var_5.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE)
			else
				pg = var_1

				local var_3_4 = var_1.TipsMgr.GetInstance()
				local var_3_5 = var_1.ShowTips

				i18n = var_3_10004

				var_3_5(var_3_4, var_3_10004("equipment_skin_unload_failed" .. arg_3_0.result))
			end

			return
		end)

		return
	end

	pg = var_1_11

	local var_1_15 = var_1_11.ConnectionMgr.GetInstance()

	var_13.Send(var_1_15, 12036, {
		equip_skin_id = 0,
		ship_id = var_1_0,
		pos = var_1_1
	}, 12037, function(arg_4_0)
		if arg_4_0.result == 0 then
			local var_4_0 = var_0

			var_1.updateEquipmentSkin(var_4_0, var_1_1, 0)

			local var_4_1 = var_0

			var_1.updateShip(var_4_1, var_0)

			local var_4_2 = var_1_4

			var_1.addEquipmentSkin(var_4_2, var_0, 1)
			var_1_14()
		else
			pg = var_1

			local var_4_3 = var_1.TipsMgr.GetInstance()
			local var_4_4 = var_1.ShowTips

			i18n = var_2_10004

			var_4_4(var_4_3, var_2_10004("equipment_skin_unload_failed" .. arg_4_0.result))
		end

		return
	end)

	return
end

return var_0_1
