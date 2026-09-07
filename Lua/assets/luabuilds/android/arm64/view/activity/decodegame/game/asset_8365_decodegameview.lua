local DecodeGameView = class("DecodeGameView")

function DecodeGameView:Ctor(arg_1_1)
	pg.DelegateInfo.New(self)

	self.controller = arg_1_1

	return
end

function DecodeGameView:SetUI(arg_2_1)
	self._tf = arg_2_1
	self._go = go(arg_2_1)
	self.mapItemContainer = self._tf:Find("game/container")
	self.itemList = UIItemList.New(self.mapItemContainer, self._tf:Find("game/container/tpl"))
	self.mapLine = self._tf:Find("game/line")

	setActive(self.mapLine, false)

	self.mapBtns = {
		self._tf:Find("btn/btn1"),
		self._tf:Find("btn/btn2"),
		self._tf:Find("btn/btn3")
	}
	self.engines = {
		self._tf:Find("tuitong/1"),
		self._tf:Find("tuitong/2"),
		self._tf:Find("tuitong/3")
	}
	self.engineBottom = self._tf:Find("tuitong/4")
	self.number1 = self._tf:Find("shuzi/1"):GetComponent(typeof(Image))
	self.number2 = self._tf:Find("shuzi/2"):GetComponent(typeof(Image))
	self.awardProgressTF = self._tf:Find("zhuanpanxinxi/jindu")
	self.awardProgress1TF = self._tf:Find("zhuanpanxinxi/jindu/zhuanpan")
	self.mapProgreeses = {
		self._tf:Find("zhuanpanxinxi/deng1"),
		self._tf:Find("zhuanpanxinxi/deng2"),
		self._tf:Find("zhuanpanxinxi/deng3")
	}
	self.mapPasswords = {
		self._tf:Find("dengguang/code1/1"),
		self._tf:Find("dengguang/code1/2"),
		self._tf:Find("dengguang/code1/3"),
		self._tf:Find("dengguang/code1/4"),
		self._tf:Find("dengguang/code1/5"),
		self._tf:Find("dengguang/code1/6")
	}
	self.encodingPanel = self._tf:Find("encoding")
	self.encodingSlider = self._tf:Find("encoding/slider/bar")

	setActive(self.encodingPanel, false)

	self.enterAnim = self._tf:Find("enter_anim")
	self.enterAnimTop = self._tf:Find("enter_anim/top")
	self.enterAnimBottom = self._tf:Find("enter_anim/bottom")

	setActive(self.enterAnim, false)

	self.bookBtn = self._tf:Find("btn/mima/unlock")
	self.mimaLockBtn = self._tf:Find("btn/mima/lock")
	self.mimaLockBlink = self._tf:Find("btn/mima/blink")
	self.code1Panel = self._tf:Find("dengguang/code1")
	self.code2Panel = self._tf:Find("dengguang/code2")
	self.passWordTF = self._tf:Find("game/password")
	self.containerSize = self.mapItemContainer.sizeDelta
	self.mosaic = self._tf:Find("game/Mosaic")
	self.lines = self._tf:Find("game/grids")
	self.code2 = {
		self._tf:Find("dengguang/code2/1"),
		self._tf:Find("dengguang/code2/2"),
		self._tf:Find("dengguang/code2/3"),
		self._tf:Find("dengguang/code2/4"),
		self._tf:Find("dengguang/code2/5"),
		self._tf:Find("dengguang/code2/6"),
		self._tf:Find("dengguang/code2/7"),
		self._tf:Find("dengguang/code2/8"),
		self._tf:Find("dengguang/code2/9")
	}
	self.lightRight = self._tf:Find("dengguang/code2/light_right")
	self.lightLeft = self._tf:Find("dengguang/code2/light_left")
	self.awardLock = self._tf:Find("zhuanpanxinxi/item/lock")
	self.awardGot = self._tf:Find("zhuanpanxinxi/item/got")
	self.screenHeight = self._tf.rect.height
	self.engineBottom.localPosition = Vector3(self.engineBottom.localPosition.x, -self.screenHeight / 2, 0)
	self.code2Panel.localPosition = Vector3(self.code2Panel.localPosition.x, self.screenHeight / 2, 0)
	self.line1 = self._tf:Find("game/lines/line1")
	self.blinkFlag = false
	self.helperTF = self._tf:Find("helper")
	self.tips = self._tf:Find("btn/tips")
	self.animCallbacks = {}
	self.decodeTV = self._tf:Find("game/zhezhao/DecodeTV")
	self.anim = self.decodeTV:GetComponent(typeof(Animator))
	self.dftAniEvent = self.decodeTV:GetComponent(typeof(DftAniEvent))

	self.dftAniEvent:SetEndEvent(function(arg_3_0)
		for iter_3_0, iter_3_1 in ipairs(self.animCallbacks) do
			iter_3_1()
		end

		self.animCallbacks = {}

		setActive(self.decodeTV, false)

		return
	end)

	self.codeHeight = self.screenHeight / 2 - self.code1Panel.anchoredPosition.y
	self.code2Panel.sizeDelta = Vector2(self.code2Panel.sizeDelta.x, self.codeHeight)
	self.code1Panel.sizeDelta = Vector2(self.code1Panel.sizeDelta.x, self.codeHeight)

	return
