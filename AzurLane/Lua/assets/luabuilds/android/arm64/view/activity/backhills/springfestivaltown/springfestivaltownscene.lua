class = var_0_10000

local var_0_0 = "SpringFestivalTownScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "SpringFestivalTownUI"
end

function var_0_1.getBGM(arg_2_0)
	return "story-china"
end

var_0_1.HUB_ID = 5
var_0_1.edge2area = {
	default = "_middle",
	["9_9"] = "_bottom",
	["4_4"] = "_front"
}

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.top = var_1.Find(var_3_0, "top")

	local var_3_1 = arg_3_0._tf

	arg_3_0._closeBtn = var_1.Find(var_3_1, "top/return_btn")

	local var_3_2 = arg_3_0._tf

	arg_3_0._homeBtn = var_1.Find(var_3_2, "top/return_main_btn")

	local var_3_3 = arg_3_0._tf

	arg_3_0._helpBtn = var_1.Find(var_3_3, "top/help_btn")

	local var_3_4 = arg_3_0._tf

	arg_3_0._map = var_1.Find(var_3_4, "map")

	for iter_3_0 = 0, arg_3_0._map.childCount - 1 do
		var_1_10007 = arg_3_0._map

		local var_3_5 = var_5.GetChild(var_1_10007, iter_3_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_3_5).name
		arg_3_0["_" .. var_1_10006] = var_3_5
	end

	local var_3_6 = arg_3_0._map

	arg_3_0._front = var_1.Find(var_3_6, "top")

	local var_3_7 = arg_3_0._map

	arg_3_0._middle = var_1.Find(var_3_7, "middle")

	local var_3_8 = arg_3_0._map

	arg_3_0._bottom = var_1.Find(var_3_8, "bottom")
	arg_3_0.containers = {
		arg_3_0._front,
		arg_3_0._middle,
		arg_3_0._bottom
	}

	local var_3_9 = arg_3_0._map

	arg_3_0._shipTpl = var_1.Find(var_3_9, "ship")
	GraphPath = var_1

	local var_3_10 = var_1.New

	import = var_3_9
	arg_3_0.graphPath = var_3_10(var_3_9("GameCfg.BackHillGraphs.SpringFestivalTownGraph"))

	local var_3_11 = arg_3_0._tf

	arg_3_0._upper = var_1.Find(var_3_11, "upper")

	local var_3_12 = arg_3_0.top
	local var_3_13 = var_1.Find(var_3_12, "usable_count/Text")
	local var_3_14 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.usableTxt = var_3_14(var_3_13, var_4(var_1_10006))

	local var_3_15 = arg_3_0.top

	arg_3_0.diedieleTF = var_1.Find(var_3_15, "diediele_count")

	local var_3_16 = arg_3_0.diedieleTF
	local var_3_17 = var_1.Find(var_3_16, "Text")
	local var_3_18 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_3_0.diedieleTxt = var_3_18(var_3_17, var_4(var_1_10006))
	LoadPrefabRequestPackage = var_1

	local var_3_19 = var_1.New("ui/map_donghuangchunjie", "map_donghuangchunjie", function(arg_4_0)
		setParent = var_2_10001

		var_2_10001(arg_4_0, arg_3_0._map, false)

		GameObject = var_2_10001

		local var_4_0 = var_2_10001.Find("UICamera/Canvas")
		local var_4_1 = var_1.GetComponent

		typeof = var_4
		Canvas = var_2_10006

		local var_4_2 = var_4_1(var_4_0, var_4(var_2_10006)).sortingOrder
		local var_4_3 = arg_4_0
		local var_4_4 = arg_4_0.GetComponentsInChildren

		typeof = var_2_10006
		Renderer = var_2_10008

		local var_4_5 = var_4_4(var_4_3, var_2_10006(var_2_10008))
		local var_4_6 = var_3.ToTable(var_4_5)

		ipairs = var_4

		for iter_4_0, iter_4_1 in var_4(var_4_6) do
			iter_4_1.sortingOrder = var_4_2 + 1
		end

		arg_3_0.mapeffect = arg_4_0

		return
	end)

	arg_3_0.effectReq = var_1.Start(var_3_19)

	local var_3_20 = arg_3_0
	local var_3_21 = arg_3_0.managedTween

	LeanTween = var_4

	local var_3_22 = var_4.value
	local var_3_23

	go = var_1_10006

	local var_3_24 = var_1_10006(arg_3_0._map)

	System = var_1_10007

	local var_3_25 = var_1_10007.Action_UnityEngine_Color(function(arg_5_0)
		go = var_2_10001

		local var_5_0 = var_2_10001(arg_3_0._map)
		local var_5_1 = var_1.GetComponent

		typeof = var_2_10004
		Image = var_2_10006

		local var_5_2 = var_5_1(var_5_0, var_2_10004(var_2_10006)).material

		var_1.SetColor(var_5_2, "_Color", arg_5_0)

		return
	end)

	Color = var_8

	local var_3_26 = var_8(0, 0, 0, 0)

	Color = var_9

	local var_3_27 = var_3_21(var_3_20, var_3_22, var_3_23, var_3_24, var_3_25, var_3_26, var_9(1, 1, 0, 0), 1.5)

	var_1.setLoopPingPong(var_3_27, -1)

	return
