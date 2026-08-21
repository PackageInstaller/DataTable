pg = pg or {}
pg.TrackerMgr = singletonClass("TrackerMgr")
TRACKING_ROLE_CREATE = "role_create"
TRACKING_ROLE_LOGIN = "role_login"
TRACKING_TUTORIAL_COMPLETE_1 = "tutorial_complete_1"
TRACKING_TUTORIAL_COMPLETE_2 = "tutorial_complete_2"
TRACKING_TUTORIAL_COMPLETE_3 = "tutorial_complete_3"
TRACKING_TUTORIAL_COMPLETE_4 = "tutorial_complete_4"
TRACKING_USER_LEVELUP = "user_levelup"
TRACKING_ROLE_LOGOUT = "role_logout"
TRACKING_PURCHASE_FIRST = "purchase_first"
TRACKING_PURCHASE_CLICK = "purchase_click"
TRACKING_PURCHASE_CLICK_MONTHLYCARD = "purchase_click_monthlycard"
TRACKING_PURCHASE_CLICK_GIFTBAG = "purchase_click_giftbag"
TRACKING_PURCHASE_CLICK_DIAMOND = "purchase_click_diamond"
TRACKING_PURCHASE = "purchase"
TRACKING_2D_RETENTION = "2d_retention"
TRACKING_7D_RETENTION = "7d_retention"
TRACKING_BUILD_SHIP = "build_ship"
TRACKING_SHIP_INTENSIFY = "ship_intensify"
TRACKING_SHIP_LEVEL_UP = "ship_level_up"
TRACKING_SHIP_HIGHEST_LEVEL = "ship_highest_level"
TRACKING_CUBE_ADD = "cube_add"
TRACKING_CUBE_CONSUME = "cube_consume"
TRACKING_USER_LEVEL_THIRTY = "user_level_thirty"
TRACKING_USER_LEVEL_FORTY = "user_level_forty"
TRACKING_PROPOSE_SHIP = "propose_ship"
TRACKING_REMOULD_SHIP = "remould_ship"
TRACKING_HARD_CHAPTER = "hard_chapter"
TRACKING_KILL_BOSS = "kill_boss"
TRACKING_HIGHEST_CHAPTER = "highest_chapter"
TRACKING_SHIPWORKS_COMPLETE = "shipworks_complete"
TRACKING_FIRST_PASS_3_4 = "first_pass_3-4"
TRACKING_FIRST_PASS_4_4 = "first_pass_4-4"
TRACKING_FIRST_PASS_5_4 = "first_pass_5-4"
TRACKING_FIRST_PASS_6_4 = "first_pass_6-4"
TRACKING_FIRST_PASS_12_4 = "first_pass_12_4"
TRACKING_FIRST_PASS_13_1 = "first_pass_13_1"
TRACKING_FIRST_PASS_13_2 = "first_pass_13_2"
TRACKING_FIRST_PASS_13_3 = "first_pass_13_3"
TRACKING_FIRST_PASS_13_4 = "first_pass_13_4"
TRACKING_CLASS_LEVEL_UP_8 = "class_level_up_8"
TRACKING_CLASS_LEVEL_UP_9 = "class_level_up_9"
TRACKING_CLASS_LEVEL_UP_10 = "class_level_up_10"
TRACKING_GUIDE_COMPLETE = "stdhour1"
TRACKING_EXP_LV_10 = "stdlevel10"
TRACKING_EXP_LV_20 = "stdlevel20"
TRACKING_EXP_LV_30 = "stdlevel30"
TRACKING_STRIKE_FAILD = "stdexhausted"
TRACKING_PAY_OIL = "stdstaminapurchase"
TRACKING_PAY_FAILD = "stdrechargeprompt"
TRACKING_PAY_SUCCESS = "stdrecharge"
TRACKING_BUILD_OR_SKIN_FAILD = "stdlackofdiamonds"
TRACKING_COST_300_D = "stdspend300"

