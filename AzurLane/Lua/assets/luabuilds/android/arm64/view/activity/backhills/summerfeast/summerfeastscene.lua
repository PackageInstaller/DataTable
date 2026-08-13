class = var_0_10000

local var_0_0 = "SummerFeastScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "SummerFeastUI"
end

var_0_1.HUB_ID = 1
var_0_1.Elements = {
	[0] = {
		color = "ffffff",
		name = "none"
	},
	{
		color = "ffed95",
		name = "na"
	},
	{
		color = "feb8ff",
		name = "k"
	},
	{
		color = "ad92ff",
		name = "rb"
	},
	{
		color = "affff4",
		name = "zn"
	},
	{
		color = "ffa685",
		name = "ca"
	},
	{
		color = "c1ffa7",
		name = "cu"
	}
}

function var_0_1.GetCurrentDay()
	pg = var_1_10000

	local var_2_0 = var_1_10000.TimeMgr.GetInstance()
	local var_2_1 = var_0.GetServerTime(var_2_0)

	pg = var_1_10001

	local var_2_2 = var_1_10001.TimeMgr.GetInstance()

	return var_1.STimeDescS(var_2_2, var_2_1, "*t").yday
end

function var_0_1.GetTheDay()
	os = var_1_10000

	local var_3_0 = var_1_10000.time({
		hour = 0,
		month = 8,
		year = 2019,
		min = 0,
		sec = 0,
		isdst = false,
		day = 29
	})

	os = var_1_10001

	return var_1_10001.date("*t", var_3_0).yday
end

function var_0_1.TransformColor(arg_4_0)
	tonumber = var_1_10001
	string = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003.sub(arg_4_0, 1, 2), 16)

	tonumber = var_1_10002
	string = var_4

	local var_4_1 = var_1_10002(var_4.sub(arg_4_0, 3, 4), 16)

	tonumber = var_3
	string = var_5

	local var_4_2 = var_3(var_5.sub(arg_4_0, 5, 6), 16)
	local var_4_3 = 255

	string = var_5

	if var_5.len(arg_4_0) > 6 then
		string = var_5

		if var_5.len(arg_4_0) <= 8 then
			tonumber = var_5
			string = var_7
			var_4_3 = var_5(var_7.sub(arg_4_0, 7, 8), 16)
		end
	end

	Color = var_5

	return var_5.New(var_4_0 / 255, var_4_1 / 255, var_4_2 / 255, var_4_3 / 255)
end

