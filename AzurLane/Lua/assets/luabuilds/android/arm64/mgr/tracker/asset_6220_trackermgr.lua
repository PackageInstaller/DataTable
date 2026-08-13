pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.TrackerMgr = var_0_10001("TrackerMgr")
pg = var_0

local var_0_1 = var_0.TrackerMgr
local var_0_2 = "role_create"
local var_0_3 = TRACKING_ROLE_CREATE
local var_0_4 = "role_login"
local var_0_5 = TRACKING_ROLE_LOGIN
local var_0_6 = "tutorial_complete_1"
local var_0_7 = TRACKING_TUTORIAL_COMPLETE_1
local var_0_8 = "tutorial_complete_2"
local var_0_9 = TRACKING_TUTORIAL_COMPLETE_2
local var_0_10 = "tutorial_complete_3"
local var_0_11 = TRACKING_TUTORIAL_COMPLETE_3
local var_0_12 = "tutorial_complete_4"
local var_0_13 = TRACKING_TUTORIAL_COMPLETE_4
local var_0_14 = "user_levelup"
local var_0_15 = TRACKING_USER_LEVELUP
local var_0_16 = "role_logout"
local var_0_17 = TRACKING_ROLE_LOGOUT
local var_0_18 = "purchase_first"
local var_0_19 = TRACKING_PURCHASE_FIRST
local var_0_20 = "purchase_click"
local var_0_21 = TRACKING_PURCHASE_CLICK
local var_0_22 = "purchase_click_monthlycard"
local var_0_23 = TRACKING_PURCHASE_CLICK_MONTHLYCARD
local var_0_24 = "purchase_click_giftbag"
local var_0_25 = TRACKING_PURCHASE_CLICK_GIFTBAG
local var_0_26 = "purchase_click_diamond"
local var_0_27 = TRACKING_PURCHASE_CLICK_DIAMOND
local var_0_28 = "purchase"
local var_0_29 = TRACKING_PURCHASE
local var_0_30 = "2d_retention"
local var_0_31 = TRACKING_2D_RETENTION
local var_0_32 = "7d_retention"
local var_0_33 = TRACKING_7D_RETENTION
local var_0_34 = "build_ship"
local var_0_35 = TRACKING_BUILD_SHIP
local var_0_36 = "ship_intensify"
local var_0_37 = TRACKING_SHIP_INTENSIFY
local var_0_38 = "ship_level_up"
local var_0_39 = TRACKING_SHIP_LEVEL_UP
local var_0_40 = "ship_highest_level"
local var_0_41 = TRACKING_SHIP_HIGHEST_LEVEL
local var_0_42 = "cube_add"
local var_0_43 = TRACKING_CUBE_ADD
local var_0_44 = "cube_consume"
local var_0_45 = TRACKING_CUBE_CONSUME
local var_0_46 = "user_level_thirty"
local var_0_47 = TRACKING_USER_LEVEL_THIRTY
local var_0_48 = "user_level_forty"
local var_0_49 = TRACKING_USER_LEVEL_FORTY
local var_0_50 = "propose_ship"
local var_0_51 = TRACKING_PROPOSE_SHIP
local var_0_52 = "remould_ship"
local var_0_53 = TRACKING_REMOULD_SHIP
local var_0_54 = "hard_chapter"
local var_0_55 = TRACKING_HARD_CHAPTER
local var_0_56 = "kill_boss"
local var_0_57 = TRACKING_KILL_BOSS
local var_0_58 = "highest_chapter"
local var_0_59 = TRACKING_HIGHEST_CHAPTER
local var_0_60 = "shipworks_complete"
local var_0_61 = TRACKING_SHIPWORKS_COMPLETE
local var_0_62 = "first_pass_3-4"
local var_0_63 = TRACKING_FIRST_PASS_3_4
local var_0_64 = "first_pass_4-4"
local var_0_65 = TRACKING_FIRST_PASS_4_4
local var_0_66 = "first_pass_5-4"
local var_0_67 = TRACKING_FIRST_PASS_5_4
local var_0_68 = "first_pass_6-4"
local var_0_69 = TRACKING_FIRST_PASS_6_4
local var_0_70 = "first_pass_12_4"
local var_0_71 = TRACKING_FIRST_PASS_12_4
local var_0_72 = "first_pass_13_1"
local var_0_73 = TRACKING_FIRST_PASS_13_1
local var_0_74 = "first_pass_13_2"
local var_0_75 = TRACKING_FIRST_PASS_13_2
local var_0_76 = "first_pass_13_3"
local var_0_77 = TRACKING_FIRST_PASS_13_3
local var_0_78 = "first_pass_13_4"
local var_0_79 = TRACKING_FIRST_PASS_13_4
local var_0_80 = "class_level_up_8"
local var_0_81 = TRACKING_CLASS_LEVEL_UP_8
local var_0_82 = "class_level_up_9"
local var_0_83 = TRACKING_CLASS_LEVEL_UP_9
local var_0_84 = "class_level_up_10"
local var_0_85 = TRACKING_CLASS_LEVEL_UP_10
local var_0_86 = "stdhour1"
local var_0_87 = TRACKING_GUIDE_COMPLETE
local var_0_88 = "stdlevel10"
local var_0_89 = TRACKING_EXP_LV_10
local var_0_90 = "stdlevel20"
local var_0_91 = TRACKING_EXP_LV_20
local var_0_92 = "stdlevel30"
local var_0_93 = TRACKING_EXP_LV_30
local var_0_94 = "stdexhausted"
local var_0_95 = TRACKING_STRIKE_FAILD
local var_0_96 = "stdstaminapurchase"
local var_0_97 = TRACKING_PAY_OIL
local var_0_98 = "stdrechargeprompt"
local var_0_99 = TRACKING_PAY_FAILD
local var_0_100 = "stdrecharge"
local var_0_101 = TRACKING_PAY_SUCCESS
local var_0_102 = "stdlackofdiamonds"
local var_0_103 = TRACKING_BUILD_OR_SKIN_FAILD
local var_0_104 = "stdspend300"
local var_0_105 = TRACKING_COST_300_D

