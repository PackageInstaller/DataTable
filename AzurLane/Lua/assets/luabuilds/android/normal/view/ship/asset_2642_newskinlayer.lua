class = var_0_10000

local var_0_0 = "NewSkinLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

var_0_1.PAINT_DURATION = 0.35
var_0_1.STAR_DURATION = 0.5

local var_0_2 = 19

function var_0_1.getUIName(arg_1_0)
	return "NewSkinUI"
end

function var_0_1.preload(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.contextData.skinId

	pg = var_1_10003

	local var_2_1 = var_1_10003.ship_skin_template[var_2_0].ship_group * 10 + 1

	pg = var_1_10006

	local var_2_2 = var_1_10006.ship_data_statistics[var_2_1]
	local var_2_3

	if var_3.bg_sp and var_3.bg_sp ~= "" then
		var_2_3 = var_3.bg_sp

		goto label_2_2
	end

	if var_3.bg then
		local var_2_4 = #var_3.bg

		if not (0 < var_2_4) or not var_3.bg then
			::label_2_0::

			if var_3.rarity_bg then
				::label_2_1::

				var_2_4 = #var_3.rarity_bg
				var_2_3 = 0 < var_2_4 and var_3.rarity_bg
			end
		end

		::label_2_2::

		if not var_2_3 or not ("bg/star_level_bg_" .. var_2_3) then
			::label_2_3::

			var_2_4 = "newshipbg/bg_"
			shipRarity2bgPrint = var_1_10009

			local var_2_5 = var_2_2.rarity

			ShipGroup = var_1_10011

			local var_2_6 = var_1_10011.IsBluePrintGroup(var_4)

			ShipGroup = var_12
			var_2_3 = var_2_4 .. var_1_10009(var_2_5, var_2_6, var_12.IsMetaGroup(var_4))
		end

		GetSpriteFromAtlasAsync = var_2_4

		var_2_4(var_2_3, "", arg_2_1)

		return
	end
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0._shake = var_1.Find(var_3_0, "shake_panel")

	local var_3_1 = arg_3_0._tf

	arg_3_0._shade = var_1.Find(var_3_1, "shade")

	local var_3_2 = arg_3_0._shake

	arg_3_0._bg = var_1.Find(var_3_2, "bg")

	local var_3_3 = arg_3_0._bg

	arg_3_0._staticBg = var_1.Find(var_3_3, "static_bg")

	local var_3_4 = arg_3_0._shake

	arg_3_0._paintingTF = var_1.Find(var_3_4, "paint")

	local var_3_5 = arg_3_0._shake

	arg_3_0._dialogue = var_1.Find(var_3_5, "dialogue")

	local var_3_6 = arg_3_0._dialogue
	local var_3_7 = var_1.Find(var_3_6, "name")
	local var_3_8 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_3_0._skinName = var_3_8(var_3_7, var_3(var_1_10004))

	local var_3_9 = arg_3_0._shake

	arg_3_0._left = var_1.Find(var_3_9, "left_panel")

	local var_3_10 = arg_3_0._left

	arg_3_0._viewBtn = var_1.Find(var_3_10, "view_btn")

	local var_3_11 = arg_3_0._left

	arg_3_0._shareBtn = var_1.Find(var_3_11, "share_btn")

	local var_3_12 = arg_3_0._shake

	arg_3_0.clickTF = var_1.Find(var_3_12, "click")

	local var_3_13 = arg_3_0._shake

	arg_3_0.newTF = var_1.Find(var_3_13, "New")

	local var_3_14 = arg_3_0._shake

	arg_3_0.timelimit = var_1.Find(var_3_14, "timelimit")
	setActive = var_1

	var_1(arg_3_0.newTF, false)

	local var_3_15 = arg_3_0._shake

	arg_3_0.changeSkinBtn = var_1.Find(var_3_15, "set_skin_btn")

	local var_3_16 = arg_3_0._tf

	arg_3_0.selectPanel = var_1.Find(var_3_16, "select_ship_panel")
	arg_3_0.isTimeLimit = arg_3_0.contextData.timeLimit
	setActive = var_1

	var_1(arg_3_0.timelimit, arg_3_0.isTimeLimit)

	pg = var_1

	local var_3_17 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_3_17, arg_3_0._tf)

	arg_3_0.isLoadBg = false
	ChangeShipSkinPage = var_1
	arg_3_0.selectShipPage = var_1.New(arg_3_0._parentTf, arg_3_0.event)
	arg_3_0.selectShipPage.isNew = true

	function arg_3_0.selectShipPage.hideCallback()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	return
