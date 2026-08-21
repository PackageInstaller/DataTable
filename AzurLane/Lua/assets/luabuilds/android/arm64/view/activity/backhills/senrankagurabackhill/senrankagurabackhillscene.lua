local var_0_0 = class("SenrankaguraBackHillScene", import("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_0.getUIName(arg_1_0)
	return "SenrankaguraBackHillUI"
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
	arg_2_0._shipTpl = arg_2_0._map:Find("ship")
	arg_2_0.graphPath = GraphPath.New(import("GameCfg.BackHillGraphs.SenrankaguraBackHillGraph"))

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Back"), function()
		arg_3_0:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Home"), function()
		arg_3_0:quickExitFunc()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.senrankagura_backhill_help.tip
		})

		return
	end, SFX_PANEL)

	local var_3_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_BUFF)

	arg_3_0:InitStudents(var_3_0 and var_3_0.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "renshuzhidaochang", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SENRANKAGURA_TRAIN)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "michuanrenfashu", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.SENRANKAGURA_MEDAL)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "renzherenwuban", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.SENRANKAGURA_TURNTABLE
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "baochouleijisuo", function()
		arg_3_0:emit(BackHillMediatorTemplate.GO_SCENE, SCENE.ACTIVITY, {
			id = ActivityConst.SENRANKAGURA_PT
		})

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()
	arg_3_0:UpdateView()

	return
end

function var_0_0.UpdateView(arg_11_0)
	setActive(arg_11_0.upper_renshuzhidaochang:Find("Tip"), var_0_0.TrainTip())
	setActive(arg_11_0.upper_michuanrenfashu:Find("Tip"), var_0_0.MedalTip())
	setActive(arg_11_0.upper_renzherenwuban:Find("Tip"), var_0_0.TaskTip())
	setActive(arg_11_0.upper_baochouleijisuo:Find("Tip"), var_0_0.PTTip())

	return
end

function var_0_0.willExit(arg_12_0)
	arg_12_0:clearStudents()
	var_0_0.super.willExit(arg_12_0)

	return
end

function var_0_0.MedalTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_MEDAL_ID))) or SenrankaguraMedalScene.GetTaskCountAble()
end

function var_0_0.TaskTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_TURNTABLE)))
end

function var_0_0.PTTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_PT)))
end

function var_0_0.TrainTip()
	return Activity.IsActivityReady((getProxy(ActivityProxy):getActivityById(ActivityConst.SENRANKAGURA_TRAIN_ACT_ID)))
end

function var_0_0.IsShowMainTip(arg_17_0)
	if arg_17_0 and not arg_17_0:isEnd() then
		return var_0_0.PTTip() or var_0_0.MedalTip() or var_0_0.TaskTip() or var_0_0.TrainTip()
	end

	return
end

return var_0_0