function var_0_1.GenerateRandomFanPosition(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	local var_5_0 = {}

	for iter_5_0 = 1, arg_5_6 do
		table = var_1_10012
		var_1_10012 = var_1_10012.insert

		local var_5_1 = var_5_0

		math = var_1_10015
		var_1_10015 = var_1_10015.lerp

		local var_5_2 = arg_5_4

		var_1_10018 = arg_5_5
		math = var_1_10019

		var_1_10012(var_5_1, var_1_10015(var_5_2, var_1_10018, var_1_10019.random(1, 100) / 100))
	end

	local var_5_3 = arg_5_3 / (arg_5_6 - 1)

	math = var_9

	local var_5_4 = var_9.sin(var_5_3)

	math = var_10

	local var_5_5 = var_10.cos(var_5_3)

	Vector2 = var_11

	local var_5_6 = var_11.Normalize(arg_5_2 - arg_5_1)
	local var_5_7 = {}
	local var_5_8 = var_5_6.x
	local var_5_9 = var_5_6.y

	table = var_1_10015

	local var_5_10 = var_1_10015.insert
	local var_5_11 = var_5_7

	Vector2 = var_1_10018

	var_5_10(var_5_11, var_1_10018.New(arg_5_1.x + var_5_0[1] * var_5_8, arg_5_1.y + var_5_0[1] * var_5_9))

	for iter_5_1 = 2, arg_5_6 do
		local var_5_12 = var_5_8 * var_5_5 + var_5_9 * var_5_4
		local var_5_13

		var_5_9, var_5_13 = var_5_9 * var_5_5 - var_5_8 * var_5_4, var_5_12
		var_5_8 = var_5_13
		table = var_5_13

		local var_5_14 = var_5_13.insert
		local var_5_15 = var_5_7

		Vector2 = var_1_10024

		var_5_14(var_5_15, var_1_10024.New(arg_5_1.x + var_5_0[iter_5_1] * var_5_8, arg_5_1.y + var_5_0[iter_5_1] * var_5_9))
	end

	return var_5_7
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.top = var_1.Find(var_6_0, "top")

	local var_6_1 = arg_6_0._tf

	arg_6_0._closeBtn = var_1.Find(var_6_1, "top/back")

	local var_6_2 = arg_6_0._tf

	arg_6_0._homeBtn = var_1.Find(var_6_2, "top/home")

	local var_6_3 = arg_6_0._tf

	arg_6_0._helpBtn = var_1.Find(var_6_3, "top/help")

	local var_6_4 = arg_6_0.top

	arg_6_0.ticketTimes = var_1.Find(var_6_4, "ticket/text")

	local var_6_5 = arg_6_0.top

	arg_6_0.yinhuace = var_1.Find(var_6_5, "yinhuace")

	local var_6_6 = arg_6_0.yinhuace

	arg_6_0.yinhuaceTimes = var_1.Find(var_6_6, "get")

	local var_6_7 = arg_6_0.yinhuace

	arg_6_0.yinhuaceTips = var_1.Find(var_6_7, "tip")

	local var_6_8 = arg_6_0._tf

	arg_6_0.shouce = var_1.Find(var_6_8, "yinhuashouceye")

	local var_6_9 = arg_6_0.shouce

	arg_6_0.shouce_bg = var_1.Find(var_6_9, "bg")

	local var_6_10 = arg_6_0.shouce

	arg_6_0.layout_shouce = var_1.Find(var_6_10, "yinhuace/go/layout")
	CustomIndexLayer = var_1
	arg_6_0.group_get = var_1.Clone2Full(arg_6_0.layout_shouce, 14)

	local var_6_11 = arg_6_0.shouce

	arg_6_0.btn_receive = var_1.Find(var_6_11, "yinhuace/receive")

	local var_6_12 = arg_6_0.shouce

	arg_6_0.btn_shouce_help = var_1.Find(var_6_12, "yinhuace/help")

	local var_6_13 = arg_6_0.shouce

	arg_6_0.img_get = var_1.Find(var_6_13, "yinhuace/get")
	setActive = var_1

	var_1(arg_6_0.shouce, false)

	local var_6_14 = arg_6_0._tf

	arg_6_0.sakura = var_1.Find(var_6_14, "effect")

	local var_6_15 = arg_6_0._tf

	arg_6_0._map = var_1.Find(var_6_15, "scrollRect/map")

	local var_6_16 = arg_6_0._map

	arg_6_0.wave = var_1.Find(var_6_16, "effect_wave")

	local var_6_17 = arg_6_0._map

	arg_6_0.shrine = var_1.Find(var_6_17, "shrine")

	local var_6_18 = arg_6_0._map

	arg_6_0.snack_street = var_1.Find(var_6_18, "snack_street")

	local var_6_19 = arg_6_0._map

	arg_6_0.entertainment_street = var_1.Find(var_6_19, "entertainment_street")

	local var_6_20 = arg_6_0._map

	arg_6_0.firework_factory = var_1.Find(var_6_20, "firework_factory")

	local var_6_21 = arg_6_0.firework_factory

	arg_6_0.btn_fire = var_1.Find(var_6_21, "fire")

	local var_6_22 = arg_6_0._map

	arg_6_0.bottom = var_1.Find(var_6_22, "bottom")

	local var_6_23 = arg_6_0._map

	arg_6_0.middle = var_1.Find(var_6_23, "middle")

	local var_6_24 = arg_6_0._map

	arg_6_0.front = var_1.Find(var_6_24, "front")

	local var_6_25 = arg_6_0._map

	arg_6_0._shipTpl = var_1.Find(var_6_25, "ship")
	GraphPath = var_1

	local var_6_26 = var_1.New

	import = var_6_25
	arg_6_0.graphPath = var_6_26(var_6_25("GameCfg.BackHillGraphs.SummerFeastGraph"))
	pg = var_1

	local var_6_27 = var_1.PoolMgr.GetInstance()

	var_1.GetPrefab(var_6_27, "ui/firework", "", true, function(arg_7_0)
		pg = var_2_10001

		local var_7_0 = var_2_10001.PoolMgr.GetInstance()

		var_1.ReturnPrefab(var_7_0, "ui/firework", "", arg_7_0)

		return
	end)

	arg_6_0.workingEffect = {}

	return
end

function var_0_1.didEnter(arg_8_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0._closeBtn, function()
		local var_9_0 = arg_8_0

		var_0.emit(var_9_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0._homeBtn, function()
		local var_10_0 = arg_8_0

		var_0.emit(var_10_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0._helpBtn, function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_11_2.type = var_2_10004
		pg = var_2_10004
		var_11_2.helps = var_2_10004.gametip.help_summer_feast.tip

		var_11_1(var_11_0, var_11_2)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0.yinhuace, function()
		pg = var_2_10000

		local var_12_0 = var_2_10000.UIMgr.GetInstance()

		var_0.OverlayPanel(var_12_0, arg_8_0.shouce)

		setActive = var_0

		var_0(arg_8_0.shouce, true)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0.shouce_bg, function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_13_0, arg_8_0.shoucem, arg_8_0._tf)

		setActive = var_0

		var_0(arg_8_0.shouce, false)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0.btn_shouce_help, function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_14_1 = var_0.ShowMsgBox
		local var_14_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_14_2.type = var_2_10004
		pg = var_2_10004
		var_14_2.helps = var_2_10004.gametip.help_summer_stamp.tip

		var_14_1(var_14_0, var_14_2)

		return
	end)

	onButton = var_1_10002

	var_1_10002(arg_8_0, arg_8_0.btn_receive, function()
		local var_15_0 = var_8_0

		if var_0.GetHubByHubId(var_15_0, arg_8_0.HUB_ID).ultimate == 0 then
			local var_15_1 = var_0.usedtime

			var_2_10004 = var_0

			if var_15_1 < var_0.getConfig(var_2_10004, "reward_need") then
				return
			end

			local var_15_2 = arg_8_0
			local var_15_3 = var_1.emit

			SummerFeastMediator = var_2_10004

			local var_15_4 = var_2_10004.MINI_GAME_OPERATOR
			local var_15_5 = {
				hubid = var_0.id
			}

			MiniGameOPCommand = var_6
			var_15_5.cmd = var_6.CMD_ULTIMATE
			var_15_5.args1 = {}

			var_15_3(var_15_2, var_15_4, var_15_5)

			return
		end
	end)
	arg_8_0:InitFacility(arg_8_0.shrine, function()
		pg = var_2_10000

		local var_16_0 = var_2_10000.m02
		local var_16_1 = var_0.sendNotification

		GAME = var_2_10003

		var_16_1(var_16_0, var_2_10003.GO_MINI_GAME, 3)

		return
	end)
	arg_8_0:InitFacility(arg_8_0.snack_street, function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.m02
		local var_17_1 = var_0.sendNotification

		GAME = var_2_10003

		var_17_1(var_17_0, var_2_10003.GO_MINI_GAME, 2)

		return
	end)
	arg_8_0:InitFacility(arg_8_0.entertainment_street, function()
		pg = var_2_10000

		local var_18_0 = var_2_10000.m02
		local var_18_1 = var_0.sendNotification

		GAME = var_2_10003

		var_18_1(var_18_0, var_2_10003.GO_MINI_GAME, 5)

		return
	end)
	arg_8_0:InitFacility(arg_8_0.firework_factory, function()
		pg = var_2_10000

		local var_19_0 = var_2_10000.m02
		local var_19_1 = var_0.sendNotification

		GAME = var_2_10003

		var_19_1(var_19_0, var_2_10003.GO_MINI_GAME, 4)

		return
	end)

	onButton = var_2

	var_2(arg_8_0, arg_8_0.btn_fire, function()
		local var_20_0 = var_8_0
		local var_20_1 = var_0.GetMiniGameData(var_20_0, 4)

		if not var_0.GetRuntimeData(var_20_1, "elements") or not (#var_1 >= 4) or var_1[4] ~= arg_8_0.GetCurrentDay() then
			return
		end

		local var_20_2 = arg_8_0

		var_2.PlayFirework(var_20_2, var_1)

		setActive = var_2

		var_2(arg_8_0.btn_fire, false)

		return
	end)

	pg = var_2

	local var_8_1 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_8_1, arg_8_0.top)

	arg_8_0.academyStudents = {}

	arg_8_0:InitAreaTransFunc()
	arg_8_0:updateStudents()
	arg_8_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_21_0)
	getProxy = var_1_10001
	MiniGameProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)
	local var_21_1 = var_1.GetHubByHubId(var_21_0, arg_21_0.HUB_ID).usedtime

	setText = var_21_0

	var_21_0(arg_21_0.ticketTimes, var_2.count)

	setText = var_21_0

	var_21_0(arg_21_0.yinhuaceTimes, var_21_1)

	ipairs = var_21_0

	for iter_21_0, iter_21_1 in var_21_0(arg_21_0.group_get) do
		setActive = var_1_10009

		var_1_10009(iter_21_1, iter_21_0 <= var_21_1)
	end

	local var_21_2 = var_21_1 >= #arg_21_0.group_get and var_2.ultimate == 0

	setActive = var_5

	var_5(arg_21_0.btn_receive, var_21_2)

	setActive = var_5

	var_5(arg_21_0.yinhuaceTips, var_21_2)

	setActive = var_5

	var_5(arg_21_0.img_get, var_2.ultimate ~= 0)

	if var_2.ultimate == 1 then
		arg_21_0:TryPlayStory()
	end

	local var_21_3 = var_1:GetMiniGameData(4)
	local var_21_5

	if var_5.GetRuntimeData(var_21_3, "elements") then
		::label_21_0::

		local var_21_4 = #var_6

		var_21_5 = 4 <= var_21_4 and var_6[4] == arg_21_0.GetCurrentDay()
	end

	setActive = var_21_3

	var_21_3(arg_21_0.btn_fire, var_21_5)

	return