end

function var_0_1.voice(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	arg_5_0:stopVoice()

	arg_5_0._currentVoice = arg_5_1
	pg = var_2

	local var_5_0 = var_2.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_5_0, arg_5_1)

	return
end

function var_0_1.stopVoice(arg_6_0)
	if arg_6_0._currentVoice then
		pg = var_1

		local var_6_0 = var_1.CriMgr.GetInstance()

		var_1.UnloadSoundEffect_V3(var_6_0, arg_6_0._currentVoice)
	end

	arg_6_0._currentVoice = nil

	return
end

function var_0_1.setSkin(arg_7_0, arg_7_1)
	GetOrAddComponent = var_1_10002

	local var_7_0 = arg_7_0._tf

	typeof = var_1_10004
	CanvasGroup = var_1_10005
	arg_7_0.cg = var_1_10002(var_7_0, var_1_10004(var_1_10005))

	local var_7_1 = arg_7_0.cg

	var_7_1.alpha = 0
	setActive = var_7_1

	var_7_1(arg_7_0._shade, true)

	local var_7_2 = arg_7_0._shade
	local var_7_3 = var_2.GetComponent

	typeof = var_4
	Image = var_1_10005

	local var_7_4 = var_7_3(var_7_2, var_4(var_1_10005))

	Color = var_7_2
	var_7_4.color = var_7_2.New(0, 0, 0, 1)

	local var_7_5 = "star_level_unlock_anim_" .. arg_7_1

	checkABExist = var_3

	if var_3("ui/skinunlockanim/" .. var_7_5) then
		arg_7_0:playOpening(function()
			local var_8_0 = arg_7_0

			var_0.setSkinPri(var_8_0, arg_7_1)

			return
		end, var_7_5)
	else
		arg_7_0:setSkinPri(arg_7_1)
	end

	return
end