end

function DecodeGameView:DoEnterAnim(arg_4_1)
	setActive(self.enterAnim, true)
	LeanTween.moveLocalY(go(self.enterAnimTop), self.screenHeight / 2, 1):setFrom(-75):setDelay(DecodeGameConst.OPEN_DOOR_DELAY)
	LeanTween.moveLocalY(go(self.enterAnimBottom), -self.screenHeight / 2, 1):setFrom(75):setDelay(DecodeGameConst.OPEN_DOOR_DELAY):setOnComplete(System.Action(function()
		arg_4_1()
		setActive(self.enterAnim, false)

		return
	end))
	updateDrop(self._tf:Find("zhuanpanxinxi/item"), {
		id = DecodeGameConst.AWARD[2],
		type = DecodeGameConst.AWARD[1],
		count = DecodeGameConst.AWARD[3]
	})

	return
end

function DecodeGameView:Inited(arg_6_1)
	onButton(self, self._tf:Find("btn/back"), function()
		self.controller:ExitGame()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("btn/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.decodegame_gametip.tip
		})

		return
	end, SFX_PANEL)

	self.ison = false

	onButton(self, self.bookBtn, function()
		if self.controller:CanSwitch() then
			self.ison = not self.ison

			self.controller:SwitchToDecodeMap(self.ison)
			setActive(self.bookBtn:Find("Image"), self.ison)
		end

		return
	end)

	for iter_6_0, iter_6_1 in ipairs(self.mapBtns) do
		onButton(self, iter_6_1, function()
			self.controller:SwitchMap(iter_6_0)

			return
		end)
	end

	setActive(self.awardLock, not arg_6_1)
	setActive(self.awardGot, arg_6_1)

	return
end

