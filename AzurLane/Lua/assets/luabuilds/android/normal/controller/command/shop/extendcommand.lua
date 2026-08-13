class = var_0_10000

local var_0_0 = "ExtendCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count

	getProxy = var_1_10005
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getData(var_1_2)

	pg = var_1_2

	local var_1_4 = var_1_2.shop_template[var_1_0].effect_args

	ShopArgs = var_1_10009

	local var_1_5

	if var_1_4 == var_1_10009.EffecetEquipBagSize then
		var_1_5 = var_1_3

		var_1_3.addEquipmentBagCount(var_1_5, var_7.num * var_1_1)

		goto label_1_0
	end

	local var_1_6 = var_7.effect_args

	ShopArgs = var_1_5

	local var_1_7

	if var_1_6 == var_1_5.EffecetShipBagSize then
		var_1_7 = var_1_3

		var_1_3.addShipBagCount(var_1_7, var_7.num * var_1_1)

		goto label_1_0
	end

	local var_1_8 = var_7.effect_args

	ShopArgs = var_1_7

	if var_1_8 == var_1_7.EffectDromExpPos then
		getProxy = var_1_8
		DormProxy = var_9
		var_1_10010 = var_1_8(var_9)
		var_1_10011 = var_8.getData(var_1_10010)

		var_9.increaseTrainPos(var_1_10011)

		var_1_10011 = var_9

		var_9.increaseRestPos(var_1_10011)

		var_1_10011 = var_8
		var_1_10010 = var_8.updateDrom

		local var_1_9 = var_9

		BackYardConst = var_1_10013

		var_1_10010(var_1_10011, var_1_9, var_1_10013.DORM_UPDATE_TYPE_SHIP)

		var_1_10011 = arg_1_0
		var_1_10010 = arg_1_0.sendNotification
		GAME = var_1_9

		var_1_10010(var_1_10011, var_1_9.EXTEND_BACKYARD_DONE)

		goto label_1_0
	end

	local var_1_10 = var_7.effect_args

	ShopArgs = var_9

	if var_1_10 == var_9.EffectDromFoodMax then
		getProxy = var_1_10
		DormProxy = var_9
		var_1_10010 = var_1_10(var_9)
		var_1_10011 = var_8.getData(var_1_10010)

		var_9.extendFoodCapacity(var_1_10011, var_7.num)

		var_1_10011 = var_9

		var_9.increaseFoodExtendCount(var_1_10011)

		var_1_10011 = var_8
		var_1_10010 = var_8.updateDrom

		local var_1_11 = var_9

		BackYardConst = var_1_10013

		var_1_10010(var_1_10011, var_1_11, var_1_10013.DORM_UPDATE_TYPE_EXTENDFOOD)

		pg = var_1_10010
		var_1_10011 = var_1_10010.TipsMgr.GetInstance()
		var_1_10010 = var_1_10010.ShowTips
		i18n = var_1_11

		var_1_10010(var_1_10011, var_1_11("backyard_extendCapacity_ok", var_7.num))

		goto label_1_0
	end

	local var_1_12 = var_7.effect_args

	ShopArgs = var_9

	local var_1_13

	if var_1_12 == var_9.EffectShopStreetFlash then
		pg = var_1_12
		var_1_13 = var_1_12.TipsMgr.GetInstance()

		local var_1_14 = var_8.ShowTips

		i18n = var_1_10010

		var_1_14(var_1_13, var_1_10010("refresh_shopStreet_ok"))

		goto label_1_0
	end

	local var_1_15 = var_7.effect_args

	ShopArgs = var_1_13

	if var_1_15 ~= var_1_13.EffectTradingPortLevel then
		local var_1_16 = var_7.effect_args

		ShopArgs = var_1_19

		if var_1_16 ~= var_1_19.EffectOilFieldLevel then
			do
				local var_1_17 = var_7.effect_args

				ShopArgs = var_1_19

				local var_1_19

				if var_1_17 == var_1_19.EffectClassLevel then
					local var_1_18

					getProxy = var_1_19
					NavalAcademyProxy = var_1_10010
					var_1_19 = var_1_19(var_1_10010)
					var_1_10010 = var_7.effect_args
					ShopArgs = var_1_10011

					if var_1_10010 == var_1_10011.EffectTradingPortLevel then
						var_1_18 = var_1_19._goldVO
					else
						var_1_10010 = var_7.effect_args
						ShopArgs = var_1_10011

						if var_1_10010 == var_1_10011.EffectOilFieldLevel then
							var_1_18 = var_1_19._oilVO
						else
							var_1_10010 = var_7.effect_args
							ShopArgs = var_1_10011

							if var_1_10010 == var_1_10011.EffectClassLevel then
								var_1_10011 = var_1_19._classVO

								if var_1_18.GetLevel(var_1_10011) == 7 then
									pg = var_1_10011

									local var_1_20 = var_1_10011.TrackerMgr.GetInstance()

									var_1_10011 = var_1_10011.Tracking
									TRACKING_CLASS_LEVEL_UP_8 = var_1_10013

									var_1_10011(var_1_20, var_1_10013)
								elseif var_1_10010 == 8 then
									pg = var_1_10011

									local var_1_21 = var_1_10011.TrackerMgr.GetInstance()

									var_1_10011 = var_1_10011.Tracking
									TRACKING_CLASS_LEVEL_UP_9 = var_1_10013

									var_1_10011(var_1_21, var_1_10013)
								elseif var_1_10010 == 9 then
									pg = var_1_10011

									local var_1_22 = var_1_10011.TrackerMgr.GetInstance()

									var_1_10011 = var_1_10011.Tracking
									TRACKING_CLASS_LEVEL_UP_10 = var_1_10013

									var_1_10011(var_1_22, var_1_10013)
								end
							end
						end
					end

					var_1_10011 = var_1_19

					var_1_19.StartUpGradeSuccess(var_1_10011, var_1_18)

					PLATFORM_CODE = var_1_10010
					PLATFORM_US = var_1_10011

					local var_1_23

					if var_1_10010 == var_1_10011 then
						pg = var_1_10010
						var_1_10011 = var_1_10010.TipsMgr.GetInstance()
						var_1_10010 = var_1_10010.ShowTips
						i18n = var_1_23
						var_1_23 = var_1_23("word_start")
						var_1_10013 = " "
						i18n = var_1_10014

						var_1_10010(var_1_10011, var_1_23 .. var_1_10013 .. var_1_10014("word_levelup"))
					else
						pg = var_1_10010
						var_1_10011 = var_1_10010.TipsMgr.GetInstance()
						var_1_10010 = var_1_10010.ShowTips
						i18n = var_1_23

						local var_1_24 = var_1_23("word_start")

						i18n = var_1_10013

						var_1_10010(var_1_10011, var_1_24 .. var_1_10013("word_levelup"))
					end
				else
					local var_1_25 = var_7.effect_args

					ShopArgs = var_1_19

					local var_1_26

					if var_1_25 == var_1_19.EffectGuildFlash then
						pg = var_1_25
						var_1_26 = var_1_25.TipsMgr.GetInstance()

						local var_1_27 = var_8.ShowTips

						i18n = var_1_10010

						var_1_27(var_1_26, var_1_10010("guild_shop_flash_success"))
					else
						local var_1_28 = var_7.effect_args

						ShopArgs = var_1_26

						if var_1_28 == var_1_26.EffectDormFloor then
							getProxy = var_1_28
							DormProxy = var_9

							local var_1_29 = var_1_28(var_9)

							var_1_10011 = var_8.getData(var_1_29)

							var_9.setFloorNum(var_1_10011, var_9.floorNum + 1)

							var_1_10011 = var_8

							local var_1_30 = var_8.updateDrom
							local var_1_31 = var_9

							BackYardConst = var_1_10013

							var_1_30(var_1_10011, var_1_31, var_1_10013.DORM_UPDATE_TYPE_FLOOR)

							pg = var_1_30
							var_1_10011 = var_1_30.TipsMgr.GetInstance()

							local var_1_32 = var_10.ShowTips

							i18n = var_1_31

							var_1_32(var_1_10011, var_1_31("common_buy_success"))
						else
							local var_1_33 = var_7.effect_args

							ShopArgs = var_9

							local var_1_36

							if var_1_33 == var_9.EffectSkillPos then
								getProxy = var_1_33
								NavalAcademyProxy = var_1_36

								local var_1_34 = var_1_33(var_1_36)

								var_8.inCreaseKillClassNum(var_1_34)

								pg = var_1_36

								local var_1_35 = var_1_36.TipsMgr.GetInstance()

								var_1_36 = var_1_36.ShowTips
								i18n = var_1_10011

								var_1_36(var_1_35, var_1_10011("open_skill_class_success"))
							else
								local var_1_37 = var_7.effect_args

								ShopArgs = var_1_36

								local var_1_38

								if var_1_37 == var_1_36.EffectCommanderBagSize then
									var_1_38 = var_1_3

									var_1_3.updateCommanderBagMax(var_1_38, var_7.num)
								else
									local var_1_39 = var_7.effect_args

									ShopArgs = var_1_38

									if var_1_39 == var_1_38.EffectSpWeaponBagSize then
										getProxy = var_1_39
										EquipmentProxy = var_9

										local var_1_40 = var_1_39(var_9)

										var_1_39.AddSpWeaponCapacity(var_1_40, var_7.num)
									else
										assert = var_1_39

										var_1_39(false, "未处理类型")
									end
								end
							end
						end
					end
				end
			end

			::label_1_0::

			var_5:updatePlayer(var_1_3)

			return
		end
	end
end

return var_0_1
