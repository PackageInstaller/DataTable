class = var_0_10000

local var_0_0 = "ThirdAnniversarySquareScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

var_0_1.UIName = "ThirdAnniversarySquareUI"
var_0_1.HUB_ID = 9
var_0_1.edge2area = {
	default = "_middle",
	["3_4"] = "_bottom",
	["4_5"] = "_bottom",
	["7_7"] = "_front"
}
var_0_1.Buildings = {
	"nvpukafeiting",
	"xiaolongbaodian",
	"zhajihanbaodian",
	"heguozidian"
}

function var_0_1.init(arg_1_0)
	AutoLoader = var_1_10001
	arg_1_0.loader = var_1_10001.New()

	local var_1_0 = arg_1_0._tf

	arg_1_0.top = var_1.Find(var_1_0, "top")

	local var_1_1 = arg_1_0._tf

	arg_1_0._map = var_1.Find(var_1_1, "map")

	for iter_1_0 = 0, arg_1_0._map.childCount - 1 do
		local var_1_2 = arg_1_0._map
		local var_1_3 = var_5.GetChild(var_1_2, iter_1_0)

		go = var_1_2

		local var_1_4 = var_1_2(var_1_3).name

		arg_1_0["map_" .. var_1_4] = var_1_3
	end

	local var_1_5 = arg_1_0._tf

	arg_1_0._upper = var_1.Find(var_1_5, "upper")

	for iter_1_1 = 0, arg_1_0._upper.childCount - 1 do
		local var_1_6 = arg_1_0._upper
		local var_1_7 = var_5.GetChild(var_1_6, iter_1_1)

		go = var_1_6

		local var_1_8 = var_1_6(var_1_7).name

		arg_1_0["upper_" .. var_1_8] = var_1_7
	end

	local var_1_9 = arg_1_0._map

	arg_1_0._front = var_1.Find(var_1_9, "top")

	local var_1_10 = arg_1_0._map

	arg_1_0._middle = var_1.Find(var_1_10, "middle")

	local var_1_11 = arg_1_0._map

	arg_1_0._bottom = var_1.Find(var_1_11, "bottom")
	arg_1_0.containers = {
		arg_1_0._front,
		arg_1_0._middle,
		arg_1_0._bottom
	}

	local var_1_12 = arg_1_0._map

	arg_1_0._shipTpl = var_1.Find(var_1_12, "ship")
	GraphPath = var_1

	local var_1_13 = var_1.New

	import = var_1_12
	arg_1_0.graphPath = var_1_13(var_1_12("GameCfg.BackHillGraphs.ThirdAnniversarySquareGraph"))

	local var_1_14 = arg_1_0.top
	local var_1_15 = var_1.Find(var_1_14, "usable_count/text")
	local var_1_16 = var_1.GetComponent

	typeof = var_3
	Text = iter_1_1
	arg_1_0.usableTxt = var_1_16(var_1_15, var_3(iter_1_1))

	local var_1_17 = arg_1_0.top
	local var_1_18 = var_1.Find(var_1_17, "material/text")
	local var_1_19 = var_1.GetComponent

	typeof = var_3
	Text = iter_1_1
	arg_1_0.materialTxt = var_1_19(var_1_18, var_3(iter_1_1))

	arg_1_0:RegisterDataResponse()

	return
end

