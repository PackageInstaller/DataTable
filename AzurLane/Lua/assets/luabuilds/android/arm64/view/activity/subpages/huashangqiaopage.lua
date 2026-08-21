local var_0_0 = class("HuaShangQiaoPage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.Build = arg_1_0.bg:Find("build"):GetComponent("Button")
	arg_1_0.build_times = arg_1_0.bg:Find("build/build_times")
	arg_1_0.build_time = arg_1_0.bg:Find("build/build_times/time"):GetComponent("Text")
	arg_1_0.Level = arg_1_0.bg:Find("fight"):GetComponent("Button")
	arg_1_0.fight_times = arg_1_0.bg:Find("fight/fight_times")
	arg_1_0.fight_time = arg_1_0.bg:Find("fight/fight_times/time"):GetComponent("Text")
	arg_1_0.Shop = arg_1_0.bg:Find("shop"):GetComponent("Button")
	arg_1_0.shop_times = arg_1_0.bg:Find("shop/shop_times")
	arg_1_0.shop_time = arg_1_0.bg:Find("shop/shop_times/time"):GetComponent("Text")
	arg_1_0.Manual = arg_1_0.bg:Find("Manual"):GetComponent("Button")

	SetActive(arg_1_0.build_times, false)
	SetActive(arg_1_0.fight_times, false)
	SetActive(arg_1_0.shop_times, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.time = arg_2_0.activity:getConfig("time")
	arg_2_0.time = arg_2_0.time[2]
	arg_2_0.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.Manual, function()
		arg_3_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = SpringFashionFestaMedalAlbumView
		})))

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Build, function()
		arg_3_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Level, function()
		arg_3_0:emit(ActivityMediator.GO_SPECIAL_EXERCISE)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Shop, function()
		arg_3_0:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)

	if os.date("%d") == "06" and os.date("%m") == "02" and os.date("%Y") == "2025" then
		SetActive(arg_3_0.build_times, true)
		SetActive(arg_3_0.fight_times, true)
		SetActive(arg_3_0.shop_times, true)
		setText(arg_3_0.build_time, i18n("tolovemainpage_build_countdown"))
		setText(arg_3_0.fight_time, i18n("tolovemainpage_build_countdown"))

		arg_3_0.times = arg_3_0.timeMgr:GetServerHour()

		if os.date("%d") >= "01" then
			setText(arg_3_0.shop_time, i18n("tolovemainpage_skin_countdown", 24 - arg_3_0.times - 1))
		else
			setText(arg_3_0.shop_time, i18n("tolovemainpage_skin_countdown", 24 - arg_3_0.times))
		end
	end

	return
end

return var_0_0