end

function var_0_1.InitFacility(arg_22_0, arg_22_1, arg_22_2)
	onButton = var_1_10003

	var_1_10003(arg_22_0, arg_22_1, arg_22_2)

	onButton = var_1_10003

	var_1_10003(arg_22_0, arg_22_1:Find("button"), arg_22_2)

	return
end

function var_0_1.PlayFirework(arg_23_0, arg_23_1)
	local var_23_0 = #arg_23_0.workingEffect

	if 0 < var_23_0 then
		return
	end

	arg_23_1 = arg_23_1 or {
		0,
		0,
		0
	}

	local var_23_1 = {}

	Vector2 = var_3
	var_23_1[1] = var_3(215, 150)
	UnityEngine = var_3

	local var_23_2 = var_3.ParticleSystem.MinMaxGradient.New

	pairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(var_23_1) do
		pg = var_1_10009

		local var_23_3 = var_1_10009.PoolMgr.GetInstance()

		var_1_10009.GetPrefab(var_23_3, "ui/firework", "", false, function(arg_24_0)
			local var_24_0 = var_0_1.Elements

			tf = var_2_10002

			local var_24_1 = var_2_10002(arg_24_0)
			local var_24_2 = var_2.Find(var_24_1, "Fire")
			local var_24_3 = var_2.GetComponent(var_24_2, "ParticleSystem").main

			var_24_3.startColor = var_23_2(arg_23_0.TransformColor(var_24_0[arg_23_1[1]].color))
			tf = var_24_3

			local var_24_4 = var_24_3(arg_24_0)
			local var_24_5 = var_2.Find(var_24_4, "Fire/par_small")
			local var_24_6 = var_2.GetComponent(var_24_5, "ParticleSystem").main

			var_24_6.startColor = var_23_2(arg_23_0.TransformColor(var_24_0[arg_23_1[2]].color))
			tf = var_24_6

			local var_24_7 = var_24_6(arg_24_0)
			local var_24_8 = var_2.Find(var_24_7, "Fire/par_small/par_big")
			local var_24_9 = var_2.GetComponent(var_24_8, "ParticleSystem").main

			var_24_9.startColor = var_23_2(arg_23_0.TransformColor(var_24_0[arg_23_1[3]].color))
			table = var_24_9

			var_24_9.insert(arg_23_0.workingEffect, arg_24_0)

			setParent = var_2

			var_2(arg_24_0, arg_23_0._map)

			arg_24_0.transform.localPosition = iter_23_1

			return
		end)
	end

	arg_23_0:PlaySE()

	return
