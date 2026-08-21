local var_0_0 = class("UpdateShipEquipmentSkinCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.pos
	local var_1_2 = var_1_0.equipmentSkinId
	local var_1_3 = getProxy(EquipmentProxy)

	if var_1_0.equipmentSkinId and var_1_0.equipmentSkinId ~= 0 then
		local var_1_4 = getProxy(EquipmentProxy):getEquipmnentSkinById(var_1_0.equipmentSkinId)

		assert(var_1_4, "不存在该外观" .. var_1_0.equipmentSkinId)

		if not var_1_4 or var_1_4.count == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_count_noenough"))

			return
		end
	end

	local var_1_5 = getProxy(BayProxy)

	if not var_1_5:getShipById(var_1_0.shipId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_no_new_ship"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(12036, {
		ship_id = var_1_0.shipId,
		equip_skin_id = var_1_0.equipmentSkinId,
		pos = var_1_0.pos
	}, 12037, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0:getEquipSkin(var_1_1)

			var_0:updateEquipmentSkin(var_1_1, var_1_2)
			var_1_5:updateShip(var_0)

			if var_1_2 and var_1_2 ~= 0 then
				if var_2_0 and var_2_0 ~= 0 then
					var_1_3:addEquipmentSkin(var_2_0, 1)
				end

				var_1_3:useageEquipmnentSkin(var_1_2)
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_replace_done"))
			else
				var_1_3:addEquipmentSkin(var_2_0, 1)
				pg.TipsMgr.GetInstance():ShowTips(i18n("equipment_skin_unload"))
			end

			arg_1_0:sendNotification(GAME.EQUIP_EQUIPMENTSKIN_TO_SHIP_DONE, {
				ship = var_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
