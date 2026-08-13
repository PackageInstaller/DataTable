class = var_0_10000

local var_0_0 = "HelenaMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.DAL.DALMainPage"))

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
	SetActive = var_1

	var_1(arg_1_0.build_bgtime, false)

	SetActive = var_1

	var_1(arg_1_0.shop_bgtime, false)

	setText = var_1

	local var_1_10 = arg_1_0.shop
	local var_1_11 = var_3.Find(var_1_10, "shop")

	i18n = var_4

	var_1(var_1_11, var_4("yumia_main_tip_3"))

	setText = var_1

	local var_1_12 = arg_1_0.fight
	local var_1_13 = var_3.Find(var_1_12, "fight")

	i18n = var_4

	var_1(var_1_13, var_4("yumia_main_tip_2"))

	setText = var_1

	local var_1_14 = arg_1_0.build
	local var_1_15 = var_3.Find(var_1_14, "build")

	i18n = var_4

	var_1(var_1_15, var_4("yumia_main_tip_1"))

	setText = var_1

	local var_1_16 = arg_1_0.Manual
	local var_1_17 = var_3.Find(var_1_16, "Manual")

	i18n = var_4

	var_1(var_1_17, var_4("fengfanV3_20251023_jinianshouce"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	var_1(arg_2_0, arg_2_0.Manual, function()
		Context = var_2_10000

		local var_3_0 = var_2_10000.New
		local var_3_1 = {}

		MedalAlbumTemplateMediator = var_2_10003
		var_3_1.mediator = var_2_10003
		TianqiongMedalAlbumView = var_2_10003
		var_3_1.viewComponent = var_2_10003

		local var_3_2 = var_3_0(var_3_1)
		local var_3_3 = arg_2_0
		local var_3_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_3_4(var_3_3, var_2_10004.ON_ADD_SUBLAYER, var_3_2)

		return
	end)

	return
end

function var_0_1.updateUI(arg_4_0)
	if not arg_4_0.shop_id then
		return
	end

	local var_4_0 = arg_4_0.timeMgr
	local var_4_1 = var_1.inTime

	pg = var_1_10004

	local var_4_2, var_4_3 = var_4_1(var_4_0, var_1_10004.shop_template[arg_4_0.shop_id].time)
	local var_4_4
	local var_4_6

	if var_4_3 then
		local var_4_5 = arg_4_0.timeMgr

		var_4_6 = var_4_6.Table2ServerTime(var_4_5, var_4_3)

		local var_4_7 = var_0_1

		var_4_4 = var_5.skinCommdityTimeStamps(var_4_7, var_4_6)
	end

	setActive = var_4_6

	var_4_6(arg_4_0.shop_bgtime, var_4_4 and var_4_4 ~= 0)

	setText = var_4_6

	var_4_6(arg_4_0.shop_time, var_4_4)

	local var_4_8 = arg_4_0.timeMgr
	local var_4_9 = var_4.inTime

	pg = var_7

	local var_4_10, var_4_11 = var_4_9(var_4_8, var_7.activity_template[arg_4_0.activity.id].time)
	local var_4_12
	local var_4_14

	if var_4_11 then
		local var_4_13 = arg_4_0.timeMgr

		var_4_14 = var_4_14.Table2ServerTime(var_4_13, var_4_11)

		local var_4_15 = var_0_1

		var_4_12 = var_8.skinCommdityTimeStamps(var_4_15, var_4_14)
	end

	setActive = var_4_14

	var_4_14(arg_4_0.build_bgtime, var_4_12 and var_4_12 ~= 0)

	setText = var_4_14

	local var_4_16 = arg_4_0.build_time

	i18n = var_10

	var_4_14(var_4_16, var_10("tolovemainpage_build_countdown"))

	onButton = var_4_14

	var_4_14(arg_4_0, arg_4_0.shop, function()
		if var_4_4 == nil then
			pg = var_0

			local var_5_0 = var_0.TipsMgr.GetInstance()
			local var_5_1 = var_0.ShowTips

			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("common_activity_end"))

			return
		end

		local var_5_2 = arg_4_0
		local var_5_3 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_3(var_5_2, var_2_10003.GO_CHANGE_SHOP)

		return
	end)

	onButton = var_4_14

	var_4_14(arg_4_0, arg_4_0.build, function()
		if var_4_12 == nil then
			pg = var_0

			local var_6_0 = var_0.TipsMgr.GetInstance()
			local var_6_1 = var_0.ShowTips

			i18n = var_2_10003

			var_6_1(var_6_0, var_2_10003("common_activity_end"))

			return
		end

		local var_6_2 = arg_4_0
		local var_6_3 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_4 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_6_5 = var_2_10004.GETBOAT
		local var_6_6 = {}

		BuildShipScene = var_2_10006
		var_6_6.page = var_2_10006.PAGE_BUILD
		BuildShipScene = var_6
		var_6_6.projectName = var_6.PROJECTS.ACTIVITY

		var_6_3(var_6_2, var_6_4, var_6_5, var_6_6)

		return
	end)

	onButton = var_4_14

	var_4_14(arg_4_0, arg_4_0.fight, function()
		local var_7_0 = arg_4_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.SPECIAL_BATTLE_OPERA)

		return
	end)

	return
end

return var_0_1
