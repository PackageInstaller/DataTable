class = var_0_10000

local var_0_0 = "EquipFromShipCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().equipmentId
	local var_1_1 = var_2.shipId
	local var_1_2 = var_2.pos
	local var_1_3 = var_2.oldShipId
	local var_1_4 = var_2.oldPos

	getProxy = var_1_10008
	BayProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)

	getProxy = var_1_10009
	EquipmentProxy = var_1_10010

	local var_1_6 = var_1_10009(var_1_10010)
	local var_1_7 = var_1_5

	if not var_1_5.getShipById(var_1_7, var_1_1) then
		pg = var_1_7

		local var_1_8 = var_1_7.TipsMgr.GetInstance()
		local var_1_9 = var_11.ShowTips

		i18n = var_1_10013

		var_1_9(var_1_8, var_1_10013("ship_error_noShip", var_1_1))

		return
	end

	local var_1_10 = var_10

	if var_10.getEquip(var_1_10, var_1_2) then
		getProxy = var_11
		PlayerProxy = var_1_10

		local var_1_11 = var_11(var_1_10)
		local var_1_12 = var_11.getData(var_1_11)
		local var_1_13 = var_1_6:getCapacity()

		var_1_10014 = var_1_12

		if var_1_12.getMaxEquipmentBag(var_1_10014) <= var_1_13 then
			NoPosMsgBox = var_13
			i18n = var_1_10014
			var_1_10014 = var_1_10014("switch_to_shop_tip_noPos")
			openDestroyEquip = var_1_10015
			gotoChargeScene = var_1_10016

			var_13(var_1_10014, var_1_10015, var_1_10016)

			return
		end
	end

	local var_1_14 = var_1_5

	if not var_1_5.getShipById(var_1_14, var_1_3) then
		pg = var_1_14

		local var_1_15 = var_1_14.TipsMgr.GetInstance()
		local var_1_16 = var_12.ShowTips

		i18n = var_1_10014

		var_1_16(var_1_15, var_1_10014("ship_error_noShip", var_1_3))

		return
	end

	local var_1_17 = var_11

	if not var_11.getEquip(var_1_17, var_1_4) then
		pg = var_1_17

		local var_1_18 = var_1_17.TipsMgr.GetInstance()
		local var_1_19 = var_13.ShowTips

		i18n = var_1_10015

		var_1_19(var_1_18, var_1_10015("ship_equipToShip_error_noEquip"))

		return
	end

	local var_1_20, var_1_21 = var_10:canEquipAtPos(var_12, var_1_2)
	local var_1_22

	if not var_1_20 then
		pg = var_15
		var_1_22 = var_15.TipsMgr.GetInstance()

		var_15.ShowTips(var_1_22, var_1_21)

		return
	end

	local var_1_23 = {}

	table = var_1_22

	var_1_22.insert(var_1_23, function(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.MsgboxMgr.GetInstance()
		local var_2_1 = var_1.ShowMsgBox
		local var_2_2 = {}

		i18n = var_2_10004

		local var_2_3 = "ship_equip_exchange_tip"
		local var_2_4 = var_0
		local var_2_5 = var_6.getName(var_2_4)
		local var_2_6 = var_0
		local var_2_7 = var_7.getConfig(var_2_6, "name")
		local var_2_8 = var_0

		var_2_2.content = var_2_10004(var_2_3, var_2_5, var_2_7, var_8.getName(var_2_8))
		var_2_2.onYes = arg_2_0

		var_2_1(var_2_0, var_2_2)

		return
	end)

	table = var_16

	var_16.insert(var_1_23, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.ConnectionMgr.GetInstance()

		var_1.Send(var_3_0, 12006, {
			type = 0,
			equip_id = 0,
			ship_id = var_1_3,
			pos = var_1_4
		}, 12007, function(arg_4_0)
			local var_4_1

			if arg_4_0.result == 0 then
				local var_4_0 = var_0

				var_4_1 = var_4_1.getEquip(var_4_0, var_1_4)
				var_3_10003 = var_0

				var_2.updateEquip(var_3_10003, var_1_4, nil)

				var_3_10003 = var_1_5

				var_2.updateShip(var_3_10003, var_0)

				if var_0.id == var_0.id then
					var_0 = var_0
				end

				var_3_10003 = var_1_6

				var_2.addEquipment(var_3_10003, var_4_1)
				arg_3_0(var_0, var_1_0, var_1_1, var_1_2)
			else
				pg = var_4_1

				local var_4_2 = var_4_1.TipsMgr.GetInstance()
				local var_4_3 = var_1.ShowTips

				errorTip = var_3_10003

				var_4_3(var_4_2, var_3_10003("ship_unequipFromShip", arg_4_0.result))
			end

			return
		end)

		return
	end)

	seriesAsync = var_16

	var_16(var_1_23, function(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0 = var_1_6
		local var_5_1 = var_4.getEquipmentById(var_5_0, arg_5_1)

		var_5_1.count = 1
		assert = var_5

		var_5(var_5_1 and var_5_1.count > 0)

		pg = var_5

		local var_5_2 = var_5.ConnectionMgr.GetInstance()

		var_5.Send(var_5_2, 12006, {
			type = 0,
			equip_id = arg_5_1,
			ship_id = arg_5_2,
			pos = arg_5_3
		}, 12007, function(arg_6_0)
			local var_6_1

			if arg_6_0.result == 0 then
				local var_6_0 = arg_5_0

				var_6_1 = var_6_1.getEquip(var_6_0, arg_5_3)
				pg = var_6_0

				local var_6_2 = var_6_0.equip_skin_template

				if var_6_1 then
					local var_6_3 = var_1_6

					var_3_10003.addEquipment(var_6_3, var_6_1)
				end

				local var_6_4 = arg_5_0

				var_3_10003.updateEquip(var_6_4, arg_5_3, var_5_1)

				local var_6_5 = var_1_5

				var_3_10003.updateShip(var_6_5, arg_5_0)

				local var_6_6 = var_1_6

				var_3_10003.removeEquipmentById(var_6_6, arg_5_1, 1)

				local var_6_7 = arg_1_0

				var_3_10003 = var_3_10003.sendNotification
				GAME = var_5

				var_3_10003(var_6_7, var_5.EQUIP_TO_SHIP_DONE, arg_5_0)

				pg = var_3_10003

				local var_6_8 = var_3_10003.TipsMgr.GetInstance()

				var_3_10003 = var_3_10003.ShowTips
				i18n = var_5

				local var_6_9 = "ship_equipToShip_ok"

				Equipment = var_3_10007

				var_3_10003(var_6_8, var_5(var_6_9, var_3_10007.getConfigData(arg_5_1).name), "green")
			else
				pg = var_6_1

				local var_6_10 = var_6_1.TipsMgr.GetInstance()
				local var_6_11 = var_1.ShowTips

				errorTip = var_3_10003

				var_6_11(var_6_10, var_3_10003("ship_equipToShip", arg_6_0.result))
			end

			return
		end)

		return
	end)

	return
end

return var_0_1
