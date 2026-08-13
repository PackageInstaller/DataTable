class = var_0_10000

local var_0_0 = "NewYearFestivalScene2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewyearFestivalUI2"
end

var_0_1.edge2area = {
	default = "map_middle",
	["3_4"] = "map_bottom",
	["5_6"] = "map_bottom"
}

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_1, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		var_1_10006 = arg_2_0._map
		var_1_10005 = var_1_10005.GetChild(var_1_10006, iter_2_0)
		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_10005).name
		arg_2_0["map_" .. var_1_10006] = var_1_10005
	end

	local var_2_2 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_2, "ship")

	local var_2_3 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_3, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		var_1_10006 = arg_2_0._upper
		var_1_10005 = var_1_10005.GetChild(var_1_10006, iter_2_1)
		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_10005).name
		arg_2_0["upper_" .. var_1_10006] = var_1_10005
	end

	arg_2_0.containers = {
		arg_2_0.map_middle
	}
	GraphPath = var_1

	local var_2_4 = var_1.New

	import = var_2
	arg_2_0.graphPath = var_2_4(var_2("GameCfg.BackHillGraphs.NewyearFestivalGraph2"))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.GetComponentInParent

	typeof = var_3
	UnityEngine = iter_2_1

	local var_2_7

	if not var_2_6(var_2_5, var_3(iter_2_1.Canvas)) or not var_1.sortingOrder then
		var_2_7 = 0
	end

	local var_2_8 = arg_2_0._map
	local var_2_9 = var_3.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10006
	var_2_9(var_2_8, var_1_10005(var_1_10006.Canvas)).sortingOrder = var_2_7 - 2

	local var_2_10 = arg_2_0._map
	local var_2_11 = var_3.Find(var_2_10, "xuehezhan_snow01")

	pg = var_2_10

	var_2_10.ViewUtils.SetSortingOrder(var_2_11, var_2_7 - 1)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_3.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end

	SFX_CANCEL = var_5

	var_1_10001(var_3_0, var_3_2, var_3_3, var_5)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_3.Find(var_3_5, "top/home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_3.Find(var_3_9, "top/help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.help_xinnian2021_feast.tip

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

	local var_3_14 = var_3_13(var_3_12, var_3_10.NEWYEAR_SNACKSTREET_MINIGAME)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "daxuezhang", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_MINI_GAME, 18)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xiaochijie", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.GO_MINI_GAME, 19)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "qiaozhong", function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10002

		var_9_1(var_9_0, var_2_10002.GO_MINI_GAME, 20)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "fuzhuangdian", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_10_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_10_1(var_10_0, var_10_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "mofang", function()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_11_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_11_1(var_11_0, var_11_2, var_2_10003.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.upper_daxuezhang
	local var_12_1 = var_2.Find(var_12_0, "Tip")
	local var_12_2 = var_0_1.IsMiniActNeedTip

	ActivityConst = var_4

	var_1_10001(var_12_1, var_12_2(var_4.NEWYEAR_SNOWBALL_FIGHT))

	setActive = var_1_10001

	local var_12_3 = arg_12_0.upper_xiaochijie
	local var_12_4 = var_2.Find(var_12_3, "Tip")

	NewYearSnackPage = var_12_3

	var_1_10001(var_12_4, var_12_3.IsTip())

	setActive = var_1_10001

	local var_12_5 = arg_12_0.upper_qiaozhong
	local var_12_6 = var_2.Find(var_12_5, "Tip")

	NewYearShrineView = var_12_5

	var_1_10001(var_12_6, var_12_5.IsNeedShowTipWithoutActivityFinalReward())

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:clearStudents()
	var_0_1.super.willExit(arg_13_0)

	return
end

return var_0_1
