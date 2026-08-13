class = var_0_10000

local var_0_0 = "ZengKeMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))
local var_0_2 = 71151
local var_0_3 = 50013
local var_0_4 = 50013

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	arg_1_0.bg = arg_1_0:findTF("AD")
	arg_1_0.btnList = arg_1_0:findTF("btn_list", arg_1_0.bg)

	local var_1_0 = arg_1_0.bg

	arg_1_0.build_bgtime = var_1.Find(var_1_0, "btn_list/build/build_bgtime")

	local var_1_1 = arg_1_0.bg

	arg_1_0.build_time = var_1.Find(var_1_1, "btn_list/build/build_bgtime/time")

	local var_1_2 = arg_1_0.bg

	arg_1_0.shop_bgtime = var_1.Find(var_1_2, "btn_list/shop/shop_bgtime")

	local var_1_3 = arg_1_0.bg

	arg_1_0.shop_time = var_1.Find(var_1_3, "btn_list/shop/shop_bgtime/time")

	local var_1_4 = arg_1_0.bg

	arg_1_0.Manual = var_1.Find(var_1_4, "Manual")
	SetActive = var_1

	var_1(arg_1_0.build_bgtime, false)

	SetActive = var_1

	var_1(arg_1_0.shop_bgtime, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001
	arg_2_0.timeMgr = var_1_10001.TimeMgr.GetInstance()

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.Manual, function()
		Context = var_2_10000

		local var_4_0 = var_2_10000.New
		local var_4_1 = {}

		MedalAlbumTemplateMediator = var_2_10003
		var_4_1.mediator = var_2_10003
		CamouflageCityMedalAlbumView = var_2_10003
		var_4_1.viewComponent = var_2_10003

		local var_4_2 = var_4_0(var_4_1)
		local var_4_3 = arg_3_0
		local var_4_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_4_4(var_4_3, var_2_10004.ON_ADD_SUBLAYER, var_4_2)

		return
	end)
	arg_3_0:updateUI()

	eachChild = var_1

	var_1(arg_3_0.btnList, function(arg_5_0)
		arg_3_0.btnFuncList[arg_5_0.name](arg_5_0)

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	arg_6_0:updateUI()

	return
end

function var_0_1.updateUI(arg_7_0)
	local var_7_0 = arg_7_0.timeMgr
	local var_7_1 = var_1.inTime

	pg = var_1_10004

	local var_7_2, var_7_3 = var_7_1(var_7_0, var_1_10004.shop_template[var_0_2].time)
	local var_7_4
	local var_7_6

	if var_7_3 then
		local var_7_5 = arg_7_0.timeMgr

		var_7_6 = var_7_6.Table2ServerTime(var_7_5, var_7_3)

		local var_7_7 = var_0_1

		var_7_4 = var_5.skinCommdityTimeStamps(var_7_7, var_7_6)
	end

	setActive = var_7_6

	var_7_6(arg_7_0.shop_bgtime, var_7_4 and var_7_4 ~= 0)

	setText = var_7_6

	var_7_6(arg_7_0.shop_time, var_7_4)

	local var_7_8 = arg_7_0.timeMgr
	local var_7_9 = var_4.inTime

	pg = var_7

	local var_7_10, var_7_11 = var_7_9(var_7_8, var_7.activity_template[var_0_4].time)
	local var_7_12
	local var_7_14

	if var_7_11 then
		local var_7_13 = arg_7_0.timeMgr

		var_7_14 = var_7_14.Table2ServerTime(var_7_13, var_7_11)

		local var_7_15 = var_0_1

		var_7_12 = var_8.skinCommdityTimeStamps(var_7_15, var_7_14)
	end

	setActive = var_7_14

	var_7_14(arg_7_0.build_bgtime, var_7_12 and var_7_12 ~= 0)

	setText = var_7_14

	local var_7_16 = arg_7_0.build_time

	i18n = var_10

	var_7_14(var_7_16, var_10("tolovemainpage_build_countdown"))

	local var_7_17 = arg_7_0.activity
	local var_7_18 = var_7.getConfig(var_7_17, "config_client")

	arg_7_0.btnFuncList = {
		shop = function(arg_8_0)
			onButton = var_2_10001

			var_2_10001(arg_7_0, arg_8_0, function()
				if var_7_4 == nil then
					pg = var_0

					local var_9_0 = var_0.TipsMgr.GetInstance()
					local var_9_1 = var_0.ShowTips

					i18n = var_3_10003

					var_9_1(var_9_0, var_3_10003("common_activity_end"))

					return
				end

				local var_9_2 = arg_7_0
				local var_9_3 = var_0.emit

				ActivityMediator = var_3_10003

				var_9_3(var_9_2, var_3_10003.GO_CHANGE_SHOP)

				return
			end)

			return
		end,
		build = function(arg_10_0)
			onButton = var_2_10001

			var_2_10001(arg_7_0, arg_10_0, function()
				if var_7_12 == nil then
					pg = var_0

					local var_11_0 = var_0.TipsMgr.GetInstance()
					local var_11_1 = var_0.ShowTips

					i18n = var_3_10003

					var_11_1(var_11_0, var_3_10003("common_activity_end"))

					return
				end

				local var_11_2 = arg_7_0
				local var_11_3 = var_0.emit

				ActivityMediator = var_3_10003

				local var_11_4 = var_3_10003.EVENT_GO_SCENE

				SCENE = var_3_10004

				local var_11_5 = var_3_10004.GETBOAT
				local var_11_6 = {}

				BuildShipScene = var_3_10006
				var_11_6.page = var_3_10006.PAGE_BUILD
				BuildShipScene = var_6
				var_11_6.projectName = var_6.PROJECTS.ACTIVITY

				var_11_3(var_11_2, var_11_4, var_11_5, var_11_6)

				return
			end)

			return
		end,
		fight = function(arg_12_0)
			onButton = var_2_10001

			var_2_10001(arg_7_0, arg_12_0, function()
				local var_13_0 = arg_7_0
				local var_13_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_13_1(var_13_0, var_3_10003.ON_BOSSRUSH_MAP)

				return
			end)

			return
		end
	}

	return
end

function var_0_1.skinCommdityTimeStamps(arg_14_0, arg_14_1)
	pg = var_1_10002

	local var_14_0 = var_1_10002.TimeMgr.GetInstance()
	local var_14_1 = var_2.GetServerTime(var_14_0)

	math = var_1_10003

	local var_14_2 = var_1_10003.max(arg_14_1 - var_14_1, 0)

	math = var_14_0

	local var_14_3 = var_14_0.floor(var_14_2 / 0)

	if 0 < var_14_3 then
		return 0
	else
		math = var_5

		local var_14_4 = var_5.floor(var_14_2 / 16)
		local var_14_5

		if 0 < var_14_4 then
			var_14_5 = var_14_4
			i18n = var_7

			return var_14_5 .. var_7("word_hour")
		else
			math = var_14_5

			if var_14_5.floor(var_14_2 / 60) > 0 then
				local var_14_6 = var_6

				i18n = var_8

				return var_14_6 .. var_8("word_minute")
			else
				local var_14_7 = var_14_2

				i18n = var_8

				return var_14_7 .. var_8("word_second")
			end
		end
	end

	return
end

return var_0_1
