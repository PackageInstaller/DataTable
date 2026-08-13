class = var_0_10000

local var_0_0 = "AnniversaryIsland2023Scene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.BackHills.TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "AnniversaryIsland2023UI"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}
var_0_1.Buildings = {
	[24] = "craft",
	[25] = "adventure",
	[26] = "dining",
	[23] = "living"
}

function var_0_1.Ctor(arg_2_0)
	var_0_1.super.Ctor(arg_2_0)

	AutoLoader = var_1
	arg_2_0.loader = var_1.New()

	return
end

function var_0_1.preload(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:CalculateSceneLevel()
	local var_3_1 = arg_3_0.loader

	var_3.LoadBundle(var_3_1, "ui/" .. arg_3_0:getUIName() .. "_level" .. var_3_0, arg_3_1)

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.top = var_1.Find(var_4_0, "top")

	local var_4_1 = arg_4_0._tf

	arg_4_0._bg = var_1.Find(var_4_1, "BG")

	local var_4_2 = arg_4_0._tf

	arg_4_0._map = var_1.Find(var_4_2, "map")

	for iter_4_0 = 0, arg_4_0._map.childCount - 1 do
		local var_4_3 = arg_4_0._map
		local var_4_4 = var_5.GetChild(var_4_3, iter_4_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_4_4).name
		arg_4_0["map_" .. var_1_10006] = var_4_4
	end

	local var_4_5 = arg_4_0._tf

	arg_4_0._upper = var_1.Find(var_4_5, "upper")

	for iter_4_1 = 0, arg_4_0._upper.childCount - 1 do
		local var_4_6 = arg_4_0._upper
		local var_4_7 = var_5.GetChild(var_4_6, iter_4_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_4_7).name
		arg_4_0["upper_" .. var_1_10006] = var_4_7
	end

	local var_4_8 = arg_4_0._tf

	arg_4_0._SDPlace = var_1.Find(var_4_8, "SDPlace")
	arg_4_0.containers = {
		arg_4_0._SDPlace
	}

	local var_4_9 = arg_4_0._map

	arg_4_0._shipTpl = var_1.Find(var_4_9, "ship")
	GraphPath = var_1

	local var_4_10 = var_1.New

	import = var_4_9
	arg_4_0.graphPath = var_4_10(var_4_9("GameCfg.BackHillGraphs.AnniversaryIsland2023Graph"))

	return
end

function var_0_1.didEnter(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_4.Find(var_5_1, "top/Back")

	local function var_5_3()
		local var_6_0 = arg_5_0

		var_0.onBackPressed(var_6_0)

		return
	end

	SFX_CANCEL = var_5_1

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5_1)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_4.Find(var_5_5, "top/Home")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.emit(var_7_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_5_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_4.Find(var_5_9, "top/Help")

	local function var_5_11()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_8_2.type = var_2_10004
		pg = var_2_10004
		var_8_2.helps = var_2_10004.gametip.haidaojudian_help.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_5_9

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5_9)

	getProxy = var_1_10001
	ActivityProxy = var_5_8

	local var_5_12 = var_1_10001(var_5_8)
	local var_5_13 = var_1.getActivityByType

	ActivityConst = var_5_10

	local var_5_14 = var_5_13(var_5_12, var_5_10.ACTIVITY_TYPE_BUILDING_BUFF_2)

	arg_5_0:InitStudents(var_5_14 and var_5_14.id, 3, 4)

	pairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0.Buildings) do
		arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, iter_5_1, function()
			local var_9_0 = arg_5_0
			local var_9_1 = var_0.emit

			BackHillMediatorTemplate = var_2_10003

			local var_9_2 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_9_3 = var_2_10004.New
			local var_9_4 = {}

			AnniversaryIslandBuildingUpgrade2023WindowMediator = var_2_10007
			var_9_4.mediator = var_2_10007
			AnniversaryIslandBuildingUpgrade2023Window = var_2_10007
			var_9_4.viewComponent = var_2_10007
			var_9_4.data = {
				buildingID = iter_5_0
			}

			var_9_1(var_9_0, var_9_2, var_9_3(var_9_4))

			return
		end)

		eachChild = var_7

		local var_5_15 = arg_5_0._map

		var_7(var_9.Find(var_5_15, iter_5_1), function(arg_10_0)
			GetComponent = var_2_10001

			local var_10_0 = arg_10_0

			typeof = var_2_10004
			Image = var_2_10006

			local var_10_1 = var_2_10001(var_10_0, var_2_10004(var_2_10006))

			var_10_1.alphaHitTestMinimumThreshold = 0.5
			setActive = var_10_1

			var_10_1(arg_10_0, false)

			return
		end)
	end

	eachChild = var_2

	local var_5_16 = arg_5_0._map

	var_2(var_4.Find(var_5_16, "xianshijianzao"), function(arg_11_0)
		GetComponent = var_2_10001

		local var_11_0 = arg_11_0

		typeof = var_2_10004
		Image = var_2_10006
		var_2_10001(var_11_0, var_2_10004(var_2_10006)).alphaHitTestMinimumThreshold = 0.5

		return
	end)

	eachChild = var_2

	local var_5_17 = arg_5_0._map

	var_2(var_4.Find(var_5_17, "huanzhuangshangdian"), function(arg_12_0)
		GetComponent = var_2_10001

		local var_12_0 = arg_12_0

		typeof = var_2_10004
		Image = var_2_10006
		var_2_10001(var_12_0, var_2_10004(var_2_10006)).alphaHitTestMinimumThreshold = 0.5

		return
	end)

	eachChild = var_2

	local var_5_18 = arg_5_0._map

	var_2(var_4.Find(var_5_18, "taskboard"), function(arg_13_0)
		GetComponent = var_2_10001

		local var_13_0 = arg_13_0

		typeof = var_2_10004
		Image = var_2_10006
		var_2_10001(var_13_0, var_2_10004(var_2_10006)).alphaHitTestMinimumThreshold = 0.5

		return
	end)

	GetComponent = var_2

	local var_5_19 = arg_5_0._map
	local var_5_20 = var_4.Find(var_5_19, "bigmap")

	typeof = var_5
	Image = var_7
	var_2(var_5_20, var_5(var_7)).alphaHitTestMinimumThreshold = 0.5

	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "craft", function()
		local var_14_0 = arg_5_0
		local var_14_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_14_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_14_1(var_14_0, var_14_2, var_2_10004.ANNIVERSARY_ISLAND_WORKBENCH)

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "taskboard", function()
		Context = var_2_10000

		local var_15_0 = var_2_10000.New()

		SCENE = var_2_10001

		local var_15_1 = var_2_10001.SetSceneInfo
		local var_15_2 = var_15_0

		SCENE = var_2_10004

		var_15_1(var_15_2, var_2_10004.ISLAND_TASK)

		local var_15_3 = arg_5_0
		local var_15_4 = var_1.emit

		BackHillMediatorTemplate = var_4

		var_15_4(var_15_3, var_4.GO_SUBLAYER, var_15_0)

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "bigmap", function()
		local var_16_0 = arg_5_0
		local var_16_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_16_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_16_1(var_16_0, var_16_2, var_2_10004.ANNIVERSARY_ISLAND_SEA, {
			checkMain = true
		})

		return
	end)
	arg_5_0:InitFacilityCross(arg_5_0._map, arg_5_0._upper, "giftmake", function()
		local var_17_0 = arg_5_0
		local var_17_1 = var_0.emit

		BackHillMediatorTemplate = var_2_10003

		local var_17_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_17_1(var_17_0, var_17_2, var_2_10004.SCULPTURE)

		return
	end)
	arg_5_0:BindItemSkinShop()
	arg_5_0:BindItemBuildShip()
	arg_5_0:RegisterDataResponse()
	arg_5_0:UpdateView()

	return
