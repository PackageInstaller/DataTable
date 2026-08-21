local var_0_0 = class("NewYearFestivalScene2", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "NewyearFestivalUI2"
end

var_0_0.edge2area = {
	default = "map_middle",
	["3_4"] = "map_bottom",
	["5_6"] = "map_bottom"
}

function var_0_0.init(arg_2_0)
	var_0_0.super.init(arg_2_0)

	arg_2_0.top = arg_2_0._tf:Find("top")
	arg_2_0._map = arg_2_0._tf:Find("map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_0 = arg_2_0._map:GetChild(iter_2_0)
		local var_2_1 = "map_" .. go(var_2_0).name

		arg_2_0[var_2_1] = var_2_0
	end

	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0.containers = {
		arg_2_0.map_middle
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.NewyearFestivalGraph2"))

	local var_2_4 = arg_2_0._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	if var_2_4 then
		local var_2_5 = var_2_4.sortingOrder or 0

		arg_2_0._map:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = var_2_5 - 2

		pg.ViewUtils.SetSortingOrder(arg_2_0._map:Find("xuehezhan_snow01"), var_2_5 - 1)

		return
	end
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
			helps = pg.gametip.help_xinnian2021_feast.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.NEWYEAR_SNACKSTREET_MINIGAME)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "daxuezhang", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 18)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xiaochijie", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 19)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "qiaozhong", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 20)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "fuzhuangdian", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "mofang", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_12_0)
	setActive(arg_12_0.upper_daxuezhang:Find("Tip"), var_0_0.IsMiniActNeedTip(ActivityConst.NEWYEAR_SNOWBALL_FIGHT))
	setActive(arg_12_0.upper_xiaochijie:Find("Tip"), NewYearSnackPage.IsTip())
	setActive(arg_12_0.upper_qiaozhong:Find("Tip"), NewYearShrineView.IsNeedShowTipWithoutActivityFinalReward())

	return
end

function var_0_0.willExit(arg_13_0)
	arg_13_0:clearStudents()
	var_0_0.super.willExit(arg_13_0)

	return
end

return var_0_0
