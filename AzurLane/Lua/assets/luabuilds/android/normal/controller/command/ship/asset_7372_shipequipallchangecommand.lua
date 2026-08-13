class = var_0_10000

local var_0_0 = "ShipEquipAllChangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	BayProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	getProxy = var_1_10004
	EquipmentProxy = var_1_10005

	local var_1_3 = var_1_10004(var_1_10005)

	local function var_1_4(arg_2_0, arg_2_1, arg_2_2)
		return function(arg_3_0)
			pg = var_3_10001

			local var_3_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Send(var_3_0, 12006, {
				type = 0,
				ship_id = arg_2_0,
				equip_id = arg_2_1,
				pos = arg_2_2
			}, 12007, function(arg_4_0)
				if arg_4_0.result == 0 then
					local var_4_0 = var_1_2

					var_4_10003 = var_1.getShipById(var_4_0, arg_2_0)

					if var_1.getEquip(var_4_10003, arg_2_2) then
						local var_4_1 = var_1_3

						var_4_10003.addEquipment(var_4_1, var_2)
					end

					if arg_2_1 > 0 then
						local var_4_2 = var_1_3

						if not var_4_10003.getEquipmentById(var_4_2, arg_2_1) then
							var_4_10003 = nil
						end

						if var_4_10003 then
							var_4_10003.count = 1

							local var_4_3 = var_1_3

							var_4.removeEquipmentById(var_4_3, arg_2_1, 1)
						end

						var_1:updateEquip(arg_2_2, var_4_10003)

						local var_4_4 = var_1_2

						var_4.updateShip(var_4_4, var_1)

						existCall = var_4

						var_4(arg_3_0)

						if false then
							pg = var_1

							local var_4_5 = var_1.TipsMgr.GetInstance()
							local var_4_6 = var_1.ShowTips

							errorTip = var_4_10003

							var_4_6(var_4_5, var_4_10003("ship_equipToShip", arg_4_0.result))
						end

						return
					end
				end
			end)

			return
		end
	end

	local function var_1_5(arg_5_0, arg_5_1)
		return function(arg_6_0)
			pg = var_3_10001

			local var_6_0 = var_3_10001.ConnectionMgr.GetInstance()

			var_1.Send(var_6_0, 14201, {
				spweapon_id = arg_5_1,
				ship_id = arg_5_0
			}, 14202, function(arg_7_0)
				if arg_7_0.result == 0 then
					local var_7_0 = var_1_2

					var_4_10003 = var_1.getShipById(var_7_0, arg_5_0)

					if var_1.GetSpWeapon(var_4_10003) then
						local var_7_1 = var_1_3

						var_4_10003.AddSpWeapon(var_7_1, var_2)
					end

					if arg_5_1 > 0 then
						local var_7_2 = var_1_3

						if not var_4_10003.GetSpWeaponByUid(var_7_2, arg_5_1) then
							var_4_10003 = nil
						end

						if var_4_10003 then
							local var_7_3 = var_1_3

							var_4.RemoveSpWeapon(var_7_3, var_4_10003)
						end

						var_1:UpdateSpWeapon(var_4_10003)

						local var_7_4 = var_1_2

						var_4.updateShip(var_7_4, var_1)

						existCall = var_4

						var_4(arg_6_0)

						if false then
							pg = var_1

							local var_7_5 = var_1.TipsMgr.GetInstance()
							local var_7_6 = var_1.ShowTips

							errorTip = var_4_10003

							var_7_6(var_7_5, var_4_10003("ship_equipToShip", arg_7_0.result))
						end

						return
					end
				end
			end)

			return
		end
	end

	local var_1_6 = var_1_1.shipId
	local var_1_7 = var_1_2

	if not var_1_2.getShipById(var_1_7, var_1_6) then
		pg = var_1_7

		local var_1_8 = var_1_7.TipsMgr.GetInstance()
		local var_1_9 = var_9.ShowTips

		i18n = var_1_10011

		var_1_9(var_1_8, var_1_10011("ship_error_noShip", var_1_6))

		return
	end

	local var_1_10 = {}
	local var_1_11 = {}
	local var_1_12 = var_1_1.equipData
	local var_1_13 = 0
	local var_1_14 = 0

	ipairs = var_1_10014

	for iter_1_0, iter_1_1 in var_1_10014(var_1_12) do
		local var_1_15 = false

		if iter_1_0 == 6 then
			if iter_1_1 then
				var_1_15 = iter_1_1 and iter_1_1.shipId == var_1_6
			else
				var_1_15 = not var_8.spWeapon
			end

			if not var_1_15 then
				if iter_1_1 and iter_1_1.shipId then
					table = var_1_10020

					var_1_10020.insert(var_1_11, var_1_5(iter_1_1.shipId, 0))
				end

				table = var_1_10020
				var_1_10020 = var_1_10020.insert

				local var_1_16 = var_1_11
				local var_1_17 = var_1_5
				local var_1_18 = var_1_6
				local var_1_19

				if not iter_1_1 or not iter_1_1.uid then
					var_1_19 = 0
				end

				var_1_10020(var_1_16, var_1_17(var_1_18, var_1_19))

				if var_8.spWeapon or iter_1_1 and iter_1_1.shipId then
					var_1_14 = var_1_14 + 1
				end
			end
		else
			if iter_1_1 then
				var_1_15 = iter_1_1 and iter_1_1.shipId == var_1_6 and iter_1_1.shipPos == iter_1_0
			else
				var_1_15 = not var_8.equipments[iter_1_0]
			end

			if not var_1_15 then
				if var_8.equipments[iter_1_0] then
					table = var_1_10020

					var_1_10020.insert(var_1_10, var_1_4(var_1_6, 0, iter_1_0))
				end

				if iter_1_1 and iter_1_1.shipId and iter_1_1.shipId ~= var_1_6 then
					table = var_1_10020

					var_1_10020.insert(var_1_11, var_1_4(iter_1_1.shipId, 0, iter_1_1.shipPos))
				end

				table = var_1_10020
				var_1_10020 = var_1_10020.insert

				local var_1_20 = var_1_11
				local var_1_21 = var_1_4
				local var_1_22 = var_1_6
				local var_1_23

				if not iter_1_1 or not iter_1_1.id then
					var_1_23 = 0
				end

				var_1_10020(var_1_20, var_1_21(var_1_22, var_1_23, iter_1_0))

				if var_8.equipments[iter_1_0] or iter_1_1 and iter_1_1.shipId then
					var_1_13 = var_1_13 + 1
				end
			end
		end
	end

	local var_1_24

	if 0 < var_1_13 then
		getProxy = var_14
		PlayerProxy = var_1_24
		var_1_24 = var_14(var_1_24)
		var_1_24 = var_14.getData(var_1_24)

		if var_14.getMaxEquipmentBag(var_1_24) < var_1_3:getCapacity() + var_1_13 then
			NoPosMsgBox = var_14
			i18n = var_1_24
			var_1_24 = var_1_24("switch_to_shop_tip_noPos")
			openDestroyEquip = var_16
			gotoChargeScene = iter_1_0

			var_14(var_1_24, var_16, iter_1_0)

			return
		end
	end

	local var_1_25

	if 0 < var_1_14 then
		var_1_24 = var_1_3
		var_1_25 = var_1_3.GetSpWeaponCapacity(var_1_24)

		local var_1_26 = var_1_3

		if var_1_25 < var_1_3.GetSpWeaponCount(var_1_26) + var_1_14 then
			pg = var_1_25
			var_1_24 = var_1_25.TipsMgr.GetInstance()
			var_1_25 = var_1_25.ShowTips
			i18n = var_1_26

			var_1_25(var_1_24, var_1_26("spweapon_tip_bag_no_enough"))

			return
		end
	end

	seriesAsync = var_1_25
	table = var_1_24

	var_1_25(var_1_24.mergeArray(var_1_10, var_1_11), function()
		local var_8_0 = arg_1_0
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.SHIP_EQUIP_ALL_CHANGE_DONE, var_1_6)

		pg = var_8_1

		local var_8_2 = var_8_1.TipsMgr.GetInstance()
		local var_8_3 = var_0.ShowTips

		i18n = var_2

		var_8_3(var_8_2, var_2("equipcode_import_success"))

		return
	end)

	return
end

return var_0_1
