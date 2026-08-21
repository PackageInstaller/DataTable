local var_0_0 = class("SpringFestival2026MainPage", import("view.activity.CorePage.Helena.HelenaMainPage"))

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
	arg_1_0.plot = arg_1_0.AD:Find("plot")

	SetActive(arg_1_0.build_bgtime, false)
	SetActive(arg_1_0.shop_bgtime, false)
	setText(arg_1_0.Manual:Find("Text"), i18n("fengfanV3_20251023_jinianshouce"))
	setText(arg_1_0.plot:Find("Text"), i18n("drawdiary_ui_2026"))

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0.Manual, function()
		arg_2_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = DonghuangMedalAlbumView
		})))

		return
	end)
	onButton(arg_2_0, arg_2_0.plot, function()
		arg_2_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = SpringFestival2026ColoringAnshanMediator,
			viewComponent = SpringFestival2026ColoringAnshanscene
		})))

		return
	end)

	return
end

function var_0_0.updateUI(arg_5_0)
	if arg_5_0.shop_id then
		local var_5_0, var_5_1 = arg_5_0.timeMgr:inTime(pg.shop_template[arg_5_0.shop_id].time)
		local var_5_2

		if var_5_1 then
			var_5_2 = var_0_0:skinCommdityTimeStamps((arg_5_0.timeMgr:Table2ServerTime(var_5_1)))
		end

		setActive(arg_5_0.shop_bgtime, var_5_2 and var_5_2 ~= 0)
		setText(arg_5_0.shop_time, var_5_2)
		onButton(arg_5_0, arg_5_0.shop, function()
			if var_5_2 == nil then
				pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

				return
			end

			arg_5_0:emit(ActivityMediator.GO_CHANGE_SHOP)

			return
		end)
	end

	local var_5_3, var_5_4 = arg_5_0.timeMgr:inTime(pg.activity_template[arg_5_0.activity.id].time)
	local var_5_5

	if var_5_4 then
		var_5_5 = var_0_0:skinCommdityTimeStamps((arg_5_0.timeMgr:Table2ServerTime(var_5_4)))
	end

	setActive(arg_5_0.build_bgtime, var_5_5 and var_5_5 ~= 0)
	setText(arg_5_0.build_time, i18n("tolovemainpage_build_countdown"))
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
		arg_5_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = ActivityBossMediatorTemplate,
			viewComponent = ActivityBossZhangwuScene
		})))

		return
	end)

	return
end

return var_0_0