function DecodeGameView:UpdateMap(arg_11_1)
	self.mapItems = {}

	self.itemList:make(function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_0 == UIItemList.EventUpdate then
			self:UpdateMapItem(arg_12_2, arg_11_1, arg_11_1.items[arg_12_1 + 1], arg_12_1 + 1)
		end

		return
	end)
	self.itemList:align(#arg_11_1.items)

	local var_11_0 = _.flatten(arg_11_1.password)

	for iter_11_0, iter_11_1 in ipairs(self.mapPasswords) do
		iter_11_1:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", ((arg_11_1.isUnlock or nil) and var_11_0[iter_11_0]) .. "-1")
	end

	setActive(self.mosaic, not arg_11_1.isUnlock)

	return
end

function DecodeGameView:UpdateMapItem(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
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
	onButton(self, arg_13_1, function()
		self.controller:Unlock(arg_13_3.index)

		return
	end, SFX_PANEL)

	self.mapItems[arg_13_3.index] = arg_13_1

	return
end

function DecodeGameView:OnMapRepairing(arg_15_1)
	pg.UIMgr.GetInstance():BlurPanel(self.encodingPanel)
	setActive(self.encodingPanel, true)
	LeanTween.value(go(self.encodingSlider), 0, 1, DecodeGameConst.DECODE_MAP_TIME):setOnUpdate(System.Action_float(function(arg_16_0)
		setFillAmount(self.encodingSlider, arg_16_0)

		return
	end)):setOnComplete(System.Action(function()
		pg.UIMgr.GetInstance():UnOverlayPanel(self.encodingPanel, self._tf)
		setActive(self.encodingPanel, false)
		arg_15_1()

		return
	end))

	return
end

function DecodeGameView:OnSwitch(arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6, arg_18_7)
	assert(self.engines[arg_18_1], arg_18_1)

	local var_18_0 = self.engines[arg_18_1]:Find("tui")
	local var_18_1 = var_18_0.sizeDelta.y

	LeanTween.moveLocalX(go(self.engines[arg_18_1]:Find("xinx")), arg_18_2, DecodeGameConst.SWITCH_MAP):setFrom(arg_18_3)
	LeanTween.value(go(var_18_0), arg_18_4, arg_18_5, DecodeGameConst.SWITCH_MAP):setOnUpdate(System.Action_float(function(arg_19_0)
		var_18_0.sizeDelta = Vector2(arg_19_0, var_18_1)

		return
	end))
	LeanTween.rotateZ(go(self.mapBtns[arg_18_1]), arg_18_6, DecodeGameConst.SWITCH_MAP):setOnComplete(System.Action(arg_18_7))

	return
end

function DecodeGameView:OnExitMap(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 then
		self.mapItemContainer.sizeDelta = Vector2(self.containerSize.x, 0)
	end

	self:OnSwitch(arg_20_1, -11, -150, 158, 23, 0, arg_20_3)

	return
end

function DecodeGameView:OnEnterMap(arg_21_1, arg_21_2, arg_21_3)
	parallelAsync({
		function(arg_22_0)
			self:OnSwitch(arg_21_1, -150, -11, 23, 158, 90, function()
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

			setActive(self.mapLine, true)
			LeanTween.value(go(self.mapItemContainer), 0, self.containerSize.y, DecodeGameConst.SCAN_MAP_TIME):setOnUpdate(System.Action_float(function(arg_25_0)
				self.mapItemContainer.sizeDelta = Vector2(self.containerSize.x, arg_25_0)

				return
			end)):setOnComplete(System.Action(function()
				setActive(self.mapLine, false)
				arg_24_0()

				return
			end))
			LeanTween.value(go(self.mapLine), 286, 30 - self.containerSize.y, DecodeGameConst.SCAN_MAP_TIME):setOnUpdate(System.Action_float(function(arg_27_0)
				self.mapLine.localPosition = Vector2(self.mapLine.localPosition.x, arg_27_0, 0)

				return
			end))

			return
		end
	}, arg_21_3)

	return
end

function DecodeGameView:UnlockMapItem(arg_28_1, arg_28_2)
	assert(self.mapItems[arg_28_1])

	local var_28_0 = self.mapItems[arg_28_1]:Find("rect/icon")
	local var_28_1 = var_28_0:GetComponent(typeof(CanvasGroup))

	LeanTween.value(go(var_28_0), 0, 1, 0.3):setOnUpdate(System.Action_float(function(arg_29_0)
		var_28_1.alpha = arg_29_0

		return
	end)):setOnComplete(System.Action(arg_28_2))

	return
end

function DecodeGameView:UpdateCanUseCnt(arg_30_1)
	local var_30_0 = math.floor(arg_30_1 / 10)
	local var_30_1 = arg_30_1 % 10

	self.number1.sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_30_0)
	self.number2.sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", var_30_1)
	tf(self.number1).localPosition = var_30_0 == 1 and Vector3(-625, -17) or Vector3(-660, -17)
	tf(self.number2).localPosition = var_30_1 == 1 and Vector3(-516.8, -17) or Vector3(-546.3, -17)

	return
end

function DecodeGameView:UpdateProgress(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
	if arg_31_1 < DecodeGameConst.MAP_ROW * DecodeGameConst.MAP_COLUMN * DecodeGameConst.MAX_MAP_COUNT then
		setFillAmount(self.awardProgressTF, arg_31_1 * DecodeGameConst.PROGRESS2FILLAMOUMT)
	else
		setFillAmount(self.awardProgressTF, 1)
	end

	self.awardProgress1TF.eulerAngles = Vector3(0, 0, 180 - arg_31_1 * DecodeGameConst.PROGRESS2ANGLE)

	setActive(self.bookBtn, arg_31_2 == DecodeGameConst.MAX_MAP_COUNT)
	setActive(self.mapProgreeses[1], arg_31_3[1])
	setActive(self.mapProgreeses[2], arg_31_3[2])
	setActive(self.mapProgreeses[3], arg_31_3[3])

	if arg_31_2 == DecodeGameConst.MAX_MAP_COUNT and not self.blinkFlag then
		LeanTween.moveLocalX(go(self.mimaLockBtn), 150, 0.3):setOnComplete(System.Action(function()
			setActive(self.mimaLockBlink, true)
			blinkAni(go(self.mimaLockBlink), 0.2, 2):setOnComplete(System.Action(function()
				setActive(self.mimaLockBlink, false)
				arg_31_4()

				return
			end))

			return
		end))

		self.blinkFlag = true
	elseif arg_31_2 == DecodeGameConst.MAX_MAP_COUNT then
		self.mimaLockBtn.localPosition = Vector3(150, 0, 0)

		setActive(self.mimaLockBlink, false)
	else
		self.mimaLockBtn.localPosition = Vector3(0, 0, 0)

		arg_31_4()
	end

	return
end

function DecodeGameView:OnEnterDecodeMapBefore(arg_34_1)
	setActive(self.mosaic, true)
	setActive(self.lines, false)
	LeanTween.moveLocalY(go(self.code1Panel), self.screenHeight / 2, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_34_1))

	return
end

function DecodeGameView:OnEnterDecodeMap(arg_35_1, arg_35_2)
	parallelAsync({
		function(arg_36_0)
			_.each(self.code2, function(arg_37_0)
				setActive(arg_37_0, false)

				return
			end)
			LeanTween.moveLocalY(go(self.engineBottom), -500, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2)
			LeanTween.moveLocalY(go(self.code2Panel), 303, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_36_0))

			return
		end
	}, function()
		setActive(self.mosaic, false)
		setActive(self.lines, false)

		for iter_38_0, iter_38_1 in ipairs(arg_35_1) do
			self:UpdatePassWord(iter_38_1, iter_38_0)
		end

		setActive(self.passWordTF, true)
		arg_35_2()

		return
	end)

	return
end

function DecodeGameView:OnEnterNormalMapBefore(arg_39_1)
	parallelAsync({
		function(arg_40_0)
			LeanTween.moveLocalY(go(self.code2Panel), self.screenHeight / 2, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_40_0))

			return
		end,
		function(arg_41_0)
			LeanTween.moveLocalY(go(self.engineBottom), -self.screenHeight / 2, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_41_0))

			return
		end
	}, arg_39_1)

	return
