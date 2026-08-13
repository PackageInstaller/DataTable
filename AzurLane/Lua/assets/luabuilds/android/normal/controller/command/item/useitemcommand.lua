class = var_0_10000

local var_0_0 = "UseItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count
	local var_1_2 = var_2.arg

	getProxy = var_1_10006
	BagProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_4 = var_6.getItemById(var_1_3, var_1_0)
	local var_1_5 = var_7.getConfig(var_1_4, "usage")
	local var_1_6 = var_2.skip_check
	local var_1_7 = var_2.callback
	local var_1_8 = var_2.isEquipBox

	if var_1_1 == 0 then
		return
	end

	if var_7.count < var_1_1 then
		pg = var_12

		local var_1_9 = var_12.TipsMgr.GetInstance()
		local var_1_10 = var_12.ShowTips

		i18n = var_1_10014

		var_1_10(var_1_9, var_1_10014("common_no_item_1"))

		return
	end

	if not var_0_1.Check(var_7, var_1_1) then
		return
	end

	ItemUsage = var_12

	if var_1_5 ~= var_12.GUILD_DONATE then
		ItemUsage = var_1_14

		if var_1_5 == var_1_14.GUILD_OPERATION then
			getProxy = var_1_14
			GuildProxy = var_13

			local var_1_11 = var_1_14(var_13)

			if not var_1_14.getRawData(var_1_11) then
				pg = var_1_11

				local var_1_12 = var_1_11.TipsMgr.GetInstance()
				local var_1_13 = var_13.ShowTips

				i18n = var_1_10015

				var_1_13(var_1_12, var_1_10015("not_exist_guild_use_item"))

				return
			end

			goto label_1_0
		end

		ItemUsage = var_1_14

		if var_1_5 ~= var_1_14.SKIN_SHOP_DISCOUNT then
			ItemUsage = var_1_14

			do
				local var_1_14

				if var_1_5 == var_1_14.USAGE_SHOP_DISCOUNT then
					local var_1_15

					var_1_14, var_1_15 = var_7:GetConsumeForSkinShopDiscount(var_1_2[1])
					getProxy = var_14
					PlayerProxy = var_1_10015

					local var_1_16 = var_14(var_1_10015)
					local var_1_17 = var_14.getRawData(var_1_16)
					local var_1_18 = var_14.getResource(var_1_17, var_1_15)

					if 0 < var_1_14 and var_1_18 < var_1_14 then
						pg = var_15

						local var_1_19 = var_15.TipsMgr.GetInstance()
						local var_1_20 = var_15.ShowTips

						i18n = var_1_10017

						var_1_20(var_1_19, var_1_10017("common_no_resource"))

						return
					end
				end
			end

			::label_1_0::

			pg = var_1_14

			local var_1_21 = var_1_14.ConnectionMgr.GetInstance()

			var_12.Send(var_1_21, 15002, {
				id = var_1_0,
				count = var_1_1,
				arg = var_1_2
			}, 15003, function(arg_2_0)
				if arg_2_0.result == 0 then
					local var_2_0 = {}

					var_2_10003 = var_0

					var_2.removeItemById(var_2_10003, var_1_0, var_1_1)

					ipairs = var_2

					for iter_2_0, iter_2_1 in var_2(arg_2_0.drop_list) do
						print = var_2_10007

						var_2_10007(iter_2_0, iter_2_1)
					end

					local var_2_1 = var_1_5

					ItemUsage = var_2_10003

					if var_2_1 == var_2_10003.FOOD then
						var_2_10003 = arg_1_0
						var_2_1 = var_2_1.sendNotification
						GAME = var_2_6

						var_2_1(var_2_10003, var_2_6.ADD_FOOD, {
							id = var_1_0,
							count = var_1_1
						})

						goto label_2_0
					end

					var_2_1 = var_1_5
					ItemUsage = var_2_10003

					if var_2_1 ~= var_2_10003.DROP then
						var_2_1 = var_1_5
						ItemUsage = var_2_10003

						if var_2_1 ~= var_2_10003.DROP_TEMPLATE then
							var_2_1 = var_1_5
							ItemUsage = var_2_10003

							if var_2_1 ~= var_2_10003.DROP_APPOINTED then
								var_2_1 = var_1_5
								ItemUsage = var_2_10003

								if var_2_1 ~= var_2_10003.INVITATION then
									var_2_1 = var_1_5
									ItemUsage = var_2_10003

									if var_2_1 ~= var_2_10003.SKIN_SELECT then
										var_2_1 = var_1_5
										ItemUsage = var_2_10003

										if var_2_1 ~= var_2_10003.RANDOM_SKIN then
											var_2_1 = var_1_5
											ItemUsage = var_2_10003

											if var_2_1 ~= var_2_10003.SHIP_GIFT then
												var_2_1 = var_1_5
												ItemUsage = var_2_10003

												if var_2_1 == var_2_10003.REPAIR_LOVE_LETTER then
													PlayerConst = var_2_1
													var_2_0 = var_2_1.addTranDrop(arg_2_0.drop_list)

													goto label_2_0
												end

												var_2_1 = var_1_5
												ItemUsage = var_2_10003

												if var_2_1 == var_2_10003.USAGE_SKIN_EXP then
													getProxy = var_2_1
													ShipSkinProxy = var_2_10003
													var_2_1 = var_2_1(var_2_10003)
													var_2_10003 = var_1_2[1]
													pg = var_2_6
													iter_2_0 = var_2_6.shop_template[var_2_10003].effect_args[1]
													pg = iter_2_1

													local var_2_2 = iter_2_1.TimeMgr.GetInstance()

													iter_2_1 = iter_2_1.GetServerTime(var_2_2) + var_2_6.time_second
													ShipSkin = var_7

													local var_2_3 = var_7.New({
														id = iter_2_0,
														end_time = iter_2_1
													})

													var_2_1:addSkin(var_2_3)

													local var_2_4 = arg_1_0

													var_2_10008 = var_2_10008.sendNotification
													GAME = var_10

													var_2_10008(var_2_4, var_10.SKIN_SHOPPIGN_DONE, {
														id = var_2_10003
													})

													goto label_2_0
												end

												var_2_1 = var_1_5
												ItemUsage = var_2_10003

												if var_2_1 ~= var_2_10003.SKIN_SHOP_DISCOUNT then
													var_2_1 = var_1_5
													ItemUsage = var_2_10003

													do
														local var_2_6

														if var_2_1 == var_2_10003.USAGE_SHOP_DISCOUNT then
															PlayerConst = var_2_1
															var_2_0 = var_2_1.addTranDrop(arg_2_0.drop_list)
															var_2_10003 = var_0
															var_2_1, var_2_10003 = var_2_1.GetConsumeForSkinShopDiscount(var_2_10003, var_1_2[1])

															if 0 < var_2_1 then
																getProxy = var_2_6
																PlayerProxy = iter_2_0
																iter_2_0 = var_2_6(iter_2_0)
																iter_2_1 = var_2_6.getData(iter_2_0)
																iter_2_0 = var_2_6.consume

																local var_2_5 = {}

																id2res = var_2_10008
																var_2_5[var_2_10008(var_2_10003)] = var_2_1

																iter_2_0(iter_2_1, var_2_5)

																getProxy = iter_2_0
																PlayerProxy = iter_2_1
																iter_2_1 = iter_2_0(iter_2_1)

																iter_2_0.updatePlayer(iter_2_1, var_2_6)
															end

															iter_2_0 = arg_1_0
															var_2_6 = var_2_6.sendNotification
															GAME = iter_2_1

															var_2_6(iter_2_0, iter_2_1.SKIN_SHOPPIGN_DONE, {
																id = var_1_2[1]
															})
														else
															var_2_1 = var_1_5
															ItemUsage = var_2_10003

															if var_2_1 == var_2_10003.DORM_LV_UP then
																var_2_10003 = arg_1_0
																var_2_1 = var_2_1.sendNotification
																GAME = var_2_6

																var_2_1(var_2_10003, var_2_6.EXTEND_BACKYARD_AREA)
															else
																var_2_1 = var_1_5
																ItemUsage = var_2_10003

																if var_2_1 == var_2_10003.GUILD_DONATE then
																	getProxy = var_2_1
																	GuildProxy = var_2_10003
																	var_2_10003 = var_2_1(var_2_10003)

																	if var_2_1.getRawData(var_2_10003) then
																		var_2_6 = var_2_1

																		var_2_1.AddExtraDonateCnt(var_2_6, var_1_1)

																		pg = var_2_10003
																		var_2_6 = var_2_10003.TipsMgr.GetInstance()
																		var_2_10003 = var_2_10003.ShowTips
																		i18n = iter_2_0

																		var_2_10003(var_2_6, iter_2_0("guild_use_donateitem_success", var_1_1))
																	end
																else
																	var_2_1 = var_1_5
																	ItemUsage = var_2_10003

																	if var_2_1 == var_2_10003.GUILD_OPERATION then
																		getProxy = var_2_1
																		GuildProxy = var_2_10003
																		var_2_10003 = var_2_1(var_2_10003)

																		if var_2_1.getRawData(var_2_10003) then
																			var_2_6 = var_2_1

																			var_2_1.AddExtraBattleCnt(var_2_6, var_1_1)

																			pg = var_2_10003
																			var_2_6 = var_2_10003.TipsMgr.GetInstance()
																			var_2_10003 = var_2_10003.ShowTips
																			i18n = iter_2_0

																			var_2_10003(var_2_6, iter_2_0("guild_use_battleitem_success", var_1_1))
																		end
																	else
																		var_2_1 = var_1_5
																		ItemUsage = var_2_10003

																		if var_2_1 == var_2_10003.REDUCE_COMMANDER_TIME then
																			var_2_10003 = arg_1_0
																			var_2_1 = var_2_1.sendNotification
																			GAME = var_2_6

																			var_2_1(var_2_10003, var_2_6.REFRESH_COMMANDER_BOXES)
																		else
																			assert = var_2_1

																			var_2_1(false, "未处理类型" .. var_1_5)
																		end
																	end
																end
															end
														end
													end

													::label_2_0::

													QRJ_ITEM_ID_RANGE = var_2_1

													if var_1_0 >= var_2_1[1] and var_1_0 <= var_2_1[2] then
														table = var_2_10003

														var_2_10003.sort(var_2_0, function(arg_3_0, arg_3_1)
															return arg_3_0.count < arg_3_1.count
														end)
													end

													if var_1_7 then
														var_1_7(var_2_0)
													end

													local var_2_7 = arg_1_0

													var_2_10003 = var_2_10003.sendNotification
													GAME = iter_2_0

													var_2_10003(var_2_7, iter_2_0.USE_ITEM_DONE, {
														drops = var_2_0,
														isEquipBox = var_1_8
													})

													goto label_2_1

													if var_1_7 then
														var_1_7({})
													end

													pg = var_1

													do
														local var_2_8 = var_1.TipsMgr.GetInstance()
														local var_2_9 = var_1.ShowTips

														errorTip = var_2_10003

														var_2_9(var_2_8, var_2_10003("", arg_2_0.result))
													end

													::label_2_1::

													return
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end)

			return
		end
	end
