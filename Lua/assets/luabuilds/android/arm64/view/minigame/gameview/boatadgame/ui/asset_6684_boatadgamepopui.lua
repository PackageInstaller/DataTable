local BoatAdGamePopUI = class("BoatAdGamePopUI")
local var_0_1
local var_0_2

function BoatAdGamePopUI:Ctor(arg_1_1, arg_1_2)
	self._tf = arg_1_1
	self._event = arg_1_2
	var_0_1 = BoatAdGameVo

	self:initCountUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initSettlementUI()
	self:initAdWindow()

	return
end

function BoatAdGamePopUI:initCountUI()
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

function BoatAdGamePopUI:initLeavelUI()
	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	GetComponent(findTF(self.leaveUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(self.leaveUI, false)
	onButton(self._event, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, true)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function BoatAdGamePopUI:initPauseUI()
	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	GetComponent(findTF(self.pauseUI, "ad/desc"), typeof(Image)):SetNativeSize()
	setActive(self.pauseUI, false)
	onButton(self._event, findTF(self.pauseUI, "ad/btnOk"), function()
		self:resumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)

		return
	end, SFX_CANCEL)

	return
end

function BoatAdGamePopUI:initSettlementUI()
	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	setActive(self.settlementUI, false)
	onButton(self._event, findTF(self.settlementUI, "ad/btnOver"), function()
		self:clearUI()
		self._event:emit(SimpleMGEvent.BACK_MENU)

		return
	end, SFX_CANCEL)

	return
end

function BoatAdGamePopUI:initAdWindow()
	self.adUI = findTF(self._tf, "pop/AdUI")

	setActive(self.adUI, false)

	self.mvContent = findTF(self.adUI, "ad/movie/view/content")
	self.btnPlay = findTF(self.adUI, "ad/movie/btnPlay")
	self.btnStop = findTF(self.adUI, "ad/movie/btnStop")
	self.btnRepeat = findTF(self.adUI, "ad/movie/btnRepeat")

	setActive(self.btnRepeat, false)
	onButton(self._event, findTF(self.adUI, "ad/bottom"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 3 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.isLoading then
			return
		end

		setActive(self.adUI, false)
		self:clearMovie()
		self._event:emit(BoatAdGameEvent.CLOSE_AD_UI)

		return
	end, SFX_CANCEL)
	onButton(self._event, findTF(self.adUI, "ad/bgClose"), function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 3 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.isLoading then
			return
		end

		setActive(self.adUI, false)
		self:clearMovie()
		self._event:emit(BoatAdGameEvent.CLOSE_AD_UI)

		return
	end, SFX_CANCEL)
	onButton(self._event, self.btnRepeat, function()
		if var_0_2 and Time.realtimeSinceStartup - var_0_2 < 3 then
			return
		end

		var_0_2 = Time.realtimeSinceStartup

		if self.mvManaCpkUI and self.mvCompleteFlag then
			self:loadMv()
		end

		return
	end)

	return
end

function BoatAdGamePopUI:clearMovie()
	if self.mvGo then
		self.mvManaCpkUI:SetPlayEndHandler(nil)
		self.mvManaCpkUI:StopCpk()
		destroy(self.mvGo)

		self.mvManaCpkUI = nil
		self.mvGo = nil
		self.mvName = nil
	end

	return
end

function BoatAdGamePopUI:loadMv()
	self:clearMovie()

	if self.isLoading then
		return
	end

	local var_17_0 = "BoatAdMvUI"

	self.isLoading = true
	self.mvCompleteFlag = false

	setActive(self.btnPlay, false)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, false)
	PoolMgr.GetInstance():GetUI(var_17_0, true, function(arg_18_0)
		self.mvGo = arg_18_0
		self.mvName = var_17_0
		self.mvManaCpkUI = GetComponent(findTF(self.mvGo, "video/cpk"), typeof(CriManaCpkUI))

		self.mvManaCpkUI:SetPlayEndHandler(System.Action(function()
			self:mvComplete()

			return
		end))
		self.mvManaCpkUI:PlayCpk()
		self.mvManaCpkUI.player:SetVolume(PlayerPrefs.GetFloat("bgm_vol", DEFAULT_BGMVOLUME) or 1)

		if self.isLoading == false then
			self:clearMovie()
		else
			self.isLoading = false

			setParent(self.mvGo, self.mvContent)
			setActive(self.mvGo, true)
		end

		return
	end)

	return
end

function BoatAdGamePopUI:mvComplete()
	self.mvCompleteFlag = true

	self:onPlayerEnd()

	return
end

function BoatAdGamePopUI:onPlayerEnd()
	setActive(self.btnPlay, false)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, true)

	return
