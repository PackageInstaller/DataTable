local SortGameView = class("SortGameView", import("..BaseMiniGameView"))
local var_0_1 = 84

SortGameView.WANTED_ITEM_REFRESH = "SortGameView:wanted item refresh"
SortGameView.UPDATE_PLAYER = "SortGameView:update player"
SortGameView.PLAYER_SPEAK = "SortGameView:player speak"
SortGameView.GAME_OVER_TIME = "SortGameView:game over time"

function SortGameView:Ctor()
	SortGameView.super.Ctor(self)

	self._gameVo = SortGameVo.New(var_0_1)

	return
end

function SortGameView:getUIName()
	return SortGameConst.game_ui
end

function SortGameView:getBGM()
	return SortGameConst.menu_bgm
end

function SortGameView:didEnter()
	self:initEvent()
	self:initUI()
	self:readyStart()

	return
end

function SortGameView:initEvent()
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
		self.gameScene:ShowContainer(false)
		self:changeBgm(SortGameConst.menu_bgm)
		self:closeView()

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
			helps = pg.gametip[SortGameConst.rule_tip].tip
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
		self._gameVo:AddScore(arg_21_1.num)
		self.gameUI:AddScore(arg_21_1)

		return
	end)
	self:bind(SortGameView.WANTED_ITEM_REFRESH, function(arg_22_0, arg_22_1, arg_22_2)
		self.gameUI:RefreshWantedItem(arg_22_1.item_id, arg_22_1.player_prefab)

		return
	end)
	self:bind(SortGameView.UPDATE_PLAYER, function(arg_23_0, arg_23_1, arg_23_2)
		self.gameUI:UpdatePlayer(arg_23_1)

		return
	end)
	self:bind(SortGameView.PLAYER_SPEAK, function(arg_24_0, arg_24_1, arg_24_2)
		self.gameUI:SetPlayerSpeak(arg_24_1)

		return
	end)
	self:bind(SortGameView.GAME_OVER_TIME, function(arg_25_0, arg_25_1, arg_25_2)
		self.gameStop = true

		self.gameUI:StepTimeToScore()

		return
	end)

	return
end

function SortGameView:initUI()
	self.clickMask = findTF(self._tf, "clickMask")
	self.popUI = SortGamePopUI.New(self._tf, self, self._gameVo)

	self.popUI:ClearUI()

	self.gameUI = SortGamingUI.New(self._tf, self, self._gameVo)

	self.gameUI:Show(false)

	self.menuUI = SortGameMenuUI.New(self._tf, self, self._gameVo)

	self.menuUI:Update()
	self.menuUI:Show(true)

	self.gameScene = SortGameScene.New(self._tf, self, self._gameVo)

	return
end

function SortGameView:changeBgm(arg_27_1)
	local var_27_0

	if not arg_27_1 then
		var_27_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_27_1 == SortGameConst.menu_bgm then
		var_27_0 = SortGameConst.menu_bgm
	elseif arg_27_1 == SortGameConst.game_bgm then
		var_27_0 = SortGameConst.game_bgm
	end

	if self.bgm ~= var_27_0 then
		self.bgm = var_27_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_27_0)
	end

	return
end

function SortGameView:OnUpdate()
	self:gameStep()

	return
end

function SortGameView:readyStart(arg_29_1)
	self.readyStartFlag = true

	self._gameVo:Prepare()
	self.popUI:ReadyStart()
	self.menuUI:Show(false)
	self.gameUI:Show(false)
	self.gameScene:Prepare()

	return
end

function SortGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	self.popUI:PopCountUI(false)
	self.gameUI:Start()
	self.gameUI:Show(true)
	self.gameScene:Start()
	self:timerStart()
	self:changeBgm(SortGameConst.game_bgm)

	return
end

function SortGameView:gameStep()
	if self.gameStartFlag and not self.gameStop and not self.settlementFlag then
		self:stepRunTimeData()
		self.gameUI:Step(self._gameVo:GetDeltaTime())
		self.gameScene:Step()

		if self._gameVo:GetTime() <= 0 then
			self:onGameOver()
		end
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function SortGameView:timerStart()
	self.gameStop = false

	return
end

function SortGameView:timerResume()
	self.gameStop = false

	self.gameScene:Resume()

	return
end

function SortGameView:timerStop()
	self.gameStop = true

	self.gameScene:Stop()

	return
end

function SortGameView:getRankData(arg_35_1, arg_35_2)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = arg_35_1,
		callback = function(self)
			local var_36_0 = {}

			for iter_36_0 = 1, #self do
				local var_36_1 = {}

				for iter_36_1, iter_36_2 in pairs(self[iter_36_0]) do
					var_36_1[iter_36_1] = iter_36_2
				end

				table.insert(var_36_0, var_36_1)
			end

			table.sort(var_36_0, function(arg_37_0, arg_37_1)
				if arg_37_0.score ~= arg_37_1.score then
					return arg_37_0.score > arg_37_1.score
				elseif arg_37_0.time_data ~= arg_37_1.time_data then
					return arg_37_0.time_data > arg_37_1.time_data
				else
					return arg_37_0.player_id < arg_37_1.player_id
				end

				return
			end)

			if arg_35_2 then
				arg_35_2(var_36_0)
			end

			return
		end
	})

	return
end

function SortGameView:stepRunTimeData()
	self._gameVo:Step(Time.deltaTime)

	return
end

function SortGameView:onGameOver(arg_39_1)
	if self.settlementFlag then
		return
	end

	self:timerStop()
	self._gameVo:SetSettlement(true)

	self.settlementFlag = true
	self.gameStartFlag = false

	setActive(self.clickMask, true)
	self.gameUI:GameOver()
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

function SortGameView:OnApplicationPaused()
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

function SortGameView:clearController()
	self.gameScene:Clear()

	return
end

function SortGameView:pauseGame()
	self:timerStop()

	return
end

function SortGameView:resumeGame()
	self:timerResume()

	return
end

function SortGameView:onBackPressed()
	if self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self.popUI:BackPressed()
	end

	if not self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self:closeView()
	end

	return
end

function SortGameView:willExit()
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

return SortGameView