function var_0_1.setSkinPri(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.loadUISync(var_9_0, "getrole")

	LayerMask = var_9_0
	var_9_1.layer = var_9_0.NameToLayer("UI")

	local var_9_2 = var_9_1.transform

	Vector3 = var_4
	var_9_2.localPosition = var_4(0, 0, -10)
	setParent = var_9_2

	var_9_2(var_9_1, arg_9_0._tf, false)

	setActive = var_9_2

	var_9_2(var_9_1, false)

	onNextTick = var_9_2

	var_9_2(function()
		setActive = var_2_10000

		var_2_10000(var_9_1, true)

		return
	end)

	pg = var_9_2

	local var_9_3 = var_9_2.CriMgr.GetInstance()
	local var_9_4 = var_3.PlaySoundEffect_V3

	SFX_UI_DOCKYARD_CHARGET = var_5

	var_9_4(var_9_3, var_5)

	arg_9_0.cg.alpha = 1

	local var_9_5 = arg_9_0._shade
	local var_9_6 = var_3.GetComponent

	typeof = var_5
	Image = var_6

	local var_9_7 = var_9_6(var_9_5, var_5(var_6))

	Color = var_9_5
	var_9_7.color = var_9_5.New(0, 0, 0, 0)

	local var_9_8 = arg_9_0

	arg_9_0.recyclePainting(var_9_8)

	pg = var_3
	arg_9_0._skinConfig = var_3.ship_skin_template[arg_9_1]
	pg = var_3

	local var_9_9 = var_3.ship_skin_template[arg_9_1].ship_group

	pg = var_9_8

	local var_9_10 = var_9_8.ship_data_statistics[arg_9_0._skinConfig.ship_group * 10 + 1]
	local var_9_11

	if arg_9_0._skinConfig.bg_sp and arg_9_0._skinConfig.bg_sp ~= "" then
		var_9_11 = arg_9_0._skinConfig.bg_sp

		goto label_9_2
	end

	if arg_9_0._skinConfig.bg then
		local var_9_12 = #arg_9_0._skinConfig.bg

		if not (0 < var_9_12) or not arg_9_0._skinConfig.bg then
			::label_9_0::

			if arg_9_0._skinConfig.rarity_bg then
				::label_9_1::

				var_9_12 = #arg_9_0._skinConfig.rarity_bg
				var_9_11 = 0 < var_9_12 and arg_9_0._skinConfig.rarity_bg
			end
		end

		do
			local var_9_13
		end

		::label_9_2::

		if var_9_11 then
			pg = var_9_12
			var_9_13 = var_9_12.DynamicBgMgr.GetInstance()

			var_9_12.LoadBg(var_9_13, arg_9_0, var_9_11, arg_9_0._bg, arg_9_0._staticBg, function(arg_11_0)
				arg_9_0.isLoadBg = true

				return
			end, function(arg_12_0)
				arg_9_0.isLoadBg = true

				return
			end)
		else
			var_9_12 = "newshipbg/bg_"
			shipRarity2bgPrint = var_9_13

			local var_9_14 = var_9_10.rarity

			ShipGroup = var_1_10009

			local var_9_15 = var_1_10009.IsBluePrintGroup(var_9_9)

			ShipGroup = var_10

			local var_9_16 = var_9_12 .. var_9_13(var_9_14, var_9_15, var_10.IsMetaGroup(var_9_9))

			GetSpriteFromAtlasAsync = var_9_12

			var_9_12(var_9_16, "", function(arg_13_0)
				setImageSprite = var_2_10001

				var_2_10001(arg_9_0._staticBg, arg_13_0, true)

				arg_9_0.isLoadBg = true

				return
			end)
		end

		setPaintingPrefabAsync = var_9_12

		var_9_12(arg_9_0._paintingTF, arg_9_0._skinConfig.painting, "huode")

		local var_9_17 = arg_9_0._skinName

		i18n = var_7
		var_9_17.text = var_7("ship_newSkin_name", arg_9_0._skinConfig.name)

		local var_9_18
		local var_9_19 = ""
		local var_9_20

		ShipWordHelper = var_9

		local var_9_21 = var_9.RawGetWord
		local var_9_22 = arg_9_1

		ShipWordHelper = var_1_10011

		local var_9_23, var_9_26, var_9_27

		if var_9_21(var_9_22, var_1_10011.WORD_TYPE_UNLOCK) == "" then
			ShipWordHelper = var_9_23
			var_9_23 = var_9_23.GetWordAndCV

			local var_9_24 = arg_9_1

			ShipWordHelper = var_9_26

			local var_9_25

			var_9_23, var_9_25, var_9_26 = var_9_23(var_9_24, var_9_26.WORD_TYPE_DROP)
			var_9_27 = var_9_26
			var_9_20 = var_9_25

			local var_9_28 = var_9_23
		else
			ShipWordHelper = var_9_23
			var_9_23 = var_9_23.GetWordAndCV

			local var_9_29 = arg_9_1

			ShipWordHelper = var_9_26

			local var_9_30

			var_9_23, var_9_30, var_9_26 = var_9_23(var_9_29, var_9_26.WORD_TYPE_UNLOCK)
			var_9_27 = var_9_26
			var_9_20 = var_9_30

			local var_9_31 = var_9_23
		end

		setWidgetText = var_9_23

		local var_9_32 = arg_9_0._dialogue

		SwitchSpecialChar = var_9_26

		var_9_23(var_9_32, var_9_26(var_9_27, true), "desc/Text")

		local var_9_33 = arg_9_0._dialogue.transform

		Vector3 = var_9_32
		var_9_33.localScale = var_9_32(0, 1, 1)
		SetActive = var_9_33

		var_9_33(arg_9_0._dialogue, false)

		SetActive = var_9_33

		var_9_33(arg_9_0._dialogue, true)

		LeanTween = var_9_33

		local var_9_34 = var_9_33.scale
		local var_9_35 = arg_9_0._dialogue

		Vector3 = var_11

		local var_9_36 = var_9_34(var_9_35, var_11(1, 1, 1), 0.1)
		local var_9_37 = var_9.setOnComplete

		System = var_11

		var_9_37(var_9_36, var_11.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_9_0._shade, false)

			setActive = var_2_10000

			var_2_10000(arg_9_0.clickTF, true)

			local var_14_0 = arg_9_0

			var_0.voice(var_14_0, var_9_20)

			return
		end))

		return
	end
end

