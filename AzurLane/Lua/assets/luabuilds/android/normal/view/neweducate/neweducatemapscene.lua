class = var_0_10000

local var_0_0 = "NewEducateMapScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.newEducate.base.NewEducateBaseUI"))

var_0_1.DEFAULT_SCALE = 1
var_0_1.SCALE = 1.15
var_0_1.SPEED = 65
var_0_1.ALPHA_TIME = 0.25

function var_0_1.getUIName(arg_1_0)
	return "NewEducateMapUI"
end

function var_0_1.SetData(arg_2_0)
	local var_2_0 = arg_2_0.contextData.char
	local var_2_1 = var_1.GetSiteId

	NewEducateConst = var_1_10003
	arg_2_0.shopSiteId = var_2_1(var_2_0, var_1_10003.SITE_TYPE.SHOP)

	local var_2_2 = arg_2_0.contextData.char
	local var_2_3 = var_1.GetSiteId

	NewEducateConst = var_3
	arg_2_0.workSiteId = var_2_3(var_2_2, var_3.SITE_TYPE.WORK)

	local var_2_4 = arg_2_0.contextData.char
	local var_2_5 = var_1.GetSiteId

	NewEducateConst = var_3
	arg_2_0.travelSiteId = var_2_5(var_2_4, var_3.SITE_TYPE.TRAVEL)

	return
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.uiTF = var_1.Find(var_3_0, "ui")

	local var_3_1 = arg_3_0._tf

	arg_3_0.mapTF = var_1.Find(var_3_1, "map")
	setLocalScale = var_1

	var_1(arg_3_0.mapTF, {
		x = var_0_1.DEFAULT_SCALE,
		y = var_0_1.DEFAULT_SCALE,
		z = var_0_1.DEFAULT_SCALE
	})

	local var_3_2 = arg_3_0.mapTF

	arg_3_0.travelTF = var_1.Find(var_3_2, "content/travel")

	local var_3_3 = arg_3_0.mapTF

	arg_3_0.workTF = var_1.Find(var_3_3, "content/work")

	local var_3_4 = arg_3_0.mapTF

	arg_3_0.shopTF = var_1.Find(var_3_4, "content/shop")

	local var_3_5 = arg_3_0.mapTF
	local var_3_6 = var_1.Find(var_3_5, "content/events")

	UIItemList = var_3_5
	arg_3_0.eventUIList = var_3_5.New(var_3_6, var_3_6:Find("tpl"))

	local var_3_7 = arg_3_0.mapTF
	local var_3_8 = var_2.Find(var_3_7, "content/ships")

	UIItemList = var_3_7
	arg_3_0.shipUIList = var_3_7.New(var_3_8, var_3_8:Find("tpl"))
	NewEducatePersonalityTipPanel = var_3
	arg_3_0.personalityTipPanel = var_3.New(arg_3_0.adaptTF, arg_3_0.event, arg_3_0.contextData)

	local var_3_9 = arg_3_0.personalityTipPanel

	var_3.RegisterView(var_3_9, arg_3_0)

	NewEducateTopPanel = var_3

	local var_3_10 = var_3.New
	local var_3_11 = arg_3_0.uiTF
	local var_3_12 = arg_3_0.event

	setmetatable = var_6
	arg_3_0.topPanel = var_3_10(var_3_11, var_3_12, var_6({
		showBack = true
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_13 = arg_3_0.topPanel

	var_3.RegisterView(var_3_13, arg_3_0)

	NewEducateInfoPanel = var_3

	local var_3_14 = var_3.New
	local var_3_15 = arg_3_0.uiTF
	local var_3_16 = arg_3_0.event

	setmetatable = var_6
	arg_3_0.infoPanel = var_3_14(var_3_15, var_3_16, var_6({
		hide = true
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_17 = arg_3_0.infoPanel

	var_3.RegisterView(var_3_17, arg_3_0)

	NewEducateSiteDetailPanel = var_3

	local var_3_18 = var_3.New
	local var_3_19 = arg_3_0.uiTF
	local var_3_20 = arg_3_0.event

	setmetatable = var_6
	arg_3_0.detailPanel = var_3_18(var_3_19, var_3_20, var_6({
		onHide = function()
			local var_4_0 = arg_3_0

			var_0.OnDetailHide(var_4_0)

			return
		end,
		onClickUpEntryGood = function(arg_5_0)
			local var_5_0 = arg_3_0

			var_1.onClickUpEntryGood(var_5_0, arg_5_0)

			return
		end
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_21 = arg_3_0.detailPanel

	var_3.RegisterView(var_3_21, arg_3_0)

	NewEducateNodePanel = var_3

	local var_3_22 = var_3.New
	local var_3_23 = arg_3_0.adaptTF
	local var_3_24 = arg_3_0.event

	setmetatable = var_6
	arg_3_0.nodePanel = var_3_22(var_3_23, var_3_24, var_6({
		onHide = function()
			local var_6_0 = arg_3_0

			var_0.OnDetailHide(var_6_0)

			local var_6_1 = arg_3_0

			var_0.FlushView(var_6_1)

			return
		end,
		onSiteEnd = function()
			local var_7_0 = arg_3_0

			var_0.ShowInfoUI(var_7_0, true)

			return
		end,
		onNormal = function()
			local var_8_0 = arg_3_0.infoPanel

			var_0.ExecuteAction(var_8_0, "HidePanel", true)

			local var_8_1 = arg_3_0.topPanel

			var_0.ExecuteAction(var_8_1, "Hide")

			return
		end,
		view = arg_3_0
	}, {
		__index = arg_3_0.contextData
	}))

	local var_3_25 = arg_3_0.nodePanel

	var_3.RegisterView(var_3_25, arg_3_0)

	Vector2 = var_3
	arg_3_0.extendLimit = var_3(arg_3_0.mapTF.rect.width - arg_3_0._tf.rect.width, arg_3_0.mapTF.rect.height - arg_3_0._tf.rect.height) / 2
	arg_3_0.duration = 0.5
	arg_3_0.curSiteId = 0
	getProxy = var_3
	PlayerProxy = var_4

	local var_3_26 = var_3(var_4)

	arg_3_0.playerID = var_3.getRawData(var_3_26).id

	return
end

function var_0_1.didEnter(arg_9_0)
	arg_9_0:SetData()

	local var_9_0 = arg_9_0.topPanel

	var_1.Load(var_9_0)

	local var_9_1 = arg_9_0.infoPanel

	var_1.Load(var_9_1)

	onButton = var_1

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.travelTF

	local function var_9_4()
		local var_10_0 = arg_9_0

		var_0.FocusTF(var_10_0, arg_9_0.travelTF)

		arg_9_0.curSiteId = arg_9_0.travelSiteId

		local var_10_1 = arg_9_0.detailPanel

		var_0.ExecuteAction(var_10_1, "Show", arg_9_0.travelSiteId)

		local var_10_2 = arg_9_0

		var_0.ShowInfoUI(var_10_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_9_2, var_9_3, var_9_4, var_1_10005)

	onButton = var_1

	local var_9_5 = arg_9_0
	local var_9_6 = arg_9_0.workTF

	local function var_9_7()
		local var_11_0 = arg_9_0

		var_0.FocusTF(var_11_0, arg_9_0.workTF)

		arg_9_0.curSiteId = arg_9_0.workSiteId

		local var_11_1 = arg_9_0.detailPanel

		var_0.ExecuteAction(var_11_1, "Show", arg_9_0.workSiteId)

		local var_11_2 = arg_9_0

		var_0.ShowInfoUI(var_11_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_9_5, var_9_6, var_9_7, var_1_10005)

	onButton = var_1

	local var_9_8 = arg_9_0
	local var_9_9 = arg_9_0.shopTF

	local function var_9_10()
		local var_12_0 = arg_9_0

		var_0.FocusTF(var_12_0, arg_9_0.shopTF)

		arg_9_0.curSiteId = arg_9_0.shopSiteId

		local var_12_1 = arg_9_0.detailPanel

		var_0.ExecuteAction(var_12_1, "Show", arg_9_0.shopSiteId)

		local var_12_2 = arg_9_0

		var_0.ShowInfoUI(var_12_2)

		local var_12_3 = arg_9_0.infoPanel

		var_0.ExecuteAction(var_12_3, "SetShopOpen", true)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_9_8, var_9_9, var_9_10, var_1_10005)

	local var_9_11 = arg_9_0.eventUIList

	var_1.make(var_9_11, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			arg_13_2.name = arg_9_0.eventSiteIds[arg_13_1 + 1]
			pg = var_4

			local var_13_0 = var_4.child2_site_display[var_3]

			LoadImageSpriteAsync = var_2_10005

			var_2_10005("neweducateicon/" .. var_13_0.event_icon, arg_13_2, true)

			LoadImageSpriteAsync = var_2_10005

			var_2_10005("neweducateicon/" .. var_13_0.event_title, arg_13_2:Find("name"), true)

			setAnchoredPosition = var_2_10005

			var_2_10005(arg_13_2, {
				x = var_13_0.position[1],
				y = var_13_0.position[2]
			})

			onButton = var_2_10005

			local var_13_1 = arg_9_0
			local var_13_2 = arg_13_2

			local function var_13_3()
				local var_14_0 = arg_9_0

				var_0.FocusTF(var_14_0, arg_13_2)

				arg_9_0.curSiteId = var_0

				local var_14_1 = arg_9_0.detailPanel

				var_0.ExecuteAction(var_14_1, "Show", var_0)

				local var_14_2 = arg_9_0

				var_0.ShowInfoUI(var_14_2)

				return
			end

			SFX_PANEL = var_9

			var_2_10005(var_13_1, var_13_2, var_13_3, var_9)
		end

		return
	end)

	local var_9_12 = arg_9_0.shipUIList

	var_1.make(var_9_12, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			local var_15_0 = arg_9_0

			var_3.UpdateShipSite(var_15_0, arg_15_1, arg_15_2)
		end

		return
	end)
	arg_9_0:FlushView()

	local var_9_13 = arg_9_0.contextData.char
	local var_9_14 = var_1.GetFSM(var_9_13)

	if var_1.GetCurNode(var_9_14) ~= 0 then
		local var_9_15 = arg_9_0.contextData.char
		local var_9_16 = var_1.GetFSM(var_9_15)
		local var_9_17 = var_1.GetState

		NewEducateFSM = var_3

		local var_9_18 = var_9_17(var_9_16, var_3.SYSTEM.MAP)

		arg_9_0.curSiteId = var_1.GetCurSiteId(var_9_18)

		arg_9_0:ShowInfoUI()

		local var_9_19 = arg_9_0
		local var_9_20 = arg_9_0.OnNodeStart
		local var_9_21 = arg_9_0.contextData.char
		local var_9_22 = var_3.GetFSM(var_9_21)

		var_9_20(var_9_19, var_3.GetCurNode(var_9_22))
	else
		arg_9_0:CheckEventPerformance()

		if arg_9_0.contextData.openShop then
			triggerButton = var_1

			var_1(arg_9_0.shopTF)
		end
	end

	return
end

function var_0_1.CheckEventPerformance(arg_16_0)
	local var_16_0 = {}

	ipairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.eventSiteIds) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.child2_site_display[iter_16_1].param
		pg = var_1_10008

		if #var_1_10008.child2_site_event_group[var_1_10007].performance > 0 then
			PlayerPrefs = var_9

			if var_9.GetInt(arg_16_0:GetEventLocalKey(var_1_10007)) ~= 1 then
				table = var_9

				var_9.insert(var_16_0, function(arg_17_0)
					local var_17_0 = arg_16_0.nodePanel

					var_1.ExecuteAction(var_17_0, "PlayWordIds", var_1_10008, arg_17_0)

					PlayerPrefs = var_1

					local var_17_1 = var_1.SetInt
					local var_17_2 = arg_16_0

					var_17_1(var_2.GetEventLocalKey(var_17_2, var_1_10007), 1)

					return
				end)
			end
		end
	end

	seriesAsync = var_2

	var_2(var_16_0, function()
		return
	end)

	return
end

function var_0_1.GetEventLocalKey(arg_19_0, arg_19_1)
	NewEducateConst = var_1_10002

	local var_19_0 = var_1_10002.NEW_EDUCATE_EVENT_TIP
	local var_19_1 = "_"
	local var_19_2 = arg_19_0.playerID
	local var_19_3 = "_"
	local var_19_4 = arg_19_0.contextData.char.id
	local var_19_5 = "_"
	local var_19_6 = arg_19_0.contextData.char

	return var_19_0 .. var_19_1 .. var_19_2 .. var_19_3 .. var_19_4 .. var_19_5 .. var_8.GetGameCnt(var_19_6) .. "_" .. arg_19_1
end

function var_0_1.ShowInfoUI(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0.infoPanel

	var_2.ExecuteAction(var_20_0, "ShowPanel")

	local var_20_1 = arg_20_0.topPanel

	var_2.ExecuteAction(var_20_1, "Flush")

	if arg_20_1 then
		return
	end

	arg_20_0.hideTFList = {}
	pg = var_2

	local var_20_2 = var_2.child2_site_display[arg_20_0.curSiteId].type

	NewEducateConst = var_3

	if var_20_2 ~= var_3.SITE_TYPE.WORK then
		table = var_3

		var_3.insert(arg_20_0.hideTFList, arg_20_0.workTF)
	end

	NewEducateConst = var_3

	if var_20_2 ~= var_3.SITE_TYPE.TRAVEL then
		table = var_3

		var_3.insert(arg_20_0.hideTFList, arg_20_0.travelTF)
	end

	NewEducateConst = var_3

	if var_20_2 ~= var_3.SITE_TYPE.SHOP then
		table = var_3

		var_3.insert(arg_20_0.hideTFList, arg_20_0.shopTF)
	end

	eachChild = var_3

	var_3(arg_20_0.eventUIList.container, function(arg_21_0)
		local var_21_0 = arg_20_0.curSiteId

		tonumber = var_2_10002

		if var_21_0 ~= var_2_10002(arg_21_0.name) then
			table = var_21_0

			var_21_0.insert(arg_20_0.hideTFList, arg_21_0)
		end

		return
	end)

	eachChild = var_3

	var_3(arg_20_0.shipUIList.container, function(arg_22_0)
		local var_22_0 = arg_20_0.curSiteId

		tonumber = var_2_10002

		if var_22_0 ~= var_2_10002(arg_22_0.name) then
			table = var_22_0

			var_22_0.insert(arg_20_0.hideTFList, arg_22_0)
		end

		return
	end)

	ipairs = var_3

	for iter_20_0, iter_20_1 in var_3(arg_20_0.hideTFList) do
		local var_20_3 = arg_20_0
		local var_20_4 = arg_20_0.managedTween

		LeanTween = var_1_10010
		var_1_10010 = var_1_10010.value

		local var_20_5

		go = var_1_10012

		local var_20_6 = var_20_4(var_20_3, var_1_10010, var_20_5, var_1_10012(iter_20_1), 1, 0, var_0_1.ALPHA_TIME)
		local var_20_7 = var_8.setOnUpdate

		System = var_1_10010

		var_20_7(var_20_6, var_1_10010.Action_float(function(arg_23_0)
			GetOrAddComponent = var_2_10001
			var_2_10001(iter_20_1, "CanvasGroup").alpha = arg_23_0

			return
		end))
	end

	return
end

function var_0_1.OnDetailHide(arg_24_0)
	local var_24_0 = arg_24_0.infoPanel

	var_1.ExecuteAction(var_24_0, "HidePanel")

	local var_24_1 = arg_24_0.infoPanel

	var_1.ExecuteAction(var_24_1, "SetShopOpen", false)

	local var_24_2 = arg_24_0.topPanel

	var_1.ExecuteAction(var_24_2, "Flush")

	local var_24_3 = arg_24_0.topPanel

	var_1.ExecuteAction(var_24_3, "Show")

	local var_24_4 = arg_24_0
	local var_24_5 = arg_24_0.managedTween

	LeanTween = var_3

	local var_24_6 = var_3.value
	local var_24_7

	go = var_1_10005

	local var_24_8 = var_24_5(var_24_4, var_24_6, var_24_7, var_1_10005(arg_24_0.mapTF), var_0_1.SCALE, var_0_1.DEFAULT_SCALE, arg_24_0.duration)
	local var_24_9 = var_1.setOnUpdate

	System = var_24_6

	var_24_9(var_24_8, var_24_6.Action_float(function(arg_25_0)
		setLocalScale = var_2_10001

		var_2_10001(arg_24_0.mapTF, {
			x = arg_25_0,
			y = arg_25_0,
			z = arg_25_0
		})

		return
	end))

	SetCompomentEnabled = var_24_9

	local var_24_10 = arg_24_0.mapTF

	typeof = var_3
	ScrollRect = var_4

	var_24_9(var_24_10, var_3(var_4), false)

	LeanTween = var_24_9

	local var_24_11 = var_24_9.move
	local var_24_12 = arg_24_0.mapTF

	Vector3 = var_3

	local var_24_13 = var_24_11(var_24_12, var_3(0, 0, 0), arg_24_0.duration)
	local var_24_14 = var_1.setEase

	LeanTweenType = var_3

	local var_24_15 = var_24_14(var_24_13, var_3.easeInOutSine)
	local var_24_16 = var_1.setOnComplete

	System = var_3
	arg_24_0.twFocusId = var_24_16(var_24_15, var_3.Action(function()
		setSizeDelta = var_2_10000

		local var_26_0 = arg_24_0.mapTF

		Vector2 = var_2_10002

		var_2_10000(var_26_0, var_2_10002(2400, 1478))

		SetCompomentEnabled = var_2_10000

		local var_26_1 = arg_24_0.mapTF

		typeof = var_2
		ScrollRect = var_3

		var_2_10000(var_26_1, var_2(var_3), true)

		return
	end)).uniqueId
	ipairs = var_1

	local var_24_17

	if not arg_24_0.hideTFList then
		var_24_17 = {}
	end

	for iter_24_0, iter_24_1 in var_1(var_24_17) do
		local var_24_18 = arg_24_0
		local var_24_19 = arg_24_0.managedTween

		LeanTween = var_24_20

		local var_24_20 = var_24_20.value
		local var_24_21

		go = var_1_10010

		local var_24_22 = var_24_19(var_24_18, var_24_20, var_24_21, var_1_10010(iter_24_1), 0, 1, var_0_1.ALPHA_TIME)
		local var_24_23 = var_6.setOnUpdate

		System = var_24_20

		var_24_23(var_24_22, var_24_20.Action_float(function(arg_27_0)
			GetOrAddComponent = var_2_10001
			var_2_10001(iter_24_1, "CanvasGroup").alpha = arg_27_0

			return
		end))
	end

	return
end

function var_0_1.onClickUpEntryGood(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0
	local var_28_1 = arg_28_0.emit
	local var_28_2 = var_0_1.GO_SUBLAYER

	Context = var_1_10005

	local var_28_3 = var_1_10005.New
	local var_28_4 = {}

	NewEducateTarotEntryMediator = var_1_10007
	var_28_4.mediator = var_1_10007
	NewEducateTarotEntryLayer = var_1_10007
	var_28_4.viewComponent = var_1_10007

	local var_28_5 = {
		goodId = arg_28_1.id
	}

	NewEducateTarotEntryLayer = var_8
	var_28_5.type = var_8.TYPE.SHOP
	var_28_5.cost = arg_28_1:getConfig("resource_num")
	var_28_4.data = var_28_5

	var_28_1(var_28_0, var_28_2, var_28_3(var_28_4))

	return
end

function var_0_1.FlushView(arg_29_0)
	local var_29_0 = arg_29_0.contextData.char
	local var_29_1 = var_1.GetFSM(var_29_0)
	local var_29_2 = var_1.GetState

	NewEducateFSM = var_1_10003

	local var_29_3 = var_29_2(var_29_1, var_1_10003.SYSTEM.MAP)

	underscore = var_29_1
	arg_29_0.eventSiteIds = var_29_1.map(var_29_3:GetEvents(), function(arg_30_0)
		local var_30_0 = arg_29_0.contextData.char
		local var_30_1 = var_1.GetSiteId

		NewEducateConst = var_2_10003

		return var_30_1(var_30_0, var_2_10003.SITE_TYPE.EVENT, arg_30_0)
	end)
	table = var_2

	local var_29_4 = var_2.sort
	local var_29_5 = arg_29_0.eventSiteIds

	CompareFuncs = var_4

	var_29_4(var_29_5, var_4({
		function(arg_31_0)
			pg = var_2_10001

			return var_2_10001.child2_site_display[arg_31_0].position[1]
		end
	}))

	local var_29_6 = arg_29_0.contextData.char
	local var_29_7 = var_2.GetShipIds(var_29_6)

	underscore = var_29_6

	local var_29_8 = var_29_6.select(var_29_7, function(arg_32_0)
		local var_32_0 = arg_29_0
		local var_32_2

		if not var_1.IsMaxShip(var_32_0, arg_32_0) then
			local var_32_1 = var_29_3

			var_32_2 = not var_1.IsSelectedShip(var_32_1, arg_32_0)
		else
			var_32_2 = false
		end

		if false then
			var_32_2 = true
		end

		return var_32_2
	end)

	underscore = var_3
	arg_29_0.shipSiteIds = var_3.map(var_29_8, function(arg_33_0)
		local var_33_0 = arg_29_0.contextData.char
		local var_33_1 = var_1.GetSiteId

		NewEducateConst = var_2_10003

		return var_33_1(var_33_0, var_2_10003.SITE_TYPE.SHIP, arg_33_0)
	end)

	local var_29_9 = arg_29_0.eventUIList

	var_3.align(var_29_9, #arg_29_0.eventSiteIds)

	local var_29_10 = arg_29_0.shipUIList

	var_3.align(var_29_10, #arg_29_0.shipSiteIds)
	arg_29_0:InitPermanentNodes()

	setActive = var_3

	local var_29_11 = arg_29_0.shopTF
	local var_29_12 = arg_29_0.contextData.char

	var_3(var_29_11, var_5.IsUnlock(var_29_12, "shop"))
	arg_29_0:CheckUpgradeNormalSite()

	return
end

function var_0_1.InitPermanentNodes(arg_34_0)
	if arg_34_0.travelSiteId then
		arg_34_0:InitPermanent(arg_34_0.travelSiteId, arg_34_0.travelTF)
	end

	if arg_34_0.workSiteId then
		arg_34_0:InitPermanent(arg_34_0.workSiteId, arg_34_0.workTF)
	end

	if arg_34_0.shopSiteId then
		arg_34_0:InitPermanent(arg_34_0.shopSiteId, arg_34_0.shopTF)
	end

	return
end

function var_0_1.InitPermanent(arg_35_0, arg_35_1, arg_35_2)
	pg = var_1_10003

	local var_35_0 = var_1_10003.child2_site_display[arg_35_1]

	LoadImageSpriteAsync = var_1_10004

	var_1_10004("neweducateicon/" .. var_35_0.event_icon, arg_35_2, true)

	LoadImageSpriteAsync = var_1_10004

	var_1_10004("neweducateicon/" .. var_35_0.event_title, arg_35_2:Find("name"), true)

	setAnchoredPosition = var_1_10004

	var_1_10004(arg_35_2, {
		x = var_35_0.position[1],
		y = var_35_0.position[2]
	})

	return
end

function var_0_1.IsMaxShip(arg_36_0, arg_36_1)
	pg = var_1_10002

	local var_36_0 = var_1_10002.child2_site_character[arg_36_1]

	pg = var_1_10003

	local var_36_1 = var_1_10003.child2_site_character.get_id_list_by_group[var_36_0.group]

	underscore = var_4

	return not var_4.detect(var_36_1, function(arg_37_0)
		pg = var_2_10001

		return var_2_10001.child2_site_character[arg_37_0].level == var_36_0.level + 1
	end)
end

function var_0_1.IsMaxNormal(arg_38_0, arg_38_1)
	pg = var_1_10002

	local var_38_0 = var_1_10002.child2_site_normal[arg_38_1]

	pg = var_1_10003

	local var_38_1 = var_1_10003.child2_site_normal.get_id_list_by_character[arg_38_0.contextData.char.id]

	underscore = var_4

	return not var_4.detect(var_38_1, function(arg_39_0)
		pg = var_2_10001

		return var_2_10001.child2_site_normal[arg_39_0].type == var_38_0.type and var_1.site_lv == var_38_0.site_lv + 1
	end)
end

function var_0_1.CheckUpgradeNormalSite(arg_40_0)
	local var_40_0 = {}

	pairs = var_1_10002
	NewEducateConst = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10002(var_1_10003.SITE_NORMAL_TYPE) do
		var_1_10008 = arg_40_0.contextData.char

		local var_40_1 = var_7.GetNormalIdByType(var_1_10008, iter_40_1)

		pg = var_1_10008
		var_1_10008 = var_1_10008.child2_site_normal[var_40_1].special_args

		local var_40_2 = arg_40_0.contextData.char
		local var_40_3 = var_9.IsMatchComplex(var_40_2, var_1_10008)

		if not arg_40_0:IsMaxNormal(var_40_1) and var_40_3 then
			table = var_10

			var_10.insert(var_40_0, var_40_1)
		end
	end

	local var_40_4 = #var_40_0

	if 0 < var_40_4 then
		local var_40_5 = {}

		ipairs = var_3

		for iter_40_2, iter_40_3 in var_3(var_40_0) do
			table = var_1_10008

			var_1_10008.insert(var_40_5, function(arg_41_0)
				local var_41_0 = arg_40_0
				local var_41_1 = var_1.emit

				NewEducateMapMediator = var_2_10003

				var_41_1(var_41_0, var_2_10003.ON_UPGRADE_NORMAL, iter_40_3, arg_41_0)

				return
			end)
		end

		seriesAsync = var_3

		var_3(var_40_5, function()
			local var_42_0 = arg_40_0.detailPanel

			if var_0.isShowing(var_42_0) then
				local var_42_1 = arg_40_0.detailPanel

				var_0.ExecuteAction(var_42_1, "Flush")
			end

			return
		end)
	end

	return
end

function var_0_1.UpdateShipSite(arg_43_0, arg_43_1, arg_43_2)
	arg_43_2.name = arg_43_0.shipSiteIds[arg_43_1 + 1]
	pg = var_4

	local var_43_0 = var_4.child2_site_display[var_3]
	local var_43_1 = arg_43_2
	local var_43_2 = arg_43_2.Find(var_43_1, "bottom/name_mask/name")

	setScrollText = var_43_1

	var_43_1(var_43_2, var_43_0.name)

	setAnchoredPosition = var_43_1

	var_43_1(arg_43_2, {
		x = var_43_0.position[1],
		y = var_43_0.position[2]
	})

	LoadImageSpriteAsync = var_43_1

	var_43_1("squareicon/" .. var_43_0.icon, arg_43_2:Find("top/mask/icon"), true)

	pg = var_43_1

	local var_43_3 = var_43_1.child2_site_character[var_43_0.param].level

	eachChild = var_7

	var_7(arg_43_2:Find("top/lv"), function(arg_44_0)
		setActive = var_2_10001

		local var_44_0 = arg_44_0

		tonumber = var_2_10003

		var_2_10001(var_44_0, var_2_10003(arg_44_0.name) <= var_43_3)

		return
	end)

	setActive = var_7

	var_7(arg_43_2:Find("top/red"), var_43_0.bg == "red")

	setActive = var_7

	var_7(arg_43_2:Find("top/blue"), var_43_0.bg == "blue")

	setActive = var_7

	var_7(arg_43_2:Find("bottom/red"), var_43_0.bg == "red")

	setActive = var_7

	var_7(arg_43_2:Find("bottom/blue"), var_43_0.bg == "blue")

	setActive = var_7

	var_7(arg_43_2:Find("bottom/grey"), false)

	onButton = var_7

	local var_43_4 = arg_43_0
	local var_43_5 = arg_43_2

	local function var_43_6()
		local var_45_0 = arg_43_0.contextData.char
		local var_45_1 = var_0.GetFSM(var_45_0)

		if var_0.CheckPriorityStystem(var_45_1) then
			pg = var_0

			local var_45_2 = var_0.TipsMgr.GetInstance()
			local var_45_3 = var_0.ShowTips

			i18n = var_2_10002

			var_45_3(var_45_2, var_2_10002("child2_priority_tip"))

			return
		end

		local var_45_4 = arg_43_0

		var_0.FocusTF(var_45_4, arg_43_2)

		arg_43_0.curSiteId = var_0

		local var_45_5 = arg_43_0.detailPanel

		var_0.ExecuteAction(var_45_5, "Show", var_0)

		local var_45_6 = arg_43_0

		var_0.ShowInfoUI(var_45_6)

		return
	end

	SFX_PANEL = var_1_10011

	var_7(var_43_4, var_43_5, var_43_6, var_1_10011)

	return
end

function var_0_1.UpdateShipLv(arg_46_0)
	eachChild = var_1_10001

	var_1_10001(arg_46_0.shipUIList.container, function(arg_47_0)
		tonumber = var_2_10001

		if var_2_10001(arg_47_0.name) == arg_46_0.curSiteId then
			pg = var_1

			local var_47_0 = var_1.child2_site_display[arg_46_0.curSiteId]

			pg = var_2

			local var_47_1 = var_2.child2_site_character[var_47_0.param].level + 1

			eachChild = var_3

			var_3(arg_47_0:Find("top/lv"), function(arg_48_0)
				setActive = var_3_10001

				local var_48_0 = arg_48_0

				tonumber = var_3_10003

				var_3_10001(var_48_0, var_3_10003(arg_48_0.name) <= var_47_1)

				return
			end)
		end

		return
	end)

	return
end

function var_0_1.OnShoppingDone(arg_49_0)
	local var_49_0 = arg_49_0.detailPanel

	var_1.ExecuteAction(var_49_0, "FlushShop")
	arg_49_0:emit(var_0_1.ON_PRIORITY_STATE)

	return
end

function var_0_1.OnRefreshShopDone(arg_50_0)
	local var_50_0 = arg_50_0.detailPanel

	var_1.ExecuteAction(var_50_0, "FlushShop")

	return
end

function var_0_1.OnResUpdate(arg_51_0)
	local var_51_0 = arg_51_0.topPanel

	var_1.ExecuteAction(var_51_0, "FlushRes")

	return
end

function var_0_1.OnAttrUpdate(arg_52_0)
	local var_52_0 = arg_52_0.infoPanel

	var_1.ExecuteAction(var_52_0, "FlushAttrs")

	local var_52_1 = arg_52_0.topPanel

	var_1.ExecuteAction(var_52_1, "FlushProgress")

	return
end

function var_0_1.OnPersonalityUpdate(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.personalityTipPanel

	var_3.ExecuteAction(var_53_0, "FlushPersonality", arg_53_1, arg_53_2)

	return
end

function var_0_1.OnTalentUpdate(arg_54_0)
	local var_54_0 = arg_54_0.infoPanel

	var_1.ExecuteAction(var_54_0, "FlushTalents")

	return
end

function var_0_1.OnStatusUpdate(arg_55_0)
	local var_55_0 = arg_55_0.infoPanel

	var_1.ExecuteAction(var_55_0, "FlushStatus")

	return
end

function var_0_1.OnTarotUpdate(arg_56_0)
	local var_56_0 = arg_56_0.infoPanel

	var_1.ExecuteAction(var_56_0, "FlushTarot")

	return
end

function var_0_1.OnNodeStart(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.nodePanel

	var_2.ExecuteAction(var_57_0, "StartNode", arg_57_1)

	return
end

function var_0_1.OnNextNode(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0.nodePanel

	var_2.ExecuteAction(var_58_0, "ProceedNode", arg_58_1.node, arg_58_1.drop, arg_58_1.noNextCb)

	return
end

function var_0_1.FocusTF(arg_59_0, arg_59_1, arg_59_2)
	setSizeDelta = var_1_10003

	local var_59_0 = arg_59_0.mapTF

	Vector2 = var_1_10005

	var_1_10003(var_59_0, var_1_10005(3280, 2038))

	Vector2 = var_1_10003
	arg_59_0.extendLimit = var_1_10003(arg_59_0.mapTF.rect.width * var_0_1.SCALE - arg_59_0._tf.rect.width, arg_59_0.mapTF.rect.height * var_0_1.SCALE - arg_59_0._tf.rect.height) / 2

	local var_59_1 = arg_59_1.anchoredPosition * -1

	math = var_4
	var_59_1.x = var_4.clamp(var_59_1.x, -arg_59_0.extendLimit.x, arg_59_0.extendLimit.x) * var_0_1.SCALE
	math = var_4
	var_59_1.y = var_4.clamp(var_59_1.y, -arg_59_0.extendLimit.y, arg_59_0.extendLimit.y) * var_0_1.SCALE

	if arg_59_0.twFocusId then
		LeanTween = var_4

		var_4.cancel(arg_59_0.twFocusId)

		arg_59_0.twFocusId = nil
	end

	local var_59_2 = {}

	table = var_5

	var_5.insert(var_59_2, function(arg_60_0)
		SetCompomentEnabled = var_2_10001

		local var_60_0 = arg_59_0.mapTF

		typeof = var_2_10003
		ScrollRect = var_2_10004

		var_2_10001(var_60_0, var_2_10003(var_2_10004), false)

		local var_60_1 = (arg_59_0.mapTF.anchoredPosition - var_59_1).magnitude
		local var_60_2 = arg_59_0

		if var_60_1 > 0 then
			local var_60_3 = var_0_1.SPEED

			math = var_4

			local var_60_4

			if not (var_60_1 / (var_60_3 * var_4.sqrt(var_60_1))) then
				var_60_4 = 0
			end

			var_60_2.duration = var_60_4

			local var_60_5 = arg_59_0
			local var_60_6 = var_2.managedTween

			LeanTween = var_4

			local var_60_7 = var_4.value
			local var_60_8

			go = var_2_10006

			local var_60_9 = var_60_6(var_60_5, var_60_7, var_60_8, var_2_10006(arg_59_0.mapTF), var_0_1.DEFAULT_SCALE, var_0_1.SCALE, arg_59_0.duration)
			local var_60_10 = var_2.setOnUpdate

			System = var_60_7

			var_60_10(var_60_9, var_60_7.Action_float(function(arg_61_0)
				setLocalScale = var_3_10001

				var_3_10001(arg_59_0.mapTF, {
					x = arg_61_0,
					y = arg_61_0,
					z = arg_61_0
				})

				return
			end))

			local var_60_11 = arg_59_0

			LeanTween = var_60_9

			local var_60_12 = var_60_9.move
			local var_60_13 = arg_59_0.mapTF

			Vector3 = var_5

			local var_60_14 = var_60_12(var_60_13, var_5(var_59_1.x, var_59_1.y, 0), arg_59_0.duration)
			local var_60_15 = var_3.setEase

			LeanTweenType = var_5

			local var_60_16 = var_60_15(var_60_14, var_5.easeInOutSine)
			local var_60_17 = var_3.setOnComplete

			System = var_5
			var_60_11.twFocusId = var_60_17(var_60_16, var_5.Action(arg_60_0)).uniqueId

			return
		end
	end)

	seriesAsync = var_5

	var_5(var_59_2, function()
		SetCompomentEnabled = var_2_10000

		local var_62_0 = arg_59_0.mapTF

		typeof = var_2_10002
		ScrollRect = var_2_10003

		var_2_10000(var_62_0, var_2_10002(var_2_10003), true)

		if arg_59_2 then
			arg_59_2()
		end

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_63_0)
	local var_63_0 = arg_63_0.nodePanel

	if var_1.isShowing(var_63_0) then
		return
	end

	local var_63_1 = arg_63_0.detailPanel

	if var_1.isShowing(var_63_1) then
		local var_63_2 = arg_63_0.detailPanel

		var_1.Hide(var_63_2)
	else
		arg_63_0.super.onBackPressed(arg_63_0)
	end

	return
end

function var_0_1.willExit(arg_64_0)
	if arg_64_0.topPanel then
		local var_64_0 = arg_64_0.topPanel

		var_1.Destroy(var_64_0)

		arg_64_0.topPanel = nil
	end

	if arg_64_0.infoPanel then
		local var_64_1 = arg_64_0.infoPanel

		var_1.Destroy(var_64_1)

		arg_64_0.infoPanel = nil
	end

	if arg_64_0.detailPanel then
		local var_64_2 = arg_64_0.detailPanel

		var_1.Destroy(var_64_2)

		arg_64_0.detailPanel = nil
	end

	if arg_64_0.personalityTipPanel then
		local var_64_3 = arg_64_0.personalityTipPanel

		var_1.Destroy(var_64_3)

		arg_64_0.personalityTipPanel = nil
	end

	if arg_64_0.nodePanel then
		local var_64_4 = arg_64_0.nodePanel

		var_1.Destroy(var_64_4)

		arg_64_0.nodePanel = nil
	end

	return
end

return var_0_1
