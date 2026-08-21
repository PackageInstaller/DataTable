local var_0_0 = class("TianYuTianYuanMainPage", import("view.activity.CorePage.CoreActivityPage"))
local var_0_1 = 71207
local var_0_3 = 50114

function var_0_0.OnInit(arg_1_0)
	arg_1_0.AD = arg_1_0:findTF("bg")
	arg_1_0.list = arg_1_0:findTF("list", arg_1_0.AD)
	arg_1_0.build = arg_1_0:findTF("build", arg_1_0.list)
	arg_1_0.build_bgtime = arg_1_0:findTF("time_bg", arg_1_0.build)
	arg_1_0.build_time = arg_1_0:findTF("time", arg_1_0.build_bgtime)
	arg_1_0.fight = arg_1_0:findTF("fight", arg_1_0.list)
	arg_1_0.shop = arg_1_0:findTF("shop", arg_1_0.list)
	arg_1_0.shop_bgtime = arg_1_0:findTF("time_bg", arg_1_0.shop)
	arg_1_0.shop_time = arg_1_0:findTF("time", arg_1_0.shop_bgtime)
	arg_1_0.Manual = arg_1_0:findTF("Manual", arg_1_0.AD)

	SetActive(arg_1_0.build_bgtime, false)
	SetActive(arg_1_0.shop_bgtime, false)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.timeMgr = pg.TimeMgr.GetInstance()

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	onButton(arg_3_0, arg_3_0.Manual, function()
		arg_3_0:emit(ActivityMediator.ON_ADD_SUBLAYER, (Context.New({
			mediator = MedalAlbumTemplateMediator,
			viewComponent = TianYuTianYuanMedalAlbumView
		})))

		return
	end)
	arg_3_0:updateUI()

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	arg_5_0:updateUI()

	return
end

function var_0_0.updateUI(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0.timeMgr:inTime(pg.shop_template[var_0_1].time)
	local var_6_2

	if var_6_1 then
		var_6_2 = var_0_0:skinCommdityTimeStamps((arg_6_0.timeMgr:Table2ServerTime(var_6_1)))
	end

	setActive(arg_6_0.shop_bgtime, var_6_2 and var_6_2 ~= 0)
	setText(arg_6_0.shop_time, var_6_2)

	local var_6_3, var_6_4 = arg_6_0.timeMgr:inTime(pg.activity_template[var_0_3].time)
	local var_6_5

	if var_6_4 then
		var_6_5 = var_0_0:skinCommdityTimeStamps((arg_6_0.timeMgr:Table2ServerTime(var_6_4)))
	end

	setActive(arg_6_0.build_bgtime, var_6_5 and var_6_5 ~= 0)
	setText(arg_6_0.build_time, i18n("tolovemainpage_build_countdown"))
	onButton(arg_6_0, arg_6_0.shop, function()
		if var_6_2 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_6_0:emit(ActivityMediator.GO_CHANGE_SHOP)

		return
	end)
	onButton(arg_6_0, arg_6_0.build, function()
		if var_6_5 == nil then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		arg_6_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
			page = BuildShipScene.PAGE_BUILD,
			projectName = BuildShipScene.PROJECTS.ACTIVITY
		})

		return
	end)
	onButton(arg_6_0, arg_6_0.fight, function()
		arg_6_0:emit(ActivityMediator.BATTLE_OPERA)

		return
	end)

	return
end

function var_0_0.skinCommdityTimeStamps(arg_10_0, arg_10_1)
	local var_10_0 = math.max(arg_10_1 - pg.TimeMgr.GetInstance():GetServerTime(), 0)

	if math.floor(var_10_0 / 0) > 0 then
		return 0
	else
		local var_10_1 = math.floor(var_10_0 / 16)

		if var_10_1 > 0 then
			return i18n("shop_new_during_hour", var_10_1)
		else
			local var_10_2 = math.floor(var_10_0 / 60)

			if var_10_2 > 0 then
				return i18n("shop_new_during_minite", var_10_2)
			end
		end
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0.camEventId then
		pg.CameraFixMgr.GetInstance():disconnect(arg_11_0.camEventId)

		arg_11_0.camEventId = nil
	end

	return
end

return var_0_0
