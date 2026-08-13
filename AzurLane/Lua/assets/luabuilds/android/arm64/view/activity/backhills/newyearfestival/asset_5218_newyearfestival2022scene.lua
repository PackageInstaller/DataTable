class = var_0_10000

local var_0_0 = "NewYearFestival2022Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "NewyearFestival2022UI"
end

var_0_1.edge2area = {
	default = "_middle"
}
var_0_1.Buildings = {
	[18] = "ironbloodmaid",
	[17] = "royalmaid"
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

	arg_2_0._middle = var_1.Find(var_2_4, "middle")

	local var_2_5 = arg_2_0._map

	arg_2_0._shipTpl = var_1.Find(var_2_5, "ship")

	local var_2_6 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_6, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_7 = arg_2_0._upper
		local var_2_8 = var_5.GetChild(var_2_7, iter_2_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_2_8).name
		arg_2_0["upper_" .. var_1_10006] = var_2_8
	end

	arg_2_0.containers = {
		arg_2_0.map_middle
	}

	local var_2_9 = arg_2_0.top
	local var_2_10 = var_1.Find(var_2_9, "usable_count/text")
	local var_2_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.usableTxt = var_2_11(var_2_10, var_4(var_1_10006))

	local var_2_12 = arg_2_0.top
	local var_2_13 = var_1.Find(var_2_12, "material/text")
	local var_2_14 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.materialTxt = var_2_14(var_2_13, var_4(var_1_10006))

	local var_2_15 = arg_2_0.top

	arg_2_0.btnPlayFirework = var_1.Find(var_2_15, "playFirework")
	GraphPath = var_1

	local var_2_16 = var_1.New

	import = var_2_15
	arg_2_0.graphPath = var_2_16(var_2_15("GameCfg.BackHillGraphs.NewyearFestival2022Graph"))

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/back")

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
	local var_3_6 = var_4.Find(var_3_5, "top/home")

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
	local var_3_10 = var_4.Find(var_3_9, "top/help")

	local function var_3_11()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_6_2.type = var_2_10004
		pg = var_2_10004
		var_6_2.helps = var_2_10004.gametip.help_xinnian2022_feast.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_3_9

	var_1_10001(var_3_8, var_3_10, var_3_11, var_3_9)

	onButton = var_1_10001

	var_1_10001(arg_3_0, arg_3_0.btnPlayFirework, function()
		getProxy = var_2_10000
		MiniGameProxy = var_2_10002

		local var_7_0 = var_2_10000(var_2_10002)
		local var_7_1 = var_0.GetMiniGameData(var_7_0, 36)

		if var_0.GetRuntimeData(var_7_1, "elements") then
			local var_7_2 = #var_1

			if 4 <= var_7_2 then
				local var_7_3 = var_1[4]

				SummerFeastScene = var_3

				if var_7_3 ~= var_3.GetCurrentDay() then
					return
				end

				local var_7_4 = arg_3_0

				var_2.PlayFirework(var_7_4, var_1)

				setActive = var_2

				var_2(arg_3_0.btnPlayFirework, false)

				return
			end
		end
	end)

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0.InitStudents

	ActivityConst = var_4

	var_3_13(var_3_12, var_4.MINIGAME_CURLING, 3, 3)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "qiyuanwu", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10003

		var_8_1(var_8_0, var_2_10003.GO_MINI_GAME, 34)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "bingqiu", function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.m02
		local var_9_1 = var_0.sendNotification

		GAME = var_2_10003

		var_9_1(var_9_0, var_2_10003.GO_MINI_GAME, 33)

		return
	end)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "yanhua", function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.m02
		local var_10_1 = var_0.sendNotification

		GAME = var_2_10003

		var_10_1(var_10_0, var_2_10003.GO_MINI_GAME, 36)

		return
	end)

	pairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.Buildings) do
		arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, iter_3_1, function()
			local var_11_0 = arg_3_0
			local var_11_1 = var_0.emit

			BackHillMediatorTemplate = var_2_10003

			local var_11_2 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_11_3 = var_2_10004.New
			local var_11_4 = {}

			BuildingUpgradeMediator = var_2_10007
			var_11_4.mediator = var_2_10007
			BuildingCafeUpgradeLayer = var_2_10007
			var_11_4.viewComponent = var_2_10007
			var_11_4.data = {
				buildingID = iter_3_0
			}

			var_11_1(var_11_0, var_11_2, var_11_3(var_11_4))

			return
		end)
	end

	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:RegisterDataResponse()
	arg_3_0:UpdateView()

	return
