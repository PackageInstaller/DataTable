local SailBoatGameView = class("SailBoatGameView", import("..BaseMiniGameView"))

SailBoatGameView.LEVEL_GAME = "leavel game"
SailBoatGameView.PAUSE_GAME = "pause game "
SailBoatGameView.OPEN_PAUSE_UI = "open pause ui"
SailBoatGameView.OPEN_LEVEL_UI = "open leave ui"
SailBoatGameView.BACK_MENU = "back menu"
SailBoatGameView.OPEN_EQUIP_UI = "open equip ui"
SailBoatGameView.CLOSE_GAME = "close game"
SailBoatGameView.SHOW_RULE = "show rule"
SailBoatGameView.READY_START = "ready start"
SailBoatGameView.COUNT_DOWN = "count down"
SailBoatGameView.STORE_SERVER = "store server"
SailBoatGameView.SUBMIT_GAME_SUCCESS = "submit game success"
SailBoatGameView.ADD_SCORE = "add score"
SailBoatGameView.GAME_OVER = "game over"
SailBoatGameView.USE_SKILL = "use skill"
SailBoatGameView.JOYSTICK_ACTIVE_CHANGE = "joy stick active change"

local SailBoatGameVo = import("view.miniGame.gameView.SailBoatGame.SailBoatGameVo")

function SailBoatGameView:getUIName()
	return SailBoatGameVo.game_ui
end

function SailBoatGameView:getBGM()
	return SailBoatGameVo.menu_bgm
end

function SailBoatGameView:didEnter()
	self:initData()
	self:initEvent()
	self:initUI()

	return
end

function SailBoatGameView:initData()
	SailBoatGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)
	SailBoatGameVo.SetGameTpl(findTF(self._tf, "tpl"))

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / ((SailBoatGameVo.frameRate > 60 or nil) and 60), -1)

	return
end

