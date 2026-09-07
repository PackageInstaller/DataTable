local MusicBeatGameView = class("MusicBeatGameView", import("..BaseMiniGameView"))

function MusicBeatGameView:Ctor()
	MusicBeatGameView.super.Ctor(self)

	self._gameVo = MusicBeatGameVo.New(MusicBeatGameConst.mini_game_id)

	return
end

function MusicBeatGameView:getUIName()
	return MusicBeatGameConst.game_ui
end

function MusicBeatGameView:getBGM()
	return MusicBeatGameConst.menu_bgm
end

function MusicBeatGameView:didEnter()
	self:initEvent()
	self:initUI()

	if self.contextData.rank then
		self.menuUI:showRankUI()
	end

	return
end

function MusicBeatGameView:initEvent()
	if not self.handle then
		self.handle = FixedUpdateBeat:CreateListener(self.OnUpdate, self)

		FixedUpdateBeat:AddListener(self.handle)
	end

	self:bind(MusicBeatGameEvent.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			self:onGameOver(false)
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(MusicBeatGameEvent.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		self:gameStart()

		return
	end)
	self:bind(MusicBeatGameEvent.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		self:emit(BaseUI.ON_HOME)

		return
	end)
	self:bind(MusicBeatGameEvent.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(MusicBeatGameEvent.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(MusicBeatGameEvent.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(MusicBeatGameEvent.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)
		self:changeBgm(MusicBeatGameConst.bgm_type_menu)
		pg.BgmMgr.GetInstance():ContinuePlay()
		self:clearGame()

		return
	end)
	self:bind(MusicBeatGameEvent.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		self:closeView()

		return
	end)
	self:bind(MusicBeatGameEvent.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		self:onGameOver(arg_14_1)

		return
	end)
	self:bind(MusicBeatGameEvent.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[MusicBeatGameConst.rule_tip].tip
		})

		return
	end)
	self:bind(MusicBeatGameEvent.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		self:getRankData()
		self.popUI:showRank(true)

		return
	end)
	self:bind(MusicBeatGameEvent.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		self:readyStart()

		return
	end)
	self:bind(MusicBeatGameEvent.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		getProxy(MiniGameProxy):UpdataHighScore(self._gameVo.gameId, arg_18_1)

		return
	end)
	self:bind(MusicBeatGameEvent.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(MusicBeatGameEvent.ADD_SCORE, function(arg_20_0, arg_20_1, arg_20_2)
		self:addScore(arg_20_1.num)
		self.gameUI:addScore(arg_20_1)

		return
	end)

	return
end

function MusicBeatGameView:initUI()
	self._gameVo:setGameTpl(findTF(self._tf, "tpl"))
	setActive(findTF(self._tf, "tpl"), false)

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = MusicBeatGamePopUI.New(self._tf, self, self._gameVo)

	self.popUI:clearUI()

	self.gameUI = MusicBeatGamingUI.New(self._tf, self, self._gameVo)

	self.gameUI:show(false)

	self.menuUI = MusicBeatGameMenuUI.New(self._tf, self, self._gameVo)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	self.gameScene = MusicBeatGameScene.New(self._tf, self, self._gameVo)

	return
end

function MusicBeatGameView:changeBgm(arg_22_1)
	local var_22_0

	if arg_22_1 == MusicBeatGameConst.bgm_type_default then
		var_22_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_22_1 == MusicBeatGameConst.bgm_type_menu then
		var_22_0 = MusicBeatGameConst.menu_bgm
	elseif arg_22_1 == MusicBeatGameConst.bgm_type_game then
		var_22_0 = MusicBeatGameConst.game_bgm
	elseif arg_22_1 == MusicBeatGameConst.bgm_type_intro then
		var_22_0 = MusicBeatGameConst.intro_bgm
	end

	pg.BgmMgr.GetInstance():Push(self.__cname, var_22_0)

	return
end

function MusicBeatGameView:OnUpdate()
	self:gameStep()

	return
end

function MusicBeatGameView:readyStart()
	pg.BgmMgr.GetInstance():StopPlay()

	self.readyStartFlag = true

	self._gameVo:prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)
	self.gameScene:readyStart()

	return
end

function MusicBeatGameView:gameStart()
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

function MusicBeatGameView:gameStep()
	if self.gameStartFlag and not self.gameStop then
		self:stepRunTimeData()
		self.gameUI:step(self._gameVo.deltaTime)
		self.gameScene:step(self._gameVo.deltaTime)
		Physics2D.Simulate(self._gameVo.deltaTime)
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self:emit(MusicBeatGameEvent.KEY_CODE_DOWN, KeyCode.A)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self:emit(MusicBeatGameEvent.KEY_CODE_DOWN, KeyCode.D)
		end
	end

	return
end

function MusicBeatGameView:timerStart()
	self.gameStop = false

	return
end

function MusicBeatGameView:timerResume()
	self.gameStop = false

	self.gameScene:resume()

	return
end

function MusicBeatGameView:timerStop()
	self.gameStop = true

	self.gameScene:stop()

	return
end

function MusicBeatGameView:getRankData()
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = self._gameVo.gameId,
		callback = function(self)
			local var_31_0 = {}

			for iter_31_0 = 1, #self do
				local var_31_1 = {}

				for iter_31_1, iter_31_2 in pairs(self[iter_31_0]) do
					var_31_1[iter_31_1] = iter_31_2
				end

				table.insert(var_31_0, var_31_1)
			end

			table.sort(var_31_0, function(arg_32_0, arg_32_1)
				if arg_32_0.score ~= arg_32_1.score then
					return arg_32_0.score > arg_32_1.score
				elseif arg_32_0.time_data ~= arg_32_1.time_data then
					return arg_32_0.time_data > arg_32_1.time_data
				else
					return arg_32_0.player_id < arg_32_1.player_id
				end

				return
			end)
			self.popUI:updateRankData(var_31_0)

			return
		end
	})

	return
end

function MusicBeatGameView:stepRunTimeData()
	self._gameVo.gameTime = self._gameVo.gameTime - Time.fixedDeltaTime
	self._gameVo.gameStepTime = self._gameVo.gameStepTime + Time.fixedDeltaTime
	self._gameVo.deltaTime = Time.fixedDeltaTime

	return
end

function MusicBeatGameView:addScore(arg_34_1)
	self._gameVo.scoreNum = self._gameVo.scoreNum + arg_34_1

	return
end

function MusicBeatGameView:onGameOver(arg_35_1)
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
	self:emit(BaseMiniGameMediator.GAME_FINISH_TRACKING, {
		game_id = self._gameVo.gameId,
		hub_id = self._gameVo.hubId,
		isComplete = arg_35_1 and 1 or 0
	})

	return
end

function MusicBeatGameView:OnApplicationPaused()
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

function MusicBeatGameView:clearController()
	self.gameScene:clear()

	return
end

function MusicBeatGameView:pauseGame()
	self.gameStop = true

	self:timerStop()

	return
end

function MusicBeatGameView:resumeGame()
	self.gameStop = false

	self:timerStart()
	self:timerResume()

	return
end

function MusicBeatGameView:clearGame()
	self.gameStop = true

	return
end

function MusicBeatGameView:onBackPressed()
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

function MusicBeatGameView:OnSendMiniGameOPDone(arg_43_1)
	return
end

function MusicBeatGameView:willExit()
	if self.handle then
		FixedUpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	Time.timeScale = 1

	self._gameVo:clear()

	return
end

return MusicBeatGameView