function var_0_1.Ctor(arg_1_0)
	local var_1_0

	PLATFORM_CODE = var_1_10002
	PLATFORM_CH = var_1_10003

	if var_1_10002 == var_1_10003 then
		require = var_1_10002
		var_1_0 = var_1_10002("Mgr.Tracker.BiliTracker")
	else
		PLATFORM_CODE = var_1_10002
		PLATFORM_JP = var_1_10003

		if var_1_10002 == var_1_10003 then
			require = var_1_10002
			var_1_0 = var_1_10002("Mgr.Tracker.YoStarJPTracker")
		else
			PLATFORM_CODE = var_1_10002
			PLATFORM_US = var_1_10003

			if var_1_10002 == var_1_10003 then
				require = var_1_10002
				var_1_0 = var_1_10002("Mgr.Tracker.AiriUSTracker")
			else
				PLATFORM_CODE = var_1_10002
				PLATFORM_KR = var_1_10003

				if var_1_10002 == var_1_10003 then
					require = var_1_10002
					var_1_0 = var_1_10002("Mgr.Tracker.KwxyKrTracker")
				else
					PLATFORM_CODE = var_1_10002
					PLATFORM_CHT = var_1_10003

					if var_1_10002 == var_1_10003 then
						require = var_1_10002
						var_1_0 = var_1_10002("Mgr.Tracker.YongshiTracker")
					end
				end
			end
		end
	end

	if var_1_0 then
		arg_1_0.instance = var_1_0.New()
	end

	return
end

function var_0_1.Call(arg_2_0, arg_2_1, ...)
	if arg_2_0.instance and arg_2_0.instance[arg_2_1] then
		arg_2_0.instance[arg_2_1](arg_2_0.instance, ...)
	end

	return
end