end

function var_0_1.Check(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetOverflowCheckItems(var_4_0, arg_4_1)

	GetItemsOverflowDic = var_4_0

	local var_4_2 = var_4_0(var_4_1)

	CheckOverflow = var_4

	local var_4_3, var_4_4 = var_4(var_4_2)

	if not var_4_3 then
		switch = var_1_10006

		var_1_10006(var_4_4, {
			gold = function()
				pg = var_2_10000

				local var_5_0 = var_2_10000.TipsMgr.GetInstance()
				local var_5_1 = var_0.ShowTips

				i18n = var_2_10002

				var_5_1(var_5_0, var_2_10002("gold_max_tip_title"))

				return
			end,
			oil = function()
				pg = var_2_10000

				local var_6_0 = var_2_10000.TipsMgr.GetInstance()
				local var_6_1 = var_0.ShowTips

				i18n = var_2_10002

				var_6_1(var_6_0, var_2_10002("oil_max_tip_title"))

				return
			end,
			equip = function()
				NoPosMsgBox = var_2_10000
				i18n = var_2_10001

				local var_7_0 = var_2_10001("switch_to_shop_tip_noPos")

				openDestroyEquip = var_2
				gotoChargeScene = var_2_10003

				var_2_10000(var_7_0, var_2, var_2_10003)

				return
			end,
			ship = function()
				NoPosMsgBox = var_2_10000
				i18n = var_2_10001

				local var_8_0 = var_2_10001("switch_to_shop_tip_noDockyard")

				openDockyardClear = var_2
				gotoChargeScene = var_2_10003
				openDockyardIntensify = var_2_10004

				var_2_10000(var_8_0, var_2, var_2_10003, var_2_10004)

				return
			end
		})

		return false
	end

	return true
end

return var_0_1
