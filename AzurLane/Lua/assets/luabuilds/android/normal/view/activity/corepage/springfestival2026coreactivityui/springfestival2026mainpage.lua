class = var_0_10000

local var_0_0 = "SpringFestival2026MainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.Helena.HelenaMainPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.AD

	arg_1_0.list = var_1.Find(var_1_1, "list")

	local var_1_2 = arg_1_0.list

	arg_1_0.build = var_1.Find(var_1_2, "buildbtn")

	local var_1_3 = arg_1_0.build

	arg_1_0.build_bgtime = var_1.Find(var_1_3, "time_bg")

	local var_1_4 = arg_1_0.build_bgtime

	arg_1_0.build_time = var_1.Find(var_1_4, "time")

	local var_1_5 = arg_1_0.list

	arg_1_0.fight = var_1.Find(var_1_5, "fightbtn")

	local var_1_6 = arg_1_0.list

	arg_1_0.shop = var_1.Find(var_1_6, "shopbtn")

	local var_1_7 = arg_1_0.shop

	arg_1_0.shop_bgtime = var_1.Find(var_1_7, "time_bg")

	local var_1_8 = arg_1_0.shop_bgtime

	arg_1_0.shop_time = var_1.Find(var_1_8, "time")

	local var_1_9 = arg_1_0.AD

	arg_1_0.Manual = var_1.Find(var_1_9, "Manualbtn")

	local var_1_10 = arg_1_0.AD

	arg_1_0.plot = var_1.Find(var_1_10, "plot")
	SetActive = var_1

	var_1(arg_1_0.build_bgtime, false)

	SetActive = var_1

	var_1(arg_1_0.shop_bgtime, false)

	setText = var_1

	local var_1_11 = arg_1_0.Manual
	local var_1_12 = var_2.Find(var_1_11, "Text")

	i18n = var_1_11

	var_1(var_1_12, var_1_11("fengfanV3_20251023_jinianshouce"))

	setText = var_1

	local var_1_13 = arg_1_0.plot
	local var_1_14 = var_2.Find(var_1_13, "Text")

	i18n = var_1_13

	var_1(var_1_14, var_1_13("drawdiary_ui_2026"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.Manual, function()
		Context = var_2_10000

		local var_3_0 = var_2_10000.New
		local var_3_1 = {}

		MedalAlbumTemplateMediator = var_2_10002
		var_3_1.mediator = var_2_10002
		DonghuangMedalAlbumView = var_2_10002
		var_3_1.viewComponent = var_2_10002

		local var_3_2 = var_3_0(var_3_1)
		local var_3_3 = arg_2_0
		local var_3_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_3_4(var_3_3, var_2_10003.ON_ADD_SUBLAYER, var_3_2)

		return
	end)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.plot, function()
		Context = var_2_10000

		local var_4_0 = var_2_10000.New
		local var_4_1 = {}

		SpringFestival2026ColoringAnshanMediator = var_2_10002
		var_4_1.mediator = var_2_10002
		SpringFestival2026ColoringAnshanscene = var_2_10002
		var_4_1.viewComponent = var_2_10002

		local var_4_2 = var_4_0(var_4_1)
		local var_4_3 = arg_2_0
		local var_4_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_4_4(var_4_3, var_2_10003.ON_ADD_SUBLAYER, var_4_2)

		return
	end)

	return
end

function var_0_1.updateUI(arg_5_0)
	if arg_5_0.shop_id then
		local var_5_0 = arg_5_0.timeMgr
		local var_5_1 = var_1.inTime

		pg = var_1_10003

		local var_5_2, var_5_3 = var_5_1(var_5_0, var_1_10003.shop_template[arg_5_0.shop_id].time)

		var_1_10003 = nil

		local var_5_5

		if var_5_3 then
			local var_5_4 = arg_5_0.timeMgr

			var_5_5 = var_5_5.Table2ServerTime(var_5_4, var_5_3)

			local var_5_6 = var_0_1

			var_1_10003 = var_5.skinCommdityTimeStamps(var_5_6, var_5_5)
		end

		setActive = var_5_5

		var_5_5(arg_5_0.shop_bgtime, var_1_10003 and var_1_10003 ~= 0)

		setText = var_5_5

		var_5_5(arg_5_0.shop_time, var_1_10003)

		onButton = var_5_5

		var_5_5(arg_5_0, arg_5_0.shop, function()
			if var_1_10003 == nil then
				pg = var_0

				local var_6_0 = var_0.TipsMgr.GetInstance()
				local var_6_1 = var_0.ShowTips

				i18n = var_2_10002

				var_6_1(var_6_0, var_2_10002("common_activity_end"))

				return
			end

			local var_6_2 = arg_5_0
			local var_6_3 = var_0.emit

			ActivityMediator = var_2_10002

			var_6_3(var_6_2, var_2_10002.GO_CHANGE_SHOP)

			return
		end)
	end

	local var_5_7 = arg_5_0.timeMgr
	local var_5_8 = var_1.inTime

	pg = var_1_10003

	local var_5_9, var_5_10 = var_5_8(var_5_7, var_1_10003.activity_template[arg_5_0.activity.id].time)
	local var_5_11
	local var_5_13

	if var_5_10 then
		local var_5_12 = arg_5_0.timeMgr

		var_5_13 = var_5_13.Table2ServerTime(var_5_12, var_5_10)

		local var_5_14 = var_0_1

		var_5_11 = var_5.skinCommdityTimeStamps(var_5_14, var_5_13)
	end

	setActive = var_5_13

	var_5_13(arg_5_0.build_bgtime, var_5_11 and var_5_11 ~= 0)

	setText = var_5_13

	local var_5_15 = arg_5_0.build_time

	i18n = var_6

	var_5_13(var_5_15, var_6("tolovemainpage_build_countdown"))

	onButton = var_5_13

	var_5_13(arg_5_0, arg_5_0.build, function()
		if var_5_11 == nil then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10002

			var_7_1(var_7_0, var_2_10002("common_activity_end"))

			return
		end

		local var_7_2 = arg_5_0
		local var_7_3 = var_0.emit

		ActivityMediator = var_2_10002

		local var_7_4 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		local var_7_5 = var_2_10003.GETBOAT
		local var_7_6 = {}

		BuildShipScene = var_2_10005
		var_7_6.page = var_2_10005.PAGE_BUILD
		BuildShipScene = var_5
		var_7_6.projectName = var_5.PROJECTS.ACTIVITY

		var_7_3(var_7_2, var_7_4, var_7_5, var_7_6)

		return
	end)

	onButton = var_5_13

	var_5_13(arg_5_0, arg_5_0.fight, function()
		Context = var_2_10000

		local var_8_0 = var_2_10000.New
		local var_8_1 = {}

		ActivityBossMediatorTemplate = var_2_10002
		var_8_1.mediator = var_2_10002
		ActivityBossZhangwuScene = var_2_10002
		var_8_1.viewComponent = var_2_10002

		local var_8_2 = var_8_0(var_8_1)
		local var_8_3 = arg_5_0
		local var_8_4 = var_1.emit

		ActivityMediator = var_2_10003

		var_8_4(var_8_3, var_2_10003.ON_ADD_SUBLAYER, var_8_2)

		return
	end)

	return
end

return var_0_1
