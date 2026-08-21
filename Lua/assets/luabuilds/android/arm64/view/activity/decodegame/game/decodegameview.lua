local var_0_0 = class("DecodeGameView")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg.DelegateInfo.New(arg_1_0)

	arg_1_0.controller = arg_1_1

	return
end

function var_0_0.SetUI(arg_2_0, arg_2_1)
	arg_2_0._tf = arg_2_1
	arg_2_0._go = go(arg_2_1)
	arg_2_0.mapItemContainer = arg_2_0._tf:Find("game/container")
	arg_2_0.itemList = UIItemList.New(arg_2_0.mapItemContainer, arg_2_0._tf:Find("game/container/tpl"))
	arg_2_0.mapLine = arg_2_0._tf:Find("game/line")

	setActive(arg_2_0.mapLine, false)

	arg_2_0.mapBtns = {
		arg_2_0._tf:Find("btn/btn1"),
		arg_2_0._tf:Find("btn/btn2"),
		arg_2_0._tf:Find("btn/btn3")
	}
	arg_2_0.engines = {
		arg_2_0._tf:Find("tuitong/1"),
		arg_2_0._tf:Find("tuitong/2"),
		arg_2_0._tf:Find("tuitong/3")
	}
	arg_2_0.engineBottom = arg_2_0._tf:Find("tuitong/4")
	arg_2_0.number1 = arg_2_0._tf:Find("shuzi/1"):GetComponent(typeof(Image))
	arg_2_0.number2 = arg_2_0._tf:Find("shuzi/2"):GetComponent(typeof(Image))
	arg_2_0.awardProgressTF = arg_2_0._tf:Find("zhuanpanxinxi/jindu")
	arg_2_0.awardProgress1TF = arg_2_0._tf:Find("zhuanpanxinxi/jindu/zhuanpan")
	arg_2_0.mapProgreeses = {
		arg_2_0._tf:Find("zhuanpanxinxi/deng1"),
		arg_2_0._tf:Find("zhuanpanxinxi/deng2"),
		arg_2_0._tf:Find("zhuanpanxinxi/deng3")
	}
	arg_2_0.mapPasswords = {
		arg_2_0._tf:Find("dengguang/code1/1"),
		arg_2_0._tf:Find("dengguang/code1/2"),
		arg_2_0._tf:Find("dengguang/code1/3"),
		arg_2_0._tf:Find("dengguang/code1/4"),
		arg_2_0._tf:Find("dengguang/code1/5"),
		arg_2_0._tf:Find("dengguang/code1/6")
	}
	arg_2_0.encodingPanel = arg_2_0._tf:Find("encoding")
	arg_2_0.encodingSlider = arg_2_0._tf:Find("encoding/slider/bar")

	setActive(arg_2_0.encodingPanel, false)

	arg_2_0.enterAnim = arg_2_0._tf:Find("enter_anim")
	arg_2_0.enterAnimTop = arg_2_0._tf:Find("enter_anim/top")
	arg_2_0.enterAnimBottom = arg_2_0._tf:Find("enter_anim/bottom")

	setActive(arg_2_0.enterAnim, false)

	arg_2_0.bookBtn = arg_2_0._tf:Find("btn/mima/unlock")
	arg_2_0.mimaLockBtn = arg_2_0._tf:Find("btn/mima/lock")
	arg_2_0.mimaLockBlink = arg_2_0._tf:Find("btn/mima/blink")
	arg_2_0.code1Panel = arg_2_0._tf:Find("dengguang/code1")
	arg_2_0.code2Panel = arg_2_0._tf:Find("dengguang/code2")
	arg_2_0.passWordTF = arg_2_0._tf:Find("game/password")
	arg_2_0.containerSize = arg_2_0.mapItemContainer.sizeDelta
	arg_2_0.mosaic = arg_2_0._tf:Find("game/Mosaic")
	arg_2_0.lines = arg_2_0._tf:Find("game/grids")
	arg_2_0.code2 = {
		arg_2_0._tf:Find("dengguang/code2/1"),
		arg_2_0._tf:Find("dengguang/code2/2"),
		arg_2_0._tf:Find("dengguang/code2/3"),
		arg_2_0._tf:Find("dengguang/code2/4"),
		arg_2_0._tf:Find("dengguang/code2/5"),
		arg_2_0._tf:Find("dengguang/code2/6"),
		arg_2_0._tf:Find("dengguang/code2/7"),
		arg_2_0._tf:Find("dengguang/code2/8"),
		arg_2_0._tf:Find("dengguang/code2/9")
	}
	arg_2_0.lightRight = arg_2_0._tf:Find("dengguang/code2/light_right")
	arg_2_0.lightLeft = arg_2_0._tf:Find("dengguang/code2/light_left")
	arg_2_0.awardLock = arg_2_0._tf:Find("zhuanpanxinxi/item/lock")
	arg_2_0.awardGot = arg_2_0._tf:Find("zhuanpanxinxi/item/got")
	arg_2_0.screenHeight = arg_2_0._tf.rect.height
	arg_2_0.engineBottom.localPosition = Vector3(arg_2_0.engineBottom.localPosition.x, -arg_2_0.screenHeight / 2, 0)
	arg_2_0.code2Panel.localPosition = Vector3(arg_2_0.code2Panel.localPosition.x, arg_2_0.screenHeight / 2, 0)
	arg_2_0.line1 = arg_2_0._tf:Find("game/lines/line1")
	arg_2_0.blinkFlag = false
	arg_2_0.helperTF = arg_2_0._tf:Find("helper")
	arg_2_0.tips = arg_2_0._tf:Find("btn/tips")
	arg_2_0.animCallbacks = {}
	arg_2_0.decodeTV = arg_2_0._tf:Find("game/zhezhao/DecodeTV")
	arg_2_0.anim = arg_2_0.decodeTV:GetComponent(typeof(Animator))
	arg_2_0.dftAniEvent = arg_2_0.decodeTV:GetComponent(typeof(DftAniEvent))

	arg_2_0.dftAniEvent:SetEndEvent(function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(arg_2_0.animCallbacks) do
			iter_3_1()
		end

		arg_2_0.animCallbacks = {}

		setActive(arg_2_0.decodeTV, false)

		return
	end)

	arg_2_0.codeHeight = arg_2_0.screenHeight / 2 - arg_2_0.code1Panel.anchoredPosition.y
	arg_2_0.code2Panel.sizeDelta = Vector2(arg_2_0.code2Panel.sizeDelta.x, arg_2_0.codeHeight)
	arg_2_0.code1Panel.sizeDelta = Vector2(arg_2_0.code1Panel.sizeDelta.x, arg_2_0.codeHeight)

	return
