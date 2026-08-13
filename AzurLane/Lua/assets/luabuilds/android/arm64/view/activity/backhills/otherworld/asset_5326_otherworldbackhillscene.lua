class = var_0_10000

local var_0_0 = "OtherworldBackHillScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "OtherworldBackHillUI"
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
	arg_2_0.graphPath = var_2_10(var_2_9("GameCfg.BackHillGraphs.OtherworldBackHillSceneGraph"))

	local var_2_11 = arg_2_0._tf

	arg_2_0.ptIconTF = var_1.Find(var_2_11, "top/Res/icon")

	local var_2_12 = arg_2_0._tf

	arg_2_0.ptValueTF = var_1.Find(var_2_12, "top/Res/Text")

	return
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0:SetNativeSizes()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/Back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.onBackPressed(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0._tf
	local var_3_6 = var_4.Find(var_3_5, "top/Home")

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.quickExitFunc(var_5_0)

		return
	end

	SFX_PANEL = var_3_5

	var_1(var_3_4, var_3_6, var_3_7, var_3_5)

	onButton = var_1

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
		var_6_2.helps = var_2_10004.gametip.otherworld_backhill_help.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_3_9

	var_1(var_3_8, var_3_10, var_3_11, var_3_9)

	onButton = var_1

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0._tf
	local var_3_14 = var_4.Find(var_3_13, "top/Terminal")

	local function var_3_15()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.emit

		OtherworldBackHilllMediator = var_2_10003

		local var_7_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_7_3 = var_2_10004.New
		local var_7_4 = {}

		OtherworldTerminalMediator = var_2_10007
		var_7_4.mediator = var_2_10007
		OtherworldTerminalLayer = var_2_10007
		var_7_4.viewComponent = var_2_10007

		var_7_1(var_7_0, var_7_2, var_7_3(var_7_4))

		return
	end

	SFX_CANCEL = var_3_13

	var_1(var_3_12, var_3_14, var_3_15, var_3_13)

	onButton = var_1

	local var_3_16 = arg_3_0
	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_4.Find(var_3_17, "top/OtherWorld")

	local function var_3_19()
		pg = var_2_10000

		local var_8_0 = var_2_10000.SceneAnimMgr.GetInstance()
		local var_8_1 = var_0.OtherWorldCoverGoScene

		SCENE = var_2_10003

		local var_8_2 = var_2_10003.OTHERWORLD_MAP
		local var_8_3 = {}

		OtherworldMapScene = var_2_10005
		var_8_3.mode = var_2_10005.MODE_BATTLE

		var_8_1(var_8_0, var_8_2, var_8_3)

		return
	end

	SFX_CANCEL = var_3_17

	var_1(var_3_16, var_3_18, var_3_19, var_3_17)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "maoxianzgonghui", function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_9_0 = var_2_10000(var_2_10002)
		local var_9_1 = var_0.getActivityById

		ActivityConst = var_2_10003

		if not var_9_1(var_9_0, var_2_10003.OTHER_WORLD_TASK_ID) or var_0:isEnd() then
			pg = var_2_10001

			local var_9_2 = var_2_10001.TipsMgr.GetInstance()
			local var_9_3 = var_1.ShowTips

			i18n = var_2_10004

			var_9_3(var_9_2, var_2_10004("common_activity_end"))

			return
		end

		local var_9_4 = arg_3_0
		local var_9_5 = var_1.emit

		OtherworldBackHilllMediator = var_2_10004

		local var_9_6 = var_2_10004.GO_SUBLAYER

		Context = var_2_10005

		local var_9_7 = var_2_10005.New
		local var_9_8 = {}

		OtherWorldTaskMediator = var_2_10008
		var_9_8.mediator = var_2_10008
		OtherWorldTaskLayer = var_2_10008
		var_9_8.viewComponent = var_2_10008

		var_9_5(var_9_4, var_9_6, var_9_7(var_9_8))

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "jiujiushendian", function()
		local var_10_0 = arg_3_0
		local var_10_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_10_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_10_1(var_10_0, var_10_2, var_2_10004.OTHER_WORLD_TEMPLE_SCENE)

		return
	end)
	arg_3_0:BindItemSkinShop()

	local var_3_20 = arg_3_0

	arg_3_0.UpdateView(var_3_20)

	getProxy = var_1
	ActivityProxy = var_3_20

	local var_3_21 = var_1(var_3_20)
	local var_3_22 = var_1.getActivityById

	ActivityConst = var_4

	if not var_3_22(var_3_21, var_4.OTHER_WORLD_TERMINAL_LOTTERY_ID) then
		return
	end

	local var_3_23 = var_1:getConfig("config_data")[1]

	pg = var_3_21
	arg_3_0.resId = var_3_21.activity_random_award_template[var_3_23].resource_type
	GetImageSpriteFromAtlasAsync = var_3
	Drop = var_5

	local var_3_24 = var_5.New
	local var_3_25 = {}

	DROP_TYPE_RESOURCE = var_1_10008
	var_3_25.type = var_1_10008
	var_3_25.id = arg_3_0.resId

	local var_3_26 = var_3_24(var_3_25)

	var_3(var_5.getIcon(var_3_26), "", arg_3_0.ptIconTF)
	arg_3_0:UpdateRes()

	return
