class = var_0_10000

local var_0_0 = "IslandShopOpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	IslandProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)
	local var_1_3 = var_3.GetIsland(var_1_2)
	local var_1_4 = var_3.GetShopAgency(var_1_3)

	getProxy = var_1_3
	IslandProxy = var_1_10005

	local var_1_5 = var_1_3(var_1_10005)
	local var_1_6 = var_4.GetIsland(var_1_5)
	local var_1_7 = var_4.GetInventoryAgency(var_1_6)
	local var_1_8 = var_1_1.operation

	IslandConst = var_1_10006

	local var_1_9

	if var_1_8 == var_1_10006.SHOP_GET_DATA then
		pg = var_1_8
		var_1_9 = var_1_8.ConnectionMgr.GetInstance()

		var_5.Send(var_1_9, 21016, {
			shop_id = var_1_1.shopId
		}, 21017, function(arg_2_0)
			if arg_2_0.result == 0 then
				local var_2_0 = var_1_4

				var_1.UpdateShop(var_2_0, var_1_1.shopId, arg_2_0.shop_info)

				local var_2_1 = arg_1_0
				local var_2_2 = var_1.sendNotification

				GAME = var_3

				var_2_2(var_2_1, var_3.ISLAND_SHOP_OP_DONE, {
					operation = var_1_1.operation,
					refreshAll = var_1_1.refreshAll
				})

				if var_1_1.callback then
					var_1_1.callback()
				end
			else
				local var_2_3 = var_1_4

				var_1.UpdateShop(var_2_3, var_1_1.shopId, nil)
			end

			return
		end)
	else
		local var_1_10 = var_1_1.operation

		IslandConst = var_1_9

		local var_1_11

		if var_1_10 == var_1_9.SHOP_BUY_COMMODITY then
			getProxy = var_1_10
			PlayerProxy = var_1_11
			var_1_11 = var_1_10(var_1_11)

			local var_1_12 = var_5.getData(var_1_11)

			var_1_11 = {}
			var_1_10007 = {}
			var_1_10008 = 0
			var_1_10009 = {}
			ipairs = var_1_10010

			for iter_1_0, iter_1_8 in var_1_10010(var_1_1.commodityList) do
				local var_1_13 = iter_1_8.key
				local var_1_14 = iter_1_8.value1

				var_1_10017 = iter_1_8.value2
				var_1_10019 = var_1_4
				var_1_10018 = var_1_4.GetShopCommodity(var_1_10019, var_1_13, var_1_14)
				table = var_1_10019

				var_1_10019.insert(var_1_11, var_1_10018)

				table = var_1_10019

				var_1_10019.insertto(var_1_10009, var_1_10018:GetItems())

				if not var_1_10018 then
					return
				end

				if var_1_10017 == 0 then
					return
				end

				Clone = var_1_10019

				local var_1_15 = var_1_10018

				var_1_10020 = var_1_10019(var_1_10018.GetResourceConsume(var_1_15))[3] * var_1_10017
				math = var_1_15
				var_1_10019[3] = var_1_15.ceil((100 - var_1_10018:GetDiscount()) / 100 * var_1_10020)

				local var_1_16 = false

				ipairs = var_22

				for iter_1_2, iter_1_3 in var_22(var_1_10007) do
					if iter_1_3[1] == var_1_10019[1] and iter_1_3[2] == var_1_10019[2] then
						var_1_16 = true
						iter_1_3[3] = iter_1_3[3] + var_1_10019[3]

						break
					end
				end

				if not var_1_16 then
					table = var_22

					var_22.insert(var_1_10007, var_1_10019)
				end

				pg = var_22
				var_1_10008 = var_1_10008 + var_22.island_shop_goods[var_1_14].pt_award * var_1_10017

				local var_1_17 = {}
				local var_1_18 = var_1_10018
				local var_1_19 = var_1_10018.GetItems(var_1_18)

				ipairs = var_1_18

				for iter_1_4, iter_1_5 in var_1_18(var_1_19) do
					local var_1_20 = iter_1_5[1]

					DROP_TYPE_ISLAND_ITEM = var_1_10030

					if var_1_20 ~= var_1_10030 then
						Drop = var_1_20

						local var_1_21 = var_1_20.New({
							type = iter_1_5[1],
							id = iter_1_5[2],
							count = iter_1_5[3]
						})

						table = var_1_10030

						var_1_10030.insert(var_1_17, var_1_21)
					end
				end

				GetItemsOverflowDic = var_24

				local var_1_22 = var_24(var_1_17)

				CheckOverflow = var_25

				local var_1_23, var_1_24 = var_25(var_1_22)

				if not var_1_23 then
					switch = iter_1_4

					iter_1_4(var_1_24, {
						gold = function()
							pg = var_2_10000

							local var_3_0 = var_2_10000.TipsMgr.GetInstance()
							local var_3_1 = var_0.ShowTips

							i18n = var_2_10002

							local var_3_2 = var_2_10002("gold_max_tip_title")

							i18n = var_3

							var_3_1(var_3_0, var_3_2 .. var_3("resource_max_tip_shop"))

							return
						end,
						oil = function()
							pg = var_2_10000

							local var_4_0 = var_2_10000.TipsMgr.GetInstance()
							local var_4_1 = var_0.ShowTips

							i18n = var_2_10002

							local var_4_2 = var_2_10002("oil_max_tip_title")

							i18n = var_3

							var_4_1(var_4_0, var_4_2 .. var_3("resource_max_tip_shop"))

							return
						end,
						equip = function()
							NoPosMsgBox = var_2_10000
							i18n = var_2_10001

							local var_5_0 = var_2_10001("switch_to_shop_tip_noPos")

							openDestroyEquip = var_2
							gotoChargeScene = var_2_10003

							var_2_10000(var_5_0, var_2, var_2_10003)

							return
						end,
						ship = function()
							NoPosMsgBox = var_2_10000
							i18n = var_2_10001

							local var_6_0 = var_2_10001("switch_to_shop_tip_noDockyard")

							openDockyardClear = var_2
							gotoChargeScene = var_2_10003
							openDockyardIntensify = var_2_10004

							var_2_10000(var_6_0, var_2, var_2_10003, var_2_10004)

							return
						end
					})

					return
				end

				CheckShipExpOverflow = iter_1_4

				if not iter_1_4(var_1_22) then
					pg = var_27

					local var_1_25 = var_27.MsgboxMgr.GetInstance()
					local var_1_26 = var_27.ShowMsgBox
					local var_1_27 = {}

					i18n = var_1_10030
					var_1_27.content = var_1_10030("player_expResource_mail_fullBag")
					next = var_1_10030
					var_1_27.onYes = var_1_10030

					var_1_26(var_1_25, var_1_27)

					return
				end
			end

			var_1_10010 = false
			ipairs = var_1_10011

			for iter_1_8, iter_1_7 in var_1_10011(var_1_10009) do
				local var_1_28 = iter_1_7[1]

				DROP_TYPE_ISLAND_ITEM = var_1_10017

				if var_1_28 == var_1_10017 then
					var_1_10010 = true
				end
			end

			if var_1_10010 then
				var_1_10012 = var_1_7

				if var_1_7.ExistAnyOverFlowItem(var_1_10012) then
					pg = var_1_10011
					var_1_10012 = var_1_10011.TipsMgr.GetInstance()
					var_1_10011 = var_1_10011.ShowTips
					i18n = var_13

					var_1_10011(var_1_10012, var_13("island_3Dshop_bag_max"))

					return
				end
			end

			ipairs = var_1_10011

			for iter_1_8, iter_1_9 in var_1_10011(var_1_10007) do
				local var_1_29 = iter_1_9[3]
				local var_1_30 = iter_1_9[1]

				DROP_TYPE_RESOURCE = var_1_10018

				if var_1_30 == var_1_10018 then
					id2res = var_1_30

					if var_1_12[var_1_30(iter_1_9[2])] < var_1_29 then
						Drop = var_17

						local var_1_31 = var_17.New

						var_1_10018 = {}
						DROP_TYPE_RESOURCE = var_1_10019
						var_1_10018.type = var_1_10019
						var_1_10018.id = iter_1_9[2]
						var_1_10018 = var_1_31(var_1_10018)

						local var_1_32 = var_17.getName(var_1_10018)

						if iter_1_9[2] == 1 then
							pg = var_1_10018
							var_1_10019 = var_1_10018.TipsMgr.GetInstance()
							var_1_10018 = var_1_10018.ShowTips
							i18n = var_1_10020

							var_1_10018(var_1_10019, var_1_10020("island_3Dshop_lack_gold"))
						elseif iter_1_9[2] == 4 or iter_1_9[2] == 14 then
							pg = var_1_10018
							var_1_10019 = var_1_10018.TipsMgr.GetInstance()
							var_1_10018 = var_1_10018.ShowTips
							i18n = var_1_10020

							var_1_10018(var_1_10019, var_1_10020("island_3Dshop_lack_gem"))
						else
							ItemTipPanel = var_1_10018
							var_1_10018 = var_1_10018.ShowItemTip
							DROP_TYPE_RESOURCE = var_1_10019

							if not var_1_10018(var_1_10019, iter_1_9[2]) then
								pg = var_1_10018
								var_1_10019 = var_1_10018.TipsMgr.GetInstance()
								var_1_10018 = var_1_10018.ShowTips
								i18n = var_1_10020

								var_1_10018(var_1_10019, var_1_10020("buyProp_noResource_error", var_1_32))
							end
						end

						return
					end
				else
					local var_1_33 = iter_1_9[1]

					DROP_TYPE_ISLAND_ITEM = var_1_10018

					if var_1_33 == var_1_10018 then
						var_1_10018 = var_1_7

						if var_1_7.GetOwnCount(var_1_10018, iter_1_9[2]) < var_1_29 then
							pg = var_17
							var_1_10018 = var_17.TipsMgr.GetInstance()

							local var_1_34 = var_17.ShowTips

							i18n = var_1_10019

							var_1_34(var_1_10018, var_1_10019("island_3Dshop_lack_res"))

							pg = var_1_34

							local var_1_35 = var_1_34.island_item_data_template[iter_1_9[2]].jump_page

							return
						end
					end
				end
			end

			var_1_10012 = var_1_11[1]

			if var_1_10011.GetPayId(var_1_10012) == 0 then
				pg = var_1_10011
				var_1_10012 = var_1_10011.ConnectionMgr.GetInstance()

				var_1_10011.Send(var_1_10012, 21018, {
					goods_list = var_1_1.commodityList
				}, 21019, function(arg_7_0)
					local var_7_1

					if arg_7_0.result == 0 then
						ipairs = var_7_1

						for iter_7_0, iter_7_1 in var_7_1(var_1_10007) do
							var_2_10007 = arg_1_0

							local var_7_0 = var_6.sendNotification

							GAME = var_2_10008
							var_2_10008 = var_2_10008.CONSUME_ITEM
							Drop = var_2_10009

							var_7_0(var_2_10007, var_2_10008, var_2_10009.New({
								type = iter_7_1[1],
								id = iter_7_1[2],
								count = iter_7_1[3]
							}))
						end

						var_7_1 = {}
						ipairs = var_2

						for iter_7_2, iter_7_3 in var_2(arg_7_0.drop_list) do
							table = var_2_10007

							var_2_10007.insert(var_7_1, iter_7_3)
						end

						local var_7_2 = {
							id = 0
						}

						VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_2_10003
						var_7_2.type = var_2_10003
						var_7_2.count = var_1_10008
						table = var_2_10003

						var_2_10003.insert(var_7_1, var_7_2)

						IslandDropHelper = var_2_10003
						var_2_10003 = var_2_10003.AddItems({
							drop_list = var_7_1
						})
						ipairs = var_4

						for iter_7_4, iter_7_5 in var_4(var_1_1.commodityList) do
							local var_7_3 = var_1_4

							var_9.UpdateShopCommodity(var_7_3, iter_7_5.key, iter_7_5.value1, iter_7_5.value2)

							pg = var_9

							local var_7_4 = var_9.GameTrackerMgr.GetInstance()
							local var_7_5 = var_9.Record

							GameTrackerBuilder = var_11

							var_7_5(var_7_4, var_11.BuildIslandShopBuy(iter_7_5.key, iter_7_5.value1))
						end

						local var_7_6 = arg_1_0
						local var_7_7 = var_4.sendNotification

						GAME = var_6

						var_7_7(var_7_6, var_6.ISLAND_SHOP_OP_DONE, {
							operation = var_1_1.operation,
							awards = var_2_10003
						})

						if var_1_1.callback then
							var_1_1.callback()
						end
					else
						pg = var_7_1

						local var_7_8 = var_7_1.TipsMgr.GetInstance()
						local var_7_9 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10003

						var_7_9(var_7_8, var_2_10003[arg_7_0.result] .. arg_7_0.result)
					end

					return
				end)
			end
		else
			local var_1_36 = var_1_1.operation

			IslandConst = var_1_11

			if var_1_36 == var_1_11.SHOP_REFRESH_BY_PLAYER then
				local var_1_37 = var_1_1.refreshResource

				getProxy = var_6
				PlayerProxy = var_1_10007

				local var_1_38 = var_6(var_1_10007)
				local var_1_39 = var_6.getData(var_1_38)

				if var_1_37[3] ~= 0 then
					var_1_10008 = var_1_37[1]
					DROP_TYPE_RESOURCE = var_1_10009

					if var_1_10008 == var_1_10009 then
						id2res = var_1_10008

						if var_1_39[var_1_10008(var_1_37[2])] < var_7 then
							Drop = var_1_10008
							var_1_10008 = var_1_10008.New
							var_1_10009 = {}
							DROP_TYPE_RESOURCE = var_1_10010
							var_1_10009.type = var_1_10010
							var_1_10009.id = var_1_37[2]
							var_1_10009 = var_1_10008(var_1_10009)
							var_1_10008 = var_1_10008.getName(var_1_10009)

							local var_1_40

							if var_1_37[2] == 1 then
								GoShoppingMsgBox = var_1_10009
								i18n = var_1_40
								var_1_10011 = "switch_to_shop_tip_2"
								i18n = var_1_10012
								var_1_40 = var_1_40(var_1_10011, var_1_10012("word_gold"))
								ChargeScene = var_1_10011
								var_1_10011 = var_1_10011.TYPE_ITEM
								var_1_10012 = {}

								local var_1_41 = {
									59001
								}

								id2res = iter_1_8
								var_1_41[2] = var_7 - var_1_39[iter_1_8(var_1_37[2])]
								var_1_41[3] = var_7
								var_1_10012[1] = var_1_41

								var_1_10009(var_1_40, var_1_10011, var_1_10012)
							elseif var_1_37[2] == 4 or var_1_37[2] == 14 then
								GoShoppingMsgBox = var_1_10009
								i18n = var_1_40
								var_1_10011 = "switch_to_shop_tip_3"
								i18n = var_1_10012
								var_1_40 = var_1_40(var_1_10011, var_1_10012("word_gem"))
								ChargeScene = var_1_10011

								var_1_10009(var_1_40, var_1_10011.TYPE_DIAMOND)
							else
								ItemTipPanel = var_1_10009
								var_1_10009 = var_1_10009.ShowItemTip
								DROP_TYPE_RESOURCE = var_1_40

								if not var_1_10009(var_1_40, var_1_37[2]) then
									pg = var_1_10009

									local var_1_42 = var_1_10009.TipsMgr.GetInstance()

									var_1_10009 = var_1_10009.ShowTips
									i18n = var_1_10011

									var_1_10009(var_1_42, var_1_10011("buyProp_noResource_error", var_1_10008))
								end
							end

							return
						end
					else
						var_1_10008 = var_1_37[1]
						DROP_TYPE_ISLAND_ITEM = var_1_10009

						if var_1_10008 == var_1_10009 and var_1_7:GetOwnCount(var_1_37[2]) < var_7 then
							pg = var_1_10008
							var_1_10008 = var_1_10008.island_item_data_template[var_1_37[2]].name
							pg = var_9

							local var_1_43 = var_9.TipsMgr.GetInstance()
							local var_1_44 = var_9.ShowTips

							i18n = var_1_10011

							var_1_44(var_1_43, var_1_10011("buyProp_noResource_error", var_1_10008))

							return
						end
					end
				end

				pg = var_1_10008

				local var_1_45 = var_1_10008.ConnectionMgr.GetInstance()

				var_8.Send(var_1_45, 21020, {
					shop_id = var_1_1.shopId
				}, 21021, function(arg_8_0)
					local var_8_1

					if arg_8_0.result == 0 then
						if var_0 ~= 0 then
							local var_8_0 = arg_1_0

							var_8_1 = var_8_1.sendNotification
							GAME = var_2_10003
							var_2_10003 = var_2_10003.CONSUME_ITEM
							Drop = var_2_10004

							var_8_1(var_8_0, var_2_10003, var_2_10004.New({
								type = var_1_37[1],
								id = var_1_37[2],
								count = var_0
							}))
						end

						local var_8_2 = var_1_4

						var_8_1.UpdateShop(var_8_2, var_1_1.shopId, arg_8_0.shop_info)

						local var_8_3 = arg_1_0

						var_8_1 = var_8_1.sendNotification
						GAME = var_2_10003

						var_8_1(var_8_3, var_2_10003.ISLAND_SHOP_OP_DONE, {
							operation = var_1_1.operation
						})

						if var_1_1.callback then
							var_1_1.callback()
						end
					else
						pg = var_8_1

						local var_8_4 = var_8_1.TipsMgr.GetInstance()
						local var_8_5 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10003

						var_8_5(var_8_4, var_2_10003[arg_8_0.result] .. arg_8_0.result)
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_1
