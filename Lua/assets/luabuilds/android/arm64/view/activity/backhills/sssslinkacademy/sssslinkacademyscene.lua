local var_0_0 = class("SSSSLinkAcademyScene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "SSSSLinkAcademyUI"
end

var_0_0.edge2area = {
	default = "map_middle",
	["2_3"] = "map_front",
	["4_5"] = "map_front",
	["2_2"] = "map_front",
	["3_4"] = "map_front"
}

function var_0_0.init(arg_2_0)
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
		arg_2_0.map_front,
		arg_2_0.map_middle
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SSSSLinkAcademyGraph"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_btn"), function()
		arg_3_0:emit(var_0_0.ON_BACK)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("top/return_main_btn"), function()
		arg_3_0:emit(var_0_0.ON_HOME)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("top/help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ssss_main_help.tip
		})

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xiaoyouxi", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 55)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.SSSS_PT)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huodongye", function()
		({}).id = var_3_1 and var_3_1.id

		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jinianzhang", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SSSS_MEDAL_COLLECTION)

		return
	end)
	onButton(arg_3_0, arg_3_0.upper_huoyuehuodong, function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.MONOPOLY_WORLD)

		return
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_11_0)
	local var_11_0 = getProxy(ActivityProxy)
	local var_11_2 = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	setActive(arg_11_0.upper_xiaoyouxi:Find("tip"), (var_0_0.IsMiniActNeedTip(var_11_2 and var_11_2.id)))

	local var_11_3 = var_11_0:getActivityById(ActivityConst.SSSS_PT)

	setActive(arg_11_0.upper_huodongye:Find("tip"), var_11_3 and var_11_3:readyToAchieve())
	setActive(arg_11_0.upper_jinianzhang:Find("tip"), (var_0_0.MedalTip()))

	local var_11_4 = var_11_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	setActive(arg_11_0.upper_huoyuehuodong:Find("tip"), var_11_4 and var_11_4:readyToAchieve())

	return
end

function var_0_0.willExit(arg_12_0)
	arg_12_0:clearStudents()

	return
end

function var_0_0.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function var_0_0.IsShowMainTip(arg_14_0)
	local var_14_0 = getProxy(ActivityProxy)

	return (function()
		return Activity.IsActivityReady((var_14_0:getActivityById(ActivityConst.SSSS_PT)))
	end)() or var_0_0.MedalTip()() or (function()
		return Activity.IsActivityReady((var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)))
	end)() or (function()
		return Activity.IsActivityReady((var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)))
	end)()
end

return var_0_0
