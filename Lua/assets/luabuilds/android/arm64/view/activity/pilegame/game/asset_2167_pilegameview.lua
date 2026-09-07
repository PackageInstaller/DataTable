local PileGameView = class("PileGameView")

function PileGameView:Ctor(arg_1_1)
	self.controller = arg_1_1

	return
end

function PileGameView:SetUI(arg_2_1)
	pg.DelegateInfo.New(self)

	self._go = arg_2_1
	self._tf = tf(arg_2_1)
	self.bg = self._tf:Find("AD")
	self.curtainTF = self._tf:Find("AD/curtain")
	self.countDown = self.curtainTF:Find("Text"):GetComponent(typeof(Text))
	self.itemTpl = self._tf:Find("AD/item")
	self.groundTpl = self._tf:Find("AD/ground")
	self.gameContainer = self._tf:Find("AD/game")
	self.itemsContainer = self._tf:Find("AD/game/items")
	self.scoreTxt = self._tf:Find("AD/score_panel/Text"):GetComponent(typeof(Text))
	self.heats = {
		self._tf:Find("AD/score_panel/heart1"),
		self._tf:Find("AD/score_panel/heart2"),
		self._tf:Find("AD/score_panel/heart3")
	}
	self.manjuuAnim = self._tf:Find("AD/npc/manjuu"):GetComponent(typeof(Animator))
	self.anikiAnim = self._tf:Find("AD/npc/aniki"):GetComponent(typeof(Animator))
	self.manjuuPilot = self._tf:Find("AD/npc/manjuu_pilot")
	self.backBtn = self._tf:Find("AD/back")
	self.exitPanel = self._tf:Find("AD/exit_panel")
	self.exitPanelConfirmBtn = self.exitPanel:Find("frame/confirm")
	self.exitPanelCancelBtn = self.exitPanel:Find("frame/cancel")
	self.resultPanel = self._tf:Find("AD/result")
	self.endGameBtn = self.resultPanel:Find("frame/endGame")
	self.finalScoreTxt = self.resultPanel:Find("frame/score/Text"):GetComponent(typeof(Text))
	self.highestScoreText = self.resultPanel:Find("frame/highestscore/Text"):GetComponent(typeof(Text))
	self.itemIndexTF = self._tf:Find("AD/score_panel/index/target")
	self.overviewPanel = self._tf:Find("overview")
	self.startBtn = self._tf:Find("overview/start")
	self.helpBtn = self._tf:Find("overview/help")
	self.deathLine = self._tf:Find("death_line")
	self.safeLine = self._tf:Find("safe_line")
	self.itemCollider = self._tf:Find("item_collider")
	self.items = {}
	self.bgMgr = PileGameBgMgr.New(self._tf:Find("AD/bgs"))

	return
end

function PileGameView:OnEnterGame(arg_3_1)
	self.viewData = arg_3_1

	if self.viewData.tip then
		self.gameHelpTip = self.viewData.tip or nil
	end

	setActive(self.overviewPanel, true)
	setActive(self.bg, false)
	onButton(self, self.startBtn, function()
		self.controller:StartGame()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		local var_5_0 = {
			type = MSGBOX_TYPE_HELP
		}

		var_5_0.helps = self.gameHelpTip or pg.gametip.pile_game_notice.tip

		pg.MsgboxMgr.GetInstance():ShowMsgBox(var_5_0)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:ShowExitMsg()

		return
	end, SFX_PANEL)

	return
end

function PileGameView:ShowExitMsg()
	pg.UIMgr.GetInstance():BlurPanel(self.exitPanel)
	setActive(self.exitPanel, true)

	local function var_7_0()
		setActive(self.exitPanel, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.exitPanel, self.bg)

		return
	end

	onButton(self, self.exitPanelCancelBtn, var_7_0, SFX_PANEL)
	onButton(self, self.exitPanelConfirmBtn, function()
		var_7_0()
		self.controller:OnEndGame(false)

		return
	end, SFX_PANEL)

	return
end