end

function var_0_1.ClearEffectFirework(arg_25_0)
	arg_25_0:StopSE()

	pg = var_1

	local var_25_0 = var_1.PoolMgr.GetInstance()

	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.workingEffect) do
		var_25_0:ReturnPrefab("ui/firework", "", iter_25_1)
	end

	var_25_0:DestroyPrefab("ui/firework", "")

	arg_25_0.workingEffect = {}

	return
end

function var_0_1.PlaySE(arg_26_0)
	if arg_26_0.SETimer then
		return
	end

	arg_26_0.SECount = 10
	Timer = var_1
	arg_26_0.SETimer = var_1.New(function()
		arg_26_0.SECount = arg_26_0.SECount - 1

		if arg_26_0.SECount <= 0 then
			local var_27_0 = arg_26_0

			math = var_1
			var_27_0.SECount = var_1.random(5, 20)
			pg = var_27_0

			local var_27_1 = var_27_0.CriMgr.GetInstance()

			var_0.PlaySE_V3(var_27_1, "battle-firework")
		end

		return
	end, 0.1, -1)

	local var_26_0 = arg_26_0.SETimer

	var_1.Start(var_26_0)

	return
end

function var_0_1.StopSE(arg_28_0)
	if arg_28_0.SETimer then
		pg = var_1

		local var_28_0 = var_1.CriMgr.GetInstance()

		var_1.StopSEBattle_V3(var_28_0)

		local var_28_1 = arg_28_0.SETimer

		var_1.Stop(var_28_1)

		arg_28_0.SETimer = nil
	end

	return
