class = var_0_10000

local var_0_0 = "BackHillCampusFestival2022Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..TemplateMV.BackHillTemplate"))

function var_0_1.getUIName(arg_1_0)
	return "BackHillCampusFestivalUI"
end

var_0_1.edge2area = {
	default = "_SDPlace"
}
var_0_1.Buildings = {
	[19] = "teachingbuilding",
	[20] = "astrologerstent",
	[21] = "stage",
	[22] = "shoppingstreet"
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

	arg_2_0._shipTpl = var_1.Find(var_2_6, "ship")

	local var_2_7 = arg_2_0._tf

	arg_2_0._upper = var_1.Find(var_2_7, "upper")

	for iter_2_1 = 0, arg_2_0._upper.childCount - 1 do
		local var_2_8 = arg_2_0._upper
		local var_2_9 = var_5.GetChild(var_2_8, iter_2_1)

		go = var_2_8

		local var_2_10 = var_2_8(var_2_9).name

		arg_2_0["upper_" .. var_2_10] = var_2_9
	end

	setActive = var_1

	var_1(arg_2_0.map_Decoration, false)

	local var_2_11 = arg_2_0._map

	arg_2_0._SDPlace = var_1.Find(var_2_11, "SDPlace")
	arg_2_0.containers = {
		arg_2_0._SDPlace
	}

	local var_2_12 = arg_2_0.top
	local var_2_13 = var_1.Find(var_2_12, "GameCount/Text")
	local var_2_14 = var_1.GetComponent

	typeof = var_3
	Text = iter_2_1
	arg_2_0.gameCountTxt = var_2_14(var_2_13, var_3(iter_2_1))

	local var_2_15 = arg_2_0.top
	local var_2_16 = var_1.Find(var_2_15, "Material/Text")
	local var_2_17 = var_1.GetComponent

	typeof = var_3
	Text = iter_2_1
	arg_2_0.materialTxt = var_2_17(var_2_16, var_3(iter_2_1))
	GraphPath = var_1

	local var_2_18 = var_1.New

	import = var_2_16
	arg_2_0.graphPath = var_2_18(var_2_16("GameCfg.BackHillGraphs.BackHillCampusFestiva2022Graph"))

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

		var_0.emit(var_5_0, var_0_1.ON_HOME)

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
		var_6_2.helps = var_2_10003.gametip.backhill_campusfestival_tip.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_3_8, var_3_10, var_3_11, var_5)

	onButton = var_1_10001

	local var_3_12 = arg_3_0
	local var_3_13 = arg_3_0._tf

	var_1_10001(var_3_12, var_3.Find(var_3_13, "top/Invitation"), function()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)
		local var_7_1 = var_0.getActivityById

		ActivityConst = var_2_10002

		if var_7_1(var_7_0, var_2_10002.INVITATION_JP_FIFTH) and not var_0:isEnd() then
			local var_7_2 = arg_3_0
			local var_7_3 = var_1.emit

			BackHillMediatorTemplate = var_2_10003

			local var_7_4 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_7_3(var_7_2, var_7_4, var_2_10004.ACTIVITY, {
				id = var_0.id
			})
		end

		return
	end)

	getProxy = var_1_10001
	ActivityProxy = var_3_12

	local var_3_14 = var_1_10001(var_3_12)
	local var_3_15 = var_1.getActivityById

	ActivityConst = var_3

	local var_3_16 = var_3_15(var_3_14, var_3.MINIGAME_CAKEMAKING)

	arg_3_0:InitStudents(var_3_16 and var_3_16.id, 3, 4)
	arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "cakeshop", function()
		pg = var_2_10000

		local var_8_0 = var_2_10000.m02
		local var_8_1 = var_0.sendNotification

		GAME = var_2_10002

		var_8_1(var_8_0, var_2_10002.GO_MINI_GAME, 42)

		return
	end)

	pairs = var_2

	for iter_3_0, iter_3_1 in var_2(arg_3_0.Buildings) do
		arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, iter_3_1, function()
			local var_9_0 = arg_3_0
			local var_9_1 = var_0.emit

			BackHillMediatorTemplate = var_2_10002

			local var_9_2 = var_2_10002.GO_SUBLAYER

			Context = var_2_10003

			local var_9_3 = var_2_10003.New
			local var_9_4 = {}

			BuildingUpgradeMediator = var_2_10005
			var_9_4.mediator = var_2_10005
			BuildingUpgradeLayer = var_2_10005
			var_9_4.viewComponent = var_2_10005
			var_9_4.data = {
				buildingID = iter_3_0
			}

			var_9_1(var_9_0, var_9_2, var_9_3(var_9_4))

			return
		end)
	end

	setActive = var_2

	local var_3_17 = arg_3_0.upper_shujvhuigu

	PLATFORM_CODE = var_4
	PLATFORM_JP = iter_3_0

	var_2(var_3_17, var_4 == iter_3_0)

	PLATFORM_CODE = var_2
	PLATFORM_JP = var_3_17

	if var_2 == var_3_17 then
		local function var_3_18()
			local var_10_0 = arg_3_0
			local var_10_1 = var_0.emit

			NewYearFestivalMediator = var_2_10002

			local var_10_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_10_1(var_10_0, var_10_2, var_2_10003.SUMMARY)

			return
		end

		arg_3_0:InitFacilityCross(arg_3_0._map, arg_3_0._upper, "shujvhuigu", var_3_18)
	end

	arg_3_0:BindItemSkinShop()
	arg_3_0:BindItemBuildShip()
	arg_3_0:RegisterDataResponse()
	arg_3_0:UpdateView()

	return
