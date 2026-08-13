class = var_0_10000

local var_0_0 = "IslandShopOpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	IslandProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)
	local var_1_3 = var_3.GetIsland(var_1_2)
	local var_1_4 = var_3.GetShopAgency(var_1_3)

	getProxy = var_1_0
	IslandProxy = var_1_10006

	local var_1_5 = var_1_0(var_1_10006)
	local var_1_6 = var_4.GetIsland(var_1_5)
	local var_1_7 = var_4.GetInventoryAgency(var_1_6)
	local var_1_8 = var_1_1.operation

	IslandConst = var_1_6

	if var_1_8 == var_1_6.SHOP_GET_DATA then
		pg = var_1_8
		var_1_10007 = var_1_8.ConnectionMgr.GetInstance()

		var_5.Send(var_1_10007, 21016, {
			shop_id = var_1_1.shopId
		}, 21017, function(arg_2_0)
			if arg_2_0.result == 0 then
				local var_2_0 = var_1_4

				var_1.UpdateShop(var_2_0, var_1_1.shopId, arg_2_0.shop_info)

				local var_2_1 = arg_1_0
				local var_2_2 = var_1.sendNotification

				GAME = var_4

				var_2_2(var_2_1, var_4.ISLAND_SHOP_OP_DONE, {
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
		local var_1_9 = var_1_1.operation

		IslandConst = var_6

		local var_1_12

		if var_1_9 == var_6.SHOP_BUY_COMMODITY then
			getProxy = var_1_9
			PlayerProxy = var_1_10007

			local var_1_10 = var_1_9(var_1_10007)
			local var_1_11 = var_5.getData(var_1_10)

			var_1_12 = {}

			local var_1_13 = {}

			var_1_10008 = 0
			var_1_10009 = {}
			ipairs = var_1_10010

			for iter_1_0, iter_1_8 in var_1_10010(var_1_1.commodityList) do
				iter_1_9 = iter_1_8.key

				local var_1_14 = iter_1_8.value1

				var_1_10017 = iter_1_8.value2
				var_1_10020 = var_1_4
				var_1_10018 = var_1_4.GetShopCommodity(var_1_10020, iter_1_9, var_1_14)
				table = var_1_10019

				var_1_10019.insert(var_1_12, var_1_10018)

				table = var_1_10019

				var_1_10019.insertto(var_1_10009, var_1_10018:GetItems())

				if not var_1_10018 then
					return
				end

				if var_1_10017 == 0 then
					return
				end

				Clone = var_1_10019
				var_1_10020 = var_1_10019(var_1_10018:GetResourceConsume())[3] * var_1_10017
				math = var_1_10021
				var_1_10019[3] = var_1_10021.ceil((100 - var_1_10018:GetDiscount()) / 100 * var_1_10020)
				var_1_10021 = false
				ipairs = var_22

				for iter_1_2, iter_1_3 in var_22(var_1_13) do
					if iter_1_3[1] == var_1_10019[1] and iter_1_3[2] == var_1_10019[2] then
						var_1_10021 = true
						iter_1_3[3] = iter_1_3[3] + var_1_10019[3]

						break
					end
				end

				if not var_1_10021 then
					table = var_22

					var_22.insert(var_1_13, var_1_10019)
				end

				pg = var_22
				var_1_10008 = var_1_10008 + var_22.island_shop_goods[var_1_14].pt_award * var_1_10017

				local var_1_15 = {}
				local var_1_16 = var_1_10018:GetItems()

				ipairs = var_24

				for iter_1_4, iter_1_5 in var_24(var_1_16) do
					local var_1_17 = iter_1_5[1]

					DROP_TYPE_ISLAND_ITEM = var_1_10030

					if var_1_17 ~= var_1_10030 then
						Drop = var_1_17

						local var_1_18 = var_1_17.New({
							type = iter_1_5[1],
							id = iter_1_5[2],
							count = iter_1_5[3]
						})

						table = var_1_10030

						var_1_10030.insert(var_1_15, var_1_18)
					end
				end

				GetItemsOverflowDic = var_24

				local var_1_19 = var_24(var_1_15)

				CheckOverflow = var_25

				local var_1_20, var_1_21 = var_25(var_1_19)

				if not var_1_20 then
					switch = var_27

					var_27(var_1_21, {
						gold = function()
							pg = var_2_10000

							local var_3_0 = var_2_10000.TipsMgr.GetInstance()
							local var_3_1 = var_0.ShowTips

							i18n = var_2_10003

							local var_3_2 = var_2_10003("gold_max_tip_title")

							i18n = var_2_10004

							var_3_1(var_3_0, var_3_2 .. var_2_10004("resource_max_tip_shop"))

							return
						end,
						oil = function()
							pg = var_2_10000

							local var_4_0 = var_2_10000.TipsMgr.GetInstance()
							local var_4_1 = var_0.ShowTips

							i18n = var_2_10003

							local var_4_2 = var_2_10003("oil_max_tip_title")

							i18n = var_2_10004

							var_4_1(var_4_0, var_4_2 .. var_2_10004("resource_max_tip_shop"))

							return
						end,
						equip = function()
							NoPosMsgBox = var_2_10000
							i18n = var_2_10002

							local var_5_0 = var_2_10002("switch_to_shop_tip_noPos")

							openDestroyEquip = var_2_10003
							gotoChargeScene = var_4

							var_2_10000(var_5_0, var_2_10003, var_4)

							return
						end,
						ship = function()
							NoPosMsgBox = var_2_10000
							i18n = var_2_10002

							local var_6_0 = var_2_10002("switch_to_shop_tip_noDockyard")

							openDockyardClear = var_2_10003
							gotoChargeScene = var_4
							openDockyardIntensify = var_2_10005

							var_2_10000(var_6_0, var_2_10003, var_4, var_2_10005)

							return
						end
					})

					return
				end

				CheckShipExpOverflow = var_27

				if not var_27(var_1_19) then
					pg = var_27

					local var_1_22 = var_27.MsgboxMgr.GetInstance()
					local var_1_23 = var_27.ShowMsgBox

					var_1_10030 = {}
					i18n = var_1_10031
					var_1_10030.content = var_1_10031("player_expResource_mail_fullBag")
					next = var_1_10031
					var_1_10030.onYes = var_1_10031

					var_1_23(var_1_22, var_1_10030)

					return
				end
			end

			local var_1_24 = false

			ipairs = var_1_10011

			for iter_1_8, iter_1_9 in var_1_10011(var_1_10009) do
				local var_1_25 = iter_1_9[1]

				DROP_TYPE_ISLAND_ITEM = var_1_10017

				if var_1_25 == var_1_10017 then
					var_1_24 = true
				end
			end

			if var_1_24 and var_1_7:ExistAnyOverFlowItem() then
				pg = var_1_10011

				local var_1_26 = var_1_10011.TipsMgr.GetInstance()

				var_1_10011 = var_1_10011.ShowTips
				i18n = iter_1_8

				var_1_10011(var_1_26, iter_1_8("island_3Dshop_bag_max"))

				return
			end

			ipairs = var_1_10011

			for iter_1_8, iter_1_9 in var_1_10011(var_1_13) do
				local var_1_27 = iter_1_9[3]
				local var_1_28 = iter_1_9[1]

				DROP_TYPE_RESOURCE = var_1_10018

				if var_1_28 == var_1_10018 then
					id2res = var_1_28

					if var_1_11[var_1_28(iter_1_9[2])] < var_1_27 then
						Drop = var_17

						local var_1_29 = var_17.New
						local var_1_30 = {}

						DROP_TYPE_RESOURCE = var_1_10020
						var_1_30.type = var_1_10020
						var_1_30.id = iter_1_9[2]

						local var_1_31 = var_1_29(var_1_30)
						local var_1_32 = var_17.getName(var_1_31)

						if iter_1_9[2] == 1 then
							pg = var_1_10018
							var_1_10020 = var_1_10018.TipsMgr.GetInstance()
							var_1_10018 = var_1_10018.ShowTips
							i18n = var_1_10021

							var_1_10018(var_1_10020, var_1_10021("island_3Dshop_lack_gold"))
						elseif iter_1_9[2] == 4 or iter_1_9[2] == 14 then
							pg = var_1_10018
							var_1_10020 = var_1_10018.TipsMgr.GetInstance()
							var_1_10018 = var_1_10018.ShowTips
							i18n = var_1_10021

							var_1_10018(var_1_10020, var_1_10021("island_3Dshop_lack_gem"))
						else
							ItemTipPanel = var_1_10018
							var_1_10018 = var_1_10018.ShowItemTip
							DROP_TYPE_RESOURCE = var_1_10020

							if not var_1_10018(var_1_10020, iter_1_9[2]) then
								pg = var_1_10018
								var_1_10020 = var_1_10018.TipsMgr.GetInstance()
								var_1_10018 = var_1_10018.ShowTips
								i18n = var_1_10021

								var_1_10018(var_1_10020, var_1_10021("buyProp_noResource_error", var_1_32))
							end
						end

						return
					end
				else
					local var_1_33 = iter_1_9[1]

					DROP_TYPE_ISLAND_ITEM = var_1_10018

					if var_1_33 == var_1_10018 and var_1_7:GetOwnCount(iter_1_9[2]) < var_1_27 then
						pg = var_17

						local var_1_34 = var_17.TipsMgr.GetInstance()
						local var_1_35 = var_17.ShowTips

						i18n = var_1_10020

						var_1_35(var_1_34, var_1_10020("island_3Dshop_lack_res"))

						pg = var_1_35

						local var_1_36 = var_1_35.island_item_data_template[iter_1_9[2]].jump_page

						return
					end
				end
			end

			local var_1_37 = var_1_12[1]

			if var_1_10011.GetPayId(var_1_37) == 0 then
				pg = var_1_10011

				local var_1_38 = var_1_10011.ConnectionMgr.GetInstance()

				var_1_10011.Send(var_1_38, 21018, {
					goods_list = var_1_1.commodityList
				}, 21019, function(arg_7_0)
					local var_7_2

					if arg_7_0.result == 0 then
						ipairs = var_7_2

						for iter_7_0, iter_7_1 in var_7_2(var_1_13) do
							local var_7_0 = arg_1_0
							local var_7_1 = var_6.sendNotification

							GAME = var_2_10009
							var_2_10009 = var_2_10009.CONSUME_ITEM
							Drop = var_2_10010

							var_7_1(var_7_0, var_2_10009, var_2_10010.New({
								type = iter_7_1[1],
								id = iter_7_1[2],
								count = iter_7_1[3]
							}))
						end

						var_7_2 = {}
						ipairs = var_2

						for iter_7_2, iter_7_3 in var_2(arg_7_0.drop_list) do
							table = var_2_10007

							var_2_10007.insert(var_7_2, iter_7_3)
						end

						local var_7_3 = {
							id = 0
						}

						VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_3
						var_7_3.type = var_3
						var_7_3.count = var_1_10008
						table = var_3

						var_3.insert(var_7_2, var_7_3)

						IslandDropHelper = var_3

						local var_7_4 = var_3.AddItems({
							drop_list = var_7_2
						})

						ipairs = iter_7_0

						for iter_7_4, iter_7_5 in iter_7_0(var_1_1.commodityList) do
							local var_7_5 = var_1_4

							var_9.UpdateShopCommodity(var_7_5, iter_7_5.key, iter_7_5.value1, iter_7_5.value2)

							pg = var_9

							local var_7_6 = var_9.GameTrackerMgr.GetInstance()
							local var_7_7 = var_9.Record

							GameTrackerBuilder = var_12

							var_7_7(var_7_6, var_12.BuildIslandShopBuy(iter_7_5.key, iter_7_5.value1))
						end

						local var_7_8 = arg_1_0

						iter_7_0 = iter_7_0.sendNotification
						GAME = iter_7_4

						iter_7_0(var_7_8, iter_7_4.ISLAND_SHOP_OP_DONE, {
							operation = var_1_1.operation,
							awards = var_7_4
						})

						if var_1_1.callback then
							var_1_1.callback()
						end
					else
						pg = var_7_2

						local var_7_9 = var_7_2.TipsMgr.GetInstance()
						local var_7_10 = var_1.ShowTips

						ERROR_MESSAGE = iter_7_0

						var_7_10(var_7_9, iter_7_0[arg_7_0.result] .. arg_7_0.result)
					end

					return
				end)
			end
		else
			local var_1_39 = var_1_1.operation

			IslandConst = var_1_12

			if var_1_39 == var_1_12.SHOP_REFRESH_BY_PLAYER then
				local var_1_40 = var_1_1.refreshResource

				getProxy = var_6
				PlayerProxy = var_1_10008

				local var_1_41 = var_6(var_1_10008)
				local var_1_42 = var_6.getData(var_1_41)

				if var_1_40[3] ~= 0 then
					var_1_41 = var_1_40[1]
					DROP_TYPE_RESOURCE = var_1_10009

					if var_1_41 == var_1_10009 then
						id2res = var_1_41

						if var_1_42[var_1_41(var_1_40[2])] < var_7 then
							Drop = var_1_41
							var_1_41 = var_1_41.New

							local var_1_43 = {}

							DROP_TYPE_RESOURCE = var_1_10011
							var_1_43.type = var_1_10011
							var_1_43.id = var_1_40[2]

							local var_1_44 = var_1_41(var_1_43)

							var_1_41 = var_1_41.getName(var_1_44)

							local var_1_46

							if var_1_40[2] == 1 then
								GoShoppingMsgBox = var_1_10009
								i18n = var_1_46

								local var_1_45 = "switch_to_shop_tip_2"

								i18n = iter_1_8
								var_1_46 = var_1_46(var_1_45, iter_1_8("word_gold"))
								ChargeScene = var_1_10012
								var_1_10012 = var_1_10012.TYPE_ITEM

								local var_1_47 = {}

								iter_1_8 = {
									59001
								}
								id2res = iter_1_9
								iter_1_8[2] = var_7 - var_1_42[iter_1_9(var_1_40[2])]
								iter_1_8[3] = var_7
								var_1_47[1] = iter_1_8

								var_1_10009(var_1_46, var_1_10012, var_1_47)
							elseif var_1_40[2] == 4 or var_1_40[2] == 14 then
								GoShoppingMsgBox = var_1_10009
								i18n = var_1_46

								local var_1_48 = "switch_to_shop_tip_3"

								i18n = iter_1_8
								var_1_46 = var_1_46(var_1_48, iter_1_8("word_gem"))
								ChargeScene = var_1_10012

								var_1_10009(var_1_46, var_1_10012.TYPE_DIAMOND)
							else
								ItemTipPanel = var_1_10009
								var_1_10009 = var_1_10009.ShowItemTip
								DROP_TYPE_RESOURCE = var_1_46

								if not var_1_10009(var_1_46, var_1_40[2]) then
									pg = var_1_10009

									local var_1_49 = var_1_10009.TipsMgr.GetInstance()

									var_1_10009 = var_1_10009.ShowTips
									i18n = var_1_10012

									var_1_10009(var_1_49, var_1_10012("buyProp_noResource_error", var_1_41))
								end
							end

							return
						end
					else
						var_1_41 = var_1_40[1]
						DROP_TYPE_ISLAND_ITEM = var_1_10009

						if var_1_41 == var_1_10009 and var_1_7:GetOwnCount(var_1_40[2]) < var_7 then
							pg = var_1_41
							var_1_41 = var_1_41.island_item_data_template[var_1_40[2]].name
							pg = var_9

							local var_1_50 = var_9.TipsMgr.GetInstance()
							local var_1_51 = var_9.ShowTips

							i18n = var_1_10012

							var_1_51(var_1_50, var_1_10012("buyProp_noResource_error", var_1_41))

							return
						end
					end
				end

				pg = var_1_41

				local var_1_52 = var_1_41.ConnectionMgr.GetInstance()

				var_8.Send(var_1_52, 21020, {
					shop_id = var_1_1.shopId
				}, 21021, function(arg_8_0)
					local var_8_1

					if arg_8_0.result == 0 then
						if var_0 ~= 0 then
							local var_8_0 = arg_1_0

							var_8_1 = var_8_1.sendNotification
							GAME = var_2_10004
							var_2_10004 = var_2_10004.CONSUME_ITEM
							Drop = var_2_10005

							var_8_1(var_8_0, var_2_10004, var_2_10005.New({
								type = var_1_40[1],
								id = var_1_40[2],
								count = var_0
							}))
						end

						local var_8_2 = var_1_4

						var_8_1.UpdateShop(var_8_2, var_1_1.shopId, arg_8_0.shop_info)

						local var_8_3 = arg_1_0

						var_8_1 = var_8_1.sendNotification
						GAME = var_2_10004

						var_8_1(var_8_3, var_2_10004.ISLAND_SHOP_OP_DONE, {
							operation = var_1_1.operation
						})

						if var_1_1.callback then
							var_1_1.callback()
						end
					else
						pg = var_8_1

						local var_8_4 = var_8_1.TipsMgr.GetInstance()
						local var_8_5 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10004

						var_8_5(var_8_4, var_2_10004[arg_8_0.result] .. arg_8_0.result)
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_1