end

function var_0_0.DoEnterAnim(arg_4_0, arg_4_1)
	setActive(arg_4_0.enterAnim, true)
	LeanTween.moveLocalY(go(arg_4_0.enterAnimTop), arg_4_0.screenHeight / 2, 1):setFrom(-75):setDelay(DecodeGameConst.OPEN_DOOR_DELAY)
	LeanTween.moveLocalY(go(arg_4_0.enterAnimBottom), -arg_4_0.screenHeight / 2, 1):setFrom(75):setDelay(DecodeGameConst.OPEN_DOOR_DELAY):setOnComplete(System.Action(function()
		arg_4_1()
		setActive(arg_4_0.enterAnim, false)

		return
	end))
	updateDrop(arg_4_0._tf:Find("zhuanpanxinxi/item"), {
		id = DecodeGameConst.AWARD[2],
		type = DecodeGameConst.AWARD[1],
		count = DecodeGameConst.AWARD[3]
	})

	return
end

function var_0_0.Inited(arg_6_0, arg_6_1)
	onButton(arg_6_0, arg_6_0._tf:Find("btn/back"), function()
		arg_6_0.controller:ExitGame()

		return
	end, SFX_CANCEL)
	onButton(arg_6_0, arg_6_0._tf:Find("btn/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.decodegame_gametip.tip
		})

		return
	end, SFX_PANEL)

	arg_6_0.ison = false

	onButton(arg_6_0, arg_6_0.bookBtn, function()
		if arg_6_0.controller:CanSwitch() then
			arg_6_0.ison = not arg_6_0.ison

			arg_6_0.controller:SwitchToDecodeMap(arg_6_0.ison)
			setActive(arg_6_0.bookBtn:Find("Image"), arg_6_0.ison)
		end

		return
	end)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.mapBtns) do
		onButton(arg_6_0, iter_6_1, function()
			arg_6_0.controller:SwitchMap(iter_6_0)

			return
		end)
	end

	setActive(arg_6_0.awardLock, not arg_6_1)
	setActive(arg_6_0.awardGot, arg_6_1)

	return
end

