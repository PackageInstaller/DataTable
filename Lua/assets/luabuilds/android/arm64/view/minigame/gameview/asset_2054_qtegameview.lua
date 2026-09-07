local QTEGameView = class("QTEGameView", import("..BaseMiniGameView"))

function QTEGameView:getUIName()
	return "QTEGameUI"
end

function QTEGameView:init()
	self.STATE_BEGIN = 1
	self.STATE_COUNT = 2
	self.STATE_CLICK = 3
	self.STATE_SHOW = 4
	self.STATE_END = 5
	self.gameState = -1
	self.typeNum = 3
	self.idNum = 3
	self.limitNum = 5
	self.TYPE_A = 1
	self.TYPE_B = 2
	self.TYPE_C = 3
	self.ITEM_ID_1 = 1
	self.ITEM_ID_2 = 2
	self.ITEM_ID_3 = 3
	self.startUI = self._tf:Find("start_ui")
	self.startBtn = self.startUI:Find("start_btn")
	self.ruleBtn = self.startUI:Find("rule_btn")
	self.qBtn = self.startUI:Find("q_btn")
	self.countUI = self._tf:Find("count_ui")
	self.countNumTxt = self.countUI:Find("num")
	self.endUI = self._tf:Find("end_ui")
	self.endExitBtn = self.endUI:Find("exit_btn")
	self.endBestTxt = self.endUI:Find("rope/paper/best_txt")
	self.endScoreTxt = self.endUI:Find("rope/paper/score_txt")
	self.endComboTxt = self.endUI:Find("rope/paper/combo_txt")
	self.endMissTxt = self.endUI:Find("rope/paper/miss_txt")
	self.endHitTxt = self.endUI:Find("rope/paper/hit_txt")
	self.endUIEvent = self.endUI:Find("rope"):GetComponent("DftAniEvent")
	self.content = self._tf:Find("content")
	self.res = self._tf:Find("res")
	self.gameBg = self.content:Find("game_bg")
	self.xgmPos = self.content:Find("xiongguimao_pos")
	self.guinuPos = self.content:Find("guinu_pos")
	self.bucketA = self._tf:Find("content/bucket_A")
	self.bucketASpine = self.bucketA:GetComponent("SpineAnimUI")
	self.bucketAGraphic = self.bucketA:GetComponent("SkeletonGraphic")
	self.bucketB = self._tf:Find("content/bucket_B")
	self.bucketBSpine = self.bucketB:GetComponent("SpineAnimUI")
	self.bucketBGraphic = self.bucketB:GetComponent("SkeletonGraphic")
	self.bucketC = self._tf:Find("content/bucket_C")
	self.msHand = self.bucketC:Find("ani")
	self.msHandAnimator = self.msHand:GetComponent("Animator")
	self.msHandSlot = self.msHand:Find("slot")
	self.msHandEvent = self.msHand:GetComponent("DftAniEvent")
	self.msBlockList = {}

	self.msHandEvent:SetEndEvent(function()
		self:msClearHold()
		setActive(self.msHand, false)

		return
	end)

	self.xgmAnimLength = {
		idle = 1,
		attack = 1
	}
	self.xgmAnimTargetLength = {
		idle = 1,
		attack = 0.5
	}
	self.guinuAnimLength = {
		action = 1.333,
		normal = 4.667
	}
	self.guinuAnimTargetLength = {
		action = 0.5,
		normal = 4.667
	}
	self.bucketAAnimLength = {
		idle = 0.167,
		attack = 0.8
	}
	self.bucketAAnimTargetLength = {
		idle = 1,
		attack = 0.6
	}
	self.bucketBAnimLength = {
		idle = 0.167,
		attack = 0.8
	}
	self.bucketBAnimTargetLength = {
		idle = 1,
		attack = 0.6
	}
	self.cut1 = self.bucketB:Find("cut_1")
	self.cut2 = self.bucketB:Find("cut_2")
	self.cut3 = self.bucketB:Find("cut_3")
	self.cut1Animator = self.cut1:GetComponent("Animator")
	self.cut2Animator = self.cut2:GetComponent("Animator")
	self.cut3Animator = self.cut3:GetComponent("Animator")
	self.cut1Event = self.cut1:GetComponent("DftAniEvent")
	self.cut2Event = self.cut2:GetComponent("DftAniEvent")
	self.cut3Event = self.cut3:GetComponent("DftAniEvent")

	self.cut1Event:SetEndEvent(function()
		setActive(self.cut1, false)

		return
	end)
	self.cut2Event:SetEndEvent(function()
		setActive(self.cut2, false)

		return
	end)
	self.cut3Event:SetEndEvent(function()
		setActive(self.cut3, false)

		return
	end)

	self.keyUI = self.content:Find("key_ui")
	self.keyBar = self.keyUI:Find("key_bar")
	self.aBtn = self.keyUI:Find("A_btn")
	self.bBtn = self.keyUI:Find("B_btn")
	self.cBtn = self.keyUI:Find("C_btn")
	self.comboAni = self.content:Find("combo_bar/center"):GetComponent("Animator")
	self.comboTxt = self.content:Find("combo_bar/center/combo_txt")
	self.comboAni.enabled = false
	self.scoreTxt = self.content:Find("score_bar/txt")
	self.remainTxt = self.content:Find("remain_time_bar/txt")

	pg.UIMgr.GetInstance():OverlayPanel(self.keyBar, {
		pbList = {
			self.keyBar
		}
	})

	self.roundTxt = self.keyUI:Find("round_time_bar/txt")
	self.firePos = self._tf:Find("content/pos/fire_pos").anchoredPosition
	self.hitPos = self._tf:Find("content/pos/hit_pos").anchoredPosition
	self.aPos = self._tf:Find("content/pos/a_pos").anchoredPosition
	self.bPos = self._tf:Find("content/pos/b_pos").anchoredPosition
	self.cPos = self._tf:Find("content/pos/c_pos").anchoredPosition
	self.missPos = self._tf:Find("content/pos/miss_pos").anchoredPosition
	self.backBtn = self.content:Find("back_btn")
	self.autoLoader = AutoLoader.New()

	self.autoLoader:LoadSprite("ui/minigameui/qtegameuiasync_atlas", "background", self.gameBg, false)

	return