end

function var_0_1.UpdateActivity(arg_18_0, arg_18_1)
	arg_18_0:UpdateView()

	return
end

function var_0_1.RegisterDataResponse(arg_19_0)
	ResponsableTree = var_1_10001
	arg_19_0.Respones = var_1_10001.CreateShell({})

	local var_19_0 = arg_19_0.Respones

	var_1.SetRawData(var_19_0, "view", arg_19_0)

	_ = var_1

	local var_19_1 = var_1.values(arg_19_0.Buildings)

	ipairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(var_19_1) do
		local var_19_2 = arg_19_0.Respones

		var_7.AddRawListener(var_19_2, {
			"view",
			iter_19_1
		}, function(arg_20_0, arg_20_1)
			if not arg_20_1 then
				return
			end

			setActive = var_2_10002

			local var_20_0 = arg_20_0["map_" .. iter_19_1]
			local var_20_1 = var_4.Find

			tostring = var_2_10007

			var_2_10002(var_20_1(var_20_0, var_2_10007(arg_20_1)), true)

			if arg_20_1 - 1 > 0 then
				setActive = var_2

				local var_20_2 = arg_20_0["map_" .. iter_19_1]
				local var_20_3 = var_4.Find

				tostring = var_7

				var_2(var_20_3(var_20_2, var_7(arg_20_1 - 1)), false)
			end

			local var_20_4 = arg_20_0["map_" .. iter_19_1]
			local var_20_5 = var_2.Find

			tostring = var_5

			local var_20_6 = var_20_5(var_20_4, var_5(arg_20_1))
			local var_20_7 = arg_20_0.loader
			local var_20_8 = var_3.GetSpriteQuiet
			local var_20_9 = "ui/"
			local var_20_10 = arg_19_0

			var_20_8(var_20_7, var_20_9 .. var_7.getUIName(var_20_10) .. "_atlas", iter_19_1 .. "_" .. arg_20_1, var_20_6, true)

			GetComponent = var_20_8

			local var_20_11 = arg_20_0["map_" .. iter_19_1]

			typeof = var_6
			Button = var_8

			local var_20_12 = var_20_8(var_20_11, var_6(var_8))

			GetComponent = var_20_4

			local var_20_13 = var_20_6

			typeof = var_7
			Image = var_9
			var_20_12.targetGraphic = var_20_4(var_20_13, var_7(var_9))

			if arg_20_0["upper_" .. iter_19_1] then
				IsNil = var_4

				if var_4(var_3:Find("Level")) then
					return
				end

				local var_20_14 = arg_20_0.loader
				local var_20_15 = var_4.GetSpriteQuiet
				local var_20_16 = "ui/"
				local var_20_17 = arg_19_0
				local var_20_18 = var_20_16 .. var_8.getUIName(var_20_17) .. "_atlas"

				tostring = var_8

				var_20_15(var_20_14, var_20_18, var_8(arg_20_1), var_3:Find("Level"), true)

				return
			end
		end)
	end

	local var_19_3 = arg_19_0.Respones
	local var_19_4 = var_2.AddRawListener

	_ = iter_19_0

	var_19_4(var_19_3, iter_19_0.values(arg_19_0.Buildings), function(...)
		local var_21_0 = 0
		local var_21_1 = {
			...
		}
		local var_21_2 = 1

		table = var_2_10003

		for iter_21_0 = var_21_2, var_2_10003.getCount(arg_19_0.Buildings) do
			local var_21_3

			if not var_21_1[iter_21_0] then
				var_21_3 = 1
			end

			var_21_0 = var_21_0 + var_21_3
		end

		local var_21_4 = arg_19_0.Respones

		math = var_3
		var_21_4.sceneLevel = var_3.floor(var_21_0 / 4)

		return
	end)

	local var_19_5 = arg_19_0.Respones

	var_2.AddRawListener(var_19_5, {
		"sceneLevel",
		"view"
	}, function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		local var_22_0 = arg_22_1[1]
		local var_22_1 = arg_22_1[2]

		;(function(arg_23_0)
			setActive = var_3_10001

			local var_23_0 = var_22_1["map_" .. arg_23_0]
			local var_23_1 = var_3.Find

			tostring = var_3_10006

			var_3_10001(var_23_1(var_23_0, var_3_10006(var_22_0)), true)

			if arg_22_2[1] then
				setActive = var_1
				var_23_0 = var_22_1["map_" .. arg_23_0]

				local var_23_2 = var_3.Find

				tostring = var_6

				var_1(var_23_2(var_23_0, var_6(arg_22_2[1])), false)
			end

			local var_23_3 = {
				xianshijianzao = "buildship",
				huanzhuangshangdian = "skinshop",
				taskboard = "taskboard"
			}
			local var_23_4 = var_22_1["map_" .. arg_23_0]
			local var_23_5 = var_2.Find

			tostring = var_23_0

			local var_23_6 = var_23_5(var_23_4, var_23_0(var_22_0))
			local var_23_7 = var_22_1.loader
			local var_23_8 = var_3.GetSpriteQuiet
			local var_23_9 = "ui/"
			local var_23_10 = arg_19_0

			var_23_8(var_23_7, var_23_9 .. var_7.getUIName(var_23_10) .. "_level" .. var_22_0, var_23_3[arg_23_0], var_23_6, true)

			GetComponent = var_23_8

			local var_23_11 = var_22_1["map_" .. arg_23_0]

			typeof = var_6
			Button = var_8

			local var_23_12 = var_23_8(var_23_11, var_6(var_8))

			GetComponent = var_23_4

			local var_23_13 = var_23_6

			typeof = var_7
			Image = var_9
			var_23_12.targetGraphic = var_23_4(var_23_13, var_7(var_9))

			return
		end)("xianshijianzao")
		var_6("huanzhuangshangdian")
		var_6("taskboard")

		local var_22_2 = var_22_1.loader
		local var_22_3 = var_7.GetSpriteQuiet
		local var_22_4 = "ui/"
		local var_22_5 = arg_19_0
		local var_22_6 = var_22_4 .. var_11.getUIName(var_22_5) .. "_atlas"
		local var_22_7 = "title_" .. var_22_0
		local var_22_8 = var_22_1._tf

		var_22_3(var_22_2, var_22_6, var_22_7, var_12.Find(var_22_8, "top/Title/Number"), true)

		local var_22_9 = var_22_1.loader
		local var_22_10 = var_7.GetSpriteQuiet
		local var_22_11 = "ui/"
		local var_22_12 = arg_19_0
		local var_22_13 = var_22_11 .. var_11.getUIName(var_22_12) .. "_level" .. var_22_0
		local var_22_14 = "bg"
		local var_22_15 = var_22_1._tf

		var_22_10(var_22_9, var_22_13, var_22_14, var_12.Find(var_22_15, "map"))

		return
	end, {
		useOldRef = true
	})

	local var_19_6 = {
		"taskboard",
		"bigmap",
		"giftmake"
	}

	table = var_3

	var_3.insertto(var_19_6, var_19_1)

	ipairs = var_3

	for iter_19_2, iter_19_3 in var_3(var_19_6) do
		local var_19_7 = arg_19_0.Respones

		var_8.AddRawListener(var_19_7, {
			"view",
			iter_19_3 .. "Tip"
		}, function(arg_24_0, arg_24_1)
			if arg_24_0["upper_" .. iter_19_3] then
				IsNil = var_3

				if var_3(var_2:Find("Tip")) then
					return
				end

				setActive = var_3

				var_3(var_2:Find("Tip"), arg_24_1)

				return
			end
		end)
	end

	arg_19_0.Respones.hubData = {}

	local var_19_8 = arg_19_0.Respones

	var_3.AddRawListener(var_19_8, {
		"view",
		"hubData"
	}, function(arg_25_0, arg_25_1)
		arg_25_0.gameCountTxt.text = "X " .. arg_25_1.count

		return
	end, {
		strict = true
	})

	local var_19_9 = arg_19_0.Respones

	var_3.AddRawListener(var_19_9, {
		"view",
		"materialCount"
	}, function(arg_26_0, arg_26_1)
		arg_26_0.materialTxt.text = arg_26_1

		return
	end)

	return
