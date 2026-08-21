local var_0_0 = class("IdolMasterStageScene", import("..TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "IdolMasterStageUI"
end

var_0_0.edge2area = {
	default = "map_middle"
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
		arg_2_0.map_middle
	}
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.IdolMasterStageGraph"))
	arg_2_0.loader = AutoLoader.New()

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
			helps = pg.gametip.idolmaster_main.tip
		})

		return
	end)

	local var_3_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jiujiuwoshouhui", function()
		pg.m02:sendNotification(GAME.GO_MINI_GAME, 24)

		return
	end)

	local var_3_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.IDOL_MASTER_PT_ID)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "leijijiangli", function()
		({}).id = var_3_1 and var_3_1.id

		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jinianzhang", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.IDOLMASTER_MEDAL_COLLECTION_SCENE)

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_10_0)
	local var_10_0 = getProxy(ActivityProxy)
	local var_10_2 = var_10_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_MINIGAME)
	local var_10_3 = var_10_2 and getProxy(MiniGameProxy):GetHubByHubId(var_10_2:getConfig("config_id"))
	local var_10_4 = var_10_3 and var_10_3.count > 0 or not (var_10_3.usedtime < var_10_3:getConfig("reward_need") or var_10_3.ultimate ~= 0)

	setActive(arg_10_0.upper_jiujiuwoshouhui:Find("tip"), var_10_4)

	local var_10_5 = var_10_0:getActivityById(ActivityConst.IDOL_MASTER_PT_ID)

	setActive(arg_10_0.upper_leijijiangli:Find("tip"), var_10_5 and var_10_5:readyToAchieve())
	setActive(arg_10_0.upper_jinianzhang:Find("tip"), (var_0_0.MedalTip()))

	return
end

function var_0_0.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)))
end

function var_0_0.willExit(arg_12_0)
	arg_12_0:clearStudents()
	var_0_0.super.willExit(arg_12_0)

	return
end

return var_0_0
