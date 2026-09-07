local SailBoatGamePopUI = class("SailBoatGamePopUI")
local var_0_1

function SailBoatGamePopUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = SailBoatGameVo

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()

	return
end

function SailBoatGamePopUI:initCountUI()
	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		self._event:emit(SailBoatGameView.COUNT_DOWN)

		return
	end)

	return
end

function SailBoatGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(SailBoatGameView.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()
		self._event:emit(SailBoatGameView.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function SailBoatGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	setActive(self.pauseUI, false)
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(SailBoatGameView.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function SailBoatGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()
		self._event:emit(SailBoatGameView.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function SailBoatGamePopUI:updateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_12_0 = var_0_1.GetMiniGameData():GetRuntimeData("elements")
	local var_12_1 = var_0_1.scoreNum
	local var_12_2

	if var_12_0 and #var_12_0 > 0 then
		var_12_2 = var_12_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_12_2 < var_12_1)

	if var_12_2 < var_12_1 then
		var_12_2 = var_12_1

		self._event:emit(SailBoatGameView.STORE_SERVER, var_12_1)
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_12_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_12_1)
	self._event:emit(SailBoatGameView.SUBMIT_GAME_SUCCESS)

	return
end

function SailBoatGamePopUI:backPressed()
	if isActive(self.pauseUI) then
		self:resumeGame()
		self._event:emit(SailBoatGameView.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:resumeGame()
		self._event:emit(SailBoatGameView.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		self:popPauseUI()
		self._event:emit(SailBoatGameView.PAUSE_GAME, true)
	else
		self:resumeGame()
	end

	return
end

function SailBoatGamePopUI:resumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function SailBoatGamePopUI:popLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function SailBoatGamePopUI:popPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function SailBoatGamePopUI:updateGameUI(arg_17_1)
	setText(self.scoreTf, arg_17_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_17_1.gameTime))

	return
end

function SailBoatGamePopUI:readyStart()
	self:popCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_DOWN)

	return
end

function SailBoatGamePopUI:popCountUI(arg_19_1)
	setActive(self.countUI, arg_19_1)

	return
end

function SailBoatGamePopUI:popSettlementUI(arg_20_1)
	setActive(self.settlementUI, arg_20_1)

	return
end

function SailBoatGamePopUI:clearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return SailBoatGamePopUI
