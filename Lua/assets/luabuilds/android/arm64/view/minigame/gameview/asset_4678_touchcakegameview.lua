local TouchCakeGameView = class("TouchCakeGameView", import("..BaseMiniGameView"))
local TouchCakeGameVo = import("view.miniGame.gameView.TouchCakeGame.TouchCakeGameVo")
local TouchCakeGameConst = import("view.miniGame.gameView.TouchCakeGame.TouchCakeGameConst")
local TouchCakeGameEvent = import("view.miniGame.gameView.TouchCakeGame.TouchCakeGameEvent")

function TouchCakeGameView:getUIName()
	return TouchCakeGameVo.game_ui
end

function TouchCakeGameView:getBGM()
	return TouchCakeGameVo.menu_bgm
end

function TouchCakeGameView:didEnter()
	self:initData()
	self:initEvent()
	self:initUI()

	return
end

function TouchCakeGameView:initData()
	TouchCakeGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)
	TouchCakeGameVo.SetGameTpl(findTF(self._tf, "tpl"))

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / ((TouchCakeGameVo.frameRate > 60 or nil) and 60), -1)

	return
end

function TouchCakeGameView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.UpdateBeat, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(TouchCakeGameEvent.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			self:resumeGame()
			self:onGameOver()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(TouchCakeGameEvent.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		self:gameStart()

		return
	end)
	self:bind(TouchCakeGameEvent.ON_HOME, function(arg_9_0, arg_9_1, arg_9_2)
		self:emit(BaseUI.ON_HOME)

		return
	end)
	self:bind(TouchCakeGameEvent.OPEN_PAUSE_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(TouchCakeGameEvent.OPEN_LEVEL_UI, function(arg_11_0, arg_11_1, arg_11_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(TouchCakeGameEvent.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(TouchCakeGameEvent.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		self.gameStop = false

		self.gameScene:resume()
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)
		self:changeBgm(TouchCakeGameConst.bgm_type_default)

		return
	end)
	self:bind(TouchCakeGameEvent.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		self:closeView()

		return
	end)
	self:bind(TouchCakeGameEvent.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		self:onGameOver()

		return
	end)
	self:bind(TouchCakeGameEvent.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[TouchCakeGameVo.rule_tip].tip
		})

		return
	end)
	self:bind(TouchCakeGameEvent.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		self:getRankData()
		self.popUI:showRank(true)

		return
	end)
	self:bind(TouchCakeGameEvent.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		self:readyStart()

		return
	end)
	self:bind(TouchCakeGameEvent.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy(MiniGameProxy):UpdataHighScore(TouchCakeGameVo.game_id, arg_19_1)

		return
	end)
	self:bind(TouchCakeGameEvent.PRESS_DIRECT, function(arg_20_0, arg_20_1, arg_20_2)
		if self.gameScene then
			self.gameScene:touchDirect(arg_20_1, true)
		end

		return
	end)
	self:bind(TouchCakeGameEvent.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(TouchCakeGameEvent.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		self:addScore(arg_22_1)
		self.gameUI:updateScore()

		return
	end)
	self:bind(TouchCakeGameEvent.ADD_COMBO, function(arg_23_0, arg_23_1, arg_23_2)
		self:addCombo()
		self.gameUI:updateCombo()

		return
	end)
	self:bind(TouchCakeGameEvent.PLAYER_DIZZI, function(arg_24_0, arg_24_1, arg_24_2)
		self:clearCombo()
		self.gameUI:updateCombo()

		return
	end)
	self:bind(TouchCakeGameEvent.PLAYER_BOOM, function(arg_25_0, arg_25_1, arg_25_2)
		self:clearCombo()
		self.gameUI:updateCombo()

		return
	end)

	return
end

function TouchCakeGameView:initUI()
	if IsUnityEditor then
		setActive(findTF(self._tf, "tpl"), false)
	end

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = TouchCakePopUI.New(self._tf, self)

	self.popUI:clearUI()

	self.gameUI = TouchCakeGamingUI.New(self._tf, self)

	self.gameUI:show(false)

	self.menuUI = TouchCakeMenuUI.New(self._tf, self)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	self.gameScene = TouchCakeScene.New(self._tf, self)

	return
end

function TouchCakeGameView:changeBgm(arg_27_1)
	local var_27_0

	if arg_27_1 == TouchCakeGameConst.bgm_type_default then
		var_27_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_27_1 == TouchCakeGameConst.bgm_type_menu then
		var_27_0 = TouchCakeGameVo.menu_bgm
	elseif arg_27_1 == TouchCakeGameConst.bgm_type_game then
		var_27_0 = TouchCakeGameVo.game_bgm
	end

	if self.bgm ~= var_27_0 then
		self.bgm = var_27_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_27_0)
	end

	return
end

function TouchCakeGameView:UpdateBeat()
	if self.gameStop or self.settlementFlag or not self.gameStartFlag then
		return
	end

	if Input.GetKeyDown(KeyCode.A) then
		self.gameScene:press(KeyCode.A, true)
	elseif Input.GetKeyDown(KeyCode.D) then
		self.gameScene:press(KeyCode.D, true)
	end

	return
end

function TouchCakeGameView:readyStart()
	self.readyStartFlag = true

	TouchCakeGameVo.Prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)

	return
end

function TouchCakeGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:popCountUI(false)
	self.gameUI:start()
	self.gameUI:show(true)
	self.gameScene:start()
	self:timerStart()
	self:changeBgm(TouchCakeGameConst.bgm_type_game)

	return
end

function TouchCakeGameView:onTimer()
	self:gameStep()

	return
end

function TouchCakeGameView:gameStep()
	self:stepRunTimeData()
	self.gameScene:step(TouchCakeGameVo.deltaTime)
	self.gameUI:step(TouchCakeGameVo.deltaTime)

	if TouchCakeGameVo.gameTime <= 0 then
		TouchCakeGameVo.gameTime = 0

		self:onGameOver()
	end

	return
end

function TouchCakeGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function TouchCakeGameView:timerResume()
	if not self.timer.running then
		self.timer:Start()
	end

	self.gameScene:resume()

	return
end

function TouchCakeGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function TouchCakeGameView:stepRunTimeData()
	TouchCakeGameVo.gameTime = TouchCakeGameVo.gameTime - Time.deltaTime
	TouchCakeGameVo.gameStepTime = TouchCakeGameVo.gameStepTime + Time.deltaTime
	TouchCakeGameVo.deltaTime = Time.deltaTime

	return
end

function TouchCakeGameView:addScore(arg_37_1)
	TouchCakeGameVo.scoreNum = TouchCakeGameVo.scoreNum + arg_37_1

	return
end

function TouchCakeGameView:addCombo()
	TouchCakeGameVo.comboNum = TouchCakeGameVo.comboNum + 1

	return
end

function TouchCakeGameView:clearCombo()
	TouchCakeGameVo.comboNum = 0

	return
end

function TouchCakeGameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:pauseGame()
	self:clearController()

	self.settlementFlag = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self.popUI:updateSettlementUI()
		self.popUI:popSettlementUI(true)
		self:OnApplicationPaused()

		return
	end))

	return
