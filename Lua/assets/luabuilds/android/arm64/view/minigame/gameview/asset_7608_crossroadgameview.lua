local CrossRoadGameView = class("CrossRoadGameView", import("..BaseMiniGameView"))
local var_0_1 = 89

CrossRoadGameView.LEAVEL_GAME = "leavel game"
CrossRoadGameView.OPEN_LEAVEL_UI = "open leave ui"
CrossRoadGameView.SUB_LIFE = "sub life"
CrossRoadGameView.ADD_LIFE = "add life"
CrossRoadGameView.AGAIN = "reGameAgain"

function CrossRoadGameView:Ctor()
	CrossRoadGameView.super.Ctor(self)

	self._gameVo = CrossRoadGameVo.New(var_0_1)

	return
end

function CrossRoadGameView:getUIName()
	return CrossRoadGameConst.game_ui
end

function CrossRoadGameView:getBGM()
	return CrossRoadGameConst.menu_bgm
end

function CrossRoadGameView:didEnter()
	self:initEvent()
	self:initUI()

	return
end

function CrossRoadGameView:initEvent()
	if not self.handle then
		self.handle = UpdateBeat:CreateListener(self.OnUpdate, self)

		UpdateBeat:AddListener(self.handle)
	end

	self:bind(CrossRoadGameView.LEAVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
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
	self:bind(CrossRoadGameView.OPEN_LEAVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
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
	self:bind(SimpleMGEvent.SHOW_RULE, function(arg_14_0, arg_14_1, arg_14_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.crossroad_minigame_help.tip
		})

		return
	end)
	self:bind(SimpleMGEvent.READY_START, function(arg_15_0, arg_15_1, arg_15_2)
		self:readyStart()

		return
	end)
	self:bind(SimpleMGEvent.ADD_SCORE, function(arg_16_0, arg_16_1, arg_16_2)
		self:addScore(arg_16_1.score)

		return
	end)
	self:bind(CrossRoadGameView.SUB_LIFE, function(arg_17_0, arg_17_1, arg_17_2)
		self:changeLife(-1)

		return
	end)
	self:bind(CrossRoadGameView.ADD_LIFE, function(arg_18_0, arg_18_1, arg_18_2)
		self:changeLife(CrossRoadGameConst.HONGCHA_GET_LIFE)

		return
	end)
	self:bind(CrossRoadGameView.AGAIN, function(arg_19_0, arg_19_1, arg_19_2)
		self:readyStart()

		return
	end)
	self:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
			getProxy(MiniGameProxy):UpdataHighScore(var_0_1, {
				arg_20_1.num,
				arg_20_1.cnt
			})
		end

		return
	end)

	return
end

function CrossRoadGameView:initUI()
	setActive(findTF(self._tf, "tpl"), false)

	self.clickMask = findTF(self._tf, "clickMask")
	self.menuUIbg1 = findTF(self._tf, "ui/bg")
	self.menuUIbg2 = findTF(self._tf, "ui/bg_1")
	self.popUI = CrossRoadPopUI.New(self._tf, self, self._gameVo)

	self.popUI:ClearUI()

	self.gameUI = CrossRoadGamingUI.New(self._tf, self, self._gameVo)

	self.gameUI:Show(false)

	self.menuUI = CrossRoadMenuUI.New(self._tf, self, self._gameVo)

	self.menuUI:Update()
	self.menuUI:Show(true)
	setActive(self.menuUIbg1, true)
	setActive(self.menuUIbg2, true)

	self.gameScene = CrossRoadScene.New(self._tf, self, self._gameVo)

	self.gameScene:ShowContainer(true)

	return
end

function CrossRoadGameView:changeBgm(arg_22_1)
	local var_22_0

	if arg_22_1 == PipeGameConst.bgm_type_default then
		var_22_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_22_1 == PipeGameConst.bgm_type_menu then
		var_22_0 = CrossRoadGameConst.menu_bgm
	elseif arg_22_1 == PipeGameConst.bgm_type_game then
		var_22_0 = CrossRoadGameConst.game_bgm
	end

	if self.bgm ~= var_22_0 then
		self.bgm = var_22_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_22_0)
	end

	return
end

function CrossRoadGameView:OnUpdate()
	self:gameStep()

	return
end

function CrossRoadGameView:readyStart()
	self.readyStartFlag = true

	self._gameVo:Prepare()
	self.popUI:ReadyStart()
	self.menuUI:Show(false)
	self.gameUI:Show(false)
	setActive(self.menuUIbg1, false)
	setActive(self.menuUIbg2, false)
	self.gameScene:Prepare()

	return
end

function CrossRoadGameView:gameStart()
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

function CrossRoadGameView:gameStep()
	if self.gameStartFlag and not self.gameStop and not self.settlementFlag then
		self:stepRunTimeData()
		self.gameUI:Step()
		self.gameScene:Step()

		if self._gameVo:GetTime() <= 0 then
			self:onGameOver()
		end
	end

	return
end

function CrossRoadGameView:timerStart()
	self.gamestop = false

	return
end

function CrossRoadGameView:timerStop()
	self.gamestop = true

	self.gameScene:Stop()

	return
end

function CrossRoadGameView:stepRunTimeData()
	self._gameVo:Step(Time.deltaTime)

	return
end

function CrossRoadGameView:addScore(arg_30_1)
	self._gameVo:AddScore(arg_30_1)

	return
end

function CrossRoadGameView:changeLife(arg_31_1)
	if self._gameVo:GetLife() + arg_31_1 <= 0 then
		self:onGameOver()

		return
	end

	self._gameVo:changeLife(arg_31_1)

	return
end

function CrossRoadGameView:onGameOver(arg_32_1)
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

function CrossRoadGameView:OnApplicationPaused()
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

function CrossRoadGameView:clearController()
	self.gameScene:Clear()

	return
end

function CrossRoadGameView:pauseGame()
	self.gameStop = true

	self:timerStop()

	return
end

function CrossRoadGameView:resumeGame()
	self.gameStop = false

	self:timerStart()

	return
end

function CrossRoadGameView:onBackPressed()
	if self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self.popUI:BackPressed()
	end

	if not self.gameStartFlag and not self.settlementFlag and not self.readyStartFlag then
		self.menuUI:Show(false)
		self:closeView()
	end

	return
end

function CrossRoadGameView:OnSendMiniGameOPDone(arg_39_1)
	return
end

function CrossRoadGameView:willExit()
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

return CrossRoadGameView
