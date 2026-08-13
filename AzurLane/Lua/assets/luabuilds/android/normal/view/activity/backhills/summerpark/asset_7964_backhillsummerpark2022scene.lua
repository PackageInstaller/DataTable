class = var_0_10000

local var_0_0 = "BackHillSummerPark2022Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "BackHillSummerParkUI"
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

	arg_2_0._shipTpl = var_1.Find(var_2_6, "ship")

	local var_2_7 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_7, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_8 = arg_2_0._upper
		local var_2_9 = var_5.GetChild(var_2_8, iter_2_1)

		go = var_2_8

		local var_2_10 = var_2_8(var_2_9).name

		arg_2_0["upper_" .. var_2_10] = var_2_9
	end

	local var_2_11 = arg_2_0._tf

	arg_2_0._SDPlace = var_1.Find(var_2_11, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}
	GraphPath = var_1

	local var_2_12 = var_1.New

	import = var_2
	arg_2_0.graphPath = var_2_12(var_2("GameCfg.BackHillGraphs.BackHillSummerParkGraph"))

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

		var_0.emit(var_5_0, var_0_1.ON_HOME)

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
		var_6_2.helps = var_2_10003.gametip.summerland_tip.tip

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

	local var_3_14 = var_3_13(var_3_12, var_3_10.MINIGAME_ICECREAM)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bingqilin", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_MINI_GAME, 41)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "qimazhan", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_8_3 = var_2_10003.ACTIVITY
		local var_8_4 = {}

		ActivityConst = var_2_10005
		var_8_4.id = var_2_10005.ISUZU_SPORTS_SKIN_ID

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

		return
	end)

	setActive = var_2

	local var_3_15 = arg_3_0.map_shujvhuigu

	PLATFORM_CODE = var_4
	PLATFORM_US = var_5

	var_2(var_3_15, var_4 == var_5)

	setActive = var_2

	local var_3_16 = arg_3_0.upper_shujvhuigu

	PLATFORM_CODE = var_4
	PLATFORM_US = var_5

	var_2(var_3_16, var_4 == var_5)

	PLATFORM_CODE = var_2
	PLATFORM_US = var_3_16

	if var_2 == var_3_16 then
		local function var_3_17()
			local var_9_0 = arg_3_0
			local var_9_1 = var_0.emit

			NewYearFestivalMediator = var_2_10002

			local var_9_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_9_1(var_9_0, var_9_2, var_2_10003.SUMMARY)

			return
		end

		arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shujvhuigu", var_3_17)
	end

	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_10_0)
	local function var_10_0()
		BackHillTemplate = var_2_10000

		local var_11_0 = var_2_10000.IsMiniActNeedTip

		ActivityConst = var_2_10001

		return var_11_0(var_2_10001.MINIGAME_ICECREAM)
	end

	setActive = var_1_10002

	local var_10_1 = arg_10_0.upper_bingqilin

	var_1_10002(var_3.Find(var_10_1, "Tip"), var_10_0())

	local function var_10_2()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_12_0 = var_2_10000(var_2_10001)
		local var_12_1 = var_0.getActivityById

		ActivityConst = var_2_10002

		local var_12_2 = var_12_1(var_12_0, var_2_10002.ISUZU_SPORTS_SKIN_ID)

		Activity = var_12_0

		return var_12_0.IsActivityReady(var_12_2)
	end

	setActive = var_3

	local var_10_3 = arg_10_0.upper_qimazhan

	var_3(var_4.Find(var_10_3, "Tip"), var_10_2())

	local function var_10_4()
		PLATFORM_CODE = var_2_10000
		PLATFORM_US = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			return
		end

		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_13_0 = var_2_10000(var_2_10001)
		local var_13_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_13_2 = var_13_1(var_13_0, var_2_10002.ACTIVITY_TYPE_SUMMARY)

		Activity = var_13_0

		return var_13_0.IsActivityReady(var_13_2)
	end

	setActive = var_4

	local var_10_5 = arg_10_0.upper_shujvhuigu

	var_4(var_5.Find(var_10_5, "Tip"), var_10_4())

	return
end

function var_0_1.IsShowMainTip(arg_14_0)
	local function var_14_0()
		BackHillTemplate = var_2_10000

		local var_15_0 = var_2_10000.IsMiniActNeedTip

		ActivityConst = var_2_10001

		return var_15_0(var_2_10001.MINIGAME_ICECREAM)
	end

	local function var_14_1()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_16_0 = var_2_10000(var_2_10001)
		local var_16_1 = var_0.getActivityById

		ActivityConst = var_2_10002

		local var_16_2 = var_16_1(var_16_0, var_2_10002.ISUZU_SPORTS_SKIN_ID)

		Activity = var_16_0

		return var_16_0.IsActivityReady(var_16_2)
	end

	local function var_14_2()
		PLATFORM_CODE = var_2_10000
		PLATFORM_US = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			return
		end

		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_17_0 = var_2_10000(var_2_10001)
		local var_17_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_17_2 = var_17_1(var_17_0, var_2_10002.ACTIVITY_TYPE_SUMMARY)

		Activity = var_17_0

		return var_17_0.IsActivityReady(var_17_2)
	end

	local var_14_3

	if not var_14_0() and not var_14_1() then
		var_14_3 = var_14_2()
	end

	return var_14_3
end

function var_0_1.willExit(arg_18_0)
	arg_18_0:clearStudents()
	var_0_1.super.willExit(arg_18_0)

	return
end

return var_0_1
