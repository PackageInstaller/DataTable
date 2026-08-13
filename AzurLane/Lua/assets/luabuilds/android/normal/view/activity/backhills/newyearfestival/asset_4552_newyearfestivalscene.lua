class = var_0_10000

local var_0_0 = "NewyearFestivalScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewyearFestivalUI"
end

var_0_1.HUB_ID = 4

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.top = var_1.Find(var_2_0, "top")

	local var_2_1 = arg_2_0._tf

	arg_2_0._closeBtn = var_1.Find(var_2_1, "top/back")

	local var_2_2 = arg_2_0._tf

	arg_2_0._homeBtn = var_1.Find(var_2_2, "top/home")

	local var_2_3 = arg_2_0._tf

	arg_2_0._helpBtn = var_1.Find(var_2_3, "top/help")

	local var_2_4 = arg_2_0.top

	arg_2_0.ticketTimes = var_1.Find(var_2_4, "ticket/text")

	local var_2_5 = arg_2_0.top

	arg_2_0.yinhuace = var_1.Find(var_2_5, "sign")

	local var_2_6 = arg_2_0.yinhuace

	arg_2_0.yinhuaceTimes = var_1.Find(var_2_6, "get")

	local var_2_7 = arg_2_0.yinhuace

	arg_2_0.yinhuaceTips = var_1.Find(var_2_7, "tip")

	local var_2_8 = arg_2_0._tf

	arg_2_0.shouce = var_1.Find(var_2_8, "yinhuashouceye")

	local var_2_9 = arg_2_0.shouce

	arg_2_0.shouce_bg = var_1.Find(var_2_9, "bg")

	local var_2_10 = arg_2_0.shouce

	arg_2_0.layout_shouce = var_1.Find(var_2_10, "yinhuace/layout")
	CustomIndexLayer = var_1
	arg_2_0.group_get = var_1.Clone2Full(arg_2_0.layout_shouce, 7)

	local var_2_11 = arg_2_0.shouce

	arg_2_0.btn_receive = var_1.Find(var_2_11, "yinhuace/receive")

	local var_2_12 = arg_2_0.shouce

	arg_2_0.btn_shouce_help = var_1.Find(var_2_12, "yinhuace/help")

	local var_2_13 = arg_2_0.shouce

	arg_2_0.img_get = var_1.Find(var_2_13, "yinhuace/get")
	setActive = var_1

	var_1(arg_2_0.shouce, false)

	local var_2_14 = arg_2_0._tf

	arg_2_0._map = var_1.Find(var_2_14, "map")

	local var_2_15 = arg_2_0._map

	arg_2_0.shrine = var_1.Find(var_2_15, "shrine")

	local var_2_16 = arg_2_0._map

	arg_2_0.snack_street = var_1.Find(var_2_16, "snack")

	local var_2_17 = arg_2_0._map

	arg_2_0.divination = var_1.Find(var_2_17, "divination")

	local var_2_18 = arg_2_0._map

	arg_2_0.shop = var_1.Find(var_2_18, "shop")

	local var_2_19 = arg_2_0._map

	arg_2_0.cube = var_1.Find(var_2_19, "magiccube")

	local var_2_20 = arg_2_0._map

	arg_2_0.bottom2 = var_1.Find(var_2_20, "bottom2")

	local var_2_21 = arg_2_0._map

	arg_2_0.bottom = var_1.Find(var_2_21, "bottom")

	local var_2_22 = arg_2_0._map

	arg_2_0.middle = var_1.Find(var_2_22, "middle")

	local var_2_23 = arg_2_0._map

	arg_2_0.front = var_1.Find(var_2_23, "top")
	arg_2_0.containers = {
		arg_2_0.front,
		arg_2_0.middle,
		arg_2_0.bottom,
		arg_2_0.bottom2
	}

	local var_2_24 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_24, "ship")
	GraphPath = var_1

	local var_2_25 = var_1.New

	import = var_2_24
	arg_2_0.graphPath = var_2_25(var_2_24("GameCfg.BackHillGraphs.NewyearFestivalGraph"))
	LoadPrefabRequestPackage = var_1

	local var_2_26 = var_1.New("ui/xuedichangjing", "xuedichangjing", function(arg_3_0)
		setParent = var_2_10001

		var_2_10001(arg_3_0, arg_2_0._map, false)

		GameObject = var_2_10001

		local var_3_0 = var_2_10001.Find("UICamera/Canvas")
		local var_3_1 = var_1.GetComponent

		typeof = var_3
		Canvas = var_4

		local var_3_2 = var_3_1(var_3_0, var_3(var_4)).sortingOrder
		local var_3_3 = arg_3_0
		local var_3_4 = arg_3_0.GetComponentsInChildren

		typeof = var_2_10005
		Renderer = var_2_10006

		local var_3_5 = var_3_4(var_3_3, var_2_10005(var_2_10006))
		local var_3_6 = var_3.ToTable(var_3_5)

		ipairs = var_3_5

		for iter_3_0, iter_3_1 in var_3_5(var_3_6) do
			iter_3_1.sortingOrder = var_3_2 + 1
		end

		return
	end)

	arg_2_0.effectReq = var_1.Start(var_2_26)

	return
