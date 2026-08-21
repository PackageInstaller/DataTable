local var_0_0 = class("DALMainPage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("bg")
	arg_1_0.list = arg_1_0.AD:Find("list")
	arg_1_0.build = arg_1_0.list:Find("build")
	arg_1_0.build_bgtime = arg_1_0.build:Find("time_bg")
	arg_1_0.build_time = arg_1_0.build_bgtime:Find("time")
	arg_1_0.fight = arg_1_0.list:Find("fight")
	arg_1_0.shop = arg_1_0.list:Find("shop")
	arg_1_0.shop_bgtime = arg_1_0.shop:Find("time_bg")
	arg_1_0.shop_time = arg_1_0.shop_bgtime:Find("time")

	SetActive(arg_1_0.build_bgtime, false)
	SetActive(arg_1_0.shop_bgtime, false)
	setText(arg_1_0.shop:Find("Text"), i18n("yumia_main_tip_3"))
	setText(arg_1_0.fight:Find("Text"), i18n("yumia_main_tip_2"))
	setText(arg_1_0.build:Find("Text"), i18n("yumia_main_tip_1"))

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.timeMgr = pg.TimeMgr.GetInstance()
	arg_2_0.shop_id = arg_2_0.activity:getConfig("config_client").shopItemID

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	arg_3_0:updateUI()

	return
end

function var_0_0.OnUpdateFlush(arg_4_0)
	arg_4_0:updateUI()

	return
end

function var_0_0.updateUI(arg_5_0)
	if not arg_5_0.shop_id then
		return
	end

	local var_5_0, var_5_1 = arg_5_0.timeMgr:inTime(pg.shop_template[arg_5_0.shop_id].time)
	local var_5_2

	if var_5_1 then
		var_5_2 = var_0_0:skinCommdityTimeStamps((arg_5_0.timeMgr:Table2ServerTime(var_5_1)))
	end

	setActive(arg_5_0.shop_bgtime, var_5_2 and var_5_2 ~= 0)
	setText(arg_5_0.shop_time, var_5_2)

	local var_5_3, var_5_4 = arg_5_0.timeMgr:inTime(pg.activity_template[arg_5_0.activity.id].time)
	local var_5_5

	if var_5_4 then
		var_5_5 = var_0_0:skinCommdityTimeStamps((arg_5_0.timeMgr:Table2ServerTime(var_5_4)))
	end

	setActive(arg_5_0.build_bgtime, var_5_5 and var_5_5 ~= 0)
	setText(arg_5_0.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(arg_5_0, arg_5_0.shop, function()
		if var_5_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_5_0:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)
	onButton(arg_5_0, arg_5_0.build, function()
		if var_5_5 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_5_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end)
	onButton(arg_5_0, arg_5_0.fight, function()
		arg_5_0:emit(ActivityMediator.ON_COLLAB_BOSSRUSH_MAP)

		return
	end)

	return
end

function var_0_0.skinCommdityTimeStamps(arg_9_0, arg_9_1)
	local var_9_0 = math.max(arg_9_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_9_0 / 0) > 0 then
		return 0
	else
		local var_9_1 = math.floor(var_9_0 / 16)

		if var_9_1 > 0 then
			return i18n("shop_new_during_hour", var_9_1)
		else
			local var_9_2 = math.floor(var_9_0 / 60)

			if var_9_2 > 0 then
				return i18n("shop_new_during_minite", var_9_2)
			else
				return i18n("shop_new_during_minite", var_9_2)
			end
		end
	end

	return
end

return var_0_0
