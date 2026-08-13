class = var_0_10000

local var_0_0 = "ShoppingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count

	pg = var_1_10005

	local var_1_2 = var_1_10005.shop_template[var_1_0]

	if not var_1_0 then
		pg = var_1_10006
		var_1_10007 = var_1_10006.TipsMgr.GetInstance()

		local var_1_3 = var_6.ShowTips

		i18n = var_1_10008

		var_1_3(var_1_10007, var_1_10008("common_shopId_noFound"))

		return
	end

	local var_1_4 = var_1_2.type

	DROP_TYPE_WORLD_ITEM = var_1_10007

	if var_1_4 == var_1_10007 then
		nowWorld = var_1_4

		local var_1_5 = var_1_4()

		if not var_1_4.IsActivate(var_1_5) then
			pg = var_1_10007

			local var_1_6 = var_1_10007.TipsMgr.GetInstance()

			var_1_10007 = var_1_10007.ShowTips
			i18n = var_1_10009

			var_1_10007(var_1_6, var_1_10009("world_shop_bag_unactivated"))

			return
		end
	end

	getProxy = var_1_4
	PlayerProxy = var_1_10007

	local var_1_7 = var_1_4(var_1_10007)
	local var_1_8 = var_6.getData(var_1_7)
	local var_1_9 = var_1_2.type

	DROP_TYPE_ITEM = var_1_10009

	if var_1_9 == var_1_10009 then
		local var_1_10 = var_1_2.effect_args

		Item = var_1_10009
		var_1_10009 = var_1_10009.getConfigData(var_1_10[1]).display_icon
		pairs = var_1_10010

		for iter_1_0, iter_1_1 in var_1_10010(var_1_10009) do
			if iter_1_1[1] == 1 then
				if iter_1_1[2] == 1 then
					var_1_10016 = var_1_8

					if var_1_8.GoldMax(var_1_10016, iter_1_1[3]) then
						pg = var_1_10015
						var_1_10016 = var_1_10015.TipsMgr.GetInstance()
						var_1_10015 = var_1_10015.ShowTips
						i18n = iter_1_3
						iter_1_3 = iter_1_3("gold_max_tip_title")
						i18n = var_1_10018

						var_1_10015(var_1_10016, iter_1_3 .. var_1_10018("resource_max_tip_shop"))

						return
					end
				end

				if iter_1_1[2] == 2 then
					var_1_10016 = var_1_8

					if var_1_8.OilMax(var_1_10016, iter_1_1[3]) then
						pg = var_1_10015
						var_1_10016 = var_1_10015.TipsMgr.GetInstance()
						var_1_10015 = var_1_10015.ShowTips
						i18n = iter_1_3
						iter_1_3 = iter_1_3("oil_max_tip_title")
						i18n = var_1_10018

						var_1_10015(var_1_10016, iter_1_3 .. var_1_10018("resource_max_tip_shop"))

						return
					end
				end
			end
		end
	end

	local var_1_11 = var_1_2.type

	DROP_TYPE_RESOURCE = var_1_10009

	if var_1_11 == var_1_10009 then
		if var_1_2.effect_args[1] == 1 then
			var_1_10009 = var_1_8

			if var_1_8.GoldMax(var_1_10009, var_1_2.num * var_1_1) then
				pg = var_1_11
				var_1_10009 = var_1_11.TipsMgr.GetInstance()
				var_1_11 = var_1_11.ShowTips
				i18n = var_1_10010
				var_1_10010 = var_1_10010("gold_max_tip_title")
				i18n = var_11

				var_1_11(var_1_10009, var_1_10010 .. var_11("resource_max_tip_shop"))

				return
			end
		end

		if var_1_2.effect_args[1] == 2 then
			if var_1_2.num == -1 then
				var_1_10009 = var_1_2.genre
				ShopArgs = var_1_10010

				if var_1_10009 == var_1_10010.BuyOil then
					ShopArgs = var_1_10009
					var_1_11 = var_1_10009.getOilByLevel(var_1_8.level)
				end
			end

			if var_1_8:OilMax(var_1_11 * var_1_1) then
				pg = var_1_10009

				local var_1_12 = var_1_10009.TipsMgr.GetInstance()

				var_1_10009 = var_1_10009.ShowTips
				i18n = var_11

				local var_1_13 = var_11("oil_max_tip_title")

				i18n = var_1_10012

				var_1_10009(var_1_12, var_1_13 .. var_1_10012("resource_max_tip_shop"))

				return
			end
		end
	end

	if var_1_1 == 0 then
		return
	end

	getProxy = var_1_11
	ShopsProxy = var_1_10009

	local var_1_14 = var_1_11(var_1_10009)
	local var_1_15 = var_8.getShopStreet(var_1_14)
	local var_1_16 = false
	local var_1_17 = var_1_2.resource_num

	getProxy = var_1_10012
	NavalAcademyProxy = iter_1_0

	local var_1_18 = var_1_10012(iter_1_0)

	if var_1_17 == -1 then
		local var_1_19 = var_1_2.effect_args

		ShopArgs = iter_1_1

		if var_1_19 == iter_1_1.EffectShopStreetLevel then
			pg = var_1_19
			var_1_17 = var_1_19.navalacademy_shoppingstreet_template[var_1_15.level].lv_up_cost[2] * var_1_1
		else
			switch = var_1_19
			iter_1_1 = var_1_2.effect_args
			var_1_10015 = {}
			ShopArgs = var_1_10016
			var_1_10015[var_1_10016.EffectTradingPortLevel] = function()
				return var_1_18._goldVO
			end
			ShopArgs = var_16
			var_1_10015[var_16.EffectOilFieldLevel] = function()
				return var_1_18._oilVO
			end
			ShopArgs = var_16
			var_1_10015[var_16.EffectClassLevel] = function()
				return var_1_18._classVO
			end

			if var_1_19(iter_1_1, var_1_10015) then
				var_1_10015 = var_13
				var_1_17 = var_13.bindConfigTable(var_1_10015)[var_13:GetLevel()].use[2] * var_1_1
			end
		end
	else
		var_1_17 = var_1_2.resource_num * var_1_1

		if var_1_15 then
			local var_1_20 = var_1_2.genre

			ShopArgs = iter_1_1

			if var_1_20 == iter_1_1.ShoppingStreetLimit then
				var_1_16 = true

				local var_1_21 = var_1_15
				local var_1_22 = var_1_15.getGoodsById(var_1_21, var_1_0)

				math = var_1_21
				var_1_17 = var_1_21.ceil(var_1_22.discount / 100 * var_1_17)
			end
		end
	end

	if var_1_2.limit_args then
		ipairs = var_13

		for iter_1_2, iter_1_3 in var_13(var_1_2.limit_args) do
			type = var_1_10018

			if var_1_10018(iter_1_3) == "table" and iter_1_3[1] == "level" then
				var_1_10018 = iter_1_3[2]

				if var_1_8.level < var_1_10018 then
					pg = var_1_10018
					var_1_10019 = var_1_10018.TipsMgr.GetInstance()
					var_1_10018 = var_1_10018.ShowTips
					i18n = var_1_10020

					var_1_10018(var_1_10019, var_1_10020("common_limit_level", iter_1_3[2]))

					return
				end
			end
		end
	end

	if var_1_2.discount ~= 0 then
		CommonCommodity = var_13

		if var_13.InCommodityDiscountTime(var_1_2.id) then
			var_1_17 = var_1_17 * ((100 - var_1_2.discount) / 100)
		end
	end

	id2res = var_13

	local var_1_24

	if var_1_8[var_13(var_1_2.resource_type)] < var_1_17 then
		Drop = var_13

		local var_1_23 = var_13.New

		var_1_24 = {}
		DROP_TYPE_RESOURCE = var_1_10015
		var_1_24.type = var_1_10015
		var_1_24.id = var_1_2.resource_type
		var_1_24 = var_1_23(var_1_24)

		local var_1_25 = var_13.getName(var_1_24)
		local var_1_27

		if var_1_2.resource_type == 1 then
			GoShoppingMsgBox = var_1_24
			i18n = var_1_27

			local var_1_26 = "switch_to_shop_tip_2"

			i18n = iter_1_3
			var_1_27 = var_1_27(var_1_26, iter_1_3("word_gold"))
			ChargeScene = var_1_26

			local var_1_28 = var_1_26.TYPE_ITEM

			iter_1_3 = {}

			local var_1_29 = {
				59001
			}

			id2res = var_1_10019
			var_1_29[2] = var_1_17 - var_1_8[var_1_10019(var_1_2.resource_type)]
			var_1_29[3] = var_1_17
			iter_1_3[1] = var_1_29

			var_1_24(var_1_27, var_1_28, iter_1_3)
		elseif var_1_2.resource_type == 4 or var_1_2.resource_type == 14 then
			GoShoppingMsgBox = var_1_24
			i18n = var_1_27

			local var_1_30 = "switch_to_shop_tip_3"

			i18n = iter_1_3
			var_1_27 = var_1_27(var_1_30, iter_1_3("word_gem"))
			ChargeScene = var_1_30

			var_1_24(var_1_27, var_1_30.TYPE_DIAMOND)

			var_1_24 = var_1_2.id
			NewShopMainMediator = var_1_27

			if var_1_24 == var_1_27.FAST_BUILD_ITEM_ID then
				pg = var_1_24
				var_1_27 = var_1_24.TrackerMgr.GetInstance()
				var_1_24 = var_1_24.Tracking
				TRACKING_BUILD_OR_SKIN_FAILD = var_16

				var_1_24(var_1_27, var_16)
			end
		else
			ItemTipPanel = var_1_24
			var_1_24 = var_1_24.ShowItemTip
			DROP_TYPE_RESOURCE = var_1_27

			if not var_1_24(var_1_27, var_1_2.resource_type) then
				pg = var_1_24

				local var_1_31 = var_1_24.TipsMgr.GetInstance()

				var_1_24 = var_1_24.ShowTips
				i18n = var_16

				var_1_24(var_1_31, var_16("buyProp_noResource_error", var_1_25))
			end
		end

		return
	end

	local var_1_32 = {}

	table = var_1_24

	var_1_24.insert(var_1_32, function(arg_5_0)
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

				DROP_TYPE_ITEM = var_2_10003
				var_5_2.type = var_2_10003
				var_5_2.id = var_1_2.effect_args[1]

				local var_5_3 = var_5_1(var_5_2)

				GetItemsOverflowDic = var_5_2

				local var_5_4 = var_5_2({
					var_5_3
				})

				CheckOverflow = var_3

				local var_5_5, var_5_6 = var_3(var_5_4)

				if not var_5_5 then
					switch = var_2_10005

					var_2_10005(var_5_6, {
						gold = function()
							pg = var_3_10000

							local var_6_0 = var_3_10000.TipsMgr.GetInstance()
							local var_6_1 = var_0.ShowTips

							i18n = var_3_10002

							local var_6_2 = var_3_10002("gold_max_tip_title")

							i18n = var_3

							var_6_1(var_6_0, var_6_2 .. var_3("resource_max_tip_shop"))

							return
						end,
						oil = function()
							pg = var_3_10000

							local var_7_0 = var_3_10000.TipsMgr.GetInstance()
							local var_7_1 = var_0.ShowTips

							i18n = var_3_10002

							local var_7_2 = var_3_10002("oil_max_tip_title")

							i18n = var_3

							var_7_1(var_7_0, var_7_2 .. var_3("resource_max_tip_shop"))

							return
						end,
						equip = function()
							NoPosMsgBox = var_3_10000
							i18n = var_3_10001

							local var_8_0 = var_3_10001("switch_to_shop_tip_noPos")

							openDestroyEquip = var_2
							gotoChargeScene = var_3_10003

							var_3_10000(var_8_0, var_2, var_3_10003)

							return
						end,
						ship = function()
							NoPosMsgBox = var_3_10000
							i18n = var_3_10001

							local var_9_0 = var_3_10001("switch_to_shop_tip_noDockyard")

							openDockyardClear = var_2
							gotoChargeScene = var_3_10003
							openDockyardIntensify = var_3_10004

							var_3_10000(var_9_0, var_2, var_3_10003, var_3_10004)

							return
						end
					})

					return
				end

				CheckShipExpOverflow = var_2_10005

				if not var_2_10005(var_5_4) then
					pg = var_5

					local var_5_7 = var_5.MsgboxMgr.GetInstance()
					local var_5_8 = var_5.ShowMsgBox
					local var_5_9 = {}

					i18n = var_2_10008
					var_5_9.content = var_2_10008("player_expResource_mail_fullBag")
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

	var_14(var_1_32, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_10_0, 16001, {
			id = var_1_0,
			number = var_1_1
		}, 16002, function(arg_11_0)
			if arg_11_0.result == 0 then
				local var_11_0 = var_0

				var_3_10003 = var_1.getData(var_11_0)

				local var_11_1 = var_1.consume
				local var_11_2 = {}

				id2res = var_3_10005
				var_11_2[var_3_10005(var_1_2.resource_type)] = var_1_17

				var_11_1(var_3_10003, var_11_2)

				local var_11_3
				local var_11_7

				if var_1_16 then
					local var_11_4 = var_0
					local var_11_5 = var_3_10003.getShopStreet(var_11_4)
					local var_11_6 = var_3_10003.getGoodsById(var_11_5, var_1_0)

					var_11_3 = var_3_10003.type
					var_11_7 = var_11_6

					var_11_6.reduceBuyCount(var_11_7)

					var_11_7 = var_0

					var_5.UpdateShopStreet(var_11_7, var_3_10003)
				else
					switch = var_3_10003

					local var_11_8 = var_1_2.genre
					local var_11_9 = {}

					ShopArgs = var_11_7
					var_11_9[var_11_7.BuyOil] = function()
						local var_12_0 = var_0

						var_0.increaseBuyOilCount(var_12_0)

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.ArenaShopLimit] = function()
						getProxy = var_4_10000
						ShopsProxy = var_4_10001

						local var_13_0 = var_4_10000(var_4_10001)
						local var_13_1 = var_0.getMeritorousShop(var_13_0)
						local var_13_2 = var_1.getGoodsById(var_13_1, var_1_0)

						var_2.increaseBuyCount(var_13_2)
						var_1:updateGoods(var_2)

						var_11_3 = var_1.type

						var_0:updateMeritorousShop(var_1)

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.GiftPackage] = function()
						local var_14_0 = var_0
						local var_14_1 = var_0.GetNormalByID(var_14_0, var_1_0)

						var_0.increaseBuyCount(var_14_1)

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.NewServerShop] = function()
						local var_15_0 = var_0
						local var_15_1 = var_0.GetNormalByID(var_15_0, var_1_0)

						var_0.increaseBuyCount(var_15_1)

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.SkinShop] = function()
						assert = var_4_10000

						var_4_10000(false, "must be used ShoppingCommand")

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.SkinShopTimeLimit] = function()
						assert = var_4_10000

						var_4_10000(false, "must be used ShoppingCommand")

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.guildShop] = function()
						getProxy = var_4_10000
						ShopsProxy = var_4_10001

						local var_18_0 = var_4_10000(var_4_10001)
						local var_18_1 = var_0.getGuildShop(var_18_0)
						local var_18_2 = var_0.getGoodsById(var_18_1, var_1_0)

						var_1.reduceBuyCount(var_18_2)

						local var_18_3 = var_0

						var_2.updateGuildShop(var_18_3, var_0)

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.WorldShop] = function()
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
					ShopArgs = var_11_7
					var_11_9[var_11_7.WorldCollection] = function()
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
					ShopArgs = var_11_7
					var_11_9[var_11_7.CruiseSkin] = function()
						local var_21_0 = var_0
						local var_21_1 = var_0.GetNormalByID(var_21_0, var_1_0)

						var_0.increaseBuyCount(var_21_1)

						return
					end
					ShopArgs = var_11_7
					var_11_9[var_11_7.CruiseGearSkin] = function()
						local var_22_0 = var_0
						local var_22_1 = var_0.GetNormalByID(var_22_0, var_1_0)

						var_0.increaseBuyCount(var_22_1)

						return
					end

					var_3_10003(var_11_8, var_11_9)
				end

				local var_11_10 = var_0

				var_3_10003.updatePlayer(var_11_10, var_1)

				var_3_10003 = var_1_2.group

				local var_11_11

				if 0 < var_3_10003 then
					var_11_11 = var_0

					var_3_10003.updateNormalGroupList(var_11_11, var_1_2.group, var_1_2.group_buy_count)
				end

				var_3_10003 = var_1_2.genre
				ShopArgs = var_11_11

				if var_3_10003 ~= var_11_11.CruiseSkin then
					var_3_10003 = var_1_2.genre
					ShopArgs = var_4

					if var_3_10003 == var_4.CruiseGearSkin then
						local var_11_12 = var_0

						var_3_10003.UpdateCruiseShop(var_11_12)
					end

					switch = var_3_10003

					local var_11_13 = var_1_2.effect_args
					local var_11_14 = {}

					ShopArgs = var_11_7
					var_11_14[var_11_7.EffecetShipBagSize] = function()
						pg = var_4_10000

						local var_23_0 = var_4_10000.TipsMgr.GetInstance()
						local var_23_1 = var_0.ShowTips

						i18n = var_4_10002

						var_23_1(var_23_0, var_4_10002("shop_extendship_success"))

						return
					end
					ShopArgs = var_6
					var_11_14[var_6.EffecetEquipBagSize] = function()
						pg = var_4_10000

						local var_24_0 = var_4_10000.TipsMgr.GetInstance()
						local var_24_1 = var_0.ShowTips

						i18n = var_4_10002

						var_24_1(var_24_0, var_4_10002("shop_extendequip_success"))

						return
					end
					ShopArgs = var_6
					var_11_14[var_6.EffectCommanderBagSize] = function()
						pg = var_4_10000

						local var_25_0 = var_4_10000.TipsMgr.GetInstance()
						local var_25_1 = var_0.ShowTips

						i18n = var_4_10002

						var_25_1(var_25_0, var_4_10002("shop_extendcommander_success"))

						return
					end
					ShopArgs = var_6
					var_11_14[var_6.EffectSpWeaponBagSize] = function()
						pg = var_4_10000

						local var_26_0 = var_4_10000.TipsMgr.GetInstance()
						local var_26_1 = var_0.ShowTips

						i18n = var_4_10002

						var_26_1(var_26_0, var_4_10002("shop_spweapon_success"))

						return
					end

					var_3_10003(var_11_13, var_11_14)

					if var_1_2.limit_args then
						ipairs = var_3_10003

						for iter_11_0, iter_11_1 in var_3_10003(var_1_2.limit_args) do
							type = var_3_10008

							if var_3_10008(iter_11_1) == "table" then
								var_3_10008 = var_1_2.type
								DROP_TYPE_DORM3D_FURNITURE = var_11_15

								if var_3_10008 ~= var_11_15 then
									var_3_10008 = var_1_2.type
									DROP_TYPE_DORM3D_GIFT = var_11_15

									if var_3_10008 == var_11_15 then
										local var_11_15

										if iter_11_1[1] == "dailycount" then
											var_3_10008 = var_1_2.type
											DROP_TYPE_DORM3D_FURNITURE = var_11_15

											if var_3_10008 == var_11_15 then
												getProxy = var_3_10008
												ApartmentProxy = var_11_15
												var_11_15 = var_3_10008(var_11_15)
												var_3_10008 = var_3_10008.AddDailyFurnitureShopCount

												local var_11_16 = var_1_2.effect_args[1]
												local var_11_17

												if not var_1_2.effect_args[2] then
													var_11_17 = 1
												end

												var_3_10008(var_11_15, var_11_16, var_11_17)
											else
												var_3_10008 = var_1_2.type
												DROP_TYPE_DORM3D_GIFT = var_11_15

												if var_3_10008 == var_11_15 then
													getProxy = var_3_10008
													ApartmentProxy = var_11_15
													var_11_15 = var_3_10008(var_11_15)
													var_3_10008 = var_3_10008.AddDailyGiftShopCount

													local var_11_18 = var_1_2.effect_args[1]
													local var_11_19

													if not var_1_2.effect_args[2] then
														var_11_19 = 1
													end

													var_3_10008(var_11_15, var_11_18, var_11_19)
												end
											end
										elseif iter_11_1[1] == "count" then
											var_3_10008 = var_1_2.type
											DROP_TYPE_DORM3D_FURNITURE = var_11_15

											if var_3_10008 == var_11_15 then
												getProxy = var_3_10008
												ApartmentProxy = var_11_15
												var_11_15 = var_3_10008(var_11_15)
												var_3_10008 = var_3_10008.AddPermanentFurnitureShopCount

												local var_11_20 = var_1_2.effect_args[1]
												local var_11_21

												if not var_1_2.effect_args[2] then
													var_11_21 = 1
												end

												var_3_10008(var_11_15, var_11_20, var_11_21)
											else
												var_3_10008 = var_1_2.type
												DROP_TYPE_DORM3D_GIFT = var_11_15

												if var_3_10008 == var_11_15 then
													getProxy = var_3_10008
													ApartmentProxy = var_11_15

													local var_11_22 = var_3_10008(var_11_15)

													var_3_10008 = var_3_10008.AddPermanentGiftShopCount

													local var_11_23 = var_1_2.effect_args[1]
													local var_11_24

													if not var_1_2.effect_args[2] then
														var_11_24 = 1
													end

													var_3_10008(var_11_22, var_11_23, var_11_24)
												end
											end
										end
									end
								end
							end
						end
					end

					var_3_10003 = var_1_2.group_limit

					if 0 < var_3_10003 then
						var_3_10003 = var_1_2.type
						DROP_TYPE_DORM3D_FURNITURE = var_11_25

						if var_3_10003 ~= var_11_25 then
							var_3_10003 = var_1_2.type
							DROP_TYPE_DORM3D_GIFT = var_11_25

							if var_3_10003 == var_11_25 then
								var_3_10003 = var_1_2.type
								DROP_TYPE_DORM3D_FURNITURE = var_11_25

								local var_11_25

								if var_3_10003 == var_11_25 then
									getProxy = var_3_10003
									ApartmentProxy = var_11_25
									var_11_25 = var_3_10003(var_11_25)
									var_3_10003 = var_3_10003.AddDailyFurnitureShopCount

									local var_11_26 = var_1_2.effect_args[1]

									if not var_1_2.effect_args[2] then
										iter_11_0 = 1
									end

									var_3_10003(var_11_25, var_11_26, iter_11_0)
								else
									var_3_10003 = var_1_2.type
									DROP_TYPE_DORM3D_GIFT = var_11_25

									if var_3_10003 == var_11_25 then
										getProxy = var_3_10003
										ApartmentProxy = var_11_25

										local var_11_27 = var_3_10003(var_11_25)

										var_3_10003 = var_3_10003.AddDailyGiftShopCount

										local var_11_28 = var_1_2.effect_args[1]

										if not var_1_2.effect_args[2] then
											iter_11_0 = 1
										end

										var_3_10003(var_11_27, var_11_28, iter_11_0)
									end
								end
							end

							var_3_10003 = {}

							local var_11_30

							if var_1_2.type == 0 then
								local var_11_29 = arg_1_0

								var_11_30 = var_11_30.sendNotification
								GAME = iter_11_0

								var_11_30(var_11_29, iter_11_0.EXTEND, {
									id = var_1_0,
									count = var_1_1
								})
							else
								PlayerConst = var_11_30
								var_3_10003 = var_11_30.addTranDrop(arg_11_0.drop_list)

								if not var_0.silentTip then
									pg = var_4

									local var_11_31 = var_4.TipsMgr.GetInstance()
									local var_11_32 = var_4.ShowTips

									i18n = iter_11_0

									var_11_32(var_11_31, iter_11_0("common_buy_success"))
								end
							end

							if not var_0.isQuickShopping then
								local var_11_33 = arg_1_0
								local var_11_34 = var_4.sendNotification

								GAME = iter_11_0

								local var_11_35 = iter_11_0.SHOPPING_DONE
								local var_11_36 = {
									id = var_1_0,
									shopType = var_11_3
								}
								local var_11_37 = var_0

								var_11_36.normalList = var_8.GetNormalList(var_11_37)

								local var_11_38 = var_0

								var_11_36.normalGroupList = var_8.GetNormalGroupList(var_11_38)
								var_11_36.awards = var_3_10003

								var_11_34(var_11_33, var_11_35, var_11_36)
							end

							goto label_11_0

							originalPrint = var_1

							var_1(arg_11_0.result)

							do
								local var_11_40

								if arg_11_0.result == 4400 then
									pg = var_11_40

									local var_11_39 = var_11_40.TipsMgr.GetInstance()

									var_11_40 = var_11_40.ShowTips
									i18n = var_3_10003

									var_11_40(var_11_39, var_3_10003("shopping_error_time_limit"))
								else
									pg = var_11_40

									local var_11_41 = var_11_40.TipsMgr.GetInstance()
									local var_11_42 = var_1.ShowTips

									errorTip = var_3_10003

									var_11_42(var_11_41, var_3_10003("", arg_11_0.result))
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