function PileGameView:DoCurtain(arg_10_1)
	seriesAsync({
		function(arg_11_0)
			self.bgMgr:Init(arg_11_0)

			return
		end,
		function(arg_12_0)
			setActive(self.overviewPanel, false)
			setActive(self.bg, true)
			setActive(self.curtainTF, true)
			setAnchoredPosition(self.anikiAnim.gameObject, {
				x = -177,
				y = 158
			})

			local var_12_0 = 4

			self.timer = Timer.New(function()
				var_12_0 = var_12_0 - 1

				if var_12_0 == 3 then
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_PILE_COUNTDOWN)
				end

				self.countDown.text = var_12_0

				if var_12_0 == 0 then
					setActive(self.curtainTF, false)
					arg_12_0()
				end

				return
			end, 1, 4)

			self.timer:Start()
			self.timer.func()

			return
		end
	}, arg_10_1)

	return
end

function PileGameView:UpdateScore(arg_14_1, arg_14_2)
	self.scoreTxt.text = arg_14_1

	local var_14_0 = false

	if arg_14_1 > 0 and arg_14_1 % PileGameConst.LEVEL_TO_HAPPY_ANIM == 0 then
		self.manjuuAnim:SetTrigger("happy")
		self.anikiAnim:SetTrigger("nice")

		var_14_0 = true
	end

	local var_14_1 = self.items[arg_14_2]

	if self.items[arg_14_2] and var_14_0 then
		var_14_1:Find("anim"):GetComponent(typeof(Animator)):SetTrigger("win")
	elseif var_14_1 then
		var_14_1:Find("anim"):GetComponent(typeof(Animator)):SetTrigger("idle")
	end

	if arg_14_2 then
		self.itemIndexTF.localPosition = Vector3(arg_14_2.position.x / PileGameConst.RATIO, 0, 0)

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_STEP_PILE_SUCCESS)
	end

	return
end

