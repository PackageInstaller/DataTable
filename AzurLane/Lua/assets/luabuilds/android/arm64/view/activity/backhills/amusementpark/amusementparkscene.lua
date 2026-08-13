class = var_0_10000

local var_0_0 = "AmusementParkScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..TemplateMV.BackHillTemplate"))

var_0_1.UIName = "AmusementParkUI"
var_0_1.edge2area = {
	default = "map_middle",
	["1_1"] = "map_top"
}
var_0_1.Buildings = {
	[9] = "xuanzhuanmuma",
	[10] = "guoshanche",
	[12] = "haidaochuan",
	[11] = "tiaolouji"
}

function var_0_1.init(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.top = var_1.Find(var_1_0, "Top")

	local var_1_1 = arg_1_0._tf

	arg_1_0._map = var_1.Find(var_1_1, "map")

	for iter_1_0 = 0, arg_1_0._map.childCount - 1 do
		local var_1_2 = arg_1_0._map
		local var_1_3 = var_5.GetChild(var_1_2, iter_1_0)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_3).name
		arg_1_0["map_" .. var_1_10006] = var_1_3
	end

	local var_1_4 = arg_1_0._map

	arg_1_0._shipTpl = var_1.Find(var_1_4, "ship")
	arg_1_0.containers = {
		arg_1_0.map_middle,
		arg_1_0.map_top
	}
	GraphPath = var_1

	local var_1_5 = var_1.New

	import = var_1_4
	arg_1_0.graphPath = var_1_5(var_1_4("GameCfg.BackHillGraphs.AmusementParkGraph"))

	local var_1_6 = arg_1_0._tf

	arg_1_0._upper = var_1.Find(var_1_6, "upper")

	for iter_1_1 = 0, arg_1_0._upper.childCount - 1 do
		local var_1_7 = arg_1_0._upper
		local var_1_8 = var_1_8.GetChild(var_1_7, iter_1_1)

		go = var_1_10006
		var_1_10006 = var_1_10006(var_1_8).name
		arg_1_0["upper_" .. var_1_10006] = var_1_8
	end

	local var_1_9 = arg_1_0.top
	local var_1_10 = var_1.Find(var_1_9, "GameCount/text")
	local var_1_11 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.gameCountTxt = var_1_11(var_1_10, var_4(var_1_10006))

	local var_1_12 = arg_1_0.top
	local var_1_13 = var_1.Find(var_1_12, "MaterialCount/text")
	local var_1_14 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_1_0.materialTxt = var_1_14(var_1_13, var_4(var_1_10006))
	setActive = var_1

	local var_1_15 = arg_1_0.map_huiyichengbao

	PLATFORM_CODE = var_4
	PLATFORM_CH = var_1_8

	var_1(var_1_15, var_4 == var_1_8)

	setActive = var_1

	local var_1_16 = arg_1_0.upper_huiyichengbao

	PLATFORM_CODE = var_4
	PLATFORM_CH = var_1_8

	var_1(var_1_16, var_4 == var_1_8)
	arg_1_0:RegisterDataResponse()

	AutoLoader = var_1
	arg_1_0.loader = var_1.New()

	return
end