function pg.TrackerMgr.Ctor(arg_1_0)
	local var_1_0

	if PLATFORM_CODE == PLATFORM_CH then
		var_1_0 = require("Mgr.Tracker.BiliTracker")
	elseif PLATFORM_CODE == PLATFORM_JP then
		var_1_0 = require("Mgr.Tracker.YoStarJPTracker")
	elseif PLATFORM_CODE == PLATFORM_US then
		var_1_0 = require("Mgr.Tracker.AiriUSTracker")
	elseif PLATFORM_CODE == PLATFORM_KR then
		var_1_0 = require("Mgr.Tracker.KwxyKrTracker")
	elseif PLATFORM_CODE == PLATFORM_CHT then
		var_1_0 = require("Mgr.Tracker.YongshiTracker")
	end

	if var_1_0 then
		arg_1_0.instance = var_1_0.New()
	end

	return
end

function pg.TrackerMgr.Call(arg_2_0, arg_2_1, ...)
	if arg_2_0.instance and arg_2_0.instance[arg_2_1] then
		arg_2_0.instance[arg_2_1](arg_2_0.instance, ...)
	end

	return
end

function pg.TrackerMgr.Tracking(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = getProxy(UserProxy)
	local var_3_1 = var_3_0 ~= nil and var_3_0:getData() or nil

	if var_3_1 ~= nil then
		local var_3_2 = var_3_1.uid or nil

		if var_3_2 == nil then
			return
		end

		local var_3_3 = getProxy(PlayerProxy)
		local var_3_4 = var_3_3 ~= nil and var_3_3:getData() or nil

		if var_3_4 ~= nil then
			local var_3_5 = var_3_4.id or nil

			var_3_5 = var_3_5 ~= nil and var_3_5 or arg_3_3

			if var_3_5 == nil then
				return
			end

			local var_3_6 = getProxy(ServerProxy)

			if arg_3_1 == TRACKING_2D_RETENTION or arg_3_1 == TRACKING_7D_RETENTION then
				local var_3_7 = "tracking_" .. arg_3_1

				if PlayerPrefs.GetInt("tracking_" .. arg_3_1, 0) <= 0 then
					originalPrint("tracking type : " .. arg_3_1 .. "   user_id:" .. var_3_5)
					PlayerPrefs.SetInt(var_3_7, 1)
					PlayerPrefs.Save()
					arg_3_0:Call("Tracking", arg_3_1, var_3_5, arg_3_2)
				end
			else
				originalPrint("tracking type : " .. arg_3_1 .. ",   user_id:" .. var_3_5 .. ",   data:" .. (arg_3_2 or "nil"))
				arg_3_0:Call("Tracking", arg_3_1, var_3_5, arg_3_2, var_3_6:getLastServer(var_3_2).id)
			end

			if arg_3_1 == TRACKING_PURCHASE_CLICK then
				if arg_3_2 == 1 then
					originalPrint("tracking type : " .. TRACKING_PURCHASE_CLICK_MONTHLYCARD .. "   user_id:" .. var_3_5)
					arg_3_0:Call("Tracking", TRACKING_PURCHASE_CLICK_MONTHLYCARD, var_3_5, arg_3_2)
				elseif arg_3_2 == 2 then
					originalPrint("tracking type : " .. TRACKING_PURCHASE_CLICK_GIFTBAG .. "   user_id:" .. var_3_5)
					arg_3_0:Call("Tracking", TRACKING_PURCHASE_CLICK_GIFTBAG, var_3_5, arg_3_2)
				else
					originalPrint("tracking type : " .. TRACKING_PURCHASE_CLICK_DIAMOND .. "   user_id:" .. var_3_5)
					arg_3_0:Call("Tracking", TRACKING_PURCHASE_CLICK_DIAMOND, var_3_5, arg_3_2)
				end
			end

			return
		end
	end
end

return
