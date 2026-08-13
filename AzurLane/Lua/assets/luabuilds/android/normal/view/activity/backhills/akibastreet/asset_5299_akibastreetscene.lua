class = var_0_10000

local var_0_0 = "AkibaStreetScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

var_0_1.UIName = "AkibaStreetUI"
var_0_1.edge2area = {
	["4_5"] = "_bottom",
	default = "_middle",
	["5_6"] = "_bottom"
}
var_0_1.Buildings = {
	nil,
	nil,
	nil,
	nil,
	"shudian",
	"youxidian",
	"moxingdian",
	"kafeiting"
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
	arg_1_0.graphPath = var_1_13(var_1_12("GameCfg.BackHillGraphs.AkibaGraph"))

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

	local var_1_20 = arg_1_0

	arg_1_0.RegisterDataResponse(var_1_20)

	PLATFORM_CODE = var_1
	PLATFORM_JP = var_1_20

	if var_1 ~= var_1_20 then
		setActive = var_1

		local var_1_21 = arg_1_0._upper

		var_1(var_2.Find(var_1_21, "shujvhuigu"), false)

		GetOrAddComponent = var_1

		local var_1_22 = arg_1_0._map
		local var_1_23 = var_2.Find(var_1_22, "shujvhuigu")

		typeof = var_1_22
		Button = var_4
		var_1(var_1_23, var_1_22(var_4)).enabled = false
	end

	return
end

function var_0_1.RegisterDataResponse(arg_2_0)
	ResponsableTree = var_1_10001
	arg_2_0.Respones = var_1_10001.CreateShell({})

	local var_2_0 = arg_2_0.Respones

	var_1.SetRawData(var_2_0, "view", arg_2_0)

	local var_2_1 = {
		"shudian",
		"youxidian",
		"moxingdian",
		"kafeiting"
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

			var_2.GetSpriteQuiet(var_3_0, "ui/AkibaStreetUI_atlas", iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

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
		"shudian",
		"youxidian",
		"moxingdian",
		"kafeiting",
		"jiejiting",
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
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_9_0 = var_2_10000(var_2_10001)
		local var_9_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		if var_9_1(var_9_0, var_2_10002.ACTIVITY_TYPE_CLIENT_DISPLAY) and not var_0:isEnd() then
			local var_9_2 = arg_7_0
			local var_9_3 = var_1.emit

			ThirdAnniversarySquareMediator = var_2_10003

			local var_9_4 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_9_3(var_9_2, var_9_4, var_2_10004.ACTIVITY, {
				id = var_0.id
			})
		end

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

	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "jiejiting", function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.m02
		local var_13_1 = var_0.sendNotification

		GAME = var_2_10002

		var_13_1(var_13_0, var_2_10002.GO_MINI_GAME, 14)

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

	local var_7_8 = arg_7_0.loader

	var_1.GetPrefab(var_7_8, "ui/zhuanzhu_caidai", "zhuanzhu_caidai", function(arg_17_0)
		setParent = var_2_10001

		var_2_10001(arg_17_0, arg_7_0._map)

		GameObject = var_2_10001

		local var_17_0 = var_2_10001.Find("UICamera/Canvas")
		local var_17_1 = var_1.GetComponent

		typeof = var_3
		Canvas = var_2_10004

		local var_17_2 = var_17_1(var_17_0, var_3(var_2_10004)).sortingOrder

		pg = var_3

		local var_17_3 = var_3.ViewUtils.SetSortingOrder

		tf = var_2_10004

		var_17_3(var_2_10004(arg_17_0), var_17_2 + 1)

		return
	end)

	pg = var_1

	local var_7_9 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_7_9, arg_7_0.top, false)

	return
end

function var_0_1.UpdateActivity(arg_18_0, arg_18_1)
	arg_18_0.activity = arg_18_1

	local var_18_0 = arg_18_0.Respones
	local var_18_1

	if not arg_18_1.data1KeyValueList[2][5] then
		var_18_1 = 1
	end

	var_18_0.shudian = var_18_1

	local var_18_2 = arg_18_0.Respones
	local var_18_3

	if not arg_18_1.data1KeyValueList[2][6] then
		var_18_3 = 1
	end

	var_18_2.youxidian = var_18_3

	local var_18_4 = arg_18_0.Respones
	local var_18_5

	if not arg_18_1.data1KeyValueList[2][7] then
		var_18_5 = 1
	end

	var_18_4.moxingdian = var_18_5

	local var_18_6 = arg_18_0.Respones
	local var_18_7

	if not arg_18_1.data1KeyValueList[2][8] then
		var_18_7 = 1
	end

	var_18_6.kafeiting = var_18_7
	next = var_18_6

	local var_18_8 = var_18_6(arg_18_1.data1KeyValueList[1])
	local var_18_9 = arg_18_0.Respones
	local var_18_10

	if not arg_18_1.data1KeyValueList[1][var_18_8] then
		var_18_10 = 0
	end

	var_18_9.materialCount = var_18_10

	arg_18_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)

	arg_19_0.Respones.shudianTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 5)
	arg_19_0.Respones.youxidianTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 6)
	arg_19_0.Respones.moxingdianTip = arg_19_0:UpdateBuildingTip(arg_19_0.activity, 7)

	local var_19_1 = arg_19_0.Respones
	local var_19_2 = arg_19_0

	var_19_1.kafeitingTip = arg_19_0.UpdateBuildingTip(var_19_2, arg_19_0.activity, 8)
	arg_19_0.Respones.shujvhuiguTip = false

	local var_19_3 = var_19_0
	local var_19_4 = var_19_0.getActivityByType

	ActivityConst = var_19_2

	local var_19_5 = var_19_4(var_19_3, var_19_2.ACTIVITY_TYPE_MINIGAME)

	getProxy = var_19_3
	MiniGameProxy = var_4

	local var_19_6 = var_19_3(var_4)
	local var_19_7 = var_3.GetHubByHubId(var_19_6, var_19_5:getConfig("config_id"))

	arg_19_0.Respones.jiejitingTip = var_19_7.count > 0

	arg_19_0:UpdateHubData(var_19_7)

	if not arg_19_0.InitStudentBegin then
		arg_19_0:InitStudents(var_19_5.id, 3, 4)

		arg_19_0.InitStudentBegin = true
	end

	return
end

function var_0_1.UpdateHubData(arg_20_0, arg_20_1)
	arg_20_0.Respones.hubData.count = arg_20_1.count
	arg_20_0.Respones.hubData.usedtime = arg_20_1.usedtime
	arg_20_0.Respones.hubData.id = arg_20_1.id

	local var_20_0 = arg_20_0.Respones

	var_2.PropertyChange(var_20_0, "hubData")

	return
end

function var_0_1.willExit(arg_21_0)
	pg = var_1_10001

	local var_21_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_21_0, arg_21_0.top, arg_21_0._tf)
	arg_21_0:clearStudents()

	arg_21_0.Respones = nil

	var_0_1.super.willExit(arg_21_0)

	return
end

return var_0_1
