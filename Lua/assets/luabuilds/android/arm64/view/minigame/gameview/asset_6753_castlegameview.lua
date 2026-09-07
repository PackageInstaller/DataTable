local CastleGameView = class("CastleGameView", import("..BaseMiniGameView"))

CastleGameView.LEVEL_GAME = "leavel game"
CastleGameView.PAUSE_GAME = "pause game "
CastleGameView.OPEN_PAUSE_UI = "open pause ui"
CastleGameView.OPEN_LEVEL_UI = "open leave ui"
CastleGameView.BACK_MENU = "back menu"
CastleGameView.CLOSE_GAME = "close game"
CastleGameView.SHOW_RULE = "show rule"
CastleGameView.READY_START = "ready start"
CastleGameView.COUNT_DOWN = "count down"
CastleGameView.STORE_SERVER = "store server"
CastleGameView.SUBMIT_GAME_SUCCESS = "submit game success"
CastleGameView.ADD_SCORE = "add score"
CastleGameView.GAME_OVER = "game over"

function CastleGameView:getUIName()
	return CastleGameVo.game_ui
end

function CastleGameView:didEnter()
	self:initData()
	self:initEvent()
	self:initUI()
	self:initController()

	return
end

function CastleGameView:initData()
	CastleGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / ((CastleGameVo.frameRate > 60 or nil) and 60), -1)

	return
end

function CastleGameView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(CastleGameView.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			self:resumeGame()
			self:onGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(CastleGameView.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		self:gameStart()

		return
	end)
	self:bind(CastleGameView.OPEN_PAUSE_UI, function(arg_8_0, arg_8_1, arg_8_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(CastleGameView.OPEN_LEVEL_UI, function(arg_9_0, arg_9_1, arg_9_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(CastleGameView.PAUSE_GAME, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(CastleGameView.BACK_MENU, function(arg_11_0, arg_11_1, arg_11_2)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)

		local var_11_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

		if self.bgm ~= var_11_0 then
			self.bgm = var_11_0

			pg.BgmMgr.GetInstance():Push(self.__cname, var_11_0)
		end

		return
	end)
	self:bind(CastleGameView.CLOSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		self:closeView()

		return
	end)
	self:bind(CastleGameView.GAME_OVER, function(arg_13_0, arg_13_1, arg_13_2)
		self:onGameOver()

		return
	end)
	self:bind(CastleGameView.SHOW_RULE, function(arg_14_0, arg_14_1, arg_14_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[CastleGameVo.rule_tip].tip
		})

		return
	end)
	self:bind(CastleGameView.READY_START, function(arg_15_0, arg_15_1, arg_15_2)
		self:readyStart()

		return
	end)
	self:bind(CastleGameView.STORE_SERVER, function(arg_16_0, arg_16_1, arg_16_2)
		self:StoreDataToServer({
			arg_16_1
		})

		return
	end)
	self:bind(CastleGameView.SUBMIT_GAME_SUCCESS, function(arg_17_0, arg_17_1, arg_17_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(CastleGameView.ADD_SCORE, function(arg_18_0, arg_18_1, arg_18_2)
		self:addScore(arg_18_1.num)
		self.gameUI:addScore(arg_18_1)

		return
	end)

	return
end

function CastleGameView:initUI()
	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = CastleGamePopUI.New(self._tf, self)

	self.popUI:clearUI()

	self.gameUI = CastleGamingUI.New(self._tf, self)
	self.menuUI = CastleGameMenuUI.New(self._tf, self)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	return
end

function CastleGameView:initController()
	self.gameScene = CastleGameScene.New(self._tf, self)

	return
end

function CastleGameView:Update()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.S) then
			self.gameUI:press(KeyCode.S, true)
		end

		if Input.GetKeyUp(KeyCode.S) then
			self.gameUI:press(KeyCode.S, false)
		end

		if Input.GetKeyDown(KeyCode.W) then
			self.gameUI:press(KeyCode.W, true)
		end

		if Input.GetKeyUp(KeyCode.W) then
			self.gameUI:press(KeyCode.W, false)
		end

		if Input.GetKeyDown(KeyCode.A) then
			self.gameUI:press(KeyCode.A, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			self.gameUI:press(KeyCode.A, false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self.gameUI:press(KeyCode.D, true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			self.gameUI:press(KeyCode.D, false)
		end
	end

	return
end

function CastleGameView:readyStart()
	self.readyStartFlag = true

	CastleGameVo.Prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)

	return
end

function CastleGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:popCountUI(false)
	self.gameUI:start()
	self.gameUI:show(true)
	self.gameScene:start()
	self:timerStart()

	return
end

function CastleGameView:changeSpeed(arg_24_1)
	return
end

function CastleGameView:onTimer()
	self:gameStep()

	return
end

function CastleGameView:gameStep()
	self:stepRunTimeData()
	self.gameScene:step()
	self.gameUI:step()

	if CastleGameVo.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function CastleGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function CastleGameView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	self.gameScene:resume()

	return
end

function CastleGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	self.gameScene:stop()

	return
end

function CastleGameView:stepRunTimeData()
	local var_30_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_30_0 = 0.016
	end

	CastleGameVo.gameTime = CastleGameVo.gameTime - var_30_0
	CastleGameVo.gameStepTime = CastleGameVo.gameStepTime + var_30_0
	CastleGameVo.deltaTime = var_30_0

	return
end

function CastleGameView:addScore(arg_31_1)
	CastleGameVo.scoreNum = CastleGameVo.scoreNum + arg_31_1

	return
end

function CastleGameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()
	self:clearController()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self.popUI:updateSettlementUI()
		self.popUI:popSettlementUI(true)

		return
	end))

	return
end

function CastleGameView:OnApplicationPaused()
	if not self.gameStartFlag then
		return
	end

	if self.readyStartFlag then
		return
	end

	if self.settlementFlag then
		return
	end

	self:pauseGame()
	self.popUI:popPauseUI()

	return
end

function CastleGameView:clearController()
	self.gameScene:clear()

	return
end

function CastleGameView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function CastleGameView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function CastleGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(CastleGameView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		self.popUI:backPressed()
	end

	return
end

function CastleGameView:OnSendMiniGameOPDone(arg_39_1)
	return
end

function CastleGameView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return CastleGameView
