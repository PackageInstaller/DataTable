class = var_0_10000

local var_0_0 = var_0_10000("DecodeGameView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)

	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	arg_2_0._tf = arg_2_1
	go = var_1_10002
	arg_2_0._go = var_1_10002(arg_2_1)

	local var_2_0 = arg_2_0._tf

	arg_2_0.mapItemContainer = var_2.Find(var_2_0, "game/container")
	UIItemList = var_2

	local var_2_1 = var_2.New
	local var_2_2 = arg_2_0.mapItemContainer
	local var_2_3 = arg_2_0._tf

	arg_2_0.itemList = var_2_1(var_2_2, var_4.Find(var_2_3, "game/container/tpl"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.mapLine = var_2.Find(var_2_4, "game/line")
	setActive = var_2

	var_2(arg_2_0.mapLine, false)

	local var_2_5 = {}
	local var_2_6 = arg_2_0._tf

	var_2_5[1] = var_3.Find(var_2_6, "btn/btn1")

	local var_2_7 = arg_2_0._tf

	var_2_5[2] = var_3.Find(var_2_7, "btn/btn2")

	local var_2_8 = arg_2_0._tf

	var_2_5[3] = var_3.Find(var_2_8, "btn/btn3")
	arg_2_0.mapBtns = var_2_5

	local var_2_9 = {}
	local var_2_10 = arg_2_0._tf

	var_2_9[1] = var_3.Find(var_2_10, "tuitong/1")

	local var_2_11 = arg_2_0._tf

	var_2_9[2] = var_3.Find(var_2_11, "tuitong/2")

	local var_2_12 = arg_2_0._tf

	var_2_9[3] = var_3.Find(var_2_12, "tuitong/3")
	arg_2_0.engines = var_2_9

	local var_2_13 = arg_2_0._tf

	arg_2_0.engineBottom = var_2.Find(var_2_13, "tuitong/4")

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "shuzi/1")
	local var_2_16 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_2_0.number1 = var_2_16(var_2_15, var_4(var_5))

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_2.Find(var_2_17, "shuzi/2")
	local var_2_19 = var_2.GetComponent

	typeof = var_4
	Image = var_5
	arg_2_0.number2 = var_2_19(var_2_18, var_4(var_5))

	local var_2_20 = arg_2_0._tf

	arg_2_0.awardProgressTF = var_2.Find(var_2_20, "zhuanpanxinxi/jindu")

	local var_2_21 = arg_2_0._tf

	arg_2_0.awardProgress1TF = var_2.Find(var_2_21, "zhuanpanxinxi/jindu/zhuanpan")

	local var_2_22 = {}
	local var_2_23 = arg_2_0._tf

	var_2_22[1] = var_3.Find(var_2_23, "zhuanpanxinxi/deng1")

	local var_2_24 = arg_2_0._tf

	var_2_22[2] = var_3.Find(var_2_24, "zhuanpanxinxi/deng2")

	local var_2_25 = arg_2_0._tf

	var_2_22[3] = var_3.Find(var_2_25, "zhuanpanxinxi/deng3")
	arg_2_0.mapProgreeses = var_2_22

	local var_2_26 = {}
	local var_2_27 = arg_2_0._tf

	var_2_26[1] = var_3.Find(var_2_27, "dengguang/code1/1")

	local var_2_28 = arg_2_0._tf

	var_2_26[2] = var_3.Find(var_2_28, "dengguang/code1/2")

	local var_2_29 = arg_2_0._tf

	var_2_26[3] = var_3.Find(var_2_29, "dengguang/code1/3")

	local var_2_30 = arg_2_0._tf

	var_2_26[4] = var_3.Find(var_2_30, "dengguang/code1/4")

	local var_2_31 = arg_2_0._tf

	var_2_26[5] = var_3.Find(var_2_31, "dengguang/code1/5")

	local var_2_32 = arg_2_0._tf

	var_2_26[6] = var_3.Find(var_2_32, "dengguang/code1/6")
	arg_2_0.mapPasswords = var_2_26

	local var_2_33 = arg_2_0._tf

	arg_2_0.encodingPanel = var_2.Find(var_2_33, "encoding")

	local var_2_34 = arg_2_0._tf

	arg_2_0.encodingSlider = var_2.Find(var_2_34, "encoding/slider/bar")
	setActive = var_2

	var_2(arg_2_0.encodingPanel, false)

	local var_2_35 = arg_2_0._tf

	arg_2_0.enterAnim = var_2.Find(var_2_35, "enter_anim")

	local var_2_36 = arg_2_0._tf

	arg_2_0.enterAnimTop = var_2.Find(var_2_36, "enter_anim/top")

	local var_2_37 = arg_2_0._tf

	arg_2_0.enterAnimBottom = var_2.Find(var_2_37, "enter_anim/bottom")
	setActive = var_2

	var_2(arg_2_0.enterAnim, false)

	local var_2_38 = arg_2_0._tf

	arg_2_0.bookBtn = var_2.Find(var_2_38, "btn/mima/unlock")

	local var_2_39 = arg_2_0._tf

	arg_2_0.mimaLockBtn = var_2.Find(var_2_39, "btn/mima/lock")

	local var_2_40 = arg_2_0._tf

	arg_2_0.mimaLockBlink = var_2.Find(var_2_40, "btn/mima/blink")

	local var_2_41 = arg_2_0._tf

	arg_2_0.code1Panel = var_2.Find(var_2_41, "dengguang/code1")

	local var_2_42 = arg_2_0._tf

	arg_2_0.code2Panel = var_2.Find(var_2_42, "dengguang/code2")

	local var_2_43 = arg_2_0._tf

	arg_2_0.passWordTF = var_2.Find(var_2_43, "game/password")
	arg_2_0.containerSize = arg_2_0.mapItemContainer.sizeDelta

	local var_2_44 = arg_2_0._tf

	arg_2_0.mosaic = var_2.Find(var_2_44, "game/Mosaic")

	local var_2_45 = arg_2_0._tf

	arg_2_0.lines = var_2.Find(var_2_45, "game/grids")

	local var_2_46 = {}
	local var_2_47 = arg_2_0._tf

	var_2_46[1] = var_3.Find(var_2_47, "dengguang/code2/1")

	local var_2_48 = arg_2_0._tf

	var_2_46[2] = var_3.Find(var_2_48, "dengguang/code2/2")

	local var_2_49 = arg_2_0._tf

	var_2_46[3] = var_3.Find(var_2_49, "dengguang/code2/3")

	local var_2_50 = arg_2_0._tf

	var_2_46[4] = var_3.Find(var_2_50, "dengguang/code2/4")

	local var_2_51 = arg_2_0._tf

	var_2_46[5] = var_3.Find(var_2_51, "dengguang/code2/5")

	local var_2_52 = arg_2_0._tf

	var_2_46[6] = var_3.Find(var_2_52, "dengguang/code2/6")

	local var_2_53 = arg_2_0._tf

	var_2_46[7] = var_3.Find(var_2_53, "dengguang/code2/7")

	local var_2_54 = arg_2_0._tf

	var_2_46[8] = var_3.Find(var_2_54, "dengguang/code2/8")

	local var_2_55 = arg_2_0._tf

	var_2_46[9] = var_3.Find(var_2_55, "dengguang/code2/9")
	arg_2_0.code2 = var_2_46

	local var_2_56 = arg_2_0._tf

	arg_2_0.lightRight = var_2.Find(var_2_56, "dengguang/code2/light_right")

	local var_2_57 = arg_2_0._tf

	arg_2_0.lightLeft = var_2.Find(var_2_57, "dengguang/code2/light_left")

	local var_2_58 = arg_2_0._tf

	arg_2_0.awardLock = var_2.Find(var_2_58, "zhuanpanxinxi/item/lock")

	local var_2_59 = arg_2_0._tf

	arg_2_0.awardGot = var_2.Find(var_2_59, "zhuanpanxinxi/item/got")
	arg_2_0.screenHeight = arg_2_0._tf.rect.height

	local var_2_60 = arg_2_0.engineBottom

	Vector3 = var_2_59
	var_2_60.localPosition = var_2_59(arg_2_0.engineBottom.localPosition.x, -arg_2_0.screenHeight / 2, 0)

	local var_2_61 = arg_2_0.code2Panel

	Vector3 = var_3
	var_2_61.localPosition = var_3(arg_2_0.code2Panel.localPosition.x, arg_2_0.screenHeight / 2, 0)

	local var_2_62 = arg_2_0._tf

	arg_2_0.line1 = var_2.Find(var_2_62, "game/lines/line1")
	arg_2_0.blinkFlag = false

	local var_2_63 = arg_2_0._tf

	arg_2_0.helperTF = var_2.Find(var_2_63, "helper")

	local var_2_64 = arg_2_0._tf

	arg_2_0.tips = var_2.Find(var_2_64, "btn/tips")
	arg_2_0.animCallbacks = {}

	local var_2_65 = arg_2_0._tf

	arg_2_0.decodeTV = var_2.Find(var_2_65, "game/zhezhao/DecodeTV")

	local var_2_66 = arg_2_0.decodeTV
	local var_2_67 = var_2.GetComponent

	typeof = var_4
	Animator = var_5
	arg_2_0.anim = var_2_67(var_2_66, var_4(var_5))

	local var_2_68 = arg_2_0.decodeTV
	local var_2_69 = var_2.GetComponent

	typeof = var_4
	DftAniEvent = var_5
	arg_2_0.dftAniEvent = var_2_69(var_2_68, var_4(var_5))

	local var_2_70 = arg_2_0.dftAniEvent

	var_2.SetEndEvent(var_2_70, function(arg_3_0)
		ipairs = var_2_10001

		for iter_3_0, iter_3_1 in var_2_10001(arg_2_0.animCallbacks) do
			iter_3_1()
		end

		local var_3_0 = arg_2_0

		var_3_0.animCallbacks = {}
		setActive = var_3_0

		var_3_0(arg_2_0.decodeTV, false)

		return
	end)

	arg_2_0.codeHeight = arg_2_0.screenHeight / 2 - arg_2_0.code1Panel.anchoredPosition.y

	local var_2_71 = arg_2_0.code2Panel

	Vector2 = var_3
	var_2_71.sizeDelta = var_3(arg_2_0.code2Panel.sizeDelta.x, arg_2_0.codeHeight)

	local var_2_72 = arg_2_0.code1Panel

	Vector2 = var_3
	var_2_72.sizeDelta = var_3(arg_2_0.code1Panel.sizeDelta.x, arg_2_0.codeHeight)

	return
end

function var_0_0.DoEnterAnim(arg_4_0, arg_4_1)
	setActive = var_1_10002

	var_1_10002(arg_4_0.enterAnim, true)

	LeanTween = var_1_10002

	local var_4_0 = var_1_10002.moveLocalY

	go = var_3

	local var_4_1 = var_4_0(var_3(arg_4_0.enterAnimTop), arg_4_0.screenHeight / 2, 1)
	local var_4_2 = var_2.setFrom(var_4_1, -75)
	local var_4_3 = var_2.setDelay

	DecodeGameConst = var_4

	var_4_3(var_4_2, var_4.OPEN_DOOR_DELAY)

	LeanTween = var_4_3

	local var_4_4 = var_4_3.moveLocalY

	go = var_4_2

	local var_4_5 = var_4_4(var_4_2(arg_4_0.enterAnimBottom), -arg_4_0.screenHeight / 2, 1)
	local var_4_6 = var_2.setFrom(var_4_5, 75)
	local var_4_7 = var_2.setDelay

	DecodeGameConst = var_4

	local var_4_8 = var_4_7(var_4_6, var_4.OPEN_DOOR_DELAY)
	local var_4_9 = var_2.setOnComplete

	System = var_4

	var_4_9(var_4_8, var_4.Action(function()
		arg_4_1()

		setActive = var_0

		var_0(arg_4_0.enterAnim, false)

		return
	end))

	updateDrop = var_4_9

	local var_4_10 = arg_4_0._tf
	local var_4_11 = var_3.Find(var_4_10, "zhuanpanxinxi/item")
	local var_4_12 = {}

	DecodeGameConst = var_5
	var_4_12.id = var_5.AWARD[2]
	DecodeGameConst = var_5
	var_4_12.type = var_5.AWARD[1]
	DecodeGameConst = var_5
	var_4_12.count = var_5.AWARD[3]

	var_4_9(var_4_11, var_4_12)

	return
end

function var_0_0.Inited(arg_6_0, arg_6_1)
	onButton = var_1_10002

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0._tf
	local var_6_2 = var_4.Find(var_6_1, "btn/back")

	local function var_6_3()
		local var_7_0 = arg_6_0.controller

		var_0.ExitGame(var_7_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10002(var_6_0, var_6_2, var_6_3, var_6)

	onButton = var_1_10002

	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_4.Find(var_6_5, "btn/help")

	local function var_6_7()
		pg = var_2_10000

		local var_8_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_8_1 = var_0.ShowMsgBox
		local var_8_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_8_2.type = var_2_10003
		pg = var_2_10003
		var_8_2.helps = var_2_10003.gametip.decodegame_gametip.tip

		var_8_1(var_8_0, var_8_2)

		return
	end

	SFX_PANEL = var_6

	var_1_10002(var_6_4, var_6_6, var_6_7, var_6)

	arg_6_0.ison = false
	onButton = var_2

	var_2(arg_6_0, arg_6_0.bookBtn, function()
		local var_9_0 = arg_6_0.controller

		if var_0.CanSwitch(var_9_0) then
			arg_6_0.ison = not arg_6_0.ison

			local var_9_1 = arg_6_0.controller

			var_0.SwitchToDecodeMap(var_9_1, arg_6_0.ison)

			setActive = var_0

			local var_9_2 = arg_6_0.bookBtn

			var_0(var_1.Find(var_9_2, "Image"), arg_6_0.ison)
		end

		return
	end)

	ipairs = var_2

	for iter_6_0, iter_6_1 in var_2(arg_6_0.mapBtns) do
		onButton = var_1_10007

		var_1_10007(arg_6_0, iter_6_1, function()
			local var_10_0 = arg_6_0.controller

			var_0.SwitchMap(var_10_0, iter_6_0)

			return
		end)
	end

	setActive = var_2

	var_2(arg_6_0.awardLock, not arg_6_1)

	setActive = var_2

	var_2(arg_6_0.awardGot, arg_6_1)

	return
end

function var_0_0.UpdateMap(arg_11_0, arg_11_1)
	arg_11_0.mapItems = {}

	local var_11_0 = arg_11_0.itemList

	var_2.make(var_11_0, function(arg_12_0, arg_12_1, arg_12_2)
		UIItemList = var_2_10003

		if arg_12_0 == var_2_10003.EventUpdate then
			local var_12_0 = arg_11_1.items[arg_12_1 + 1]
			local var_12_1 = arg_11_0

			var_4.UpdateMapItem(var_12_1, arg_12_2, arg_11_1, var_12_0, arg_12_1 + 1)
		end

		return
	end)

	local var_11_1 = arg_11_0.itemList

	var_2.align(var_11_1, #arg_11_1.items)

	_ = var_2

	local var_11_2 = var_2.flatten(arg_11_1.password)

	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_0.mapPasswords) do
		local var_11_3 = "-"

		if arg_11_1.isUnlock then
			var_11_3 = var_11_2[iter_11_0]
		end

		local var_11_4 = iter_11_1
		local var_11_5 = iter_11_1.GetComponent

		typeof = var_1_10011
		Image = var_1_10012

		local var_11_6 = var_11_5(var_11_4, var_1_10011(var_1_10012))

		GetSpriteFromAtlas = var_11_4
		var_11_6.sprite = var_11_4("ui/DecodeGameNumber_atlas", var_11_3 .. "-1")
	end

	setActive = var_3

	var_3(arg_11_0.mosaic, not arg_11_1.isUnlock)

	return
end

function var_0_0.UpdateMapItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	local var_13_0 = arg_13_2.id

	arg_13_1.localPosition = arg_13_3.position
	go = var_6
	var_6(arg_13_1).name = arg_13_3.index

	local var_13_1 = arg_13_1:Find("rect/icon")
	local var_13_2 = var_6.GetComponent

	typeof = var_1_10009
	Image = var_1_10010

	local var_13_3 = var_13_2(var_13_1, var_1_10009(var_1_10010))
	local var_13_4

	if not arg_13_2.isUnlock or not arg_13_4 then
		::label_13_0::

		DecodeGameConst = var_13_4
		var_13_4 = var_13_4.DISORDER[arg_13_4]
	end

	GetSpriteFromAtlas = var_9

	local var_13_5 = "puzzla/bg_"

	DecodeGameConst = var_1_10011
	var_13_3.sprite = var_9(var_13_5 .. var_13_0 + var_1_10011.MAP_NAME_OFFSET, var_13_0 .. "-" .. var_13_4)

	var_13_3:SetNativeSize()

	local var_13_6 = var_6
	local var_13_7 = var_6.GetComponent

	typeof = var_11
	CanvasGroup = var_12
	var_13_7(var_13_6, var_11(var_12)).alpha = arg_13_3.isUnlock and 1 or 0
	setActive = var_10

	var_10(arg_13_1:Find("rays"), false)

	setActive = var_10

	var_10(arg_13_1:Find("rays/yellow"), false)

	setActive = var_10

	var_10(arg_13_1:Find("rays/blue"), false)

	onButton = var_10

	local var_13_8 = arg_13_0
	local var_13_9 = arg_13_1

	local function var_13_10()
		local var_14_0 = arg_13_0.controller

		var_0.Unlock(var_14_0, arg_13_3.index)

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_13_8, var_13_9, var_13_10, var_1_10014)

	arg_13_0.mapItems[arg_13_3.index] = arg_13_1

	return
end

function var_0_0.OnMapRepairing(arg_15_0, arg_15_1)
	pg = var_1_10002

	local var_15_0 = var_1_10002.UIMgr.GetInstance()

	var_2.BlurPanel(var_15_0, arg_15_0.encodingPanel)

	setActive = var_2

	var_2(arg_15_0.encodingPanel, true)

	LeanTween = var_2

	local var_15_1 = var_2.value

	go = var_3

	local var_15_2 = var_3(arg_15_0.encodingSlider)
	local var_15_3 = 0
	local var_15_4 = 1

	DecodeGameConst = var_1_10006

	local var_15_5 = var_15_1(var_15_2, var_15_3, var_15_4, var_1_10006.DECODE_MAP_TIME)
	local var_15_6 = var_2.setOnUpdate

	System = var_15_3

	local var_15_7 = var_15_6(var_15_5, var_15_3.Action_float(function(arg_16_0)
		setFillAmount = var_2_10001

		var_2_10001(arg_15_0.encodingSlider, arg_16_0)

		return
	end))
	local var_15_8 = var_2.setOnComplete

	System = var_4

	var_15_8(var_15_7, var_4.Action(function()
		pg = var_2_10000

		local var_17_0 = var_2_10000.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_17_0, arg_15_0.encodingPanel, arg_15_0._tf)

		setActive = var_0

		var_0(arg_15_0.encodingPanel, false)
		arg_15_1()

		return
	end))

	return
end

function var_0_0.OnSwitch(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	local var_18_0 = arg_18_0.mapBtns[arg_18_1]
	local var_18_1 = arg_18_0.engines[arg_18_1]

	assert = var_1_10010

	var_1_10010(var_18_1, arg_18_1)

	go = var_1_10010

	local var_18_2 = var_1_10010(var_18_1:Find("xinx"))
	local var_18_3 = var_18_1:Find("tui").sizeDelta.y

	LeanTween = var_13

	local var_18_4 = var_13.moveLocalX
	local var_18_5 = var_18_2
	local var_18_6 = arg_18_2

	DecodeGameConst = var_1_10016

	local var_18_7 = var_18_4(var_18_5, var_18_6, var_1_10016.SWITCH_MAP)

	var_13.setFrom(var_18_7, arg_18_3)

	LeanTween = var_13

	local var_18_8 = var_13.value

	go = var_18_7

	local var_18_9 = var_18_7(var_11)
	local var_18_10 = arg_18_4
	local var_18_11 = arg_18_5

	DecodeGameConst = var_1_10017

	local var_18_12 = var_18_8(var_18_9, var_18_10, var_18_11, var_1_10017.SWITCH_MAP)
	local var_18_13 = var_13.setOnUpdate

	System = var_18_10

	var_18_13(var_18_12, var_18_10.Action_float(function(arg_19_0)
		local var_19_0 = var_0

		Vector2 = var_2_10002
		var_19_0.sizeDelta = var_2_10002(arg_19_0, var_18_3)

		return
	end))

	LeanTween = var_18_13

	local var_18_14 = var_18_13.rotateZ

	go = var_18_12

	local var_18_15 = var_18_12(var_18_0)
	local var_18_16 = arg_18_6

	DecodeGameConst = var_16

	local var_18_17 = var_18_14(var_18_15, var_18_16, var_16.SWITCH_MAP)
	local var_18_18 = var_13.setOnComplete

	System = var_18_16

	var_18_18(var_18_17, var_18_16.Action(arg_18_7))

	return
end

function var_0_0.OnExitMap(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 then
		local var_20_0 = arg_20_0.mapItemContainer

		Vector2 = var_1_10005
		var_20_0.sizeDelta = var_1_10005(arg_20_0.containerSize.x, 0)
	end

	arg_20_0:OnSwitch(arg_20_1, -11, -150, 158, 23, 0, arg_20_3)

	return
end

function var_0_0.OnEnterMap(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	parallelAsync = var_1_10004

	var_1_10004({
		function(arg_22_0)
			local var_22_0 = arg_21_0

			var_1.OnSwitch(var_22_0, arg_21_1, -150, -11, 23, 158, 90, function()
				arg_22_0()

				return
			end)

			return
		end,
		function(arg_24_0)
			if not arg_21_2 then
				arg_24_0()

				return
			end

			setActive = var_1

			var_1(arg_21_0.mapLine, true)

			LeanTween = var_1

			local var_24_0 = var_1.value

			go = var_2

			local var_24_1 = var_2(arg_21_0.mapItemContainer)
			local var_24_2 = 0
			local var_24_3 = arg_21_0.containerSize.y

			DecodeGameConst = var_2_10005

			local var_24_4 = var_24_0(var_24_1, var_24_2, var_24_3, var_2_10005.SCAN_MAP_TIME)
			local var_24_5 = var_1.setOnUpdate

			System = var_24_2

			local var_24_6 = var_24_5(var_24_4, var_24_2.Action_float(function(arg_25_0)
				local var_25_0 = arg_21_0.mapItemContainer

				Vector2 = var_3_10002
				var_25_0.sizeDelta = var_3_10002(arg_21_0.containerSize.x, arg_25_0)

				return
			end))
			local var_24_7 = var_1.setOnComplete

			System = var_3

			var_24_7(var_24_6, var_3.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_21_0.mapLine, false)
				arg_24_0()

				return
			end))

			LeanTween = var_24_7

			local var_24_8 = var_24_7.value

			go = var_24_6

			local var_24_9 = var_24_6(arg_21_0.mapLine)
			local var_24_10 = 286
			local var_24_11 = 30 - arg_21_0.containerSize.y

			DecodeGameConst = var_5

			local var_24_12 = var_24_8(var_24_9, var_24_10, var_24_11, var_5.SCAN_MAP_TIME)
			local var_24_13 = var_1.setOnUpdate

			System = var_24_10

			var_24_13(var_24_12, var_24_10.Action_float(function(arg_27_0)
				local var_27_0 = arg_21_0.mapLine

				Vector2 = var_3_10002
				var_27_0.localPosition = var_3_10002(arg_21_0.mapLine.localPosition.x, arg_27_0, 0)

				return
			end))

			return
		end
	}, arg_21_3)

	return
end

function var_0_0.UnlockMapItem(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.mapItems[arg_28_1]

	assert = var_1_10004

	var_1_10004(var_28_0)

	local var_28_1 = var_28_0:Find("rect/icon")
	local var_28_2 = var_4.GetComponent

	typeof = var_1_10007
	CanvasGroup = var_1_10008

	local var_28_3 = var_28_2(var_28_1, var_1_10007(var_1_10008))

	LeanTween = var_28_1

	local var_28_4 = var_28_1.value

	go = var_7

	local var_28_5 = var_28_4(var_7(var_4), 0, 1, 0.3)
	local var_28_6 = var_6.setOnUpdate

	System = var_8

	local var_28_7 = var_28_6(var_28_5, var_8.Action_float(function(arg_29_0)
		var_28_3.alpha = arg_29_0

		return
	end))
	local var_28_8 = var_6.setOnComplete

	System = var_8

	var_28_8(var_28_7, var_8.Action(arg_28_2))

	return
end

function var_0_0.UpdateCanUseCnt(arg_30_0, arg_30_1)
	math = var_1_10002

	local var_30_0 = var_1_10002.floor(arg_30_1 / 10)
	local var_30_1 = arg_30_1 % 10
	local var_30_2 = arg_30_0.number1

	GetSpriteFromAtlas = var_1_10005
	var_30_2.sprite = var_1_10005("ui/DecodeGameNumber_atlas", var_30_0)

	local var_30_3 = arg_30_0.number2

	GetSpriteFromAtlas = var_5
	var_30_3.sprite = var_5("ui/DecodeGameNumber_atlas", var_30_1)
	tf = var_30_3

	local var_30_4 = var_30_3(arg_30_0.number1)

	if var_30_0 == 1 then
		Vector3 = var_30_5

		local var_30_5

		if not var_30_5(-625, -17) then
			Vector3 = var_30_5
			var_30_5 = var_30_5(-660, -17)
		end

		var_30_4.localPosition = var_30_5
		tf = var_30_4

		local var_30_6 = var_30_4(arg_30_0.number2)

		if var_30_1 == 1 then
			Vector3 = var_30_7

			local var_30_7

			if not var_30_7(-516.8, -17) then
				Vector3 = var_30_7
				var_30_7 = var_30_7(-546.3, -17)
			end

			var_30_6.localPosition = var_30_7

			return
		end
	end
end

function var_0_0.UpdateProgress(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	local var_31_0 = arg_31_1

	DecodeGameConst = var_1_10006

	local var_31_1 = var_1_10006.MAP_ROW

	DecodeGameConst = var_1_10007

	local var_31_2 = var_31_1 * var_1_10007.MAP_COLUMN

	DecodeGameConst = var_7

	local var_31_3

	if var_31_0 < var_31_2 * var_7.MAX_MAP_COUNT then
		setFillAmount = var_6
		var_31_3 = arg_31_0.awardProgressTF
		DecodeGameConst = var_1_10008

		var_6(var_31_3, var_31_0 * var_1_10008.PROGRESS2FILLAMOUMT)
	else
		setFillAmount = var_6

		var_6(arg_31_0.awardProgressTF, 1)
	end

	local var_31_4 = arg_31_0.awardProgress1TF

	Vector3 = var_31_3

	local var_31_5 = 0
	local var_31_6 = 0

	DecodeGameConst = var_1_10010
	var_31_4.eulerAngles = var_31_3(var_31_5, var_31_6, 180 - var_31_0 * var_1_10010.PROGRESS2ANGLE)
	setActive = var_31_4

	local var_31_7 = arg_31_0.bookBtn

	DecodeGameConst = var_31_5

	var_31_4(var_31_7, arg_31_2 == var_31_5.MAX_MAP_COUNT)

	setActive = var_31_4

	var_31_4(arg_31_0.mapProgreeses[1], arg_31_3[1])

	setActive = var_31_4

	var_31_4(arg_31_0.mapProgreeses[2], arg_31_3[2])

	setActive = var_31_4

	var_31_4(arg_31_0.mapProgreeses[3], arg_31_3[3])

	DecodeGameConst = var_31_4

	local var_31_8, var_31_9

	if arg_31_2 == var_31_4.MAX_MAP_COUNT and not arg_31_0.blinkFlag then
		LeanTween = var_31_8
		var_31_8 = var_31_8.moveLocalX
		go = var_31_9
		var_31_9 = var_31_8(var_31_9(arg_31_0.mimaLockBtn), 150, 0.3)
		var_31_8 = var_31_8.setOnComplete
		System = var_8

		var_31_8(var_31_9, var_8.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_31_0.mimaLockBlink, true)

			blinkAni = var_2_10000
			go = var_1

			local var_32_0 = var_2_10000(var_1(arg_31_0.mimaLockBlink), 0.2, 2)
			local var_32_1 = var_0.setOnComplete

			System = var_2

			var_32_1(var_32_0, var_2.Action(function()
				setActive = var_3_10000

				var_3_10000(arg_31_0.mimaLockBlink, false)
				arg_31_4()

				return
			end))

			return
		end))

		arg_31_0.blinkFlag = true
	else
		DecodeGameConst = var_31_8

		if arg_31_2 == var_31_8.MAX_MAP_COUNT then
			local var_31_10 = arg_31_0.mimaLockBtn

			Vector3 = var_31_9
			var_31_10.localPosition = var_31_9(150, 0, 0)
			setActive = var_31_10

			var_31_10(arg_31_0.mimaLockBlink, false)
		else
			local var_31_11 = arg_31_0.mimaLockBtn

			Vector3 = var_31_9
			var_31_11.localPosition = var_31_9(0, 0, 0)

			arg_31_4()
		end
	end

	return
end

function var_0_0.OnEnterDecodeMapBefore(arg_34_0, arg_34_1)
	setActive = var_1_10002

	var_1_10002(arg_34_0.mosaic, true)

	setActive = var_1_10002

	var_1_10002(arg_34_0.lines, false)

	LeanTween = var_1_10002

	local var_34_0 = var_1_10002.moveLocalY

	go = var_3

	local var_34_1 = var_3(arg_34_0.code1Panel)
	local var_34_2 = arg_34_0.screenHeight / 2

	DecodeGameConst = var_1_10005

	local var_34_3 = var_34_0(var_34_1, var_34_2, var_1_10005.SWITCH_TO_DECODE_TIME / 2)
	local var_34_4 = var_2.setOnComplete

	System = var_34_2

	var_34_4(var_34_3, var_34_2.Action(arg_34_1))

	return
end

function var_0_0.OnEnterDecodeMap(arg_35_0, arg_35_1, arg_35_2)
	parallelAsync = var_1_10003

	var_1_10003({
		function(arg_36_0)
			_ = var_2_10001

			var_2_10001.each(arg_35_0.code2, function(arg_37_0)
				setActive = var_3_10001

				var_3_10001(arg_37_0, false)

				return
			end)

			LeanTween = var_1

			local var_36_0 = var_1.moveLocalY

			go = var_2

			local var_36_1 = var_2(arg_35_0.engineBottom)
			local var_36_2 = -500

			DecodeGameConst = var_2_10004

			var_36_0(var_36_1, var_36_2, var_2_10004.SWITCH_TO_DECODE_TIME / 2)

			LeanTween = var_36_0

			local var_36_3 = var_36_0.moveLocalY

			go = var_36_1

			local var_36_4 = var_36_1(arg_35_0.code2Panel)
			local var_36_5 = 303

			DecodeGameConst = var_4

			local var_36_6 = var_36_3(var_36_4, var_36_5, var_4.SWITCH_TO_DECODE_TIME / 2)
			local var_36_7 = var_1.setOnComplete

			System = var_36_5

			var_36_7(var_36_6, var_36_5.Action(arg_36_0))

			return
		end
	}, function()
		setActive = var_2_10000

		var_2_10000(arg_35_0.mosaic, false)

		setActive = var_2_10000

		var_2_10000(arg_35_0.lines, false)

		ipairs = var_2_10000

		for iter_38_0, iter_38_1 in var_2_10000(arg_35_1) do
			local var_38_0 = arg_35_0

			var_5.UpdatePassWord(var_38_0, iter_38_1, iter_38_0)
		end

		setActive = var_0

		var_0(arg_35_0.passWordTF, true)
		arg_35_2()

		return
	end)

	return
end

function var_0_0.OnEnterNormalMapBefore(arg_39_0, arg_39_1)
	parallelAsync = var_1_10002

	var_1_10002({
		function(arg_40_0)
			LeanTween = var_2_10001

			local var_40_0 = var_2_10001.moveLocalY

			go = var_2_10002

			local var_40_1 = var_2_10002(arg_39_0.code2Panel)
			local var_40_2 = arg_39_0.screenHeight / 2

			DecodeGameConst = var_2_10004

			local var_40_3 = var_40_0(var_40_1, var_40_2, var_2_10004.SWITCH_TO_DECODE_TIME / 2)
			local var_40_4 = var_1.setOnComplete

			System = var_40_2

			var_40_4(var_40_3, var_40_2.Action(arg_40_0))

			return
		end,
		function(arg_41_0)
			LeanTween = var_2_10001

			local var_41_0 = var_2_10001.moveLocalY

			go = var_2_10002

			local var_41_1 = var_2_10002(arg_39_0.engineBottom)
			local var_41_2 = -arg_39_0.screenHeight / 2

			DecodeGameConst = var_2_10004

			local var_41_3 = var_41_0(var_41_1, var_41_2, var_2_10004.SWITCH_TO_DECODE_TIME / 2)
			local var_41_4 = var_1.setOnComplete

			System = var_41_2

			var_41_4(var_41_3, var_41_2.Action(arg_41_0))

			return
		end
	}, arg_39_1)

	return
end

function var_0_0.OnEnterNormalMap(arg_42_0, arg_42_1, arg_42_2)
	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_43_0)
			LeanTween = var_2_10001

			local var_43_0 = var_2_10001.moveLocalY

			go = var_2_10002

			local var_43_1 = var_2_10002(arg_42_0.code1Panel)
			local var_43_2 = 303

			DecodeGameConst = var_2_10004

			local var_43_3 = var_43_0(var_43_1, var_43_2, var_2_10004.SWITCH_TO_DECODE_TIME / 2)
			local var_43_4 = var_1.setOnComplete

			System = var_43_2

			var_43_4(var_43_3, var_43_2.Action(arg_43_0))

			return
		end,
		function(arg_44_0)
			setActive = var_2_10001

			var_2_10001(arg_42_0.passWordTF, false)
			arg_44_0()

			return
		end,
		function(arg_45_0)
			local var_45_0 = arg_42_0.mapItemContainer

			var_45_0.sizeDelta = arg_42_0.containerSize
			ipairs = var_45_0

			for iter_45_0, iter_45_1 in var_45_0(arg_42_1.passwordIndexs) do
				local var_45_1 = arg_42_0.mapItems[iter_45_1]
				local var_45_2 = var_6.Find(var_45_1, "rect/icon")
				local var_45_3 = var_7.GetComponent

				typeof = var_9
				CanvasGroup = var_2_10010

				local var_45_4 = var_45_3(var_45_2, var_9(var_2_10010))

				var_45_4.alpha = 1
				setActive = var_45_4

				var_45_4(var_6:Find("rays"), false)
			end

			arg_45_0()

			return
		end
	}, arg_42_2)

	return