end

function BoatAdGamePopUI:onPlayerStop()
	setActive(self.btnPlay, true)
	setActive(self.btnStop, false)
	setActive(self.btnRepeat, false)

	return
end

function BoatAdGamePopUI:onPlayerStart()
	setActive(self.btnPlay, false)
	setActive(self.btnStop, true)
	setActive(self.btnRepeat, false)

	return
end

function BoatAdGamePopUI:oepnAd()
	setActive(self.adUI, true)

	var_0_2 = Time.realtimeSinceStartup

	self:loadMv()

	return
end

function BoatAdGamePopUI:updateSettlementUI()
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_25_0 = var_0_1.scoreNum
	local var_25_1

	if var_0_1.GetMiniGameData():getConfig("game_room") > 0 then
		var_25_1 = getProxy(GameRoomProxy):getRoomScore(var_0_1.GetMiniGameData():getConfig("game_room"))
	else
		local var_25_2 = var_0_1.GetMiniGameData():GetRuntimeData("elements")

		var_25_1 = var_25_2 and #var_25_2 > 0 and var_25_2[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_25_1 < var_25_0)

	if var_25_1 < var_25_0 then
		var_25_1 = var_25_0

		self._event:emit(SimpleMGEvent.STORE_SERVER, var_25_0)
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_25_1)
	setText(findTF(self.settlementUI, "ad/currentText"), var_25_0)
	self._event:emit(SimpleMGEvent.SUBMIT_GAME_SUCCESS, var_25_0)

	return
end

function BoatAdGamePopUI:backPressed()
	if isActive(self.pauseUI) then
		self:resumeGame()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, false)
	elseif isActive(self.leaveUI) then
		self:resumeGame()
		self._event:emit(SimpleMGEvent.LEVEL_GAME, false)
	elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
		self:popPauseUI()
		self._event:emit(SimpleMGEvent.PAUSE_GAME, true)
	else
		self:resumeGame()
	end

	return
end

function BoatAdGamePopUI:resumeGame()
	setActive(self.leaveUI, false)
	setActive(self.pauseUI, false)

	return
end

function BoatAdGamePopUI:popLeaveUI()
	if isActive(self.pauseUI) then
		setActive(self.pauseUI, false)
	end

	setActive(self.leaveUI, true)

	return
end

function BoatAdGamePopUI:popPauseUI()
	if isActive(self.leaveUI) then
		setActive(self.leaveUI, false)
	end

	setActive(self.pauseUI, true)

	return
end

function BoatAdGamePopUI:updateGameUI(arg_30_1)
	setText(self.scoreTf, arg_30_1.scoreNum)
	setText(self.gameTimeS, math.ceil(arg_30_1.gameTime))

	return
end

function BoatAdGamePopUI:readyStart()
	self:popCountUI(true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_DOWN)

	return
end

function BoatAdGamePopUI:popCountUI(arg_32_1)
	setActive(self.countUI, arg_32_1)

	return
end

function BoatAdGamePopUI:popSettlementUI(arg_33_1)
	setActive(self.settlementUI, arg_33_1)

	return
end

function BoatAdGamePopUI:clearUI()
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)

	return
end

return BoatAdGamePopUI
