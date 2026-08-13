class = var_0_10000

local var_0_0 = "HarborBackHillScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "HarborBackHillUI"
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
	arg_2_0.graphPath = var_2_12(var_2_11("GameCfg.BackHillGraphs.HarborBackHillGraph"))

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
		var_6_2.helps = var_2_10003.gametip.harbor_backhill_help.tip

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

	local var_3_14 = var_3_13(var_3_12, var_3_10.MINIGAME_PIRATE_ID)

	arg_3_0:InitStudents(var_3_14 and var_3_14.id, 2, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "xuanshangban", function()
		if var_0_1.XuanShangBanFirstTip() then
			getProxy = var_0
			PlayerProxy = var_2_10001

			local var_7_0 = var_0(var_2_10001)
			local var_7_1 = var_0.getData(var_7_0).id

			PlayerPrefs = var_7_0

			local var_7_2 = var_7_0.SetInt

			var_2_10002 = "FIRST_INTO_ACT_"
			ActivityConst = var_2_10003

			var_7_2(var_2_10002 .. var_2_10003.PIRATE_MEDAL_ACT_ID .. "_" .. var_7_1, 1)
		end

		local var_7_3 = arg_3_0
		local var_7_4 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_7_5 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_7_4(var_7_3, var_7_5, var_2_10003.TEMPESTA_MEDAL_COLLECTION)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "mimichuanchang", function()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10002

		local var_8_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_8_1(var_8_0, var_8_2, var_2_10003.SECRET_SHIPYARD)

		return
	end)
	arg_3_0:BindItemActivityShop()
	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:UpdateView()

	return
end

function var_0_1.XuanShangBanFirstTip()
	getProxy = var_1_10000
	PlayerProxy = var_1_10001

	local var_9_0 = var_1_10000(var_1_10001)
	local var_9_1 = var_0.getData(var_9_0).id

	PlayerPrefs = var_9_0

	local var_9_2 = var_9_0.GetInt
	local var_9_3 = "FIRST_INTO_ACT_"

	ActivityConst = var_1_10003

	return var_9_2(var_9_3 .. var_1_10003.PIRATE_MEDAL_ACT_ID .. "_" .. var_9_1) == 0
end

function var_0_1.XuanShangBanTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_10_0 = var_1_10000(var_1_10001)
	local var_10_1 = var_0.getActivityById

	ActivityConst = var_1_10002

	local var_10_2 = var_10_1(var_10_0, var_1_10002.PIRATE_MEDAL_ACT_ID)
	local var_10_3

	if not var_0_1.XuanShangBanFirstTip() then
		Activity = var_10_3
		var_10_3 = var_10_3.IsActivityReady(var_10_2)
	end

	return var_10_3
end

function var_0_1.IsFinishAllActTask()
	getProxy = var_1_10000
	TaskProxy = var_1_10001

	local var_11_0 = var_1_10000(var_1_10001)

	pg = var_1_10001

	local var_11_1 = var_1_10001.activity_template

	ActivityConst = var_1_10002

	local var_11_2 = var_1[#var_11_1[var_1_10002.BOAT_QIAN_SHAO_ZHAN].config_data]

	underscore = var_1_10003

	return var_1_10003.all(var_11_2, function(arg_12_0)
		local var_12_0 = var_11_0

		return var_1.getFinishTaskById(var_12_0, arg_12_0)
	end)
end

function var_0_1.MiMiChuanChangTip()
	local var_13_0

	if not var_0_1.IsFinishAllActTask() then
		getProxy = var_13_0
		ActivityProxy = var_1_10001
		var_1_10001 = var_13_0(var_1_10001)
		var_13_0 = var_13_0.getActivityById
		ActivityConst = var_1_10002
		var_13_0 = var_13_0(var_1_10001, var_1_10002.BOAT_QIAN_SHAO_ZHAN)
		Activity = var_1_10001

		return var_1_10001.IsActivityReady(var_13_0)
	else
		BackHillTemplate = var_13_0

		local var_13_1 = var_13_0.IsMiniActNeedTip

		ActivityConst = var_1_10001

		return var_13_1(var_1_10001.MINIGAME_PIRATE_ID)
	end

	return
end

function var_0_1.UpdateView(arg_14_0)
	setActive = var_1_10001

	local var_14_0 = arg_14_0.upper_mimichuanchang

	var_1_10001(var_2.Find(var_14_0, "Tip"), var_0_1.MiMiChuanChangTip())

	setActive = var_1_10001

	local var_14_1 = arg_14_0.upper_xuanshangban

	var_1_10001(var_2.Find(var_14_1, "Tip"), var_0_1.XuanShangBanTip())

	return
end

function var_0_1.willExit(arg_15_0)
	arg_15_0:clearStudents()
	var_0_1.super.willExit(arg_15_0)

	return
end

function var_0_1.IsShowMainTip(arg_16_0)
	if arg_16_0 and not arg_16_0:isEnd() then
		local var_16_0

		if not var_0_1.XuanShangBanTip() then
			var_16_0 = var_0_1.MiMiChuanChangTip()
		end

		return var_16_0
	end

	return
end

return var_0_1