function var_0_1.Tracking(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	getProxy = var_1_10004
	UserProxy = var_1_10006

	if var_1_10004(var_1_10006) ~= nil then
		var_1_10007 = var_4

		local var_3_0

		if not var_4.getData(var_1_10007) then
			var_3_0 = nil
		end

		local var_3_1

		if var_3_0 == nil or not var_3_0.uid then
			var_3_1 = nil
		end

		if var_3_1 == nil then
			return
		end

		getProxy = var_1_10007
		PlayerProxy = var_1_10009

		if var_1_10007(var_1_10009) ~= nil then
			var_1_10010 = var_7

			local var_3_2

			if not var_7.getData(var_1_10010) then
				var_3_2 = nil
			end

			local var_3_3

			if var_3_2 == nil or not var_3_2.id then
				var_3_3 = nil
			end

			var_3_3 = var_3_3 ~= nil and var_3_3 or arg_3_3

			if var_3_3 == nil then
				return
			end

			getProxy = var_1_10010
			ServerProxy = var_1_10012

			local var_3_4 = var_1_10010(var_1_10012)
			local var_3_5 = var_10.getLastServer(var_3_4, var_3_1).id

			TRACKING_2D_RETENTION = var_3_4

			if arg_3_1 ~= var_3_4 then
				TRACKING_7D_RETENTION = var_3_4

				if arg_3_1 == var_3_4 then
					var_3_4 = "tracking_" .. arg_3_1
					PlayerPrefs = var_14

					if var_14.GetInt(var_3_4, 0) <= 0 then
						originalPrint = var_15

						var_15("tracking type : " .. arg_3_1 .. "   user_id:" .. var_3_3)

						PlayerPrefs = var_15

						var_15.SetInt(var_3_4, 1)

						PlayerPrefs = var_15

						var_15.Save()
						arg_3_0:Call("Tracking", arg_3_1, var_3_3, arg_3_2)
					end
				else
					originalPrint = var_3_4

					var_3_4("tracking type : " .. arg_3_1 .. ",   user_id:" .. var_3_3 .. ",   data:" .. (arg_3_2 or "nil"))
					arg_3_0:Call("Tracking", arg_3_1, var_3_3, arg_3_2, var_3_5)
				end

				TRACKING_PURCHASE_CLICK = var_3_4

				if arg_3_1 == var_3_4 then
					if arg_3_2 == 1 then
						originalPrint = var_3_4

						local var_3_6 = "tracking type : "

						TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_1_10016

						var_3_4(var_3_6 .. var_1_10016 .. "   user_id:" .. var_3_3)

						local var_3_7 = arg_3_0

						var_3_4 = arg_3_0.Call
						var_1_10016 = "Tracking"
						TRACKING_PURCHASE_CLICK_MONTHLYCARD = var_17

						var_3_4(var_3_7, var_1_10016, var_17, var_3_3, arg_3_2)
					elseif arg_3_2 == 2 then
						originalPrint = var_3_4

						local var_3_8 = "tracking type : "

						TRACKING_PURCHASE_CLICK_GIFTBAG = var_1_10016

						var_3_4(var_3_8 .. var_1_10016 .. "   user_id:" .. var_3_3)

						local var_3_9 = arg_3_0

						var_3_4 = arg_3_0.Call
						var_1_10016 = "Tracking"
						TRACKING_PURCHASE_CLICK_GIFTBAG = var_17

						var_3_4(var_3_9, var_1_10016, var_17, var_3_3, arg_3_2)
					else
						originalPrint = var_3_4

						local var_3_10 = "tracking type : "

						TRACKING_PURCHASE_CLICK_DIAMOND = var_1_10016

						var_3_4(var_3_10 .. var_1_10016 .. "   user_id:" .. var_3_3)

						local var_3_11 = arg_3_0
						local var_3_12 = arg_3_0.Call
						local var_3_13 = "Tracking"

						TRACKING_PURCHASE_CLICK_DIAMOND = var_17

						var_3_12(var_3_11, var_3_13, var_17, var_3_3, arg_3_2)
					end
				end

				return
			end
		end
	end
end

return
