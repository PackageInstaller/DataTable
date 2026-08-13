class = var_0_10000

local var_0_0 = var_0_10000("AiriUSTracker")

var_0_0.DEV_TOKEN = "2KtJzaeLzGnPUhtOY4-LYw"
var_0_0.ANDROID_LINK_ID = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
var_0_0.IOS_LINK_ID = "F7FE029D3F957A107D358D2BB93CA7E2"

function var_0_0.Ctor(arg_1_0)
	arg_1_0.mapping = {}

	local var_1_0 = arg_1_0.mapping

	TRACKING_ROLE_CREATE = var_1_10002
	var_1_0[var_1_10002] = "role_create"

	local var_1_1 = arg_1_0.mapping

	TRACKING_ROLE_LOGIN = var_1_10002
	var_1_1[var_1_10002] = "role_login"

	local var_1_2 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_1 = var_1_10002
	var_1_2[var_1_10002] = "tutorial_complete_1"

	local var_1_3 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_2 = var_1_10002
	var_1_3[var_1_10002] = "tutorial_complete_2"

	local var_1_4 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_3 = var_1_10002
	var_1_4[var_1_10002] = "tutorial_complete_3"

	local var_1_5 = arg_1_0.mapping

	TRACKING_TUTORIAL_COMPLETE_4 = var_1_10002
	var_1_5[var_1_10002] = "tutorial_complete_4"

	local var_1_6 = arg_1_0.mapping

	TRACKING_USER_LEVELUP = var_1_10002
	var_1_6[var_1_10002] = "user_levelup"

	local var_1_7 = arg_1_0.mapping

	TRACKING_ROLE_LOGOUT = var_1_10002
	var_1_7[var_1_10002] = "role_logout"

	local var_1_8 = arg_1_0.mapping

	TRACKING_PURCHASE_FIRST = var_1_10002
	var_1_8[var_1_10002] = "purchase_first"

	local var_1_9 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK = var_1_10002
	var_1_9[var_1_10002] = "purchase_click"

	local var_1_10 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_1_10002
	var_1_10[var_1_10002] = "purchase_click_monthlycard"

	local var_1_11 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK_GIFTBAG = var_1_10002
	var_1_11[var_1_10002] = "purchase_click_giftbag"

	local var_1_12 = arg_1_0.mapping

	TRACKING_PURCHASE_CLICK_DIAMOND = var_1_10002
	var_1_12[var_1_10002] = "purchase_click_diamond"

	local var_1_13 = arg_1_0.mapping

	TRACKING_PURCHASE = var_1_10002
	var_1_13[var_1_10002] = "purchase"

	local var_1_14 = arg_1_0.mapping

	TRACKING_2D_RETENTION = var_1_10002
	var_1_14[var_1_10002] = "2d_retention"

	local var_1_15 = arg_1_0.mapping

	TRACKING_7D_RETENTION = var_1_10002
	var_1_15[var_1_10002] = "7d_retention"

	return
end

