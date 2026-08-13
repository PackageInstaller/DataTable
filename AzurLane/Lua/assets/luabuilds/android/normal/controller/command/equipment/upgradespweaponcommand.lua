class = var_0_10000

local var_0_0 = "UpgradeSpWeaponCommand"

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

	local var_1_2 = var_2.items
	local var_1_3 = var_2.consumes

	getProxy = var_1_10007
	BagProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)

	getProxy = var_1_10008
	PlayerProxy = var_1_10009

	local var_1_5 = var_1_10008(var_1_10009)

	getProxy = var_1_10009
	BayProxy = var_1_10010

	local var_1_6 = var_1_10009(var_1_10010)

	getProxy = var_1_10010
	EquipmentProxy = var_1_10011

	local var_1_7 = var_1_10010(var_1_10011)
	local var_1_8
	local var_1_9 = 0
	local var_1_10 = 0
	local var_1_11 = 0
	local var_1_12 = 0
	local var_1_13 = {}

	seriesAsync = var_1_10017

	var_1_10017({
		function(arg_2_0)
			EquipmentProxy = var_2_10001

			local var_2_0, var_2_1 = var_2_10001.StaticGetSpWeapon(var_1_1, var_1_0)

			var_1_9 = var_2_0:GetPt()
			SpWeapon = var_3

			local var_2_2 = var_3.CalculateHistoryPt(var_1_2, var_1_3)

			var_1_9 = var_1_9 + var_2_2

			local var_2_3 = 0

			local function var_2_4(arg_3_0)
				ipairs = var_3_10001

				for iter_3_0, iter_3_1 in var_3_10001(arg_3_0) do
					local var_3_0 = iter_3_1[1]

					underscore = var_3_10007

					if not var_3_10007.detect(var_1_13, function(arg_4_0)
						return arg_4_0.id == var_3_0
					end) then
						Item = var_8
						var_3_10007 = var_8.New({
							id = var_3_0
						})
						var_3_10007.count = 0
						table = var_8

						var_8.insert(var_1_13, var_3_10007)
					end

					var_3_10007.count = var_3_10007.count + iter_3_1[2]
				end

				return
			end

			var_1_8 = var_2_0:GetConfigID()

			while true do
				SpWeapon = var_6

				local var_2_5 = var_6.New({
					id = var_1_8
				})

				if var_6.GetNextUpgradeID(var_2_5) == 0 then
					break
				end

				local var_2_6 = var_6:GetUpgradeConfig()

				var_1_10 = var_1_11
				var_1_11 = var_1_11 + var_2_6.upgrade_use_pt
				SpWeapon = var_9

				local var_2_7 = var_9.New({
					id = var_7
				})

				if var_2_3 > 0 then
					local var_2_8 = var_2_7:GetRarity()

					var_2_10012 = var_6

					if var_2_8 > var_6.GetRarity(var_2_10012) then
						break
					end
				end

				if var_1_9 < var_1_11 then
					break
				end

				var_2_4(var_2_6.upgrade_use_item)

				var_1_12 = var_1_12 + var_2_6.upgrade_use_gold
				var_2_3 = var_2_3 + 1
				var_1_8 = var_7

				local var_2_9 = var_2_7:GetRarity()

				var_2_10012 = var_6

				if var_2_9 > var_6.GetRarity(var_2_10012) then
					var_1_10 = var_1_11

					break
				end
			end

			local var_2_10 = var_1_9 - var_1_11

			math = var_7
			var_1_9 = var_7.min(var_1_9, var_1_11)

			if var_2_2 == 0 and var_2_3 == 0 then
				pg = var_7

				local var_2_11 = var_7.TipsMgr.GetInstance()
				local var_2_12 = var_7.ShowTips

				i18n = var_9

				var_2_12(var_2_11, var_9("spweapon_tip_pt_no_enough"))

				return
			end

			local var_2_13 = var_1_4
			local var_2_14 = var_7.getRawData(var_2_13)
			local var_2_15 = var_1_5

			if var_8.getRawData(var_2_15).gold < var_1_12 then
				GoShoppingMsgBox = var_9
				i18n = var_10

				local var_2_16 = "switch_to_shop_tip_2"

				i18n = var_2_10012

				local var_2_17 = var_10(var_2_16, var_2_10012("word_gold"))

				ChargeScene = var_2_16

				var_9(var_2_17, var_2_16.TYPE_ITEM, {
					{
						59001,
						var_1_12 - var_8.gold,
						var_1_12
					}
				})

				return
			end

			_ = var_9

			local var_2_19

			if not var_9.all(var_1_13, function(arg_5_0)
				local var_5_0 = arg_5_0.count
				local var_5_1

				if not var_2_14[arg_5_0.id] or not var_2_14[arg_5_0.id].count then
					var_5_1 = 0
				end

				return var_5_0 <= var_5_1
			end) then
				pg = var_2_19

				local var_2_18 = var_2_19.TipsMgr.GetInstance()

				var_2_19 = var_2_19.ShowTips
				i18n = var_11

				var_2_19(var_2_18, var_11("spweapon_tip_materal_no_enough"))

				return
			end

			_ = var_2_19

			local var_2_21

			if not var_2_19.all(var_1_2, function(arg_6_0)
				local var_6_0 = arg_6_0.count
				local var_6_1

				if not var_2_14[arg_6_0.id] or not var_2_14[arg_6_0.id].count then
					var_6_1 = 0
				end

				return var_6_0 <= var_6_1
			end) then
				pg = var_2_21

				local var_2_20 = var_2_21.TipsMgr.GetInstance()

				var_2_21 = var_2_21.ShowTips
				i18n = var_11

				var_2_21(var_2_20, var_11("spweapon_tip_materal_no_enough"))

				return
			end

			_ = var_2_21

			if not var_2_21.all(var_1_3, function(arg_7_0)
				if arg_7_0:GetShipId() then
					local var_7_0 = var_1_6
					local var_7_1 = var_2.getShipById(var_7_0, var_1)
					local var_7_2

					var_7_2 = var_2.GetSpWeapon(var_7_1) and var_3:GetUID() == arg_7_0:GetUID()

					return var_7_2
				else
					local var_7_3 = var_1_7

					return var_2.GetSpWeaponByUid(var_7_3, arg_7_0:GetUID())
				end

				return
			end) then
				pg = var_9

				local var_2_22 = var_9.TipsMgr.GetInstance()
				local var_2_23 = var_9.ShowTips

				i18n = var_11

				var_2_23(var_2_22, var_11("spweapon_tip_materal_no_enough"))

				return
			end

			if var_2_10 > 0 and 0 < var_2_2 then
				pg = var_9

				local var_2_24 = var_9.MsgboxMgr.GetInstance()
				local var_2_25 = var_9.ShowMsgBox
				local var_2_26 = {}

				i18n = var_2_10012
				var_2_26.content = var_2_10012("spweapon_tip_breakout_overflow", var_2_10)
				var_2_26.onYes = arg_2_0

				var_2_25(var_2_24, var_2_26)
			else
				arg_2_0()
			end

			return
		end,
		function(arg_8_0)
			_ = var_2_10001

			local var_8_0 = var_2_10001.reduce(var_1_2, {}, function(arg_9_0, arg_9_1)
				for iter_9_0 = 1, arg_9_1.count do
					table = var_3_10006

					var_3_10006.insert(arg_9_0, arg_9_1.id)
				end

				return arg_9_0
			end)

			_ = var_2

			local var_8_1 = var_2.map(var_1_3, function(arg_10_0)
				return arg_10_0:GetUID()
			end)

			pg = var_3

			local var_8_2 = var_3.ConnectionMgr.GetInstance()

			var_3.Send(var_8_2, 14203, {
				ship_id = var_1_1,
				spweapon_id = var_1_0,
				item_id_list = var_8_0,
				spweapon_id_list = var_8_1
			}, 14204, function(arg_11_0)
				local var_11_0

				if arg_11_0.result == 0 then
					EquipmentProxy = var_11_0

					local var_11_1

					var_11_0, var_11_1 = var_11_0.StaticGetSpWeapon(var_1_1, var_1_0)

					local var_11_2 = var_11_0:MigrateTo(var_1_8)
					local var_11_3 = var_3_10003.SetPt

					math = var_3_10006

					var_11_3(var_11_2, var_3_10006.floor(var_1_9 - var_1_10))

					_ = var_11_3

					var_11_3.each(var_1_13, function(arg_12_0)
						local var_12_0 = var_1_4

						var_1.removeItemById(var_12_0, arg_12_0.id, arg_12_0.count)

						return
					end)

					local var_11_4 = var_1_5
					local var_11_5 = var_4.getData(var_11_4)

					var_4.consume(var_11_5, {
						gold = var_1_12
					})

					local var_11_6 = var_1_5

					var_5.updatePlayer(var_11_6, var_4)

					_ = var_5

					var_5.each(var_1_2, function(arg_13_0)
						local var_13_0 = var_1_4

						var_1.removeItemById(var_13_0, arg_13_0.id, arg_13_0.count)

						return
					end)

					_ = var_5

					var_5.each(var_1_3, function(arg_14_0)
						if arg_14_0:GetShipId() then
							local var_14_0 = var_1_6
							local var_14_1 = var_2.getShipById(var_14_0, var_1)

							var_2.UpdateSpWeapon(var_14_1, nil)

							local var_14_2 = var_1_6

							var_3.updateShip(var_14_2, var_2)
						else
							local var_14_3 = var_1_7

							var_2.RemoveSpWeapon(var_14_3, arg_14_0)
						end

						return
					end)

					local var_11_7

					if var_11_1 then
						var_11_7 = var_11_1

						var_11_1.UpdateSpWeapon(var_11_7, var_3_10003)

						getProxy = var_5
						BayProxy = var_11_7
						var_11_7 = var_5(var_11_7)

						var_5.updateShip(var_11_7, var_11_1)
					else
						getProxy = var_5
						EquipmentProxy = var_11_7

						local var_11_8 = var_5(var_11_7)

						var_5.AddSpWeapon(var_11_8, var_3_10003)
					end

					local var_11_9 = arg_1_0
					local var_11_10 = var_5.sendNotification

					GAME = var_7

					var_11_10(var_11_9, var_7.UPGRADE_SPWEAPON_DONE, var_3_10003)
				else
					pg = var_11_0

					local var_11_11 = var_11_0.TipsMgr.GetInstance()
					local var_11_12 = var_1.ShowTips

					errorTip = var_3_10003

					var_11_12(var_11_11, var_3_10003("equipment_upgrade_erro", arg_11_0.result))
				end

				return
			end)

			return
		end
	})

	return
end

return var_0_1
