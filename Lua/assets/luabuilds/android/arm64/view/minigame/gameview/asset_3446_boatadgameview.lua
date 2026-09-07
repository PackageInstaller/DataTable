local BoatAdGameView = class("BoatAdGameView", import("..BaseMiniGameView"))
local BoatAdGameVo = import("view.miniGame.gameView.BoatAdGame.BoatAdGameVo")

function BoatAdGameView:getUIName()
	return BoatAdGameVo.game_ui
end

function BoatAdGameView:getBGM()
	return BoatAdGameVo.menu_bgm
end

function BoatAdGameView:didEnter()
	self:initData()
	self:initEvent()
	self:initUI()
	self:checkGet()

	return
end

function BoatAdGameView:checkGet()
	local var_4_0 = self:GetMGHubData()

	if var_4_0.ultimate and var_4_0.ultimate == 1 then
		return
	end

	if BoatAdGameVo.GetGameTimes() == 0 then
		if BoatAdGameVo.GetGameMaxTimes() > BoatAdGameVo.GetGameUseTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_4_0.id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function BoatAdGameView:initData()
	BoatAdGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)
	BoatAdGameVo.SetGameTpl(findTF(self._tf, "tpl"))

	local var_5_0 = Application.targetFrameRate

	if Application.targetFrameRate > 60 then
		var_5_0 = 60
	end

	self.stepCount = 1 / var_5_0 * 0.9
	self.realTimeStartUp = Time.realtimeSinceStartup
	self.timer = Timer.New(function()
		if Time.realtimeSinceStartup - self.realTimeStartUp > self.stepCount then
			self:onTimer()

			self.realTimeStartUp = Time.realtimeSinceStartup
		end

		return
	end, 1 / var_5_0, -1)

	return
end

function BoatAdGameView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(SimpleMGEvent.LEVEL_GAME, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_1 then
			self:resumeGame()
			self:onGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SimpleMGEvent.USE_SKILL, function(arg_9_0, arg_9_1, arg_9_2)
		self.gameScene:useSkill(arg_9_1)

		return
	end)
	self:bind(SimpleMGEvent.COUNT_DOWN, function(arg_10_0, arg_10_1, arg_10_2)
		self:gameStart()

		return
	end)
	self:bind(SimpleMGEvent.OPEN_PAUSE_UI, function(arg_11_0, arg_11_1, arg_11_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(SimpleMGEvent.OPEN_LEVEL_UI, function(arg_12_0, arg_12_1, arg_12_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(SimpleMGEvent.PAUSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SimpleMGEvent.BACK_MENU, function(arg_14_0, arg_14_1, arg_14_2)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)

		local var_14_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

		if self.bgm ~= var_14_0 then
			self.bgm = var_14_0

			pg.BgmMgr.GetInstance():Push(self.__cname, var_14_0)
		end

		self:checkGet()

		return
	end)
	self:bind(SimpleMGEvent.CLOSE_GAME, function(arg_15_0, arg_15_1, arg_15_2)
		self:closeView()

		return
	end)
	self:bind(SimpleMGEvent.BACK_HOME, function(arg_16_0, arg_16_1, arg_16_2)
		self:emit(BaseUI.ON_HOME)

		return
	end)
	self:bind(SimpleMGEvent.GAME_OVER, function(arg_17_0, arg_17_1, arg_17_2)
		self:onGameOver(arg_17_1)

		return
	end)
	self:bind(SimpleMGEvent.SHOW_RULE, function(arg_18_0, arg_18_1, arg_18_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[BoatAdGameVo.rule_tip].tip
		})

		return
	end)
	self:bind(SimpleMGEvent.READY_START, function(arg_19_0, arg_19_1, arg_19_2)
		self:readyStart()

		return
	end)
	self:bind(SimpleMGEvent.STORE_SERVER, function(arg_20_0, arg_20_1, arg_20_2)
		self:StoreDataToServer({
			arg_20_1
		})

		return
	end)
	self:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		local var_21_0 = BoatAdGameVo.char:getHp()

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_SUCCESS_DATA,
			args1 = {
				BoatAdGameVo.scoreNum,
				BoatAdGameVo.GetGameUseTimes() + 1,
				(math.floor(BoatAdGameVo.gameStepTime))
			}
		})

		return
	end)
	self:bind(SimpleMGEvent.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		self:addScore(arg_22_1)

		return
	end)
	self:bind(BoatAdGameEvent.OPEN_AD_WINDOW, function(arg_23_0, arg_23_1, arg_23_2)
		self:pauseGame()
		self.popUI:oepnAd()

		return
	end)
	self:bind(BoatAdGameEvent.CLOSE_AD_UI, function(arg_24_0, arg_24_1, arg_24_2)
		self:resumeGame()

		return
	end)

	return
