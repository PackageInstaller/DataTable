local GameRoomWatermelonView = class("GameRoomWatermelonView", import("..BaseMiniGameView"))
local var_0_1

function GameRoomWatermelonView:Ctor()
	GameRoomWatermelonView.super.Ctor(self)

	return
end

function GameRoomWatermelonView:getUIName()
	return WatermelonGameConst.game_room_ui
end

function GameRoomWatermelonView:getBGM()
	return WatermelonGameConst.menu_bgm
end

function GameRoomWatermelonView:didEnter()
	self._gameVo = WatermelonGameVo.New(self:GetMGData().id)
	var_0_1 = self._gameVo

	self:initEvent()
	self:initUI()

	return
end

function GameRoomWatermelonView:initEvent()
	if not self.handle then
		self.handle = FixedUpdateBeat:CreateListener(self.OnUpdate, self)

		FixedUpdateBeat:AddListener(self.handle)
	end

	self:bind(WatermelonGameEvent.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			self:resumeGame()
			self:onGameOver(false)
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(WatermelonGameEvent.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		self:gameStart()

		return
	end)
	self:bind(WatermelonGameEvent.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		self:emit(BaseUI.ON_HOME)

		return
	end)
	self:bind(WatermelonGameEvent.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		self.popUI:popPauseUI()

		return
	end)
	self:bind(WatermelonGameEvent.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.popUI:popLeaveUI()

		return
	end)
	self:bind(WatermelonGameEvent.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(WatermelonGameEvent.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		self.menuUI:update(self:GetMGHubData())
		self.menuUI:show(true)
		self.gameUI:show(false)
		self.gameScene:showContainer(false)
		self:changeBgm(PipeGameConst.bgm_type_default)
		self:openCoinLayer(true)

		return
	end)
	self:bind(WatermelonGameEvent.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		self:closeView()

		return
	end)
	self:bind(WatermelonGameEvent.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		self:onGameOver(arg_14_1)

		return
	end)
	self:bind(WatermelonGameEvent.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[WatermelonGameConst.rule_tip].tip
		})

		return
	end)
	self:bind(WatermelonGameEvent.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		self:getRankData()
		self.popUI:showRank(true)

		return
	end)
	self:bind(WatermelonGameEvent.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		self:readyStart()

		return
	end)
	self:bind(WatermelonGameEvent.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		self:StoreDataToServer({
			arg_18_1[1]
		})

		return
	end)
	self:bind(WatermelonGameEvent.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(arg_19_1)
		end

		return
	end)
	self:bind(WatermelonGameEvent.ADD_SCORE, function(arg_20_0, arg_20_1, arg_20_2)
		self:addScore(arg_20_1.num)
		self.gameUI:addScore(arg_20_1)

		return
	end)
	self:bind(WatermelonGameEvent.UPDATE_NEXT_BALL, function(arg_21_0, arg_21_1, arg_21_2)
		self.gameUI:updateBallId(arg_21_1)

		return
	end)

	return
end

function GameRoomWatermelonView:initUI()
	var_0_1:setGameTpl(findTF(self._tf, "tpl"))
	setActive(findTF(self._tf, "tpl"), false)

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = WatermelonGamePopUI.New(self._tf, self, self._gameVo)

	self.popUI:clearUI()

	self.gameUI = WatermelonGamingUI.New(self._tf, self, self._gameVo)

	self.gameUI:show(false)

	self.menuUI = WatermelonGameMenuUI.New(self._tf, self, self._gameVo)

	self.menuUI:update(self:GetMGHubData())
	self.menuUI:show(true)

	self.gameScene = WatermelonGameScene.New(self._tf, self, self._gameVo)

	return
end

function GameRoomWatermelonView:changeBgm(arg_23_1)
	local var_23_0

	if arg_23_1 == PipeGameConst.bgm_type_default then
		var_23_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_menu then
		var_23_0 = WatermelonGameConst.menu_bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_game then
		var_23_0 = WatermelonGameConst.game_bgm
	end

	if self.bgm ~= var_23_0 then
		self.bgm = var_23_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_23_0)
	end

	return
end

function GameRoomWatermelonView:OnUpdate()
	self:gameStep()

	return
end

function GameRoomWatermelonView:readyStart()
	self.readyStartFlag = true

	var_0_1:prepare()
	self.popUI:readyStart()
	self.menuUI:show(false)
	self.gameUI:show(false)
	self:openCoinLayer(false)

	return
end

function GameRoomWatermelonView:gameStart()
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

function GameRoomWatermelonView:changeSpeed(arg_27_1)
	return
end

function GameRoomWatermelonView:gameStep()
	if self.gameStartFlag and not self.gameStop then
		self:stepRunTimeData()
		self.gameUI:step(var_0_1.deltaTime)
		self.gameScene:step(var_0_1.deltaTime)
		Physics2D.Simulate(var_0_1.deltaTime)
	end

	if IsUnityEditor then
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
			self.gameUI:press(KeyCode.J, true)
		end
	end

	return
end

function GameRoomWatermelonView:timerStart()
	self.gamestop = false

	return
end

function GameRoomWatermelonView:timerResume()
	self.gamestop = false

	self.gameScene:resume()

	return
end

function GameRoomWatermelonView:timerStop()
	self.gamestop = true

	self.gameScene:stop()

	return
end

function GameRoomWatermelonView:getRankData()
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = var_0_1.gameId,
		callback = function(self)
			local var_33_0 = {}

			for iter_33_0 = 1, #self do
				local var_33_1 = {}

				for iter_33_1, iter_33_2 in pairs(self[iter_33_0]) do
					var_33_1[iter_33_1] = iter_33_2
				end

				table.insert(var_33_0, var_33_1)
			end

			table.sort(var_33_0, function(arg_34_0, arg_34_1)
				if arg_34_0.score ~= arg_34_1.score then
					return arg_34_0.score > arg_34_1.score
				elseif arg_34_0.time_data ~= arg_34_1.time_data then
					return arg_34_0.time_data > arg_34_1.time_data
				else
					return arg_34_0.player_id < arg_34_1.player_id
				end

				return
			end)
			self.popUI:updateRankData(var_33_0)

			return
		end
	})

	return
end

function GameRoomWatermelonView:stepRunTimeData()
	var_0_1.gameTime = var_0_1.gameTime - Time.fixedDeltaTime
	var_0_1.gameStepTime = var_0_1.gameStepTime + Time.fixedDeltaTime
	var_0_1.deltaTime = Time.fixedDeltaTime

	return
end

function GameRoomWatermelonView:addScore(arg_36_1)
	var_0_1.scoreNum = var_0_1.scoreNum + arg_36_1

	return
end

function GameRoomWatermelonView:onGameOver(arg_37_1)
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

function GameRoomWatermelonView:OnApplicationPaused()
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

function GameRoomWatermelonView:clearController()
	self.gameScene:clear()

	return
end

function GameRoomWatermelonView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function GameRoomWatermelonView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function GameRoomWatermelonView:onBackPressed()
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

function GameRoomWatermelonView:OnSendMiniGameOPDone(arg_44_1)
	return
end

function GameRoomWatermelonView:willExit()
	if self.handle then
		FixedUpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	Time.timeScale = 1

	var_0_1:clear()

	return
end

return GameRoomWatermelonView
