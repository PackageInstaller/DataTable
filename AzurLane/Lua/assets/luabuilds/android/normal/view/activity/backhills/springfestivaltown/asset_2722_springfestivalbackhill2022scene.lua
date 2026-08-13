class = var_0_10000

local var_0_0 = "SpringFestivalBackHill2022Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "SpringFestivalBackHill2022UI"
end

var_0_1.edge2area = {
	default = "_sdPlace"
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

	arg_2_0._sdPlace = var_1.Find(var_2_7, "SDPlace")

	local var_2_8 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_8, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_9 = arg_2_0._upper
		local var_2_10 = var_5.GetChild(var_2_9, iter_2_1)

		go = var_2_9

		local var_2_11 = var_2_9(var_2_10).name

		arg_2_0["upper_" .. var_2_11] = var_2_10
	end

	arg_2_0.containers = {
		arg_2_0._sdPlace
	}
	GraphPath = var_1

	local var_2_12 = var_1.New

	import = var_2
	arg_2_0.graphPath = var_2_12(var_2("GameCfg.BackHillGraphs.SpringFestival2022Graph"))

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
		var_6_2.helps = var_2_10003.gametip.springfes_tips1.tip

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

	local var_3_14 = var_3_13(var_3_12, var_3_10.MINIGAME_SPRINGFESTIVAL_2022)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 3, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "fushundamaoxian", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10002

		var_7_1(var_7_0, var_2_10002.GO_MINI_GAME, 37)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "longtenghuyue", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_8_3 = var_2_10003.ACTIVITY
		local var_8_4 = {}

		ActivityConst = var_2_10005
		var_8_4.id = var_2_10005.ANSHAN_CHANGCHUN_GAIZAO_ID

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huazhongshijie", function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_9_0 = var_2_10000(var_2_10001)
		local var_9_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		if not var_9_1(var_9_0, var_2_10002.ACTIVITY_TYPE_WORLDINPICTURE) or var_0:isEnd() then
			pg = var_9_0

			local var_9_2 = var_9_0.TipsMgr.GetInstance()
			local var_9_3 = var_1.ShowTips

			i18n = var_2_10003

			var_9_3(var_9_2, var_2_10003("common_activity_end"))

			return
		end

		local var_9_4 = var_0
		local var_9_5 = var_0.getConfig(var_9_4, "config_client").linkActID

		pg = var_9_4

		local var_9_6 = var_9_4.m02
		local var_9_7 = var_2.sendNotification

		GAME = var_2_10004

		local var_9_8 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_9_7(var_9_6, var_9_8, var_2_10005.ACTIVITY, {
			id = var_9_5
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huituriji", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_10_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_10_1(var_10_0, var_10_2, var_2_10003.COLORING)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jiulou", function()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_11_2 = var_2_10002.GO_SUBLAYER

		Context = var_2_10003

		local var_11_3 = var_2_10003.New
		local var_11_4 = {}

		RedPacketMediator = var_2_10005
		var_11_4.mediator = var_2_10005
		RedPacketLayer = var_2_10005
		var_11_4.viewComponent = var_2_10005

		var_11_1(var_11_0, var_11_2, var_11_3(var_11_4))

		return
	end)
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_12_0)
	local var_12_0
	local var_12_1

	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_12_2 = var_1_10003(var_1_10004)

	getProxy = var_1_10004
	ColoringProxy = var_1_10005

	local var_12_3 = var_1_10004(var_1_10005)
	local var_12_4 = var_4.CheckTodayTip(var_12_3)

	setActive = var_4

	local var_12_5 = arg_12_0.upper_huituriji

	var_4(var_5.Find(var_12_5, "Tip"), var_12_4)

	BackHillTemplate = var_4

	local var_12_6 = var_4.IsMiniActNeedTip

	ActivityConst = var_5

	local var_12_7 = var_12_6(var_5.MINIGAME_SPRINGFESTIVAL_2022)

	setActive = var_4

	local var_12_8 = arg_12_0.upper_fushundamaoxian

	var_4(var_5.Find(var_12_8, "Tip"), var_12_7)

	RedPacketLayer = var_4

	local var_12_9 = var_4.isShowRedPoint()

	setActive = var_4

	local var_12_10 = arg_12_0.upper_jiulou

	var_4(var_5.Find(var_12_10, "Tip"), var_12_9)

	local var_12_11 = var_12_2
	local var_12_12 = var_12_2.getActivityByType

	ActivityConst = var_6

	local var_12_13 = var_12_12(var_12_11, var_6.ACTIVITY_TYPE_WORLDINPICTURE)

	Activity = var_4

	local var_12_14 = var_4.IsActivityReady(var_12_13)

	setActive = var_4

	local var_12_15 = arg_12_0.upper_huazhongshijie

	var_4(var_5.Find(var_12_15, "Tip"), var_12_14)

	local var_12_16 = var_12_2
	local var_12_17 = var_12_2.getActivityById

	ActivityConst = var_6

	local var_12_18 = var_12_17(var_12_16, var_6.ANSHAN_CHANGCHUN_GAIZAO_ID)

	Activity = var_4

	local var_12_19 = var_4.IsActivityReady(var_12_18)

	setActive = var_4

	local var_12_20 = arg_12_0.upper_longtenghuyue

	var_4(var_5.Find(var_12_20, "Tip"), var_12_19)

	return
end

function var_0_1.willExit(arg_13_0)
	arg_13_0:clearStudents()
	var_0_1.super.willExit(arg_13_0)

	return
end

return var_0_1