end

function var_0_1.getStudents(arg_29_0)
	local var_29_0 = {}

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_29_1 = var_1_10002(var_1_10004)
	local var_29_2 = var_2.getActivityById

	ActivityConst = var_1_10006

	if not var_29_2(var_29_1, var_1_10006.SUMMER_FEAST_ID) then
		return var_29_0
	end

	local var_29_3

	if var_3:getConfig("config_client") then
		var_29_3 = var_29_3.ships
	end

	if var_29_3 then
		Clone = var_29_1

		local var_29_4 = var_29_1(var_29_3)
		local var_29_5 = 0
		local var_29_6 = #var_29_4

		while var_29_5 < 15 and 0 < var_29_6 do
			math = var_29_7

			local var_29_7 = var_29_7.random(1, var_29_6)

			table = var_1_10008

			var_1_10008.insert(var_29_0, var_29_4[var_29_7])

			var_29_4[var_29_7] = var_29_4[var_29_6]
			var_29_6 = var_29_6 - 1
			math = var_1_10008
			var_29_5 = var_29_5 + var_1_10008.random(3, 5)
		end
	end

	return var_29_0
end

function var_0_1.InitAreaTransFunc(arg_30_0)
	arg_30_0.edge2area = {
		["1_4"] = arg_30_0.bottom,
		["1_5"] = arg_30_0.bottom,
		["4_5"] = arg_30_0.bottom,
		["3_5"] = arg_30_0.middle
	}
	arg_30_0.graphPath.points[5].isBan = true

	return
end