end

function QTEGameView:didEnter()
	self:initGame()
	onButton(self, self.backBtn, function()
		self:setGameState(self.STATE_BEGIN)

		return
	end, SFX_PANEL)
	onButton(self, self.qBtn, function()
		self:emit(QTEGameView.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self.ruleBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.qte_game_help.tip
		})

		return
	end)
	onButton(self, self.startBtn, function()
		setButtonEnabled(self.startBtn, false)
		parallelAsync({
			function(arg_12_0)
				self:loadXGM(arg_12_0)

				return
			end,
			function(arg_13_0)
				self:loadGuinu(arg_13_0)

				return
			end
		}, function()
			self:setGameState(self.STATE_COUNT)

			return
		end)

		return
	end, SFX_PANEL)

	if QTEGAME_DEBUG then
		onButton(self, self.xgm, function()
			self:setGameState(self.STATE_SHOW)

			return
		end)
	end

	onButton(self, self.endExitBtn, function()
		self:emit(QTEGameView.ON_BACK)

		return
	end, SFX_PANEL)
	self.endUIEvent:SetEndEvent(function()
		if self:GetMGHubData().count > 0 then
			self:SendSuccess(0)
		end

		setActive(self.endExitBtn, true)

		return
	end)

	local function var_7_0(arg_18_0)
		if self.gameState == self.STATE_CLICK and self.curShowBlock then
			self.curShowBlock:select(arg_18_0)

			self.curShowBlock = self.curShowBlock.nextBlock

			if self.curShowBlock == nil then
				self:managedTween(LeanTween.delayedCall, function()
					self:setGameState(self.STATE_SHOW)

					return
				end, 0.2, nil)
			end
		end

		return
	end

	onButton(self, self.aBtn, function()
		var_7_0(self.TYPE_A)

		return
	end, SFX_PANEL)
	onButton(self, self.bBtn, function()
		var_7_0(self.TYPE_B)

		return
	end, SFX_PANEL)
	onButton(self, self.cBtn, function()
		var_7_0(self.TYPE_C)

		return
	end, SFX_PANEL)
	self:setGameState(self.STATE_BEGIN)
	self:checkHelp()

	return