end

function var_0_1.RegisterDataResponse(arg_12_0)
	ResponsableTree = var_1_10001
	arg_12_0.Respones = var_1_10001.CreateShell({})

	local var_12_0 = arg_12_0.Respones

	var_1.SetRawData(var_12_0, "view", arg_12_0)

	_ = var_1

	local var_12_1 = var_1.values(arg_12_0.Buildings)

	ipairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(var_12_1) do
		local var_12_2 = arg_12_0.Respones

		var_7.AddRawListener(var_12_2, {
			"view",
			iter_12_1
		}, function(arg_13_0, arg_13_1)
			if not arg_13_1 then
				return
			end

			local var_13_0 = arg_13_0.loader

			var_2.GetSpriteQuiet(var_13_0, "ui/NewyearFestival2022UI_atlas", iter_12_1 .. arg_13_1, arg_13_0["map_" .. iter_12_1], true)

			if arg_13_0["upper_" .. iter_12_1] then
				IsNil = var_3

				if var_3(var_2:Find("level")) then
					return
				end

				setText = var_3

				var_3(var_2:Find("level"), arg_13_1)

				return
			end
		end)
	end

	local var_12_3 = {
		"bingqiu",
		"qiyuanwu",
		"yanhua"
	}

	table = var_3

	var_3.insertto(var_12_3, var_12_1)

	ipairs = var_3

	for iter_12_2, iter_12_3 in var_3(var_12_3) do
		local var_12_4 = arg_12_0.Respones

		var_8.AddRawListener(var_12_4, {
			"view",
			iter_12_3 .. "Tip"
		}, function(arg_14_0, arg_14_1)
			if arg_14_0["upper_" .. iter_12_3] then
				IsNil = var_3

				if var_3(var_2:Find("tip")) then
					return
				end

				setActive = var_3

				var_3(var_2:Find("tip"), arg_14_1)

				return
			end
		end)
	end

	local var_12_5 = arg_12_0.Respones

	var_3.AddRawListener(var_12_5, {
		"view",
		"shrineCount"
	}, function(arg_15_0, arg_15_1)
		arg_15_0.usableTxt.text = arg_15_1

		return
	end)

	local var_12_6 = arg_12_0.Respones

	var_3.AddRawListener(var_12_6, {
		"view",
		"materialCount"
	}, function(arg_16_0, arg_16_1)
		arg_16_0.materialTxt.text = arg_16_1

		return
	end)

	return
end