function PileGameView:UpdateFailedCnt(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	for iter_15_0, iter_15_1 in ipairs(self.heats) do
		setActive(iter_15_1, arg_15_2 < iter_15_0)
	end

	if arg_15_3 then
		self.anikiAnim:SetTrigger("miss")
		self.items[arg_15_4]:Find("anim"):GetComponent(typeof(Animator)):SetTrigger("miss")
	end

	return
end

function PileGameView:AddPile(arg_16_1, arg_16_2, arg_16_3)
	PoolMgr.GetInstance():GetPrefab("Stacks/" .. arg_16_1.gname, arg_16_1.gname, true, function(arg_17_0)
		local var_17_0 = tf(arg_17_0)

		SetParent(var_17_0, self.itemsContainer)

		var_17_0.sizeDelta = arg_16_1.sizeDelta
		var_17_0.pivot = arg_16_1.pivot
		go(var_17_0).name = arg_16_1.name .. "_" .. arg_16_1.gname
		self.items[arg_16_1] = var_17_0
		var_17_0.eulerAngles = Vector3(0, 0, 0)

		self:OnItemPositionChange(arg_16_1)
		setActive(var_17_0, not arg_16_2)

		if not arg_16_2 then
			var_17_0:Find("anim"):GetComponent(typeof(Animator)):SetTrigger("exit")
		end

		if PileGameConst.DEBUG then
			self:AddPileCollider(arg_16_1)
		end

		arg_16_3()

		return
	end)

	return
end

function PileGameView:OnStartDrop(arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 then
		self.manjuuAnim:SetBool("despair", PileGameController.DROP_AREA_WARN == arg_18_2)
	else
		self.manjuuAnim:SetTrigger("shock")
	end

	self.items[arg_18_1]:Find("anim"):GetComponent(typeof(Animator)):SetTrigger("drop")

	return
end

function PileGameView:OnItemPositionChange(arg_19_1)
	if self.items[arg_19_1] then
		self.items[arg_19_1].localPosition = arg_19_1.position
	end

	return
end

function PileGameView:OnItemPositionChangeWithAnim(arg_20_1, arg_20_2)
	if self.items[arg_20_1] then
		LeanTween.moveLocalY(go(self.items[arg_20_1]), arg_20_1.position.y, PileGameConst.SINK_TIME):setOnComplete(System.Action(arg_20_2))
	end

	return
end

function PileGameView:OnItemIndexPositionChange(arg_21_1)
	local var_21_0 = arg_21_1.position.x

	self.prevPosition = self.prevPosition or self.manjuuPilot.localPosition.x

	local var_21_1 = 0
	local var_21_2 = 1

	if var_21_0 - self.prevPosition <= 0 then
		var_21_1 = var_21_0 + 12
		var_21_2 = -1
	else
		var_21_1 = var_21_0 - 12
	end

	self.manjuuPilot.localPosition = Vector3(var_21_1, arg_21_1.position.y + arg_21_1.sizeDelta.y + self.manjuuPilot.rect.height / 2, 0)
	self.manjuuPilot.localScale = Vector3(var_21_2, 1, 1)
	self.prevPosition = var_21_0

	return
end

function PileGameView:OnExceedingTheHighestScore()
	self.manjuuAnim:SetTrigger("satisfied")

	return
end

function PileGameView:DoSink(arg_23_1, arg_23_2)
	local var_23_0 = getAnchoredPosition(self.anikiAnim.gameObject)

	LeanTween.value(self.anikiAnim.gameObject, var_23_0.y, var_23_0.y - arg_23_1, PileGameConst.SINK_TIME):setOnUpdate(System.Action_float(function(arg_24_0)
		setAnchoredPosition(self.anikiAnim.gameObject, {
			y = arg_24_0
		})

		return
	end)):setOnComplete(System.Action(arg_23_2))
	self.bgMgr:DoMove(arg_23_1)

	return
end

function PileGameView:OnRemovePile(arg_25_1)
	if self.items[arg_25_1] then
		if PileGameConst.DEBUG then
			Destroy(self.items[arg_25_1]:Find("collider").gameObject)
		end

		self.items[arg_25_1]:Find("anim"):GetComponent(typeof(Animator)):SetTrigger("exit")

		self.items[arg_25_1].eulerAngles = Vector3(0, 0, 0)

		PoolMgr.GetInstance():ReturnPrefab("Stacks/" .. arg_25_1.gname, arg_25_1.gname, self.items[arg_25_1].gameObject)

		self.items[arg_25_1] = nil
	end

	return
end

function PileGameView:PlaySpeAction(arg_26_1)
	if self.items[arg_26_1] then
		if arg_26_1.speActionCount == 0 then
			return
		end

		local var_26_0 = math.random(1, arg_26_1.speActionCount) - 1

		self.items[arg_26_1]:Find("anim"):GetComponent(typeof(Animator)):SetTrigger(var_26_0 == 0 and "spe" or "spe" .. var_26_0)
	end

	return
end

function PileGameView:OnGameStart()
	onButton(self, self.bg, function()
		self.controller:Drop()

		return
	end, SFX_PANEL)

	return
end

function PileGameView:OnGameExited()
	setActive(self.overviewPanel, true)
	setActive(self.bg, false)

	self.itemsContainer.eulerAngles = Vector3(0, 0, 0)
	self.itemsContainer.pivot = Vector2(0.5, 0.5)

	self.bgMgr:Clear()

	if PileGameConst.DEBUG then
		Destroy(self.gameContainer:Find("ground").gameObject)
		Destroy(self.gameContainer:Find("deathLineR").gameObject)
		Destroy(self.gameContainer:Find("deathLineL").gameObject)
		Destroy(self.gameContainer:Find("safeLineL").gameObject)
		Destroy(self.gameContainer:Find("safeLineR").gameObject)
	end

	return
end

function PileGameView:OnGameEnd(arg_30_1, arg_30_2)
	(function()
		pg.UIMgr.GetInstance():BlurPanel(self.resultPanel)
		setActive(self.resultPanel, true)
		onButton(self, self.endGameBtn, function()
			setActive(self.resultPanel, false)
			pg.UIMgr.GetInstance():UnOverlayPanel(self.resultPanel, self.bg)
			self.controller:ExitGame()

			return
		end)

		self.finalScoreTxt.text = arg_30_1
		self.highestScoreText.text = arg_30_2

		return
	end)()

	return
end

function PileGameView:OnShake(arg_33_1)
	setAnchoredPosition(self.anikiAnim, {
		x = getAnchoredPosition(self.anikiAnim).x + arg_33_1
	})

	return
end

function PileGameView:OnCollapse(arg_34_1, arg_34_2, arg_34_3)
	local function var_34_0(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
		LeanTween.value(go(self.itemsContainer), arg_35_0, arg_35_1, arg_35_2):setOnUpdate(System.Action_float(function(arg_36_0)
			self.itemsContainer.eulerAngles = Vector3(0, 0, arg_36_0)

			return
		end)):setOnComplete(System.Action(arg_35_3))

		return
	end

	seriesAsync({
		function(arg_37_0)
			self.manjuuAnim:SetTrigger("shock")

			self.itemsContainer.pivot = Vector2(0.5 + arg_34_1 / self.itemsContainer.rect.width, 0)

			local var_37_0 = arg_34_2 == 1 and -35 or 35

			var_34_0(0, arg_34_2 == 1 and -35 or 35, 0.5, function()
				arg_37_0(var_37_0)

				return
			end)

			return
		end,
		function(arg_39_0, arg_39_1)
			local var_39_0 = {}
			local var_39_1 = _.values(self.items)

			table.sort(var_39_1, function(arg_40_0, arg_40_1)
				return arg_40_0.localPosition.y < arg_40_1.localPosition.y
			end)

			for iter_39_0, iter_39_1 in ipairs(var_39_1) do
				table.insert(var_39_0, function(arg_41_0)
					local var_41_0 = arg_34_2 == 1 and -90 or 90

					parallelAsync({
						function(arg_42_0)
							var_34_0(arg_39_1, var_41_0, 1, arg_42_0)

							return
						end,
						function(arg_43_0)
							LeanTween.value(go(iter_39_1), 0, arg_34_2 == 1 and -356 or 356, 1):setOnUpdate(System.Action_float(function(arg_44_0)
								iter_39_1.eulerAngles = Vector3(0, 0, arg_44_0)

								return
							end)):setOnComplete(System.Action(arg_43_0))

							return
						end,
						function(arg_45_0)
							LeanTween.moveLocalY(go(iter_39_1), iter_39_1.localPosition.y + 50 * iter_39_0, 1):setOnComplete(System.Action(arg_45_0))

							return
						end
					}, arg_41_0)

					return
				end)
			end

			parallelAsync(var_39_0, arg_39_0)

			return
		end
	}, arg_34_3)

	return
end

function PileGameView:InitSup(arg_46_1)
	if PileGameConst.DEBUG then
		local var_46_0 = cloneTplTo(self.groundTpl, self.gameContainer, "ground")

		var_46_0.sizeDelta = arg_46_1.ground.sizeDelta
		var_46_0.pivot = arg_46_1.ground.pivot
		var_46_0.localPosition = arg_46_1.ground.position
		cloneTplTo(self.deathLine, self.gameContainer, "deathLineR").localPosition = Vector3(arg_46_1.deathLine.y, 0, 0)
		cloneTplTo(self.deathLine, self.gameContainer, "deathLineL").localPosition = Vector3(arg_46_1.deathLine.x, 0, 0)
		cloneTplTo(self.safeLine, self.gameContainer, "safeLineL").localPosition = Vector3(arg_46_1.safeLine.x, 0, 0)
		cloneTplTo(self.safeLine, self.gameContainer, "safeLineR").localPosition = Vector3(arg_46_1.safeLine.y, 0, 0)
	end

	return
end

function PileGameView:AddPileCollider(arg_47_1)
	local var_47_0 = cloneTplTo(self.itemCollider, self.items[arg_47_1], "collider")

	var_47_0.localPosition = Vector3((0.5 - arg_47_1.pivot.x) * arg_47_1.sizeDelta.x + arg_47_1.collider.offset.x, (0.5 - arg_47_1.pivot.y) * arg_47_1.sizeDelta.y + arg_47_1.collider.offset.y, 0)
	var_47_0.sizeDelta = arg_47_1.collider.sizeDelta

	return
end

function PileGameView:onBackPressed()
	if isActive(self.resultPanel) then
		setActive(self.resultPanel, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.resultPanel, self.bg)
		self.controller:ExitGame()

		return true
	elseif isActive(self.exitPanel) then
		setActive(self.exitPanel, false)
		pg.UIMgr.GetInstance():UnOverlayPanel(self.exitPanel, self.bg)

		return true
	elseif isActive(self.bg) then
		self.controller:ExitGame()

		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		return true
	end

	return false
end

function PileGameView:Dispose()
	pg.DelegateInfo.Dispose(self)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.bgMgr:Clear()

	return
end

return PileGameView
