class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

var_0_1.optionsPath = {
	"top/btn_home"
}
var_0_1.SHOP = "SixthAnniversaryIslandScene.SHOP"

function var_0_1.getUIName(arg_1_0)
	return "SixthAnniversaryIslandUI"
end

function var_0_1.setActivity(arg_2_0, arg_2_1)
	arg_2_0.activity = arg_2_1

	return
end

function var_0_1.setNodeIds(arg_3_0, arg_3_1)
	arg_3_0.ids = arg_3_1

	return
end

function var_0_1.setPlayer(arg_4_0, arg_4_1)
	arg_4_0.player = arg_4_1
	setText = var_1_10002

	local var_4_0 = arg_4_0.rtResPanel
	local var_4_1 = var_4.Find(var_4_0, "tpl/Text")
	local var_4_2 = arg_4_0.player
	local var_4_3

	if not var_5.getResById(var_4_2, 350) then
		var_4_3 = 0
	end

	var_1_10002(var_4_1, var_4_3)

	return
end

function var_0_1.setResDrop(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.resDrop = arg_5_1
	arg_5_0.resDailyNumber = arg_5_2
	setText = var_1_10003

	local var_5_0 = arg_5_0.rtResPanel
	local var_5_1 = var_5.Find(var_5_0, "tpl_2/Text")
	local var_5_2

	if not arg_5_1.count then
		var_5_2 = 0
	end

	var_1_10003(var_5_1, var_5_2)

	return
end

function var_0_1.init(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.rtTop = var_1.Find(var_6_0, "top")
	pg = var_1

	local var_6_1 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_6_1, arg_6_0.rtTop)

	arg_6_0.effectObjs = {}
	getProxy = var_1
	SixthAnniversaryIslandProxy = var_6_1
	arg_6_0.proxy = var_1(var_6_1)
	pg = var_1

	local var_6_2 = var_1.TimeMgr.GetInstance()
	local var_6_3 = arg_6_0._tf
	local var_6_4 = var_2.Find(var_6_3, "map/content")

	UIItemList = var_6_1
	arg_6_0.nodeItemList = var_6_1.New(var_6_4, var_6_4:Find("node"))

	local var_6_5 = arg_6_0.nodeItemList

	var_3.make(var_6_5, function(arg_7_0, arg_7_1, arg_7_2)
		arg_7_1 = arg_7_1 + 1
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_0.ids[arg_7_1]
			local var_7_1 = arg_6_0.proxy

			arg_7_2.name = var_4.GetNode(var_7_1, var_7_0).id
			unpack = var_5

			local var_7_2, var_7_3 = var_5(var_4:getConfig("address"))

			setAnchoredPosition = var_7

			var_7(arg_7_2, {
				x = var_7_2,
				y = var_7_3
			})

			local var_7_4 = var_4:getConfig("type")

			eachChild = var_2_10008

			var_2_10008(arg_7_2:Find("main/type"), function(arg_8_0)
				setActive = var_3_10001

				local var_8_0 = arg_8_0
				local var_8_1 = arg_8_0.name

				tostring = var_3_10005

				var_3_10001(var_8_0, var_8_1 == var_3_10005(var_7_4))

				return
			end)

			setLocalScale = var_2_10008

			local var_7_5 = arg_7_2

			Vector3 = var_11

			var_2_10008(var_7_5, var_11(0, 0, 1))

			setActive = var_2_10008

			var_2_10008(arg_7_2:Find("name"), var_4:getConfig("icon_name") ~= "")

			onToggle = var_2_10008

			var_2_10008(arg_6_0, arg_7_2, function(arg_9_0)
				if arg_9_0 then
					arg_6_0.selectId = var_7_0
					arg_6_0.contextData.lastNodeId = var_7_0
				end

				return
			end)

			setActive = var_2_10008

			var_2_10008(arg_7_2:Find("click"), true)

			onButton = var_2_10008

			local var_7_6 = arg_6_0
			local var_7_7 = arg_7_2
			local var_7_8 = arg_7_2.Find(var_7_7, "click")

			local function var_7_9()
				local var_10_0 = arg_6_0.proxy
				local var_10_1 = var_0.GetNode(var_10_0, var_7_0)

				triggerToggle = var_3_10001

				var_3_10001(arg_7_2, var_10_1:CanToggleOn())

				if var_10_1:CanTrigger() then
					arg_6_0.isAutoPlayStory = false

					local var_10_2 = arg_6_0

					var_1.triggerNode(var_10_2, var_7_0)
				elseif var_10_1:IsRefresh() and var_10_1:IsCompleted() then
					local var_10_3 = var_6_2
					local var_10_4 = var_1.GetNextTime(var_10_3, 0, 0, 0)
					local var_10_5 = var_6_2
					local var_10_6 = var_10_4 - var_2.GetServerTime(var_10_5)
					local var_10_7 = 3
					local var_10_8

					Timer = var_10_5

					var_10_5.New(function()
						if arg_6_0.exited then
							local var_11_0 = var_10_8

							var_0.Stop(var_11_0)

							var_10_8 = nil
						end

						if var_10_7 == 0 then
							setActive = var_0

							local var_11_1 = arg_7_2

							var_0(var_2.Find(var_11_1, "main/time"), false)
						else
							setText = var_0

							local var_11_2 = arg_7_2
							local var_11_3 = var_2.Find(var_11_2, "main/time/Text")

							i18n = var_4_10003

							local var_11_4 = var_4_10003("islandnode_tips1")
							local var_11_5 = var_6_2

							var_0(var_11_3, var_11_4 .. var_4.DescCDTime(var_11_5, var_10_6))

							var_10_6 = var_10_6 - 1
							var_10_7 = var_10_7 - 1
						end

						return
					end, 1, 3).func()
					var_10_8:Start()

					setActive = var_4

					local var_10_9 = arg_7_2

					var_4(var_6.Find(var_10_9, "main/time"), true)
				end

				return
			end

			SFX_CONFIRM = var_7_7

			var_2_10008(var_7_6, var_7_8, var_7_9, var_7_7)

			local var_7_10 = arg_6_0

			var_8.refreshNode(var_7_10, var_7_0)
		end

		return
	end)

	local var_6_6 = arg_6_0.rtTop
	local var_6_7 = var_3.Find(var_6_6, "panel/content/mask/scroll_rect")

	UIItemList = var_6_3
	arg_6_0.panelItemList = var_6_3.New(var_6_7, var_6_7:Find("tpl"))

	local var_6_8 = arg_6_0.panelItemList

	var_4.make(var_6_8, function(arg_12_0, arg_12_1, arg_12_2)
		arg_12_1 = arg_12_1 + 1
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_6_0.proxy

			arg_12_2.name = var_3.GetNode(var_12_0, arg_6_0.dailyIds[arg_12_1]).id
			GetImageSpriteFromAtlasAsync = var_4

			var_4("ui/sixthanniversaryislandui_atlas", var_3:getConfig("icon"), arg_12_2:Find("Image"))

			setActive = var_4

			local var_12_1 = arg_12_2:Find("mask")
			local var_12_2 = var_3

			var_4(var_12_1, not var_3.RedDotHint(var_12_2))

			onButton = var_4

			local var_12_3 = arg_6_0
			local var_12_4 = arg_12_2

			local function var_12_5()
				local var_13_0 = arg_6_0
				local var_13_1 = var_0.focus
				local var_13_2 = var_0.id

				LeanTweenType = var_3_10004

				var_13_1(var_13_0, var_13_2, var_3_10004.easeInOutSine)

				return
			end

			SFX_PANEL = var_12_2

			var_4(var_12_3, var_12_4, var_12_5, var_12_2)
		end

		return
	end)

	triggerToggle = var_4

	local var_6_9 = arg_6_0.rtTop

	var_4(var_6.Find(var_6_9, "panel/toggle"), false)

	local var_6_10 = arg_6_0._tf
	local var_6_11 = var_4.Find(var_6_10, "top/focus")

	UIItemList = var_6_6

	local var_6_12 = var_6_6.New
	local var_6_13 = var_6_11
	local var_6_14 = var_6_11

	arg_6_0.floatItemList = var_6_12(var_6_13, var_6_11.Find(var_6_14, "main_mark"))

	local var_6_15 = arg_6_0.floatItemList

	var_5.make(var_6_15, function(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1 = arg_14_1 + 1
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventUpdate then
			arg_14_2.name = arg_6_0.mainIds[arg_14_1]
			onButton = var_3

			local var_14_0 = arg_6_0
			local var_14_1 = arg_14_2

			local function var_14_2()
				local var_15_0 = arg_6_0
				local var_15_1 = var_0.focus
				local var_15_2 = arg_6_0.mainIds[arg_14_1]

				LeanTweenType = var_4

				var_15_1(var_15_0, var_15_2, var_4.easeInOutSine)

				return
			end

			SFX_PANEL = var_2_10008

			var_3(var_14_0, var_14_1, var_14_2, var_2_10008)
		end

		return
	end)

	local var_6_16 = arg_6_0.rtTop

	arg_6_0.rtResPanel = var_5.Find(var_6_16, "res")

	local var_6_17 = arg_6_0._tf

	arg_6_0.rtMap = var_5.Find(var_6_17, "map")

	local var_6_18 = arg_6_0.rtMap
	local var_6_19 = var_5.GetComponent

	typeof = var_8
	ScrollRect = var_6_14

	local var_6_20 = var_6_19(var_6_18, var_8(var_6_14)).onValueChanged

	var_5.AddListener(var_6_20, function()
		local var_16_0 = arg_6_0

		var_0.onDragFunction(var_16_0)

		return
	end)

	getSizeRate = var_5

	local var_6_21, var_6_22, var_6_23 = var_5()

	Vector2 = var_8
	arg_6_0.delta = var_8(var_6_22 - 100, var_6_23 - 100) / 2
	Vector2 = var_8
	arg_6_0.extendLimit = var_8(arg_6_0.rtMap.rect.width - arg_6_0._tf.rect.width, arg_6_0.rtMap.rect.height - arg_6_0._tf.rect.height) / 2
	arg_6_0.displayDic = {}
	onButton = var_8

	local var_6_24 = arg_6_0
	local var_6_25 = arg_6_0.rtTop
	local var_6_26 = var_11.Find(var_6_25, "btn_back")

	local function var_6_27()
		local var_17_0 = arg_6_0

		var_0.closeView(var_17_0)

		return
	end

	SFX_CANCEL = var_6_25

	var_8(var_6_24, var_6_26, var_6_27, var_6_25)

	setActive = var_8

	local var_6_28 = arg_6_0.rtTop

	var_8(var_10.Find(var_6_28, "btn_now"), false)

	onButton = var_8

	local var_6_29 = arg_6_0
	local var_6_30 = arg_6_0.rtTop
	local var_6_31 = var_11.Find(var_6_30, "btns/btn_shop")

	local function var_6_32()
		local var_18_0 = arg_6_0
		local var_18_1 = var_0.emit

		SixthAnniversaryIslandMediator = var_2_10003

		var_18_1(var_18_0, var_2_10003.GO_SHOP)

		return
	end

	SFX_PANEL = var_6_30

	var_8(var_6_29, var_6_31, var_6_32, var_6_30)

	onButton = var_8

	local var_6_33 = arg_6_0
	local var_6_34 = arg_6_0.rtTop
	local var_6_35 = var_11.Find(var_6_34, "btns/btn_note")

	local function var_6_36()
		local var_19_0 = arg_6_0
		local var_19_1 = var_0.emit

		SixthAnniversaryIslandMediator = var_2_10003

		var_19_1(var_19_0, var_2_10003.OPEN_NOTE)

		return
	end

	SFX_PANEL = var_6_34

	var_8(var_6_33, var_6_35, var_6_36, var_6_34)

	onButton = var_8

	local var_6_37 = arg_6_0
	local var_6_38 = arg_6_0.rtTop
	local var_6_39 = var_11.Find(var_6_38, "btns/btn_help")

	local function var_6_40()
		pg = var_2_10000

		local var_20_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_20_1 = var_0.ShowMsgBox
		local var_20_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_20_2.type = var_2_10004
		i18n = var_2_10004
		var_20_2.helps = var_2_10004("island_help")

		var_20_1(var_20_0, var_20_2)

		return
	end

	SFX_PANEL = var_6_38

	var_8(var_6_37, var_6_39, var_6_40, var_6_38)

	onButton = var_8

	local var_6_41 = arg_6_0
	local var_6_42 = arg_6_0.rtResPanel
	local var_6_43 = var_11.Find(var_6_42, "tpl")

	local function var_6_44()
		local var_21_0 = arg_6_0
		local var_21_1 = var_0.emit

		SixthAnniversaryIslandMediator = var_2_10003

		var_21_1(var_21_0, var_2_10003.OPEN_RES, {
			id = 350,
			type = 1
		}, "")

		return
	end

	SFX_PANEL = var_6_42

	var_8(var_6_41, var_6_43, var_6_44, var_6_42)

	onButton = var_8

	local var_6_45 = arg_6_0
	local var_6_46 = arg_6_0.rtResPanel
	local var_6_47 = var_11.Find(var_6_46, "tpl_2")

	local function var_6_48()
		local var_22_0 = arg_6_0
		local var_22_1 = var_0.emit

		SixthAnniversaryIslandMediator = var_2_10003

		local var_22_2 = var_2_10003.OPEN_RES

		Clone = var_2_10004

		local var_22_3 = var_2_10004(arg_6_0.resDrop)

		i18n = var_2_10005

		var_22_1(var_22_0, var_22_2, var_22_3, var_2_10005("island_game_limit_help", arg_6_0.resDailyNumber))

		return
	end

	SFX_PANEL = var_6_46

	var_8(var_6_45, var_6_47, var_6_48, var_6_46)

	return
end

function var_0_1.onDragFunction(arg_23_0)
	local var_23_0

	if not var_0_1.screenPoints then
		var_23_0 = var_0_1

		local var_23_1 = {}

		Vector2 = var_1_10003
		var_23_1[1] = var_1_10003(-arg_23_0.delta.x, arg_23_0.delta.y)
		Vector2 = var_3
		var_23_1[2] = var_3(arg_23_0.delta.x, arg_23_0.delta.y)
		Vector2 = var_3
		var_23_1[3] = var_3(arg_23_0.delta.x, -arg_23_0.delta.y)
		Vector2 = var_3
		var_23_1[4] = var_3(-arg_23_0.delta.x, -arg_23_0.delta.y)
		var_23_0.screenPoints = var_23_1
	end

	ipairs = var_23_0

	for iter_23_0, iter_23_1 in var_23_0(arg_23_0.mainIds) do
		local var_23_2 = arg_23_0.nodeItemList.container
		local var_23_3 = var_6.Find(var_23_2, iter_23_1)
		local var_23_4 = arg_23_0._tf
		local var_23_5 = var_7.InverseTransformPoint(var_23_4, var_23_3.position)
		local var_23_6

		ipairs = var_23_4

		for iter_23_2, iter_23_3 in var_23_4(var_0_1.screenPoints) do
			local var_23_7 = var_0_1.screenPoints[iter_23_2 % 4 + 1]

			LineLine = var_1_10015
			Vector2 = var_1_10017
			var_1_10017 = var_1_10017.zero
			Vector2 = var_1_10018

			local var_23_8

			var_1_10015, var_23_8, var_1_10017 = var_1_10015(var_1_10017, var_1_10018(var_23_5.x, var_23_5.y), iter_23_3, var_23_7)

			if var_1_10015 then
				var_23_6 = var_23_5 * var_23_8

				break
			end
		end

		local var_23_9 = arg_23_0.floatItemList.container
		local var_23_10 = var_9.Find(var_23_9, iter_23_1)
		local var_23_11 = var_9.GetComponent

		typeof = iter_23_3
		CanvasGroup = var_1_10015

		local var_23_12 = var_23_11(var_23_10, iter_23_3(var_1_10015))

		tobool = var_23_9
		var_23_12.interactable = var_23_9(var_23_6)
		tobool = var_11
		var_23_12.blocksRaycasts = var_11(var_23_6)
		tobool = var_11
		var_23_12.alpha = var_11(var_23_6) and 1 or 0

		if var_23_6 then
			setAnchoredPosition = var_11

			var_11(var_9, var_23_6 * (1 - 50 / var_23_6:Magnitude()))

			math = var_11

			local var_23_13 = var_11.rad2Deg

			math = var_23_10

			local var_23_14 = var_23_13 * var_23_10.atan2(var_23_6.y, var_23_6.x) - 45

			setLocalEulerAngles = var_12

			var_12(var_9:Find("arrow"), {
				z = var_23_14
			})

			setLocalEulerAngles = var_12

			var_12(var_9:Find("arrow_shadow"), {
				z = var_23_14
			})
		end
	end

	return
end

function var_0_1.focus(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0.nodeItemList.container
	local var_24_1 = var_4.Find(var_24_0, arg_24_1)
	local var_24_2

	if not arg_24_3 then
		triggerToggle = var_1_10005
		var_24_2 = var_24_1

		local var_24_3 = arg_24_0.proxy
		local var_24_4 = var_8.GetNode(var_24_3, arg_24_1)

		var_1_10005(var_24_2, var_8.CanToggleOn(var_24_4))
	end

	local var_24_5 = var_24_1.anchoredPosition * -1

	math = var_24_0
	var_24_5.x = var_24_0.clamp(var_24_5.x, -arg_24_0.extendLimit.x, arg_24_0.extendLimit.x)
	math = var_6
	var_24_5.y = var_6.clamp(var_24_5.y, -arg_24_0.extendLimit.y, arg_24_0.extendLimit.y)

	if arg_24_0.twFocusId then
		LeanTween = var_6

		var_6.cancel(arg_24_0.twFocusId)

		arg_24_0.twFocusId = nil
	end

	if arg_24_2 then
		local var_24_6 = {}

		table = var_24_2

		var_24_2.insert(var_24_6, function(arg_25_0)
			SetCompomentEnabled = var_2_10001

			local var_25_0 = arg_24_0.rtMap

			typeof = var_2_10004
			ScrollRect = var_2_10006

			var_2_10001(var_25_0, var_2_10004(var_2_10006), false)

			local var_25_1 = (arg_24_0.rtMap.anchoredPosition - var_24_5).magnitude

			if 0 < var_25_1 then
				math = var_2

				local var_25_2

				if not (var_25_1 / (40 * var_2.sqrt(var_25_1))) then
					var_25_2 = 0
				end

				local var_25_3 = arg_24_0

				LeanTween = var_4

				local var_25_4 = var_4.move
				local var_25_5 = arg_24_0.rtMap

				Vector3 = var_2_10007

				local var_25_6 = var_25_4(var_25_5, var_2_10007(var_24_5.x, var_24_5.y), var_25_2)
				local var_25_7 = var_4.setEase(var_25_6, arg_24_2)
				local var_25_8 = var_4.setOnUpdate

				System = var_7

				local var_25_9 = var_25_8(var_25_7, var_7.Action_float(function(arg_26_0)
					local var_26_0 = arg_24_0

					var_1.onDragFunction(var_26_0)

					return
				end))
				local var_25_10 = var_4.setOnComplete

				System = var_7
				var_25_3.twFocusId = var_25_10(var_25_9, var_7.Action(arg_25_0)).uniqueId

				return
			end
		end)

		seriesAsync = var_7

		var_7(var_24_6, function()
			SetCompomentEnabled = var_2_10000

			local var_27_0 = arg_24_0.rtMap

			typeof = var_2_10003
			ScrollRect = var_2_10005

			var_2_10000(var_27_0, var_2_10003(var_2_10005), true)

			return
		end)
	else
		arg_24_0.rtMap.anchoredPosition = var_24_5

		arg_24_0:onDragFunction()
	end

	return
end

function var_0_1.triggerNode(arg_28_0, arg_28_1)
	getProxy = var_1_10002
	SixthAnniversaryIslandProxy = var_1_10004

	local var_28_0 = var_1_10002(var_1_10004)
	local var_28_1 = var_2.GetNode(var_28_0, arg_28_1)

	if var_2.IsNew(var_28_1) then
		local var_28_2 = arg_28_0
		local var_28_3 = arg_28_0.emit

		SixthAnniversaryIslandMediator = var_1_10006

		var_28_3(var_28_2, var_1_10006.MARK_NODE_AFTER_NEW, arg_28_1)
	end

	if var_2:IsCompleted() then
		if var_2:getConfig("type") == 5 then
			local var_28_4 = arg_28_0
			local var_28_5 = arg_28_0.emit

			SixthAnniversaryIslandMediator = var_6

			var_28_5(var_28_4, var_6.INTO_ENTRANCE, var_2:getConfig("params")[1])
		end
	else
		arg_28_0:triggerEvent(var_2)
	end

	return
end

function var_0_1.triggerEvent(arg_29_0, arg_29_1)
	assert = var_1_10002

	local var_29_0

	if arg_29_1.eventId then
		var_29_0 = arg_29_1.eventId ~= 0
	end

	var_1_10002(var_29_0)

	IslandEvent = var_1_10002

	local var_29_1 = var_1_10002.New({
		id = arg_29_1.eventId
	})

	switch = var_1_10003

	var_1_10003(var_29_1:getConfig("type"), {
		[3] = function()
			local var_30_0 = {}
			local var_30_1 = var_29_1

			if var_1.getConfig(var_30_1, "story") and var_1 ~= "" then
				table = var_2_10002

				var_2_10002.insert(var_30_0, function(arg_31_0)
					if arg_29_0.isAutoPlayStory then
						pg = var_1

						local var_31_0 = var_1.NewStoryMgr.GetInstance()

						var_1.ForceAutoPlay(var_31_0, var_0, arg_31_0)
					else
						pg = var_1

						local var_31_1 = var_1.NewStoryMgr.GetInstance()

						var_1.ForceManualPlay(var_31_1, var_0, arg_31_0)
					end

					return
				end)

				table = var_2_10002

				var_2_10002.insert(var_30_0, function(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
					arg_29_0.isAutoPlayStory = arg_32_3

					arg_32_0(arg_32_2)

					return
				end)
			end

			seriesAsync = var_2_10002

			var_2_10002(var_30_0, function(arg_33_0)
				local var_33_0 = arg_29_0
				local var_33_1 = var_1.emit

				SixthAnniversaryIslandMediator = var_3_10004

				local var_33_2 = var_3_10004.OPEN_QTE_GAME
				local var_33_3 = var_29_1

				var_33_1(var_33_0, var_33_2, var_5.getConfig(var_33_3, "params")[1], function(arg_34_0)
					local var_34_0 = arg_29_0
					local var_34_1 = var_1.emit

					SixthAnniversaryIslandMediator = var_4_10004

					var_34_1(var_34_0, var_4_10004.TRIGGER_NODE_EVENT, arg_29_1.id, arg_34_0 or 0)

					return
				end)

				return
			end)

			return
		end
	}, function()
		local var_35_0 = {}
		local var_35_1 = var_29_1

		if var_1.getConfig(var_35_1, "story") and var_1 ~= "" then
			table = var_2_10002

			var_2_10002.insert(var_35_0, function(arg_36_0)
				if arg_29_0.isAutoPlayStory then
					pg = var_1

					local var_36_0 = var_1.NewStoryMgr.GetInstance()

					var_1.ForceAutoPlay(var_36_0, var_0, arg_36_0, true)
				else
					pg = var_1

					local var_36_1 = var_1.NewStoryMgr.GetInstance()

					var_1.ForceManualPlay(var_36_1, var_0, arg_36_0, true)
				end

				return
			end)

			table = var_2_10002

			var_2_10002.insert(var_35_0, function(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
				arg_29_0.isAutoPlayStory = arg_37_3

				arg_37_0(arg_37_2)

				return
			end)
		end

		seriesAsync = var_2_10002

		var_2_10002(var_35_0, function(arg_38_0)
			local var_38_0 = arg_29_0
			local var_38_1 = var_1.emit

			SixthAnniversaryIslandMediator = var_3_10004

			var_38_1(var_38_0, var_3_10004.TRIGGER_NODE_EVENT, arg_29_1.id, arg_38_0 or 0)

			return
		end)

		return
	end)

	return
end

function var_0_1.afterTriggerEvent(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.proxy
	local var_39_1 = var_2.GetNode(var_39_0, arg_39_1)

	if var_2.IsCompleted(var_39_1) then
		underscore = var_3

		var_3.each(arg_39_0.ids, function(arg_40_0)
			local var_40_0 = arg_39_0

			var_1.refreshNode(var_40_0, arg_40_0)

			return
		end)
		arg_39_0:refreshDailyPanel()
	else
		arg_39_0:refreshNode(arg_39_1)
	end

	if var_2:CanTrigger() then
		triggerToggle = var_3

		local var_39_2 = arg_39_0.nodeItemList.container

		var_3(var_5.Find(var_39_2, arg_39_1), var_2:CanToggleOn())
		arg_39_0:triggerNode(arg_39_1)
	end

	return
end

function var_0_1.refreshNode(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.nodeItemList.container
	local var_41_1 = var_2.Find(var_41_0, arg_41_1)

	getProxy = var_1_10003
	SixthAnniversaryIslandProxy = var_5

	local var_41_2 = var_1_10003(var_5)
	local var_41_3 = var_3.GetNode(var_41_2, arg_41_1)
	local var_41_4 = var_3.IsVisual(var_41_3)

	setActive = var_41_2

	var_41_2(var_41_1:Find("click"), var_41_4)

	if var_41_4 then
		local var_41_5 = var_3
		local var_41_6

		if not var_3.GetScale(var_41_5) then
			var_41_6 = 0
		end

		Vector3 = var_41_3

		local var_41_7 = var_41_3(var_41_6, var_41_6, 1)
		local var_41_9

		if var_41_1.localScale ~= var_41_7 then
			LeanTween = var_41_9

			var_41_9.cancel(var_41_1)

			LeanTween = var_41_9

			local var_41_8 = var_41_9.scale(var_41_1, var_41_7, 0.3)

			var_41_9 = var_41_9.setEase
			LeanTweenType = var_9

			var_41_9(var_41_8, var_9.easeInOutSine)
		end

		if var_41_4 and not arg_41_0.displayDic[arg_41_1] then
			var_41_9 = arg_41_0.displayDic
			var_41_9[arg_41_1] = true

			local var_41_10 = var_3

			if var_3.getConfig(var_41_10, "icon") == "" then
				SetCompomentEnabled = var_41_5

				local var_41_11 = var_41_1:Find("main")

				typeof = var_10
				Image = var_12

				var_41_5(var_41_11, var_10(var_12), false)

				SetCompomentEnabled = var_41_5

				local var_41_12 = var_41_1:Find("selected_back/light")

				typeof = var_10
				Image = var_12

				var_41_5(var_41_12, var_10(var_12), false)
			else
				GetSpriteFromAtlasAsync = var_41_5

				var_41_5("ui/sixthanniversaryislandui_atlas", var_41_9, function(arg_42_0)
					setImageSprite = var_2_10001

					local var_42_0 = var_41_1

					var_2_10001(var_3.Find(var_42_0, "main"), arg_42_0)

					setImageSprite = var_2_10001

					local var_42_1 = var_41_1

					var_2_10001(var_3.Find(var_42_1, "main/mask"), arg_42_0)

					return
				end)

				GetImageSpriteFromAtlasAsync = var_41_5

				var_41_5("ui/sixthanniversaryislandui_atlas", var_41_9 .. "_light", var_41_1:Find("selected_back/light"))
			end

			if var_3:getConfig("icon_name") ~= "" then
				GetImageSpriteFromAtlasAsync = var_41_5

				var_41_5("ui/sixthanniversaryislandui_atlas", var_3:getConfig("icon_name"), var_41_1:Find("name/Image"), true)
			end

			if var_3:GetEffectName() ~= "" then
				pg = var_41_10

				local var_41_13 = var_41_10.PoolMgr.GetInstance()

				var_8.GetUI(var_41_13, var_41_5, true, function(arg_43_0)
					table = var_2_10001

					var_2_10001.insert(arg_41_0.effectObjs, {
						name = var_41_5,
						go = arg_43_0
					})

					setParent = var_1

					local var_43_0 = arg_43_0
					local var_43_1 = var_41_1

					var_1(var_43_0, var_4.Find(var_43_1, "click"), false)

					return
				end)
			end
		end

		setActive = var_41_9

		var_41_9(var_41_1:Find("main/type"), var_3:RedDotHint())

		local var_41_14 = var_3
		local var_41_15

		if var_3.IsRefresh(var_41_14) then
			var_41_14 = var_3
			var_41_15 = var_3.IsCompleted(var_41_14)
		end

		setActive = var_41_5

		var_41_5(var_41_1:Find("name"), not var_41_15 and not var_3:IsTreasure())

		setActive = var_41_5

		var_41_5(var_41_1:Find("main/mask"), var_41_15)

		setActive = var_41_5

		var_41_5(var_41_1:Find("main/time"), false)

		setActive = var_41_5

		var_41_5(var_41_1:Find("main/new"), var_3:IsNew())

		GetOrAddComponent = var_41_5

		local var_41_16 = var_41_1:Find("main")

		typeof = var_10

		local var_41_17 = var_41_5(var_41_16, var_10("LOutLine"))

		ReflectionHelp = var_41_14

		local var_41_18 = var_41_14.RefSetField

		typeof = var_10

		var_41_18(var_10("LOutLine"), "OutlineWidth", var_41_17, var_41_15 and 0 or 3)

		ReflectionHelp = var_41_18

		local var_41_19 = var_41_18.RefCallMethod

		typeof = var_10

		var_41_19(var_10("LOutLine"), "_Refresh", var_41_17)

		triggerToggle = var_41_19

		var_41_19(var_41_1, arg_41_0.selectId == arg_41_1 and var_3:CanToggleOn())

		return
	end
end

function var_0_1.refreshDailyPanel(arg_44_0)
	underscore = var_1_10001
	arg_44_0.dailyIds = var_1_10001.select(arg_44_0.ids, function(arg_45_0)
		local var_45_0 = arg_44_0.proxy
		local var_45_1 = var_1.GetNode(var_45_0, arg_45_0)
		local var_45_2

		if var_1.IsRefresh(var_45_1) or var_1:IsFlowerField() then
			var_45_2 = var_1:IsVisual()
		end

		return var_45_2
	end)

	local var_44_0 = arg_44_0.panelItemList

	var_1.align(var_44_0, #arg_44_0.dailyIds)

	underscore = var_1
	arg_44_0.mainIds = var_1.select(arg_44_0.ids, function(arg_46_0)
		local var_46_0 = arg_44_0.proxy
		local var_46_1 = var_1.GetNode(var_46_0, arg_46_0)
		local var_46_2

		if var_1.IsMain(var_46_1) then
			var_46_2 = var_1:IsVisual()
		end

		return var_46_2
	end)

	local var_44_1 = arg_44_0.floatItemList

	var_1.align(var_44_1, #arg_44_0.mainIds)
	arg_44_0:onDragFunction()

	return
end

function var_0_1.focusList(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	ipairs = var_1_10004

	for iter_47_0, iter_47_1 in var_1_10004(arg_47_1) do
		local var_47_0 = arg_47_0.proxy
		local var_47_1 = var_9.GetNode(var_47_0, iter_47_1)

		if var_9.IsVisual(var_47_1) then
			arg_47_0:focus(iter_47_1, arg_47_2, arg_47_3)

			return true
		end
	end

	return false
end

function var_0_1.didEnter(arg_48_0)
	local var_48_0 = arg_48_0.nodeItemList

	var_1.align(var_48_0, #arg_48_0.ids)
	arg_48_0:refreshDailyPanel()
	arg_48_0:updateTaskTip()

	local var_48_1 = {}

	if arg_48_0.contextData.nodeIds and #arg_48_0.contextData.nodeIds > 0 then
		table = var_2

		var_2.insert(var_48_1, function(arg_49_0)
			local var_49_0 = arg_48_0

			if not var_1.focusList(var_49_0, arg_48_0.contextData.nodeIds) then
				pg = var_1

				local var_49_1 = var_1.TipsMgr.GetInstance()
				local var_49_2 = var_1.ShowTips

				i18n = var_4

				var_49_2(var_49_1, var_4("islandnode_tips8"))
				arg_49_0()
			end

			arg_48_0.contextData.nodeIds = nil

			return
		end)
	elseif arg_48_0.contextData.checkMain then
		table = var_2

		var_2.insert(var_48_1, function(arg_50_0)
			getProxy = var_2_10001
			SixthAnniversaryIslandProxy = var_2_10003

			local var_50_0 = var_2_10001(var_2_10003)

			underscore = var_2_10002

			local var_50_1 = var_2_10002.filter

			underscore = var_2_10004

			local var_50_2 = var_50_1(var_2_10004.map(arg_48_0.ids, function(arg_51_0)
				local var_51_0 = var_50_0

				return var_1.GetNode(var_51_0, arg_51_0)
			end), function(arg_52_0)
				local var_52_0

				if arg_52_0:IsMain() then
					var_52_0 = not arg_52_0:IsCompleted()
				end

				return var_52_0
			end)

			getProxy = var_2_10003
			ActivityProxy = var_5

			local var_50_3 = var_2_10003(var_5)
			local var_50_4 = var_3.getActivityByType

			ActivityConst = var_6

			local var_50_5 = var_50_4(var_50_3, var_6.ACTIVITY_TYPE_BUILDING_BUFF_2)
			local var_50_6 = var_3.GetTotalBuildingLevel(var_50_5)

			if #var_50_2 > 0 then
				underscore = var_4

				if var_4.all(var_50_2, function(arg_53_0)
					return not arg_53_0:IsUnlock() and arg_53_0:getConfig("open_need")[1] > var_50_6
				end) then
					pg = var_4

					local var_50_7 = var_4.TipsMgr.GetInstance()
					local var_50_8 = var_4.ShowTips

					i18n = var_7

					var_50_8(var_50_7, var_7("islandnode_tips9"))
				end
			end

			arg_50_0()

			return
		end)
	end

	arg_48_0.contextData.checkMain = nil

	local var_48_2 = {
		1001,
		1002,
		1003,
		1004,
		1005
	}

	if arg_48_0.contextData.lastNodeId then
		table = var_3

		var_3.insert(var_48_2, 1, arg_48_0.contextData.lastNodeId)
	end

	table = var_3

	var_3.insert(var_48_1, function(arg_54_0)
		local var_54_0 = arg_48_0

		if not var_1.focusList(var_54_0, var_48_2) then
			arg_54_0()
		end

		return
	end)

	seriesAsync = var_3

	var_3(var_48_1, function()
		local var_55_0 = arg_48_0

		var_0.focusList(var_55_0, {
			1050,
			1051,
			1052,
			1053
		}, nil, true)

		return
	end)

	local var_48_3 = "HAIDAORICHANG2"

	pg = var_4

	local var_48_4 = var_4.NewStoryMgr.GetInstance()

	var_4.Play(var_48_4, var_48_3, function()
		if arg_48_0.contextData.wraps then
			switch = var_0

			var_0(arg_48_0.contextData.wraps, {
				[var_0_1.SHOP] = function()
					local var_57_0 = arg_48_0
					local var_57_1 = var_0.emit

					SixthAnniversaryIslandMediator = var_3_10003

					var_57_1(var_57_0, var_3_10003.GO_SHOP)

					return
				end
			})

			arg_48_0.contextData.wraps = nil
		end

		return
	end)

	return
end

function var_0_1.updateTaskTip(arg_58_0)
	setActive = var_1_10001

	local var_58_0 = arg_58_0.rtTop
	local var_58_1 = var_3.Find(var_58_0, "btns/btn_note/tip")

	getProxy = var_1_10004
	ActivityTaskProxy = var_6

	local var_58_2 = var_1_10004(var_6)
	local var_58_3 = var_4.getActTaskTip

	ActivityConst = var_1_10007

	var_1_10001(var_58_1, var_58_3(var_58_2, var_1_10007.ISLAND_TASK_ID))

	return
end

function var_0_1.willExit(arg_59_0)
	pg = var_1_10001

	local var_59_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_59_0, arg_59_0.rtTop, arg_59_0._tf)

	local var_59_1 = arg_59_0.rtMap
	local var_59_2 = var_1.GetComponent

	typeof = var_4
	ScrollRect = var_1_10006

	local var_59_3 = var_59_2(var_59_1, var_4(var_1_10006)).onValueChanged

	var_1.RemoveAllListeners(var_59_3)

	pg = var_1

	local var_59_4 = var_1.PoolMgr.GetInstance()

	ipairs = var_1_10002

	for iter_59_0, iter_59_1 in var_1_10002(arg_59_0.effectObjs) do
		var_59_4:ReturnUI(iter_59_1.name, iter_59_1.go)
	end

	return
end

return var_0_1
