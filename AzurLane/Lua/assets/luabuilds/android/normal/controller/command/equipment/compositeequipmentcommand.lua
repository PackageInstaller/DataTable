class = var_0_10000

local var_0_0 = "CompositeEquipmentCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().count
	local var_1_1 = var_2.id

	getProxy = var_1_10005
	BagProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getData(var_1_2)

	getProxy = var_1_2
	PlayerProxy = var_1_10008

	local var_1_4 = var_1_2(var_1_10008)
	local var_1_5 = var_7.getData(var_1_4)

	pg = var_1_4

	local var_1_6 = var_1_4.compose_data_template[var_1_1]

	getProxy = var_1_10010
	EquipmentProxy = var_1_10011

	local var_1_7 = var_1_10010(var_1_10011)
	local var_1_8 = var_10.getCapacity(var_1_7)

	if var_1_5:getMaxEquipmentBag() < var_1_8 + var_1_0 then
		NoPosMsgBox = var_12
		i18n = var_13

		local var_1_9 = var_13("switch_to_shop_tip_noPos")

		openDestroyEquip = var_1_10014
		gotoChargeScene = var_1_10015

		var_12(var_1_9, var_1_10014, var_1_10015)

		return
	end

	if var_1_5.gold < var_1_6.gold_num * var_1_0 then
		GoShoppingMsgBox = var_12
		i18n = var_13
		var_1_10014 = "switch_to_shop_tip_2"
		i18n = var_1_10015

		local var_1_10 = var_13(var_1_10014, var_1_10015("word_gold"))

		ChargeScene = var_1_10014

		var_12(var_1_10, var_1_10014.TYPE_ITEM, {
			{
				59001,
				var_1_6.gold_num * var_1_0 - var_1_5.gold,
				var_1_6.gold_num * var_1_0
			}
		})

		return
	end

	if not var_1_3[var_1_6.material_id] then
		pg = var_12

		local var_1_11 = var_12.TipsMgr.GetInstance()
		local var_1_12 = var_12.ShowTips

		i18n = var_1_10014

		var_1_12(var_1_11, var_1_10014("word_materal_no_enough"))

		return
	end

	local var_1_14

	if var_1_3[var_1_6.material_id].count < var_1_6.material_num * var_1_0 then
		pg = var_1_14

		local var_1_13 = var_1_14.TipsMgr.GetInstance()

		var_1_14 = var_1_14.ShowTips
		i18n = var_1_10014

		var_1_14(var_1_13, var_1_10014("word_materal_no_enough"))

		return
	end

	pg = var_1_14

	local var_1_15 = var_1_14.ConnectionMgr.GetInstance()

	var_12.Send(var_1_15, 14006, {
		id = var_1_1,
		num = var_1_0
	}, 14007, function(arg_2_0)
		local var_2_5

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_5.addEquipmentById(var_2_0, var_1_6.equip_id, var_1_0)

			local var_2_1 = var_1_5

			var_2_5.consume(var_2_1, {
				gold = var_1_6.gold_num * var_1_0
			})

			local var_2_2 = var_0

			var_2_5.updatePlayer(var_2_2, var_1_5)

			local var_2_3 = var_0

			var_2_5.removeItemById(var_2_3, var_1_6.material_id, var_1_6.material_num * var_1_0)

			local var_2_4 = arg_1_0

			var_2_5 = var_2_5.sendNotification
			GAME = var_2_10003
			var_2_10003 = var_2_10003.COMPOSITE_EQUIPMENT_DONE

			local var_2_6 = {}

			Equipment = var_5
			var_2_6.equipment = var_5.New({
				id = var_1_6.equip_id
			})
			var_2_6.count = var_1_0
			var_2_6.composeId = var_1_1

			var_2_5(var_2_4, var_2_10003, var_2_6)
		else
			pg = var_2_5

			local var_2_7 = var_2_5.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_8(var_2_7, var_2_10003("equipment_compositeEquipment", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