function var_0_1.updateStudents(arg_31_0)
	local var_31_0 = arg_31_0:getStudents()

	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(var_31_0) do
		if not arg_31_0.academyStudents[iter_31_0] then
			cloneTplTo = var_7

			local var_31_1 = var_7(arg_31_0._shipTpl, arg_31_0._map).gameObject

			var_31_1.name = iter_31_0
			SummerFeastNavigationAgent = var_31_1

			local var_31_2 = var_31_1.New(var_7.gameObject)

			var_8.attach(var_31_2)
			var_8:setPathFinder(arg_31_0.graphPath)
			var_8:SetOnTransEdge(function(arg_32_0, arg_32_1, arg_32_2)
				math = var_2_10003

				local var_32_0 = var_2_10003.min(arg_32_1, arg_32_2)

				math = var_2_10004
				arg_32_2 = var_2_10004.max(arg_32_1, arg_32_2)
				arg_32_1 = var_32_0

				local var_32_1

				if not arg_31_0.edge2area[arg_32_1 .. "_" .. arg_32_2] then
					var_32_1 = arg_31_0.front
				end

				local var_32_2 = arg_32_0._tf

				var_4.SetParent(var_32_2, var_32_1)

				return
			end)
			var_8:updateStudent(iter_31_1)

			arg_31_0.academyStudents[iter_31_0] = var_8
		end
	end

	if #var_31_0 > 0 then
		Timer = var_2
		arg_31_0.sortTimer = var_2.New(function()
			local var_33_0 = arg_31_0

			var_0.sortStudents(var_33_0)

			return
		end, 0.2, -1)

		local var_31_3 = arg_31_0.sortTimer

		var_2.Start(var_31_3)
		arg_31_0.sortTimer.func()
	end

	return
end

function var_0_1.sortStudents(arg_34_0)
	local var_34_0 = {
		arg_34_0.front,
		arg_34_0.middle,
		arg_34_0.bottom
	}

	pairs = var_2

	for iter_34_0, iter_34_1 in var_2(var_34_0) do
		if iter_34_1.childCount > 1 then
			local var_34_1 = {}

			for iter_34_2 = 1, iter_34_1.childCount do
				local var_34_2 = iter_34_1:GetChild(iter_34_2 - 1)

				table = var_1_10013

				var_1_10013.insert(var_34_1, {
					tf = var_34_2,
					index = iter_34_2
				})
			end

			table = var_8

			var_8.sort(var_34_1, function(arg_35_0, arg_35_1)
				local var_35_0 = arg_35_0.tf.anchoredPosition.y - arg_35_1.tf.anchoredPosition.y

				math = var_3

				if var_3.abs(var_35_0) < 1 then
					return arg_35_0.index < arg_35_1.index
				else
					return var_35_0 > 0
				end

				return
			end)

			ipairs = var_8

			for iter_34_3, iter_34_4 in var_8(var_34_1) do
				local var_34_3 = iter_34_4.tf

				var_1_10013.SetSiblingIndex(var_34_3, iter_34_3 - 1)
			end
		end
	end

	return
end

function var_0_1.clearStudents(arg_36_0)
	if arg_36_0.sortTimer then
		local var_36_0 = arg_36_0.sortTimer

		var_1.Stop(var_36_0)

		arg_36_0.sortTimer = nil
	end

	pairs = var_1

	for iter_36_0, iter_36_1 in var_1(arg_36_0.academyStudents) do
		iter_36_1:detach()

		Destroy = var_6

		var_6(iter_36_1._go)
	end

	arg_36_0.academyStudents = {}

	return
end

function var_0_1.TryPlayStory(arg_37_0)
	local var_37_0 = "TIANHOUYUYI2"

	if var_37_0 then
		pg = var_1_10002

		local var_37_1 = var_1_10002.NewStoryMgr.GetInstance()

		var_2.Play(var_37_1, var_37_0)
	end

	return
end

function var_0_1.willExit(arg_38_0)
	pg = var_1_10001

	local var_38_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_38_0, arg_38_0.top, arg_38_0._tf)

	isActive = var_1

	if var_1(arg_38_0.shouce) then
		pg = var_1

		local var_38_1 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_38_1, arg_38_0.shoucem, arg_38_0._tf)

		setActive = var_1

		var_1(arg_38_0.shouce, false)
	end

	arg_38_0:clearStudents()
	arg_38_0:ClearEffectFirework()

	return
end

return var_0_1
