class = var_0_10000

local var_0_0 = "SSSSLinkAcademyScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "SSSSLinkAcademyUI"
end

var_0_1.edge2area = {
	default = "map_middle",
	["2_3"] = "map_front",
	["4_5"] = "map_front",
	["2_2"] = "map_front",
	["3_4"] = "map_front"
}

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_1, "map")

	for iter_2_0 = 0, arg_2_0._map.childCount - 1 do
		local var_2_2 = arg_2_0._map
		local var_2_3 = var_5.GetChild(var_2_2, iter_2_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_3).name
		arg_2_0["map_" .. var_1_10006] = var_2_3
	end

	local var_2_4 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_4, "ship")

	local var_2_5 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_5, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_6 = arg_2_0._upper
		local var_2_7 = var_5.GetChild(var_2_6, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_7).name
		arg_2_0["upper_" .. var_1_10006] = var_2_7
	end

	arg_2_0.containers = {
		arg_2_0.map_front,
		arg_2_0.map_middle
	}
	GraphPath = var_1

	local var_2_8 = var_1.New

	import = var_3
	arg_2_0.graphPath = var_2_8(var_3("GameCfg.BackHillGraphs.SSSSLinkAcademyGraph"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	var_1_10001(var_3_0, var_4.Find(var_3_1, "top/return_btn"), function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf

	var_1_10001(var_3_2, var_4.Find(var_3_3, "top/return_main_btn"), function()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	var_1_10001(var_3_4, var_4.Find(var_3_5, "top/help_btn"), function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.ssss_main_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()

	local var_3_6 = arg_3_0

	arg_3_0.BindItemBattle(var_3_6)

	getProxy = var_1
	ActivityProxy = var_3_6

	local var_3_7 = var_1(var_3_6)
	local var_3_8 = var_1.getActivityByType

	ActivityConst = var_4

	local var_3_9 = var_3_8(var_3_7, var_4.ACTIVITY_TYPE_MINIGAME)

	arg_3_0:InitStudents(var_3_9 and var_3_9.id, 3, 4)

	local var_3_10 = arg_3_0

	arg_3_0.InitFacilityCross(var_3_10, arg_3_0._map, arg_3_0._upper, "xiaoyouxi", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_MINI_GAME, 55)

		return
	end)

	getProxy = var_2
	ActivityProxy = var_3_10

	local var_3_11 = var_2(var_3_10)
	local var_3_12 = var_2.getActivityById

	ActivityConst = var_5

	local var_3_13 = var_3_12(var_3_11, var_5.SSSS_PT)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huodongye", function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_8_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_8_3 = var_2_10004.ACTIVITY
		local var_8_4 = {}
		local var_8_5

		if var_3_13 then
			var_8_5 = var_3_13.id
		end

		var_8_4.id = var_8_5

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jinianzhang", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_9_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_9_1(var_9_0, var_9_2, var_2_10004.SSSS_MEDAL_COLLECTION)

		return
	end)

	onButton = var_3

	var_3(arg_3_0, arg_3_0.upper_huoyuehuodong, function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_10_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_10_1(var_10_0, var_10_2, var_2_10004.MONOPOLY_WORLD)

		return
	end)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_11_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_11_0 = var_1_10001(var_1_10003)
	local var_11_1
	local var_11_2 = var_11_0
	local var_11_3 = var_11_0.getActivityByType

	ActivityConst = var_1_10006

	local var_11_4 = var_11_3(var_11_2, var_1_10006.ACTIVITY_TYPE_MINIGAME)
	local var_11_5 = var_0_1.IsMiniActNeedTip(var_11_4 and var_11_4.id)
	local var_11_6 = arg_11_0.upper_xiaoyouxi
	local var_11_7 = var_4.Find(var_11_6, "tip")

	setActive = var_11_2

	var_11_2(var_11_7, var_11_5)

	local var_11_8 = var_11_0
	local var_11_9 = var_11_0.getActivityById

	ActivityConst = var_8

	local var_11_10 = var_11_9(var_11_8, var_8.SSSS_PT)
	local var_11_11 = arg_11_0.upper_huodongye
	local var_11_12 = var_6.Find(var_11_11, "tip")
	local var_11_13 = var_11_10 and var_11_10:readyToAchieve()

	setActive = var_11_8

	var_11_8(var_11_12, var_11_13)

	local var_11_14 = arg_11_0.upper_jinianzhang
	local var_11_15 = var_7.Find(var_11_14, "tip")
	local var_11_16 = var_0_1.MedalTip()

	setActive = var_8

	var_8(var_11_15, var_11_16)

	local var_11_17 = var_11_0
	local var_11_18 = var_11_0.getActivityByType

	ActivityConst = var_11

	local var_11_19 = var_11_18(var_11_17, var_11.ACTIVITY_TYPE_MONOPOLY)
	local var_11_20 = arg_11_0.upper_huoyuehuodong
	local var_11_21 = var_9.Find(var_11_20, "tip")
	local var_11_22 = var_11_19 and var_11_19:readyToAchieve()

	setActive = var_11_17

	var_11_17(var_11_21, var_11_22)

	return
end

function var_0_1.willExit(arg_12_0)
	arg_12_0:clearStudents()

	return
end

function var_0_1.MedalTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_13_0 = var_1_10000(var_1_10002)
	local var_13_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_13_2 = var_13_1(var_13_0, var_1_10003.ACTIVITY_TYPE_PUZZLA)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_13_2)
end

function var_0_1.IsShowMainTip(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	local function var_14_1()
		local var_15_0 = var_14_0
		local var_15_1 = var_0.getActivityById

		ActivityConst = var_2_10003

		local var_15_2 = var_15_1(var_15_0, var_2_10003.SSSS_PT)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_15_2)
	end

	local var_14_2 = var_0_1.MedalTip()

	local function var_14_3()
		local var_16_0 = var_14_0
		local var_16_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		local var_16_2 = var_16_1(var_16_0, var_2_10003.ACTIVITY_TYPE_MINIGAME)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_16_2)
	end

	local function var_14_4()
		local var_17_0 = var_14_0
		local var_17_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		local var_17_2 = var_17_1(var_17_0, var_2_10003.ACTIVITY_TYPE_MONOPOLY)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_17_2)
	end

	local var_14_5

	if not var_14_1() and not var_14_2() and not var_14_3() then
		var_14_5 = var_14_4()
	end

	return var_14_5
end

return var_0_1