end

function BoatAdGameView:initUI()
	if IsUnityEditor then
		setActive(findTF(self._tf, "tpl"), false)
	end

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = BoatAdGamePopUI.New(self._tf, self)

	self.popUI:clearUI()

	self.gameUI = BoatAdGamingUI.New(self._tf, self)

	self.gameUI:show(false)

	self.menuUI = BoatAdGameMenuUI.New(self._tf, self)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	self.gameScene = BoatAdGameScene.New(self._tf, self)

	return
end

function BoatAdGameView:Update()
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

		if Input.GetKeyDown(KeyCode.J) then
			self.gameScene:press(KeyCode.J, true)
		end
	end

	return
end

function BoatAdGameView:readyStart()
	self.readyStartFlag = true

	BoatAdGameVo.Prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)
	setActive(findTF(self._tf, "sceneBg"), false)

	return
end

function BoatAdGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:popCountUI(false)
	self.gameUI:start()
	self.gameUI:show(true)

	if self.bgm ~= BoatAdGameVo.game_bgm then
		self.bgm = BoatAdGameVo.game_bgm

		pg.BgmMgr.GetInstance():Push(self.__cname, BoatAdGameVo.game_bgm)
	end

	self.gameScene:start()
	self:timerStart()

	return
end

function BoatAdGameView:changeSpeed(arg_29_1)
	return
end

function BoatAdGameView:onTimer()
	self:gameStep()

	return
end

function BoatAdGameView:gameStep()
	self:stepRunTimeData()
	self.gameScene:step(BoatAdGameVo.deltaTime)
	self.gameUI:step(BoatAdGameVo.deltaTime)

	if BoatAdGameVo.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function BoatAdGameView:timerStart()
	if not self.timer.running then
		self.realTimeStartUp = Time.realtimeSinceStartup

		self.timer:Start()
	end

	return
end

function BoatAdGameView:timerResume()
	if not self.timer.running then
		self.realTimeStartUp = Time.realtimeSinceStartup

		self.timer:Start()
	end

	self.gameScene:resume()

	return
end

function BoatAdGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	self.gameScene:stop()

	return
end

function BoatAdGameView:stepRunTimeData()
	BoatAdGameVo.gameTime = BoatAdGameVo.gameTime - (Time.realtimeSinceStartup - self.realTimeStartUp)
	BoatAdGameVo.gameStepTime = BoatAdGameVo.gameStepTime + (Time.realtimeSinceStartup - self.realTimeStartUp)
	BoatAdGameVo.deltaTime = Time.realtimeSinceStartup - self.realTimeStartUp

	return
end

function BoatAdGameView:addScore(arg_36_1)
	BoatAdGameVo.scoreNum = BoatAdGameVo.scoreNum + arg_36_1

	return
end

function BoatAdGameView:onGameOver(arg_37_1)
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
	setActive(findTF(self._tf, "sceneBg"), true)

	return
end

function BoatAdGameView:OnApplicationPaused()
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

function BoatAdGameView:clearController()
	self.gameScene:clear()

	return
end

function BoatAdGameView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function BoatAdGameView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerResume()

	return
end

function BoatAdGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(BoatAdGameView.ON_BACK_PRESSED)

		return
	else
		if self.settlementFlag then
			return
		end

		self.popUI:backPressed()
	end

	return
end

function BoatAdGameView:OnSendMiniGameOPDone(arg_44_1)
	return
end

function BoatAdGameView:willExit()
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

	BoatAdGameVo.Clear()

	return
end

return BoatAdGameView