end

function QTEGameView:initGame()
	self.curShowBlock = nil
	self.randomBlockList = nil
	self.scorePerHit = self:GetMGData():GetSimpleValue("scorePerHit")
	self.comboRange = self:GetMGData():GetSimpleValue("comboRange")
	self.comboAddScore = self:GetMGData():GetSimpleValue("comboAddScore")
	self.targetCombo = self:GetMGData():GetSimpleValue("targetCombo")
	self.targetComboScore = self:GetMGData():GetSimpleValue("targetComboScore")
	self.usingBlockList = {}
	self.blockUniId = 0

	self:resetGame()
	self.bucketASpine:SetActionCallBack(function(arg_24_0)
		if arg_24_0 == "FINISH" then
			self:setBucketAAction("idle")
		end

		return
	end)
	self.bucketBSpine:SetActionCallBack(function(arg_25_0)
		if arg_25_0 == "FINISH" then
			self:setBucketBAction("idle")
		end

		return
	end)

	return
end

function QTEGameView:resetGame()
	self:setXgmAction("idle")
	self:setGuinuAction("normal")
	self:setBucketAAction("idle")
	self:setBucketBAction("idle")
	setActive(self.msHand, false)

	self.score = 0
	self.bestComboNum = 0
	self.comboNum = 0
	self.missNum = 0
	self.hitNum = 0
	self.remainTime = self:GetMGData():GetSimpleValue("gameTime")
	self.roundTime = self:GetMGData():GetSimpleValue("roundTime")

	setText(self.comboTxt, 0)
	setText(self.scoreTxt, 0)
	setText(self.remainTxt, self.remainTime .. "S")
	setText(self.roundTxt, self.roundTime)
	self:clearTimer()
	self:hideRandomList()
	self:clearUsingBlock()
	self:cleanManagedTween()

	return
end

function QTEGameView:setGameState(arg_27_1)
	if arg_27_1 == self.gameState then
		return
	end

	self.gameState = arg_27_1

	local function var_27_0(arg_28_0)
		for iter_28_0, iter_28_1 in pairs({
			self.startUI,
			self.content,
			self.endUI,
			self.countUI,
			self.keyUI,
			self.keyBar
		}) do
			setActive(iter_28_1, table.indexof(arg_28_0, iter_28_1) and true)
		end

		if isActive(self.endUI) then
			pg.UIMgr.GetInstance():BlurPanel(self.endUI)
		else
			pg.UIMgr.GetInstance():UnOverlayPanel(self.endUI, self._tf)
		end

		return
	end

	if self.gameState == self.STATE_BEGIN then
		setButtonEnabled(self.startBtn, true)
		var_27_0({
			self.startUI
		})
		self:resetGame()
	elseif self.gameState == self.STATE_COUNT then
		var_27_0({
			self.countUI,
			self.content
		})

		local var_27_1 = Time.realtimeSinceStartup

		self:managedTween(LeanTween.delayedCall, function()
			self:startGameTimer()
			self:setGameState(self.STATE_CLICK)

			return
		end, 3, nil):setOnUpdate(System.Action_float(function(arg_30_0)
			setText(self.countNumTxt, math.ceil(3 - (Time.realtimeSinceStartup - var_27_1)))

			return
		end))
	elseif self.gameState == self.STATE_CLICK then
		var_27_0({
			self.content,
			self.keyUI,
			self.keyBar
		})

		self.randomBlockList, self.curShowBlock, self.firstShowBlock = self:getRandomList()

		self:startRoundTimer()
	elseif self.gameState == self.STATE_SHOW then
		var_27_0({
			self.content
		})
		self:hideRandomList()
		self:playArchiveAnim(self.randomBlockList, self:getUserResult())
	elseif self.gameState == self.STATE_END then
		var_27_0({
			self.content,
			self.endUI
		})
		setActive(self.endExitBtn, false)

		local var_27_2 = 0
		local var_27_3 = self:GetMGData():GetRuntimeData("elements")

		if var_27_3 and #var_27_3 > 0 then
			var_27_2 = var_27_3[1]
		end

		if var_27_2 < self.score then
			var_27_2 = self.score

			self:StoreDataToServer({
				self.score
			})
		end

		setText(self.endBestTxt, var_27_2)
		setText(self.endScoreTxt, self.score)
		setText(self.endComboTxt, self.bestComboNum)
		setText(self.endMissTxt, self.missNum)
		setText(self.endHitTxt, self.hitNum)
		self:clearTimer()
	end

	return
