class = var_0_10000

local var_0_0 = "BackHillFifthAnniversaryScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "BackHillFifthAnniversaryUI"
end

var_0_1.edge2area = {
	default = "_sdPlace",
	["6_7"] = "_sdPlace2"
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

	arg_2_0._shipTpl = var_1.Find(var_2_5, "ship")

	local var_2_6 = arg_2_0._tf

	arg_2_0._sdPlace = var_1.Find(var_2_6, "map/SDPlace")

	local var_2_7 = arg_2_0._tf

	arg_2_0._sdPlace2 = var_1.Find(var_2_7, "map/SDPlace2")

	local var_2_8 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_8, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_9 = arg_2_0._upper
		local var_2_10 = var_5.GetChild(var_2_9, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_10).name
		arg_2_0["upper_" .. var_1_10006] = var_2_10
	end

	arg_2_0.containers = {
		arg_2_0._sdPlace,
		arg_2_0._sdPlace2
	}

	local var_2_11 = arg_2_0.top
	local var_2_12 = var_1.Find(var_2_11, "UsableCount/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.usableTxt = var_2_13(var_2_12, var_4(var_1_10006))
	GraphPath = var_1

	local var_2_14 = var_1.New

	import = var_2_12
	arg_2_0.graphPath = var_2_14(var_2_12("GameCfg.BackHillGraphs.BackHillFifthAnniversaryGraph"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

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

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_3_5

	var_1_10001(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1_10001

	local var_3_8 = arg_3_0
	local var_3_9 = arg_3_0._tf
	local var_3_10 = var_4.Find(var_3_9, "top/Invitation")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.m02
		local var_6_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_6_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_6_3 = var_2_10004.ACTIVITY
		local var_6_4 = {}

		ActivityConst = var_2_10006
		var_6_4.id = var_2_10006.FIFTH_ANNIVERSARY_INVITATION

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_8, var_3_10, var_3_11, var_3_9)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_4.Find(var_3_13, "top/UsableCount")

	local function var_3_15()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_MINI_GAME, 40)

		return
	end

	SFX_PANEL = var_3_13

	var_1_10001(var_3_12, var_3_14, var_3_15, var_3_13)

	getProxy = var_1_10001
	ActivityProxy = var_3_12

	local var_3_16 = var_1_10001(var_3_12)
	local var_3_17 = var_1.getActivityById

	ActivityConst = var_3_14

	local var_3_18 = var_3_17(var_3_16, var_3_14.JIUJIU_DUOMAOMAO_ID)

	arg_3_0:InitStudents(var_3_18 and var_3_18.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "youxidian", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10003

		var_8_1(var_8_0, var_2_10003.GO_MINI_GAME, 40)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "kafeiting", function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_9_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_9_3 = var_2_10004.ACTIVITY
		local var_9_4 = {}

		ActivityConst = var_2_10006
		var_9_4.id = var_2_10006.ACTIVITY_MAID_DAY

		var_9_1(var_9_0, var_9_2, var_9_3, var_9_4)

		return
	end)

	setActive = var_2

	local var_3_19 = arg_3_0.map_longpaifangBanner

	PLATFORM_CODE = var_5
	PLATFORM_CH = var_6

	var_2(var_3_19, var_5 == var_6)

	PLATFORM_CODE = var_2
	PLATFORM_CH = var_3_16

	if var_2 == var_3_16 then
		local function var_3_20()
			local var_10_0 = arg_3_0
			local var_10_1 = var_0.emit

			NewYearFestivalMediator = var_2_10003

			local var_10_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_10_1(var_10_0, var_10_2, var_2_10004.SUMMARY)

			return
		end

		onButton = var_3_16

		local var_3_21 = arg_3_0
		local var_3_22 = arg_3_0.map_longpaifang
		local var_3_23 = var_3_20

		SFX_PANEL = var_8

		var_3_16(var_3_21, var_3_22, var_3_23, var_8)

		onButton = var_3_16

		local var_3_24 = arg_3_0
		local var_3_25 = arg_3_0.map_longpaifangBanner
		local var_3_26 = var_3_20

		SFX_PANEL = var_8

		var_3_16(var_3_24, var_3_25, var_3_26, var_8)
	end

	arg_3_0:BindItemSkinShop()

	local function var_3_27()
		local var_11_0

		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_11_1 = var_2_10001(var_2_10003)
		local var_11_2 = var_1.getActivityByType

		ActivityConst = var_2_10004

		local var_11_3 = var_11_2(var_11_1, var_2_10004.ACTIVITY_TYPE_BUILDSHIP_1)

		getProxy = var_2_10002
		ActivityProxy = var_4

		local var_11_4 = var_2_10002(var_4)
		local var_11_5 = var_2.getActivityByType

		ActivityConst = var_2_10005

		local var_11_6 = var_11_5(var_11_4, var_2_10005.ACTIVITY_TYPE_BUILD)

		if var_11_3 and not var_11_3:isEnd() then
			BuildShipScene = var_11_1
			var_11_0 = var_11_1.PROJECTS.ACTIVITY
		elseif var_11_6 and not var_11_6:isEnd() then
			var_11_1 = {}
			BuildShipScene = var_11_4
			var_11_1[1] = var_11_4.PROJECTS.SPECIAL
			BuildShipScene = var_4
			var_11_1[2] = var_4.PROJECTS.LIGHT
			BuildShipScene = var_4
			var_11_1[3] = var_4.PROJECTS.HEAVY
			var_2_10006 = var_11_6
			var_11_0 = var_11_1[var_11_6.getConfig(var_2_10006, "config_client").id]
		else
			pg = var_11_1

			local var_11_7 = var_11_1.TipsMgr.GetInstance()
			local var_11_8 = var_3.ShowTips

			i18n = var_2_10006

			var_11_8(var_11_7, var_2_10006("common_activity_end"))

			return
		end

		local var_11_9 = arg_3_0
		local var_11_10 = var_3.emit

		BackHillMediatorTemplate = var_2_10006

		local var_11_11 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		local var_11_12 = var_2_10007.GETBOAT
		local var_11_13 = {}

		BuildShipScene = var_2_10009
		var_11_13.page = var_2_10009.PAGE_BUILD
		var_11_13.projectName = var_11_0

		var_11_10(var_11_9, var_11_11, var_11_12, var_11_13)

		return
	end

	onButton = var_3_16

	local var_3_28 = arg_3_0
	local var_3_29 = arg_3_0.map_xianshijianzao
	local var_3_30 = var_3_27

	SFX_PANEL = var_8

	var_3_16(var_3_28, var_3_29, var_3_30, var_8)

	onButton = var_3_16

	local var_3_31 = arg_3_0
	local var_3_32 = arg_3_0.map_xianshijianzaoBanner
	local var_3_33 = var_3_27

	SFX_PANEL = var_8

	var_3_16(var_3_31, var_3_32, var_3_33, var_8)
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_12_0)
	local function var_12_0()
		BackHillTemplate = var_2_10000

		local var_13_0 = var_2_10000.IsMiniActNeedTip

		ActivityConst = var_2_10002

		return var_13_0(var_2_10002.JIUJIU_DUOMAOMAO_ID)
	end

	setActive = var_1_10002

	local var_12_1 = arg_12_0.upper_youxidian

	var_1_10002(var_4.Find(var_12_1, "Tip"), var_12_0())

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_12_2 = var_1_10002(var_4)
	local var_12_3 = var_2.getActivityById

	ActivityConst = var_5

	if var_12_3(var_12_2, var_5.JIUJIU_DUOMAOMAO_ID) then
		::label_12_0::

		getProxy = var_1_10003
		MiniGameProxy = var_5

		local var_12_4 = var_1_10003(var_5)

		var_1_10003 = var_1_10003.GetHubByHubId(var_12_4, var_2:getConfig("config_id"))
	end

	local var_12_5

	if not var_1_10003 or not var_1_10003.count then
		var_12_5 = 0
	end

	arg_12_0.usableTxt.text = "X" .. var_12_5

	local function var_12_6()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_14_0 = var_2_10000(var_2_10002)
		local var_14_1 = var_0.getActivityById

		ActivityConst = var_2_10003

		local var_14_2 = var_14_1(var_14_0, var_2_10003.ACTIVITY_MAID_DAY)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_14_2)
	end

	setActive = var_6

	local var_12_7 = arg_12_0.upper_kafeiting

	var_6(var_8.Find(var_12_7, "Tip"), var_12_6())

	local function var_12_8()
		PLATFORM_CODE = var_2_10000
		PLATFORM_CH = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			return
		end

		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_15_0 = var_2_10000(var_2_10002)
		local var_15_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		local var_15_2 = var_15_1(var_15_0, var_2_10003.ACTIVITY_TYPE_SUMMARY)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_15_2)
	end

	setActive = var_7

	local var_12_9 = arg_12_0.map_longpaifangBanner

	var_7(var_9.Find(var_12_9, "Tip"), var_12_8())

	return
end

function var_0_1.IsShowMainTip(arg_16_0)
	local function var_16_0()
		BackHillTemplate = var_2_10000

		local var_17_0 = var_2_10000.IsMiniActNeedTip

		ActivityConst = var_2_10002

		return var_17_0(var_2_10002.JIUJIU_DUOMAOMAO_ID)
	end

	local function var_16_1()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_18_0 = var_2_10000(var_2_10002)
		local var_18_1 = var_0.getActivityById

		ActivityConst = var_2_10003

		local var_18_2 = var_18_1(var_18_0, var_2_10003.ACTIVITY_MAID_DAY)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_18_2)
	end

	local function var_16_2()
		PLATFORM_CODE = var_2_10000
		PLATFORM_CH = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			return
		end

		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_19_0 = var_2_10000(var_2_10002)
		local var_19_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		local var_19_2 = var_19_1(var_19_0, var_2_10003.ACTIVITY_TYPE_SUMMARY)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_19_2)
	end

	local var_16_3

	if not var_16_0() and not var_16_1() then
		var_16_3 = var_16_2()
	end

	return var_16_3
end

function var_0_1.willExit(arg_20_0)
	arg_20_0:clearStudents()
	var_0_1.super.willExit(arg_20_0)

	return
end

return var_0_1
