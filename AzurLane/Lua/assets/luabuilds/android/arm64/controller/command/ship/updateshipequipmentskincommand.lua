class = var_0_10000

local var_0_0 = "UpdateShipEquipmentSkinCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.pos
	local var_1_2 = var_2.equipmentSkinId

	getProxy = var_1_10006
	EquipmentProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	if var_1_2 and var_1_2 ~= 0 then
		var_1_10009 = var_1_3
		var_1_10007 = var_1_3.getEquipmnentSkinById(var_1_10009, var_1_2)
		assert = var_1_10008

		var_1_10008(var_1_10007, "不存在该外观" .. var_1_2)

		if not var_1_10007 or var_1_10007.count == 0 then
			pg = var_1_10008

			local var_1_4 = var_1_10008.TipsMgr.GetInstance()
			local var_1_5 = var_8.ShowTips

			i18n = var_11

			var_1_5(var_1_4, var_11("equipment_skin_count_noenough"))

			return
		end
	end

	getProxy = var_1_10007
	BayProxy = var_1_10009

	local var_1_6 = var_1_10007(var_1_10009)

	if not var_7.getShipById(var_1_6, var_1_0) then
		pg = var_1_10009

		local var_1_7 = var_1_10009.TipsMgr.GetInstance()

		var_1_10009 = var_1_10009.ShowTips
		i18n = var_1_10012

		var_1_10009(var_1_7, var_1_10012("equipment_skin_no_new_ship"))

		return
	end

	pg = var_1_10009

	local var_1_8 = var_1_10009.ConnectionMgr.GetInstance()

	var_9.Send(var_1_8, 12036, {
		ship_id = var_1_0,
		equip_skin_id = var_1_2,
		pos = var_1_1
	}, 12037, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.getEquipSkin(var_2_0, var_1_1)
			var_2_10004 = var_0

			var_2.updateEquipmentSkin(var_2_10004, var_1_1, var_1_2)

			var_2_10004 = var_0

			var_2.updateShip(var_2_10004, var_0)

			if var_1_2 and var_1_2 ~= 0 then
				if var_2_1 and var_2_1 ~= 0 then
					var_2_10004 = var_1_3

					var_2.addEquipmentSkin(var_2_10004, var_2_1, 1)
				end

				var_2_10004 = var_1_3

				var_2.useageEquipmnentSkin(var_2_10004, var_1_2)

				pg = var_2
				var_2_10004 = var_2.TipsMgr.GetInstance()

				local var_2_2 = var_2.ShowTips

				i18n = var_5

				var_2_2(var_2_10004, var_5("equipment_skin_replace_done"))
			else
				var_2_10004 = var_1_3

				var_2.addEquipmentSkin(var_2_10004, var_2_1, 1)

				pg = var_2
				var_2_10004 = var_2.TipsMgr.GetInstance()

				local var_2_3 = var_2.ShowTips

				i18n = var_5

				var_2_3(var_2_10004, var_5("equipment_skin_unload"))
			end

			var_2_10004 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_5

			var_2_4(var_2_10004, var_5.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE, {
				ship = var_0
			})
		else
			pg = var_2_1

			local var_2_5 = var_2_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
