local EquipESkinFormShipCommand = class("EquipESkinFormShipCommand", pm.SimpleCommand)

function EquipESkinFormShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.oldShipPos
	local var_1_2 = var_1_0.newShipId
	local var_1_3 = var_1_0.newShipPos
	local var_1_4 = getProxy(EquipmentProxy)
	local var_1_5 = getProxy(BayProxy)
	local var_1_6 = var_1_5:getShipById(var_1_0.oldShipId)

	if not var_1_6 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_no_old_ship"))

		return
	end

	local var_1_7 = var_1_6:getEquipSkin(var_1_0.oldShipPos)

	if var_1_7 == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_no_old_skinorequipment"))

		return
	end

	local var_1_8 = var_1_5:getShipById(var_1_0.newShipId)

	if not var_1_8 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_no_new_ship"))

		return
	end

	local function var_1_9()
		local var_2_0 = var_1_4:getEquipmnentSkinById(var_1_7)

		if not var_2_0 or var_2_0.count == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_count_noenough"))

			return
		end

		pg.ConnectionMgr.GetInstance():Send(12036, {
			ship_id = var_1_2,
			equip_skin_id = var_1_7,
			pos = var_1_3
		}, 12037, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = var_1_8:getEquipSkin(var_1_3)

				if var_3_0 ~= 0 then
					var_1_4:addEquipmentSkin(var_3_0, 1)
					pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload"))
				end

				var_1_8:updateEquipmentSkin(var_1_3, var_1_7)
				var_1_5:updateShip(var_1_8)
				var_1_4:useageEquipmnentSkin(var_1_7)
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_replace_done"))
				self:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_FROM_SHIP_DONE)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload_failed" .. arg_3_0.result))
			end

			return
		end)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(12036, {
		equip_skin_id = 0,
		ship_id = var_1_0.oldShipId,
		pos = var_1_0.oldShipPos
	}, 12037, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_1_6:updateEquipmentSkin(var_1_1, 0)
			var_1_5:updateShip(var_1_6)
			var_1_4:addEquipmentSkin(var_1_7, 1)
			var_1_9()
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload_failed" .. arg_4_0.result))
		end

		return
	end)

	return
end

return EquipESkinFormShipCommand
