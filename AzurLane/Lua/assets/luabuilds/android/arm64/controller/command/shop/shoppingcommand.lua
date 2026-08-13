class = var_0_10000

local var_0_0 = "ShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count

	pg = var_1_10005

	local var_1_2 = var_1_10005.shop_template[var_1_0]

	if not var_1_0 then
		pg = var_1_10006
		var_1_10008 = var_1_10006.TipsMgr.GetInstance()

		local var_1_3 = var_6.ShowTips

		i18n = var_1_10009

		var_1_3(var_1_10008, var_1_10009("common_shopId_noFound"))

		return
	end

	local var_1_4 = var_1_2.type

	DROP_TYPE_WORLD_ITEM = var_1_10007

	if var_1_4 == var_1_10007 then
		nowWorld = var_1_4

		local var_1_5 = var_1_4()

		if not var_1_4.IsActivate(var_1_5) then
			pg = var_7

			local var_1_6 = var_7.TipsMgr.GetInstance()
			local var_1_7 = var_7.ShowTips

			i18n = var_1_10010

			var_1_7(var_1_6, var_1_10010("world_shop_bag_unactivated"))

			return
		end
	end

	getProxy = var_1_4
	PlayerProxy = var_1_10008

	local var_1_8 = var_1_4(var_1_10008)
	local var_1_9 = var_6.getData(var_1_8)
	local var_1_10 = var_1_2.type

	DROP_TYPE_ITEM = var_1_8

	if var_1_10 == var_1_8 then
		local var_1_11 = var_1_2.effect_args

		Item = var_1_8
		var_1_8 = var_1_8.getConfigData(var_1_11[1]).display_icon
		pairs = var_1_10010

		for iter_1_0, iter_1_1 in var_1_10010(var_1_8) do
			if iter_1_1[1] == 1 then
				if iter_1_1[2] == 1 then
					iter_1_3 = var_1_9

					if var_1_9.GoldMax(iter_1_3, iter_1_1[3]) then
						pg = var_15
						iter_1_3 = var_15.TipsMgr.GetInstance()

						local var_1_12 = var_15.ShowTips

						i18n = var_1_10018
						var_1_10018 = var_1_10018("gold_max_tip_title")
						i18n = var_1_10019

						var_1_12(iter_1_3, var_1_10018 .. var_1_10019("resource_max_tip_shop"))

						return
					end
				end

				if iter_1_1[2] == 2 then
					iter_1_3 = var_1_9

					if var_1_9.OilMax(iter_1_3, iter_1_1[3]) then
						pg = var_15
						iter_1_3 = var_15.TipsMgr.GetInstance()

						local var_1_13 = var_15.ShowTips

						i18n = var_1_10018
						var_1_10018 = var_1_10018("oil_max_tip_title")
						i18n = var_1_10019

						var_1_13(iter_1_3, var_1_10018 .. var_1_10019("resource_max_tip_shop"))

						return
					end
				end
			end
		end
	end

	local var_1_14 = var_1_2.type

	DROP_TYPE_RESOURCE = var_1_8

	if var_1_14 == var_1_8 then
		if var_1_2.effect_args[1] == 1 then
			var_1_10010 = var_1_9

			if var_1_9.GoldMax(var_1_10010, var_1_2.num * var_1_1) then
				pg = var_1_14
				var_1_10010 = var_1_14.TipsMgr.GetInstance()
				var_1_14 = var_1_14.ShowTips
				i18n = var_11

				local var_1_15 = var_11("gold_max_tip_title")

				i18n = var_1_10012

				var_1_14(var_1_10010, var_1_15 .. var_1_10012("resource_max_tip_shop"))

				return
			end
		end

		if var_1_2.effect_args[1] == 2 then
			if var_1_2.num == -1 then
				local var_1_16 = var_1_2.genre

				ShopArgs = var_1_10010

				if var_1_16 == var_1_10010.BuyOil then
					ShopArgs = var_1_16
					var_1_14 = var_1_16.getOilByLevel(var_1_9.level)
				end
			end

			if var_1_9:OilMax(var_1_14 * var_1_1) then
				pg = var_9

				local var_1_17 = var_9.TipsMgr.GetInstance()
				local var_1_18 = var_9.ShowTips

				i18n = var_1_10012
				var_1_10012 = var_1_10012("oil_max_tip_title")
				i18n = iter_1_0

				var_1_18(var_1_17, var_1_10012 .. iter_1_0("resource_max_tip_shop"))

				return
			end
		end
	end

	if var_1_1 == 0 then
		return
	end

	getProxy = var_1_14
	ShopsProxy = var_1_10010

	local var_1_19 = var_1_14(var_1_10010)
	local var_1_20 = var_8.getShopStreet(var_1_19)
	local var_1_21 = false
	local var_1_22 = var_1_2.resource_num

	getProxy = var_1_10012
	NavalAcademyProxy = iter_1_1

	local var_1_23 = var_1_10012(iter_1_1)

	if var_1_22 == -1 then
		local var_1_24 = var_1_2.effect_args

		ShopArgs = iter_1_1

		if var_1_24 == iter_1_1.EffectShopStreetLevel then
			pg = var_1_24
			var_1_22 = var_1_24.navalacademy_shoppingstreet_template[var_1_20.level].lv_up_cost[2] * var_1_1
		else
			switch = var_1_24

			local var_1_25 = var_1_2.effect_args

			iter_1_2 = {}
			ShopArgs = iter_1_3
			iter_1_2[iter_1_3.EffectTradingPortLevel] = function()
				return var_1_23._goldVO
			end
			ShopArgs = iter_1_3
			iter_1_2[iter_1_3.EffectOilFieldLevel] = function()
				return var_1_23._oilVO
			end
			ShopArgs = iter_1_3
			iter_1_2[iter_1_3.EffectClassLevel] = function()
				return var_1_23._classVO
			end

			if var_1_24(var_1_25, iter_1_2) then
				iter_1_2 = var_13
				iter_1_1 = var_13.bindConfigTable(iter_1_2)
				iter_1_3 = var_13
				var_1_22 = iter_1_1[var_13.GetLevel(iter_1_3)].use[2] * var_1_1
			end
		end
	else
		var_1_22 = var_1_2.resource_num * var_1_1

		if var_1_20 then
			local var_1_26 = var_1_2.genre

			ShopArgs = iter_1_1

			if var_1_26 == iter_1_1.ShoppingStreetLimit then
				var_1_21 = true

				local var_1_27 = var_1_20:getGoodsById(var_1_0)

				math = iter_1_1
				var_1_22 = iter_1_1.ceil(var_1_27.discount / 100 * var_1_22)
			end
		end
	end

	if var_1_2.limit_args then
		ipairs = var_13

		for iter_1_2, iter_1_3 in var_13(var_1_2.limit_args) do
			type = var_1_10018

			if var_1_10018(iter_1_3) == "table" and iter_1_3[1] == "level" then
				var_1_10018 = iter_1_3[2]

				if var_1_9.level < var_1_10018 then
					pg = var_1_10018
					var_1_10020 = var_1_10018.TipsMgr.GetInstance()
					var_1_10018 = var_1_10018.ShowTips
					i18n = var_1_10021

					var_1_10018(var_1_10020, var_1_10021("common_limit_level", iter_1_3[2]))

					return
				end
			end
		end
	end

	if var_1_2.discount ~= 0 then
		CommonCommodity = var_13

		if var_13.InCommodityDiscountTime(var_1_2.id) then
			var_1_22 = var_1_22 * ((100 - var_1_2.discount) / 100)
		end
	end

	id2res = var_13

	if var_1_9[var_13(var_1_2.resource_type)] < var_1_22 then
		Drop = var_13

		local var_1_28 = var_13.New
		local var_1_29 = {}

		DROP_TYPE_RESOURCE = iter_1_2
		var_1_29.type = iter_1_2
		var_1_29.id = var_1_2.resource_type

		local var_1_30 = var_1_28(var_1_29)
		local var_1_31 = var_13.getName(var_1_30)
		local var_1_33

		if var_1_2.resource_type == 1 then
			GoShoppingMsgBox = iter_1_1
			i18n = var_1_33

			local var_1_32 = "switch_to_shop_tip_2"

			i18n = var_1_10019
			var_1_33 = var_1_33(var_1_32, var_1_10019("word_gold"))
			ChargeScene = iter_1_3
			iter_1_3 = iter_1_3.TYPE_ITEM

			local var_1_34 = {}

			var_1_10019 = {
				59001
			}
			id2res = var_1_10020
			var_1_10019[2] = var_1_22 - var_1_9[var_1_10020(var_1_2.resource_type)]
			var_1_10019[3] = var_1_22
			var_1_34[1] = var_1_10019

			iter_1_1(var_1_33, iter_1_3, var_1_34)
		elseif var_1_2.resource_type == 4 or var_1_2.resource_type == 14 then
			GoShoppingMsgBox = iter_1_1
			i18n = var_1_33

			local var_1_35 = "switch_to_shop_tip_3"

			i18n = var_1_10019
			var_1_33 = var_1_33(var_1_35, var_1_10019("word_gem"))
			ChargeScene = iter_1_3

			iter_1_1(var_1_33, iter_1_3.TYPE_DIAMOND)

			iter_1_1 = var_1_2.id
			NewShopMainMediator = var_1_30

			if iter_1_1 == var_1_30.FAST_BUILD_ITEM_ID then
				pg = iter_1_1
				var_1_33 = iter_1_1.TrackerMgr.GetInstance()
				iter_1_1 = iter_1_1.Tracking
				TRACKING_BUILD_OR_SKIN_FAILD = var_17

				iter_1_1(var_1_33, var_17)
			end
		else
			ItemTipPanel = iter_1_1
			iter_1_1 = iter_1_1.ShowItemTip
			DROP_TYPE_RESOURCE = var_1_33

			if not iter_1_1(var_1_33, var_1_2.resource_type) then
				pg = iter_1_1

				local var_1_36 = iter_1_1.TipsMgr.GetInstance()

				iter_1_1 = iter_1_1.ShowTips
				i18n = var_17

				iter_1_1(var_1_36, var_17("buyProp_noResource_error", var_1_31))
			end
		end

		return
	end

	local var_1_37 = {}

	table = iter_1_1

	iter_1_1.insert(var_1_37, function(arg_5_0)
		local var_5_0 = var_1_2.genre

		ShopArgs = var_2_10002

		if var_5_0 ~= var_2_10002.GiftPackage then
			var_5_0 = var_1_2.genre
			ShopArgs = var_2

			if var_5_0 == var_2.NewServerShop then
				Drop = var_5_0

				local var_5_1 = var_5_0.New
				local var_5_2 = {
					count = 1
				}

				DROP_TYPE_ITEM = var_2_10004
				var_5_2.type = var_2_10004
				var_5_2.id = var_1_2.effect_args[1]

				local var_5_3 = var_5_1(var_5_2)

				GetItemsOverflowDic = var_2

				local var_5_4 = var_2({
					var_5_3
				})

				CheckOverflow = var_5_2

				local var_5_5, var_5_6 = var_5_2(var_5_4)

				if not var_5_5 then
					switch = var_5

					var_5(var_5_6, {
						gold = function()
							pg = var_3_10000

							local var_6_0 = var_3_10000.TipsMgr.GetInstance()
							local var_6_1 = var_0.ShowTips

							i18n = var_3_10003

							local var_6_2 = var_3_10003("gold_max_tip_title")

							i18n = var_3_10004

							var_6_1(var_6_0, var_6_2 .. var_3_10004("resource_max_tip_shop"))

							return
						end,
						oil = function()
							pg = var_3_10000

							local var_7_0 = var_3_10000.TipsMgr.GetInstance()
							local var_7_1 = var_0.ShowTips

							i18n = var_3_10003

							local var_7_2 = var_3_10003("oil_max_tip_title")

							i18n = var_3_10004

							var_7_1(var_7_0, var_7_2 .. var_3_10004("resource_max_tip_shop"))

							return
						end,
						equip = function()
							NoPosMsgBox = var_3_10000
							i18n = var_3_10002

							local var_8_0 = var_3_10002("switch_to_shop_tip_noPos")

							openDestroyEquip = var_3_10003
							gotoChargeScene = var_4

							var_3_10000(var_8_0, var_3_10003, var_4)

							return
						end,
						ship = function()
							NoPosMsgBox = var_3_10000
							i18n = var_3_10002

							local var_9_0 = var_3_10002("switch_to_shop_tip_noDockyard")

							openDockyardClear = var_3_10003
							gotoChargeScene = var_4
							openDockyardIntensify = var_3_10005

							var_3_10000(var_9_0, var_3_10003, var_4, var_3_10005)

							return
						end
					})

					return
				end

				CheckShipExpOverflow = var_5

				if not var_5(var_5_4) then
					pg = var_5

					local var_5_7 = var_5.MsgboxMgr.GetInstance()
					local var_5_8 = var_5.ShowMsgBox
					local var_5_9 = {}

					i18n = var_2_10009
					var_5_9.content = var_2_10009("player_expResource_mail_fullBag")
					var_5_9.onYes = arg_5_0

					var_5_8(var_5_7, var_5_9)

					return
				end
			end

			arg_5_0()

			return
		end
	end)

	seriesAsync = var_14

	var_14(var_1_37, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_10_0, 16001, {
			id = var_1_0,
			number = var_1_1
		}, 16002, function(arg_11_0)
			if arg_11_0.result == 0 then
				local var_11_0 = var_0

				var_3_10004 = var_1.getData(var_11_0)

				local var_11_1 = var_1.consume
				local var_11_2 = {}

				id2res = var_3_10006
				var_11_2[var_3_10006(var_1_2.resource_type)] = var_1_22

				var_11_1(var_3_10004, var_11_2)

				local var_11_3
				local var_11_6

				if var_1_21 then
					local var_11_4 = var_0
					local var_11_5 = var_3.getShopStreet(var_11_4)

					var_3_10004 = var_3.getGoodsById(var_11_5, var_1_0)
					var_11_3 = var_3.type
					var_11_6 = var_3_10004

					var_3_10004.reduceBuyCount(var_11_6)

					var_11_6 = var_0

					var_5.UpdateShopStreet(var_11_6, var_3)
				else
					switch = var_3

					local var_11_7 = var_1_2.genre
					local var_11_8 = {}

					ShopArgs = var_11_6
					var_11_8[var_11_6.BuyOil] = function()
						local var_12_0 = var_0

						var_0.increaseBuyOilCount(var_12_0)

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.ArenaShopLimit] = function()
						getProxy = var_4_10000
						ShopsProxy = var_4_10002

						local var_13_0 = var_4_10000(var_4_10002)
						local var_13_1 = var_0.getMeritorousShop(var_13_0)
						local var_13_2 = var_1.getGoodsById(var_13_1, var_1_0)

						var_2.increaseBuyCount(var_13_2)
						var_1:updateGoods(var_2)

						var_11_3 = var_1.type

						var_0:updateMeritorousShop(var_1)

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.GiftPackage] = function()
						local var_14_0 = var_0
						local var_14_1 = var_0.GetNormalByID(var_14_0, var_1_0)

						var_0.increaseBuyCount(var_14_1)

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.NewServerShop] = function()
						local var_15_0 = var_0
						local var_15_1 = var_0.GetNormalByID(var_15_0, var_1_0)

						var_0.increaseBuyCount(var_15_1)

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.SkinShop] = function()
						assert = var_4_10000

						var_4_10000(false, "must be used ShoppingCommand")

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.SkinShopTimeLimit] = function()
						assert = var_4_10000

						var_4_10000(false, "must be used ShoppingCommand")

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.guildShop] = function()
						getProxy = var_4_10000
						ShopsProxy = var_4_10002

						local var_18_0 = var_4_10000(var_4_10002)
						local var_18_1 = var_0.getGuildShop(var_18_0)
						local var_18_2 = var_0.getGoodsById(var_18_1, var_1_0)

						var_1.reduceBuyCount(var_18_2)

						local var_18_3 = var_0

						var_2.updateGuildShop(var_18_3, var_0)

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.WorldShop] = function()
						nowWorld = var_4_10000

						local var_19_0 = var_4_10000()

						var_0.UpdateWorldShopGoods(var_19_0, {
							{
								goods_id = var_1_0,
								count = var_1_1
							}
						})

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.WorldCollection] = function()
						nowWorld = var_4_10000

						local var_20_0 = var_4_10000()

						var_0.UpdateWorldShopGoods(var_20_0, {
							{
								goods_id = var_1_0,
								count = var_1_1
							}
						})

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.CruiseSkin] = function()
						local var_21_0 = var_0
						local var_21_1 = var_0.GetNormalByID(var_21_0, var_1_0)

						var_0.increaseBuyCount(var_21_1)

						return
					end
					ShopArgs = var_11_6
					var_11_8[var_11_6.CruiseGearSkin] = function()
						local var_22_0 = var_0
						local var_22_1 = var_0.GetNormalByID(var_22_0, var_1_0)

						var_0.increaseBuyCount(var_22_1)

						return
					end

					var_3(var_11_7, var_11_8)
				end

				local var_11_9 = var_0

				var_3.updatePlayer(var_11_9, var_1)

				local var_11_10 = var_1_2.group

				if 0 < var_11_10 then
					local var_11_11 = var_0

					var_3.updateNormalGroupList(var_11_11, var_1_2.group, var_1_2.group_buy_count)
				end

				local var_11_12 = var_1_2.genre

				ShopArgs = var_3_10004

				if var_11_12 ~= var_3_10004.CruiseSkin then
					var_11_12 = var_1_2.genre
					ShopArgs = var_3_10004

					if var_11_12 == var_3_10004.CruiseGearSkin then
						local var_11_13 = var_0

						var_11_12.UpdateCruiseShop(var_11_13)
					end

					switch = var_11_12

					local var_11_14 = var_1_2.effect_args
					local var_11_15 = {}

					ShopArgs = var_11_6
					var_11_15[var_11_6.EffecetShipBagSize] = function()
						pg = var_4_10000

						local var_23_0 = var_4_10000.TipsMgr.GetInstance()
						local var_23_1 = var_0.ShowTips

						i18n = var_4_10003

						var_23_1(var_23_0, var_4_10003("shop_extendship_success"))

						return
					end
					ShopArgs = var_7
					var_11_15[var_7.EffecetEquipBagSize] = function()
						pg = var_4_10000

						local var_24_0 = var_4_10000.TipsMgr.GetInstance()
						local var_24_1 = var_0.ShowTips

						i18n = var_4_10003

						var_24_1(var_24_0, var_4_10003("shop_extendequip_success"))

						return
					end
					ShopArgs = var_7
					var_11_15[var_7.EffectCommanderBagSize] = function()
						pg = var_4_10000

						local var_25_0 = var_4_10000.TipsMgr.GetInstance()
						local var_25_1 = var_0.ShowTips

						i18n = var_4_10003

						var_25_1(var_25_0, var_4_10003("shop_extendcommander_success"))

						return
					end
					ShopArgs = var_7
					var_11_15[var_7.EffectSpWeaponBagSize] = function()
						pg = var_4_10000

						local var_26_0 = var_4_10000.TipsMgr.GetInstance()
						local var_26_1 = var_0.ShowTips

						i18n = var_4_10003

						var_26_1(var_26_0, var_4_10003("shop_spweapon_success"))

						return
					end

					var_11_12(var_11_14, var_11_15)

					if var_1_2.limit_args then
						ipairs = var_3

						for iter_11_0, iter_11_1 in var_3(var_1_2.limit_args) do
							type = var_11_16

							if var_11_16(iter_11_1) == "table" then
								local var_11_16 = var_1_2.type

								DROP_TYPE_DORM3D_FURNITURE = var_3_10009

								if var_11_16 ~= var_3_10009 then
									var_11_16 = var_1_2.type
									DROP_TYPE_DORM3D_GIFT = var_3_10009

									if var_11_16 == var_3_10009 then
										local var_11_17

										if iter_11_1[1] == "dailycount" then
											var_11_16 = var_1_2.type
											DROP_TYPE_DORM3D_FURNITURE = var_3_10009

											if var_11_16 == var_3_10009 then
												getProxy = var_11_16
												ApartmentProxy = var_11_17
												var_11_17 = var_11_16(var_11_17)
												var_11_16 = var_11_16.AddDailyFurnitureShopCount

												local var_11_18 = var_1_2.effect_args[1]
												local var_11_19

												if not var_1_2.effect_args[2] then
													var_11_19 = 1
												end

												var_11_16(var_11_17, var_11_18, var_11_19)
											else
												var_11_16 = var_1_2.type
												DROP_TYPE_DORM3D_GIFT = var_3_10009

												if var_11_16 == var_3_10009 then
													getProxy = var_11_16
													ApartmentProxy = var_11_17
													var_11_17 = var_11_16(var_11_17)
													var_11_16 = var_11_16.AddDailyGiftShopCount

													local var_11_20 = var_1_2.effect_args[1]
													local var_11_21

													if not var_1_2.effect_args[2] then
														var_11_21 = 1
													end

													var_11_16(var_11_17, var_11_20, var_11_21)
												end
											end
										elseif iter_11_1[1] == "count" then
											var_11_16 = var_1_2.type
											DROP_TYPE_DORM3D_FURNITURE = var_3_10009

											if var_11_16 == var_3_10009 then
												getProxy = var_11_16
												ApartmentProxy = var_11_17
												var_11_17 = var_11_16(var_11_17)
												var_11_16 = var_11_16.AddPermanentFurnitureShopCount

												local var_11_22 = var_1_2.effect_args[1]
												local var_11_23

												if not var_1_2.effect_args[2] then
													var_11_23 = 1
												end

												var_11_16(var_11_17, var_11_22, var_11_23)
											else
												var_11_16 = var_1_2.type
												DROP_TYPE_DORM3D_GIFT = var_3_10009

												if var_11_16 == var_3_10009 then
													getProxy = var_11_16
													ApartmentProxy = var_11_17

													local var_11_24 = var_11_16(var_11_17)

													var_11_16 = var_11_16.AddPermanentGiftShopCount

													local var_11_25 = var_1_2.effect_args[1]
													local var_11_26

													if not var_1_2.effect_args[2] then
														var_11_26 = 1
													end

													var_11_16(var_11_24, var_11_25, var_11_26)
												end
											end
										end
									end
								end
							end
						end
					end

					local var_11_27 = var_1_2.group_limit

					if 0 < var_11_27 then
						local var_11_28 = var_1_2.type

						DROP_TYPE_DORM3D_FURNITURE = var_3_10004

						if var_11_28 ~= var_3_10004 then
							local var_11_29 = var_1_2.type

							DROP_TYPE_DORM3D_GIFT = var_3_10004

							if var_11_29 == var_3_10004 then
								local var_11_30 = var_1_2.type

								DROP_TYPE_DORM3D_FURNITURE = var_3_10004

								if var_11_30 == var_3_10004 then
									getProxy = var_11_30
									ApartmentProxy = var_11_14
									var_11_14 = var_11_30(var_11_14)

									local var_11_31 = var_3.AddDailyFurnitureShopCount
									local var_11_32 = var_1_2.effect_args[1]

									if not var_1_2.effect_args[2] then
										iter_11_1 = 1
									end

									var_11_31(var_11_14, var_11_32, iter_11_1)
								else
									local var_11_33 = var_1_2.type

									DROP_TYPE_DORM3D_GIFT = var_3_10004

									if var_11_33 == var_3_10004 then
										getProxy = var_11_33
										ApartmentProxy = var_11_14

										local var_11_34 = var_11_33(var_11_14)
										local var_11_35 = var_3.AddDailyGiftShopCount
										local var_11_36 = var_1_2.effect_args[1]

										if not var_1_2.effect_args[2] then
											iter_11_1 = 1
										end

										var_11_35(var_11_34, var_11_36, iter_11_1)
									end
								end
							end

							local var_11_37 = {}

							if var_1_2.type == 0 then
								local var_11_38 = arg_1_0

								var_3_10004 = var_3_10004.sendNotification
								GAME = iter_11_1

								var_3_10004(var_11_38, iter_11_1.EXTEND, {
									id = var_1_0,
									count = var_1_1
								})
							else
								PlayerConst = var_3_10004
								var_11_37 = var_3_10004.addTranDrop(arg_11_0.drop_list)

								if not var_0.silentTip then
									pg = var_3_10004

									local var_11_39 = var_3_10004.TipsMgr.GetInstance()

									var_3_10004 = var_3_10004.ShowTips
									i18n = iter_11_1

									var_3_10004(var_11_39, iter_11_1("common_buy_success"))
								end
							end

							if not var_0.isQuickShopping then
								local var_11_40 = arg_1_0

								var_3_10004 = var_3_10004.sendNotification
								GAME = iter_11_1

								local var_11_41 = iter_11_1.SHOPPING_DONE
								local var_11_42 = {
									id = var_1_0,
									shopType = var_11_3
								}
								local var_11_43 = var_0

								var_11_42.normalList = var_9.GetNormalList(var_11_43)

								local var_11_44 = var_0

								var_11_42.normalGroupList = var_9.GetNormalGroupList(var_11_44)
								var_11_42.awards = var_11_37

								var_3_10004(var_11_40, var_11_41, var_11_42)
							end

							goto label_11_0

							originalPrint = var_1

							var_1(arg_11_0.result)

							do
								local var_11_46

								if arg_11_0.result == 4400 then
									pg = var_11_46

									local var_11_45 = var_11_46.TipsMgr.GetInstance()

									var_11_46 = var_11_46.ShowTips
									i18n = var_3_10004

									var_11_46(var_11_45, var_3_10004("shopping_error_time_limit"))
								else
									pg = var_11_46

									local var_11_47 = var_11_46.TipsMgr.GetInstance()
									local var_11_48 = var_1.ShowTips

									errorTip = var_3_10004

									var_11_48(var_11_47, var_3_10004("", arg_11_0.result))
								end
							end

							::label_11_0::

							return
						end
					end
				end
			end
		end)

		return
	end)

	return
end

return var_0_1