function var_0_0.UpdateMap(arg_11_0, arg_11_1)
	arg_11_0.mapItems = {}

	arg_11_0.itemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			arg_11_0:UpdateMapItem(arg_12_2, arg_11_1, arg_11_1.items[arg_12_1 + 1], arg_12_1 + 1)
		end

		return
	end)
	arg_11_0.itemList:align(#arg_11_1.items)

	local var_11_0 = _.flatten(arg_11_1.password)

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.mapPasswords) do
		local var_11_1 = "-"

		if arg_11_1.isUnlock then
			var_11_1 = var_11_0[iter_11_0]
		end

		iter_11_1:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_11_1 .. "-1")
	end

	setActive(arg_11_0.mosaic, not arg_11_1.isUnlock)

	return
end

function var_0_0.UpdateMapItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_1.localPosition = arg_13_3.position
	go(arg_13_1).name = arg_13_3.index

	local var_13_0 = arg_13_1:Find("rect/icon")
	local var_13_1 = var_13_0:GetComponent(typeof(Image))

	var_13_1.sprite = GetSpriteFromAtlas("puzzla/bg_" .. arg_13_2.id + DecodeGameConst.MAP_NAME_OFFSET, arg_13_2.id .. "-" .. (arg_13_2.isUnlock and arg_13_4 or DecodeGameConst.DISORDER[arg_13_4]))

	var_13_1:SetNativeSize()

	var_13_0:GetComponent(typeof(CanvasGroup)).alpha = arg_13_3.isUnlock and 1 or 0

	setActive(arg_13_1:Find("rays"), false)
	setActive(arg_13_1:Find("rays/yellow"), false)
	setActive(arg_13_1:Find("rays/blue"), false)
	onButton(arg_13_0, arg_13_1, function()
		arg_13_0.controller:Unlock(arg_13_3.index)

		return
	end, SFX_PANEL)

	arg_13_0.mapItems[arg_13_3.index] = arg_13_1

	return
end

function var_0_0.OnMapRepairing(arg_15_0, arg_15_1)
	pg.UIMgr.GetInstance():BlurPanel(arg_15_0.encodingPanel)
	setActive(arg_15_0.encodingPanel, true)
	LeanTween.value(go(arg_15_0.encodingSlider), 0, 1, DecodeGameConst.DECODE_MAP_TIME):setOnUpdate(System.Action_float(function(arg_16_0)
		setFillAmount(arg_15_0.encodingSlider, arg_16_0)

		return
	end)):setOnComplete(System.Action(function()
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0.encodingPanel, arg_15_0._tf)
		setActive(arg_15_0.encodingPanel, false)
		arg_15_1()

		return
	end))

	return
end

function var_0_0.OnSwitch(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	assert(arg_18_0.engines[arg_18_1], arg_18_1)

	local var_18_0 = arg_18_0.engines[arg_18_1]:Find("tui")
	local var_18_1 = var_18_0.sizeDelta.y

	LeanTween.moveLocalX(go(arg_18_0.engines[arg_18_1]:Find("xinx")), arg_18_2, DecodeGameConst.SWITCH_MAP):setFrom(arg_18_3)
	LeanTween.value(go(var_18_0), arg_18_4, arg_18_5, DecodeGameConst.SWITCH_MAP):setOnUpdate(System.Action_float(function(arg_19_0)
		var_18_0.sizeDelta = Vector2(arg_19_0, var_18_1)

		return
	end))
	LeanTween.rotateZ(go(arg_18_0.mapBtns[arg_18_1]), arg_18_6, DecodeGameConst.SWITCH_MAP):setOnComplete(System.Action(arg_18_7))

	return
end

function var_0_0.OnExitMap(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 then
		arg_20_0.mapItemContainer.sizeDelta = Vector2(arg_20_0.containerSize.x, 0)
	end

	arg_20_0:OnSwitch(arg_20_1, -11, -150, 158, 23, 0, arg_20_3)

	return
end

function var_0_0.OnEnterMap(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	parallelAsync({
		function(arg_22_0)
			arg_21_0:OnSwitch(arg_21_1, -150, -11, 23, 158, 90, function()
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

			setActive(arg_21_0.mapLine, true)
			LeanTween.value(go(arg_21_0.mapItemContainer), 0, arg_21_0.containerSize.y, DecodeGameConst.SCAN_MAP_TIME):setOnUpdate(System.Action_float(function(arg_25_0)
				arg_21_0.mapItemContainer.sizeDelta = Vector2(arg_21_0.containerSize.x, arg_25_0)

				return
			end)):setOnComplete(System.Action(function()
				setActive(arg_21_0.mapLine, false)
				arg_24_0()

				return
			end))
			LeanTween.value(go(arg_21_0.mapLine), 286, 30 - arg_21_0.containerSize.y, DecodeGameConst.SCAN_MAP_TIME):setOnUpdate(System.Action_float(function(arg_27_0)
				arg_21_0.mapLine.localPosition = Vector2(arg_21_0.mapLine.localPosition.x, arg_27_0, 0)

				return
			end))

			return
		end
	}, arg_21_3)

	return
end

function var_0_0.UnlockMapItem(arg_28_0, arg_28_1, arg_28_2)
	assert(arg_28_0.mapItems[arg_28_1])

	local var_28_0 = arg_28_0.mapItems[arg_28_1]:Find("rect/icon")
	local var_28_1 = var_28_0:GetComponent(typeof(CanvasGroup))

	LeanTween.value(go(var_28_0), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_29_0)
		var_28_1.alpha = arg_29_0

		return
	end)):setOnComplete(System.Action(arg_28_2))

	return
end

function var_0_0.UpdateCanUseCnt(arg_30_0, arg_30_1)
	local var_30_0 = math.floor(arg_30_1 / 10)
	local var_30_1 = arg_30_1 % 10

	arg_30_0.number1.sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_30_0)
	arg_30_0.number2.sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_30_1)

	local var_30_2 = tf(arg_30_0.number1)

	var_30_2.localPosition = var_30_0 == 1 and Vector3(-625, -17) or Vector3(-660, -17)

	local var_30_3 = tf(arg_30_0.number2)

	var_30_3.localPosition = var_30_1 == 1 and Vector3(-516.8, -17) or Vector3(-546.3, -17)

	return