end

function var_0_1.SetNativeSizes(arg_11_0)
	eachChild = var_1_10001

	var_1_10001(arg_11_0._upper, function(arg_12_0)
		if arg_12_0:Find("Image") then
			::label_12_0::

			local var_12_0 = var_1

			var_2_10002 = var_1.GetComponent
			typeof = var_2_10005
			Image = var_2_10007
			var_2_10002 = var_2_10002(var_12_0, var_2_10005(var_2_10007))
		end

		if var_2_10002 then
			var_2_10002:SetNativeSize()
		end

		return
	end)

	return
end

function var_0_1.GongHuiTip()
	getProxy = var_1_10000
	ActivityTaskProxy = var_1_10002

	local var_13_0 = var_1_10000(var_1_10002)
	local var_13_1 = var_0.getActTaskTip

	ActivityConst = var_1_10003

	return var_13_1(var_13_0, var_1_10003.OTHER_WORLD_TASK_ID)
end

function var_0_1.ShenDianTip()
	ActivityItemPool = var_1_10000

	local var_14_0 = var_1_10000.GetTempleRedTip

	ActivityConst = var_1_10002

	return var_14_0(var_1_10002.OTHER_WORLD_TERMINAL_LOTTERY_ID)
end

function var_0_1.TerminalTip()
	TerminalAdventurePage = var_1_10000

	return var_1_10000.IsTip()
end

function var_0_1.UpdateRes(arg_16_0)
	setText = var_1_10001

	local var_16_0 = arg_16_0.ptValueTF

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_16_1 = var_1_10004(var_1_10006)
	local var_16_2 = var_4.getData(var_16_1)

	var_1_10001(var_16_0, var_4.getResource(var_16_2, arg_16_0.resId))

	return
end

function var_0_1.UpdateView(arg_17_0)
	setActive = var_1_10001

	local var_17_0 = arg_17_0.upper_maoxianzgonghui

	var_1_10001(var_3.Find(var_17_0, "Tip"), var_0_1.GongHuiTip())

	setActive = var_1_10001

	local var_17_1 = arg_17_0.upper_jiujiushendian

	var_1_10001(var_3.Find(var_17_1, "Tip"), var_0_1.ShenDianTip())

	setActive = var_1_10001

	local var_17_2 = arg_17_0._tf

	var_1_10001(var_3.Find(var_17_2, "top/Terminal/Tip"), var_0_1.TerminalTip())

	return
end

function var_0_1.UpdateActivity(arg_18_0)
	arg_18_0:UpdateView()

	return
end

function var_0_1.willExit(arg_19_0)
	arg_19_0:clearStudents()
	var_0_1.super.willExit(arg_19_0)

	return
end

function var_0_1.IsShowMainTip(arg_20_0)
	if arg_20_0 and not arg_20_0:isEnd() then
		local var_20_0

		if not var_0_1.GongHuiTip() then
			var_20_0 = var_0_1.ShenDianTip()
		end

		return var_20_0
	end

	return
end

function var_0_1.IsShowTip()
	local var_21_0

	if not var_0_1.GongHuiTip() then
		var_21_0 = var_0_1.ShenDianTip()
	end

	return var_21_0
end

return var_0_1
