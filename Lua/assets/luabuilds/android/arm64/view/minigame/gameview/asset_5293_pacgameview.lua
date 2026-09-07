local PacGameView = class("PacGameView", import("..BaseMiniGameView"))
local var_0_1 = 81

function PacGameView:Ctor()
	PacGameView.super.Ctor(self)

	self._gameVo = PacGameVo.New(var_0_1)

	return
end

function PacGameView:getUIName()
	return PacGameConst.game_ui
end

function PacGameView:getBGM()
	return PacGameConst.menu_bgm
end

function PacGameView:didEnter()
	self:initEvent()
	self:initUI()

	return
end

function PacGameView:initEvent()
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
	self:bind(SimpleMGEvent.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			self:pauseGame()
		else
			self:resumeGame()
		end

		return
	end)
	self:bind(SimpleMGEvent.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		self.menuUI:Update(self:GetMGHubData())
		self.menuUI:Show(true)
		self.gameUI:Show(false)
		self.gameScene:ShowContainer(false)
		self:changeBgm(PipeGameConst.bgm_type_default)

		return
	end)
	self:bind(SimpleMGEvent.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		self:closeView()

		return
	end)
	self:bind(SimpleMGEvent.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		self:onGameOver(arg_14_1)

		return
	end)
	self:bind(SimpleMGEvent.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[PacGameConst.rule_tip].tip
		})

		return
	end)
	self:bind(SimpleMGEvent.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		self:getRankData(self._gameVo:GetGameId(), function(arg_17_0)
			self.popUI:UpdateRankData(arg_17_0)

			return
		end)
		self.popUI:PopRankUI(true)

		return
	end)
	self:bind(SimpleMGEvent.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = not not (arg_18_1 and arg_18_1.editor)

		print("editor flag = " .. tostring(arg_18_1 and arg_18_1.editor and true or false))
		self._gameVo:SetEditor(var_18_0)
		self:readyStart(arg_18_1)

		return
	end)
	self:bind(SimpleMGEvent.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy(MiniGameProxy):UpdataHighScore(self._gameVo:GetGameId(), arg_19_1)

		return
	end)
	self:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end)
	self:bind(SimpleMGEvent.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		self:addScore(arg_21_1.num)

		return
	end)

	return
end

function PacGameView:initUI()
	setActive(findTF(self._tf, "tpl"), false)

	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = PacGamePopUI.New(self._tf, self, self._gameVo)

	self.popUI:ClearUI()

	self.gameUI = PacGamingUI.New(self._tf, self, self._gameVo)

	self.gameUI:Show(false)

	self.menuUI = PacGameMenuUI.New(self._tf, self, self._gameVo)

	self.menuUI:Update()
	self.menuUI:Show(true)

	self.gameScene = PacGameScene.New(self._tf, self, self._gameVo)

	return
end

function PacGameView:changeBgm(arg_23_1)
	local var_23_0

	if arg_23_1 == PipeGameConst.bgm_type_default then
		var_23_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_menu then
		var_23_0 = PacGameConst.menu_bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_game then
		var_23_0 = PacGameConst.game_bgm
	end

	if self.bgm ~= var_23_0 then
		self.bgm = var_23_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_23_0)
	end

	return
end

function PacGameView:OnUpdate()
	self:gameStep()

	return
end

function PacGameView:readyStart(arg_25_1)
	self.readyStartFlag = true

	self._gameVo:Prepare()
	self.popUI:ReadyStart()
	self.menuUI:Show(false)
	self.gameUI:Show(false)
	self.gameScene:Prepare()

	return
end

function PacGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:PopCountUI(false)
	self.gameUI:Start()
	self.gameUI:Show(true)
	self.gameScene:Start()
	self:timerStart()
	self:changeBgm(PipeGameConst.bgm_type_game)

	return
end

function PacGameView:changeSpeed(arg_27_1)
	return
end

function PacGameView:gameStep()
	if self.gameStartFlag and not self.gameStop and not self.settlementFlag then
		self:stepRunTimeData()
		self.gameUI:Step()
		self.gameScene:Step()

		if self._gameVo:GetTime() <= 0 then
			self:onGameOver()
		end
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			self.gameUI:Press(KeyCode.A, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			self.gameUI:Press(KeyCode.A, false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			self.gameUI:Press(KeyCode.D, true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			self.gameUI:Press(KeyCode.D, false)
		end

		if Input.GetKeyDown(KeyCode.W) then
			self.gameUI:Press(KeyCode.W, true)
		end

		if Input.GetKeyUp(KeyCode.W) then
			self.gameUI:Press(KeyCode.W, false)
		end

		if Input.GetKeyDown(KeyCode.S) then
			self.gameUI:Press(KeyCode.S, true)
		end

		if Input.GetKeyUp(KeyCode.S) then
			self.gameUI:Press(KeyCode.S, false)
		end
	end

	return
end

function PacGameView:timerStart()
	self.gamestop = false

	return
end

function PacGameView:timerResume()
	self.gamestop = false

	self.gameScene:Resume()

	return
end

function PacGameView:timerStop()
	self.gamestop = true

	self.gameScene:Stop()

	return
end

function PacGameView:getRankData(arg_32_1, arg_32_2)
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

function PacGameView:stepRunTimeData()
	self._gameVo:Step(Time.deltaTime)

	return
end

function PacGameView:addScore(arg_36_1)
	self._gameVo:AddScore(arg_36_1)

	return
end

function PacGameView:onGameOver(arg_37_1)
	if self.settlementFlag then
		return
	end

	self:timerStop()
	self._gameVo:SetSettlement(true)

	self.settlementFlag = true
	self.gameStartFlag = false

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
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

function PacGameView:OnApplicationPaused()
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
	self.popUI:PopPauseUI()

	return
end

function PacGameView:clearController()
	self.gameScene:Clear()

	return
end

function PacGameView:pauseGame()
	self.gameStop = true

	self:changeSpeed(0)
	self:timerStop()

	return
end

function PacGameView:resumeGame()
	self.gameStop = false

	self:changeSpeed(1)
	self:timerStart()

	return
end

function PacGameView:onBackPressed()
	if self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self.popUI:BackPressed()
	end

	if not self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self:closeView()
	end

	return
end

function PacGameView:OnSendMiniGameOPDone(arg_44_1)
	return
end

function PacGameView:willExit()
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

return PacGameView
