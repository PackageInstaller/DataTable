class = var_0_10000

local var_0_0 = var_0_10000("YoStarJPTracker")

this = this

function var_0.Ctor(arg_1_0)
	local var_1_0 = {}

	TRACKING_ROLE_CREATE = var_1_10002
	var_1_0[var_1_10002] = "role_create"
	TRACKING_ROLE_LOGIN = var_1_10002
	var_1_0[var_1_10002] = "role_login"
	TRACKING_TUTORIAL_COMPLETE_1 = var_1_10002
	var_1_0[var_1_10002] = "tutorial_complete_1"
	TRACKING_TUTORIAL_COMPLETE_2 = var_1_10002
	var_1_0[var_1_10002] = "tutorial_complete_2"
	TRACKING_TUTORIAL_COMPLETE_3 = var_1_10002
	var_1_0[var_1_10002] = "tutorial_complete_3"
	TRACKING_TUTORIAL_COMPLETE_4 = var_1_10002
	var_1_0[var_1_10002] = "tutorial_complete_4"
	TRACKING_USER_LEVELUP = var_1_10002
	var_1_0[var_1_10002] = "user_levelup"
	TRACKING_ROLE_LOGOUT = var_1_10002
	var_1_0[var_1_10002] = "role_logout"
	TRACKING_PURCHASE_FIRST = var_1_10002
	var_1_0[var_1_10002] = "purchase_first"
	TRACKING_PURCHASE_CLICK = var_1_10002
	var_1_0[var_1_10002] = "purchase_click"
	TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_1_10002
	var_1_0[var_1_10002] = "purchase_click_monthlycard"
	TRACKING_PURCHASE_CLICK_GIFTBAG = var_1_10002
	var_1_0[var_1_10002] = "purchase_click_giftbag"
	TRACKING_PURCHASE_CLICK_DIAMOND = var_1_10002
	var_1_0[var_1_10002] = "purchase_click_diamond"
	TRACKING_2D_RETENTION = var_1_10002
	var_1_0[var_1_10002] = "2d_retention"
	TRACKING_7D_RETENTION = var_1_10002
	var_1_0[var_1_10002] = "7d_retention"
	TRACKING_BUILD_SHIP = var_1_10002
	var_1_0[var_1_10002] = "construct"
	TRACKING_SHIP_INTENSIFY = var_1_10002
	var_1_0[var_1_10002] = "strengthen"
	TRACKING_SHIP_LEVEL_UP = var_1_10002
	var_1_0[var_1_10002] = "levelup"
	TRACKING_SHIP_HIGHEST_LEVEL = var_1_10002
	var_1_0[var_1_10002] = "character_Max_level"
	TRACKING_CUBE_ADD = var_1_10002
	var_1_0[var_1_10002] = "cube_acquisition"
	TRACKING_CUBE_CONSUME = var_1_10002
	var_1_0[var_1_10002] = "cube_Consumption"
	TRACKING_USER_LEVEL_THIRTY = var_1_10002
	var_1_0[var_1_10002] = "level_30"
	TRACKING_USER_LEVEL_FORTY = var_1_10002
	var_1_0[var_1_10002] = "level_40"
	TRACKING_PROPOSE_SHIP = var_1_10002
	var_1_0[var_1_10002] = "married"
	TRACKING_REMOULD_SHIP = var_1_10002
	var_1_0[var_1_10002] = "remodeled"
	TRACKING_HARD_CHAPTER = var_1_10002
	var_1_0[var_1_10002] = "hard_clear"
	TRACKING_KILL_BOSS = var_1_10002
	var_1_0[var_1_10002] = "stage_laps"
	TRACKING_HIGHEST_CHAPTER = var_1_10002
	var_1_0[var_1_10002] = "stage"
	TRACKING_FIRST_PASS_3_4 = var_1_10002
	var_1_0[var_1_10002] = "3-4_clear"
	TRACKING_FIRST_PASS_4_4 = var_1_10002
	var_1_0[var_1_10002] = "4-4_clear"
	TRACKING_FIRST_PASS_5_4 = var_1_10002
	var_1_0[var_1_10002] = "5-4_clear"
	TRACKING_FIRST_PASS_6_4 = var_1_10002
	var_1_0[var_1_10002] = "6-4_clear"
	TRACKING_FIRST_PASS_12_4 = var_1_10002
	var_1_0[var_1_10002] = "12-4_clear"
	TRACKING_FIRST_PASS_13_1 = var_1_10002
	var_1_0[var_1_10002] = "13-1_clear"
	TRACKING_FIRST_PASS_13_2 = var_1_10002
	var_1_0[var_1_10002] = "13-2_clear"
	TRACKING_FIRST_PASS_13_3 = var_1_10002
	var_1_0[var_1_10002] = "13-3_clear"
	TRACKING_FIRST_PASS_13_4 = var_1_10002
	var_1_0[var_1_10002] = "13-4_clear"
	TRACKING_CLASS_LEVEL_UP_8 = var_1_10002
	var_1_0[var_1_10002] = "auditoriumLV_8"
	TRACKING_CLASS_LEVEL_UP_9 = var_1_10002
	var_1_0[var_1_10002] = "auditoriumLV_9"
	TRACKING_CLASS_LEVEL_UP_10 = var_1_10002
	var_1_0[var_1_10002] = "auditoriumLV_10"
	arg_1_0.mapping = var_1_0

	return
