local CrossRoadPopUI = class("CrossRoadPopUI")

function CrossRoadPopUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initCountUI()
	self:initLeavelUI()
	self:initSettlementUI()

	return
end

function CrossRoadPopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(self.countUI, typeof(Animator))
	self.countDft = GetOrAddComponent(self.countUI, typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(SimpleMGEvent.COUNT_DOWN)

		return
	end)

	return
end

function CrossRoadPopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setText(findTF(self.leaveUI, "ad/desc"), i18n("mini_game_leave"))
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnConfirm"), function()
		self:ResumeGame()
		self._event:emit(CrossRoadGameView.LEAVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:ResumeGame()
		self._event:emit(CrossRoadGameView.LEAVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function CrossRoadPopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")
	self.curRoleText = findTF(self.settlementUI, "ad/1/layout2/curRoleText")
	self.curRoleTextCnt = findTF(self.settlementUI, "ad/1/layout2/curRoleText_Cnt")
	self.curScoreText = findTF(self.settlementUI, "ad/1/layout1/currentText")
	self.curScoreTextCnt = findTF(self.settlementUI, "ad/1/layout1/currentText_Cnt")

	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:ClearUI()
		self._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.settlementUI, "ad/btnAgain"), function()
		self:ClearUI()
		self._event:emit(CrossRoadGameView.AGAIN)

		return
	end, SFX_CANCEL)

	return
end

function CrossRoadPopUI:setChildVisible(arg_11_1, arg_11_2)
	for iter_11_0 = 1, arg_11_1.childCount do
		setActive(arg_11_1:GetChild(iter_11_0 - 1), arg_11_2)
	end

	return
end

function CrossRoadPopUI:PopPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	return
end

function CrossRoadPopUI:PopCountUI(arg_13_1)
	setActive(self.countUI, arg_13_1)

	return
end

function CrossRoadPopUI:PopSettlementUI(arg_14_1)
	setActive(self.settlementUI, arg_14_1)

	return
end

function CrossRoadPopUI:PopLeaveUI()
	setActive(self.leaveUI, true)

	return
end

function CrossRoadPopUI:UpdateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_16_0 = self._gameVo:GetScore()
	local var_16_1 = self._gameVo:GetRoleCnt()

	setText(self.curScoreText, i18n("mini_game_crossroad_score"))
	setText(self.curScoreTextCnt, var_16_0)
	setText(self.curRoleText, i18n("mini_game_crossroad_cnt"))
	setText(self.curRoleTextCnt, var_16_1)
	self._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, {
		num = var_16_0,
		cnt = var_16_1
	})

	return
end

function CrossRoadPopUI:BackPressed()
	if isActive(self.leaveUI) then
		self:ResumeGame()
		self._event:emit(CrossRoadGameView.LEAVEL_GAME, false)
	else
		setActive(self.leaveUI, true)
		self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
	end

	return
end

function CrossRoadPopUI:ResumeGame()
	setActive(self.leaveUI, false)

	return
end

function CrossRoadPopUI:UpdateGameUI(arg_19_1)
	setText(self.scoreTf, arg_19_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_19_1.gameTime))

	return
end

function CrossRoadPopUI:ReadyStart()
	self:PopCountUI(true)
	self.countAnimator:Play("cross_count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(WatermelonGameConst.SFX_COUNT_DOWN)

	return
end

function CrossRoadPopUI:ClearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return CrossRoadPopUI