end

function DecodeGameView:OnEnterNormalMap(arg_42_1, arg_42_2)
	seriesAsync({
		function(arg_43_0)
			LeanTween.moveLocalY(go(self.code1Panel), 303, DecodeGameConst.SWITCH_TO_DECODE_TIME / 2):setOnComplete(System.Action(arg_43_0))

			return
		end,
		function(arg_44_0)
			setActive(self.passWordTF, false)
			arg_44_0()

			return
		end,
		function(arg_45_0)
			self.mapItemContainer.sizeDelta = self.containerSize

			for iter_45_0, iter_45_1 in ipairs(arg_42_1.passwordIndexs) do
				self.mapItems[iter_45_1]:Find("rect/icon"):GetComponent(typeof(CanvasGroup)).alpha = 1

				setActive(self.mapItems[iter_45_1]:Find("rays"), false)
			end

			arg_45_0()

			return
		end
	}, arg_42_2)

	return
end

function DecodeGameView:OnDecodeMap(arg_46_1, arg_46_2)
	local var_46_0 = {}

	local function var_46_1(arg_47_0)
		for iter_47_0, iter_47_1 in ipairs(arg_46_1.items) do
			if iter_47_1.index == arg_47_0 then
				return iter_47_1
			end
		end

		return
	end

	for iter_46_0, iter_46_1 in ipairs(arg_46_1.passwordIndexs) do
		local var_46_2 = self.mapItems[iter_46_1]:Find("rect").sizeDelta
		local var_46_3 = Vector2(self.mapItems[iter_46_1].localPosition.x + var_46_2.x / 2, self.mapItems[iter_46_1].localPosition.y - var_46_2.y / 2)
		local var_46_4 = Vector2(self.mapItems[iter_46_1].localPosition.x - var_46_2.x / 2, self.mapItems[iter_46_1].localPosition.y + var_46_2.y / 2)

		self.mapItems[iter_46_1]:SetAsLastSibling()
		table.insert(var_46_0, {
			target = self.mapItems[iter_46_1],
			sizeDelta = var_46_2,
			starPosition = var_46_3,
			endPosition = var_46_4,
			item = var_46_1(iter_46_1)
		})
	end

	local function var_46_5()
		local var_48_0 = Vector2(0, self.line1.localPosition.y)

		for iter_48_0, iter_48_1 in ipairs(var_46_0) do
			local var_48_1 = iter_48_1.target:Find("rect")

			if var_48_0.y >= iter_48_1.starPosition.y and var_48_0.y <= iter_48_1.endPosition.y then
				var_48_1.sizeDelta = Vector2(var_48_1.sizeDelta.x, iter_48_1.sizeDelta.y - (var_48_0.y - iter_48_1.starPosition.y))
			end
		end

		return
	end

	setActive(self.line1, true)
	LeanTween.value(go(self.line1), 0, DecodeGameConst.BLOCK_SIZE[1] * DecodeGameConst.MAP_ROW, DecodeGameConst.SCAN_GRID_TIME):setOnUpdate(System.Action_float(function(arg_49_0)
		setAnchoredPosition(self.line1, {
			y = arg_49_0
		})
		var_46_5()

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.line1, false)

		for iter_50_0, iter_50_1 in ipairs(var_46_0) do
			iter_50_1.target:Find("rect/icon"):GetComponent(typeof(CanvasGroup)).alpha = 0
			iter_50_1.target:Find("rect").sizeDelta = iter_50_1.sizeDelta

			setActive(iter_50_1.target:Find("rays"), true)
			setActive(iter_50_1.target:Find("rays/blue"), iter_50_1.item.isUsed)
		end

		arg_46_2()

		return
	end))

	return
