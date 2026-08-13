class = var_0_10000

local var_0_0 = "SailingShip3MainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreActivityPage"))
local var_0_2 = 71226
local var_0_3 = 5
local var_0_4 = 5

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

	local var_1_9 = arg_1_0.AD

	arg_1_0.Manual = var_1.Find(var_1_9, "Manual")

	local var_1_10 = arg_1_0.Manual

	arg_1_0.name = var_1.Find(var_1_10, "name")
	setText = var_1

	local var_1_11 = arg_1_0.name

	i18n = var_4

	var_1(var_1_11, var_4("fengfanV3_20251023_jinianshouce"))

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
		SailingShip3MedalAlbumView = var_2_10003
		var_4_1.viewComponent = var_2_10003

		local var_4_2 = var_4_0(var_4_1)
		local var_4_3 = arg_3_0
		local var_4_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_4_4(var_4_3, var_2_10004.ON_ADD_SUBLAYER, var_4_2)

		return
	end)
	arg_3_0:updateUI()

	return
end

function var_0_1.OnUpdateFlush(arg_5_0)
	arg_5_0:updateUI()

	return
end

function var_0_1.updateUI(arg_6_0)
	local var_6_0 = arg_6_0.timeMgr
	local var_6_1 = var_1.inTime

	pg = var_1_10004

	local var_6_2, var_6_3 = var_6_1(var_6_0, var_1_10004.shop_template[var_0_2].time)
	local var_6_4
	local var_6_6

	if var_6_3 then
		local var_6_5 = arg_6_0.timeMgr

		var_6_6 = var_6_6.Table2ServerTime(var_6_5, var_6_3)

		local var_6_7 = var_0_1

		var_6_4 = var_5.skinCommdityTimeStamps(var_6_7, var_6_6)
	end

	setActive = var_6_6

	var_6_6(arg_6_0.shop_bgtime, var_6_4 and var_6_4 ~= 0)

	setText = var_6_6

	var_6_6(arg_6_0.shop_time, var_6_4)

	local var_6_8 = arg_6_0.timeMgr
	local var_6_9 = var_4.inTime

	pg = var_7

	local var_6_10, var_6_11 = var_6_9(var_6_8, var_7.activity_template[var_0_4].time)
	local var_6_12
	local var_6_14

	if var_6_11 then
		local var_6_13 = arg_6_0.timeMgr

		var_6_14 = var_6_14.Table2ServerTime(var_6_13, var_6_11)

		local var_6_15 = var_0_1

		var_6_12 = var_8.skinCommdityTimeStamps(var_6_15, var_6_14)
	end

	setActive = var_6_14

	var_6_14(arg_6_0.build_bgtime, var_6_12 and var_6_12 ~= 0)

	setText = var_6_14

	local var_6_16 = arg_6_0.build_time

	i18n = var_10

	var_6_14(var_6_16, var_10("tolovemainpage_build_countdown"))

	onButton = var_6_14

	var_6_14(arg_6_0, arg_6_0.shop, function()
		if var_6_4 == nil then
			pg = var_0

			local var_7_0 = var_0.TipsMgr.GetInstance()
			local var_7_1 = var_0.ShowTips

			i18n = var_2_10003

			var_7_1(var_7_0, var_2_10003("common_activity_end"))

			return
		end

		local var_7_2 = arg_6_0
		local var_7_3 = var_0.emit

		ActivityMediator = var_2_10003

		var_7_3(var_7_2, var_2_10003.GO_CHANGE_SHOP)

		return
	end)

	onButton = var_6_14

	var_6_14(arg_6_0, arg_6_0.build, function()
		if var_6_12 == nil then
			pg = var_0

			local var_8_0 = var_0.TipsMgr.GetInstance()
			local var_8_1 = var_0.ShowTips

			i18n = var_2_10003

			var_8_1(var_8_0, var_2_10003("common_activity_end"))

			return
		end

		local var_8_2 = arg_6_0
		local var_8_3 = var_0.emit

		ActivityMediator = var_2_10003

		local var_8_4 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_8_5 = var_2_10004.GETBOAT
		local var_8_6 = {}

		BuildShipScene = var_2_10006
		var_8_6.page = var_2_10006.PAGE_BUILD
		BuildShipScene = var_6
		var_8_6.projectName = var_6.PROJECTS.ACTIVITY

		var_8_3(var_8_2, var_8_4, var_8_5, var_8_6)

		return
	end)

	onButton = var_6_14

	var_6_14(arg_6_0, arg_6_0.fight, function()
		local var_9_0 = arg_6_0
		local var_9_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.BATTLE_OPERA)

		return
	end)

	return
end

function var_0_1.skinCommdityTimeStamps(arg_10_0, arg_10_1)
	pg = var_1_10002

	local var_10_0 = var_1_10002.TimeMgr.GetInstance()
	local var_10_1 = var_2.GetServerTime(var_10_0)

	math = var_1_10003

	local var_10_2 = var_1_10003.max(arg_10_1 - var_10_1, 0)

	math = var_10_0

	local var_10_3 = var_10_0.floor(var_10_2 / 0)

	if 0 < var_10_3 then
		return 0
	else
		math = var_5

		local var_10_4 = var_5.floor(var_10_2 / 16)

		if 0 < var_10_4 then
			i18n = var_6

			return var_6("shop_new_during_hour", var_10_4)
		else
			math = var_6

			local var_10_5 = var_6.floor(var_10_2 / 60)

			if 0 < var_10_5 then
				i18n = var_7

				return var_7("shop_new_during_minite", var_10_5)
			end
		end
	end

	return
end

function var_0_1.OnShowFlush(arg_11_0)
	setCanvasGroupAlpha = var_1_10001

	var_1_10001(arg_11_0._tf, 1)

	return
end

return var_0_1