function SailBoatGameView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(SailBoatGameView.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			self:resumeGame()
			self:onGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SailBoatGameView.USE_SKILL, function(arg_8_0, arg_8_1, arg_8_2)
		self.gameScene:useSkill()

		return
	end)
	self:bind(SailBoatGameView.COUNT_DOWN, function(arg_9_0, arg_9_1, arg_9_2)
		self:gameStart()

		return
	end)
	self:bind(SailBoatGameView.OPEN_EQUIP_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.equipUI:show(true)
		self.menuUI:show(false)

		return
	end)
	self:bind(SailBoatGameView.OPEN_PAUSE_UI, function(arg_11_0, arg_11_1, arg_11_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(SailBoatGameView.OPEN_LEVEL_UI, function(arg_12_0, arg_12_1, arg_12_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(SailBoatGameView.PAUSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SailBoatGameView.BACK_MENU, function(arg_14_0, arg_14_1, arg_14_2)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)

		local var_14_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

		if self.bgm ~= var_14_0 then
			self.bgm = var_14_0

			pg.BgmMgr.GetInstance():Push(self.__cname, var_14_0)
		end

		self:initBgAnimation()

		return
	end)
	self:bind(SailBoatGameView.CLOSE_GAME, function(arg_15_0, arg_15_1, arg_15_2)
		self:closeView()

		return
	end)
	self:bind(SailBoatGameView.GAME_OVER, function(arg_16_0, arg_16_1, arg_16_2)
		self:onGameOver()

		return
	end)
	self:bind(SailBoatGameView.SHOW_RULE, function(arg_17_0, arg_17_1, arg_17_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[SailBoatGameVo.rule_tip].tip
		})

		return
	end)
	self:bind(SailBoatGameView.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		self:readyStart()

		return
	end)
	self:bind(SailBoatGameView.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		self:StoreDataToServer({
			arg_19_1
		})

		return
	end)
	self:bind(SailBoatGameView.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(SailBoatGameView.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		self:addScore(arg_21_1.num)
		self.gameUI:addScore(arg_21_1)

		return
	end)
	self:bind(SailBoatGameView.JOYSTICK_ACTIVE_CHANGE, function(arg_22_0, arg_22_1, arg_22_2)
		if self.gameStartFlag then
			self.gameScene:joystickActive(arg_22_1)
		end

		return
	end)

	return
end

function SailBoatGameView:initUI()
	if IsUnityEditor then
		setActive(findTF(self._tf, "tpl"), false)
	end

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = SailBoatGamePopUI.New(self._tf, self)

	self.popUI:clearUI()

	self.gameUI = SailBoatGamingUI.New(self._tf, self)

	self.gameUI:show(false)

	self.menuUI = SailBoatGameMenuUI.New(self._tf, self)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	self.equipUI = SailBoatEquipUI.New(self._tf, self)

	self.equipUI:show(false)

	self.gameScene = SailBoatGameScene.New(self._tf, self)

	self:initBgAnimation()

	return
end

function SailBoatGameView:initBgAnimation()
	local var_24_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.BOAT_QIAN_SHAO_ZHAN)
	local var_24_1 = getProxy(TaskProxy)
	local var_24_2 = var_24_0:getConfig("config_data")
	local var_24_3 = var_24_0.data3

	if var_24_1:getFinishTaskById(var_24_2[var_24_0.data3][1]) ~= nil and var_24_1:getFinishTaskById(var_24_2[var_24_3][2]) ~= nil then
		var_24_3 = var_24_3 + 1
	end

	GetComponent(findTF(self._tf, "sceneBg/1"), typeof(Animator)):Play(({
		"Phase_00",
		"Phase_01",
		"Phase_02",
		"Phase_03",
		"Phase_04",
		"Phase_05",
		"Phase_06",
		"Phase_07"
	})[var_24_3])

	return
end

function SailBoatGameView:Update()
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

function SailBoatGameView:readyStart()
	self.readyStartFlag = true

	SailBoatGameVo.Prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)
	self.equipUI:show(false)
	setActive(findTF(self._tf, "sceneBg"), false)

	return
end

function SailBoatGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:popCountUI(false)
	self.gameUI:start()
	self.gameUI:show(true)

	if self.bgm ~= SailBoatGameVo.game_bgm then
		self.bgm = SailBoatGameVo.game_bgm

		pg.BgmMgr.GetInstance():Push(self.__cname, SailBoatGameVo.game_bgm)
	end

	self.gameScene:start()
	self:timerStart()

	return
end

function SailBoatGameView:changeSpeed(arg_28_1)
	return
end

function SailBoatGameView:onTimer()
	self:gameStep()

	return
end

function SailBoatGameView:gameStep()
	self:stepRunTimeData()
	self.gameScene:step(SailBoatGameVo.deltaTime)
	self.gameUI:step(SailBoatGameVo.deltaTime)

	if SailBoatGameVo.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function SailBoatGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function SailBoatGameView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	self.gameScene:resume()

	return
end

function SailBoatGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	self.gameScene:stop()

	return
end

function SailBoatGameView:stepRunTimeData()
	local var_34_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_34_0 = 0.016
	end

	SailBoatGameVo.gameTime = SailBoatGameVo.gameTime - var_34_0
	SailBoatGameVo.gameStepTime = SailBoatGameVo.gameStepTime + var_34_0
	SailBoatGameVo.deltaTime = var_34_0

	local var_34_1 = SailBoatGameVo.GetSceneSpeed()

	var_34_1.x = SailBoatGameVo.moveAmount.x * var_34_0
	var_34_1.y = SailBoatGameVo.moveAmount.y * var_34_0

	SailBoatGameVo.SetSceneSpeed(var_34_1)

	return
end

function SailBoatGameView:addScore(arg_35_1)
	SailBoatGameVo.scoreNum = SailBoatGameVo.scoreNum + arg_35_1

	return
end

function SailBoatGameView:onGameOver()
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

function SailBoatGameView:OnApplicationPaused()
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

function SailBoatGameView:clearController()
	self.gameScene:clear()

	return
end

function SailBoatGameView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function SailBoatGameView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function SailBoatGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:emit(SailBoatGameView.ON_BACK_PRESSED)

		return
	else
		if self.settlementFlag then
			return
		end

		self.popUI:backPressed()
	end

	return
end

function SailBoatGameView:OnSendMiniGameOPDone(arg_43_1)
	return
end

function SailBoatGameView:willExit()
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

	SailBoatGameVo.Clear()

	return
end

return SailBoatGameView
