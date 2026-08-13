class = var_0_10000

local var_0_0 = "MusicFestivalScene3"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "MusicFestivalUI3"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

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

	local var_2_4 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_4, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_5 = arg_2_0._upper
		local var_2_6 = var_5.GetChild(var_2_5, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_6).name
		arg_2_0["upper_" .. var_1_10006] = var_2_6
	end

	local var_2_7 = arg_2_0._upper

	arg_2_0._SDPlace = var_1.Find(var_2_7, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_8 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_8, "ship")
	GraphPath = var_1

	local var_2_9 = var_1.New

	import = var_2_8
	arg_2_0.graphPath = var_2_9(var_2_8("GameCfg.BackHillGraphs.MusicFestivalGraph3"))

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
	local var_3_10 = var_4.Find(var_3_9, "top/Help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.idol3rd_houshan.tip

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

	local var_3_14 = var_3_13(var_3_12, var_3_10.MUSIC_FESTIVAL_ID_3)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 3, 4)

	local var_3_15 = arg_3_0

	arg_3_0.InitFacilityCross(var_3_15, arg_3_0._map, arg_3_0._upper, "xiaoyouxi", function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.m02
		local var_7_1 = var_0.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.GO_MINI_GAME, 16)

		return
	end)

	getProxy = var_2
	ActivityProxy = var_3_15

	local var_3_16 = var_2(var_3_15)
	local var_3_17 = var_2.getActivityById

	ActivityConst = var_5

	local var_3_18 = var_3_17(var_3_16, var_5.MUSIC_FESTIVAL_PT_ID_3)

	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "huodongye", function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_8_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_8_1(var_8_0, var_8_2, var_2_10004.ACTIVITY, {
			id = var_3_18.id
		})

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "dalaozhang", function()
		local var_9_0 = arg_3_0
		local var_9_1 = var_0.emit

		MusicFestivalMediator = var_2_10003

		local var_9_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_9_1(var_9_0, var_9_2, var_2_10004.IDOL_MEDAL_COLLECTION_SCENE3)

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:BindItemBattle()
	arg_3_0:UpdateView()

	return
end

function var_0_1.MiniGameTip()
	BackHillTemplate = var_1_10000

	local var_10_0 = var_1_10000.IsMiniActNeedTip

	ActivityConst = var_1_10002

	return var_10_0(var_1_10002.MUSIC_FESTIVAL_ID_3)
end

function var_0_1.MedalTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_11_0 = var_1_10000(var_1_10002)
	local var_11_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_11_2 = var_11_1(var_11_0, var_1_10003.ACTIVITY_TYPE_PUZZLA)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_11_2)
end

function var_0_1.ActivityTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_12_0 = var_1_10000(var_1_10002)
	local var_12_1 = var_0.getActivityById

	ActivityConst = var_1_10003

	local var_12_2 = var_12_1(var_12_0, var_1_10003.MUSIC_FESTIVAL_PT_ID_3)

	Activity = var_1_10001

	return var_1_10001.IsActivityReady(var_12_2)
end

function var_0_1.UpdateView(arg_13_0)
	setActive = var_1_10001

	local var_13_0 = arg_13_0.upper_xiaoyouxi

	var_1_10001(var_3.Find(var_13_0, "Tip"), var_0_1.MiniGameTip())

	setActive = var_1_10001

	local var_13_1 = arg_13_0.upper_dalaozhang

	var_1_10001(var_3.Find(var_13_1, "Tip"), var_0_1.MedalTip())

	setActive = var_1_10001

	local var_13_2 = arg_13_0.upper_huodongye

	var_1_10001(var_3.Find(var_13_2, "Tip"), var_0_1.ActivityTip())

	return
end

function var_0_1.IsShowMainTip(arg_14_0)
	if arg_14_0 and not arg_14_0:isEnd() then
		local var_14_0

		if not var_0_1.MiniGameTip() and not var_0_1.MedalTip() then
			var_14_0 = var_0_1.ActivityTip()
		end

		return var_14_0
	end

	return
end

function var_0_1.willExit(arg_15_0)
	arg_15_0:clearStudents()
	var_0_1.super.willExit(arg_15_0)

	return
end

return var_0_1
