local var_0_0 = class("EquipToShipCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.equipmentId
	local var_1_2 = var_1_0.pos
	local var_1_3 = var_1_0.callback
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = getProxy(BayProxy):getShipById(var_1_0.shipId)

	if var_1_5 == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_0.shipId))

		if var_1_0.callback then
			var_1_0.callback(100)
		end

		return
	end

	local var_1_6 = getProxy(EquipmentProxy)
	local var_1_7 = var_1_6:getEquipmentById(var_1_0.equipmentId)
	local var_1_8, var_1_9 = var_1_5:canEquipAtPos(var_1_7, var_1_0.pos)

	if not var_1_8 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_9)

		return
	end

	if not var_1_7 or var_1_7.count == 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_equipToShip_error_noEquip"))

		if var_1_0.callback then
			var_1_0.callback(101)
		end

		return
	end

	pg.ConnectionMgr.GetInstance():Send(12006, {
		type = 0,
		equip_id = var_1_0.equipmentId,
		ship_id = var_1_0.shipId,
		pos = var_1_0.pos
	}, 12007, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_5:getEquip(var_1_2)
			local var_2_1 = var_1_6:getEquipmentById(var_1_1)

			assert(var_2_1 and var_2_1.count > 0)

			var_2_1.count = 1

			if var_2_0 then
				var_1_6:addEquipment(var_2_0)
			end

			var_1_5:updateEquip(var_1_2, var_2_1)
			var_1_4:updateShip(var_1_5)
			var_1_6:removeEquipmentById(var_1_1, 1)
			arg_1_0:sendNotification(GAME.EQUIP_TO_SHIP_DONE, var_1_5)
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_equipToShip_ok", var_2_1:getConfig("name")), "green")
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_EQUIPON)

			if var_1_3 then
				var_1_3()
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_equipToShip", arg_2_0.result))

			if var_1_3 then
				var_1_3()
			end
		end

		return
	end)

	return
end

return var_0_0
