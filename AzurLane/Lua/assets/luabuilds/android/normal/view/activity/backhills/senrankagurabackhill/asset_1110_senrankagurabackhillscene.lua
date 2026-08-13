class = var_0_10000

local var_0_0 = "SenrankaguraBackHillScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "SenrankaguraBackHillUI"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._bg = var_1.Find(var_2_1, "BG")

	local var_2_2 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_2, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_3 = arg_2_0._map
		local var_2_4 = var_5.GetChild(var_2_3, iter_2_0)

		go = var_2_3

		local var_2_5 = var_2_3(var_2_4).name

		arg_2_0["map_" .. var_2_5] = var_2_4
	end

	local var_2_6 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_6, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_7 = arg_2_0._upper
		local var_2_8 = var_5.GetChild(var_2_7, iter_2_1)

		go = var_2_7

		local var_2_9 = var_2_7(var_2_8).name

		arg_2_0["upper_" .. var_2_9] = var_2_8
	end

	local var_2_10 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_10, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_11 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_11, "ship")
	GraphPath = var_1

	local var_2_12 = var_1.New

	import = var_2_11
	arg_2_0.graphPath = var_2_12(var_2_11("GameCfg.BackHillGraphs.SenrankaguraBackHillGraph"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "top/Home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_3.Find(var_3_9, "top/Help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.senrankagura_backhill_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	getProxy = var_1_10001
	ActivityProxy = var_3_8

	local var_3_12 = var_1_10001(var_3_8)
	local var_3_13 = var_1.getActivityById

	ActivityConst = var_3_10

	local var_3_14 = var_3_13(var_3_12, var_3_10.SENRANKAGURA_BUFF)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "renshuzhidaochang", function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.SENRANKAGURA_TRAIN)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "michuanrenfashu", function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.SENRANKAGURA_MEDAL)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "renzherenwuban", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_9_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_9_3 = var_2_10003.ACTIVITY
		local var_9_4 = {}

		ActivityConst = var_2_10005
		var_9_4.id = var_2_10005.SENRANKAGURA_TURNTABLE

		var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "baochouleijisuo", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_10_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_10_3 = var_2_10003.ACTIVITY
		local var_10_4 = {}

		ActivityConst = var_2_10005
		var_10_4.id = var_2_10005.SENRANKAGURA_PT

		var_10_1(var_10_0, var_10_2, var_10_3, var_10_4)

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_11_0)
	setActive = var_1_10001

	local var_11_0 = arg_11_0.upper_renshuzhidaochang

	var_1_10001(var_2.Find(var_11_0, "Tip"), var_0_1.TrainTip())

	setActive = var_1_10001

	local var_11_1 = arg_11_0.upper_michuanrenfashu

	var_1_10001(var_2.Find(var_11_1, "Tip"), var_0_1.MedalTip())

	setActive = var_1_10001

	local var_11_2 = arg_11_0.upper_renzherenwuban

	var_1_10001(var_2.Find(var_11_2, "Tip"), var_0_1.TaskTip())

	setActive = var_1_10001

	local var_11_3 = arg_11_0.upper_baochouleijisuo

	var_1_10001(var_2.Find(var_11_3, "Tip"), var_0_1.PTTip())

	return
end

function var_0_1.willExit(arg_12_0)
	arg_12_0:clearStudents()
	var_0_1.super.willExit(arg_12_0)

	return
end

function var_0_1.MedalTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_13_0 = var_1_10000(var_1_10001)
	local var_13_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	local var_13_2 = var_13_1(var_13_0, var_1_10002.SENRANKAGURA_MEDAL_ID)

	Activity = var_13_0

	local var_13_3

	if not var_13_0.IsActivityReady(var_13_2) then
		SenrankaguraMedalScene = var_13_3
		var_13_3 = var_13_3.GetTaskCountAble()
	end

	return var_13_3
end

function var_0_1.TaskTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_14_0 = var_1_10000(var_1_10001)
	local var_14_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	local var_14_2 = var_14_1(var_14_0, var_1_10002.SENRANKAGURA_TURNTABLE)

	Activity = var_14_0

	return var_14_0.IsActivityReady(var_14_2)
end

function var_0_1.PTTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_15_0 = var_1_10000(var_1_10001)
	local var_15_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	local var_15_2 = var_15_1(var_15_0, var_1_10002.SENRANKAGURA_PT)

	Activity = var_15_0

	return var_15_0.IsActivityReady(var_15_2)
end

function var_0_1.TrainTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_16_0 = var_1_10000(var_1_10001)
	local var_16_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	local var_16_2 = var_16_1(var_16_0, var_1_10002.SENRANKAGURA_TRAIN_ACT_ID)

	Activity = var_16_0

	return var_16_0.IsActivityReady(var_16_2)
end

function var_0_1.IsShowMainTip(arg_17_0)
	if arg_17_0 and not arg_17_0:isEnd() then
		local var_17_0

		if not var_0_1.PTTip() and not var_0_1.MedalTip() and not var_0_1.TaskTip() then
			var_17_0 = var_0_1.TrainTip()
		end

		return var_17_0
	end

	return
end

return var_0_1