end

function var_0_1.PlayStory()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_27_0 = var_1_10000(var_1_10002)
	local var_27_1 = var_0.getActivityByType

	ActivityConst = var_1_10003

	local var_27_2 = var_27_1(var_27_0, var_1_10003.ACTIVITY_TYPE_BUILDING_BUFF_2)
	local var_27_3 = var_0.GetTotalBuildingLevel(var_27_2)
	local var_27_4 = {
		false,
		var_0:getConfig("config_client").lv2Story,
		var_0:getConfig("config_client").lv3Story,
		var_0:getConfig("config_client").lv4Story
	}

	table = var_3

	var_3.SerialIpairsAsync(var_27_4, function(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 <= var_27_3 and arg_28_1 then
			pg = var_3

			local var_28_0 = var_3.NewStoryMgr.GetInstance()

			var_3.Play(var_28_0, arg_28_1, arg_28_2)
		else
			arg_28_2()
		end

		return
	end)

	return
end

function var_0_1.UpdateView(arg_29_0)
	AnniversaryIsland2023Scene = var_1_10001

	var_1_10001.PlayStory()

	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_29_0 = var_1(var_1_10003)
	local var_29_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_29_2 = var_29_1(var_29_0, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF_2)

	pairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0.Buildings) do
		local var_29_3 = arg_29_0.Respones
		local var_29_4

		if not var_29_2.data1KeyValueList[2][iter_29_0] then
			var_29_4 = 1
		end

		var_29_3[iter_29_1] = var_29_4
		arg_29_0.Respones[iter_29_1 .. "Tip"] = arg_29_0:UpdateBuildingTip(var_29_2, iter_29_0)
	end

	getProxy = var_2
	ActivityProxy = var_4

	local var_29_5 = var_2(var_4)
	local var_29_6 = var_2.getActivityByType

	ActivityConst = iter_29_0

	local var_29_7 = var_29_6(var_29_5, iter_29_0.ACTIVITY_TYPE_WORKBENCH)
	local var_29_8 = arg_29_0.Respones
	local var_29_9

	if not arg_29_0.Respones.craftTip then
		iter_29_1 = var_29_7

		if var_29_7.HasAvaliableFormula(iter_29_1) then
			getProxy = var_29_9
			SettingsProxy = iter_29_1
			iter_29_1 = var_29_9(iter_29_1)
			var_29_9 = var_29_9.IsTipWorkbenchDaily(iter_29_1)
		end
	end

	var_29_8.craftTip = var_29_9

	local function var_29_10()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_30_0 = var_2_10000(var_2_10002)
		local var_30_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		local var_30_2 = var_30_1(var_30_0, var_2_10003.ACTIVITY_TYPE_ISLAND)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_30_2)
	end

	local var_29_11 = arg_29_0.Respones

	tobool = var_5
	var_29_11.bigmapTip = var_5(var_29_10())

	local function var_29_12()
		getProxy = var_2_10000
		ActivityTaskProxy = var_2_10002

		local var_31_0 = var_2_10000(var_2_10002)
		local var_31_1 = var_0.getActTaskTip

		ActivityConst = var_2_10003

		return var_31_1(var_31_0, var_2_10003.ISLAND_TASK_ID)
	end

	local var_29_13 = arg_29_0.Respones

	tobool = iter_29_1
	var_29_13.taskboardTip = iter_29_1(var_29_12())

	local function var_29_14()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_32_0 = var_2_10000(var_2_10002)
		local var_32_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		local var_32_2 = var_32_1(var_32_0, var_2_10003.ACTIVITY_TYPE_SCULPTURE)

		Activity = var_2_10001

		return var_2_10001.IsActivityReady(var_32_2)
	end

	local var_29_15 = arg_29_0.Respones

	tobool = var_7
	var_29_15.giftmakeTip = var_7(var_29_14())

	return