function var_0_1.RegisterDataResponse(arg_2_0)
	ResponsableTree = var_1_10001
	arg_2_0.Respones = var_1_10001.CreateShell({})

	local var_2_0 = arg_2_0.Respones

	var_1.SetRawData(var_2_0, "view", arg_2_0)

	local var_2_1 = {
		"guoshanche",
		"haidaochuan",
		"xuanzhuanmuma",
		"tiaolouji"
	}

	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(var_2_1) do
		local var_2_2 = arg_2_0.Respones

		var_7.AddRawListener(var_2_2, {
			"view",
			iter_2_1
		}, function(arg_3_0, arg_3_1)
			if not arg_3_1 then
				return
			end

			local var_3_0 = arg_3_0.loader

			var_2.GetSpriteQuiet(var_3_0, "ui/AmusementParkUI_atlas", "entrance_" .. iter_2_1 .. arg_3_1, arg_3_0["map_" .. iter_2_1])

			if arg_3_0["upper_" .. iter_2_1] then
				IsNil = var_3

				if var_3(var_2:Find("Level")) then
					return
				end

				setText = var_3

				var_3(var_2:Find("Level"), "LV." .. arg_3_1)

				return
			end
		end)
	end

	local var_2_3 = {
		"guoshanche",
		"haidaochuan",
		"xuanzhuanmuma",
		"tiaolouji",
		"dangaobaoweizhan",
		"jiujiuduihuanwu"
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

				if var_3(var_2:Find("Tip")) then
					return
				end

				setActive = var_3

				var_3(var_2:Find("Tip"), arg_4_1)

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
		arg_5_0.gameCountTxt.text = "X" .. arg_5_1.count

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
	local var_7_1 = arg_7_0.top

	var_1_10001(var_7_0, var_4.Find(var_7_1, "Back"), function()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_BACK)

		return
	end)

	onButton = var_1_10001

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.top

	var_1_10001(var_7_2, var_4.Find(var_7_3, "Home"), function()
		local var_9_0 = arg_7_0

		var_0.emit(var_9_0, var_0_1.ON_HOME)

		return
	end)

	onButton = var_1_10001

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.top

	var_1_10001(var_7_4, var_4.Find(var_7_5, "Help"), function()
		pg = var_2_10000

		local var_10_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_10_1 = var_0.ShowMsgBox
		local var_10_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_10_2.type = var_2_10004
		pg = var_2_10004
		var_10_2.helps = var_2_10004.gametip.amusementpark_help.tip

		var_10_1(var_10_0, var_10_2)

		return
	end)

	onButton = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.top

	var_1_10001(var_7_6, var_4.Find(var_7_7, "Invitation"), function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10002

		local var_11_0 = var_2_10000(var_2_10002)
		local var_11_1 = var_0.getActivityByType

		ActivityConst = var_2_10003

		if var_11_1(var_11_0, var_2_10003.ACTIVITY_TYPE_CLIENT_DISPLAY) and not var_0:isEnd() then
			local var_11_2 = arg_7_0
			local var_11_3 = var_1.emit

			BackHillMediatorTemplate = var_2_10004

			local var_11_4 = var_2_10004.GO_SCENE

			SCENE = var_2_10005

			var_11_3(var_11_2, var_11_4, var_2_10005.ACTIVITY, {
				id = var_0.id
			})
		end

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "jiujiuduihuanwu", function()
		local var_12_0 = arg_7_0
		local var_12_1 = var_0.emit

		AmusementParkMediator = var_2_10003

		local var_12_2 = var_2_10003.GO_SUBLAYER

		Context = var_2_10004

		local var_12_3 = var_2_10004.New
		local var_12_4 = {}

		AmusementParkShopMediator = var_2_10007
		var_12_4.mediator = var_2_10007
		AmusementParkShopPage = var_2_10007
		var_12_4.viewComponent = var_2_10007

		var_12_1(var_12_0, var_12_2, var_12_3(var_12_4))

		return
	end)

	pairs = var_1

	for iter_7_0, iter_7_1 in var_1(arg_7_0.Buildings) do
		arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, iter_7_1, function()
			local var_13_0 = arg_7_0
			local var_13_1 = var_0.emit

			BackHillMediatorTemplate = var_2_10003

			local var_13_2 = var_2_10003.GO_SUBLAYER

			Context = var_2_10004

			local var_13_3 = var_2_10004.New
			local var_13_4 = {}

			BuildingUpgradeMediator = var_2_10007
			var_13_4.mediator = var_2_10007
			BuildingUpgradeLayer = var_2_10007
			var_13_4.viewComponent = var_2_10007
			var_13_4.data = {
				buildingID = iter_7_0
			}

			var_13_1(var_13_0, var_13_2, var_13_3(var_13_4))

			return
		end)
	end

	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "dangaobaoweizhan", function()
		pg = var_2_10000

		local var_14_0 = var_2_10000.m02
		local var_14_1 = var_0.sendNotification

		GAME = var_2_10003

		var_14_1(var_14_0, var_2_10003.GO_MINI_GAME, 23)

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "huiyichengbao", function()
		local var_15_0 = arg_7_0
		local var_15_1 = var_0.emit

		AmusementParkMediator = var_2_10003

		local var_15_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_15_1(var_15_0, var_15_2, var_2_10004.SUMMARY)

		return
	end)
	arg_7_0:InitFacilityCross(arg_7_0._map, arg_7_0._upper, "xianshijianzao", function()
		local var_16_0 = arg_7_0
		local var_16_1 = var_0.emit

		AmusementParkMediator = var_2_10003

		local var_16_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_16_1(var_16_0, var_16_2, var_2_10004.GETBOAT, {
			projectName = "new",
			page = 1
		})

		return
	end)

	local var_7_8 = arg_7_0

	arg_7_0.InitFacilityCross(var_7_8, arg_7_0._map, arg_7_0._upper, "huanzhuangshandian", function()
		local var_17_0 = arg_7_0
		local var_17_1 = var_0.emit

		AmusementParkMediator = var_2_10003

		local var_17_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_17_1(var_17_0, var_17_2, var_2_10004.SKINSHOP)

		return
	end)

	getProxy = var_1
	ActivityProxy = var_7_8

	local var_7_9 = var_1(var_7_8)
	local var_7_10 = var_1.getActivityByType

	ActivityConst = var_4

	local var_7_11 = var_7_10(var_7_9, var_4.ACTIVITY_TYPE_MINIGAME)

	arg_7_0:InitStudents(var_7_11 and var_7_11.id, 2, 3)
	arg_7_0:UpdateView()

	local var_7_12 = arg_7_0.loader

	var_2.LoadPrefab(var_7_12, "ui/houshan_caidai", "", function(arg_18_0)
		setParent = var_2_10001

		var_2_10001(arg_18_0, arg_7_0._map)

		return
	end)

	return
