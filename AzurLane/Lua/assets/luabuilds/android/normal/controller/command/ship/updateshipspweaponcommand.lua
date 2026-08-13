class = var_0_10000

local var_0_0 = "UpdateShipSpWeaponCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().spWeaponUid then
		var_1_0 = 0
	end

	local var_1_1 = var_2.shipId
	local var_1_2 = var_2.callback

	getProxy = var_1_10006
	BayProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	getProxy = var_1_10007
	EquipmentProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)
	local var_1_5

	if var_1_0 and var_1_0 ~= 0 then
		var_1_5 = var_1_4:GetSpWeaponByUid(var_1_0)
		assert = var_9

		var_9(var_1_5, "不存在该特殊兵装" .. var_1_0)

		if not var_1_5 then
			pg = var_9

			local var_1_6 = var_9.TipsMgr.GetInstance()
			local var_1_7 = var_9.ShowTips

			i18n = var_11

			var_1_7(var_1_6, var_11("ship_equipToShip_error_noEquip"))

			return
		end
	end

	local var_1_8 = var_1_3

	if var_1_3.getShipById(var_1_8, var_1_1) == nil then
		pg = var_1_8

		local var_1_9 = var_1_8.TipsMgr.GetInstance()

		var_1_8 = var_1_8.ShowTips
		i18n = var_1_10012

		var_1_8(var_1_9, var_1_10012("ship_error_noShip", var_1_1))

		return
	end

	ShipStatus = var_1_8

	local var_1_10, var_1_11 = var_1_8.ShipStatusCheck("onModify", var_9)

	if not var_1_10 then
		pg = var_1_19

		local var_1_12 = var_1_19.TipsMgr.GetInstance()

		var_1_19.ShowTips(var_1_12, var_1_11)

		return
	end

	if not var_1_5 then
		local var_1_13 = var_9

		if not var_9.GetSpWeapon(var_1_13) then
			return
		end

		getProxy = var_1_13
		EquipmentProxy = var_1_10014

		local var_1_14 = var_1_13(var_1_10014)
		local var_1_15 = var_13.GetSpWeaponCapacity(var_1_14)

		getProxy = var_1_14
		EquipmentProxy = var_1_10015

		local var_1_16 = var_1_14(var_1_10015)

		if var_1_15 <= var_14.GetSpWeaponCount(var_1_16) then
			pg = var_1_16

			local var_1_17 = var_1_16.TipsMgr.GetInstance()
			local var_1_18 = var_15.ShowTips

			i18n = var_1_10017

			var_1_18(var_1_17, var_1_10017("spweapon_tip_bag_no_enough"))

			return
		end
	end

	local var_1_19

	if var_1_5 then
		local var_1_20

		var_1_19, var_1_20 = var_9:CanEquipSpWeapon(var_1_5)

		if not var_1_19 then
			pg = var_14

			local var_1_21 = var_14.TipsMgr.GetInstance()

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

				var_2_10003.AddSpWeapon(var_2_3, var_2_1)
			end

			local var_2_4 = var_0

			var_2_10003.UpdateSpWeapon(var_2_4, var_2_2)

			local var_2_5 = var_1_3

			var_2_10003.updateShip(var_2_5, var_0)

			if var_1_0 and var_1_0 ~= 0 then
				local var_2_6 = var_1_4

				var_2_10003.RemoveSpWeapon(var_2_6, var_2_2)
			end

			local var_2_7 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_5

			var_2_10003(var_2_7, var_5.EQUIP_SPWEAPON_TO_SHIP_DONE, var_0)

			if var_1_0 and var_1_0 ~= 0 then
				pg = var_2_10003

				local var_2_8 = var_2_10003.TipsMgr.GetInstance()

				var_2_10003 = var_2_10003.ShowTips
				i18n = var_5

				var_2_10003(var_2_8, var_5("ship_equipToShip_ok", var_2_2:GetName()), "green")
			end

			if var_2_1 then
				pg = var_2_10003

				local var_2_9 = var_2_10003.TipsMgr.GetInstance()

				var_2_10003 = var_2_10003.ShowTips
				i18n = var_5

				var_2_10003(var_2_9, var_5("ship_unequipFromShip_ok", var_2_1:GetName()), "red")
			end

			pg = var_2_10003

			local var_2_10 = var_2_10003.CriMgr.GetInstance()

			var_2_10003 = var_2_10003.PlaySoundEffect_V3
			SFX_UI_DOCKYARD_EQUIPON = var_5

			var_2_10003(var_2_10, var_5)
		else
			pg = var_2_1

			local var_2_11 = var_2_1.TipsMgr.GetInstance()

			var_2_1 = var_2_1.ShowTips
			errorTip = var_2_10003

			var_2_1(var_2_11, var_2_10003("ship_equipToShip", arg_2_0.result))
		end

		existCall = var_2_1

		var_2_1(var_1_2)

		return
	end)

	return
end

return var_0_1
