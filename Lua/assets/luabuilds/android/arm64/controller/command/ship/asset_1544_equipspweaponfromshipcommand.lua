local EquipSpWeaponFromShipCommand = class("EquipSpWeaponFromShipCommand", pm.SimpleCommand)

function EquipSpWeaponFromShipCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipId
	local var_1_2 = var_1_0.oldShipId
	local var_1_3 = var_1_0.spWeaponUid
	local var_1_4 = getProxy(BayProxy)
	local var_1_5 = getProxy(EquipmentProxy)
	local var_1_6
	local var_1_7
	local var_1_8

	if not (function()
		var_1_7 = var_1_4:getShipById(var_1_1)

		if var_1_7 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_1))

			return
		end

		local var_2_0, var_2_1 = ShipStatus.ShipStatusCheck("onModify", var_1_7)

		if not var_2_0 then
			pg.TipsMgr.GetInstance():ShowTips(var_2_1)

			return
		end

		if var_1_7:GetSpWeapon() then
			if getProxy(EquipmentProxy):GetSpWeaponCapacity() <= getProxy(EquipmentProxy):GetSpWeaponCount() then
				pg.TipsMgr.GetInstance():ShowTips(i18n("spweapon_tip_bag_no_enough"))

				return
			end
		end

		var_1_8 = var_1_4:getShipById(var_1_2)

		if var_1_8 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_error_noShip", var_1_2))

			return
		end

		local var_2_2, var_2_3 = ShipStatus.ShipStatusCheck("onModify", var_1_8)

		if not var_2_2 then
			pg.TipsMgr.GetInstance():ShowTips(var_2_3)

			return
		end

		local var_2_4, var_2_5 = ShipStatus.ShipStatusCheck("onModify", var_1_8)

		if not var_2_4 then
			pg.TipsMgr.GetInstance():ShowTips(var_2_5)
		end

		var_1_6 = var_1_8:GetSpWeapon()

		if not var_1_6 or var_1_6:GetUID() ~= var_1_3 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_equipToShip_error_noEquip"))

			return
		end

		local var_2_6, var_2_7 = var_1_7:CanEquipSpWeapon(var_1_6)

		if not var_2_6 then
			pg.TipsMgr.GetInstance():ShowTips(var_2_7)

			return
		end

		return true
	end)() then
		return
	end

	seriesAsync({
		function(arg_3_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("ship_equip_exchange_tip", var_1_8:getName(), var_1_6:GetName(), var_1_7:getName()),
				onYes = arg_3_0
			})

			return
		end,
		function(arg_4_0)
			pg.ConnectionMgr.GetInstance():Send(14201, {
				spweapon_id = 0,
				ship_id = var_1_2
			}, 14202, function(arg_5_0)
				if arg_5_0.result == 0 then
					local var_5_0 = var_1_4:getShipById(var_1_2)
					local var_5_1 = var_5_0:GetSpWeapon()

					var_5_0:UpdateSpWeapon(nil)
					var_1_4:updateShip(var_5_0)
					var_1_5:AddSpWeapon(var_5_1)
					arg_4_0(var_5_1:GetUID())
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_unequipFromShip", arg_5_0.result))
				end

				return
			end)

			return
		end,
		function(arg_6_0, arg_6_1)
			pg.ConnectionMgr.GetInstance():Send(14201, {
				spweapon_id = arg_6_1,
				ship_id = var_1_1
			}, 14202, function(arg_7_0)
				if arg_7_0.result == 0 then
					local var_7_0 = var_1_4:getShipById(var_1_1)
					local var_7_1 = var_7_0:GetSpWeapon()

					if var_7_1 then
						var_1_5:AddSpWeapon(var_7_1)
					end

					local var_7_2 = var_1_5:GetSpWeaponByUid(arg_6_1)

					var_7_0:UpdateSpWeapon(var_7_2)
					var_1_4:updateShip(var_7_0)
					var_1_5:RemoveSpWeapon(var_7_2)
					self:sendNotification(GAME.EQUIP_SPWEAPON_TO_SHIP_DONE, var_7_0)
					pg.TipsMgr.GetInstance():ShowTips(i18n("ship_equipToShip_ok", var_7_2:GetName()), "green")
				else
					pg.TipsMgr.GetInstance():ShowTips(errorTip("ship_equipToShip", arg_7_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return EquipSpWeaponFromShipCommand
