local UpdateShipSpWeaponCommand = class("UpdateShipSpWeaponCommand", pm.SimpleCommand)

function UpdateShipSpWeaponCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.spWeaponUid or 0
	local var_1_2 = var_1_0.shipId
	local var_1_3 = var_1_0.callback
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = getProxy(EquipmentProxy)
	local var_1_6

	if var_1_1 and var_1_1 ~= 0 then
		var_1_6 = var_1_5:GetSpWeaponByUid(var_1_1)

		assert(var_1_6, "不存在该特殊兵装" .. var_1_1)

		if not var_1_6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_equipToShip_error_noEquip"))

			return
		end
	end

	local var_1_7 = var_1_4:getShipById(var_1_2)

	if var_1_7 == nil then
		pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_2))

		return
	end

	local var_1_8, var_1_9 = ShipStatus.ShipStatusCheck("onModify", var_1_7)

	if not var_1_8 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_9)

		return
	end

	if not var_1_6 then
		if not var_1_7:GetSpWeapon() then
			return
		end

		if getProxy(EquipmentProxy):GetSpWeaponCapacity() <= getProxy(EquipmentProxy):GetSpWeaponCount() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_bag_no_enough"))

			return
		end
	end

	if var_1_6 then
		local var_1_10, var_1_11 = var_1_7:CanEquipSpWeapon(var_1_6)

		if not var_1_10 then
			pg.TipsMgr.GetInstance():ShowTips(var_1_11)

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(14201, {
		spweapon_id = var_1_1,
		ship_id = var_1_2
	}, 14202, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_7:GetSpWeapon()

			if var_2_0 then
				var_1_5:AddSpWeapon(var_2_0)
			end

			var_1_7:UpdateSpWeapon(var_1_6)
			var_1_4:updateShip(var_1_7)

			if var_1_1 and var_1_1 ~= 0 then
				var_1_5:RemoveSpWeapon(var_1_6)
			end

			self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP_DONE, var_1_7)

			if var_1_1 and var_1_1 ~= 0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_equipToShip_ok", var_1_6:GetName()), "green")
			end

			if var_2_0 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("ship_unequipFromShip_ok", var_2_0:GetName()), "red")
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_UI_DOCKYARD_EQUIPON)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_equipToShip", arg_2_0.result))
		end

		existCall(var_1_3)

		return
	end)

	return
end

return UpdateShipSpWeaponCommand
