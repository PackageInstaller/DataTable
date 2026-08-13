class = var_0_10000

local var_0_0 = "NewYearFestival2024Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewYearFestival2024UI"
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

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_4).name
		arg_2_0["map_" .. var_1_10006] = var_2_4
	end

	local var_2_5 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_5, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_6 = arg_2_0._upper
		local var_2_7 = var_5.GetChild(var_2_6, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_7).name
		arg_2_0["upper_" .. var_1_10006] = var_2_7
	end

	local var_2_8 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_8, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_9 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_9, "ship")
	GraphPath = var_1

	local var_2_10 = var_1.New

	import = var_2_9
	arg_2_0.graphPath = var_2_10(var_2_9("GameCfg.BackHillGraphs.NewyearFestival2024Graph"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "top/Home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_4.Find(var_3_9, "top/Help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.newyear2024_backhill_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_8, var_3_10, var_3_11, var_3_9)

	getProxy = var_1_10001
	ActivityProxy = var_3_8

	local var_3_12 = var_1_10001(var_3_8)
	local var_3_13 = var_1.getActivityById

	ActivityConst = var_3_10

	local var_3_14 = var_3_13(var_3_12, var_3_10.MINIGAME_COOKGAME2_ID)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "nvpudian", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_MINI_GAME, 60)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huimaqiyuan", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10003

		var_8_1(var_8_0, var_2_10003.GO_MINI_GAME, 62)

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_9_0)
	setActive = var_1_10001

	local var_9_0 = arg_9_0.upper_nvpudian

	var_1_10001(var_3.Find(var_9_0, "Tip"), var_0_1.MiniGameTip())

	setActive = var_1_10001

	local var_9_1 = arg_9_0.upper_huimaqiyuan

	var_1_10001(var_3.Find(var_9_1, "Tip"), var_0_1.ShrineTip())

	return
end

function var_0_1.ShrineTip()
	Shrine2024View = var_1_10000

	return var_1_10000.IsNeedShowTipWithoutActivityFinalReward()
end

function var_0_1.MiniGameTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	local var_11_2 = var_11_1(var_11_0, var_1_10003.MINIGAME_COOKGAME2_ID)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_11_2)
end

function var_0_1.willExit(arg_12_0)
	arg_12_0:clearStudents()
	var_0_1.super.willExit(arg_12_0)

	return
end

function var_0_1.IsShowMainTip(arg_13_0)
	if arg_13_0 and not arg_13_0:isEnd() then
		local var_13_0

		if not var_0_1.MiniGameTip() then
			var_13_0 = var_0_1.ShrineTip()
		end

		return var_13_0
	end

	return
end

return var_0_1