end

function var_0_0.UpdateProgress(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if arg_31_1 < DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN * DecodeGameConst.MAX_MAP_COUNT then
		setFillAmount(arg_31_0.awardProgressTF, arg_31_1 * DecodeGameConst.PROGRESS2FILLAMOUMT)
	else
		setFillAmount(arg_31_0.awardProgressTF, 1)
	end

	arg_31_0.awardProgress1TF.eulerAngles = Vector3(0, 0, 180 - arg_31_1 * DecodeGameConst.PROGRESS2ANGLE)

	setActive(arg_31_0.bookBtn, arg_31_2 == DecodeGameConst.MAX_MAP_COUNT)
	setActive(arg_31_0.mapProgreeses[1], arg_31_3[1])
	setActive(arg_31_0.mapProgreeses[2], arg_31_3[2])
	setActive(arg_31_0.mapProgreeses[3], arg_31_3[3])

	if arg_31_2 == DecodeGameConst.MAX_MAP_COUNT and not arg_31_0.blinkFlag then
		LeanTween.moveLocalX(go(arg_31_0.mimaLockBtn), 150, 0.3):setOnComplete(System.Action(function()
			setActive(arg_31_0.mimaLockBlink, true)
			blinkAni(go(arg_31_0.mimaLockBlink), 0.2, 2):setOnComplete(System.Action(function()
				setActive(arg_31_0.mimaLockBlink, false)
				arg_31_4()

				return
			end))

			return
		end))

		arg_31_0.blinkFlag = true
	elseif arg_31_2 == DecodeGameConst.MAX_MAP_COUNT then
		arg_31_0.mimaLockBtn.localPosition = Vector3(150, 0, 0)

		setActive(arg_31_0.mimaLockBlink, false)
	else
		arg_31_0.mimaLockBtn.localPosition = Vector3(0, 0, 0)

		arg_31_4()
	end

	return
end

function var_0_0.OnEnterDecodeMapBefore(arg_34_0, arg_34_1)
	setActive(arg_34_0.mosaic, true)
	setActive(arg_34_0.lines, false)
	LeanTween.moveLocalY(go(arg_34_0.code1Panel), arg_34_0.screenHeight / 2, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_34_1))

	return
end

function var_0_0.OnEnterDecodeMap(arg_35_0, arg_35_1, arg_35_2)
	parallelAsync({
		function(arg_36_0)
			_.each(arg_35_0.code2, function(arg_37_0)
				setActive(arg_37_0, false)

				return
			end)
			LeanTween.moveLocalY(go(arg_35_0.engineBottom), -500, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2)
			LeanTween.moveLocalY(go(arg_35_0.code2Panel), 303, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_36_0))

			return
		end
	}, function()
		setActive(arg_35_0.mosaic, false)
		setActive(arg_35_0.lines, false)

		for iter_38_0, iter_38_1 in ipairs(arg_35_1) do
			arg_35_0:UpdatePassWord(iter_38_1, iter_38_0)
		end

		setActive(arg_35_0.passWordTF, true)
		arg_35_2()

		return
	end)

	return