function var_0_1.UpdateView(arg_17_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_17_0 = var_1_10001(var_1_10003)
	local var_17_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_17_2 = var_17_1(var_17_0, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF)

	pairs = var_1_10002

	for iter_17_0, iter_17_1 in var_1_10002(arg_17_0.Buildings) do
		var_1_10007 = arg_17_0.Respones

		if not var_17_2.data1KeyValueList[2][iter_17_0] then
			var_1_10008 = 1
		end

		var_1_10007[iter_17_1] = var_1_10008
		var_1_10007 = arg_17_0.Respones
		var_1_10007[iter_17_1 .. "Tip"] = arg_17_0:UpdateBuildingTip(var_17_2, iter_17_0)
	end

	;(function()
		local var_18_0

		if not var_17_2.data1KeyValueList[2][17] then
			var_18_0 = 1
		end

		local var_18_1

		if not var_17_2.data1KeyValueList[2][18] then
			var_18_1 = 1
		end

		pg = var_2_10002

		local var_18_2 = var_2_10002.activity_event_building[17].material[1][1][2]
		local var_18_3

		if not var_17_2.data1KeyValueList[1][var_18_2] then
			var_18_3 = 0
		end

		local var_18_4 = #var_2.buff

		arg_17_0.Respones.royalmaidTip = var_18_0 < var_18_4 and var_18_3 >= var_2.material[var_18_0][1][3] and var_18_0 <= var_18_1
		arg_17_0.Respones.ironbloodmaidTip = var_18_1 < var_18_4 and var_18_3 >= var_2.material[var_18_1][1][3] and var_18_1 <= var_18_0

		return
	end)()

	next = var_3

	local var_17_3 = var_3(var_17_2.data1KeyValueList[1])
	local var_17_4 = arg_17_0.Respones
	local var_17_5

	if not var_17_2.data1KeyValueList[1][var_17_3] then
		var_17_5 = 0
	end

	var_17_4.materialCount = var_17_5
	getProxy = var_17_4
	MiniGameProxy = iter_17_1

	local var_17_6 = var_17_4(iter_17_1)
	local var_17_7 = var_4.GetMiniGameDataByType

	MiniGameConst = var_1_10007

	local var_17_8

	if not var_17_7(var_17_6, var_1_10007.MG_TYPE_5) or not var_4:GetRuntimeData("count") then
		var_17_8 = 0
	end

	arg_17_0.Respones.shrineCount = var_17_8

	local var_17_9 = arg_17_0.Respones
	local var_17_10 = var_0_1.IsMiniActNeedTip

	ActivityConst = var_1_10009
	var_17_9.bingqiuTip = var_17_10(var_1_10009.MINIGAME_CURLING)

	local var_17_11 = arg_17_0.Respones
	local var_17_12 = var_0_1.IsMiniActNeedTip

	ActivityConst = var_9
	var_17_11.yanhuaTip = var_17_12(var_9.MINIGAME_FIREWORK_2022)

	local var_17_13 = arg_17_0.Respones

	Shrine2022View = var_7
	var_17_13.qiyuanwuTip = var_7.IsNeedShowTipWithoutActivityFinalReward()
	getProxy = var_17_13
	MiniGameProxy = var_1_10008

	local var_17_14 = var_17_13(var_1_10008)
	local var_17_15 = var_6.GetMiniGameData(var_17_14, 36)

	if var_6.GetRuntimeData(var_17_15, "elements") then
		::label_17_0::

		var_17_14 = #var_7

		if 4 <= var_17_14 then
			var_17_14 = var_7[4]
			SummerFeastScene = var_17_15

			if var_17_14 ~= var_17_15.GetCurrentDay() then
				var_17_14 = false
			else
				var_17_14 = true
			end

			setActive = var_17_15

			local var_17_16 = arg_17_0.btnPlayFirework

			if var_17_14 then
				::label_17_1::

				tobool = var_1_10012

				local var_17_17 = arg_17_0.loader

				var_1_10012 = not var_1_10012(var_14.GetRequestPackage(var_17_17, "Firework"))
			end

			var_17_15(var_17_16, var_1_10012)
			arg_17_0:TryPlayStory()

			return
		end
	end
end

function var_0_1.TryPlayStory(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)
	local var_19_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_19_2

	if not var_19_1(var_19_0, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF).data1KeyValueList[2][17] then
		var_19_2 = 1
	end

	local var_19_3

	if not var_1.data1KeyValueList[2][18] then
		var_19_3 = 1
	end

	local var_19_4 = var_1
	local var_19_5 = var_1.getConfig(var_19_4, "config_client").story

	pg = var_1_10005

	local var_19_6 = var_1_10005.NewStoryMgr.GetInstance()

	table = var_19_4

	var_19_4.Foreach(var_19_5, function(arg_20_0, arg_20_1)
		local var_20_0 = false

		math = var_2_10003

		local var_20_1 = var_2_10003.floor((arg_20_0 - 1) / 3) + 2

		if arg_20_0 % 3 == 1 then
			var_20_0 = var_20_1 - 1 <= var_19_2 and var_20_1 <= var_19_3
		elseif arg_20_0 % 3 == 2 then
			var_20_0 = var_20_1 <= var_19_3
		elseif arg_20_0 % 3 == 0 then
			var_20_0 = var_20_1 <= var_19_2
		end

		if var_20_0 then
			local var_20_2 = var_19_6

			var_4.Play(var_20_2, arg_20_1[1])
		end

		return
	end)

	return
end

function var_0_1.willExit(arg_21_0)
	arg_21_0:clearStudents()
	arg_21_0:ClearEffectFirework()
	var_0_1.super.willExit(arg_21_0)

	return
end

function var_0_1.PlayFirework(arg_22_0, arg_22_1)
	arg_22_1 = arg_22_1 or {
		0,
		0,
		0
	}
	UnityEngine = var_1_10002

	local var_22_0 = var_1_10002.ParticleSystem.MinMaxGradient.New
	local var_22_1 = arg_22_0.loader

	var_3.GetPrefab(var_22_1, "ui/firework", "", function(arg_23_0)
		SummerFeastScene = var_2_10001

		local var_23_0 = var_2_10001.Elements

		tf = var_2_10002

		local var_23_1 = var_2_10002(arg_23_0)
		local var_23_2 = var_2.Find(var_23_1, "Fire")
		local var_23_3 = var_2.GetComponent(var_23_2, "ParticleSystem").main
		local var_23_4 = var_22_0

		SummerFeastScene = var_5
		var_23_3.startColor = var_23_4(var_5.TransformColor(var_23_0[arg_22_1[1]].color))
		tf = var_23_3

		local var_23_5 = var_23_3(arg_23_0)
		local var_23_6 = var_2.Find(var_23_5, "Fire/par_small")
		local var_23_7 = var_2.GetComponent(var_23_6, "ParticleSystem").main
		local var_23_8 = var_22_0

		SummerFeastScene = var_5
		var_23_7.startColor = var_23_8(var_5.TransformColor(var_23_0[arg_22_1[2]].color))
		tf = var_23_7

		local var_23_9 = var_23_7(arg_23_0)
		local var_23_10 = var_2.Find(var_23_9, "Fire/par_small/par_big")
		local var_23_11 = var_2.GetComponent(var_23_10, "ParticleSystem").main
		local var_23_12 = var_22_0

		SummerFeastScene = var_5
		var_23_11.startColor = var_23_12(var_5.TransformColor(var_23_0[arg_22_1[3]].color))
		setParent = var_23_11

		var_23_11(arg_23_0, arg_22_0._map)

		local var_23_13 = arg_23_0.transform

		Vector2 = var_3
		var_23_13.localPosition = var_3(663, 50)

		local var_23_14 = arg_23_0.transform

		Vector3 = var_3
		var_23_14.localScale = var_3(0.7, 0.7, 0.7)
		pg = var_23_14

		var_23_14.ViewUtils.SetSortingOrder(arg_23_0, -1)

		local var_23_15 = arg_22_0

		var_2.PlaySE(var_23_15)

		return
	end, "Firework")

	Timer = var_3
	arg_22_0.fireworkTimer = var_3.New(function()
		local var_24_0 = arg_22_0.loader

		var_0.GetPrefab(var_24_0, "ui/firework", "", function(arg_25_0)
			SummerFeastScene = var_3_10001

			local var_25_0 = var_3_10001.Elements

			tf = var_3_10002

			local var_25_1 = var_3_10002(arg_25_0)
			local var_25_2 = var_2.Find(var_25_1, "Fire")
			local var_25_3 = var_2.GetComponent(var_25_2, "ParticleSystem").main
			local var_25_4 = var_22_0

			SummerFeastScene = var_5
			var_25_3.startColor = var_25_4(var_5.TransformColor(var_25_0[arg_22_1[1]].color))
			tf = var_25_3

			local var_25_5 = var_25_3(arg_25_0)
			local var_25_6 = var_2.Find(var_25_5, "Fire/par_small")
			local var_25_7 = var_2.GetComponent(var_25_6, "ParticleSystem").main
			local var_25_8 = var_22_0

			SummerFeastScene = var_5
			var_25_7.startColor = var_25_8(var_5.TransformColor(var_25_0[arg_22_1[2]].color))
			tf = var_25_7

			local var_25_9 = var_25_7(arg_25_0)
			local var_25_10 = var_2.Find(var_25_9, "Fire/par_small/par_big")
			local var_25_11 = var_2.GetComponent(var_25_10, "ParticleSystem").main
			local var_25_12 = var_22_0

			SummerFeastScene = var_5
			var_25_11.startColor = var_25_12(var_5.TransformColor(var_25_0[arg_22_1[3]].color))
			setParent = var_25_11

			var_25_11(arg_25_0, arg_22_0._map)

			local var_25_13 = arg_25_0.transform

			Vector2 = var_3
			var_25_13.localPosition = var_3(123, 110)

			local var_25_14 = arg_25_0.transform

			Vector3 = var_3
			var_25_14.localScale = var_3(1.2, 1.2, 1.2)

			return
		end, "Firework2")

		return
	end, 2)

	local var_22_2 = arg_22_0.fireworkTimer

	var_3.Start(var_22_2)

	Timer = var_3
	arg_22_0.fireworkTimer2 = var_3.New(function()
		local var_26_0 = arg_22_0.loader

		var_0.GetPrefab(var_26_0, "ui/firework", "", function(arg_27_0)
			SummerFeastScene = var_3_10001

			local var_27_0 = var_3_10001.Elements

			tf = var_3_10002

			local var_27_1 = var_3_10002(arg_27_0)
			local var_27_2 = var_2.Find(var_27_1, "Fire")
			local var_27_3 = var_2.GetComponent(var_27_2, "ParticleSystem").main
			local var_27_4 = var_22_0

			SummerFeastScene = var_5
			var_27_3.startColor = var_27_4(var_5.TransformColor(var_27_0[arg_22_1[1]].color))
			tf = var_27_3

			local var_27_5 = var_27_3(arg_27_0)
			local var_27_6 = var_2.Find(var_27_5, "Fire/par_small")
			local var_27_7 = var_2.GetComponent(var_27_6, "ParticleSystem").main
			local var_27_8 = var_22_0

			SummerFeastScene = var_5
			var_27_7.startColor = var_27_8(var_5.TransformColor(var_27_0[arg_22_1[2]].color))
			tf = var_27_7

			local var_27_9 = var_27_7(arg_27_0)
			local var_27_10 = var_2.Find(var_27_9, "Fire/par_small/par_big")
			local var_27_11 = var_2.GetComponent(var_27_10, "ParticleSystem").main
			local var_27_12 = var_22_0

			SummerFeastScene = var_5
			var_27_11.startColor = var_27_12(var_5.TransformColor(var_27_0[arg_22_1[3]].color))
			setParent = var_27_11

			var_27_11(arg_27_0, arg_22_0._map)

			local var_27_13 = arg_27_0.transform

			Vector2 = var_3
			var_27_13.localPosition = var_3(-465, -90)

			return
		end, "Firework3")

		return
	end, 3)

	local var_22_3 = arg_22_0.fireworkTimer2

	var_3.Start(var_22_3)

	return
end

function var_0_1.ClearEffectFirework(arg_28_0)
	arg_28_0:StopSE()

	local var_28_0 = arg_28_0.loader

	var_1.ClearRequest(var_28_0, "Firework")

	local var_28_1 = arg_28_0.loader

	var_1.ClearRequest(var_28_1, "Firework2")

	local var_28_2 = arg_28_0.loader

	var_1.ClearRequest(var_28_2, "Firework3")

	if arg_28_0.fireworkTimer then
		local var_28_3 = arg_28_0.fireworkTimer

		var_1.Stop(var_28_3)

		arg_28_0.fireworkTimer = nil
	end

	if arg_28_0.fireworkTimer2 then
		local var_28_4 = arg_28_0.fireworkTimer2

		var_1.Stop(var_28_4)

		arg_28_0.fireworkTimer2 = nil
	end

	return
end

function var_0_1.PlaySE(arg_29_0)
	if arg_29_0.SETimer then
		return
	end

	arg_29_0.SECount = 10
	Timer = var_1
	arg_29_0.SETimer = var_1.New(function()
		arg_29_0.SECount = arg_29_0.SECount - 1

		if arg_29_0.SECount <= 0 then
			local var_30_0 = arg_29_0

			math = var_1
			var_30_0.SECount = var_1.random(5, 20)
			pg = var_30_0

			local var_30_1 = var_30_0.CriMgr.GetInstance()

			var_0.PlaySE_V3(var_30_1, "battle-firework")
		end

		return
	end, 0.1, -1)

	local var_29_0 = arg_29_0.SETimer

	var_1.Start(var_29_0)

	return
end

function var_0_1.StopSE(arg_31_0)
	if arg_31_0.SETimer then
		pg = var_1

		local var_31_0 = var_1.CriMgr.GetInstance()

		var_1.StopSEBattle_V3(var_31_0)

		local var_31_1 = arg_31_0.SETimer

		var_1.Stop(var_31_1)

		arg_31_0.SETimer = nil
	end

	return
end

return var_0_1
