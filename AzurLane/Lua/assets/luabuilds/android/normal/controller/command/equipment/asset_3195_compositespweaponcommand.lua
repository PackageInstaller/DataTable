class = var_0_10000

local var_0_0 = "CompositeSpWeaponCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.consumeItems
	local var_1_2 = var_2.consumeSpweapons

	getProxy = var_1_10006
	BagProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	getProxy = var_1_10007
	PlayerProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)

	getProxy = var_1_10008
	EquipmentProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)

	getProxy = var_1_10009
	BayProxy = var_1_10010

	local var_1_6 = var_1_10009(var_1_10010)
	local var_1_7 = var_1_0
	local var_1_8 = 0
	local var_1_9 = 0
	local var_1_10 = 0
	local var_1_11 = 0
	local var_1_12 = {}

	seriesAsync = var_1_10016

	var_1_10016({
		function(arg_2_0)
			local var_2_0 = var_1_3
			local var_2_1 = var_1.getRawData(var_2_0)
			local var_2_2 = var_1_4
			local var_2_3 = var_2.getData(var_2_2)

			SpWeapon = var_2_2
			var_1_8 = var_2_2.CalculateHistoryPt(var_1_1, var_1_2)

			local var_2_4 = 0

			local function var_2_5(arg_3_0)
				ipairs = var_3_10001

				for iter_3_0, iter_3_1 in var_3_10001(arg_3_0) do
					local var_3_0 = iter_3_1[1]

					underscore = var_3_10007

					if not var_3_10007.detect(var_1_12, function(arg_4_0)
						return arg_4_0.id == var_3_0
					end) then
						Item = var_8
						var_3_10007 = var_8.New({
							id = var_3_0
						})
						var_3_10007.count = 0
						table = var_8

						var_8.insert(var_1_12, var_3_10007)
					end

					var_3_10007.count = var_3_10007.count + iter_3_1[2]
				end

				return
			end

			SpWeapon = var_5

			local var_2_6 = var_5.New({
				id = var_1_7
			})
			local var_2_7 = var_5.GetUpgradeConfig(var_2_6)

			var_1_10 = var_1_10 + var_2_7.create_use_pt

			var_2_5(var_2_7.create_use_item)

			var_1_11 = var_1_11 + var_2_7.create_use_gold

			if var_1_8 >= var_1_10 then
				while true do
					SpWeapon = var_7
					var_2_10009 = var_7.New({
						id = var_1_7
					})

					if var_7.GetNextUpgradeID(var_2_10009) == 0 then
						break
					end

					var_2_10009 = var_7:GetUpgradeConfig()
					var_1_9 = var_1_10
					var_1_10 = var_1_10 + var_2_10009.upgrade_use_pt
					SpWeapon = var_10

					local var_2_8 = var_10.New({
						id = var_8
					})

					if 0 < var_2_4 then
						var_2_10011 = var_2_8:GetRarity()
						var_2_10013 = var_7

						if var_2_10011 > var_7.GetRarity(var_2_10013) then
							break
						end
					end

					if var_1_8 < var_1_10 then
						break
					end

					var_2_5(var_2_10009.upgrade_use_item)

					var_1_11 = var_1_11 + var_2_10009.upgrade_use_gold
					var_2_4 = var_2_4 + 1
					var_1_7 = var_8
					var_2_10011 = var_2_8:GetRarity()
					var_2_10013 = var_7

					if var_2_10011 > var_7.GetRarity(var_2_10013) then
						var_1_9 = var_1_10

						break
					end
				end
			else
				pg = var_7

				local var_2_9 = var_7.TipsMgr.GetInstance()
				local var_2_10 = var_7.ShowTips

				i18n = var_2_10009

				var_2_10(var_2_9, var_2_10009("spweapon_tip_creatept_no_enough"))

				return
			end

			local var_2_11 = var_1_8 - var_1_10

			math = var_8
			var_1_8 = var_8.min(var_1_8, var_1_10)
			getProxy = var_8
			EquipmentProxy = var_9

			local var_2_12 = var_8(var_9)
			local var_2_13 = var_8.GetSpWeaponCapacity(var_2_12)

			getProxy = var_2_12
			EquipmentProxy = var_10

			local var_2_14 = var_2_12(var_10)

			if var_2_13 <= var_9.GetSpWeaponCount(var_2_14) then
				NoPosMsgBox = var_2_14
				i18n = var_2_10011

				local var_2_15 = var_2_10011("switch_to_shop_tip_noPos")

				OpenSpWeaponPage = var_12
				gotoChargeScene = var_2_10013

				var_2_14(var_2_15, var_12, var_2_10013)

				return
			end

			if var_2_3.gold < var_1_11 then
				GoShoppingMsgBox = var_10
				i18n = var_11

				local var_2_16 = "switch_to_shop_tip_2"

				i18n = var_2_10013

				local var_2_17 = var_11(var_2_16, var_2_10013("word_gold"))

				ChargeScene = var_2_16

				var_10(var_2_17, var_2_16.TYPE_ITEM, {
					{
						59001,
						var_1_11 - var_2_3.gold,
						var_1_11
					}
				})

				return
			end

			_ = var_10

			local var_2_19

			if not var_10.all(var_1_12, function(arg_5_0)
				local var_5_0 = arg_5_0.count
				local var_5_1

				if not var_2_1[arg_5_0.id] or not var_2_1[arg_5_0.id].count then
					var_5_1 = 0
				end

				return var_5_0 <= var_5_1
			end) then
				pg = var_2_19

				local var_2_18 = var_2_19.TipsMgr.GetInstance()

				var_2_19 = var_2_19.ShowTips
				i18n = var_12

				var_2_19(var_2_18, var_12("spweapon_tip_materal_no_enough"))

				return
			end

			_ = var_2_19

			local var_2_21

			if not var_2_19.all(var_1_1, function(arg_6_0)
				local var_6_0 = arg_6_0.count
				local var_6_1

				if not var_2_1[arg_6_0.id] or not var_2_1[arg_6_0.id].count then
					var_6_1 = 0
				end

				return var_6_0 <= var_6_1
			end) then
				pg = var_2_21

				local var_2_20 = var_2_21.TipsMgr.GetInstance()

				var_2_21 = var_2_21.ShowTips
				i18n = var_12

				var_2_21(var_2_20, var_12("spweapon_tip_materal_no_enough"))

				return
			end

			_ = var_2_21

			if not var_2_21.all(var_1_2, function(arg_7_0)
				if arg_7_0:GetShipId() then
					local var_7_0 = var_1_6
					local var_7_1 = var_2.getShipById(var_7_0, var_1)
					local var_7_2

					var_7_2 = var_2.GetSpWeapon(var_7_1) and var_3:GetUID() == arg_7_0:GetUID()

					return var_7_2
				else
					local var_7_3 = var_1_5

					return var_2.GetSpWeaponByUid(var_7_3, arg_7_0:GetUID())
				end

				return
			end) then
				pg = var_10

				local var_2_22 = var_10.TipsMgr.GetInstance()
				local var_2_23 = var_10.ShowTips

				i18n = var_12

				var_2_23(var_2_22, var_12("spweapon_tip_materal_no_enough"))

				return
			end

			if 0 < var_2_11 then
				pg = var_10

				local var_2_24 = var_10.MsgboxMgr.GetInstance()
				local var_2_25 = var_10.ShowMsgBox
				local var_2_26 = {}

				i18n = var_2_10013
				var_2_26.content = var_2_10013("spweapon_tip_breakout_overflow", var_2_11)
				var_2_26.onYes = arg_2_0

				var_2_25(var_2_24, var_2_26)
			else
				arg_2_0()
			end

			return
		end,
		function(arg_8_0)
			_ = var_2_10001

			local var_8_0 = var_2_10001.reduce(var_1_1, {}, function(arg_9_0, arg_9_1)
				for iter_9_0 = 1, arg_9_1.count do
					table = var_3_10006

					var_3_10006.insert(arg_9_0, arg_9_1.id)
				end

				return arg_9_0
			end)

			_ = var_2

			local var_8_1 = var_2.map(var_1_2, function(arg_10_0)
				return arg_10_0:GetUID()
			end)

			pg = var_3

			local var_8_2 = var_3.ConnectionMgr.GetInstance()

			var_3.Send(var_8_2, 14209, {
				template_id = var_1_0,
				item_id_list = var_8_0,
				spweapon_id_list = var_8_1
			}, 14210, function(arg_11_0)
				local var_11_0

				if arg_11_0.result == 0 then
					SpWeapon = var_11_0
					var_11_0 = var_11_0.CreateByNet(arg_11_0.spweapon)
					var_3_10003 = var_1_4

					local var_11_1 = var_2.getData(var_3_10003)

					var_2.consume(var_11_1, {
						gold = var_1_11
					})

					local var_11_2 = var_1_4

					var_3_10003.updatePlayer(var_11_2, var_2)

					_ = var_3_10003

					var_3_10003.each(var_1_12, function(arg_12_0)
						local var_12_0 = var_1_3

						var_1.removeItemById(var_12_0, arg_12_0.id, arg_12_0.count)

						return
					end)

					_ = var_3_10003

					var_3_10003.each(var_1_1, function(arg_13_0)
						local var_13_0 = var_1_3

						var_1.removeItemById(var_13_0, arg_13_0.id, arg_13_0.count)

						return
					end)

					_ = var_3_10003

					var_3_10003.each(var_1_2, function(arg_14_0)
						if arg_14_0:GetShipId() then
							local var_14_0 = var_1_6
							local var_14_1 = var_2.getShipById(var_14_0, var_1)

							var_2.UpdateSpWeapon(var_14_1, nil)

							local var_14_2 = var_1_6

							var_3.updateShip(var_14_2, var_2)
						else
							local var_14_3 = var_1_5

							var_2.RemoveSpWeapon(var_14_3, arg_14_0)
						end

						return
					end)

					local var_11_3 = var_1_5

					var_3_10003.AddSpWeapon(var_11_3, var_11_0)

					local var_11_4 = arg_1_0

					var_3_10003 = var_3_10003.sendNotification
					GAME = var_5

					var_3_10003(var_11_4, var_5.COMPOSITE_SPWEAPON_DONE, var_11_0)

					pg = var_3_10003

					local var_11_5 = var_3_10003.TipsMgr.GetInstance()

					var_3_10003 = var_3_10003.ShowTips
					i18n = var_5

					var_3_10003(var_11_5, var_5("spweapon_tip_create_sussess", var_11_0:GetName()))
				else
					pg = var_11_0

					local var_11_6 = var_11_0.TipsMgr.GetInstance()
					local var_11_7 = var_1.ShowTips

					errorTip = var_3_10003

					var_11_7(var_11_6, var_3_10003("equipment_compositeEquipment", arg_11_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return var_0_1