function var_0_0.Tracking(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
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
			TRACKING_PURCHASE = var_1_10005

			if arg_2_1 ~= var_1_10005 then
				YoStarUserEvent = var_1_10005

				local var_2_8 = var_1_10005.New(var_4)

				var_1_10005.AddParam(var_2_8, "user_id", arg_2_2)

				pg = var_6

				local var_2_9 = var_6.SdkMgr.GetInstance()

				var_6.UserEventUpload(var_2_9, var_1_10005)
			end
		end

		::label_2_0::

		pg = var_1_10005

		local var_2_10 = var_1_10005.SdkMgr.GetInstance()

		if var_5.GetChannelUID(var_2_10) == "0" then
			TRACKING_PURCHASE_CLICK = var_2_10

			if arg_2_1 == var_2_10 then
				local var_2_11 = arg_2_0

				var_2_10 = arg_2_0.transMoney
				pg = var_1_10008
				var_2_10 = var_2_10(var_2_11, var_1_10008.pay_data_display[arg_2_3].money)
				var_1_10008 = arg_2_0

				local var_2_12 = arg_2_0.YS_S2S
				local var_2_13 = var_0_0.DEV_TOKEN
				local var_2_14 = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
				local var_2_15 = "Azur Lane (Android) S2S_purchase_click"

				var_1_10012 = ""
				tostring = var_1_10013
				var_1_10013 = var_1_10013(var_2_10)
				pg = var_14
				var_1_10015 = var_14.SdkMgr.GetInstance()

				local var_2_16 = var_14.GetDeviceId(var_1_10015)

				tostring = var_1_10015
				pg = var_1_10016

				local var_2_17 = var_1_10016.TimeMgr.GetInstance()

				var_2_12(var_1_10008, var_2_13, var_2_14, var_2_15, var_1_10012, var_1_10013, var_2_16, var_1_10015(var_1_10016.GetServerTime(var_2_17)))
			else
				TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_2_10

				if arg_2_1 == var_2_10 then
					local var_2_18 = arg_2_0

					var_2_10 = arg_2_0.transMoney
					pg = var_1_10008
					var_2_10 = var_2_10(var_2_18, var_1_10008.pay_data_display[arg_2_3].money)
					var_1_10008 = arg_2_0

					local var_2_19 = arg_2_0.YS_S2S
					local var_2_20 = var_0_0.DEV_TOKEN
					local var_2_21 = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
					local var_2_22 = "Azur Lane (Android) S2S_purchase_click_monthlycard"

					var_1_10012 = ""
					tostring = var_1_10013
					var_1_10013 = var_1_10013(var_2_10)
					pg = var_14
					var_1_10015 = var_14.SdkMgr.GetInstance()

					local var_2_23 = var_14.GetDeviceId(var_1_10015)

					tostring = var_1_10015
					pg = var_1_10016

					local var_2_24 = var_1_10016.TimeMgr.GetInstance()

					var_2_19(var_1_10008, var_2_20, var_2_21, var_2_22, var_1_10012, var_1_10013, var_2_23, var_1_10015(var_1_10016.GetServerTime(var_2_24)))
				else
					TRACKING_PURCHASE_CLICK_DIAMOND = var_2_10

					if arg_2_1 == var_2_10 then
						local var_2_25 = arg_2_0

						var_2_10 = arg_2_0.transMoney
						pg = var_1_10008
						var_2_10 = var_2_10(var_2_25, var_1_10008.pay_data_display[arg_2_3].money)
						var_1_10008 = arg_2_0

						local var_2_26 = arg_2_0.YS_S2S
						local var_2_27 = var_0_0.DEV_TOKEN
						local var_2_28 = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
						local var_2_29 = "Azur Lane (Android) S2S_purchase_click_diamond"

						var_1_10012 = ""
						tostring = var_1_10013
						var_1_10013 = var_1_10013(var_2_10)
						pg = var_14
						var_1_10015 = var_14.SdkMgr.GetInstance()

						local var_2_30 = var_14.GetDeviceId(var_1_10015)

						tostring = var_1_10015
						pg = var_1_10016

						local var_2_31 = var_1_10016.TimeMgr.GetInstance()

						var_2_26(var_1_10008, var_2_27, var_2_28, var_2_29, var_1_10012, var_1_10013, var_2_30, var_1_10015(var_1_10016.GetServerTime(var_2_31)))
					else
						TRACKING_PURCHASE_CLICK_GIFTBAG = var_2_10

						if arg_2_1 == var_2_10 then
							local var_2_32 = arg_2_0

							var_2_10 = arg_2_0.transMoney
							pg = var_1_10008
							var_2_10 = var_2_10(var_2_32, var_1_10008.pay_data_display[arg_2_3].money)
							var_1_10008 = arg_2_0

							local var_2_33 = arg_2_0.YS_S2S
							local var_2_34 = var_0_0.DEV_TOKEN
							local var_2_35 = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
							local var_2_36 = "Azur Lane (Android) S2S_purchase_click_giftbag"

							var_1_10012 = ""
							tostring = var_1_10013
							var_1_10013 = var_1_10013(var_2_10)
							pg = var_14
							var_1_10015 = var_14.SdkMgr.GetInstance()

							local var_2_37 = var_14.GetDeviceId(var_1_10015)

							tostring = var_1_10015
							pg = var_1_10016

							local var_2_38 = var_1_10016.TimeMgr.GetInstance()

							var_2_33(var_1_10008, var_2_34, var_2_35, var_2_36, var_1_10012, var_1_10013, var_2_37, var_1_10015(var_1_10016.GetServerTime(var_2_38)))
						else
							TRACKING_PURCHASE = var_2_10

							if arg_2_1 == var_2_10 then
								local var_2_39 = arg_2_0

								var_2_10 = arg_2_0.transMoney
								pg = var_1_10008
								var_2_10 = var_2_10(var_2_39, var_1_10008.pay_data_display[arg_2_3].money)
								var_1_10008 = arg_2_0

								local var_2_40 = arg_2_0.YS_S2S
								local var_2_41 = var_0_0.DEV_TOKEN
								local var_2_42 = "DE31AE06D3CE21EE3A9E1A1BCEB506E1"
								local var_2_43 = "Azur Lane (Android) S2S_purchase"

								var_1_10012 = ""
								tostring = var_1_10013

								local var_2_44 = var_1_10013(var_2_10)

								pg = var_14
								var_1_10015 = var_14.SdkMgr.GetInstance()

								local var_2_45 = var_14.GetDeviceId(var_1_10015)

								tostring = var_1_10015
								pg = var_1_10016

								local var_2_46 = var_1_10016.TimeMgr.GetInstance()

								var_2_40(var_1_10008, var_2_41, var_2_42, var_2_43, var_1_10012, var_2_44, var_2_45, var_1_10015(var_16.GetServerTime(var_2_46)))
							end
						end
					end
				end
			end
		else
			TRACKING_PURCHASE_CLICK = var_2_10

			if arg_2_1 == var_2_10 then
				local var_2_47 = arg_2_0

				var_2_10 = arg_2_0.transMoney
				pg = var_1_10008
				var_2_10 = var_2_10(var_2_47, var_1_10008.pay_data_display[arg_2_3].money)
				YS2S = var_2_47

				local var_2_48 = var_2_47.S2S

				var_1_10008 = var_0_0.DEV_TOKEN

				local var_2_49 = "F7FE029D3F957A107D358D2BB93CA7E2"
				local var_2_50 = "Azur Lane (iOS) S2S_purchase_click"
				local var_2_51 = ""

				tostring = var_1_10012
				var_1_10012 = var_1_10012(var_2_10)
				pg = var_13

				local var_2_52 = var_13.SdkMgr.GetInstance()
				local var_2_53 = var_13.GetDeviceId(var_2_52)

				tostring = var_2_52
				pg = var_1_10015

				local var_2_54 = var_1_10015.TimeMgr.GetInstance()

				var_2_48(var_1_10008, var_2_49, var_2_50, var_2_51, var_1_10012, var_2_53, var_2_52(var_1_10015.GetServerTime(var_2_54)))
			else
				TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_2_10

				if arg_2_1 == var_2_10 then
					local var_2_55 = arg_2_0

					var_2_10 = arg_2_0.transMoney
					pg = var_1_10008
					var_2_10 = var_2_10(var_2_55, var_1_10008.pay_data_display[arg_2_3].money)
					YS2S = var_2_55

					local var_2_56 = var_2_55.S2S

					var_1_10008 = var_0_0.DEV_TOKEN

					local var_2_57 = "F7FE029D3F957A107D358D2BB93CA7E2"
					local var_2_58 = "Azur Lane (iOS) S2S_purchase_click_monthlycard"
					local var_2_59 = ""

					tostring = var_1_10012
					var_1_10012 = var_1_10012(var_2_10)
					pg = var_13

					local var_2_60 = var_13.SdkMgr.GetInstance()
					local var_2_61 = var_13.GetDeviceId(var_2_60)

					tostring = var_2_60
					pg = var_1_10015

					local var_2_62 = var_1_10015.TimeMgr.GetInstance()

					var_2_56(var_1_10008, var_2_57, var_2_58, var_2_59, var_1_10012, var_2_61, var_2_60(var_1_10015.GetServerTime(var_2_62)))
				else
					TRACKING_PURCHASE_CLICK_DIAMOND = var_2_10

					if arg_2_1 == var_2_10 then
						local var_2_63 = arg_2_0

						var_2_10 = arg_2_0.transMoney
						pg = var_1_10008
						var_2_10 = var_2_10(var_2_63, var_1_10008.pay_data_display[arg_2_3].money)
						YS2S = var_2_63

						local var_2_64 = var_2_63.S2S

						var_1_10008 = var_0_0.DEV_TOKEN

						local var_2_65 = "F7FE029D3F957A107D358D2BB93CA7E2"
						local var_2_66 = "Azur Lane (iOS) S2S_purchase_click_diamond"
						local var_2_67 = ""

						tostring = var_1_10012
						var_1_10012 = var_1_10012(var_2_10)
						pg = var_13

						local var_2_68 = var_13.SdkMgr.GetInstance()
						local var_2_69 = var_13.GetDeviceId(var_2_68)

						tostring = var_2_68
						pg = var_1_10015

						local var_2_70 = var_1_10015.TimeMgr.GetInstance()

						var_2_64(var_1_10008, var_2_65, var_2_66, var_2_67, var_1_10012, var_2_69, var_2_68(var_1_10015.GetServerTime(var_2_70)))
					else
						TRACKING_PURCHASE_CLICK_GIFTBAG = var_2_10

						if arg_2_1 == var_2_10 then
							local var_2_71 = arg_2_0

							var_2_10 = arg_2_0.transMoney
							pg = var_1_10008
							var_2_10 = var_2_10(var_2_71, var_1_10008.pay_data_display[arg_2_3].money)
							YS2S = var_2_71

							local var_2_72 = var_2_71.S2S

							var_1_10008 = var_0_0.DEV_TOKEN

							local var_2_73 = "F7FE029D3F957A107D358D2BB93CA7E2"
							local var_2_74 = "Azur Lane (iOS) S2S_purchase_click_giftbag"
							local var_2_75 = ""

							tostring = var_1_10012
							var_1_10012 = var_1_10012(var_2_10)
							pg = var_13

							local var_2_76 = var_13.SdkMgr.GetInstance()
							local var_2_77 = var_13.GetDeviceId(var_2_76)

							tostring = var_2_76
							pg = var_1_10015

							local var_2_78 = var_1_10015.TimeMgr.GetInstance()

							var_2_72(var_1_10008, var_2_73, var_2_74, var_2_75, var_1_10012, var_2_77, var_2_76(var_1_10015.GetServerTime(var_2_78)))
						else
							TRACKING_PURCHASE = var_2_10

							if arg_2_1 == var_2_10 then
								local var_2_79 = arg_2_0

								var_2_10 = arg_2_0.transMoney
								pg = var_1_10008
								var_2_10 = var_2_10(var_2_79, var_1_10008.pay_data_display[arg_2_3].money)
								YS2S = var_2_79

								local var_2_80 = var_2_79.S2S
								local var_2_81 = var_0_0.DEV_TOKEN
								local var_2_82 = "F7FE029D3F957A107D358D2BB93CA7E2"
								local var_2_83 = "Azur Lane (iOS) S2S_purchase"
								local var_2_84 = ""

								tostring = var_1_10012

								local var_2_85 = var_1_10012(var_2_10)

								pg = var_13

								local var_2_86 = var_13.SdkMgr.GetInstance()
								local var_2_87 = var_13.GetDeviceId(var_2_86)

								tostring = var_2_86
								pg = var_1_10015

								local var_2_88 = var_1_10015.TimeMgr.GetInstance()

								var_2_80(var_2_81, var_2_82, var_2_83, var_2_84, var_2_85, var_2_87, var_2_86(var_15.GetServerTime(var_2_88)))
							end
						end
					end
				end
			end
		end

		originalPrint = var_2_10

		var_2_10("track done.")

		return
	end
end

function var_0_0.YS_S2S(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	pg = var_1_10008

	local var_3_0 = var_1_10008.SdkMgr.GetInstance()
	local var_3_1 = var_8.GetChannelUID(var_3_0) == "0"
	local var_3_2 = "https://www.googleadservices.com/pagead/conversion/app/1.0?"
	local var_3_3 = {
		dev_token = arg_3_1,
		link_id = arg_3_2
	}

	var_3_3.app_event_type = "custom"
	var_3_3.app_event_name = arg_3_3

	if arg_3_4 then
		var_3_3.app_event_data = arg_3_4
	end

	var_3_3.rdid = arg_3_6

	if var_3_1 then
		var_3_3.id_type = "advertisingid"
	else
		var_3_3.id_type = "idfa"
	end

	var_3_3.lat = "0"
	Application = var_11
	var_3_3.app_version = var_11.version
	SystemInfo = var_11
	var_3_3.os_version = var_11.operatingSystem
	var_3_3.sdk_version = "1.9.5r6"
	var_3_3.timestamp = arg_3_7 .. ".000001"
	var_3_3.value = arg_3_5
	var_3_3.currency_code = "USD"
	pairs = var_11

	for iter_3_0, iter_3_1 in var_11(var_3_3) do
		var_3_2 = var_3_2 .. iter_3_0 .. "=" .. iter_3_1 .. "&"
	end

	string = var_11

	local var_3_4 = var_11.sub(var_3_2, 1, -2)

	originalPrint = var_12

	var_12(var_3_2)

	VersionMgr = var_12

	local var_3_5 = var_12.Inst

	var_12.WebRequest(var_3_5, var_3_4, function(arg_4_0, arg_4_1)
		originalPrint = var_2_10002

		var_2_10002("code:" .. arg_4_0 .. " content:" .. arg_4_1)

		return
	end)

	return
end

function var_0_0.transMoney(arg_5_0, arg_5_1)
	string = var_1_10002

	return var_1_10002.format("%.2f", arg_5_1 / 100)
end

return var_0_0