function var_0_1.showExitTip(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.MsgboxMgr.GetInstance()
	local var_15_1 = var_1.ShowMsgBox
	local var_15_2 = {}

	i18n = var_1_10004
	var_15_2.content = var_1_10004("give_up_cloth_change")

	function var_15_2.onYes()
		local var_16_0 = arg_15_0

		var_0.emit(var_16_0, var_0_1.ON_CLOSE)

		return
	end

	var_15_1(var_15_0, var_15_2)

	return
end

function var_0_1.didEnter(arg_17_0)
	ShipWordHelper = var_1_10001

	local var_17_0 = var_1_10001.GetDefaultSkin(arg_17_0.contextData.skinId)

	pg = var_2
	arg_17_0.shipName = var_2.ship_skin_template[var_17_0].name
	onButton = var_2

	local var_17_1 = arg_17_0
	local var_17_2 = arg_17_0._viewBtn

	local function var_17_3()
		arg_17_0.isInView = true

		local var_18_0 = arg_17_0

		var_0.paintView(var_18_0)

		setActive = var_0

		var_0(arg_17_0.clickTF, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_17_1, var_17_2, var_17_3, var_1_10006)

	onButton = var_2

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0._shareBtn

	local function var_17_6()
		pg = var_2_10000

		local var_19_0 = var_2_10000.ShareMgr.GetInstance()
		local var_19_1 = var_0.Share

		pg = var_2_10002

		var_19_1(var_19_0, var_2_10002.ShareMgr.TypeNewSkin)

		return
	end

	SFX_PANEL = var_1_10006

	var_2(var_17_4, var_17_5, var_17_6, var_1_10006)

	onButton = var_2

	local var_17_7 = arg_17_0
	local var_17_8 = arg_17_0.clickTF

	local function var_17_9()
		if arg_17_0.isInView or not arg_17_0.isLoadBg then
			return
		end

		local var_20_0 = arg_17_0

		var_0.showExitTip(var_20_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_2(var_17_7, var_17_8, var_17_9, var_1_10006)

	arg_17_0.sameShipVOs = arg_17_0:GetShips(arg_17_0.contextData.skinId)

	arg_17_0:onSwitch(arg_17_0.changeSkinBtn, #arg_17_0.sameShipVOs > 0)

	return
end

function var_0_1.GetShips(arg_21_0, arg_21_1)
	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_21_0 = var_1_10002(var_1_10003)
	local var_21_1 = var_2.CanUseShareSkinPhantoms(var_21_0, arg_21_1)

	table = var_21_0

	local var_21_2 = var_21_0.sort
	local var_21_3 = var_21_1

	CompareFuncs = var_1_10005

	var_21_2(var_21_3, var_1_10005({
		function(arg_22_0)
			return arg_22_0:getSkinId() == arg_21_1 and 1 or 0
		end,
		function(arg_23_0)
			return -arg_23_0.level
		end,
		function(arg_24_0)
			return -arg_24_0:getStar()
		end,
		function(arg_25_0)
			return arg_25_0.inFleet and 0 or 1
		end,
		function(arg_26_0)
			return arg_26_0.createTime
		end
	}))

	return var_21_1
end

function var_0_1.onBackPressed(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.CriMgr.GetInstance()
	local var_27_1 = var_1.PlaySoundEffect_V3

	SFX_CANCEL = var_1_10003

	var_27_1(var_27_0, var_1_10003)

	if arg_27_0.isInView then
		arg_27_0:hidePaintView(true)

		return
	end

	local var_27_2 = arg_27_0.selectShipPage

	if var_1.isShowing(var_27_2) then
		local var_27_3 = arg_27_0.selectShipPage

		var_1.Hide(var_27_3)

		return
	end

	isActive = var_1

	if var_1(arg_27_0.clickTF) then
		triggerButton = var_1

		var_1(arg_27_0.clickTF)
	end

	return
end

function var_0_1.onSwitch(arg_28_0, arg_28_1, arg_28_2)
	onButton = var_1_10003

	var_1_10003(arg_28_0, arg_28_1, function()
		if arg_28_2 then
			local var_29_0 = arg_28_0

			var_0.openSelectPanel(var_29_0)
		else
			pg = var_0

			local var_29_1 = var_0.TipsMgr.GetInstance()
			local var_29_2 = var_0.ShowTips

			i18n = var_2_10002

			var_29_2(var_29_1, var_2_10002("err_cloth_change_noship", arg_28_0.shipName))
		end

		return
	end)

	return
end

function var_0_1.paintView(arg_30_0)
	local var_30_0 = {}
	local var_30_1 = arg_30_0._shake.childCount
	local var_30_2 = 0

	while var_30_2 < var_30_1 do
		local var_30_3 = arg_30_0._shake

		if var_1_10004.GetChild(var_30_3, var_30_2).gameObject.activeSelf and var_1_10004 ~= arg_30_0._paintingTF and var_1_10004 ~= arg_30_0._bg then
			var_30_0[#var_30_0 + 1] = var_1_10004
			setActive = var_5

			var_5(var_1_10004, false)
		end

		var_30_2 = var_30_2 + 1
	end

	openPortrait = var_1_10004

	var_1_10004()

	local var_30_4 = arg_30_0._paintingTF.anchoredPosition.x
	local var_30_5 = var_4.anchoredPosition.y
	local var_30_6 = var_4.rect.width
	local var_30_7 = var_4.rect.height
	local var_30_8 = arg_30_0._tf.rect.width

	UnityEngine = var_1_10010

	local var_30_9 = var_30_8 / var_1_10010.Screen.width
	local var_30_10 = arg_30_0._tf.rect.height

	UnityEngine = var_1_10011

	local var_30_11 = var_30_10 / var_1_10011.Screen.height
	local var_30_12 = var_30_6 / 2
	local var_30_13 = var_30_7 / 2
	local var_30_14
	local var_30_15

	LeanTween = var_1_10015

	local var_30_16 = var_1_10015.isTweening

	go = var_1_10016

	local var_30_17

	if not var_30_16(var_1_10016(var_4)) then
		LeanTween = var_30_17
		var_30_17 = var_30_17.moveX
		rtf = var_16

		local var_30_18 = var_30_17(var_16(var_4), 150, 0.5)

		var_30_17 = var_30_17.setEase
		LeanTweenType = var_17

		var_30_17(var_30_18, var_17.easeInOutSine)
	end

	GetOrAddComponent = var_30_17

	local var_30_19 = var_30_17(arg_30_0._bg, "MultiTouchZoom")

	var_15.SetZoomTarget(var_30_19, arg_30_0._paintingTF)

	GetOrAddComponent = var_16

	local var_30_20 = var_16(arg_30_0._bg, "EventTriggerListener")
	local var_30_21 = true

	var_15.enabled = true
	var_30_20.enabled = true

	local var_30_22 = false

	var_30_20:AddPointDownFunc(function(arg_31_0)
		Input = var_2_10001

		if var_2_10001.touchCount ~= 1 then
			IsUnityEditor = var_1

			if var_1 then
				var_30_22 = true
				var_30_21 = true
			else
				Input = var_1

				if var_1.touchCount >= 2 then
					var_30_21 = false
					var_30_22 = false
				end
			end

			return
		end
	end)
	var_30_20:AddPointUpFunc(function(arg_32_0)
		Input = var_2_10001

		if var_2_10001.touchCount <= 2 then
			var_30_21 = true
		end

		return
	end)
	var_30_20:AddBeginDragFunc(function(arg_33_0, arg_33_1)
		var_30_22 = false

		local var_33_0 = arg_33_1.position.x * var_30_9 - var_30_12

		tf = var_3
		var_30_14 = var_33_0 - var_3(arg_30_0._paintingTF).localPosition.x

		local var_33_1 = arg_33_1.position.y * var_30_11 - var_30_13

		tf = var_3
		var_30_15 = var_33_1 - var_3(arg_30_0._paintingTF).localPosition.y

		return
	end)
	var_30_20:AddDragFunc(function(arg_34_0, arg_34_1)
		if var_30_21 then
			tf = var_2

			local var_34_0 = var_2(arg_30_0._paintingTF).localPosition

			tf = var_3

			local var_34_1 = var_3(arg_30_0._paintingTF)

			Vector3 = var_4
			var_34_1.localPosition = var_4(arg_34_1.position.x * var_30_9 - var_30_12 - var_30_14, arg_34_1.position.y * var_30_11 - var_30_13 - var_30_15, -22)
		end

		return
	end)

	onButton = var_19

	local var_30_23 = arg_30_0
	local var_30_24 = arg_30_0._bg

	local function var_30_25()
		local var_35_0 = arg_30_0

		var_0.hidePaintView(var_35_0)

		return
	end

	SFX_CANCEL = var_1_10023

	var_19(var_30_23, var_30_24, var_30_25, var_1_10023)

	function var_0_1.hidePaintView(arg_36_0, arg_36_1)
		if not arg_36_1 and not var_30_22 then
			return
		end

		var_30_20.enabled = false

		local var_36_0 = var_0

		var_36_0.enabled = false
		RemoveComponent = var_36_0

		var_36_0(arg_36_0._bg, "Button")

		ipairs = var_36_0

		for iter_36_0, iter_36_1 in var_36_0(var_30_0) do
			setActive = var_2_10007

			var_2_10007(iter_36_1, true)
		end

		closePortrait = var_2

		var_2()

		LeanTween = var_2

		local var_36_1 = var_2.cancel

		go = var_3

		var_36_1(var_3(arg_36_0._paintingTF))

		local var_36_2 = arg_36_0._paintingTF

		Vector3 = var_3
		var_36_2.localScale = var_3(1, 1, 1)
		setAnchoredPosition = var_36_2

		var_36_2(arg_36_0._paintingTF, {
			x = var_30_4,
			y = var_30_5
		})

		arg_36_0.isInView = false
		setActive = var_2

		var_2(arg_36_0.clickTF, true)

		return
	end

	return
end

function var_0_1.recyclePainting(arg_37_0)
	if arg_37_0._shipVO then
		retPaintingPrefab = var_1

		local var_37_0 = arg_37_0._paintingTF
		local var_37_1 = arg_37_0._shipVO

		var_1(var_37_0, var_3.getPainting(var_37_1))
	end

	return
end

function var_0_1.openSelectPanel(arg_38_0)
	local var_38_0 = arg_38_0.selectShipPage
	local var_38_1 = var_1.ExecuteAction
	local var_38_2 = "Show"

	ShipSkin = var_1_10004

	var_38_1(var_38_0, var_38_2, var_1_10004.New({
		id = arg_38_0.contextData.skinId
	}))

	return
end

function var_0_1.updateShipCards(arg_39_0)
	pairs = var_1_10001

	local var_39_0

	if not arg_39_0.shipCards then
		var_39_0 = {}
	end

	for iter_39_0, iter_39_1 in var_1_10001(var_39_0) do
		if arg_39_0.sameShipVOs[iter_39_0] then
			iter_39_1:update(var_6, arg_39_0.contextData.skinId)
		end
	end

	return
end

function var_0_1.playOpening(arg_40_0, arg_40_1, arg_40_2)
	pg = var_1_10003

	local var_40_0 = var_1_10003.CpkPlayMgr.GetInstance()

	var_3.PlayCpkMovie(var_40_0, function()
		return
	end, function()
		if arg_40_1 then
			arg_40_1()
		end

		return
	end, "ui/skinunlockanim", arg_40_2, false, false)

	return
end

function var_0_1.willExit(arg_43_0)
	pg = var_1_10001

	local var_43_0 = var_1_10001.CpkPlayMgr.GetInstance()

	var_1.DisposeCpkMovie(var_43_0)

	local var_43_1 = arg_43_0._skinConfig.ship_group * 10 + 1

	pg = var_43_0

	local var_43_2 = var_43_0.ship_data_statistics[var_43_1]

	pg = var_1_10003

	local var_43_3 = var_1_10003.TipsMgr.GetInstance()
	local var_43_4 = var_3.ShowTips

	i18n = var_1_10005

	local var_43_5 = var_1_10005("ship_newSkinLayer_get", var_43_2.name, arg_43_0._skinConfig.name)

	COLOR_GREEN = var_6

	var_43_4(var_43_3, var_43_5, var_6)
	arg_43_0:recyclePainting()

	pg = var_3

	local var_43_6 = var_3.UIMgr.GetInstance()

	var_3.UnOverlayPanel(var_43_6, arg_43_0._tf)
	arg_43_0:stopVoice()

	if arg_43_0.loadedCVBankName then
		pg = var_3

		var_3.CriMgr.UnloadCVBank(arg_43_0.loadedCVBankName)

		arg_43_0.loadedCVBankName = nil
	end

	local var_43_7 = arg_43_0.selectShipPage

	var_3.Destroy(var_43_7)

	cameraPaintViewAdjust = var_3

	var_3(false)

	return
end

return var_0_1