end

function var_0_1.CalculateSceneLevel(arg_33_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_33_0 = var_1_10001(var_1_10003)
	local var_33_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_33_2 = var_33_1(var_33_0, var_1_10004.ACTIVITY_TYPE_BUILDING_BUFF_2)

	return var_1.GetTotalBuildingLevel(var_33_2)
end

function var_0_1.UpdateBuildingTip(arg_34_0, arg_34_1, arg_34_2)
	local var_34_1

	if var_0_1.super.UpdateBuildingTip(arg_34_0, arg_34_1, arg_34_2) then
		local var_34_0

		if not arg_34_1.data1KeyValueList[2][arg_34_2] then
			var_34_0 = 1
		end

		var_34_1 = var_34_1 and var_34_0 <= arg_34_1:GetTotalBuildingLevel()
	end

	return var_34_1
end

function var_0_1.willExit(arg_35_0)
	arg_35_0:clearStudents()
	var_0_1.super.willExit(arg_35_0)

	return
end

function var_0_1.IsShowMainTip(arg_36_0)
	if arg_36_0 and not arg_36_0:isEnd() then
		local function var_36_0()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_37_0 = var_2_10000(var_2_10002)
			local var_37_1 = var_0.getActivityByType

			ActivityConst = var_2_10003

			local var_37_2 = var_37_1(var_37_0, var_2_10003.ACTIVITY_TYPE_ISLAND)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_37_2)
		end

		local function var_36_1()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_38_0 = var_2_10000(var_2_10002)
			local var_38_1 = var_0.getActivityByType

			ActivityConst = var_2_10003

			local var_38_2 = var_38_1(var_38_0, var_2_10003.ACTIVITY_TYPE_BUILDING_BUFF_2)

			ipairs = var_2_10001

			for iter_38_0, iter_38_1 in var_2_10001(var_38_2:GetBuildingIds()) do
				AnniversaryIsland2023Scene = var_2_10006

				if var_2_10006.UpdateBuildingTip(nil, var_38_2, iter_38_1) then
					return true
				end
			end

			getProxy = var_1
			ActivityProxy = var_3

			local var_38_3 = var_1(var_3)
			local var_38_4 = var_1.getActivityByType

			ActivityConst = iter_38_0

			local var_38_5 = var_38_4(var_38_3, iter_38_0.ACTIVITY_TYPE_WORKBENCH)

			if var_1.HasAvaliableFormula(var_38_5) then
				getProxy = var_2
				SettingsProxy = var_38_5

				local var_38_6 = var_2(var_38_5)

				if var_2.IsTipWorkbenchDaily(var_38_6) then
					return true
				end
			end

			return
		end

		local function var_36_2()
			getProxy = var_2_10000
			ActivityTaskProxy = var_2_10002

			local var_39_0 = var_2_10000(var_2_10002)
			local var_39_1 = var_0.getActTaskTip

			ActivityConst = var_2_10003

			return var_39_1(var_39_0, var_2_10003.ISLAND_TASK_ID)
		end

		local function var_36_3()
			getProxy = var_2_10000
			ActivityProxy = var_2_10002

			local var_40_0 = var_2_10000(var_2_10002)
			local var_40_1 = var_0.getActivityByType

			ActivityConst = var_2_10003

			local var_40_2 = var_40_1(var_40_0, var_2_10003.ACTIVITY_TYPE_SCULPTURE)

			Activity = var_2_10001

			return var_2_10001.IsActivityReady(var_40_2)
		end

		local var_36_4

		if not var_36_0() and not var_36_1() and not var_36_2() then
			var_36_4 = var_36_3()
		end

		return var_36_4
	end

	return
end

return var_0_1
