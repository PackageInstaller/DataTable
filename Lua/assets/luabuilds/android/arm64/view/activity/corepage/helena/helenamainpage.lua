local var_0_0 = class("HelenaMainPage", import("view.activity.CorePage.DAL.DALMainPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0._tf:Find("bg")
	arg_1_0.list = arg_1_0.AD:Find("list")
	arg_1_0.build = arg_1_0.list:Find("buildbtn")
	arg_1_0.build_bgtime = arg_1_0.build:Find("time_bg")
	arg_1_0.build_time = arg_1_0.build_bgtime:Find("time")
	arg_1_0.fight = arg_1_0.list:Find("fightbtn")
	arg_1_0.shop = arg_1_0.list:Find("shopbtn")
	arg_1_0.shop_bgtime = arg_1_0.shop:Find("time_bg")
	arg_1_0.shop_time = arg_1_0.shop_bgtime:Find("time")
	arg_1_0.Manual = arg_1_0.AD:Find("Manualbtn")

	SetActive(arg_1_0.build_bgtime, false)
	SetActive(arg_1_0.shop_bgtime, false)
	setText(arg_1_0.shop:Find("shop"), i18n("yumia_main_tip_3"))
	setText(arg_1_0.fight:Find("fight"), i18n("yumia_main_tip_2"))
	setText(arg_1_0.build:Find("build"), i18n("yumia_main_tip_1"))
	setText(arg_1_0.Manual:Find("Manual"), i18n("fengfanV3_20251023_jinianshouce"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.Manual, function()
		arg_2_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = TianqiongMedalAlbumView
		})))

		return
	end)

	return
end

function var_0_0.updateUI(arg_4_0)
	if not arg_4_0.shop_id then
		return
	end

	local var_4_0, var_4_1 = arg_4_0.timeMgr:inTime(pg.shop_template[arg_4_0.shop_id].time)
	local var_4_2

	if var_4_1 then
		var_4_2 = var_0_0:skinCommdityTimeStamps((arg_4_0.timeMgr:Table2ServerTime(var_4_1)))
	end

	setActive(arg_4_0.shop_bgtime, var_4_2 and var_4_2 ~= 0)
	setText(arg_4_0.shop_time, var_4_2)

	local var_4_3, var_4_4 = arg_4_0.timeMgr:inTime(pg.activity_template[arg_4_0.activity.id].time)
	local var_4_5

	if var_4_4 then
		var_4_5 = var_0_0:skinCommdityTimeStamps((arg_4_0.timeMgr:Table2ServerTime(var_4_4)))
	end

	setActive(arg_4_0.build_bgtime, var_4_5 and var_4_5 ~= 0)
	setText(arg_4_0.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(arg_4_0, arg_4_0.shop, function()
		if var_4_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_4_0:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)
	onButton(arg_4_0, arg_4_0.build, function()
		if var_4_5 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_4_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end)
	onButton(arg_4_0, arg_4_0.fight, function()
		arg_4_0:emit(ActivityMediator.SPECIAL_BATTLE_OPERA)

		return
	end)

	return
end

return var_0_0