end

function QTEGameView:fireBlocks()
	local var_31_0 = self.opIndex
	local var_31_1 = self.arBlockList[self.opIndex].type
	local var_31_2 = self.arBlockList[self.opIndex].id
	local var_31_3 = self.opList[self.opIndex]
	local var_31_4 = self:getBlock(self.arBlockList[self.opIndex].type, self.arBlockList[self.opIndex].id)
	local var_31_5 = var_31_4.tf

	self:addUsingBlock(var_31_4)

	local var_31_6

	if self.opList[self.opIndex] then
		if self.arBlockList[self.opIndex].type == self.TYPE_A then
			var_31_6 = self.aPos
		elseif self.arBlockList[self.opIndex].type == self.TYPE_B then
			var_31_6 = self.bPos
		elseif self.arBlockList[self.opIndex].type == self.TYPE_C then
			var_31_6 = self.cPos
		end
	else
		var_31_6 = self.missPos
	end

	var_31_5.anchoredPosition = self.firePos

	self:hitFly(var_31_5, 0.5, self.hitPos, function()
		var_31_5.anchoredPosition = self.hitPos

		if var_31_3 then
			local var_32_0 = 0.4
			local var_32_1 = self.parabolaMove

			if var_31_1 == self.TYPE_A then
				var_32_0 = 0.3
				var_32_1 = self.parabolaMove_center

				self:setBucketAAction("attack")
			elseif var_31_1 == self.TYPE_B then
				self:managedTween(LeanTween.delayedCall, function()
					self:setBucketBAction("attack")

					return
				end, 0.2, nil)
			elseif var_31_1 == self.TYPE_C then
				var_32_0 = 0.3
				var_32_1 = self.parabolaMove_center

				setActive(self.msHand, true)
				self.msHandAnimator:Play("mingshi_hand", -1, 0)
			end

			var_32_1(self, var_31_5, var_32_0, var_31_6, function()
				if var_31_1 == self.TYPE_A then
					self:removeUsingBlock(var_31_4)
					self:showBucketAEffect()
					pg.CriMgr.GetInstance():PlaySE_V3("ui-minigame_hitcake")
				elseif var_31_1 == self.TYPE_B then
					setActive(self["cut" .. var_31_2], true)
					self["cut" .. var_31_2 .. "Animator"]:Play("cut_fruit", -1, 0)
					self:removeUsingBlock(var_31_4)
					pg.CriMgr.GetInstance():PlaySE_V3("ui-minigame_sword")
				elseif var_31_1 == self.TYPE_C then
					self:msClearHold()
					self:msHoldBlock(var_31_4)
				end

				self:checkEnd(var_31_0)

				return
			end)
		else
			self:hitFly(var_31_5, 0.6, var_31_6, function()
				self:removeUsingBlock(var_31_4)
				self:checkEnd(var_31_0)

				return
			end)
		end

		pg.CriMgr.GetInstance():PlaySE_V3("ui-minigame_hitwood")
		self:countScore(var_31_3)

		return
	end)
	self:managedTween(LeanTween.delayedCall, function()
		self:setGuinuAction("action")

		return
	end, 0.2, nil)

	return
end