function var_0_1.RegisterDataResponse(arg_2_0)
	ResponsableTree = var_1_10001
	arg_2_0.Respones = var_1_10001.CreateShell({})

	local var_2_0 = arg_2_0.Respones

	var_1.SetRawData(var_2_0, "view", arg_2_0)

	local var_2_1 = {
		"xiaolongbaodian",
		"heguozidian",
		"nvpukafeiting",
		"zhajihanbaodian"
	}

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		local var_2_2 = arg_2_0.Respones

		var_7.AddRawListener(var_2_2, {
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			local var_3_0 = arg_3_0.loader

			var_2.GetSpriteQuiet(var_3_0, "ui/thirdanniversarysquareui_atlas", iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if arg_3_0["upper_" .. iter_2_1] then
				IsNil = var_3

				if var_3(var_2:Find("level")) then
					return
				end

				setText = var_3

				var_3(var_2:Find("level"), "LV." .. arg_3_1)

				return
			end
		end)
	end

	local var_2_3 = {
		"xiaolongbaodian",
		"heguozidian",
		"nvpukafeiting",
		"zhajihanbaodian",
		"gangqvchenlieshi",
		"huanzhuangshandian",
		"shujvhuigu",
		"xianshijianzao"
	}

	ipairs = var_3

	for iter_2_2, iter_2_3 in var_3(var_2_3) do
		local var_2_4 = arg_2_0.Respones

		var_8.AddRawListener(var_2_4, {
			"view",
			iter_2_3 .. "Tip"
		}, function(arg_4_0, arg_4_1)
			if arg_4_0["upper_" .. iter_2_3] then
				IsNil = var_3

				if var_3(var_2:Find("tip")) then
					return
				end

				setActive = var_3

				var_3(var_2:Find("tip"), arg_4_1)

				return
			end
		end)
	end

	arg_2_0.Respones.hubData = {}

	local var_2_5 = arg_2_0.Respones

	var_3.AddRawListener(var_2_5, {
		"view",
		"hubData"
	}, function(arg_5_0, arg_5_1)
		arg_5_0.usableTxt.text = "X" .. arg_5_1.count

		return
	end, {
		strict = true
	})

	local var_2_6 = arg_2_0.Respones

	var_3.AddRawListener(var_2_6, {
		"view",
		"materialCount"
	}, function(arg_6_0, arg_6_1)
		arg_6_0.materialTxt.text = arg_6_1

		return
	end)

	return
end

function var_0_1.didEnter(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0._tf

	var_1_10001(var_7_0, var_3.Find(var_7_1, "top/return_btn"), function()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.top

	var_1_10001(var_7_2, var_3.Find(var_7_3, "daka_count"), function()
		local var_9_0 = arg_7_0
		local var_9_1 = var_0.emit

		ThirdAnniversarySquareMediator = var_2_10002

		var_9_1(var_9_0, var_2_10002.ON_OPEN_TOWERCLIMBING_SIGNED)

		return
	end)

	onButton = var_1_10001

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0._tf

	var_1_10001(var_7_4, var_3.Find(var_7_5, "top/return_main_btn"), function()
		local var_10_0 = arg_7_0

		var_0.emit(var_10_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0._tf

	var_1_10001(var_7_6, var_3.Find(var_7_7, "top/help_btn"), function()
		pg = var_2_10000

		local var_11_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_11_1 = var_0.ShowMsgBox
		local var_11_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_11_2.type = var_2_10003
		pg = var_2_10003
		var_11_2.helps = var_2_10003.gametip.qingdianguangchang_help.tip

		var_11_1(var_11_0, var_11_2)

		return
	end)

	pairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0.Buildings) do
		arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, iter_7_1, function()
			local var_12_0 = arg_7_0
			local var_12_1 = var_0.emit

			BackHillMediatorTemplate = var_2_10002

			local var_12_2 = var_2_10002.GO_SUBLAYER

			Context = var_2_10003

			local var_12_3 = var_2_10003.New
			local var_12_4 = {}

			BuildingUpgradeMediator = var_2_10005
			var_12_4.mediator = var_2_10005
			BuildingUpgradeLayer = var_2_10005
			var_12_4.viewComponent = var_2_10005
			var_12_4.data = {
				buildingID = iter_7_0
			}

			var_12_1(var_12_0, var_12_2, var_12_3(var_12_4))

			return
		end)
	end

	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "gangqvchenlieshi", function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.m02
		local var_13_1 = var_0.sendNotification

		GAME = var_2_10002

		var_13_1(var_13_0, var_2_10002.GO_MINI_GAME, 13)

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "shujvhuigu", function()
		local var_14_0 = arg_7_0
		local var_14_1 = var_0.emit

		ThirdAnniversarySquareMediator = var_2_10002

		local var_14_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_14_1(var_14_0, var_14_2, var_2_10003.SUMMARY)

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "xianshijianzao", function()
		local var_15_0 = arg_7_0
		local var_15_1 = var_0.emit

		ThirdAnniversarySquareMediator = var_2_10002

		local var_15_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_15_1(var_15_0, var_15_2, var_2_10003.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "huanzhuangshandian", function()
		local var_16_0 = arg_7_0
		local var_16_1 = var_0.emit

		ThirdAnniversarySquareMediator = var_2_10002

		local var_16_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_16_1(var_16_0, var_16_2, var_2_10003.SKINSHOP)

		return
	end)

	pg = var_1

	local var_7_8 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_7_8, arg_7_0.top)

	return
end

function var_0_1.UpdateActivity(arg_17_0, arg_17_1)
	arg_17_0.activity = arg_17_1

	local var_17_0 = arg_17_0.Respones
	local var_17_1

	if not arg_17_1.data1KeyValueList[2][1] then
		var_17_1 = 1
	end

	var_17_0.nvpukafeiting = var_17_1

	local var_17_2 = arg_17_0.Respones
	local var_17_3

	if not arg_17_1.data1KeyValueList[2][2] then
		var_17_3 = 1
	end

	var_17_2.xiaolongbaodian = var_17_3

	local var_17_4 = arg_17_0.Respones
	local var_17_5

	if not arg_17_1.data1KeyValueList[2][3] then
		var_17_5 = 1
	end

	var_17_4.zhajihanbaodian = var_17_5

	local var_17_6 = arg_17_0.Respones
	local var_17_7

	if not arg_17_1.data1KeyValueList[2][4] then
		var_17_7 = 1
	end

	var_17_6.heguozidian = var_17_7
	next = var_17_6

	local var_17_8 = var_17_6(arg_17_1.data1KeyValueList[1])
	local var_17_9 = arg_17_0.Respones
	local var_17_10

	if not arg_17_1.data1KeyValueList[1][var_17_8] then
		var_17_10 = 0
	end

	var_17_9.materialCount = var_17_10

	arg_17_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_18_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)

	arg_18_0.Respones.nvpukafeitingTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 1)
	arg_18_0.Respones.xiaolongbaodianTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 2)
	arg_18_0.Respones.zhajihanbaodianTip = arg_18_0:UpdateBuildingTip(arg_18_0.activity, 3)

	local var_18_1 = arg_18_0.Respones
	local var_18_2 = arg_18_0

	var_18_1.heguozidianTip = arg_18_0.UpdateBuildingTip(var_18_2, arg_18_0.activity, 4)
	arg_18_0.Respones.shujvhuiguTip = false

	local var_18_3 = var_18_0
	local var_18_4 = var_18_0.getActivityByType

	ActivityConst = var_18_2

	local var_18_5 = var_18_4(var_18_3, var_18_2.ACTIVITY_TYPE_MINIGAME)

	getProxy = var_18_3
	MiniGameProxy = var_4

	local var_18_6 = var_18_3(var_4)
	local var_18_7 = var_3.GetHubByHubId(var_18_6, var_18_5:getConfig("config_id"))

	arg_18_0.Respones.gangqvchenlieshiTip = var_18_7.count > 0

	arg_18_0:UpdateHubData(var_18_7)

	if not arg_18_0.InitStudentBegin then
		arg_18_0:InitStudents(var_18_5.id, 2, 3)

		arg_18_0.InitStudentBegin = true
	end

	return
end

function var_0_1.UpdateHubData(arg_19_0, arg_19_1)
	arg_19_0.Respones.hubData.count = arg_19_1.count
	arg_19_0.Respones.hubData.usedtime = arg_19_1.usedtime
	arg_19_0.Respones.hubData.id = arg_19_1.id

	local var_19_0 = arg_19_0.Respones

	var_2.PropertyChange(var_19_0, "hubData")

	return
end

function var_0_1.willExit(arg_20_0)
	pg = var_1_10001

	local var_20_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_20_0, arg_20_0.top, arg_20_0._tf)
	arg_20_0:clearStudents()

	arg_20_0.Respones = nil

	var_0_1.super.willExit(arg_20_0)

	return
end

return var_0_1
