local var_0_0 = class("SpringFestivalTownScene2", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "SpringFestivalTownUI2"
end

var_0_0.edge2area = {
	default = "map_middle"
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
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SpringFestivalTownGraph2"))

	local var_2_4 = arg_2_0._tf:GetComponentInParent(typeof(UnityEngine.Canvas))

	if var_2_4 then
		local var_2_5 = var_2_4.sortingOrder or 0

		arg_2_0._bg:GetComponent(typeof(UnityEngine.Canvas)).sortingOrder = var_2_5 - 2

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
			helps = pg.gametip.help_chunjie2021_feast.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SPRING_FES_MINIGAME_SECOND)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "damaoxian", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 21)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "chunyouji", function()
		local var_8_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.ACTIVITY, {
			id = var_8_0 and var_8_0.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huituriji", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.COLORING)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "dajiulou", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SUBLAYER, Context.New({
			mediator = RedPacketMediator,
			viewComponent = RedPacketLayer
		}))

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "fuzhuang", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jianzao", function()
		arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.GETBOAT, {
			page = 1,
			projectName = BuildShipScene.PROJECTS.LIGHT
		})

		return
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_13_0)
	local var_13_1 = getProxy(ActivityProxy)
	local var_13_2 = getProxy(MiniGameProxy)

	setActive(arg_13_0.upper_huituriji:Find("Tip"), (getProxy(ColoringProxy):CheckTodayTip()))
	setActive(arg_13_0.upper_dajiulou:Find("Tip"), (RedPacketLayer.isShowRedPoint()))

	local var_13_3 = var_13_1:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	setActive(arg_13_0.upper_chunyouji:Find("Tip"), nil and not (nil):isEnd() and (nil):readyToAchieve())

	local var_13_4 = var_13_1:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	setActive(arg_13_0.upper_damaoxian:Find("Tip"), nil and not (nil):isEnd() and (nil):readyToAchieve())

	return
end

function var_0_0.willExit(arg_14_0)
	arg_14_0:clearStudents()
	var_0_0.super.willExit(arg_14_0)

	return
end

return var_0_0