end

function var_0_1.didEnter(arg_6_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)

	onButton = var_1_10002

	var_1_10002(arg_6_0, arg_6_0._closeBtn, function()
		local var_7_0 = arg_6_0

		var_0.emit(var_7_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_6_0, arg_6_0.diedieleTF, function()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		var_8_1(var_8_0, var_2_10003.ON_OPEN_PILE_SIGNED)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_6_0, arg_6_0._homeBtn, function()
		local var_9_0 = arg_6_0

		var_0.emit(var_9_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_6_0, arg_6_0._helpBtn, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.help_chunjie_feast.tip

		var_10_1(var_10_0, var_10_2)

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "kaihongbao", function()
		local var_11_0 = arg_6_0
		local var_11_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_11_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_11_3 = var_2_10004.New
		local var_11_4 = {}

		RedPacketMediator = var_2_10007
		var_11_4.mediator = var_2_10007
		RedPacketLayer = var_2_10007
		var_11_4.viewComponent = var_2_10007

		function var_11_4.onRemoved()
			if arg_6_0.mapeffect then
				setActive = var_0

				var_0(arg_6_0.mapeffect, true)
			end

			return
		end

		var_11_1(var_11_0, var_11_2, var_11_3(var_11_4), function()
			if arg_6_0.mapeffect then
				setActive = var_0

				var_0(arg_6_0.mapeffect, false)
			end

			return
		end)

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "danianshou", function()
		local var_14_0 = arg_6_0
		local var_14_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_14_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_14_3 = var_2_10004.ACTIVITY
		local var_14_4 = {}

		ActivityConst = var_2_10006
		var_14_4.id = var_2_10006.BEAT_MONSTER_NIAN_2020

		var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "dafuweng", function()
		local var_15_0 = arg_6_0
		local var_15_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_15_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_15_3 = var_2_10004.ACTIVITY
		local var_15_4 = {}

		ActivityConst = var_2_10006
		var_15_4.id = var_2_10006.MONOPOLY_2020

		var_15_1(var_15_0, var_15_2, var_15_3, var_15_4)

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "diediele", function()
		pg = var_2_10000

		local var_16_0 = var_2_10000.m02
		local var_16_1 = var_0.sendNotification

		GAME = var_2_10003

		var_16_1(var_16_0, var_2_10003.GO_MINI_GAME, 9)

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "jianzao", function()
		local var_17_0 = arg_6_0
		local var_17_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_17_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_17_1(var_17_0, var_17_2, var_2_10004.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "sishu", function()
		local var_18_0 = arg_6_0
		local var_18_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_18_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_18_1(var_18_0, var_18_2, var_2_10004.COLORING)

		return
	end)
	arg_6_0:InitFacilityCross(arg_6_0._map, arg_6_0._upper, "pifushangdian", function()
		local var_19_0 = arg_6_0
		local var_19_1 = var_0.emit

		NewYearFestivalMediator = var_2_10003

		local var_19_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_19_1(var_19_0, var_19_2, var_2_10004.SKINSHOP)

		return
	end)

	pg = var_2

	local var_6_1 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_6_1, arg_6_0.top)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.InitStudents

	ActivityConst = var_5

	var_6_3(var_6_2, var_5.ACTIVITY_478, 3, 5)
	arg_6_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_20_0)
	local var_20_0
	local var_20_1

	getProxy = var_1_10003
	ActivityProxy = var_1_10005

	local var_20_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	MiniGameProxy = var_1_10006

	local var_20_3 = var_1_10004(var_1_10006)
	local var_20_4 = arg_20_0._upper
	local var_20_5 = var_5.Find(var_20_4, "danianshou/tip")
	local var_20_6 = var_20_2
	local var_20_7 = var_20_2.getActivityById

	ActivityConst = var_8

	local var_20_8 = var_20_7(var_20_6, var_8.BEAT_MONSTER_NIAN_2020)

	setActive = var_5

	local var_20_9 = var_20_5
	local var_20_10

	if var_20_8 then
		::label_20_0::

		var_1_10010 = var_20_8
		var_20_10 = var_20_8.readyToAchieve(var_1_10010)
	end

	var_5(var_20_9, var_20_10)

	local var_20_11 = arg_20_0._upper
	local var_20_12 = var_5.Find(var_20_11, "dafuweng/tip")
	local var_20_13 = var_20_2
	local var_20_14 = var_20_2.getActivityById

	ActivityConst = var_8

	local var_20_15 = var_20_14(var_20_13, var_8.MONOPOLY_2020)

	setActive = var_5

	local var_20_16 = var_20_12
	local var_20_17

	if var_20_15 then
		::label_20_1::

		var_1_10010 = var_20_15
		var_20_17 = var_20_15.readyToAchieve(var_1_10010)
	end

	var_5(var_20_16, var_20_17)

	local var_20_18 = arg_20_0._upper
	local var_20_19

	var_20_19, setActive = var_5.Find(var_20_18, "sishu/tip"), var_5
	getProxy = var_8
	ColoringProxy = var_1_10010

	local var_20_20 = var_8(var_1_10010)

	var_5(var_20_19, var_8.CheckTodayTip(var_20_20))

	local var_20_21 = arg_20_0._upper
	local var_20_22 = var_5.Find(var_20_21, "jianzao/tip")

	setActive = var_5

	var_5(var_20_22, false)

	local var_20_23 = arg_20_0._upper
	local var_20_24 = var_5.Find(var_20_23, "pifushangdian/tip")

	setActive = var_5

	var_5(var_20_24, false)

	local var_20_25 = arg_20_0._upper
	local var_20_26

	var_20_26, setActive = var_5.Find(var_20_25, "kaihongbao/tip"), var_5
	RedPacketLayer = var_8

	var_5(var_20_26, var_8.isShowRedPoint())

	local var_20_27 = var_20_3:GetHubByHubId(arg_20_0.HUB_ID)
	local var_20_28 = arg_20_0._upper
	local var_20_29 = var_6.Find(var_20_28, "diediele/tip")

	setActive = var_6

	var_6(var_20_29, var_20_27.count > 0)
	arg_20_0:UpdateDieDieleCnt(var_20_27)

	return
end

function var_0_1.UpdateDieDieleCnt(arg_21_0, arg_21_1)
	arg_21_0.usableTxt.text = "X" .. arg_21_1.count
	arg_21_0.diedieleTxt.text = arg_21_1.usedtime .. "/" .. arg_21_1:getConfig("reward_need")

	return
end

function var_0_1.TryPlayStory(arg_22_0)
	return
end

function var_0_1.willExit(arg_23_0)
	local var_23_0 = arg_23_0.effectReq

	var_1.Stop(var_23_0)

	arg_23_0.mapeffect = nil
	pg = var_1

	local var_23_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_23_1, arg_23_0.top, arg_23_0._tf)
	arg_23_0:clearStudents()

	return
end

return var_0_1