end

function var_0_0.OnEnterNormalMapBefore(arg_39_0, arg_39_1)
	parallelAsync({
		function(arg_40_0)
			LeanTween.moveLocalY(go(arg_39_0.code2Panel), arg_39_0.screenHeight / 2, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_40_0))

			return
		end,
		function(arg_41_0)
			LeanTween.moveLocalY(go(arg_39_0.engineBottom), -arg_39_0.screenHeight / 2, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_41_0))

			return
		end
	}, arg_39_1)

	return
end

function var_0_0.OnEnterNormalMap(arg_42_0, arg_42_1, arg_42_2)
	seriesAsync({
		function(arg_43_0)
			LeanTween.moveLocalY(go(arg_42_0.code1Panel), 303, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_43_0))

			return
		end,
		function(arg_44_0)
			setActive(arg_42_0.passWordTF, false)
			arg_44_0()

			return
		end,
		function(arg_45_0)
			arg_42_0.mapItemContainer.sizeDelta = arg_42_0.containerSize

			for iter_45_0, iter_45_1 in ipairs(arg_42_1.passwordIndexs) do
				local var_45_0 = arg_42_0.mapItems[iter_45_1]:Find("rect/icon")

				var_45_0:GetComponent(typeof(CanvasGroup)).alpha = 1

				setActive(arg_42_0.mapItems[iter_45_1]:Find("rays"), false)
			end

			arg_45_0()

			return
		end
	}, arg_42_2)

	return
end

