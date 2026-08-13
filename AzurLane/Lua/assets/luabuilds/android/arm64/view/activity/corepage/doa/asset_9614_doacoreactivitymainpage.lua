class = var_0_10000

local var_0_0 = "DOACoreActivityMainPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.Helena.HelenaMainPage"))

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	onButton = var_1

	var_1(arg_1_0, arg_1_0.Manual, function()
		Context = var_2_10000

		local var_2_0 = var_2_10000.New
		local var_2_1 = {}

		DOAYearHotSpringMediator = var_2_10003
		var_2_1.mediator = var_2_10003
		DOAYearHotSpringScene = var_2_10003
		var_2_1.viewComponent = var_2_10003

		local var_2_2 = var_2_0(var_2_1)
		local var_2_3 = arg_1_0
		local var_2_4 = var_1.emit

		ActivityMediator = var_2_10004

		var_2_4(var_2_3, var_2_10004.ON_ADD_SUBLAYER, var_2_2)

		return
	end)

	return
end

function var_0_1.updateUI(arg_3_0)
	if arg_3_0.shop_id then
		local var_3_0 = arg_3_0.timeMgr
		local var_3_1 = var_1.inTime

		pg = var_1_10004

		local var_3_2, var_3_3 = var_3_1(var_3_0, var_1_10004.shop_template[arg_3_0.shop_id].time)
		local var_3_4

		if var_3_3 then
			local var_3_5 = arg_3_0.timeMgr

			var_1_10004 = var_1_10004.Table2ServerTime(var_3_5, var_3_3)

			local var_3_6 = var_0_1

			var_3_4 = var_5.skinCommdityTimeStamps(var_3_6, var_1_10004)
		end

		setActive = var_1_10004

		var_1_10004(arg_3_0.shop_bgtime, var_3_4 and var_3_4 ~= 0)

		setText = var_1_10004

		var_1_10004(arg_3_0.shop_time, var_3_4)

		onButton = var_1_10004

		var_1_10004(arg_3_0, arg_3_0.shop, function()
			if var_3_4 == nil then
				pg = var_0

				local var_4_0 = var_0.TipsMgr.GetInstance()
				local var_4_1 = var_0.ShowTips

				i18n = var_2_10003

				var_4_1(var_4_0, var_2_10003("common_activity_end"))

				return
			end

			local var_4_2 = arg_3_0
			local var_4_3 = var_0.emit

			ActivityMediator = var_2_10003

			var_4_3(var_4_2, var_2_10003.GO_CHANGE_SHOP)

			return
		end)
	end

	local var_3_7 = arg_3_0.timeMgr
	local var_3_8 = var_1.inTime

	pg = var_1_10004

	local var_3_9, var_3_10 = var_3_8(var_3_7, var_1_10004.activity_template[arg_3_0.activity.id].time)
	local var_3_11
	local var_3_13

	if var_3_10 then
		local var_3_12 = arg_3_0.timeMgr

		var_3_13 = var_3_13.Table2ServerTime(var_3_12, var_3_10)

		local var_3_14 = var_0_1

		var_3_11 = var_5.skinCommdityTimeStamps(var_3_14, var_3_13)
	end

	setActive = var_3_13

	var_3_13(arg_3_0.build_bgtime, var_3_11 and var_3_11 ~= 0)

	setText = var_3_13

	local var_3_15 = arg_3_0.build_time

	i18n = var_7

	var_3_13(var_3_15, var_7("tolovemainpage_build_countdown"))

	onButton = var_3_13

	var_3_13(arg_3_0, arg_3_0.build, function()
		if var_3_11 == nil then
			pg = var_0

			local var_5_0 = var_0.TipsMgr.GetInstance()
			local var_5_1 = var_0.ShowTips

			i18n = var_2_10003

			var_5_1(var_5_0, var_2_10003("common_activity_end"))

			return
		end

		local var_5_2 = arg_3_0
		local var_5_3 = var_0.emit

		ActivityMediator = var_2_10003

		local var_5_4 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_5_5 = var_2_10004.GETBOAT
		local var_5_6 = {}

		BuildShipScene = var_2_10006
		var_5_6.page = var_2_10006.PAGE_BUILD
		BuildShipScene = var_6
		var_5_6.projectName = var_6.PROJECTS.ACTIVITY

		var_5_3(var_5_2, var_5_4, var_5_5, var_5_6)

		return
	end)

	onButton = var_3_13

	var_3_13(arg_3_0, arg_3_0.fight, function()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_6_1(var_6_0, var_2_10003.SKIP_ACTIVITY_MAP, 6036)

		return
	end)

	return
end

return var_0_1
