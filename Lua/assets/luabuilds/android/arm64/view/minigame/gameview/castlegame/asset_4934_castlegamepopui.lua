local CastleGamePopUI = class("CastleGamePopUI")

function CastleGamePopUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()

	return
end

function CastleGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(CastleGameView.COUNT_DOWN)

		return
	end)

	return
end

function CastleGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(CastleGameView.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()
		self._event:emit(CastleGameView.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function CastleGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(CastleGameView.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function CastleGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()
		self._event:emit(CastleGameView.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function CastleGamePopUI:updateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_12_0 = CastleGameVo.GetMiniGameData():GetRuntimeData("elements")
	local var_12_1 = CastleGameVo.scoreNum
	local var_12_2

	if var_12_0 and #var_12_0 > 0 then
		var_12_2 = var_12_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_12_2 < var_12_1)

	if var_12_2 < var_12_1 then
		var_12_2 = var_12_1

		self._event:emit(CastleGameView.STORE_SERVER, var_12_1)
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_12_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_12_1)

	local var_12_3 = CastleGameVo.GetGameTimes()

	if var_12_3 and var_12_3 > 0 and not self.sendSuccessFlag then
		self._event:emit(CastleGameView.SUBMIT_GAME_SUCCESS)
	end

	return
end

function CastleGamePopUI:backPressed()
	if isActive(self.pauseUI) then
		self:resumeGame()
		self._event:emit(CastleGameView.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:resumeGame()
		self._event:emit(CastleGameView.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		self:popPauseUI()
		self._event:emit(CastleGameView.PAUSE_GAME, true)
	else
		self:resumeGame()
	end

	return
end

function CastleGamePopUI:resumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function CastleGamePopUI:popLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function CastleGamePopUI:popPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function CastleGamePopUI:updateGameUI(arg_17_1)
	setText(self.scoreTf, arg_17_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_17_1.gameTime))

	return
end

function CastleGamePopUI:readyStart()
	self:popCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(CastleGameVo.SFX_COUNT_DOWN)

	return
end

function CastleGamePopUI:popCountUI(arg_19_1)
	setActive(self.countUI, arg_19_1)

	return
end

function CastleGamePopUI:popSettlementUI(arg_20_1)
	setActive(self.settlementUI, arg_20_1)

	return
end

function CastleGamePopUI:clearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return CastleGamePopUI
