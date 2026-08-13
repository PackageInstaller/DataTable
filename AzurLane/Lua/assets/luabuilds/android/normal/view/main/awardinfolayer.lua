class = var_0_10000

local var_0_0 = "AwardInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.TITLE = {
	COMMANDER = "commander",
	RYZA = "ryza",
	ITEM = "item",
	SHIP = "ship",
	REVERT = "revert",
	ESCORT = "escort"
}

local var_0_2 = 0.15
local var_0_3 = 340
local var_0_4 = 564

function var_0_1.getUIName(arg_1_0)
	return "AwardInfoUI"
end

function var_0_1.init(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_2_0, arg_2_0._tf)

	_ = var_1

	local var_2_1 = var_1.select
	local var_2_2

	if not arg_2_0.contextData.items then
		var_2_2 = {}
	end

	arg_2_0.awards = var_2_1(var_2_2, function(arg_3_0)
		local var_3_0 = arg_3_0.type

		DROP_TYPE_ICON_FRAME = var_2_10002

		if var_3_0 ~= var_2_10002 then
			local var_3_1 = arg_3_0.type

			DROP_TYPE_CHAT_FRAME = var_2_10002

			if var_3_1 ~= var_2_10002 then
				local var_3_2 = arg_3_0.type

				DROP_TYPE_LIVINGAREA_COVER = var_2_10002

				local var_3_3

				if var_3_2 == var_2_10002 then
					var_3_3 = false
				else
					var_3_3 = true
				end

				return var_3_3
			end
		end
	end)

	local var_2_3 = arg_2_0._tf

	arg_2_0._itemsWindow = var_1.Find(var_2_3, "items")

	local var_2_4 = arg_2_0._itemsWindow

	arg_2_0.spriteMask = var_1.Find(var_2_4, "SpriteMask")

	local var_2_5

	if not arg_2_0.contextData.title then
		var_2_5 = var_0_1.TITLE.ITEM
	end

	arg_2_0.title = var_2_5
	pairs = var_2_5

	for iter_2_0, iter_2_1 in var_2_5(var_0_1.TITLE) do
		setActive = var_1_10006

		local var_2_6 = arg_2_0._itemsWindow

		var_1_10006(var_1_10007.Find(var_2_6, "titles/title_" .. iter_2_1), arg_2_0.title == iter_2_1)
	end

	if arg_2_0.title == var_0_1.TITLE.COMMANDER then
		eachChild = var_1

		local var_2_7 = arg_2_0._itemsWindow

		var_1(var_2.Find(var_2_7, "titles/title_commander"), function(arg_4_0)
			setActive = var_2_10001

			var_2_10001(arg_4_0, arg_4_0.name == arg_2_0.contextData.titleExtra)

			return
		end)
	end

	local var_2_8 = {}
	local var_2_9 = arg_2_0._itemsWindow

	var_2_8.items_scroll = var_2.Find(var_2_9, "items_scroll/content")

	local var_2_10 = arg_2_0._itemsWindow

	var_2_8.ships = var_2.Find(var_2_10, "ships")

	local var_2_13

	if arg_2_0.title == var_0_1.TITLE.SHIP then
		arg_2_0.container = var_2_8.ships
	else
		arg_2_0.container = var_2_8.items_scroll
		scrollTo = var_2_13

		var_2_13(arg_2_0.container, nil, 1)

		local var_2_11 = arg_2_0._itemsWindow
		local var_2_12 = var_2_13.Find(var_2_11, "items_scroll")

		var_2_13 = var_2_13.GetComponent
		typeof = var_4
		LayoutElement = var_5
		arg_2_0.windowLayout = var_2_13(var_2_12, var_4(var_5))
	end

	GetOrAddComponent = var_2_13

	local var_2_14 = var_2_13(arg_2_0.container, "CanvasGroup")

	var_2_14.alpha = 1
	pairs = var_2_14

	for iter_2_2, iter_2_3 in var_2_14(var_2_8) do
		setActive = var_1_10007

		local var_2_15 = arg_2_0._itemsWindow

		var_1_10007(var_8.Find(var_2_15, iter_2_2), arg_2_0.container == iter_2_3)
	end

	setLocalScale = var_2

	local var_2_16 = arg_2_0._itemsWindow

	Vector3 = var_4

	var_2(var_2_16, var_4(0.5, 0.5, 0.5))

	local var_2_17 = arg_2_0._itemsWindow

	arg_2_0.itemTpl = var_2.Find(var_2_17, "item_tpl")

	local var_2_18 = arg_2_0._itemsWindow

	arg_2_0.shipTpl = var_2.Find(var_2_18, "ship_tpl")

	local var_2_19 = arg_2_0._itemsWindow

	arg_2_0.extraBouns = var_2.Find(var_2_19, "titles/extra_bouns")
	setActive = var_2

	var_2(arg_2_0.extraBouns, arg_2_0.contextData.extraBonus)

	local var_2_20 = arg_2_0._tf

	arg_2_0.continueBtn = var_2.Find(var_2_20, "items/close")

	local var_2_21 = arg_2_0._tf
	local var_2_22 = var_2.Find(var_2_21, "decorations")

	if arg_2_0.title == var_0_1.TITLE.SHIP then
		setLocalScale = var_3

		local var_2_23 = var_2_22

		Vector3 = var_5

		var_3(var_2_23, var_5.New(1.25, 1.25, 1))
	else
		setLocalScale = var_3

		local var_2_24 = var_2_22

		Vector3 = var_5

		var_3(var_2_24, var_5.one)
	end

	arg_2_0.blinks = {}
	arg_2_0.tweenItems = {}

	local var_2_25 = arg_2_0._tf

	arg_2_0.shipCardTpl = var_3.Find(var_2_25, "ShipCardTpl")

	local var_2_26 = arg_2_0._tf

	var_3.SetAsLastSibling(var_2_26)

	local var_2_27 = arg_2_0._tf

	arg_2_0.metaRepeatAwardTF = var_3.Find(var_2_27, "MetaShipRepeatAward")

	return
