class = var_0_10000

local var_0_0 = "ReforgeSpWeaponCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1:getBody().uid then
		var_1_0 = 0
	end

	local var_1_1

	if not var_2.shipId then
		var_1_1 = 0
	end

	getProxy = var_1_10005
	BagProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = 0

	if not (function()
		EquipmentProxy = var_2_10000

		local var_2_0, var_2_1 = var_2_10000.StaticGetSpWeapon(var_1_1, var_1_0)
		local var_2_2 = var_2_0
		local var_2_3 = var_2_0.GetAttributeOptions(var_2_2)

		_ = var_2_2

		if not var_2_2.all(var_2_3, function(arg_3_0)
			return arg_3_0 == 0
		end) then
			pg = var_3

			local var_2_4 = var_3.TipsMgr.GetInstance()
			local var_2_5 = var_3.ShowTips

			i18n = var_5

			var_2_5(var_2_4, var_5("spweapon_tip_attr_modify"))

			return
		end

		local var_2_6 = var_1_2
		local var_2_7 = var_3.getRawData(var_2_6)
		local var_2_8 = var_1_3
		local var_2_9 = var_4.getData(var_2_8)
		local var_2_10 = var_2_0
		local var_2_11 = var_2_0.GetUpgradeConfig(var_2_10)

		_ = var_2_10

		if not var_2_10.all(var_2_11.reset_use_item, function(arg_4_0)
			local var_4_0 = arg_4_0[2]
			local var_4_1

			if not var_2_7[arg_4_0[1]] or not var_2_7[arg_4_0[1]].count then
				var_4_1 = 0
			end

			return var_4_0 <= var_4_1
		end) then
			pg = var_6

			local var_2_12 = var_6.TipsMgr.GetInstance()
			local var_2_13 = var_6.ShowTips

			i18n = var_8

			var_2_13(var_2_12, var_8("spweapon_tip_materal_no_enough"))

			return
		end

		local var_2_14 = var_2_0:GetBaseAttributes()
		local var_2_15 = var_2_0
		local var_2_16 = var_2_0.GetAttributesRange(var_2_15)

		table = var_2_15

		if var_2_15.equal(var_2_14, var_2_16) then
			pg = var_8

			local var_2_17 = var_8.TipsMgr.GetInstance()
			local var_2_18 = var_8.ShowTips

			i18n = var_10

			var_2_18(var_2_17, var_10("spweapon_tip_transform_attrmax"))

			return
		end

		return true
	end)() then
		return
	end

	pg = var_9

	local var_1_5 = var_9.ConnectionMgr.GetInstance()

	var_9.Send(var_1_5, 14205, {
		ship_id = var_1_1,
		spweapon_id = var_1_0
	}, 14206, function(arg_5_0)
		local var_5_0

		if arg_5_0.result == 0 then
			EquipmentProxy = var_5_0

			local var_5_1

			var_5_0, var_5_1 = var_5_0.StaticGetSpWeapon(var_1_1, var_1_0)

			local var_5_2 = var_5_0

			var_5_0.SetAttributeOptions(var_5_2, {
				arg_5_0.attr_temp_1,
				arg_5_0.attr_temp_2
			})

			if var_5_1 then
				var_5_2 = var_5_1

				var_5_1.UpdateSpWeapon(var_5_2, var_5_0)

				getProxy = var_2_10003
				BayProxy = var_5_2
				var_5_2 = var_2_10003(var_5_2)

				var_2_10003.updateShip(var_5_2, var_5_1)
			else
				getProxy = var_2_10003
				EquipmentProxy = var_5_2

				local var_5_3 = var_2_10003(var_5_2)

				var_2_10003.AddSpWeapon(var_5_3, var_5_0)
			end

			local var_5_4 = var_5_0

			var_2_10003 = var_5_0.GetUpgradeConfig(var_5_4)
			_ = var_5_4

			var_5_4.each(var_2_10003.reset_use_item, function(arg_6_0)
				local var_6_0 = var_1_2

				var_1.removeItemById(var_6_0, arg_6_0[1], arg_6_0[2])

				return
			end)

			local var_5_5 = arg_1_0
			local var_5_6 = var_4.sendNotification

			GAME = var_6

			var_5_6(var_5_5, var_6.REFORGE_SPWEAPON_DONE, var_5_0)
		else
			pg = var_5_0

			local var_5_7 = var_5_0.TipsMgr.GetInstance()
			local var_5_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_5_8(var_5_7, var_2_10003("common", arg_5_0.result))
		end

		return
	end)

	return
end

return var_0_1