function var_0_0.OnDecodeMap(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1.passwordIndexs) do
		local var_46_1 = arg_46_0.mapItems[iter_46_1]:Find("rect").sizeDelta
		local var_46_2 = Vector2(arg_46_0.mapItems[iter_46_1].localPosition.x + var_46_1.x / 2, arg_46_0.mapItems[iter_46_1].localPosition.y - var_46_1.y / 2)
		local var_46_3 = Vector2(arg_46_0.mapItems[iter_46_1].localPosition.x - var_46_1.x / 2, arg_46_0.mapItems[iter_46_1].localPosition.y + var_46_1.y / 2)

		arg_46_0.mapItems[iter_46_1]:SetAsLastSibling()
		table.insert({}, {
			target = arg_46_0.mapItems[iter_46_1],
			sizeDelta = var_46_1,
			starPosition = var_46_2,
			endPosition = var_46_3,
			item = (function(arg_47_0)
				for iter_47_0, iter_47_1 in ipairs(arg_46_1.items) do
					if iter_47_1.index == arg_47_0 then
						return iter_47_1
					end
				end

				return
			end)(iter_46_1)
		})
	end

	local function var_46_4()
		local var_48_0 = Vector2(0, arg_46_0.line1.localPosition.y)

		for iter_48_0, iter_48_1 in ipairs(var_46_0) do
			local var_48_1 = iter_48_1.target:Find("rect")

			if var_48_0.y >= iter_48_1.starPosition.y and var_48_0.y <= iter_48_1.endPosition.y then
				var_48_1.sizeDelta = Vector2(var_48_1.sizeDelta.x, iter_48_1.sizeDelta.y - (var_48_0.y - iter_48_1.starPosition.y))
			end
		end

		return
	end

	setActive(arg_46_0.line1, true)
	LeanTween.value(go(arg_46_0.line1), 0, DecodeGameConst.BLOCK_SIZE[1] * DecodeGameConst.MAP_ROW, DecodeGameConst.SCAN_GRID_TIME):setOnUpdate(System.Action_float(function(arg_49_0)
		setAnchoredPosition(arg_46_0.line1, {
			y = arg_49_0
		})
		var_46_4()

		return
	end)):setOnComplete(System.Action(function()
		setActive(arg_46_0.line1, false)

		for iter_50_0, iter_50_1 in ipairs(var_46_0) do
			local var_50_0 = iter_50_1.target:Find("rect/icon")

			var_50_0:GetComponent(typeof(CanvasGroup)).alpha = 0
			iter_50_1.target:Find("rect").sizeDelta = iter_50_1.sizeDelta

			setActive(iter_50_1.target:Find("rays"), true)
			setActive(iter_50_1.target:Find("rays/blue"), iter_50_1.item.isUsed)
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

	arg_51_0.code2[arg_51_2]:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", arg_51_1 .. "-1")

	setActive(var_51_0, true)

	return
end

function var_0_0.OnRightCode(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	arg_52_0:UpdatePassWord(arg_52_2, arg_52_3)
	setActive(arg_52_0.mapItems[arg_52_1]:Find("rays/blue"), true)
	setActive(arg_52_0.lightRight, true)

	arg_52_0.timer2 = Timer.New(function()
		setActive(arg_52_0.lightRight, false)

		return
	end, 1, 1)

	arg_52_0.timer2:Start()

	return
end

function var_0_0.OnFalseCode(arg_54_0, arg_54_1)
	arg_54_0:RemoveTimers()
	setActive(arg_54_0.lightLeft, true)

	arg_54_0.timer1 = Timer.New(function()
		setActive(arg_54_0.lightLeft, false)

		return
	end, 1, 1)

	arg_54_0.timer1:Start()

	local var_54_0 = arg_54_0.mapItems[arg_54_1]:Find("rays/yellow")

	setActive(var_54_0, true)
	blinkAni(var_54_0, 0.2, 2):setOnComplete(System.Action(function(...)
		setActive(var_54_0, false)

		return
	end))

	return
end

function var_0_0.RemoveTimers(arg_57_0)
	if arg_57_0.timer1 then
		arg_57_0.timer1:Stop()

		arg_57_0.timer1 = nil
	end

	if arg_57_0.timer2 then
		arg_57_0.timer2:Stop()

		arg_57_0.timer2 = nil
	end

	return
end

function var_0_0.OnSuccess(arg_58_0, arg_58_1)
	LeanTween.value(go(arg_58_0.awardLock:Find("icon")), 0, -140, DecodeGameConst.GET_AWARD_ANIM_TIME / 2):setOnUpdate(System.Action_float(function(arg_59_0)
		tf(var_0).eulerAngles = Vector3(0, 0, arg_59_0)

		return
	end)):setOnComplete(System.Action(function()
		LeanTween.moveLocalX(var_0, 132, DecodeGameConst.GET_AWARD_ANIM_TIME / 2):setFrom(0):setOnComplete(System.Action(function()
			setActive(arg_58_0.awardLock, false)
			setActive(arg_58_0.awardGot, true)
			arg_58_1()

			return
		end))

		return
	end))

	return
end

function var_0_0.ShowHelper(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.GetInt("DecodeGameHelpBg" .. var_62_0 .. arg_62_1, 0) > 0 then
		arg_62_2()

		return
	end

	PlayerPrefs.SetInt("DecodeGameHelpBg" .. var_62_0 .. arg_62_1, 1)
	PlayerPrefs.Save()
	setActive(arg_62_0.helperTF, true)

	local var_62_1 = arg_62_0.helperTF:Find("Image")

	setImageSprite(var_62_1, (LoadSprite("helpbg/" .. DecodeGameConst.HELP_BGS[arg_62_1][1], "")))

	var_62_1.sizeDelta = Vector2(DecodeGameConst.HELP_BGS[arg_62_1][2][1], DecodeGameConst.HELP_BGS[arg_62_1][2][2])
	var_62_1.localPosition = Vector3(DecodeGameConst.HELP_BGS[arg_62_1][3][1], DecodeGameConst.HELP_BGS[arg_62_1][3][2], 0)

	onButton(arg_62_0, arg_62_0.helperTF, function()
		setActive(arg_62_0.helperTF, false)
		arg_62_2()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.ShowTip(arg_64_0, arg_64_1)
	eachChild(arg_64_0.tips, function(arg_65_0)
		setActive(arg_65_0, go(arg_65_0).name == tostring(arg_64_1))

		return
	end)

	return
end

function var_0_0.PlayVoice(arg_66_0, arg_66_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_66_1)

	return
end

function var_0_0.OnSwitchMap(arg_67_0, arg_67_1)
	arg_67_0:PlayerMapStartAnim(arg_67_1)

	return
end

function var_0_0.PlayerMapStartAnim(arg_68_0, arg_68_1)
	setActive(arg_68_0.decodeTV, true)
	table.insert(arg_68_0.animCallbacks, arg_68_1)
	arg_68_0.anim:SetTrigger("trigger")

	return
end

function var_0_0.Dispose(arg_69_0)
	pg.DelegateInfo.Dispose(arg_69_0)

	arg_69_0.mapItems = nil

	arg_69_0:RemoveTimers()
	arg_69_0.dftAniEvent:SetEndEvent(nil)

	arg_69_0.animCallbacks = nil

	return
end

return var_0_0