end

function var_0_1.didEnter(arg_4_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0._closeBtn, function()
		local var_5_0 = arg_4_0

		var_0.emit(var_5_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0._homeBtn, function()
		local var_6_0 = arg_4_0

		var_0.emit(var_6_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0._helpBtn, function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		pg = var_2_10003
		var_7_2.helps = var_2_10003.gametip.help_newyear_feast.tip

		var_7_1(var_7_0, var_7_2)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0.yinhuace, function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.UIMgr.GetInstance()

		var_0.OverlayPanel(var_8_0, arg_4_0.shouce)

		setActive = var_0

		var_0(arg_4_0.shouce, true)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0.shouce_bg, function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_9_0, arg_4_0.shouce, arg_4_0._tf)

		setActive = var_0

		var_0(arg_4_0.shouce, false)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0.btn_shouce_help, function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_10_2.type = var_2_10003
		pg = var_2_10003
		var_10_2.helps = var_2_10003.gametip.help_newyear_stamp.tip

		var_10_1(var_10_0, var_10_2)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_4_0, arg_4_0.btn_receive, function()
		local var_11_0 = var_4_0

		if var_0.GetHubByHubId(var_11_0, arg_4_0.HUB_ID).ultimate == 0 then
			local var_11_1 = var_0.usedtime

			var_2_10003 = var_0

			if var_11_1 < var_0.getConfig(var_2_10003, "reward_need") then
				return
			end

			local var_11_2 = arg_4_0
			local var_11_3 = var_1.emit

			NewYearFestivalMediator = var_2_10003

			local var_11_4 = var_2_10003.MINI_GAME_OPERATOR
			local var_11_5 = {
				hubid = var_0.id
			}

			MiniGameOPCommand = var_5
			var_11_5.cmd = var_5.CMD_ULTIMATE
			var_11_5.args1 = {}

			var_11_3(var_11_2, var_11_4, var_11_5)

			return
		end
	end)
	arg_4_0:InitFacility(arg_4_0.shrine, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.m02
		local var_12_1 = var_0.sendNotification

		GAME = var_2_10002

		var_12_1(var_12_0, var_2_10002.GO_MINI_GAME, 3)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.snack_street, function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.m02
		local var_13_1 = var_0.sendNotification

		GAME = var_2_10002

		var_13_1(var_13_0, var_2_10002.GO_MINI_GAME, 8)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.divination, function()
		local var_14_0 = arg_4_0
		local var_14_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_14_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		local var_14_3 = var_2_10003.ACTIVITY
		local var_14_4 = {}

		ActivityConst = var_2_10005
		var_14_4.id = var_2_10005.CYGNET_BATHROBE_PAGE_ID

		var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.shop, function()
		local var_15_0 = arg_4_0
		local var_15_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_15_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_15_1(var_15_0, var_15_2, var_2_10003.SKINSHOP)

		return
	end)
	arg_4_0:InitFacility(arg_4_0.cube, function()
		local var_16_0 = arg_4_0
		local var_16_1 = var_0.emit

		NewYearFestivalMediator = var_2_10002

		local var_16_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_16_1(var_16_0, var_16_2, var_2_10003.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)

	pg = var_2

	local var_4_1 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_4_1, arg_4_0.top)

	arg_4_0.academyStudents = {}

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.InitStudents

	ActivityConst = var_4

	var_4_3(var_4_2, var_4.NEWYEAR_ACTIVITY, 3, 5)
	arg_4_0:UpdateView()

	if arg_4_0.contextData.isOpenShrine then
		local var_4_4 = arg_4_0.contextData

		var_4_4.isOpenShrine = nil
		pg = var_4_4

		local var_4_5 = var_4_4.m02
		local var_4_6 = var_2.sendNotification

		GAME = var_4

		var_4_6(var_4_5, var_4.GO_MINI_GAME, 3)
	end

	if var_4_0:GetMiniGameData(3) and not var_2:GetRuntimeData("isInited") then
		local var_4_7 = arg_4_0
		local var_4_8 = arg_4_0.emit

		NewYearFestivalMediator = var_5

		local var_4_9 = var_5.MINIGAME_OPERATION
		local var_4_10 = arg_4_0.HUB_ID

		MiniGameOPCommand = var_1_10007

		var_4_8(var_4_7, var_4_9, var_4_10, var_1_10007.CMD_SPECIAL_GAME, {
			3,
			1
		})
	end

	return
end

function var_0_1.UpdateView(arg_17_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10002

	local var_17_0 = var_1_10001(var_1_10002)
	local var_17_1 = var_1.GetHubByHubId(var_17_0, arg_17_0.HUB_ID).usedtime

	setText = var_4

	var_4(arg_17_0.ticketTimes, "X " .. var_2.count)

	setText = var_4

	local var_17_2 = arg_17_0.yinhuaceTimes

	string = var_6

	var_4(var_17_2, var_6.format("%02d", var_17_1))

	ipairs = var_4

	for iter_17_0, iter_17_1 in var_4(arg_17_0.group_get) do
		setActive = var_1_10009

		var_1_10009(iter_17_1, iter_17_0 <= var_17_1)
	end

	local var_17_3 = var_17_1 >= #arg_17_0.group_get and var_2.ultimate == 0

	setActive = var_5

	var_5(arg_17_0.btn_receive, var_17_3)

	setActive = var_5

	var_5(arg_17_0.yinhuaceTips, var_17_3)

	setActive = var_5

	var_5(arg_17_0.img_get, var_2.ultimate ~= 0)

	if var_2.ultimate == 1 then
		arg_17_0:TryPlayStory()
	end

	local var_17_4 = arg_17_0.snack_street
	local var_17_5 = var_5.Find(var_17_4, "tip")

	setActive = var_17_4

	var_17_4(var_17_5, var_2.count > 0)

	local var_17_6 = arg_17_0.shrine
	local var_17_7 = var_6.Find(var_17_6, "tip")
	local var_17_8 = var_1:GetMiniGameData(3)
	local var_17_9 = false

	if var_17_8 then
		local var_17_10

		if not var_17_8:GetRuntimeData("count") then
			var_17_10 = 0
		end

		if 0 < var_17_10 then
			NewYearShrinePage = var_10
			var_17_9 = var_10.IsTip()
		else
			var_17_9 = false
		end
	end

	if false then
		var_17_9 = true
	end

	setActive = var_17_10

	var_17_10(var_17_7, var_17_9)

	local var_17_11 = arg_17_0.divination
	local var_17_12

	var_17_12, setActive = var_9.Find(var_17_11, "tip"), var_17_11
	CygnetBathrobePage = var_1_10012

	var_17_11(var_17_12, var_1_10012.IsTip())

	return
end

var_0_1.edge2area = {
	["3_8"] = "bottom",
	["7_8"] = "bottom2",
	["5_6"] = "front"
}

function var_0_1.TryPlayStory(arg_18_0)
	return
end

function var_0_1.willExit(arg_19_0)
	local var_19_0 = arg_19_0.effectReq

	var_1.Stop(var_19_0)

	pg = var_1

	local var_19_1 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_1, arg_19_0.top, arg_19_0._tf)

	isActive = var_1

	if var_1(arg_19_0.shouce) then
		pg = var_1

		local var_19_2 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_19_2, arg_19_0.shouce, arg_19_0._tf)

		setActive = var_1

		var_1(arg_19_0.shouce, false)
	end

	arg_19_0:clearStudents()

	return
end

return var_0_1