end

function DecodeGameView:UpdatePassWord(arg_51_1, arg_51_2)
	if arg_51_1 == false then
		return
	end

	local var_51_0 = self.code2[arg_51_2]

	self.code2[arg_51_2]:GetComponent(typeof(Image)).sprite = GetSpriteFromAtlas("ui/DecodeGameNumber_atlas", arg_51_1 .. "-1")

	setActive(var_51_0, true)

	return
end

function DecodeGameView:OnRightCode(arg_52_1, arg_52_2, arg_52_3)
	self:UpdatePassWord(arg_52_2, arg_52_3)
	setActive(self.mapItems[arg_52_1]:Find("rays/blue"), true)
	setActive(self.lightRight, true)

	self.timer2 = Timer.New(function()
		setActive(self.lightRight, false)

		return
	end, 1, 1)

	self.timer2:Start()

	return
end

function DecodeGameView:OnFalseCode(arg_54_1)
	self:RemoveTimers()
	setActive(self.lightLeft, true)

	self.timer1 = Timer.New(function()
		setActive(self.lightLeft, false)

		return
	end, 1, 1)

	self.timer1:Start()

	local var_54_0 = self.mapItems[arg_54_1]:Find("rays/yellow")

	setActive(var_54_0, true)
	blinkAni(var_54_0, 0.2, 2):setOnComplete(System.Action(function(...)
		setActive(var_54_0, false)

		return
	end))

	return
