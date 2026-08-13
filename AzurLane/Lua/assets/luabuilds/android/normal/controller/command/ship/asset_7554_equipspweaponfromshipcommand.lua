class = var_0_10000

local var_0_0 = "EquipSpWeaponFromShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.oldShipId
	local var_1_2 = var_2.spWeaponUid

	getProxy = var_1_10006
	BayProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	getProxy = var_1_10007
	EquipmentProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)
	local var_1_5
	local var_1_6
	local var_1_7

	if not (function()
		local var_2_0 = var_1_3

		var_1_6 = var_0.getShipById(var_2_0, var_1_0)

		local var_2_2

		if var_1_6 == nil then
			pg = var_2_2

			local var_2_1 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2

			var_2_2(var_2_1, var_2("ship_error_noShip", var_1_0))

			return
		end

		ShipStatus = var_2_2

		local var_2_3, var_2_4 = var_2_2.ShipStatusCheck("onModify", var_1_6)

		if not var_2_3 then
			pg = var_2

			local var_2_5 = var_2.TipsMgr.GetInstance()

			var_2.ShowTips(var_2_5, var_2_4)

			return
		end

		local var_2_6 = var_1_6

		if var_2.GetSpWeapon(var_2_6) then
			getProxy = var_2
			EquipmentProxy = var_2_6

			local var_2_7 = var_2(var_2_6)
			local var_2_8 = var_2.GetSpWeaponCapacity(var_2_7)

			getProxy = var_2_7
			EquipmentProxy = var_2_10004

			local var_2_9 = var_2_7(var_2_10004)

			if var_2_8 <= var_3.GetSpWeaponCount(var_2_9) then
				pg = var_2_9

				local var_2_10 = var_2_9.TipsMgr.GetInstance()
				local var_2_11 = var_4.ShowTips

				i18n = var_2_10006

				var_2_11(var_2_10, var_2_10006("spweapon_tip_bag_no_enough"))

				return
			end
		end

		local var_2_12 = var_1_3

		var_1_7 = var_2.getShipById(var_2_12, var_1_1)

		local var_2_14

		if var_1_7 == nil then
			pg = var_2_14

			local var_2_13 = var_2_14.TipsMgr.GetInstance()

			var_2_14 = var_2_14.ShowTips
			i18n = var_4

			var_2_14(var_2_13, var_4("ship_error_noShip", var_1_1))

			return
		end

		ShipStatus = var_2_14

		local var_2_15, var_2_16 = var_2_14.ShipStatusCheck("onModify", var_1_7)
		local var_2_17 = var_2_16

		if not var_2_15 then
			pg = var_2_15

			local var_2_18 = var_2_15.TipsMgr.GetInstance()

			var_2_15.ShowTips(var_2_18, var_2_17)

			return
		end

		ShipStatus = var_2_15

		local var_2_19, var_2_20 = var_2_15.ShipStatusCheck("onModify", var_1_7)

		if not var_2_19 then
			pg = var_4

			local var_2_21 = var_4.TipsMgr.GetInstance()

			var_4.ShowTips(var_2_21, var_2_20)
		end

		local var_2_22 = var_1_7

		var_1_5 = var_4.GetSpWeapon(var_2_22)

		if var_1_5 then
			local var_2_23 = var_1_5

			if var_4.GetUID(var_2_23) ~= var_1_2 then
				pg = var_4

				local var_2_24 = var_4.TipsMgr.GetInstance()
				local var_2_25 = var_4.ShowTips

				i18n = var_2_10006

				var_2_25(var_2_24, var_2_10006("ship_equipToShip_error_noEquip"))

				return
			end

			local var_2_26 = var_1_6
			local var_2_27, var_2_28 = var_4.CanEquipSpWeapon(var_2_26, var_1_5)

			if not var_2_27 then
				pg = var_6

				local var_2_29 = var_6.TipsMgr.GetInstance()

				var_6.ShowTips(var_2_29, var_2_28)

				return
			end

			return true
		end
	end)() then
		return
	end

	seriesAsync = var_12

	var_12({
		function(arg_3_0)
			pg = var_2_10001

			local var_3_0 = var_2_10001.MsgboxMgr.GetInstance()
			local var_3_1 = var_1.ShowMsgBox
			local var_3_2 = {}

			i18n = var_2_10004

			local var_3_3 = "ship_equip_exchange_tip"
			local var_3_4 = var_1_7
			local var_3_5 = var_6.getName(var_3_4)
			local var_3_6 = var_1_5
			local var_3_7 = var_7.GetName(var_3_6)
			local var_3_8 = var_1_6

			var_3_2.content = var_2_10004(var_3_3, var_3_5, var_3_7, var_8.getName(var_3_8))
			var_3_2.onYes = arg_3_0

			var_3_1(var_3_0, var_3_2)

			return
		end,
		function(arg_4_0)
			pg = var_2_10001

			local var_4_0 = var_2_10001.ConnectionMgr.GetInstance()

			var_1.Send(var_4_0, 14201, {
				spweapon_id = 0,
				ship_id = var_1_1
			}, 14202, function(arg_5_0)
				if arg_5_0.result == 0 then
					local var_5_0 = var_1_3

					var_3_10003 = var_1.getShipById(var_5_0, var_1_1)

					local var_5_1 = var_1.GetSpWeapon(var_3_10003)

					var_1:UpdateSpWeapon(nil)

					local var_5_2 = var_1_3

					var_3_10003.updateShip(var_5_2, var_1)

					local var_5_3 = var_1_4

					var_3_10003.AddSpWeapon(var_5_3, var_5_1)
					arg_4_0(var_5_1:GetUID())
				else
					pg = var_1

					local var_5_4 = var_1.TipsMgr.GetInstance()
					local var_5_5 = var_1.ShowTips

					errorTip = var_3_10003

					var_5_5(var_5_4, var_3_10003("ship_unequipFromShip", arg_5_0.result))
				end

				return
			end)

			return
		end,
		function(arg_6_0, arg_6_1)
			pg = var_2_10002

			local var_6_0 = var_2_10002.ConnectionMgr.GetInstance()

			var_2.Send(var_6_0, 14201, {
				spweapon_id = arg_6_1,
				ship_id = var_1_0
			}, 14202, function(arg_7_0)
				if arg_7_0.result == 0 then
					local var_7_0 = var_1_3

					var_3_10003 = var_1.getShipById(var_7_0, var_1_0)

					if var_1.GetSpWeapon(var_3_10003) then
						local var_7_1 = var_1_4

						var_3_10003.AddSpWeapon(var_7_1, var_2)
					end

					local var_7_2 = var_1_4

					var_3_10003 = var_3_10003.GetSpWeaponByUid(var_7_2, arg_6_1)

					var_1:UpdateSpWeapon(var_3_10003)

					local var_7_3 = var_1_3

					var_4.updateShip(var_7_3, var_1)

					local var_7_4 = var_1_4

					var_4.RemoveSpWeapon(var_7_4, var_3_10003)

					local var_7_5 = arg_1_0
					local var_7_6 = var_4.sendNotification

					GAME = var_6

					var_7_6(var_7_5, var_6.EQUIP_SPWEAPON_TO_SHIP_DONE, var_1)

					pg = var_7_6

					local var_7_7 = var_7_6.TipsMgr.GetInstance()
					local var_7_8 = var_4.ShowTips

					i18n = var_6

					var_7_8(var_7_7, var_6("ship_equipToShip_ok", var_3_10003:GetName()), "green")
				else
					pg = var_1

					local var_7_9 = var_1.TipsMgr.GetInstance()
					local var_7_10 = var_1.ShowTips

					errorTip = var_3_10003

					var_7_10(var_7_9, var_3_10003("ship_equipToShip", arg_7_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return var_0_1
