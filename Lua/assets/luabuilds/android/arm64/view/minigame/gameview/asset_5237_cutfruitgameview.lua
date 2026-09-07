local CutFruitGameView = class("CutFruitGameView", import("..BaseMiniGameView"))

CutFruitGameView.EVENT_DIRECT = "CutFruitGameView:EVENT_DIRECT"

local var_0_1 = 83

function CutFruitGameView:Ctor()
	CutFruitGameView.super.Ctor(self)

	self._gameVo = CutFruitGameVo.New(var_0_1)

	return
end

function CutFruitGameView:getUIName()
	return CutFruitGameConst.game_ui
end

function CutFruitGameView:getBGM()
	return CutFruitGameConst.menu_bgm
end

function CutFruitGameView:didEnter()
	self:initEvent()
	self:initUI()

	return
end

function CutFruitGameView:initEvent()
	if not self.handle then
		self.handle = UpdateBeat:CreateListener(self.OnUpdate, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(SimpleMGEvent.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			self:resumeGame()
			self:onGameOver(false)
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SimpleMGEvent.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		self:gameStart()

		return
	end)
	self:bind(SimpleMGEvent.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		self:emit(BaseUI.ON_HOME)

		return
	end)
	self:bind(SimpleMGEvent.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		self.popUI:PopPauseUI()

		return
	end)
	self:bind(SimpleMGEvent.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		self.popUI:PopLeaveUI()

		return
	end)
	self:bind(SimpleMGEvent.STOP_TIME_STEP, function(arg_11_0, arg_11_1, arg_11_2)
		self._gameVo:StopTimeStep(arg_11_1)

		return
	end)
	self:bind(SimpleMGEvent.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SimpleMGEvent.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 and arg_13_1.restart then
			self:readyStart(arg_13_1)
		else
			self.menuUI:Update(self:GetMGHubData())
			self.menuUI:Show(true)
			self.gameUI:Show(false)
			self.popUI:PopSelectUI(true)
			self.gameScene:ShowContainer(false)
			self:changeBgm(CutFruitGameConst.bgm_type_default)
		end

		return
	end)
	self:bind(SimpleMGEvent.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		self:closeView()

		return
	end)
	self:bind(SimpleMGEvent.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		self:onGameOver(arg_15_1)

		return
	end)
	self:bind(SimpleMGEvent.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[CutFruitGameConst.rule_tip].tip
		})

		return
	end)
	self:bind(SimpleMGEvent.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		self:getRankData(self._gameVo:GetGameId(), function(arg_18_0)
			self.popUI:UpdateRankData(arg_18_0)

			return
		end)
		self.popUI:PopRankUI(true)

		return
	end)
	self:bind(SimpleMGEvent.READY_START, function(arg_19_0, arg_19_1, arg_19_2)
		self:readyStart(arg_19_1)

		return
	end)
	self:bind(SimpleMGEvent.STORE_SERVER, function(arg_20_0, arg_20_1, arg_20_2)
		getProxy(MiniGameProxy):UpdataHighScore(self._gameVo:GetGameId(), arg_20_1)

		return
	end)
	self:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(SimpleMGEvent.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		self:addScore(arg_22_1.num)

		return
	end)

	return
end

function CutFruitGameView:initUI()
	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = CutFruitGamePopUI.New(self._tf, self, self._gameVo)

	self.popUI:ClearUI()

	self.gameUI = CutFruitGamingUI.New(self._tf, self, self._gameVo)

	self.gameUI:Show(false)

	self.menuUI = CutFruitGameMenuUI.New(self._tf, self, self._gameVo)

	self.menuUI:Update()
	self.menuUI:Show(true)
	self.popUI:PopSelectUI(true)

	self.gameScene = CutFruitGameScene.New(self._tf, self, self._gameVo)

	return
end

function CutFruitGameView:changeBgm(arg_24_1)
	local var_24_0

	if arg_24_1 == CutFruitGameConst.bgm_type_default then
		var_24_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_24_1 == CutFruitGameConst.bgm_type_menu then
		var_24_0 = CutFruitGameConst.menu_bgm
	elseif arg_24_1 == CutFruitGameConst.bgm_type_game then
		var_24_0 = CutFruitGameConst.game_bgm
	end

	if self.bgm ~= var_24_0 then
		self.bgm = var_24_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_24_0)
	end

	return
end

function CutFruitGameView:OnUpdate()
	self:gameStep()

	return
end

function CutFruitGameView:readyStart(arg_26_1)
	self.readyStartFlag = true

	self._gameVo:Prepare()
	self.popUI:ReadyStart()
	self.menuUI:Show(false)
	self.gameUI:Show(false)
	self.gameScene:Prepare(arg_26_1)

	return
end

function CutFruitGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:PopCountUI(false)
	self.gameUI:Start()
	self.gameUI:Show(true)
	self.gameScene:Start()
	self:timerStart()
	self:changeBgm(CutFruitGameConst.bgm_type_game)

	return
end

function CutFruitGameView:gameStep()
	if self.gameStartFlag and not self.gameStop and not self.settlementFlag then
		self:stepRunTimeData()
		self.gameUI:Step()
		self.gameScene:Step()

		if self._gameVo:GetTime() <= 0 then
			self:onGameOver(false)
		end
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_LEFT)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_RIGHT)
		end

		if Input.GetKeyDown(KeyCode.W) then
			self:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_UP)
		end

		if Input.GetKeyDown(KeyCode.S) then
			self:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_DOWN)
		end
	end

	return
end

function CutFruitGameView:timerStart()
	self.gamestop = false

	return
end

function CutFruitGameView:timerResume()
	self.gamestop = false

	self.gameScene:Resume()

	return
end

function CutFruitGameView:timerStop()
	self.gamestop = true

	self.gameScene:Stop()

	return
end

function CutFruitGameView:getRankData(arg_32_1, arg_32_2)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = arg_32_1,
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

			if arg_32_2 then
				arg_32_2(var_33_0)
			end

			return
		end
	})

	return
end

function CutFruitGameView:stepRunTimeData()
	self._gameVo:Step(Time.deltaTime)

	return
end

function CutFruitGameView:addScore(arg_36_1)
	self._gameVo:AddScore(arg_36_1)

	return
end

function CutFruitGameView:onGameOver(arg_37_1)
	if self.settlementFlag then
		return
	end

	self:timerStop()
	self._gameVo:SetSuccess(arg_37_1 and true or false)
	self._gameVo:SetSettlement(true)
	self.gameScene:GameOver()

	self.settlementFlag = true
	self.gameStartFlag = false

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 1, System.Action(function()
		self.settlementFlag = false

		self:clearController()
		self._gameVo:SetSettlement(false)
		setActive(self.clickMask, false)
		self.popUI:UpdateSettlementUI()
		self.popUI:PopSettlementUI(true)

		return
	end))

	return
end

function CutFruitGameView:OnApplicationPaused()
	if not self.gameStartFlag then
		return
	end

	if self.readyStartFlag then
		return
	end

	if self.settlementFlag then
		return
	end

	return
end

function CutFruitGameView:clearController()
	self.gameScene:Clear()

	return
end

function CutFruitGameView:pauseGame()
	self.gameStop = true

	self:timerStop()

	return
end

function CutFruitGameView:resumeGame()
	self.gameStop = false

	self:timerStart()

	return
end

function CutFruitGameView:onBackPressed()
	if not self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self:closeView()
	end

	return
end

function CutFruitGameView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	Time.timeScale = 1

	if self._gameVo then
		self._gameVo:Clear()

		self._gameVo = nil
	end

	return
end

return CutFruitGameView