end

function DecodeGameView:RemoveTimers()
	if self.timer1 then
		self.timer1:Stop()

		self.timer1 = nil
	end

	if self.timer2 then
		self.timer2:Stop()

		self.timer2 = nil
	end

	return
end

function DecodeGameView:OnSuccess(arg_58_1)
	local var_58_0 = go(self.awardLock:Find("icon"))

	LeanTween.value(var_58_0, 0, -140, DecodeGameConst.GET_AWARD_ANIM_TIME / 2):setOnUpdate(System.Action_float(function(arg_59_0)
		tf(var_58_0).eulerAngles = Vector3(0, 0, arg_59_0)

		return
	end)):setOnComplete(System.Action(function()
		LeanTween.moveLocalX(var_58_0, 132, DecodeGameConst.GET_AWARD_ANIM_TIME / 2):setFrom(0):setOnComplete(System.Action(function()
			setActive(self.awardLock, false)
			setActive(self.awardGot, true)
			arg_58_1()

			return
		end))

		return
	end))

	return
end

function DecodeGameView:ShowHelper(arg_62_1, arg_62_2)
	local var_62_0 = getProxy(PlayerProxy):getRawData().id

	if PlayerPrefs.GetInt("DecodeGameHelpBg" .. var_62_0 .. arg_62_1, 0) > 0 then
		arg_62_2()

		return
	end

	PlayerPrefs.SetInt("DecodeGameHelpBg" .. var_62_0 .. arg_62_1, 1)
	PlayerPrefs.Save()
	setActive(self.helperTF, true)

	local var_62_1 = self.helperTF:Find("Image")

	setImageSprite(var_62_1, (LoadSprite("helpbg/" .. DecodeGameConst.HELP_BGS[arg_62_1][1], "")))

	var_62_1.sizeDelta = Vector2(DecodeGameConst.HELP_BGS[arg_62_1][2][1], DecodeGameConst.HELP_BGS[arg_62_1][2][2])
	var_62_1.localPosition = Vector3(DecodeGameConst.HELP_BGS[arg_62_1][3][1], DecodeGameConst.HELP_BGS[arg_62_1][3][2], 0)

	onButton(self, self.helperTF, function()
		setActive(self.helperTF, false)
		arg_62_2()

		return
	end, SFX_PANEL)

	return
end

function DecodeGameView:ShowTip(arg_64_1)
	eachChild(self.tips, function(arg_65_0)
		setActive(arg_65_0, go(arg_65_0).name == tostring(arg_64_1))

		return
	end)

	return
end

function DecodeGameView:PlayVoice(arg_66_1)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(arg_66_1)

	return
end

function DecodeGameView:OnSwitchMap(arg_67_1)
	self:PlayerMapStartAnim(arg_67_1)

	return
end

function DecodeGameView:PlayerMapStartAnim(arg_68_1)
	setActive(self.decodeTV, true)
	table.insert(self.animCallbacks, arg_68_1)
	self.anim:SetTrigger("trigger")

	return
end

function DecodeGameView:Dispose()
	pg.DelegateInfo.Dispose(self)

	self.mapItems = nil

	self:RemoveTimers()
	self.dftAniEvent:SetEndEvent(nil)

	self.animCallbacks = nil

	return
end

return DecodeGameView