end

function var_0_1.UpdateActivity(arg_19_0, arg_19_1)
	arg_19_0.activity = arg_19_1

	local var_19_0 = arg_19_0.Respones
	local var_19_1

	if not arg_19_1.data1KeyValueList[2][9] then
		var_19_1 = 1
	end

	var_19_0.xuanzhuanmuma = var_19_1

	local var_19_2 = arg_19_0.Respones
	local var_19_3

	if not arg_19_1.data1KeyValueList[2][10] then
		var_19_3 = 1
	end

	var_19_2.guoshanche = var_19_3

	local var_19_4 = arg_19_0.Respones
	local var_19_5

	if not arg_19_1.data1KeyValueList[2][11] then
		var_19_5 = 1
	end

	var_19_4.tiaolouji = var_19_5

	local var_19_6 = arg_19_0.Respones
	local var_19_7

	if not arg_19_1.data1KeyValueList[2][12] then
		var_19_7 = 1
	end

	var_19_6.haidaochuan = var_19_7
	next = var_19_6

	local var_19_8 = var_19_6(arg_19_1.data1KeyValueList[1])
	local var_19_9 = arg_19_0.Respones
	local var_19_10

	if not arg_19_1.data1KeyValueList[1][var_19_8] then
		var_19_10 = 0
	end

	var_19_9.materialCount = var_19_10

	arg_19_0:UpdateView()

	return
end

function var_0_1.UpdateView(arg_20_0)
	local var_20_0

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_20_1 = var_1_10002(var_1_10004)

	arg_20_0.Respones.xuanzhuanmumaTip = arg_20_0:UpdateBuildingTip(arg_20_0.activity, 9)
	arg_20_0.Respones.guoshancheTip = arg_20_0:UpdateBuildingTip(arg_20_0.activity, 10)
	arg_20_0.Respones.tiaoloujiTip = arg_20_0:UpdateBuildingTip(arg_20_0.activity, 11)

	local var_20_2 = arg_20_0.Respones
	local var_20_3 = arg_20_0

	var_20_2.haidaochuanTip = arg_20_0.UpdateBuildingTip(var_20_3, arg_20_0.activity, 12)

	local var_20_4 = var_20_1
	local var_20_5 = var_20_1.getActivityByType

	ActivityConst = var_20_3

	local var_20_6 = var_20_5(var_20_4, var_20_3.ACTIVITY_TYPE_MINIGAME)

	getProxy = var_4
	MiniGameProxy = var_6

	local var_20_7 = var_4(var_6)
	local var_20_8 = var_4.GetHubByHubId(var_20_7, var_20_6:getConfig("config_id")).count
	local var_20_9 = 0 < var_20_8

	arg_20_0.Respones.dangaobaoweizhanTip = var_20_9

	arg_20_0:UpdateHubData(var_5)

	local var_20_10 = arg_20_0.Respones

	AmusementParkShopPage = var_7
	var_20_10.jiujiuduihuanwuTip = var_7.GetActivityShopTip()

	return
end

function var_0_1.UpdateHubData(arg_21_0, arg_21_1)
	arg_21_0.Respones.hubData.count = arg_21_1.count
	arg_21_0.Respones.hubData.usedtime = arg_21_1.usedtime
	arg_21_0.Respones.hubData.id = arg_21_1.id

	local var_21_0 = arg_21_0.Respones

	var_2.PropertyChange(var_21_0, "hubData")

	return
end

function var_0_1.willExit(arg_22_0)
	arg_22_0:clearStudents()
	var_0_1.super.willExit(arg_22_0)

	return
end

return var_0_1
