local var_0_0 = class("CagePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = findTF(arg_1_0._tf, "AD")
	arg_1_0.Build = findTF(arg_1_0.bg, "build")
	arg_1_0.build_times = findTF(arg_1_0.Build, "build_times")
	arg_1_0.build_time = findTF(arg_1_0.build_times, "time")
	arg_1_0.Level = findTF(arg_1_0.bg, "fight")
	arg_1_0.Shop = findTF(arg_1_0.bg, "shop")
	arg_1_0.shop_times = findTF(arg_1_0.Shop, "shop_times")
	arg_1_0.shop_time = findTF(arg_1_0.shop_times, "time")
	arg_1_0.Manual = findTF(arg_1_0.bg, "Manual")

	SetActive(arg_1_0.build_times, false)
	SetActive(arg_1_0.shop_times, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.time = arg_2_0.activity:getConfig("time")
	arg_2_0.timeMgr = pg.TimeMgr.GetInstance()
	arg_2_0.js_time = arg_2_0.timeMgr:parseTimeFromConfig(arg_2_0.time[3])
	arg_2_0.fw_time = arg_2_0.timeMgr:GetServerTime()
	arg_2_0.xc_time = arg_2_0.timeMgr:DiffDay(arg_2_0.fw_time, arg_2_0.js_time)

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.Manual, function()
		arg_3_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = DivineLightMedalAlbumView
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
		arg_3_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.Shop, function()
		arg_3_0:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end, SFX_PANEL)

	if arg_3_0.xc_time <= 0 then
		SetActive(arg_3_0.build_times, true)
		SetActive(arg_3_0.shop_times, true)
		setText(arg_3_0.build_time, i18n("tolovemainpage_build_countdown"))

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
