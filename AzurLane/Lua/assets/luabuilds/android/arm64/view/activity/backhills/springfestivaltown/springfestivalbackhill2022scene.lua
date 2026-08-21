local var_0_0 = class("SpringFestivalBackHill2022Scene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "SpringFestivalBackHill2022UI"
end

var_0_0.edge2area = {
	default = "_sdPlace"
}

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._bg = arg_2_0._tf:Find("BG")
	arg_2_0._map = arg_2_0._tf:Find("map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_0 = arg_2_0._map:GetChild(iter_2_0)
		local var_2_1 = "map_" .. go(var_2_0).name

		arg_2_0[var_2_1] = var_2_0
	end

	arg_2_0._shipTpl = arg_2_0._tf:Find("ship")
	arg_2_0._sdPlace = arg_2_0._tf:Find("SDPlace")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0.containers = {
		arg_2_0._sdPlace
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestival2022Graph"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/back"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/home"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.springfes_tips1.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_SPRINGFESTIVAL_2022)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "fushundamaoxian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 37)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "longtenghuyue", function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.ANSHAN_CHANGCHUN_GAIZAO_ID
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huazhongshijie", function()
		local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)

		if not var_9_0 or var_9_0:isEnd() then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

			return
		end

		;({}).id = var_9_0:getConfig("config_client").linkActID

		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huituriji", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jiulou", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_12_0)
	local var_12_2 = getProxy(ActivityProxy)

	setActive(arg_12_0.upper_huituriji:Find("Tip"), (getProxy(ColoringProxy):CheckTodayTip()))
	setActive(arg_12_0.upper_fushundamaoxian:Find("Tip"), (BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_SPRINGFESTIVAL_2022)))
	setActive(arg_12_0.upper_jiulou:Find("Tip"), (RedPacketLayer.isShowRedPoint()))
	setActive(arg_12_0.upper_huazhongshijie:Find("Tip"), (Activity.IsActivityReady((var_12_2:getActivityByType(ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE)))))
	setActive(arg_12_0.upper_longtenghuyue:Find("Tip"), (Activity.IsActivityReady((var_12_2:getActivityById(ActivityConst.ANSHAN_CHANGCHUN_GAIZAO_ID)))))

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:clearStudents()
	var_0_0.super.willExit(arg_13_0)

	return
end

return var_0_0