end

this = var_0

function var_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_0.mapping[arg_2_1] == nil then
		return
	end

	TRACKING_USER_LEVELUP = var_1_10005

	if arg_2_1 == var_1_10005 then
		originalPrint = var_1_10005

		var_1_10005("tracking lvl:" .. arg_2_3)

		YoStarUserEvent = var_1_10005

		local var_2_0 = var_1_10005.New(var_4)

		var_1_10005.AddParam(var_2_0, "lvl", arg_2_3)
		var_1_10005:AddParam("user_id", arg_2_2)

		pg = var_6

		local var_2_1 = var_6.SdkMgr.GetInstance()

		var_6.UserEventUpload(var_2_1, var_1_10005)

		goto label_2_0
	end

	TRACKING_PURCHASE_CLICK = var_1_10005

	if arg_2_1 == var_1_10005 then
		YoStarUserEvent = var_1_10005

		local var_2_2 = var_1_10005.New(var_4)

		var_1_10005.AddParam(var_2_2, "user_id", arg_2_2)

		pg = var_6

		local var_2_3 = var_6.SdkMgr.GetInstance()

		var_6.UserEventUpload(var_2_3, var_1_10005)

		goto label_2_0
	end

	TRACKING_PURCHASE_FIRST = var_1_10005

	if arg_2_1 == var_1_10005 then
		originalPrint = var_1_10005

		var_1_10005("order id : " .. arg_2_3)

		YoStarUserEvent = var_1_10005

		local var_2_4 = var_1_10005.New(var_4)

		var_1_10005.AddParam(var_2_4, "user_id", arg_2_2)
		var_1_10005:AddParam("order_id", arg_2_3)

		pg = var_6

		local var_2_5 = var_6.SdkMgr.GetInstance()

		var_6.UserEventUpload(var_2_5, var_1_10005)

		goto label_2_0
	end

	TRACKING_2D_RETENTION = var_1_10005

	if arg_2_1 ~= var_1_10005 then
		TRACKING_7D_RETENTION = var_1_10005

		if arg_2_1 == var_1_10005 then
			YoStarUserEvent = var_1_10005

			local var_2_6 = var_1_10005.New(var_4)

			var_1_10005.AddParam(var_2_6, "user_id", arg_2_2)

			pg = var_6

			local var_2_7 = var_6.SdkMgr.GetInstance()

			var_6.UserEventUpload(var_2_7, var_1_10005)
		else
			TRACKING_BUILD_SHIP = var_1_10005

			if arg_2_1 == var_1_10005 then
				YoStarUserEvent = var_1_10005

				local var_2_8 = var_1_10005.New(var_4)

				var_1_10005.AddParam(var_2_8, "user_id", arg_2_2)
				var_1_10005:AddParam("Cons_Num", arg_2_3)

				pg = var_6

				local var_2_9 = var_6.SdkMgr.GetInstance()

				var_6.UserEventUpload(var_2_9, var_1_10005)
			else
				TRACKING_SHIP_INTENSIFY = var_1_10005

				if arg_2_1 == var_1_10005 then
					YoStarUserEvent = var_1_10005

					local var_2_10 = var_1_10005.New(var_4)

					var_1_10005.AddParam(var_2_10, "user_id", arg_2_2)
					var_1_10005:AddParam("Cost_Num", arg_2_3)

					pg = var_6

					local var_2_11 = var_6.SdkMgr.GetInstance()

					var_6.UserEventUpload(var_2_11, var_1_10005)
				else
					TRACKING_SHIP_LEVEL_UP = var_1_10005

					if arg_2_1 == var_1_10005 then
						YoStarUserEvent = var_1_10005

						local var_2_12 = var_1_10005.New(var_4)

						var_1_10005.AddParam(var_2_12, "user_id", arg_2_2)
						var_1_10005:AddParam("Lvup_Num", arg_2_3)

						pg = var_6

						local var_2_13 = var_6.SdkMgr.GetInstance()

						var_6.UserEventUpload(var_2_13, var_1_10005)
					else
						TRACKING_SHIP_HIGHEST_LEVEL = var_1_10005

						if arg_2_1 == var_1_10005 then
							YoStarUserEvent = var_1_10005

							local var_2_14 = var_1_10005.New(var_4)

							var_1_10005.AddParam(var_2_14, "user_id", arg_2_2)
							var_1_10005:AddParam("Ship_Max_level", arg_2_3)

							pg = var_6

							local var_2_15 = var_6.SdkMgr.GetInstance()

							var_6.UserEventUpload(var_2_15, var_1_10005)
						else
							TRACKING_CUBE_ADD = var_1_10005

							if arg_2_1 == var_1_10005 then
								YoStarUserEvent = var_1_10005

								local var_2_16 = var_1_10005.New(var_4)

								var_1_10005.AddParam(var_2_16, "user_id", arg_2_2)
								var_1_10005:AddParam("Aqui_Num", arg_2_3)

								pg = var_6

								local var_2_17 = var_6.SdkMgr.GetInstance()

								var_6.UserEventUpload(var_2_17, var_1_10005)
							else
								TRACKING_CUBE_CONSUME = var_1_10005

								if arg_2_1 == var_1_10005 then
									YoStarUserEvent = var_1_10005

									local var_2_18 = var_1_10005.New(var_4)

									var_1_10005.AddParam(var_2_18, "user_id", arg_2_2)
									var_1_10005:AddParam("Consum_Num", arg_2_3)

									pg = var_6

									local var_2_19 = var_6.SdkMgr.GetInstance()

									var_6.UserEventUpload(var_2_19, var_1_10005)
								else
									TRACKING_PROPOSE_SHIP = var_1_10005

									if arg_2_1 == var_1_10005 then
										YoStarUserEvent = var_1_10005

										local var_2_20 = var_1_10005.New(var_4)

										var_1_10005.AddParam(var_2_20, "user_id", arg_2_2)
										var_1_10005:AddParam("Married_Id", arg_2_3)

										pg = var_6

										local var_2_21 = var_6.SdkMgr.GetInstance()

										var_6.UserEventUpload(var_2_21, var_1_10005)
									else
										TRACKING_REMOULD_SHIP = var_1_10005

										if arg_2_1 == var_1_10005 then
											YoStarUserEvent = var_1_10005

											local var_2_22 = var_1_10005.New(var_4)

											var_1_10005.AddParam(var_2_22, "user_id", arg_2_2)
											var_1_10005:AddParam("Remodel_Id", arg_2_3)

											pg = var_6

											local var_2_23 = var_6.SdkMgr.GetInstance()

											var_6.UserEventUpload(var_2_23, var_1_10005)
										else
											TRACKING_HARD_CHAPTER = var_1_10005

											if arg_2_1 == var_1_10005 then
												YoStarUserEvent = var_1_10005

												local var_2_24 = var_1_10005.New(var_4)

												var_1_10005.AddParam(var_2_24, "user_id", arg_2_2)
												var_1_10005:AddParam("Clear_Stage_Id", arg_2_3)

												pg = var_6

												local var_2_25 = var_6.SdkMgr.GetInstance()

												var_6.UserEventUpload(var_2_25, var_1_10005)
											else
												TRACKING_HIGHEST_CHAPTER = var_1_10005

												if arg_2_1 == var_1_10005 then
													YoStarUserEvent = var_1_10005

													local var_2_26 = var_1_10005.New(var_4)

													var_1_10005.AddParam(var_2_26, "user_id", arg_2_2)
													var_1_10005:AddParam("Clear_Stage_Id", arg_2_3)

													pg = var_6

													local var_2_27 = var_6.SdkMgr.GetInstance()

													var_6.UserEventUpload(var_2_27, var_1_10005)
												else
													YoStarUserEvent = var_1_10005

													local var_2_28 = var_1_10005.New(var_4)

													var_5.AddParam(var_2_28, "user_id", arg_2_2)

													pg = var_6

													local var_2_29 = var_6.SdkMgr.GetInstance()

													var_6.UserEventUpload(var_2_29, var_5)
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		::label_2_0::

		return
	end
end

this = var_0

return var_0
