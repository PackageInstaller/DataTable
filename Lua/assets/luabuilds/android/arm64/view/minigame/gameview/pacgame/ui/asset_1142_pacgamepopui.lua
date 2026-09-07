local WatermelonGamePopUI = class("WatermelonGamePopUI")

function WatermelonGamePopUI:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._event = arg_1_2
	self._gameVo = arg_1_3

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()

	return
end

function WatermelonGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(SimpleMGEvent.COUNT_DOWN)

		return
	end)

	return
end

function WatermelonGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setText(findTF(self.leaveUI, "ad/desc"), i18n("mini_game_leave"))
	setText(findTF(self.leaveUI, "ad/btnConfirmDesc"), i18n("ryza_task_confirm"))
	setText(findTF(self.leaveUI, "ad/btnCancelDesc"), i18n("ryza_task_cancel"))
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnConfirm"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function WatermelonGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	setText(findTF(self.pauseUI, "ad/desc"), i18n("mini_game_pause"))
	setText(findTF(self.pauseUI, "ad/btnDesc"), i18n("mini_game_continue"))
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function WatermelonGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setText(findTF(self.settlementUI, "ad/btnOver/text"), i18n("mini_game_over_game"))
	setText(findTF(self.settlementUI, "ad/HighDesc"), i18n("mini_game_high_score"))
	setText(findTF(self.settlementUI, "ad/CurDesc"), i18n("mini_game_cur_score"))
	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:ClearUI()
		self._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function WatermelonGamePopUI:setChildVisible(arg_12_1, arg_12_2)
	for iter_12_0 = 1, arg_12_1.childCount do
		setActive(arg_12_1:GetChild(iter_12_0 - 1), arg_12_2)
	end

	return
end

function WatermelonGamePopUI:PopPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function WatermelonGamePopUI:PopCountUI(arg_14_1)
	setActive(self.countUI, arg_14_1)

	return
end

function WatermelonGamePopUI:PopSettlementUI(arg_15_1)
	setActive(self.settlementUI, arg_15_1)

	return
end

function WatermelonGamePopUI:PopLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function WatermelonGamePopUI:UpdateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_17_0 = self._gameVo:GetScore()
	local var_17_1

	if self._gameVo:GetConfig("game_room") > 0 then
		var_17_1 = getProxy(GameRoomProxy):getRoomScore(self._gameVo:GetConfig("game_room"))
	else
		local var_17_2 = getProxy(MiniGameProxy):GetHighScore(self._gameVo:GetGameId())

		var_17_1 = var_17_2 and #var_17_2 > 0 and var_17_2[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_17_1 < var_17_0)

	if var_17_0 > 0 and var_17_1 < var_17_0 then
		self._event:emit(SimpleMGEvent.STORE_SERVER, {
			var_17_0,
			1
		})
	end

	local var_17_3 = findTF(self.settlementUI, "ad/highText")

	setText(findTF(self.settlementUI, "ad/currentText"), var_17_0)
	setText(var_17_3, var_17_1)
	self._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_17_0)

	return
end

function WatermelonGamePopUI:BackPressed()
	if isActive(self.pauseUI) then
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:ResumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		if not self._gameVo:IsSettlement() then
			self:PopPauseUI()
			self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
		end
	else
		self:ResumeGame()
	end

	return
end

function WatermelonGamePopUI:ResumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function WatermelonGamePopUI:UpdateGameUI(arg_20_1)
	setText(self.scoreTf, arg_20_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_20_1.gameTime))

	return
end

function WatermelonGamePopUI:ReadyStart()
	self:PopCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(WatermelonGameConst.SFX_COUNT_DOWN)

	return
end

function WatermelonGamePopUI:ClearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return WatermelonGamePopUI