end

function var_0_1.UpdateActivity(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getConfig(var_11_0, "type")

	ActivityConst = var_11_0

	if var_11_1 == var_11_0.ACTIVITY_TYPE_BUILDING_BUFF then
		arg_11_0:UpdateView()
	end

	return
end

local var_0_2 = {}

Vector2 = var_2
var_0_2[1] = var_2(-744, -187.3)
Vector2 = var_2
var_0_2[2] = var_2(-744, -187.3)
Vector2 = var_2
var_0_2[3] = var_2(-801.7, -149)

function var_0_1.RegisterDataResponse(arg_12_0)
	ResponsableTree = var_1_10001
	arg_12_0.Respones = var_1_10001.CreateShell({})

	local var_12_0 = arg_12_0.Respones

	var_1.SetRawData(var_12_0, "view", arg_12_0)

	_ = var_1

	local var_12_1 = var_1.values(arg_12_0.Buildings)

	ipairs = var_2

	for iter_12_0, iter_12_1 in var_2(var_12_1) do
		local var_12_2 = arg_12_0.Respones

		var_7.AddRawListener(var_12_2, {
			"view",
			iter_12_1
		}, function(arg_13_0, arg_13_1)
			if not arg_13_1 then
				return
			end

			local var_13_0 = arg_13_0.loader
			local var_13_1 = var_2.GetSpriteQuiet
			local var_13_2 = "ui/"
			local var_13_3 = arg_12_0

			var_13_1(var_13_0, var_13_2 .. var_5.getUIName(var_13_3) .. "_atlas", "entrance_" .. iter_12_1 .. arg_13_1, arg_13_0["map_" .. iter_12_1], true)

			if arg_13_0["upper_" .. iter_12_1] then
				IsNil = var_3

				if var_3(var_2:Find("Lv")) then
					return
				end

				setText = var_3

				var_3(var_2:Find("Lv"), arg_13_1)

				return
			end
		end)
	end

	local var_12_3 = arg_12_0.Respones

	var_2.AddRawListener(var_12_3, {
		"view",
		"stage"
	}, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.map_stage

		setAnchoredPosition = var_2_10003

		var_2_10003(var_14_0, var_0_2[arg_14_1])

		return
	end)

	local var_12_4 = {
		"cakeshop",
		"shujvhuigu"
	}

	table = var_12_3

	var_12_3.insertto(var_12_4, var_12_1)

	ipairs = var_3

	for iter_12_2, iter_12_3 in var_3(var_12_4) do
		local var_12_5 = arg_12_0.Respones

		var_8.AddRawListener(var_12_5, {
			"view",
			iter_12_3 .. "Tip"
		}, function(arg_15_0, arg_15_1)
			if arg_15_0["upper_" .. iter_12_3] then
				IsNil = var_3

				if var_3(var_2:Find("Tip")) then
					return
				end

				setActive = var_3

				var_3(var_2:Find("Tip"), arg_15_1)

				return
			end
		end)
	end

	arg_12_0.Respones.hubData = {}

	local var_12_6 = arg_12_0.Respones

	var_3.AddRawListener(var_12_6, {
		"view",
		"hubData"
	}, function(arg_16_0, arg_16_1)
		arg_16_0.gameCountTxt.text = "X " .. arg_16_1.count

		return
	end, {
		strict = true
	})

	local var_12_7 = arg_12_0.Respones

	var_3.AddRawListener(var_12_7, {
		"view",
		"materialCount"
	}, function(arg_17_0, arg_17_1)
		arg_17_0.materialTxt.text = arg_17_1

		return
	end)

	return
end

function var_0_1.UpdateView(arg_18_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_18_0 = var_1_10001(var_1_10002)
	local var_18_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_18_2 = var_18_1(var_18_0, var_1_10003.ACTIVITY_TYPE_BUILDING_BUFF)

	pairs = var_18_0

	for iter_18_0, iter_18_1 in var_18_0(arg_18_0.Buildings) do
		local var_18_3 = arg_18_0.Respones
		local var_18_4

		if not var_18_2.data1KeyValueList[2][iter_18_0] then
			var_18_4 = 1
		end

		var_18_3[iter_18_1] = var_18_4
		arg_18_0.Respones[iter_18_1 .. "Tip"] = arg_18_0:UpdateBuildingTip(var_18_2, iter_18_0)
	end

	_ = var_2

	local var_18_5 = var_2.all

	_ = var_3

	local var_18_6 = var_18_5(var_3.keys(arg_18_0.Buildings), function(arg_19_0)
		local var_19_0

		if not var_18_2.data1KeyValueList[2][arg_19_0] then
			var_19_0 = 1
		end

		pg = var_2_10002

		return var_2_10002.activity_event_building[arg_19_0] and var_19_0 >= #var_2.buff
	end)

	setActive = var_3

	var_3(arg_18_0.map_Decoration, var_18_6)

	next = var_3

	local var_18_7 = var_3(var_18_2.data1KeyValueList[1])
	local var_18_8 = arg_18_0.Respones
	local var_18_9

	if not var_18_2.data1KeyValueList[1][var_18_7] then
		var_18_9 = 0
	end

	var_18_8.materialCount = var_18_9

	local function var_18_10()
		BackHillTemplate = var_2_10000

		local var_20_0 = var_2_10000.IsMiniActNeedTip

		ActivityConst = var_2_10001

		return var_20_0(var_2_10001.MINIGAME_CAKEMAKING)
	end

	local var_18_11 = arg_18_0.Respones

	tobool = iter_18_1
	var_18_11.cakeshopTip = iter_18_1(var_18_10())
	getProxy = var_18_11
	ActivityProxy = var_6

	local var_18_12 = var_18_11(var_6)
	local var_18_13 = var_5.getActivityById

	ActivityConst = var_7

	local var_18_14 = var_18_13(var_18_12, var_7.MINIGAME_CAKEMAKING)

	getProxy = var_18_12
	MiniGameProxy = var_7

	local var_18_15 = var_18_12(var_7)
	local var_18_16 = var_6.GetHubByHubId(var_18_15, var_18_14:getConfig("config_id"))

	arg_18_0:UpdateHubData(var_18_16)

	local function var_18_17()
		PLATFORM_CODE = var_2_10000
		PLATFORM_JP = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			return
		end

		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_21_0 = var_2_10000(var_2_10001)
		local var_21_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_21_2 = var_21_1(var_21_0, var_2_10002.ACTIVITY_TYPE_SUMMARY)

		Activity = var_21_0

		return var_21_0.IsActivityReady(var_21_2)
	end

	local var_18_18 = arg_18_0.Respones

	tobool = var_9
	var_18_18.shujvhuiguTip = var_9(var_18_17())

	return
end

function var_0_1.UpdateHubData(arg_22_0, arg_22_1)
	arg_22_0.Respones.hubData.count = arg_22_1.count
	arg_22_0.Respones.hubData.usedtime = arg_22_1.usedtime
	arg_22_0.Respones.hubData.id = arg_22_1.id

	local var_22_0 = arg_22_0.Respones

	var_2.PropertyChange(var_22_0, "hubData")

	return
end

function var_0_1.IsShowMainTip(arg_23_0)
	local function var_23_0()
		BackHillTemplate = var_2_10000

		local var_24_0 = var_2_10000.IsMiniActNeedTip

		ActivityConst = var_2_10001

		return var_24_0(var_2_10001.MINIGAME_CAKEMAKING)
	end

	local function var_23_1()
		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_25_0 = var_2_10000(var_2_10001)
		local var_25_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_25_2 = var_25_1(var_25_0, var_2_10002.ACTIVITY_TYPE_BUILDING_BUFF)

		Activity = var_25_0

		return var_25_0.IsActivityReady(var_25_2)
	end

	local function var_23_2()
		PLATFORM_CODE = var_2_10000
		PLATFORM_JP = var_2_10001

		if var_2_10000 ~= var_2_10001 then
			return
		end

		getProxy = var_2_10000
		ActivityProxy = var_2_10001

		local var_26_0 = var_2_10000(var_2_10001)
		local var_26_1 = var_0.getActivityByType

		ActivityConst = var_2_10002

		local var_26_2 = var_26_1(var_26_0, var_2_10002.ACTIVITY_TYPE_SUMMARY)

		Activity = var_26_0

		return var_26_0.IsActivityReady(var_26_2)
	end

	local var_23_3

	if not var_23_0() and not var_23_1() then
		var_23_3 = var_23_2()
	end

	return var_23_3
end

function var_0_1.willExit(arg_27_0)
	arg_27_0:clearStudents()
	var_0_1.super.willExit(arg_27_0)

	return
end

return var_0_1
