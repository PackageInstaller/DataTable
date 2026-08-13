class = var_0_10000

local var_0_0 = "UpdateShipSpWeaponCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().spWeaponUid then
		var_1_0 = 0
	end

	local var_1_1 = var_2.shipId
	local var_1_2 = var_2.callback

	getProxy = var_1_10006
	BayProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	getProxy = var_1_10007
	EquipmentProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5

	if var_1_0 and var_1_0 ~= 0 then
		var_1_5 = var_1_4:GetSpWeaponByUid(var_1_0)
		assert = var_9

		var_9(var_1_5, "不存在该特殊兵装" .. var_1_0)

		if not var_1_5 then
			pg = var_9

			local var_1_6 = var_9.TipsMgr.GetInstance()
			local var_1_7 = var_9.ShowTips

			i18n = var_12

			var_1_7(var_1_6, var_12("ship_equipToShip_error_noEquip"))

			return
		end
	end

	if var_1_3:getShipById(var_1_1) == nil then
		pg = var_1_10010

		local var_1_8 = var_1_10010.TipsMgr.GetInstance()

		var_1_10010 = var_1_10010.ShowTips
		i18n = var_1_10013

		var_1_10010(var_1_8, var_1_10013("ship_error_noShip", var_1_1))

		return
	end

	ShipStatus = var_1_10010

	local var_1_9, var_1_10 = var_1_10010.ShipStatusCheck("onModify", var_9)

	if not var_1_9 then
		pg = var_1_19

		local var_1_11 = var_1_19.TipsMgr.GetInstance()

		var_1_19.ShowTips(var_1_11, var_1_10)

		return
	end

	if not var_1_5 then
		local var_1_12 = var_9

		if not var_9.GetSpWeapon(var_1_12) then
			return
		end

		getProxy = var_13
		EquipmentProxy = var_1_10015

		local var_1_13 = var_13(var_1_10015)
		local var_1_14 = var_13.GetSpWeaponCapacity(var_1_13)

		getProxy = var_1_12
		EquipmentProxy = var_1_10016

		local var_1_15 = var_1_12(var_1_10016)

		if var_1_14 <= var_14.GetSpWeaponCount(var_1_15) then
			pg = var_1_13

			local var_1_16 = var_1_13.TipsMgr.GetInstance()
			local var_1_17 = var_15.ShowTips

			i18n = var_1_10018

			var_1_17(var_1_16, var_1_10018("spweapon_tip_bag_no_enough"))

			return
		end
	end

	local var_1_19

	if var_1_5 then
		local var_1_18 = var_9
		local var_1_20

		var_1_19, var_1_20 = var_9.CanEquipSpWeapon(var_1_18, var_1_5)

		if not var_1_19 then
			pg = var_1_18

			local var_1_21 = var_1_18.TipsMgr.GetInstance()

			var_14.ShowTips(var_1_21, var_1_20)

			return
		end
	end

	pg = var_1_19

	local var_1_22 = var_1_19.ConnectionMgr.GetInstance()

	var_12.Send(var_1_22, 14201, {
		spweapon_id = var_1_0,
		ship_id = var_1_1
	}, 14202, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.GetSpWeapon(var_2_0)

			local var_2_2 = var_1_5

			if var_2_1 then
				local var_2_3 = var_1_4

				var_3.AddSpWeapon(var_2_3, var_2_1)
			end

			local var_2_4 = var_0

			var_3.UpdateSpWeapon(var_2_4, var_2_2)

			local var_2_5 = var_1_3

			var_3.updateShip(var_2_5, var_0)

			if var_1_0 and var_1_0 ~= 0 then
				local var_2_6 = var_1_4

				var_3.RemoveSpWeapon(var_2_6, var_2_2)
			end

			local var_2_7 = arg_1_0
			local var_2_8 = var_3.sendNotification

			GAME = var_6

			var_2_8(var_2_7, var_6.EQUIP_SPWEAPON_TO_SHIP_DONE, var_0)

			local var_2_10

			if var_1_0 and var_1_0 ~= 0 then
				pg = var_2_10

				local var_2_9 = var_2_10.TipsMgr.GetInstance()

				var_2_10 = var_2_10.ShowTips
				i18n = var_6

				var_2_10(var_2_9, var_6("ship_equipToShip_ok", var_2_2:GetName()), "green")
			end

			if var_2_1 then
				pg = var_2_10

				local var_2_11 = var_2_10.TipsMgr.GetInstance()

				var_2_10 = var_2_10.ShowTips
				i18n = var_6

				var_2_10(var_2_11, var_6("ship_unequipFromShip_ok", var_2_1:GetName()), "red")
			end

			pg = var_2_10

			local var_2_12 = var_2_10.CriMgr.GetInstance()
			local var_2_13 = var_3.PlaySoundEffect_V3

			SFX_UI_DOCKYARD_EQUIPON = var_6

			var_2_13(var_2_12, var_6)
		else
			pg = var_2_1

			local var_2_14 = var_2_1.TipsMgr.GetInstance()

			var_2_1 = var_2_1.ShowTips
			errorTip = var_2_10004

			var_2_1(var_2_14, var_2_10004("ship_equipToShip", arg_2_0.result))
		end

		existCall = var_2_1

		var_2_1(var_1_2)

		return
	end)

	return
end

return var_0_1