end

function TouchCakeGameView:OnApplicationPaused()
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

function TouchCakeGameView:clearController()
	self.gameScene:clear()

	return
end

function TouchCakeGameView:pauseGame()
	self.gameStop = true

	self.gameScene:stop()
	self:timerStop()

	return
end

function TouchCakeGameView:resumeGame()
	self.gameStop = false

	self.gameScene:resume()
	self:timerStart()

	return
end

function TouchCakeGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		self:closeView()

		return
	else
		if self.settlementFlag then
			return
		end

		self.popUI:backPressed()
	end

	return
end

function TouchCakeGameView:OnSendMiniGameOPDone(arg_47_1)
	return
end

function TouchCakeGameView:getRankData()
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = TouchCakeGameVo.game_id,
		callback = function(self)
			local var_49_0 = {}

			for iter_49_0 = 1, #self do
				local var_49_1 = {}

				for iter_49_1, iter_49_2 in pairs(self[iter_49_0]) do
					var_49_1[iter_49_1] = iter_49_2
				end

				table.insert(var_49_0, var_49_1)
			end

			table.sort(var_49_0, function(arg_50_0, arg_50_1)
				if arg_50_0.score ~= arg_50_1.score then
					return arg_50_0.score > arg_50_1.score
				elseif arg_50_0.time_data ~= arg_50_1.time_data then
					return arg_50_0.time_data > arg_50_1.time_data
				else
					return arg_50_0.player_id < arg_50_1.player_id
				end

				return
			end)
			self.popUI:updateRankData(var_49_0)

			return
		end
	})

	return
end

function TouchCakeGameView:willExit()
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

	if self.gameUI then
		self.gameUI:dispose()
	end

	TouchCakeGameVo.Clear()

	return
end

return TouchCakeGameView
