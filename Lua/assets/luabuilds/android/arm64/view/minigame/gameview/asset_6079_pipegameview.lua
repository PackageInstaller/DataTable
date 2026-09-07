local PipeGameView = class("PipeGameView", import("..BaseMiniGameView"))
local PipeGameVo = import("view.miniGame.gameView.PipeGame.PipeGameVo")

function PipeGameView:getUIName()
	return PipeGameVo.game_ui
end

function PipeGameView:getBGM()
	return PipeGameVo.menu_bgm
end

function PipeGameView:didEnter()
	self:initData()
	self:initEvent()
	self:initUI()

	return
end

function PipeGameView:initData()
	PipeGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)
	PipeGameVo.SetGameTpl(findTF(self._tf, "tpl"))

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / ((PipeGameVo.frameRate > 60 or nil) and 60), -1)

	return
end

function PipeGameView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.UpdateBeat, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(PipeGameEvent.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			self:resumeGame()
			self.gameScene:setGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(PipeGameEvent.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		self:gameStart()

		return
	end)
	self:bind(PipeGameEvent.ON_HOME, function(arg_9_0, arg_9_1, arg_9_2)
		self:emit(BaseUI.ON_HOME)

		return
	end)
	self:bind(PipeGameEvent.OPEN_PAUSE_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(PipeGameEvent.OPEN_LEVEL_UI, function(arg_11_0, arg_11_1, arg_11_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(PipeGameEvent.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(PipeGameEvent.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)
		self:changeBgm(PipeGameConst.bgm_type_default)

		return
	end)
	self:bind(PipeGameEvent.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		self:closeView()

		return
	end)
	self:bind(PipeGameEvent.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		self:onGameOver()

		return
	end)
	self:bind(PipeGameEvent.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[PipeGameVo.rule_tip].tip
		})

		return
	end)
	self:bind(PipeGameEvent.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		self.popUI:showRank(true)

		return
	end)
	self:bind(PipeGameEvent.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		self:readyStart()

		return
	end)
	self:bind(PipeGameEvent.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy(MiniGameProxy):UpdataHighScore(PipeGameVo.game_id, arg_19_1)

		return
	end)
	self:bind(PipeGameEvent.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(PipeGameEvent.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		self:addScore(arg_21_1.num)
		self.gameUI:addScore(arg_21_1)

		return
	end)

	return
end

function PipeGameView:initUI()
	if IsUnityEditor then
		setActive(findTF(self._tf, "tpl"), false)
	end

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = PipeGamePopUI.New(self._tf, self)

	self.popUI:clearUI()

	self.gameUI = PipeGamingUI.New(self._tf, self)

	self.gameUI:show(false)

	self.menuUI = PipeGameMenuUI.New(self._tf, self)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	self.gameScene = PipeGameScene.New(self._tf, self)

	return
end

function PipeGameView:changeBgm(arg_23_1)
	local var_23_0

	if arg_23_1 == PipeGameConst.bgm_type_default then
		var_23_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_menu then
		var_23_0 = PipeGameVo.menu_bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_game then
		var_23_0 = PipeGameVo.game_bgm
	end

	if self.bgm ~= var_23_0 then
		self.bgm = var_23_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_23_0)
	end

	return
end

function PipeGameView:UpdateBeat()
	if self.gameStop or self.settlementFlag then
		return
	end

	return
end

function PipeGameView:readyStart()
	self.readyStartFlag = true

	PipeGameVo.Prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)

	return
end

function PipeGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:popCountUI(false)
	self.gameUI:start()
	self.gameUI:show(true)
	self.gameScene:start()
	self:timerStart()
	self:changeBgm(PipeGameConst.bgm_type_game)

	return
end

function PipeGameView:changeSpeed(arg_27_1)
	return
end

function PipeGameView:onTimer()
	self:gameStep()

	return
end

function PipeGameView:gameStep()
	self:stepRunTimeData()
	self.gameScene:step(PipeGameVo.deltaTime)
	self.gameUI:step(PipeGameVo.deltaTime)

	return
end

function PipeGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function PipeGameView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	self.gameScene:resume()

	return
end

function PipeGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	self.gameScene:stop()

	return
end

function PipeGameView:stepRunTimeData()
	PipeGameVo.gameTime = PipeGameVo.gameTime - Time.deltaTime

	if not PipeGameVo.startSettlement then
		PipeGameVo.gameDragTime = PipeGameVo.gameDragTime - Time.deltaTime

		if PipeGameVo.gameDragTime < 0 then
			PipeGameVo.gameDragTime = 0
		end
	end

	PipeGameVo.gameStepTime = PipeGameVo.gameStepTime + Time.deltaTime
	PipeGameVo.deltaTime = Time.deltaTime

	return
end

function PipeGameView:addScore(arg_34_1)
	PipeGameVo.scoreNum = PipeGameVo.scoreNum + arg_34_1

	return
end

function PipeGameView:onGameOver()
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

function PipeGameView:OnApplicationPaused()
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

function PipeGameView:clearController()
	self.gameScene:clear()

	return
end

function PipeGameView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function PipeGameView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function PipeGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		return
	else
		if self.settlementFlag then
			return
		end

		self.popUI:backPressed()
	end

	return
end

function PipeGameView:OnSendMiniGameOPDone(arg_42_1)
	return
end

function PipeGameView:willExit()
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

	PipeGameVo.Clear()

	return
end

return PipeGameView
