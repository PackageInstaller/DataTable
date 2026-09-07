local GameRoomLaunchView = class("GameRoomLaunchView", import("..BaseMiniGameView"))

GameRoomLaunchView.LEVEL_GAME = "leavel game"
GameRoomLaunchView.PAUSE_GAME = "pause game "
GameRoomLaunchView.OPEN_PAUSE_UI = "open pause ui"
GameRoomLaunchView.OPEN_LEVEL_UI = "open leave ui"
GameRoomLaunchView.BACK_MENU = "back menu"
GameRoomLaunchView.CLOSE_GAME = "close game"
GameRoomLaunchView.SHOW_RULE = "show rule"
GameRoomLaunchView.READY_START = "ready start"
GameRoomLaunchView.COUNT_DOWN = "count down"
GameRoomLaunchView.STORE_SERVER = "store server"
GameRoomLaunchView.SUBMIT_GAME_SUCCESS = "submit game success"
GameRoomLaunchView.ADD_SCORE = "add score"
GameRoomLaunchView.GAME_OVER = "game over"
GameRoomLaunchView.JOYSTICK_ACTIVE_CHANGE = "joy stick active change"
GameRoomLaunchView.PRESS_SKILL = "press skill"

function GameRoomLaunchView:getUIName()
	return LaunchBallGameVo.game_room_ui
end

function GameRoomLaunchView:getBGM()
	return LaunchBallGameVo.game_bgm
end

function GameRoomLaunchView:didEnter()
	if not LaunchBallGameVo.gameRoundData then
		LaunchBallGameVo.initRoundData(3, 1)
	end

	self:initData()
	self:initEvent()
	self:initUI()
	self:initController()

	if LaunchBallGameVo.gameRoundData.type == LaunchBallGameConst.round_type_zhuanshu then
		LaunchBallGameVo.SetPlayer(LaunchBallGameVo.gameRoundData.player_id)
		self:readyStart()
	end

	return
end

function GameRoomLaunchView:initData()
	LaunchBallGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)

	LaunchBallGameVo.game_room_flag = true
	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / ((LaunchBallGameVo.frameRate > 60 or nil) and 60), -1)

	return
end

function GameRoomLaunchView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(GameRoomLaunchView.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			self:resumeGame()
			self:onGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(GameRoomLaunchView.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		self:gameStart()

		return
	end)
	self:bind(GameRoomLaunchView.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(GameRoomLaunchView.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(GameRoomLaunchView.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(GameRoomLaunchView.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		if LaunchBallGameVo.gameRoundData.type ~= LaunchBallGameConst.round_type_wuxian then
			self:closeView()

			return
		end

		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)

		local var_12_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

		if self.bgm ~= var_12_0 then
			self.bgm = var_12_0

			pg.BgmMgr.GetInstance():Push(self.__cname, var_12_0)
		end

		return
	end)
	self:bind(GameRoomLaunchView.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		self:closeView()

		return
	end)
	self:bind(GameRoomLaunchView.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		self:onGameOver()

		return
	end)
	self:bind(GameRoomLaunchView.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[LaunchBallGameVo.rule_tip].tip
		})

		return
	end)
	self:bind(GameRoomLaunchView.READY_START, function(arg_16_0, arg_16_1, arg_16_2)
		self:readyStart()

		return
	end)
	self:bind(GameRoomLaunchView.STORE_SERVER, function(arg_17_0, arg_17_1, arg_17_2)
		self:StoreDataToServer({
			arg_17_1
		})

		return
	end)
	self:bind(GameRoomLaunchView.SUBMIT_GAME_SUCCESS, function(arg_18_0, arg_18_1, arg_18_2)
		self:SendSuccess(LaunchBallGameVo.scoreNum)

		return
	end)
	self:bind(GameRoomLaunchView.ADD_SCORE, function(arg_19_0, arg_19_1, arg_19_2)
		self:addScore(arg_19_1.num)
		self.gameUI:addScore(arg_19_1)

		return
	end)
	self:bind(GameRoomLaunchView.JOYSTICK_ACTIVE_CHANGE, function(arg_20_0, arg_20_1, arg_20_2)
		if self.gameStartFlag then
			self.gameScene:joystickActive(arg_20_1)
		end

		return
	end)
	self:bind(GameRoomLaunchView.PRESS_SKILL, function(arg_21_0, arg_21_1, arg_21_2)
		self.gameScene:useSkill()

		return
	end)

	return
end

function GameRoomLaunchView:initUI()
	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = LaunchBallGamePopUI.New(self._tf, self)

	self.popUI:clearUI()

	self.gameUI = LaunchBallGamingUI.New(self._tf, self)

	self.gameUI:show(false)

	self.menuUI = LaunchBallGameMenuUI.New(self._tf, self)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	return
end

function GameRoomLaunchView:initController()
	self.gameScene = LaunchBallGameScene.New(self._tf, self)

	return
end

function GameRoomLaunchView:Update()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.S) and self.timer then
			self:timerStop()
		end

		if Input.GetKeyUp(KeyCode.S) then
			self.gameUI:press(KeyCode.S, false)
		end

		if Input.GetKeyDown(KeyCode.W) and self.timer then
			self:timerStart()
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
			self:onTimer()
		end
	end

	return
end

function GameRoomLaunchView:readyStart()
	self.readyStartFlag = true

	LaunchBallGameVo.Prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)

	return
end

function GameRoomLaunchView:gameStart()
	pg.BgmMgr.GetInstance():Push(self.__cname, LaunchBallGameConst.map_data[LaunchBallGameVo.gameRoundData.map].bgm)

	self.bgm = LaunchBallGameConst.map_data[LaunchBallGameVo.gameRoundData.map].bgm
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

function GameRoomLaunchView:changeSpeed(arg_27_1)
	return
end

function GameRoomLaunchView:onTimer()
	self:gameStep()

	return
end

function GameRoomLaunchView:gameStep()
	self:stepRunTimeData()
	self.gameScene:step()
	self.gameUI:step()

	if LaunchBallGameVo.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function GameRoomLaunchView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GameRoomLaunchView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	self.gameScene:resume()

	return
end

function GameRoomLaunchView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	self.gameScene:stop()

	return
end

function GameRoomLaunchView:stepRunTimeData()
	local var_33_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_33_0 = 0.016
	end

	LaunchBallGameVo.gameTime = LaunchBallGameVo.gameTime - var_33_0
	LaunchBallGameVo.gameStepTime = LaunchBallGameVo.gameStepTime + var_33_0
	LaunchBallGameVo.deltaTime = var_33_0

	return
end

function GameRoomLaunchView:addScore(arg_34_1)
	LaunchBallGameVo.scoreNum = LaunchBallGameVo.scoreNum + arg_34_1

	return
end

function GameRoomLaunchView:onGameOver()
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

function GameRoomLaunchView:OnApplicationPaused()
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

function GameRoomLaunchView:clearController()
	self.gameScene:clear()

	return
end

function GameRoomLaunchView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function GameRoomLaunchView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function GameRoomLaunchView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(GameRoomLaunchView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		self.popUI:backPressed()
	end

	return
end

function GameRoomLaunchView:OnSendMiniGameOPDone(arg_42_1)
	return
end

function GameRoomLaunchView:willExit()
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

return GameRoomLaunchView
