local var_0_0 = class("BackHillSummerPark2022Scene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "BackHillSummerParkUI"
end

var_0_0.edge2area = {
	default = "_SDPlace"
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
	arg_2_0._upper = arg_2_0._tf:Find("upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_2 = arg_2_0._upper:GetChild(iter_2_1)
		local var_2_3 = "upper_" .. go(var_2_2).name

		arg_2_0[var_2_3] = var_2_2
	end

	arg_2_0._SDPlace = arg_2_0._tf:Find("SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.BackHillSummerParkGraph"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Back"), function()
		arg_3_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Home"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.summerland_tip.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.MINIGAME_ICECREAM)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 2, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bingqilin", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 41)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "qimazhan", function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.ISUZU_SPORTS_SKIN_ID
		})

		return
	end)
	setActive(arg_3_0.map_shujvhuigu, PLATFORM_CODE == PLATFORM_US)
	setActive(arg_3_0.upper_shujvhuigu, PLATFORM_CODE == PLATFORM_US)

	if PLATFORM_CODE == PLATFORM_US then
		arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shujvhuigu", function()
			arg_3_0:emit(NewYearFestivalMediator.GO_SCENE, SCENE.SUMMARY)

			return
		end)
	end

	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_10_0)
	setActive(arg_10_0.upper_bingqilin:Find("Tip"), (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_ICECREAM)
	end)())
	setActive(arg_10_0.upper_qimazhan:Find("Tip"), (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ISUZU_SPORTS_SKIN_ID)))
	end)())
	setActive(arg_10_0.upper_shujvhuigu:Find("Tip"), (function()
		if PLATFORM_CODE ~= PLATFORM_US then
			return
		end

		local var_13_0 = getProxy(ActivityProxy)

		return Activity.IsActivityReady((var_13_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)())

	return
end

function var_0_0.IsShowMainTip(arg_14_0)
	return (function()
		return BackHillTemplate.IsMiniActNeedTip(ActivityConst.MINIGAME_ICECREAM)
	end)() or (function()
		return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.ISUZU_SPORTS_SKIN_ID)))
	end)() or (function()
		if PLATFORM_CODE ~= PLATFORM_US then
			return
		end

		local var_17_0 = getProxy(ActivityProxy)

		return Activity.IsActivityReady((var_17_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))
	end)()
end

function var_0_0.willExit(arg_18_0)
	arg_18_0:clearStudents()
	var_0_0.super.willExit(arg_18_0)

	return
end

return var_0_0