end

function var_0_0.OnDecodeMap(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {}

	local function var_46_1(arg_47_0)
		ipairs = var_2_10001

		for iter_47_0, iter_47_1 in var_2_10001(arg_46_1.items) do
			if iter_47_1.index == arg_47_0 then
				return iter_47_1
			end
		end

		return
	end

	ipairs = var_1_10005

	for iter_46_0, iter_46_1 in var_1_10005(arg_46_1.passwordIndexs) do
		local var_46_2 = arg_46_0.mapItems[iter_46_1]

		var_1_10011 = var_10.Find(var_46_2, "rect").sizeDelta

		local var_46_3 = var_10.localPosition

		Vector2 = var_13

		local var_46_4 = var_13(var_46_3.x + var_1_10011.x / 2, var_46_3.y - var_1_10011.y / 2)

		Vector2 = var_14

		local var_46_5 = var_14(var_46_3.x - var_1_10011.x / 2, var_46_3.y + var_1_10011.y / 2)

		var_10:SetAsLastSibling()

		table = var_15

		var_15.insert(var_46_0, {
			target = var_10,
			sizeDelta = var_1_10011,
			starPosition = var_46_4,
			endPosition = var_46_5,
			item = var_46_1(iter_46_1)
		})
	end

	local function var_46_6()
		Vector2 = var_2_10000

		local var_48_0 = var_2_10000(0, arg_46_0.line1.localPosition.y)

		ipairs = var_1

		for iter_48_0, iter_48_1 in var_1(var_46_0) do
			local var_48_1 = iter_48_1.target
			local var_48_2 = iter_48_1.starPosition
			local var_48_3 = iter_48_1.endPosition
			local var_48_4 = var_48_1:Find("rect").sizeDelta

			if var_48_0.y >= var_48_2.y and var_48_0.y <= var_48_3.y then
				local var_48_5 = var_48_0.y - var_48_2.y

				Vector2 = var_12
				var_9.sizeDelta = var_12(var_48_4.x, iter_48_1.sizeDelta.y - var_48_5)
			end
		end

		return
	end

	setActive = var_6

	var_6(arg_46_0.line1, true)

	DecodeGameConst = var_6

	local var_46_7 = var_6.BLOCK_SIZE[1]

	DecodeGameConst = var_7

	local var_46_8 = var_46_7 * var_7.MAP_ROW

	LeanTween = var_7

	local var_46_9 = var_7.value

	go = var_8

	local var_46_10 = var_8(arg_46_0.line1)
	local var_46_11 = 0
	local var_46_12 = var_46_8

	DecodeGameConst = var_1_10011

	local var_46_13 = var_46_9(var_46_10, var_46_11, var_46_12, var_1_10011.SCAN_GRID_TIME)
	local var_46_14 = var_7.setOnUpdate

	System = var_46_11

	local var_46_15 = var_46_14(var_46_13, var_46_11.Action_float(function(arg_49_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_46_0.line1, {
			y = arg_49_0
		})
		var_46_6()

		return
	end))
	local var_46_16 = var_7.setOnComplete

	System = var_9

	var_46_16(var_46_15, var_9.Action(function()
		setActive = var_2_10000

		var_2_10000(arg_46_0.line1, false)

		ipairs = var_2_10000

		for iter_50_0, iter_50_1 in var_2_10000(var_46_0) do
			local var_50_0 = iter_50_1.target
			local var_50_1 = var_5.Find(var_50_0, "rect/icon")
			local var_50_2 = var_5.GetComponent

			typeof = var_7
			CanvasGroup = var_2_10008
			var_50_2(var_50_1, var_7(var_2_10008)).alpha = 0

			local var_50_3 = iter_50_1.target
			local var_50_4 = var_5.Find(var_50_3, "rect")

			var_50_4.sizeDelta = iter_50_1.sizeDelta
			setActive = var_50_4

			local var_50_5 = iter_50_1.target

			var_50_4(var_6.Find(var_50_5, "rays"), true)

			setActive = var_50_4

			local var_50_6 = iter_50_1.target

			var_50_4(var_6.Find(var_50_6, "rays/blue"), iter_50_1.item.isUsed)
		end

		arg_46_2()

		return
	end))

	return
end

function var_0_0.UpdatePassWord(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 == false then
		return
	end

	local var_51_0 = arg_51_0.code2[arg_51_2]
	local var_51_1 = var_3.GetComponent

	typeof = var_1_10006
	Image = var_1_10007

	local var_51_2 = var_51_1(var_51_0, var_1_10006(var_1_10007))

	GetSpriteFromAtlas = var_51_0
	var_51_2.sprite = var_51_0("ui/DecodeGameNumber_atlas", arg_51_1 .. "-1")
	setActive = var_51_2

	var_51_2(var_3, true)

	return
end

function var_0_0.OnRightCode(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = arg_52_0

	arg_52_0.UpdatePassWord(var_52_0, arg_52_2, arg_52_3)

	local var_52_1 = arg_52_0.mapItems[arg_52_1]

	setActive = var_52_0

	var_52_0(var_52_1:Find("rays/blue"), true)

	setActive = var_52_0

	var_52_0(arg_52_0.lightRight, true)

	Timer = var_52_0
	arg_52_0.timer2 = var_52_0.New(function()
		setActive = var_2_10000

		var_2_10000(arg_52_0.lightRight, false)

		return
	end, 1, 1)

	local var_52_2 = arg_52_0.timer2

	var_5.Start(var_52_2)

	return
end

function var_0_0.OnFalseCode(arg_54_0, arg_54_1)
	arg_54_0:RemoveTimers()

	setActive = var_2

	var_2(arg_54_0.lightLeft, true)

	Timer = var_2
	arg_54_0.timer1 = var_2.New(function()
		setActive = var_2_10000

		var_2_10000(arg_54_0.lightLeft, false)

		return
	end, 1, 1)

	local var_54_0 = arg_54_0.timer1

	var_2.Start(var_54_0)

	local var_54_1 = arg_54_0.mapItems[arg_54_1]
	local var_54_2 = var_2.Find(var_54_1, "rays/yellow")

	setActive = var_54_1

	var_54_1(var_54_2, true)

	blinkAni = var_54_1

	local var_54_3 = var_54_1(var_54_2, 0.2, 2)
	local var_54_4 = var_4.setOnComplete

	System = var_6

	var_54_4(var_54_3, var_6.Action(function(...)
		setActive = var_2_10000

		var_2_10000(var_54_2, false)

		return
	end))

	return
end

function var_0_0.RemoveTimers(arg_57_0)
	if arg_57_0.timer1 then
		local var_57_0 = arg_57_0.timer1

		var_1.Stop(var_57_0)

		arg_57_0.timer1 = nil
	end

	if arg_57_0.timer2 then
		local var_57_1 = arg_57_0.timer2

		var_1.Stop(var_57_1)

		arg_57_0.timer2 = nil
	end

	return
end

function var_0_0.OnSuccess(arg_58_0, arg_58_1)
	go = var_1_10002

	local var_58_0 = arg_58_0.awardLock
	local var_58_1 = var_1_10002(var_3.Find(var_58_0, "icon"))

	LeanTween = var_3

	local var_58_2 = var_3.value
	local var_58_3 = var_58_1
	local var_58_4 = 0
	local var_58_5 = -140

	DecodeGameConst = var_1_10007

	local var_58_6 = var_58_2(var_58_3, var_58_4, var_58_5, var_1_10007.GET_AWARD_ANIM_TIME / 2)
	local var_58_7 = var_3.setOnUpdate

	System = var_58_4

	local var_58_8 = var_58_7(var_58_6, var_58_4.Action_float(function(arg_59_0)
		tf = var_2_10001

		local var_59_0 = var_2_10001(var_58_1)

		Vector3 = var_2
		var_59_0.eulerAngles = var_2(0, 0, arg_59_0)

		return
	end))
	local var_58_9 = var_3.setOnComplete

	System = var_5

	var_58_9(var_58_8, var_5.Action(function()
		LeanTween = var_2_10000

		local var_60_0 = var_2_10000.moveLocalX
		local var_60_1 = var_58_1
		local var_60_2 = 132

		DecodeGameConst = var_2_10003

		local var_60_3 = var_60_0(var_60_1, var_60_2, var_2_10003.GET_AWARD_ANIM_TIME / 2)
		local var_60_4 = var_0.setFrom(var_60_3, 0)
		local var_60_5 = var_0.setOnComplete

		System = var_2

		var_60_5(var_60_4, var_2.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_58_0.awardLock, false)

			setActive = var_3_10000

			var_3_10000(arg_58_0.awardGot, true)
			arg_58_1()

			return
		end))

		return
	end))

	return
end

function var_0_0.ShowHelper(arg_62_0, arg_62_1, arg_62_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_62_0 = var_1_10003(var_1_10004)
	local var_62_1 = var_3.getRawData(var_62_0).id

	PlayerPrefs = var_62_0

	local var_62_2 = var_62_0.GetInt("DecodeGameHelpBg" .. var_62_1 .. arg_62_1, 0)

	if 0 < var_62_2 then
		arg_62_2()

		return
	end

	PlayerPrefs = var_5

	var_5.SetInt("DecodeGameHelpBg" .. var_62_1 .. arg_62_1, 1)

	PlayerPrefs = var_5

	var_5.Save()

	setActive = var_5

	var_5(arg_62_0.helperTF, true)

	local var_62_3 = arg_62_0.helperTF
	local var_62_4 = var_5.Find(var_62_3, "Image")

	DecodeGameConst = var_62_3

	local var_62_5 = var_62_3.HELP_BGS[arg_62_1][1]

	LoadSprite = var_8

	local var_62_6 = var_8("helpbg/" .. var_62_5, "")

	setImageSprite = var_9

	var_9(var_62_4, var_62_6)

	Vector2 = var_9
	var_62_4.sizeDelta = var_9(var_6[2][1], var_6[2][2])
	Vector3 = var_9
	var_62_4.localPosition = var_9(var_6[3][1], var_6[3][2], 0)
	onButton = var_9

	local var_62_7 = arg_62_0
	local var_62_8 = arg_62_0.helperTF

	local function var_62_9()
		setActive = var_2_10000

		var_2_10000(arg_62_0.helperTF, false)
		arg_62_2()

		return
	end

	SFX_PANEL = var_1_10013

	var_9(var_62_7, var_62_8, var_62_9, var_1_10013)

	return
end

function var_0_0.ShowTip(arg_64_0, arg_64_1)
	eachChild = var_1_10002

	var_1_10002(arg_64_0.tips, function(arg_65_0)
		setActive = var_2_10001

		local var_65_0 = arg_65_0

		go = var_2_10003

		local var_65_1 = var_2_10003(arg_65_0).name

		tostring = var_4

		var_2_10001(var_65_0, var_65_1 == var_4(arg_64_1))

		return
	end)

	return
end

function var_0_0.PlayVoice(arg_66_0, arg_66_1)
	pg = var_1_10002

	local var_66_0 = var_1_10002.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_66_0, arg_66_1)

	return
end

function var_0_0.OnSwitchMap(arg_67_0, arg_67_1)
	arg_67_0:PlayerMapStartAnim(arg_67_1)

	return
end

function var_0_0.PlayerMapStartAnim(arg_68_0, arg_68_1)
	setActive = var_1_10002

	var_1_10002(arg_68_0.decodeTV, true)

	table = var_1_10002

	var_1_10002.insert(arg_68_0.animCallbacks, arg_68_1)

	local var_68_0 = arg_68_0.anim

	var_2.SetTrigger(var_68_0, "trigger")

	return
end

function var_0_0.Dispose(arg_69_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_69_0)

	arg_69_0.mapItems = nil

	arg_69_0:RemoveTimers()

	local var_69_0 = arg_69_0.dftAniEvent

	var_1.SetEndEvent(var_69_0, nil)

	arg_69_0.animCallbacks = nil

	return
end

return var_0_0
