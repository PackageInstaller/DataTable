class = var_0_10000

local var_0_0 = "DALMainPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.AD = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.AD

	arg_1_0.list = var_1.Find(var_1_1, "list")

	local var_1_2 = arg_1_0.list

	arg_1_0.build = var_1.Find(var_1_2, "build")

	local var_1_3 = arg_1_0.build

	arg_1_0.build_bgtime = var_1.Find(var_1_3, "time_bg")

	local var_1_4 = arg_1_0.build_bgtime

	arg_1_0.build_time = var_1.Find(var_1_4, "time")

	local var_1_5 = arg_1_0.list

	arg_1_0.fight = var_1.Find(var_1_5, "fight")

	local var_1_6 = arg_1_0.list

	arg_1_0.shop = var_1.Find(var_1_6, "shop")

	local var_1_7 = arg_1_0.shop

	arg_1_0.shop_bgtime = var_1.Find(var_1_7, "time_bg")

	local var_1_8 = arg_1_0.shop_bgtime

	arg_1_0.shop_time = var_1.Find(var_1_8, "time")
	SetActive = var_1

	var_1(arg_1_0.build_bgtime, false)

	SetActive = var_1

	var_1(arg_1_0.shop_bgtime, false)

	setText = var_1

	local var_1_9 = arg_1_0.shop
	local var_1_10 = var_2.Find(var_1_9, "Text")

	i18n = var_1_9

	var_1(var_1_10, var_1_9("yumia_main_tip_3"))

	setText = var_1

	local var_1_11 = arg_1_0.fight
	local var_1_12 = var_2.Find(var_1_11, "Text")

	i18n = var_1_11

	var_1(var_1_12, var_1_11("yumia_main_tip_2"))

	setText = var_1

	local var_1_13 = arg_1_0.build
	local var_1_14 = var_2.Find(var_1_13, "Text")

	i18n = var_1_13

	var_1(var_1_14, var_1_13("yumia_main_tip_1"))

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001
	arg_2_0.timeMgr = var_1_10001.TimeMgr.GetInstance()

	local var_2_0 = arg_2_0.activity

	arg_2_0.shop_id = var_1.getConfig(var_2_0, "config_client").shopItemID

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	arg_3_0:updateUI()

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	arg_4_0:updateUI()

	return
end

function var_0_1.updateUI(arg_5_0)
	if not arg_5_0.shop_id then
		return
	end

	local var_5_0 = arg_5_0.timeMgr
	local var_5_1 = var_1.inTime

	pg = var_1_10003

	local var_5_2, var_5_3 = var_5_1(var_5_0, var_1_10003.shop_template[arg_5_0.shop_id].time)
	local var_5_4
	local var_5_6

	if var_5_3 then
		local var_5_5 = arg_5_0.timeMgr

		var_5_6 = var_5_6.Table2ServerTime(var_5_5, var_5_3)

		local var_5_7 = var_0_1

		var_5_4 = var_5.skinCommdityTimeStamps(var_5_7, var_5_6)
	end

	setActive = var_5_6

	var_5_6(arg_5_0.shop_bgtime, var_5_4 and var_5_4 ~= 0)

	setText = var_5_6

	var_5_6(arg_5_0.shop_time, var_5_4)

	local var_5_8 = arg_5_0.timeMgr
	local var_5_9 = var_4.inTime

	pg = var_6

	local var_5_10, var_5_11 = var_5_9(var_5_8, var_6.activity_template[arg_5_0.activity.id].time)
	local var_5_12
	local var_5_14

	if var_5_11 then
		local var_5_13 = arg_5_0.timeMgr

		var_5_14 = var_5_14.Table2ServerTime(var_5_13, var_5_11)

		local var_5_15 = var_0_1

		var_5_12 = var_8.skinCommdityTimeStamps(var_5_15, var_5_14)
	end

	setActive = var_5_14

	var_5_14(arg_5_0.build_bgtime, var_5_12 and var_5_12 ~= 0)

	setText = var_5_14

	local var_5_16 = arg_5_0.build_time

	i18n = var_9

	var_5_14(var_5_16, var_9("tolovemainpage_build_countdown"))

	onButton = var_5_14

	var_5_14(arg_5_0, arg_5_0.shop, function()
		if var_5_4 == nil then
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

	onButton = var_5_14

	var_5_14(arg_5_0, arg_5_0.build, function()
		if var_5_12 == nil then
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

	onButton = var_5_14

	var_5_14(arg_5_0, arg_5_0.fight, function()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_COLLAB_BOSSRUSH_MAP)

		return
	end)

	return
end

function var_0_1.skinCommdityTimeStamps(arg_9_0, arg_9_1)
	pg = var_1_10002

	local var_9_0 = var_1_10002.TimeMgr.GetInstance()
	local var_9_1 = var_2.GetServerTime(var_9_0)

	math = var_9_0

	local var_9_2 = var_9_0.max(arg_9_1 - var_9_1, 0)

	math = var_4

	local var_9_3 = var_4.floor(var_9_2 / 0)

	if 0 < var_9_3 then
		return 0
	else
		math = var_5

		local var_9_4 = var_5.floor(var_9_2 / 16)

		if 0 < var_9_4 then
			i18n = var_6

			return var_6("shop_new_during_hour", var_9_4)
		else
			math = var_6

			local var_9_5 = var_6.floor(var_9_2 / 60)

			if 0 < var_9_5 then
				i18n = var_7

				return var_7("shop_new_during_minite", var_9_5)
			else
				i18n = var_7

				return var_7("shop_new_during_minite", var_9_5)
			end
		end
	end

	return
end

return var_0_1
