class = var_0_10000

local var_0_0 = "MusicFestivalScene2"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "MusicFestivalUI2"
end

var_0_1.edge2area = {
	default = "_middle"
}

function var_0_1.init(arg_2_0)
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

	arg_2_0._stageShip = var_1.Find(var_2_2, "stageship")

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

	local var_2_5 = arg_2_0.upper_model

	arg_2_0.modelTip = var_1.Find(var_2_5, "tip")
	setActive = var_1

	var_1(arg_2_0.modelTip, false)

	local var_2_6 = arg_2_0._map

	arg_2_0._middle = var_1.Find(var_2_6, "middle")
	arg_2_0.containers = {
		arg_2_0._middle
	}
	GraphPath = var_1

	local var_2_7 = var_1.New

	import = var_2
	arg_2_0.graphPath = var_2_7(var_2("GameCfg.BackHillGraphs.MusicFestivalGraph2"))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.GetComponentInParent

	typeof = var_3
	UnityEngine = iter_2_1

	local var_2_10

	var_2_10 = var_2_9(var_2_8, var_3(iter_2_1.Canvas)) and var_1.sortingOrder

	local var_2_11 = arg_2_0._map
	local var_2_12 = var_3.GetComponent

	typeof = var_1_10005
	UnityEngine = var_1_10006

	local var_2_13 = var_2_12(var_2_11, var_1_10005(var_1_10006.Canvas))

	var_2_13.sortingOrder = var_2_10 - 2
	AutoLoader = var_2_13
	arg_2_0.loader = var_2_13.New()

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	var_1_10001(var_3_0, var_3.Find(var_3_1, "top/return_btn"), function()
		local var_4_0 = arg_3_0

		var_0.emit(var_4_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0._tf

	var_1_10001(var_3_2, var_3.Find(var_3_3, "top/return_main_btn"), function()
		local var_5_0 = arg_3_0

		var_0.emit(var_5_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf

	var_1_10001(var_3_4, var_3.Find(var_3_5, "top/help_btn"), function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.music_main.tip

		var_6_1(var_6_0, var_6_2)

		return
	end)

	getProxy = var_1_10001
	ActivityProxy = var_3_4

	local var_3_6 = var_1_10001(var_3_4)
	local var_3_7 = var_1.getActivityById

	ActivityConst = var_3

	local var_3_8 = var_3_7(var_3_6, var_3.MUSIC_FESTIVAL_ID_2)

	arg_3_0:InitStudents(var_3_8 and var_3_8.id, 3, 4)

	onButton = var_2

	var_2(arg_3_0, arg_3_0.upper_model, function()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		MusicFestivalMediator = var_2_10002

		local var_7_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_1(var_7_0, var_7_2, var_2_10003.ACTIVITY, {
			id = var_3_8.id
		})

		return
	end)

	local var_3_9 = arg_3_0

	arg_3_0.InitFacilityCross(var_3_9, arg_3_0._map, arg_3_0._upper, "jichangwutai", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.GO_MINI_GAME, 16)

		return
	end)

	getProxy = var_2
	ActivityProxy = var_3_9

	local var_3_10 = var_2(var_3_9)
	local var_3_11 = var_2.getActivityByType

	ActivityConst = var_4

	local var_3_12 = var_3_11(var_3_10, var_4.ACTIVITY_TYPE_PT_BUFF)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "leijipt", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		MusicFestivalMediator = var_2_10002

		local var_9_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_9_1(var_9_0, var_9_2, var_2_10003.ACTIVITY, {
			id = var_3_12.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bujishangdian", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		MusicFestivalMediator = var_2_10002

		local var_10_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_10_3 = var_2_10003.SHOP
		local var_10_4 = {}

		NewShopsScene = var_2_10005
		var_10_4.warp = var_2_10005.TYPE_ACTIVITY

		var_10_1(var_10_0, var_10_2, var_10_3, var_10_4)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huangzhuangshangdian", function()
		local var_11_0 = arg_3_0
		local var_11_1 = var_0.emit

		MusicFestivalMediator = var_2_10002

		local var_11_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_11_1(var_11_0, var_11_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xianshijianzao", function()
		local var_12_0 = arg_3_0
		local var_12_1 = var_0.emit

		MusicFestivalMediator = var_2_10002

		local var_12_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_12_1(var_12_0, var_12_2, var_2_10003.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jinianzhang", function()
		Context = var_2_10000

		local var_13_0 = var_2_10000.New
		local var_13_1 = {}

		IdolMedalCollectionMediator = var_2_10002
		var_13_1.mediator = var_2_10002
		IdolMedalCollectionView2 = var_2_10002
		var_13_1.viewComponent = var_2_10002

		local var_13_2 = var_13_0(var_13_1)
		local var_13_3 = arg_3_0
		local var_13_4 = var_1.emit

		MusicFestivalMediator = var_2_10003

		var_13_4(var_13_3, var_2_10003.GO_SUBLAYER, var_13_2)

		return
	end)
	arg_3_0:BindItemBattle()
	arg_3_0:updateStageShip()
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
	local var_14_1
	local var_14_2 = var_14_0
	local var_14_3 = var_14_0.getActivityById

	ActivityConst = var_1_10005

	local var_14_4 = var_14_3(var_14_2, var_1_10005.MUSIC_FESTIVAL_ID_2)

	getProxy = var_14_2
	MiniGameProxy = var_5

	local var_14_5 = var_14_2(var_5)
	local var_14_6 = var_4.GetHubByHubId(var_14_5, var_14_4:getConfig("config_id")).count > 0
	local var_14_7 = arg_14_0.upper_jichangwutai
	local var_14_8 = var_6.Find(var_14_7, "tip")

	setActive = var_14_7

	var_14_7(var_14_8, var_14_6)

	local var_14_9 = var_5.usedtime >= var_5:getConfig("reward_need") and var_5.ultimate == 0

	setActive = var_7

	var_7(arg_14_0.modelTip, var_14_9)

	local var_14_10 = var_14_0
	local var_14_11 = var_14_0.getActivityByType

	ActivityConst = var_9

	local var_14_12 = var_14_11(var_14_10, var_9.ACTIVITY_TYPE_PT_BUFF)
	local var_14_13 = arg_14_0.upper_leijipt
	local var_14_14 = var_8.Find(var_14_13, "tip")
	local var_14_15 = var_14_12:readyToAchieve()

	setActive = var_9

	var_9(var_14_14, var_14_15)

	local var_14_16 = arg_14_0.upper_jinianzhang
	local var_14_17 = var_9.Find(var_14_16, "tip")
	local var_14_18 = var_0_1.MedalTip()

	setActive = var_10

	var_10(var_14_17, var_14_18)

	return
end

function var_0_1.getStageShip(arg_15_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_15_1 = var_1_10002(var_1_10003)
	local var_15_2 = var_2.getActivityById

	ActivityConst = var_1_10004

	if not var_15_2(var_15_1, var_1_10004.MUSIC_FESTIVAL_ID_2) then
		return
	end

	if var_2:getConfig("config_client") and var_3.stage_on_ship then
		local var_15_3 = #var_4

		math = var_1_10006

		return var_4[var_1_10006.random(1, var_15_3)], var_4.action[1]
	end

	return
end

function var_0_1.updateStageShip(arg_16_0)
	local var_16_0, var_16_1 = arg_16_0:getStageShip()

	if not var_16_0 then
		return
	end

	local var_16_2 = arg_16_0.loader

	var_3.GetSpine(var_16_2, var_16_0, function(arg_17_0)
		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.SetLocalScale

		Vector3 = var_2_10003

		var_17_1(var_17_0, var_2_10003(0.63, 0.63, 1))

		local var_17_2 = arg_17_0
		local var_17_3 = arg_17_0.SetLocalPosition

		Vector3 = var_3

		var_17_3(var_17_2, var_3.zero)
		arg_17_0:SetParent(arg_16_0._stageShip)
		arg_17_0:SetSiblingIndex(1)

		setActive = var_1

		var_1(arg_16_0._stageShip, true)
		arg_17_0:SetAction(var_16_1, 0)

		return
	end, arg_16_0._stageShip)

	return
end

function var_0_1.getStudents(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = {}

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_18_1 = var_1_10004(var_1_10005)

	if not var_4.getActivityById(var_18_1, arg_18_0) then
		return var_18_0
	end

	local var_18_2 = var_5
	local var_18_3

	if var_5.getConfig(var_18_2, "config_client") then
		var_18_3 = var_18_3.stage_off_ship
	end

	if var_18_3 then
		Clone = var_18_2

		local var_18_4 = var_18_2(var_18_3)

		math = var_7

		local var_18_5 = var_7.random(arg_18_1, arg_18_2)
		local var_18_6 = #var_18_4

		while var_18_5 > 0 and 0 < var_18_6 do
			math = var_18_7

			local var_18_7 = var_18_7.random(1, var_18_6)

			table = var_10

			var_10.insert(var_18_0, var_18_4[var_18_7])

			var_18_4[var_18_7] = var_18_4[var_18_6]
			var_18_6 = var_18_6 - 1
			var_18_5 = var_18_5 - 1
		end
	end

	return var_18_0
end

function var_0_1.MedalTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_19_0 = var_1_10000(var_1_10001)
	local var_19_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_19_2 = var_19_1(var_19_0, var_1_10002.ACTIVITY_TYPE_PUZZLA)

	Activity = var_19_0

	return var_19_0.IsActivityReady(var_19_2)
end

function var_0_1.IsShowMainTip(arg_20_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)
	local var_20_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_20_2 = var_20_1(var_20_0, var_1_10004.MUSIC_FESTIVAL_ID_2)

	assert = var_20_0

	var_20_0(var_20_2)

	local function var_20_3()
		local var_21_0 = var_0
		local var_21_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_21_2

		var_21_2 = var_21_1(var_21_0, var_2_10002.ACTIVITY_TYPE_PT_BUFF) and not var_0:isEnd() and var_0:readyToAchieve()

		return var_21_2
	end

	local var_20_4 = var_0_1.MedalTip

	local function var_20_5()
		getProxy = var_2_10000
		MiniGameProxy = var_2_10001

		local var_22_0 = var_2_10000(var_2_10001)
		local var_22_1 = var_0.GetHubByHubId
		local var_22_2 = var_20_2

		return var_22_1(var_22_0, var_2.getConfig(var_22_2, "config_id")).usedtime >= var_0:getConfig("reward_need") and var_0.ultimate == 0
	end

	local function var_20_6()
		getProxy = var_2_10000
		MiniGameProxy = var_2_10001

		local var_23_0 = var_2_10000(var_2_10001)
		local var_23_1 = var_0.GetHubByHubId
		local var_23_2 = var_20_2

		return var_23_1(var_23_0, var_2.getConfig(var_23_2, "config_id")).count > 0
	end

	local var_20_7

	if not var_20_3() and not var_20_4() and not var_20_5() then
		var_20_7 = var_20_6()
	end

	return var_20_7
end

function var_0_1.willExit(arg_24_0)
	arg_24_0:clearStudents()
	var_0_1.super.willExit(arg_24_0)

	return
end

return var_0_1
