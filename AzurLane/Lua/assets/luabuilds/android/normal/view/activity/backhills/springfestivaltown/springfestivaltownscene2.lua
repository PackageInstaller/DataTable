class = var_0_10000

local var_0_0 = "SpringFestivalTownScene2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "SpringFestivalTownUI2"
end

var_0_1.edge2area = {
	default = "map_middle"
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
		var_1_10006 = arg_2_0._map
		var_1_10005 = var_1_10005.GetChild(var_1_10006, iter_2_0)
		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_10005).name
		arg_2_0["map_" .. var_1_10006] = var_1_10005
	end

	local var_2_3 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_3, "ship")

	local var_2_4 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_4, "upper")

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

	local var_2_5 = var_1.New

	import = var_2
	arg_2_0.graphPath = var_2_5(var_2("GameCfg.BackHillGraphs.SpringFestivalTownGraph2"))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.GetComponentInParent

	typeof = var_3
	UnityEngine = iter_2_1

	local var_2_8

	if not var_2_7(var_2_6, var_3(iter_2_1.Canvas)) or not var_1.sortingOrder then
		var_2_8 = 0
	end

	local var_2_9 = arg_2_0._bg
	local var_2_10 = var_3.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10006
	var_2_10(var_2_9, var_1_10005(var_1_10006.Canvas)).sortingOrder = var_2_8 - 2

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
		var_6_2.helps = var_2_10003.gametip.help_chunjie2021_feast.tip

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

	local var_3_14 = var_3_13(var_3_12, var_3_10.SPRING_FES_MINIGAME_SECOND)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "damaoxian", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_MINI_GAME, 21)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "chunyouji", function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_8_0 = var_2_10000(var_2_10001)
		local var_8_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_8_2 = var_8_1(var_8_0, var_2_10002.ACTIVITY_TYPE_MONOPOLY)
		local var_8_3 = arg_3_0
		local var_8_4 = var_1.emit

		NewYearFestivalMediator = var_2_10003

		local var_8_5 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_8_4(var_8_3, var_8_5, var_2_10004.ACTIVITY, {
			id = var_8_2 and var_8_2.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huituriji", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_9_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003.COLORING)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "dajiulou", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_10_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_10_3 = var_2_10003.New
		local var_10_4 = {}

		RedPacketMediator = var_2_10005
		var_10_4.mediator = var_2_10005
		RedPacketLayer = var_2_10005
		var_10_4.viewComponent = var_2_10005

		var_10_1(var_10_0, var_10_2, var_10_3(var_10_4))

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "fuzhuang", function()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_11_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_11_1(var_11_0, var_11_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jianzao", function()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_12_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_12_3 = var_2_10003.GETBOAT
		local var_12_4 = {
			page = 1
		}

		BuildShipScene = var_2_10005
		var_12_4.projectName = var_2_10005.PROJECTS.LIGHT

		var_12_1(var_12_0, var_12_2, var_12_3, var_12_4)

		return
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_13_0)
	local var_13_0
	local var_13_1

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_13_2 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	MiniGameProxy = var_1_10005

	local var_13_3 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	ColoringProxy = var_1_10006

	local var_13_4 = var_1_10005(var_1_10006)
	local var_13_5 = var_5.CheckTodayTip(var_13_4)

	setActive = var_5

	local var_13_6 = arg_13_0.upper_huituriji

	var_5(var_6.Find(var_13_6, "Tip"), var_13_5)

	RedPacketLayer = var_5

	local var_13_7 = var_5.isShowRedPoint()

	setActive = var_5

	local var_13_8 = arg_13_0.upper_dajiulou

	var_5(var_6.Find(var_13_8, "Tip"), var_13_7)

	local var_13_9 = var_13_2
	local var_13_10 = var_13_2.getActivityByType

	ActivityConst = var_7

	local var_13_11 = var_13_10(var_13_9, var_7.ACTIVITY_TYPE_MONOPOLY) and not var_2:isEnd() and var_2:readyToAchieve()

	setActive = var_5

	local var_13_12 = arg_13_0.upper_chunyouji

	var_5(var_6.Find(var_13_12, "Tip"), var_13_11)

	local var_13_13 = var_13_2
	local var_13_14 = var_13_2.getActivityByType

	ActivityConst = var_7

	local var_13_15 = var_13_14(var_13_13, var_7.ACTIVITY_TYPE_MINIGAME) and not var_2:isEnd() and var_2:readyToAchieve()

	setActive = var_5

	local var_13_16 = arg_13_0.upper_damaoxian

	var_5(var_6.Find(var_13_16, "Tip"), var_13_15)

	return
end

function var_0_1.willExit(arg_14_0)
	arg_14_0:clearStudents()
	var_0_1.super.willExit(arg_14_0)

	return
end

return var_0_1