end

function var_0_1.doAnim(arg_5_0, arg_5_1)
	LeanTween = var_1_10002

	local var_5_0 = var_1_10002.scale

	rtf = var_1_10003

	local var_5_1 = var_1_10003(arg_5_0._itemsWindow)

	Vector3 = var_4

	local var_5_2 = var_5_0(var_5_1, var_4(1, 1, 1), 0.15)
	local var_5_3 = var_2.setEase

	LeanTweenType = var_4

	local var_5_4 = var_5_3(var_5_2, var_4.linear)
	local var_5_5 = var_2.setOnComplete

	System = var_4

	var_5_5(var_5_4, var_4.Action(function()
		if arg_5_0.exited then
			return
		end

		arg_5_1()

		return
	end))

	return
end

function var_0_1.playAnim(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0 = 1, #arg_7_0.awards do
		table = var_1_10007

		var_1_10007.insert(var_7_0, function(arg_8_0)
			setActive = var_2_10001

			local var_8_0 = arg_7_0.container

			var_2_10001(var_2.GetChild(var_8_0, iter_7_0 - 1), true)

			local var_8_2

			if arg_7_0.windowLayout then
				local var_8_1 = iter_7_0

				if 5 < var_8_1 and arg_7_0.windowLayout.preferredHeight ~= var_0_4 then
					arg_7_0.windowLayout.preferredHeight = var_0_4
					var_8_2 = arg_7_0

					var_1.updateSpriteMaskScale(var_8_2)
				end

				if iter_7_0 % 5 == 1 then
					scrollTo = var_1

					var_1(arg_7_0.container, nil, 0)
				end
			end

			local var_8_3 = arg_7_0

			LeanTween = var_8_2

			local var_8_4 = var_8_2.delayedCall
			local var_8_5 = var_0_2

			System = var_4
			var_8_3.tweeningId = var_8_4(var_8_5, var_4.Action(arg_8_0)).uniqueId

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_7_0, function()
		arg_7_0.tweeningId = nil

		if arg_7_1 then
			arg_7_1()
		end

		return
	end)

	return
end

function var_0_1.didEnter(arg_10_0)
	setActive = var_1_10001

	var_1_10001(arg_10_0.spriteMask, true)

	onButton = var_1_10001

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0._tf

	local function var_10_2()
		local function var_11_0()
			if arg_10_0.tweeningId then
				LeanTween = var_0

				var_0.cancel(arg_10_0.tweeningId)

				arg_10_0.tweeningId = nil
			end

			local var_12_0 = arg_10_0

			var_0.emit(var_12_0, var_0_1.ON_CLOSE)

			return
		end

		local var_11_1 = arg_10_0

		var_1.checkPaintingRes(var_11_1, var_11_0)

		return
	end

	SFX_CANCEL = var_1_10005

	var_1_10001(var_10_0, var_10_1, var_10_2, var_1_10005, {
		noShip = not arg_10_0.hasShip
	})

	onButton = var_1_10001

	var_1_10001(arg_10_0, arg_10_0.continueBtn, function()
		triggerButton = var_2_10000

		var_2_10000(arg_10_0._tf)

		return
	end)

	pg = var_1_10001

	local var_10_3 = var_1_10001.CriMgr.GetInstance()
	local var_10_4 = var_1.PlaySoundEffect_V3

	SFX_UI_GETITEM = var_3

	var_10_4(var_10_3, var_3)

	local var_10_5 = {}

	table = var_10_3

	var_10_3.insert(var_10_5, function(arg_14_0)
		local var_14_0 = arg_10_0

		var_1.doAnim(var_14_0, arg_14_0)

		return
	end)
	arg_10_0:displayAwards()

	if arg_10_0.contextData.animation then
		eachChild = var_2

		var_2(arg_10_0.container, function(arg_15_0)
			setActive = var_2_10001

			var_2_10001(arg_15_0, false)

			return
		end)

		GetOrAddComponent = var_2

		local var_10_6 = var_2(arg_10_0.container, "CanvasGroup")

		var_10_6.alpha = 0
		table = var_10_6

		var_10_6.insert(var_10_5, function(arg_16_0)
			GetOrAddComponent = var_2_10001
			var_2_10001(arg_10_0.container, "CanvasGroup").alpha = 1

			local var_16_0 = arg_10_0

			var_1.playAnim(var_16_0, arg_16_0)

			return
		end)
	end

	local var_10_7

	if arg_10_0.windowLayout then
		var_10_7 = arg_10_0.windowLayout

		local var_10_8

		if arg_10_0.contextData.animation or not (#arg_10_0.awards > 5) or not var_0_4 then
			var_10_8 = var_0_3
		end

		var_10_7.preferredHeight = var_10_8

		arg_10_0:updateSpriteMaskScale()
	end

	seriesAsync = var_10_7

	var_10_7(var_10_5, function()
		if arg_10_0.exited then
			return
		end

		if arg_10_0.contextData.closeOnCompleted then
			triggerButton = var_0

			var_0(arg_10_0._tf)
		end

		if arg_10_0.enterCallback then
			arg_10_0.enterCallback()

			arg_10_0.enterCallback = nil
		end

		return
	end)

	if arg_10_0.contextData.auto then
		arg_10_0:AddCloseTimer()
	end

	return
end

function var_0_1.RemoveCloseTimer(arg_18_0)
	if arg_18_0.closeTimer then
		local var_18_0 = arg_18_0.closeTimer

		var_1.Stop(var_18_0)

		arg_18_0.closeTimer = nil
	end

	return
end

function var_0_1.AddCloseTimer(arg_19_0)
	arg_19_0:RemoveCloseTimer()

	Timer = var_1

	local var_19_0 = var_1.New

	local function var_19_1()
		local var_20_0 = arg_19_0

		var_0.RemoveCloseTimer(var_20_0)

		triggerButton = var_0

		var_0(arg_19_0._tf)

		return
	end

	local var_19_2

	if not arg_19_0.contextData.auto then
		var_19_2 = 2
	end

	arg_19_0.closeTimer = var_19_0(var_19_1, var_19_2, 1)

	local var_19_3 = arg_19_0.closeTimer

	var_1.Start(var_19_3)

	return
end

function var_0_1.onUIAnimEnd(arg_21_0, arg_21_1)
	arg_21_0.enterCallback = arg_21_1

	return
end

function var_0_1.onBackPressed(arg_22_0)
	LeanTween = var_1_10001

	local var_22_0 = var_1_10001.isTweening

	go = var_1_10002

	if var_22_0(var_1_10002(arg_22_0._itemsWindow)) then
		return
	end

	pg = var_1

	local var_22_1 = var_1.CriMgr.GetInstance()
	local var_22_2 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_3

	var_22_2(var_22_1, var_3)

	triggerButton = var_22_2

	var_22_2(arg_22_0._tf)

	return
end

local function var_0_5(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.ship_data_statistics[arg_23_1.id]

	Ship = var_3

	local var_23_1 = var_3.New({
		configId = arg_23_1.id
	})

	var_23_1.virgin = arg_23_1.virgin
	setScrollText = var_4
	findTF = var_5

	var_4(var_5(arg_23_0, "content/info/name_mask/name"), var_23_1:GetColorName())

	flushShipCard = var_4

	var_4(arg_23_0, var_23_1)

	findTF = var_4

	local var_23_2 = var_4(arg_23_0, "content/front/new")

	setActive = var_5

	var_5(var_23_2, arg_23_1.virgin)

	return
end

function var_0_1.displayAwards(arg_24_0)
	assert = var_1_10001

	var_1_10001(#arg_24_0.awards ~= 0, "items数量不能为0")

	removeAllChildren = var_1_10001

	var_1_10001(arg_24_0.container)

	for iter_24_0 = 1, #arg_24_0.awards do
		if arg_24_0.title ~= var_0_1.TITLE.SHIP then
			cloneTplTo = var_5

			var_5(arg_24_0.itemTpl, arg_24_0.container)
		else
			cloneTplTo = var_5

			local var_24_0 = var_5(arg_24_0.shipTpl, arg_24_0.container)

			setActive = var_6
			cloneTplTo = var_7

			var_6(var_7(arg_24_0.shipCardTpl, var_24_0, "ship_tpl"), true)
		end
	end

	if arg_24_0.title ~= var_0_1.TITLE.SHIP then
		for iter_24_1 = 1, #arg_24_0.awards do
			local var_24_1 = arg_24_0.container
			local var_24_2 = var_5.GetChild(var_24_1, iter_24_1 - 1)
			local var_24_3 = var_5.Find(var_24_2, "bg")
			local var_24_4 = arg_24_0.awards[iter_24_1].type

			DROP_TYPE_SHIP = var_1_10008

			if var_24_4 == var_1_10008 then
				arg_24_0.hasShip = true
			end

			updateDrop = var_24_4

			var_24_4(var_24_3, var_6, {
				fromAwardLayer = true
			})

			setActive = var_24_4
			findTF = var_1_10008

			var_24_4(var_1_10008(var_24_3, "icon_bg/bonus"), var_6.riraty)

			setActive = var_24_4
			findTF = var_1_10008

			var_24_4(var_1_10008(var_24_3, "icon_bg/bonus_catchup"), var_6.catchupTag)

			setActive = var_24_4
			findTF = var_1_10008

			var_24_4(var_1_10008(var_24_3, "icon_bg/bonus_event"), var_6.catchupActTag)

			findTF = var_24_4

			local var_24_5 = var_24_4(var_24_3, "name")

			findTF = var_1_10008
			var_1_10008 = var_1_10008(var_24_3, "name_mask")
			setActive = var_9

			var_9(var_24_5, false)

			setActive = var_9

			var_9(var_1_10008, true)

			setScrollText = var_9
			findTF = var_10

			local var_24_6 = var_10(var_24_3, "name_mask/name")

			if not var_6.name then
				getText = var_1_10011
				var_1_10011 = var_1_10011(var_24_5)
			end

			var_9(var_24_6, var_1_10011)

			onButton = var_9

			local var_24_7 = arg_24_0

			var_1_10011 = var_24_3

			local function var_24_8()
				if arg_24_0.tweeningId then
					return
				end

				local var_25_0 = arg_24_0
				local var_25_1 = var_0.emit

				AwardInfoMediator = var_2_10002

				var_25_1(var_25_0, var_2_10002.ON_DROP, var_0)

				return
			end

			SFX_PANEL = var_1_10013

			var_9(var_24_7, var_1_10011, var_24_8, var_1_10013)
		end
	else
		for iter_24_2 = 1, #arg_24_0.awards do
			local var_24_9 = arg_24_0.container
			local var_24_10 = var_5.GetChild(var_24_9, iter_24_2 - 1)
			local var_24_11 = var_5.Find(var_24_10, "ship_tpl")
			local var_24_12 = arg_24_0.awards[iter_24_2]

			var_0_5(var_24_11, var_24_12)

			if var_24_12.reMetaSpecialItemVO then
				cloneTplTo = var_8

				local var_24_13 = var_8(arg_24_0.metaRepeatAwardTF, var_24_11)

				setLocalPosition = var_9

				local var_24_14 = var_24_13

				Vector3 = var_1_10011

				var_9(var_24_14, var_1_10011.zero)

				setLocalScale = var_9

				local var_24_15 = var_24_13

				Vector3 = var_1_10011

				var_9(var_24_15, var_1_10011.zero)

				local var_24_16 = var_24_13
				local var_24_17 = var_24_13.Find(var_24_16, "item_tpl/bg")

				updateDrop = var_24_16

				var_24_16(var_24_17, var_7)

				setActive = var_24_16

				var_24_16(var_24_17:Find("name"), false)

				setActive = var_24_16

				var_24_16(var_24_17:Find("name_mask"), true)

				var_1_10011 = var_24_17
				var_1_10011 = var_24_17.Find(var_1_10011, "name_mask/name")

				local var_24_18 = var_10.GetComponent(var_1_10011, "ScrollText")

				var_10.SetText(var_24_18, var_7.cfg.name)

				function var_1_10011()
					local var_26_0 = arg_24_0
					local var_26_1 = var_0.managedTween

					LeanTween = var_2_10002

					local var_26_2 = var_2_10002.value
					local var_26_3

					go = var_2_10004

					local var_26_4 = var_26_1(var_26_0, var_26_2, var_26_3, var_2_10004(var_24_13), 0, 1, 0.3)
					local var_26_5 = var_0.setOnUpdate

					System = var_26_2

					local var_26_6 = var_26_5(var_26_4, var_26_2.Action_float(function(arg_27_0)
						setLocalScale = var_3_10001

						var_3_10001(var_24_13, {
							x = arg_27_0,
							y = arg_27_0
						})

						return
					end))
					local var_26_7 = var_0.setOnComplete

					System = var_2

					var_26_7(var_26_6, var_2.Action(function()
						setLocalScale = var_3_10000

						local var_28_0 = var_24_13

						Vector3 = var_3_10002

						var_3_10000(var_28_0, var_3_10002.one)

						return
					end))

					return
				end

				local var_24_19 = arg_24_0
				local var_24_20 = arg_24_0.managedTween

				LeanTween = var_1_10014

				var_24_20(var_24_19, var_1_10014.delayedCall, var_1_10011, 0.3, nil)
			end

			if #arg_24_0.awards > 5 then
				if iter_24_2 <= 5 then
					Vector2 = var_8
					var_24_11.anchoredPosition = var_8.New(-50, 0)
				else
					Vector2 = var_8
					var_24_11.anchoredPosition = var_8.New(50, 0)
				end
			end
		end
	end

	return
end

function var_0_1.ShowOrHideSpriteMask(arg_29_0, arg_29_1)
	isActive = var_1_10002

	if var_1_10002(arg_29_0.spriteMask) == arg_29_1 then
		return
	end

	setActive = var_2

	var_2(arg_29_0.spriteMask, arg_29_1)

	return
end

function var_0_1.willExit(arg_30_0)
	arg_30_0:RemoveCloseTimer()

	setActive = var_1

	var_1(arg_30_0.spriteMask, false)

	pg = var_1

	local var_30_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_30_0, arg_30_0._tf)

	if arg_30_0.title ~= var_0_1.TITLE.SHIP then
		for iter_30_0 = 0, arg_30_0.container.childCount - 1 do
			clearDrop = var_1_10005

			local var_30_1 = arg_30_0.container
			local var_30_2 = var_1_10006.GetChild(var_30_1, iter_30_0)

			var_1_10005(var_1_10006.Find(var_30_2, "bg"))
		end
	end

	if arg_30_0.blinks and #arg_30_0.blinks > 0 then
		pairs = var_1

		for iter_30_1, iter_30_2 in var_1(arg_30_0.blinks) do
			IsNil = var_1_10006

			if not var_1_10006(iter_30_2) then
				Destroy = var_1_10006

				var_1_10006(iter_30_2)
			end
		end
	end

	if arg_30_0.contextData.removeFunc then
		arg_30_0.contextData.removeFunc()

		arg_30_0.contextData.removeFunc = nil
	end

	return
end

function var_0_1.updateSpriteMaskScale(arg_31_0)
	onNextTick = var_1_10001

	var_1_10001(function()
		if arg_31_0.exited then
			return
		end

		setLocalScale = var_0

		local var_32_0 = arg_31_0.spriteMask

		Vector3 = var_2_10002

		local var_32_1 = arg_31_0.spriteMask.rect.width

		WHITE_DOT_SIZE = var_2_10004

		local var_32_2 = var_32_1 / var_2_10004

		PIXEL_PER_UNIT = var_2_10004

		local var_32_3 = var_32_2 * var_2_10004
		local var_32_4 = arg_31_0.spriteMask.rect.height

		WHITE_DOT_SIZE = var_2_10005

		local var_32_5 = var_32_4 / var_2_10005

		PIXEL_PER_UNIT = var_2_10005

		var_0(var_32_0, var_2_10002(var_32_3, var_32_5 * var_2_10005, 1))

		return
	end)

	return
end

function var_0_1.checkPaintingRes(arg_33_0, arg_33_1)
	PaintingGroupConst = var_1_10002

	local var_33_0 = var_1_10002.GetPaintingNameListForAwardList(arg_33_0.awards)
	local var_33_1 = {
		isShowBox = false,
		paintingNameList = var_33_0,
		finishFunc = arg_33_1
	}

	PaintingGroupConst = var_1_10004

	var_1_10004.PaintingDownload(var_33_1)

	return
end

return var_0_1
