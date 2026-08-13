class = var_0_10000

local var_0_0 = "CagePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	findTF = var_1_10001
	arg_1_0.bg = var_1_10001(arg_1_0._tf, "AD")
	findTF = var_1
	arg_1_0.Build = var_1(arg_1_0.bg, "build")
	findTF = var_1
	arg_1_0.build_times = var_1(arg_1_0.Build, "build_times")
	findTF = var_1
	arg_1_0.build_time = var_1(arg_1_0.build_times, "time")
	findTF = var_1
	arg_1_0.Level = var_1(arg_1_0.bg, "fight")
	findTF = var_1
	arg_1_0.Shop = var_1(arg_1_0.bg, "shop")
	findTF = var_1
	arg_1_0.shop_times = var_1(arg_1_0.Shop, "shop_times")
	findTF = var_1
	arg_1_0.shop_time = var_1(arg_1_0.shop_times, "time")
	findTF = var_1
	arg_1_0.Manual = var_1(arg_1_0.bg, "Manual")
	SetActive = var_1

	var_1(arg_1_0.build_times, false)

	SetActive = var_1

	var_1(arg_1_0.shop_times, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.time = var_1.getConfig(var_2_0, "time")
	pg = var_1
	arg_2_0.timeMgr = var_1.TimeMgr.GetInstance()

	local var_2_1 = arg_2_0.timeMgr

	arg_2_0.js_time = var_1.parseTimeFromConfig(var_2_1, arg_2_0.time[3])

	local var_2_2 = arg_2_0.timeMgr

	arg_2_0.fw_time = var_1.GetServerTime(var_2_2)

	local var_2_3 = arg_2_0.timeMgr

	arg_2_0.xc_time = var_1.DiffDay(var_2_3, arg_2_0.fw_time, arg_2_0.js_time)

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.Manual

	local function var_3_2()
		Context = var_2_10000

		local var_4_0 = var_2_10000.New
		local var_4_1 = {}

		MedalAlbumTemplateMediator = var_2_10003
		var_4_1.mediator = var_2_10003
		DivineLightMedalAlbumView = var_2_10003
		var_4_1.viewComponent = var_2_10003

		local var_4_2 = var_4_0(var_4_1)
		local var_4_3 = arg_3_0
		local var_4_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_4_4(var_4_3, var_2_10004.ON_ADD_SUBLAYER, var_4_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.Build

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_5_3 = var_2_10004.GETBOAT
		local var_5_4 = {}

		BuildShipScene = var_2_10006
		var_5_4.page = var_2_10006.PAGE_BUILD
		BuildShipScene = var_6
		var_5_4.projectName = var_6.PROJECTS.ACTIVITY

		var_5_1(var_5_0, var_5_2, var_5_3, var_5_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.Level

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.BATTLE_OPERA)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.Shop

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_CHANGE_SHOP)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10006)

	if arg_3_0.xc_time <= 0 then
		SetActive = var_1

		var_1(arg_3_0.build_times, true)

		SetActive = var_1

		var_1(arg_3_0.shop_times, true)

		setText = var_1

		local var_3_12 = arg_3_0.build_time

		i18n = var_4

		var_1(var_3_12, var_4("tolovemainpage_build_countdown"))

		local var_3_13 = arg_3_0.timeMgr

		arg_3_0.times = var_1.GetServerHour(var_3_13)
		os = var_1

		if var_1.date("%d") >= "01" then
			setText = var_1

			local var_3_14 = arg_3_0.shop_time

			i18n = var_4

			var_1(var_3_14, var_4("tolovemainpage_skin_countdown", 24 - arg_3_0.times - 1))
		else
			setText = var_1

			local var_3_15 = arg_3_0.shop_time

			i18n = var_4

			var_1(var_3_15, var_4("tolovemainpage_skin_countdown", 24 - arg_3_0.times))
		end
	end

	return
end

return var_0_1
