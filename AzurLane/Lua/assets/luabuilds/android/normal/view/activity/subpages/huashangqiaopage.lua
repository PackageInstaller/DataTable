class = var_0_10000

local var_0_0 = "HuaShangQiaoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "build")

	arg_1_0.Build = var_1.GetComponent(var_1_2, "Button")

	local var_1_3 = arg_1_0.bg

	arg_1_0.build_times = var_1.Find(var_1_3, "build/build_times")

	local var_1_4 = arg_1_0.bg
	local var_1_5 = var_1.Find(var_1_4, "build/build_times/time")

	arg_1_0.build_time = var_1.GetComponent(var_1_5, "Text")

	local var_1_6 = arg_1_0.bg
	local var_1_7 = var_1.Find(var_1_6, "fight")

	arg_1_0.Level = var_1.GetComponent(var_1_7, "Button")

	local var_1_8 = arg_1_0.bg

	arg_1_0.fight_times = var_1.Find(var_1_8, "fight/fight_times")

	local var_1_9 = arg_1_0.bg
	local var_1_10 = var_1.Find(var_1_9, "fight/fight_times/time")

	arg_1_0.fight_time = var_1.GetComponent(var_1_10, "Text")

	local var_1_11 = arg_1_0.bg
	local var_1_12 = var_1.Find(var_1_11, "shop")

	arg_1_0.Shop = var_1.GetComponent(var_1_12, "Button")

	local var_1_13 = arg_1_0.bg

	arg_1_0.shop_times = var_1.Find(var_1_13, "shop/shop_times")

	local var_1_14 = arg_1_0.bg
	local var_1_15 = var_1.Find(var_1_14, "shop/shop_times/time")

	arg_1_0.shop_time = var_1.GetComponent(var_1_15, "Text")

	local var_1_16 = arg_1_0.bg
	local var_1_17 = var_1.Find(var_1_16, "Manual")

	arg_1_0.Manual = var_1.GetComponent(var_1_17, "Button")
	SetActive = var_1

	var_1(arg_1_0.build_times, false)

	SetActive = var_1

	var_1(arg_1_0.fight_times, false)

	SetActive = var_1

	var_1(arg_1_0.shop_times, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity

	arg_2_0.time = var_1.getConfig(var_2_0, "time")
	arg_2_0.time = arg_2_0.time[2]
	pg = var_1
	arg_2_0.timeMgr = var_1.TimeMgr.GetInstance()

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

		MedalAlbumTemplateMediator = var_2_10002
		var_4_1.mediator = var_2_10002
		SpringFashionFestaMedalAlbumView = var_2_10002
		var_4_1.viewComponent = var_2_10002

		local var_4_2 = var_4_0(var_4_1)
		local var_4_3 = arg_3_0
		local var_4_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_4_4(var_4_3, var_2_10003.ON_ADD_SUBLAYER, var_4_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.Build

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_5_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_5_3 = var_2_10003.GETBOAT
		local var_5_4 = {}

		BuildShipScene = var_2_10005
		var_5_4.page = var_2_10005.PAGE_BUILD
		BuildShipScene = var_5
		var_5_4.projectName = var_5.PROJECTS.ACTIVITY

		var_5_1(var_5_0, var_5_2, var_5_3, var_5_4)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.Level

	local function var_3_8()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_6_1(var_6_0, var_2_10002.GO_SPECIAL_EXERCISE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.Shop

	local function var_3_11()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_CHANGE_SHOP)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	os = var_1_10001

	if var_1_10001.date("%d") == "06" then
		os = var_1

		if var_1.date("%m") == "02" then
			os = var_1

			if var_1.date("%Y") == "2025" then
				SetActive = var_1

				var_1(arg_3_0.build_times, true)

				SetActive = var_1

				var_1(arg_3_0.fight_times, true)

				SetActive = var_1

				var_1(arg_3_0.shop_times, true)

				setText = var_1

				local var_3_12 = arg_3_0.build_time

				i18n = var_3

				var_1(var_3_12, var_3("tolovemainpage_build_countdown"))

				setText = var_1

				local var_3_13 = arg_3_0.fight_time

				i18n = var_3

				var_1(var_3_13, var_3("tolovemainpage_build_countdown"))

				local var_3_14 = arg_3_0.timeMgr

				arg_3_0.times = var_1.GetServerHour(var_3_14)
				os = var_1

				if var_1.date("%d") >= "01" then
					setText = var_1

					local var_3_15 = arg_3_0.shop_time

					i18n = var_3

					var_1(var_3_15, var_3("tolovemainpage_skin_countdown", 24 - arg_3_0.times - 1))
				else
					setText = var_1

					local var_3_16 = arg_3_0.shop_time

					i18n = var_3

					var_1(var_3_16, var_3("tolovemainpage_skin_countdown", 24 - arg_3_0.times))
				end
			end
		end
	end

	return
end

return var_0_1