function QTEGameView:getRandomList()
	if not self.allList then
		self.allList = {}

		for iter_37_0 = 1, self.typeNum do
			for iter_37_1 = 1, self.idNum do
				self.allList[#self.allList + 1] = {
					type = iter_37_0,
					id = iter_37_1
				}
			end
		end
	end

	local var_37_0 = Clone(self.allList)
	local var_37_1 = {}

	for iter_37_2 = 1, self.limitNum do
		var_37_1[#var_37_1 + 1] = table.remove(var_37_0, math.random(1, #var_37_0))
	end

	local var_37_2

	for iter_37_3, iter_37_4 in ipairs(var_37_1) do
		local var_37_3 = self:getShowBlock(iter_37_4.type, iter_37_4.id)

		if nil then
			(nil).nextBlock = var_37_3
		end

		if iter_37_3 >= self.limitNum then
			var_37_3.nextBlock = nil
		end

		if iter_37_3 == 1 then
			var_37_2 = var_37_3
		end

		var_37_3:showOrHide(true)
	end

	return var_37_1, var_37_2, nil
end

function QTEGameView:hideRandomList()
	while self.firstShowBlock do
		self.firstShowBlock:showOrHide(false)
	end

	return
end

function QTEGameView:countScore(arg_39_1)
	if arg_39_1 then
		local var_39_0

		for iter_39_0, iter_39_1 in ipairs(self.comboRange) do
			if iter_39_1 > self.comboNum then
				var_39_0 = iter_39_0 - 1

				break
			elseif iter_39_0 == #self.comboRange then
				var_39_0 = #self.comboRange
			end
		end

		self.comboNum = self.comboNum + 1
		self.score = self.score + self.scorePerHit + (self.comboAddScore[var_39_0] or 0) + (self.targetComboScore[table.indexof(self.targetCombo, self.comboNum)] or 0)
		self.hitNum = self.hitNum + 1
		self.comboAni.enabled = true

		self.comboAni:Play("combo_shake", -1, 0)
	else
		self.comboNum = 0
		self.missNum = self.missNum + 1
	end

	if self.comboNum > self.bestComboNum then
		self.bestComboNum = self.comboNum
	end

	setText(self.comboTxt, self.comboNum < 0 and 0 or self.comboNum)
	setText(self.scoreTxt, self.score)

	return
end

function QTEGameView:getUserResult()
	local var_40_0 = {}

	while self.firstShowBlock do
		var_40_0[#var_40_0 + 1] = self.firstShowBlock:isRight()
	end

	return var_40_0
end

function QTEGameView:playArchiveAnim(arg_41_1, arg_41_2)
	self.arBlockList = arg_41_1
	self.opList = arg_41_2
	self.opIndex = 1

	self:setXgmAction("attack")

	return
end

function QTEGameView:checkPlayFinished()
	if self.opIndex >= #self.opList and self.remainTime > 0 then
		self:setGameState(self.STATE_CLICK)
	end

	return
end

function QTEGameView:checkEnd(arg_43_1)
	if arg_43_1 >= #self.opList and self.remainTime <= 0 then
		self:setGameState(self.STATE_END)
	end

	return
end

function QTEGameView:parabolaMove(arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	self:managedTween(LeanTween.rotate, nil, arg_44_1, 135, arg_44_2)
	self:managedTween(LeanTween.moveX, nil, arg_44_1, arg_44_3.x, arg_44_2):setEase(LeanTweenType.linear)
	self:managedTween(LeanTween.moveY, function()
		if arg_44_4 then
			arg_44_4()
		end

		return
	end, arg_44_1, arg_44_3.y, arg_44_2):setEase(LeanTweenType.easeInQuad)

	return
end

function QTEGameView:parabolaMove_center(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	self:managedTween(LeanTween.rotate, nil, arg_46_1, 135, arg_46_2)
	self:managedTween(LeanTween.moveX, nil, arg_46_1, arg_46_3.x, arg_46_2):setEase(LeanTweenType.easeOutQuad)
	self:managedTween(LeanTween.moveY, function()
		if arg_46_4 then
			arg_46_4()
		end

		return
	end, arg_46_1, arg_46_3.y, arg_46_2):setEase(LeanTweenType.linear)

	return
end

function QTEGameView:hitFly(arg_48_1, arg_48_2, arg_48_3, arg_48_4)
	self:managedTween(LeanTween.rotate, nil, arg_48_1, 135, arg_48_2)
	self:managedTween(LeanTween.moveX, nil, arg_48_1, arg_48_3.x, arg_48_2):setEase(LeanTweenType.linear)
	self:managedTween(LeanTween.moveY, function()
		if arg_48_4 then
			arg_48_4()
		end

		return
	end, arg_48_1, arg_48_3.y, arg_48_2):setEase(LeanTweenType.easeOutQuad)

	return
end

function QTEGameView:loadXGM(arg_50_1)
	if self.xgm then
		arg_50_1()
	else
		self.autoLoader:LoadPrefab("ui/minigameui/qtegameuiasync_atlas", "xiongguimao", function(arg_51_0)
			self.xgm = tf(arg_51_0)
			self.xgmSpine = self.xgm:GetComponent("SpineAnimUI")
			self.xgmSklGraphic = self.xgm:GetComponent("SkeletonGraphic")

			setParent(self.xgm, self.xgmPos, false)
			self:initXGM()
			arg_50_1()

			return
		end)
	end

	return
end

function QTEGameView:initXGM()
	self.xgmSpine:SetActionCallBack(function(arg_53_0)
		if arg_53_0 == "FIRE" then
			self:fireBlocks()
		elseif arg_53_0 == "FINISH" then
			if self.opIndex < #self.opList then
				self.opIndex = self.opIndex + 1

				self:setXgmAction("attack")
			else
				self:setXgmAction("idle")
				self:checkPlayFinished()
			end
		end

		return
	end)

	return
end

function QTEGameView:loadGuinu(arg_54_1)
	if self.guinuChar then
		arg_54_1()
	else
		self.autoLoader:GetSpine("guinu_2", function(arg_55_0)
			self.guinuChar = arg_55_0
			self.guinuSklGraphic = arg_55_0:GetSkeletonGraphic()

			self.guinuChar:SetParent(self.guinuPos)
			self:initGuinu()
			arg_54_1()

			return
		end)
	end

	return
end

function QTEGameView:initGuinu()
	self.guinuChar:SetLocalScale(Vector3.one)
	self:setGuinuAction("normal")
	self.guinuChar:SetActionCallBack(function(arg_57_0)
		if arg_57_0 == "finish" then
			self:setGuinuAction("normal")
		end

		return
	end)

	return
end

function QTEGameView:setXgmAction(arg_58_1)
	if not self.xgm then
		return
	end

	self.xgmSklGraphic.timeScale = self.xgmAnimLength[arg_58_1] / self.xgmAnimTargetLength[arg_58_1]

	self.xgmSpine:SetAction(arg_58_1, 0)

	return
end

function QTEGameView:setGuinuAction(arg_59_1)
	if not self.guinuChar then
		return
	end

	self.guinuSklGraphic.timeScale = self.guinuAnimLength[arg_59_1] / self.guinuAnimTargetLength[arg_59_1]

	self.guinuChar:SetAction(arg_59_1, 0)

	return
end

function QTEGameView:setBucketAAction(arg_60_1)
	self.bucketAGraphic.timeScale = self.bucketAAnimLength[arg_60_1] / self.bucketAAnimTargetLength[arg_60_1]

	self.bucketASpine:SetAction(arg_60_1, 0)

	return
end

function QTEGameView:setBucketBAction(arg_61_1)
	self.bucketBGraphic.timeScale = self.bucketBAnimLength[arg_61_1] / self.bucketBAnimTargetLength[arg_61_1]

	self.bucketBSpine:SetAction(arg_61_1, 0)

	return
end

function QTEGameView:showBucketAEffect()
	self.aEffectList = self.aEffectList or {}
	self.aEffectUsingList = self.aEffectUsingList or {}

	local function var_62_0()
		local var_63_0 = table.remove(self.aEffectList, #self.aEffectList)

		self.aEffectUsingList[#self.aEffectUsingList + 1] = var_63_0

		setParent(var_63_0, self.bucketA, false)

		var_63_0.localScale = Vector3.one

		setActive(var_63_0, true)
		self:managedTween(LeanTween.delayedCall, function()
			self:recycleBucketAEffect(var_63_0)

			return
		end, 2, nil)

		return
	end

	if #self.aEffectList == 0 then
		self.autoLoader:LoadPrefab("effect/xinnianyouxi_baozha", nil, function(arg_65_0)
			self.aEffectList[#self.aEffectList + 1] = tf(arg_65_0)

			var_62_0()

			return
		end)
	else
		var_62_0()
	end

	return
end

function QTEGameView:recycleBucketAEffect(arg_66_1)
	for iter_66_0 = #self.aEffectUsingList, 1, -1 do
		if self.aEffectUsingList[iter_66_0] == arg_66_1 then
			setActive(arg_66_1, false)

			self.aEffectList[#self.aEffectList + 1] = table.remove(self.aEffectUsingList, iter_66_0)
		end
	end

	return
end

function QTEGameView:getBlock(arg_67_1, arg_67_2)
	local var_67_0 = arg_67_1 .. "-" .. arg_67_2

	if not self.blockPool then
		self.blockPool = {}
		self.blockSource = {}

		for iter_67_0 = 1, 3 do
			for iter_67_1 = 1, 3 do
				local var_67_1 = self._tf:Find("res/item" .. iter_67_0 .. "-" .. iter_67_1)

				self.blockPool[iter_67_0 .. "-" .. iter_67_1] = {}
				self.blockPool[iter_67_0 .. "-" .. iter_67_1][#self.blockPool[iter_67_0 .. "-" .. iter_67_1] + 1] = var_67_1
				self.blockSource[iter_67_0 .. "-" .. iter_67_1] = var_67_1
			end
		end
	end

	local var_67_2

	if #self.blockPool[var_67_0] > 0 then
		var_67_2 = table.remove(self.blockPool[var_67_0], #self.blockPool[var_67_0])

		var_67_2:SetParent(self.content, false)
	else
		var_67_2 = cloneTplTo(self.blockSource[var_67_0], self.content)
	end

	setActive(var_67_2, true)

	self.blockUniId = self.blockUniId + 1

	return {
		uid = self.blockUniId,
		key = var_67_0,
		tf = var_67_2
	}
end

function QTEGameView:recycleBlock(arg_68_1)
	self.blockPool[arg_68_1.key][#self.blockPool[arg_68_1.key] + 1] = arg_68_1.tf

	arg_68_1.tf:SetParent(self.res, false)
	setActive(arg_68_1.tf, false)

	return
end

function QTEGameView:msHoldBlock(arg_69_1)
	setParent(arg_69_1.tf, self.msHandSlot, false)

	arg_69_1.tf.localPosition = Vector2.zero
	self.msBlockList[#self.msBlockList + 1] = arg_69_1

	return
end

function QTEGameView:msClearHold()
	for iter_70_0 = #self.msBlockList, 1, -1 do
		self:removeUsingBlock(table.remove(self.msBlockList, iter_70_0))
	end

	return
end

function QTEGameView:addUsingBlock(arg_71_1)
	self.usingBlockList[#self.usingBlockList + 1] = arg_71_1

	return
end

function QTEGameView:removeUsingBlock(arg_72_1)
	for iter_72_0 = #self.usingBlockList, 1, -1 do
		if self.usingBlockList[iter_72_0].uid == arg_72_1.uid then
			self:recycleBlock(self.usingBlockList[iter_72_0])
			table.remove(self.usingBlockList, iter_72_0)
		end
	end

	return
end

function QTEGameView:clearUsingBlock()
	for iter_73_0 = #self.usingBlockList, 1, -1 do
		self:recycleBlock(self.usingBlockList[iter_73_0])
		table.remove(self.usingBlockList, iter_73_0)
	end

	return
end

function QTEGameView:getShowBlock(arg_74_1, arg_74_2)
	self.showBlockDic = self.showBlockDic or {}

	local var_74_0

	if self.showBlockDic[arg_74_1 .. "-" .. arg_74_2] then
		var_74_0 = self.showBlockDic[arg_74_1 .. "-" .. arg_74_2]
	else
		var_74_0 = {
			type = arg_74_1,
			id = arg_74_2,
			goName = "item" .. arg_74_1 .. "-" .. arg_74_2,
			tf = self.keyBar:Find("item" .. arg_74_1 .. "-" .. arg_74_2)
		}
		var_74_0.wrongTag = var_74_0.tf:Find("wrong")
		var_74_0.rightTag = var_74_0.tf:Find("right")
		var_74_0.nextBlock = nil
		var_74_0.userChoose = nil

		function var_74_0:init()
			setActive(self.wrongTag, false)
			setActive(self.rightTag, false)

			self.userChoose = nil

			self.tf:SetAsLastSibling()

			return
		end

		function var_74_0:select(arg_76_1)
			self.userChoose = arg_76_1

			setActive(self.wrongTag, not self:isRight())
			setActive(self.rightTag, self:isRight())

			return
		end

		function var_74_0:showOrHide(arg_77_1)
			setActive(self.tf, arg_77_1)

			return
		end

		function var_74_0:isRight()
			return self.userChoose == self.type
		end
	end

	var_74_0:init()

	return var_74_0
end

function QTEGameView:startGameTimer()
	self.remainTime = self:GetMGData():GetSimpleValue("gameTime")

	setText(self.remainTxt, self.remainTime .. "S")

	local function var_79_0()
		self.remainTime = self.remainTime - 1

		setText(self.remainTxt, self.remainTime .. "S")

		if self.remainTime <= 0 then
			self.remainTimer:Stop()
		end

		return
	end

	if self.remainTimer then
		self.remainTimer:Reset(var_79_0, 1, -1)
	else
		self.remainTimer = Timer.New(var_79_0, 1, -1)
	end

	self.remainTimer:Start()

	return
end

function QTEGameView:startRoundTimer()
	self.roundTime = self:GetMGData():GetSimpleValue("roundTime")

	setText(self.roundTxt, self.roundTime)

	local function var_81_0()
		self.roundTime = self.roundTime - 1

		setText(self.roundTxt, self.roundTime)

		if self.roundTime <= 0 then
			self.roundTimer:Stop()

			if not QTEGAME_DEBUG then
				self:setGameState(self.STATE_SHOW)
			end
		end

		return
	end

	if self.roundTimer then
		self.roundTimer:Reset(var_81_0, 1, -1)
	else
		self.roundTimer = Timer.New(var_81_0, 1, -1)
	end

	self.roundTimer:Start()

	return
end

function QTEGameView:clearTimer()
	if self.remainTimer then
		self.remainTimer:Stop()

		self.remainTimer = nil
	end

	if self.roundTimer then
		self.roundTimer:Stop()

		self.roundTimer = nil
	end

	return
end

function QTEGameView:OnSendMiniGameOPDone(arg_84_1)
	if arg_84_1.cmd == MiniGameOPCommand.CMD_COMPLETE and arg_84_1.argList[1] == 0 then
		local var_84_0 = {
			nil,
			1
		}

		var_84_0[1] = self:GetMGData():GetSimpleValue("shrineGameId")

		self:SendOperator(MiniGameOPCommand.CMD_SPECIAL_GAME, var_84_0)
	end

	return
end

function QTEGameView:checkHelp()
	if PlayerPrefs.GetInt("QTEGameGuide", 0) == 0 then
		triggerButton(self.ruleBtn)
		PlayerPrefs.SetInt("QTEGameGuide", 1)
		PlayerPrefs.Save()
	end

	return
end

function QTEGameView:willExit()
	self:clearTimer()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.endUI, self._tf)
	pg.UIMgr.GetInstance():UnOverlayPanel(self.keyBar, self.content)

	self.xgm = nil
	self.xgmSpine = nil
	self.xgmSklGraphic = nil
	self.guinuChar = nil
	self.guinuSklGraphic = nil

	self.autoLoader:Clear()

	return
end

return QTEGameView
