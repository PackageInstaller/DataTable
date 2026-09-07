local ToLoveGameView = class("ToLoveGameView", import("..BaseMiniGameView"))
local ToLoveGameVo = import("view.miniGame.gameView.ToLoveGame.ToLoveGameVo")

function ToLoveGameView:getUIName()
	return "ToLoveGameUI"
end

function ToLoveGameView:didEnter()
	self:initData()
	self:initUI()
	self:initEvent()
	self:changeBgm(ToLoveGameConst.bgm_type_menu)

	return
end

function ToLoveGameView:initData()
	ToLoveGameVo.Init(self:GetMGData().id, self:GetMGHubData().id)

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / ((ToLoveGameVo.frameRate > 60 or nil) and 60), -1)

	self:GetTaskData()

	return
end

function ToLoveGameView:initUI()
	self:initMenuUI()
	self:initGamingUI()
	self:initPopUI()

	self.clickMask = self._tf:Find("clickMask")

	return
end

function ToLoveGameView:initMenuUI()
	self.menuUI = self._tf:Find("ui/menuUI")
	self.menuBack = self.menuUI:Find("btnBack")
	self.menuHome = self.menuUI:Find("btnHome")
	self.menuHighestScoreText = self.menuUI:Find("highestScore/Text")
	self.menuRule = self.menuUI:Find("btnRule")
	self.menuStart = self.menuUI:Find("btnStart")
	self.menuRank = self.menuUI:Find("btnRank")
	self.menuBuff = self.menuUI:Find("btnBuff")
	self.menuTask = self.menuUI:Find("btnTask")
	self.menuLastTimesText = self.menuUI:Find("lastTimes/desc")
	self.menuAwardList = UIItemList.New(self.menuUI:Find("awardsScrollView/Viewport/Content"), self.menuUI:Find("awardsScrollView/Viewport/Content/award"))
	self.menuStartTip = self.menuStart:Find("tip")
	self.menuBuffTip = self.menuBuff:Find("tip")
	self.menuTaskTip = self.menuTask:Find("tip")

	setText(self.menuUI:Find("awards/Text"), i18n("tolovegame_join_reward"))
	self.menuUI:Find("title"):GetComponent(typeof(Image)):SetNativeSize()
	self.menuUI:Find("desc"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.menuUI, true)
	onButton(self, self.menuBack, function()
		self:closeView()

		return
	end, SFX_PANEL)
	onButton(self, self.menuHome, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	if self:GetMGHubData().highScores[ToLoveGameVo.game_id] and self:GetMGHubData().highScores[ToLoveGameVo.game_id][1] then
		ToLoveGameVo.highestScore = self:GetMGHubData().highScores[ToLoveGameVo.game_id][1]
	end

	setText(self.menuHighestScoreText, ToLoveGameVo.highestScore)
	onButton(self, self.menuRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[ToLoveGameConst.rule_tip].tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.menuStart, function()
		self:readyStart()

		return
	end, SFX_PANEL)
	onButton(self, self.menuRank, function()
		setActive(self.menuUI, false)
		self:ShowRank()

		return
	end, SFX_PANEL)
	onButton(self, self.menuBuff, function()
		setActive(self.menuUI, false)
		self:ShowBuff()

		return
	end, SFX_PANEL)
	onButton(self, self.menuTask, function()
		setActive(self.menuUI, false)
		self:ShowTask()

		return
	end, SFX_PANEL)
	setText(self.menuLastTimesText, self:GetMGHubData().count)
	self:UpdateMenuAwardList()
	setActive(self.menuStartTip, self:GetMGHubData().count > 0)
	setActive(self.menuBuffTip, self:ShouldShowBuffTip())
	setActive(self.menuTaskTip, self.canGetAward)

	return
end

function ToLoveGameView:UpdateMenuAwardList()
	self.menuAwardList:make(function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = {
			type = ToLoveGameVo.drop[arg_15_1 + 1][1],
			id = ToLoveGameVo.drop[arg_15_1 + 1][2],
			count = ToLoveGameVo.drop[arg_15_1 + 1][3]
		}

		updateDrop(arg_15_2, var_15_0)
		onButton(self, arg_15_2, function()
			self:emit(BaseUI.ON_DROP, var_15_0)

			return
		end, SFX_PANEL)

		local var_15_1 = self:GetMGHubData().usedtime

		setActive(arg_15_2:Find("lock"), arg_15_1 + 1 > self:GetMGHubData().count + var_15_1)
		setActive(arg_15_2:Find("got"), var_15_1 >= arg_15_1 + 1)

		return
	end)
	self.menuAwardList:align(#ToLoveGameVo.drop)

	return
end

function ToLoveGameView:ShouldShowBuffTip()
	self.unlockBuffCount = 0

	for iter_17_0, iter_17_1 in ipairs((ToLoveGameVo.GetBuffList(self:GetMGHubData()))) do
		if iter_17_1[3] == "" then
			self.unlockBuffCount = self.unlockBuffCount + 1
		end
	end

	if self.unlockBuffCount ~= PlayerPrefs.GetInt("toLoveGameBuffCount", 0) then
		return true
	end

	return false
end

function ToLoveGameView:initGamingUI()
	self.gamingUI = self._tf:Find("ui/gamingUI")
	self.gamingBack = self.gamingUI:Find("back")
	self.gamingPause = self.gamingUI:Find("pause")
	self.gamingScoreText = self.gamingUI:Find("bgScore/score")
	self.gamingTimeText = self.gamingUI:Find("bgTime/time")
	self.gamingBuff = self.gamingUI:Find("buff")
	self.gamingOperationArea = self.gamingUI:Find("operationArea")
	self.gamingUp = self.gamingUI:Find("operationArea/up")
	self.gamingDown = self.gamingUI:Find("operationArea/down")
	self.gamingLeft = self.gamingUI:Find("operationArea/left")
	self.gamingRight = self.gamingUI:Find("operationArea/right")
	self.gamingMap = self.gamingUI:Find("map")

	setActive(self.gamingUI, false)
	setActive(self.gamingOperationArea, false)
	onButton(self, self.gamingBack, function()
		if not ToLoveGameVo.startSettlement then
			self:pauseGame()
			setActive(self.leaveUI, true)
			setActive(self.gamingBack, false)
			setActive(self.gamingPause, false)
			setActive(self.gamingOperationArea, false)
			setActive(self.gamingBuff, false)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.gamingPause, function()
		if not ToLoveGameVo.startSettlement then
			self:pauseGame()
			setActive(self.pauseUI, true)
			setActive(self.gamingBack, false)
			setActive(self.gamingPause, false)
			setActive(self.gamingOperationArea, false)
			setActive(self.gamingBuff, false)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.gamingUp, function()
		if ToLoveGameVo.canMove then
			ToLoveGameVo.canMove = false

			self:OperateMapPlayer(function(arg_22_0)
				local var_22_0 = arg_22_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_22_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_22_1 = ToLoveGameVo.currentPlayerPosition[1] - 1

				if ToLoveGameVo.currentPlayerPosition[1] - 1 == 0 then
					var_22_1 = 5
				end

				self:OperateMap(ToLoveGameConst.map[var_22_1][ToLoveGameVo.currentPlayerPosition[2]], function(arg_23_0)
					arg_23_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, -86)

					return
				end)
				var_22_0:SetEndEvent(function()
					var_22_0:SetEndEvent(nil)
					self:OperateMapPlayer(function(arg_25_0)
						setActive(arg_25_0:Find("player"), false)

						return
					end)

					ToLoveGameVo.currentPlayerPosition[1] = var_22_1

					self:OperateMapPlayer(function(arg_26_0)
						setActive(arg_26_0:Find("player"), true)
						setActive(arg_26_0:Find("player/arrow"), false)
						setActive(arg_26_0:Find("player/happy"), false)
						setActive(arg_26_0:Find("player/sad"), false)

						if ToLoveGameVo.shieldCount > 0 then
							setActive(arg_26_0:Find("player/shield"), true)
						else
							setActive(arg_26_0:Find("player/shield"), false)
						end

						arg_26_0:Find("player"):GetComponent(typeof(Animator)):Play("playerDownBack")

						return
					end)

					return
				end)
				arg_22_0:Find("player"):GetComponent(typeof(Animator)):Play("playerUp")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.gamingDown, function()
		if ToLoveGameVo.canMove then
			ToLoveGameVo.canMove = false

			self:OperateMapPlayer(function(arg_28_0)
				local var_28_0 = arg_28_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_28_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_28_1 = ToLoveGameVo.currentPlayerPosition[1] + 1

				if ToLoveGameVo.currentPlayerPosition[1] + 1 == 6 then
					var_28_1 = 1
				end

				self:OperateMap(ToLoveGameConst.map[var_28_1][ToLoveGameVo.currentPlayerPosition[2]], function(arg_29_0)
					arg_29_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 86)

					return
				end)
				var_28_0:SetEndEvent(function()
					var_28_0:SetEndEvent(nil)
					self:OperateMapPlayer(function(arg_31_0)
						setActive(arg_31_0:Find("player"), false)

						return
					end)

					ToLoveGameVo.currentPlayerPosition[1] = var_28_1

					self:OperateMapPlayer(function(arg_32_0)
						setActive(arg_32_0:Find("player"), true)
						setActive(arg_32_0:Find("player/arrow"), false)
						setActive(arg_32_0:Find("player/happy"), false)
						setActive(arg_32_0:Find("player/sad"), false)

						if ToLoveGameVo.shieldCount > 0 then
							setActive(arg_32_0:Find("player/shield"), true)
						else
							setActive(arg_32_0:Find("player/shield"), false)
						end

						arg_32_0:Find("player"):GetComponent(typeof(Animator)):Play("playerUpBack")

						return
					end)

					return
				end)
				arg_28_0:Find("player"):GetComponent(typeof(Animator)):Play("playerDown")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.gamingLeft, function()
		if ToLoveGameVo.canMove then
			ToLoveGameVo.canMove = false

			self:OperateMapPlayer(function(arg_34_0)
				local var_34_0 = arg_34_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_34_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_34_1 = ToLoveGameVo.currentPlayerPosition[2] - 1

				if ToLoveGameVo.currentPlayerPosition[2] - 1 == 0 then
					var_34_1 = 5
				end

				self:OperateMap(ToLoveGameConst.map[ToLoveGameVo.currentPlayerPosition[1]][var_34_1], function(arg_35_0)
					arg_35_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(82.5, 0)

					return
				end)
				var_34_0:SetEndEvent(function()
					var_34_0:SetEndEvent(nil)
					self:OperateMapPlayer(function(arg_37_0)
						setActive(arg_37_0:Find("player"), false)

						return
					end)

					ToLoveGameVo.currentPlayerPosition[2] = var_34_1

					self:OperateMapPlayer(function(arg_38_0)
						setActive(arg_38_0:Find("player"), true)
						setActive(arg_38_0:Find("player/arrow"), false)
						setActive(arg_38_0:Find("player/happy"), false)
						setActive(arg_38_0:Find("player/sad"), false)

						if ToLoveGameVo.shieldCount > 0 then
							setActive(arg_38_0:Find("player/shield"), true)
						else
							setActive(arg_38_0:Find("player/shield"), false)
						end

						arg_38_0:Find("player"):GetComponent(typeof(Animator)):Play("playerRightBack")

						return
					end)

					return
				end)
				arg_34_0:Find("player"):GetComponent(typeof(Animator)):Play("playerLeft")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(self, self.gamingRight, function()
		if ToLoveGameVo.canMove then
			ToLoveGameVo.canMove = false

			self:OperateMapPlayer(function(arg_40_0)
				local var_40_0 = arg_40_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_40_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_40_1 = ToLoveGameVo.currentPlayerPosition[2] + 1

				if ToLoveGameVo.currentPlayerPosition[2] + 1 == 6 then
					var_40_1 = 1
				end

				self:OperateMap(ToLoveGameConst.map[ToLoveGameVo.currentPlayerPosition[1]][var_40_1], function(arg_41_0)
					arg_41_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(-82.5, 0)

					return
				end)
				var_40_0:SetEndEvent(function()
					var_40_0:SetEndEvent(nil)
					self:OperateMapPlayer(function(arg_43_0)
						setActive(arg_43_0:Find("player"), false)

						return
					end)

					ToLoveGameVo.currentPlayerPosition[2] = var_40_1

					self:OperateMapPlayer(function(arg_44_0)
						setActive(arg_44_0:Find("player"), true)
						setActive(arg_44_0:Find("player/arrow"), false)
						setActive(arg_44_0:Find("player/happy"), false)
						setActive(arg_44_0:Find("player/sad"), false)

						if ToLoveGameVo.shieldCount > 0 then
							setActive(arg_44_0:Find("player/shield"), true)
						else
							setActive(arg_44_0:Find("player/shield"), false)
						end

						arg_44_0:Find("player"):GetComponent(typeof(Animator)):Play("playerLeftBack")

						return
					end)

					return
				end)
				arg_40_0:Find("player"):GetComponent(typeof(Animator)):Play("playerRight")

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:initPopUI()
	self.popUI = self._tf:Find("ui/popUI")

	self:initCountUI()
	self:initSettlementUI()
	self:initLeavelUI()
	self:initPauseUI()
	self:initRankUI()
	self:initBuffUI()
	self:initTaskUI()

	return
end

function ToLoveGameView:initCountUI()
	self.countUI = self.popUI:Find("countUI")
	self.count = self.countUI:Find("count")
	self.countAnimator = self.count:GetComponent(typeof(Animator))
	self.countDft = self.count:GetComponent(typeof(DftAniEvent))

	setActive(self.countUI, false)
	self.countDft:SetEndEvent(function()
		self:gameStart()

		return
	end)

	return
end

function ToLoveGameView:initSettlementUI()
	self.settlementUI = self.popUI:Find("settleMentUI")
	self.settlementCurrentText = self.settlementUI:Find("ad/currentText")
	self.settlementHighText = self.settlementUI:Find("ad/highText")
	self.settlementOverBtn = self.settlementUI:Find("ad/btnOver")
	self.settlementNew = self.settlementUI:Find("ad/new")
	self.settlementClose = self.settlementUI:Find("ad/btnClose")

	self.settlementUI:Find("ad/CurImg"):GetComponent(typeof(Image)):SetNativeSize()
	self.settlementUI:Find("ad/HighImg"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.settlementUI, false)
	onButton(self, self.settlementOverBtn, function()
		if not self.sendSuccessFlag then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		setActive(self.settlementUI, false)
		setActive(self.menuUI, true)
		setActive(self.gamingUI, false)
		setText(self.menuHighestScoreText, ToLoveGameVo.highestScore)
		self:GetTaskData()
		setActive(self.menuTaskTip, self.canGetAward)
		self:changeBgm(ToLoveGameConst.bgm_type_menu)

		return
	end, SFX_PANEL)
	onButton(self, self.settlementClose, function()
		triggerButton(self.settlementOverBtn)

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:initLeavelUI()
	self.leaveUI = self.popUI:Find("leaveUI")
	self.leaveOkBtn = self.leaveUI:Find("ad/btnOk")
	self.leaveCancelBtn = self.leaveUI:Find("ad/btnCancel")
	self.leaveClose = self.leaveUI:Find("ad/btnClose")

	self.leaveUI:Find("ad/desc"):GetComponent(typeof(Image)):SetNativeSize()
	self.leaveUI:Find("ad/desc2"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.leaveUI, false)
	onButton(self, self.leaveOkBtn, function()
		setActive(self.leaveUI, false)
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_PANEL)
	onButton(self, self.leaveCancelBtn, function()
		setActive(self.leaveUI, false)
		setActive(self.gamingBack, true)
		setActive(self.gamingPause, true)

		if ToLoveGameVo.playerMoveFlag then
			setActive(self.gamingOperationArea, true)
		end

		setActive(self.gamingBuff, true)
		self:resumeGame()

		return
	end, SFX_PANEL)
	onButton(self, self.leaveClose, function()
		triggerButton(self.leaveCancelBtn)

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:initPauseUI()
	self.pauseUI = self.popUI:Find("pauseUI")
	self.pauseOkBtn = self.pauseUI:Find("ad/btnOk")
	self.pauseClose = self.pauseUI:Find("ad/btnClose")

	self.pauseUI:Find("ad/desc"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.pauseUI, false)
	onButton(self, self.pauseOkBtn, function()
		setActive(self.pauseUI, false)
		setActive(self.gamingBack, true)
		setActive(self.gamingPause, true)

		if ToLoveGameVo.playerMoveFlag then
			setActive(self.gamingOperationArea, true)
		end

		setActive(self.gamingBuff, true)
		self:resumeGame()

		return
	end, SFX_PANEL)
	onButton(self, self.pauseClose, function()
		triggerButton(self.pauseOkBtn)

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:initRankUI()
	self.rankUI = self.popUI:Find("rankUI")
	self.rankCloseBtn = self.rankUI:Find("ad/btnClose")
	self.rankPlayerList = UIItemList.New(self.rankUI:Find("ad/Scroll View/Viewport/Content"), self.rankUI:Find("ad/Scroll View/Viewport/Content/playerTpl"))
	self.rankMyself = self.rankUI:Find("ad/myself")
	self.rankDesc = self.rankUI:Find("ad/desc")

	setText(self.rankUI:Find("ad/score"), i18n("tolovegame_score"))
	setText(self.rankUI:Find("ad/desc"), i18n("tolovegame_rank_tip"))
	self.rankUI:Find("ad/bg/titleBg/title"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.rankUI, false)
	onButton(self, self.rankCloseBtn, function()
		setActive(self.rankUI, false)
		setActive(self.menuUI, true)

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:initBuffUI()
	self.buffUI = self.popUI:Find("buffUI")
	self.buffCloseBtn = self.buffUI:Find("ad/btnClose")
	self.buffList = UIItemList.New(self.buffUI:Find("ad/Scroll View/Viewport/Content"), self.buffUI:Find("ad/Scroll View/Viewport/Content/buff"))

	self.buffUI:Find("ad/bg/titleBg/title"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.buffUI, false)
	onButton(self, self.buffCloseBtn, function()
		setActive(self.buffUI, false)
		setActive(self.menuUI, true)

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:initTaskUI()
	self.taskUI = self.popUI:Find("taskUI")
	self.taskCloseBtn = self.taskUI:Find("ad/btnClose")
	self.taskTasklist = UIItemList.New(self.taskUI:Find("ad/Scroll View/Viewport/Content"), self.taskUI:Find("ad/Scroll View/Viewport/Content/Tasktpl"))

	self.taskUI:Find("ad/bg/titleBg/title"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(self.taskUI, false)
	onButton(self, self.taskCloseBtn, function()
		setActive(self.taskUI, false)
		setActive(self.menuUI, true)
		self:GetTaskData()
		setActive(self.menuTaskTip, self.canGetAward)

		return
	end, SFX_PANEL)

	return
end

function ToLoveGameView:onTimer()
	self:stepRunTimeData()
	self:TimeStep(ToLoveGameVo.deltaTime)
	self:ShowArrowAndPlayerMove()

	if ToLoveGameVo.gameTime <= 0 then
		if ToLoveGameVo.buffIndex == 6 then
			if math.random() >= 0.5 then
				ToLoveGameVo.gameTime = ToLoveGameVo.gameTime + ToLoveGameConst.addTime
			else
				self:onGameOver()
			end
		else
			self:onGameOver()
		end
	end

	return
end

function ToLoveGameView:stepRunTimeData()
	local var_65_0 = Time.deltaTime

	if not ToLoveGameVo.startSettlement then
		ToLoveGameVo.gameTime = ToLoveGameVo.gameTime - var_65_0

		if ToLoveGameVo.gameTime < 0 then
			ToLoveGameVo.gameTime = 0
		end

		ToLoveGameVo.gameStepTime = ToLoveGameVo.gameStepTime + var_65_0

		if (ToLoveGameVo.showArrowFlag or ToLoveGameVo.playerMoveFlag) and ToLoveGameVo.gameStepTime >= ToLoveGameConst.motionTime then
			ToLoveGameVo.gameStepTime = ToLoveGameVo.gameStepTime - ToLoveGameConst.motionTime

			ToLoveGameVo.ChangeMotion()
		end

		if ToLoveGameVo.waitingFlag and ToLoveGameVo.gameStepTime >= ToLoveGameConst.waitingTime then
			ToLoveGameVo.gameStepTime = ToLoveGameVo.gameStepTime - ToLoveGameConst.waitingTime

			ToLoveGameVo.ChangeMotion()
		end

		ToLoveGameVo.gameArrowTime = ToLoveGameVo.gameArrowTime + var_65_0
		ToLoveGameVo.gameMoveTime = ToLoveGameVo.gameMoveTime + var_65_0
		ToLoveGameVo.gameBombTime = ToLoveGameVo.gameBombTime + var_65_0

		if ToLoveGameVo.bombBlast then
			ToLoveGameVo.gameBombBlastTime = ToLoveGameVo.gameBombBlastTime + var_65_0
		end
	end

	ToLoveGameVo.deltaTime = var_65_0

	return
end

function ToLoveGameView:TimeStep(arg_66_1)
	local var_66_0 = math.floor(ToLoveGameVo.gameTime)

	setText(self.gamingTimeText, string.format("%02d", (math.floor(var_66_0 / 60))) .. "  :  " .. string.format("%02d", var_66_0 % 60))

	return
end

function ToLoveGameView:ShowArrowAndPlayerMove()
	if ToLoveGameVo.showArrowFlag then
		if not ToLoveGameVo.hasDone then
			ToLoveGameVo.hasDone = true

			setActive(self.gamingOperationArea, false)
		end

		if ToLoveGameVo.gameArrowTime >= ToLoveGameVo.doTime then
			ToLoveGameVo.gameArrowTime = ToLoveGameVo.gameArrowTime - ToLoveGameVo.doTime

			self:OperateMapPlayer(function(arg_68_0)
				setActive(arg_68_0:Find("player/arrow"), true)
				self:ShowArraw(arg_68_0:Find("player/arrow"), ToLoveGameVo.arrowList[ToLoveGameVo.nowArrowIndex])

				ToLoveGameVo.nowArrowIndex = ToLoveGameVo.nowArrowIndex + 1

				return
			end)
		end
	elseif ToLoveGameVo.playerMoveFlag then
		if not ToLoveGameVo.hasDone then
			ToLoveGameVo.hasDone = true

			setActive(self.gamingOperationArea, true)
			self:OperateMapPlayer(function(arg_69_0)
				setActive(arg_69_0:Find("player/arrow"), false)

				return
			end)
		end

		if ToLoveGameVo.gameMoveTime >= ToLoveGameVo.doTime and ToLoveGameVo.moveCount > 0 then
			ToLoveGameVo.moveCount = ToLoveGameVo.moveCount - 1
			ToLoveGameVo.gameMoveTime = ToLoveGameVo.gameMoveTime - ToLoveGameVo.doTime
			ToLoveGameVo.canMove = true
		end
	end

	self:BombBlast()

	return
end

function ToLoveGameView:ShowArraw(arg_70_1, arg_70_2)
	arg_70_1:GetComponent(typeof(Animation)):Play("arrowUp")

	if arg_70_2 == ToLoveGameConst.arrowUp then
		setActive(arg_70_1:Find("up"), true)
		setActive(arg_70_1:Find("down"), false)
		setActive(arg_70_1:Find("left"), false)
		setActive(arg_70_1:Find("right"), false)
	elseif arg_70_2 == ToLoveGameConst.arrowDown then
		setActive(arg_70_1:Find("up"), false)
		setActive(arg_70_1:Find("down"), true)
		setActive(arg_70_1:Find("left"), false)
		setActive(arg_70_1:Find("right"), false)
	elseif arg_70_2 == ToLoveGameConst.arrowLeft then
		setActive(arg_70_1:Find("up"), false)
		setActive(arg_70_1:Find("down"), false)
		setActive(arg_70_1:Find("left"), true)
		setActive(arg_70_1:Find("right"), false)
	elseif arg_70_2 == ToLoveGameConst.arrowRight then
		setActive(arg_70_1:Find("up"), false)
		setActive(arg_70_1:Find("down"), false)
		setActive(arg_70_1:Find("left"), false)
		setActive(arg_70_1:Find("right"), true)
	end

	if ToLoveGameVo.arrowVideoCount > 0 then
		ToLoveGameVo.arrowVideoCount = ToLoveGameVo.arrowVideoCount - 1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-di")
	end

	return
end

function ToLoveGameView:BombBlast()
	if ToLoveGameVo.nowBombIndex <= #ToLoveGameVo.safeList and ToLoveGameVo.gameBombTime >= ToLoveGameVo.doTime then
		ToLoveGameVo.gameBombTime = ToLoveGameVo.gameBombTime - ToLoveGameVo.doTime
		ToLoveGameVo.safeCellPosition = ToLoveGameVo.GetSafeCellPosition(ToLoveGameVo.safeList[ToLoveGameVo.nowBombIndex])
		ToLoveGameVo.previousPlayerPosition = Clone(ToLoveGameVo.currentPlayerPosition)
		ToLoveGameVo.nowBombIndex = ToLoveGameVo.nowBombIndex + 1
		self.isOk = true

		self:OperateMapOthers(function(arg_72_0)
			setActive(arg_72_0:Find("bomb"), true)

			if isActive(arg_72_0:Find("player")) then
				self.isOk = false
			end

			return
		end, ToLoveGameVo.safeCellPosition)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-bomb")

		if self.isOk then
			self:AddScore()
			setText(self.gamingScoreText, ToLoveGameVo.score)

			if ToLoveGameVo.buffIndex == 4 then
				ToLoveGameVo.shieldGetCombo = ToLoveGameVo.shieldGetCombo + 1

				if ToLoveGameVo.shieldGetCombo == 5 then
					ToLoveGameVo.shieldGetCombo = 0

					if ToLoveGameVo.shieldCount < 2 then
						ToLoveGameVo.shieldCount = ToLoveGameVo.shieldCount + 1

						self:OperateMapPlayer(function(arg_73_0)
							setActive(arg_73_0:Find("player/shield"), true)

							return
						end)
					end
				end
			end

			self:OperateMapPlayer(function(arg_74_0)
				setActive(arg_74_0:Find("player/happy"), true)

				return
			end)
		else
			if ToLoveGameVo.shieldCount > 0 then
				ToLoveGameVo.combo = 0
				ToLoveGameVo.shieldCount = ToLoveGameVo.shieldCount - 1

				self:OperateMapPlayer(function(arg_75_0)
					if ToLoveGameVo.shieldCount > 0 then
						setActive(arg_75_0:Find("player/shield"), true)
					else
						setActive(arg_75_0:Find("player/shield"), false)
					end

					return
				end)
			else
				self:onGameOver()
			end

			self:OperateMapPlayer(function(arg_76_0)
				setActive(arg_76_0:Find("player/sad"), true)

				return
			end)
		end

		ToLoveGameVo.bombBlast = true
	end

	if ToLoveGameVo.bombBlast and ToLoveGameVo.gameBombBlastTime >= ToLoveGameConst.bombBlastTime then
		ToLoveGameVo.bombBlast = false
		ToLoveGameVo.gameBombBlastTime = 0

		self:OperateMapOthers(function(arg_77_0)
			setActive(arg_77_0:Find("bomb"), false)

			return
		end, ToLoveGameVo.safeCellPosition)
	end

	return
end

function ToLoveGameView:readyStart()
	self.readyStartFlag = true

	ToLoveGameVo.Prepare()
	setActive(self.countUI, true)
	setActive(self.menuUI, false)
	setActive(self.gamingUI, false)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(ToLoveGameVo.SFX_COUNT_DOWN)
	self:OperateMapAll(function(arg_79_0)
		setActive(arg_79_0:Find("bomb"), false)

		return
	end)

	return
end

function ToLoveGameView:gameStart()
	self.readyStartFlag = false
	self.gameStartFlag = true
	self.sendSuccessFlag = false

	setActive(self.countUI, false)
	setActive(self.gamingUI, true)
	self:ResetMapAndPlayer()
	self:timerStart()
	self:changeBgm(ToLoveGameConst.bgm_type_game)
	setText(self.gamingScoreText, ToLoveGameVo.score)
	self:SetGamingBuff()
	setActive(self.gamingBack, true)
	setActive(self.gamingPause, true)
	setActive(self.gamingBuff, true)

	return
end

function ToLoveGameView:ResetMapAndPlayer()
	for iter_81_0 = 0, self.gamingMap.childCount - 1 do
		local var_81_0 = self.gamingMap:GetChild(iter_81_0)

		setActive(var_81_0:Find("player/happy"), false)
		setActive(var_81_0:Find("player/sad"), false)

		var_81_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

		if iter_81_0 == ToLoveGameConst.map[ToLoveGameVo.currentPlayerPosition[1]][ToLoveGameVo.currentPlayerPosition[2]] then
			setActive(var_81_0:Find("player"), true)
			setActive(var_81_0:Find("player/arrow"), false)

			if ToLoveGameVo.shieldCount > 0 then
				setActive(var_81_0:Find("player/shield"), true)
			else
				setActive(var_81_0:Find("player/shield"), false)
			end
		else
			setActive(var_81_0:Find("player"), false)
		end
	end

	return
end

function ToLoveGameView:OperateMapAll(arg_82_1)
	for iter_82_0 = 0, self.gamingMap.childCount - 1 do
		arg_82_1((self.gamingMap:GetChild(iter_82_0)))
	end

	return
end

function ToLoveGameView:OperateMapPlayer(arg_83_1)
	for iter_83_0 = 0, self.gamingMap.childCount - 1 do
		if iter_83_0 == ToLoveGameConst.map[ToLoveGameVo.currentPlayerPosition[1]][ToLoveGameVo.currentPlayerPosition[2]] then
			arg_83_1((self.gamingMap:GetChild(iter_83_0)))

			break
		end
	end

	return
end

function ToLoveGameView:OperateMapOthers(arg_84_1, arg_84_2)
	for iter_84_0 = 0, self.gamingMap.childCount - 1 do
		if iter_84_0 ~= ToLoveGameConst.map[arg_84_2[1]][arg_84_2[2]] then
			arg_84_1((self.gamingMap:GetChild(iter_84_0)))
		end
	end

	return
end

function ToLoveGameView:OperateMap(arg_85_1, arg_85_2)
	for iter_85_0 = 0, self.gamingMap.childCount - 1 do
		if iter_85_0 == arg_85_1 then
			arg_85_2((self.gamingMap:GetChild(iter_85_0)))

			break
		end
	end

	return
end

function ToLoveGameView:SetGamingBuff()
	for iter_86_0 = 1, 7 do
		setActive(self.gamingBuff:GetChild(iter_86_0 - 1), ToLoveGameVo.buffIndex == iter_86_0)
	end

	return
end

function ToLoveGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function ToLoveGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function ToLoveGameView:AddScore()
	ToLoveGameVo.combo = ToLoveGameVo.combo + 1

	local var_89_0 = 100

	for iter_89_0 = #ToLoveGameConst.comboNum, 1, -1 do
		if ToLoveGameVo.combo >= ToLoveGameConst.comboNum[iter_89_0] then
			var_89_0 = var_89_0 + ToLoveGameConst.comboAdd[iter_89_0]

			break
		end
	end

	local var_89_1 = ToLoveGameVo.GetScoreMultiplyRate()
	local var_89_2 = 1

	if ToLoveGameVo.buffIndex == 2 or ToLoveGameVo.buffIndex == 7 then
		var_89_2 = 1.2
	elseif ToLoveGameVo.buffIndex == 5 then
		var_89_2 = 1.2 + 0.01 * math.floor(ToLoveGameVo.combo / 5)
	end

	ToLoveGameVo.score = ToLoveGameVo.score + math.ceil(var_89_0 * var_89_1 * var_89_2)

	return
end

function ToLoveGameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self.settlementFlag = true

	self:timerStop()

	ToLoveGameVo.startSettlement = true

	setActive(self.clickMask, true)
	LeanTween.delayedCall(go(self._tf), 0.2, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:ShowSettlementUI()

		return
	end))
	self:UpdateTaskProgress()

	return
end

function ToLoveGameView:ShowSettlementUI()
	setActive(self.settlementUI, true)
	setActive(self.gamingBack, false)
	setActive(self.gamingPause, false)
	setActive(self.gamingOperationArea, false)
	setActive(self.gamingBuff, false)
	setText(self.settlementCurrentText, ToLoveGameVo.score)
	setActive(self.settlementNew, false)

	if ToLoveGameVo.score > ToLoveGameVo.highestScore then
		ToLoveGameVo.highestScore = ToLoveGameVo.score

		setActive(self.settlementNew, true)
		getProxy(MiniGameProxy):UpdataHighScore(ToLoveGameVo.game_id, {
			ToLoveGameVo.highestScore,
			ToLoveGameVo.gameTime
		})
	end

	setText(self.settlementHighText, ToLoveGameVo.highestScore)

	return
end

function ToLoveGameView:OnSendMiniGameOPDone(arg_93_1)
	if arg_93_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_93_0 = checkExist(ToLoveGameVo.story, {
			self:GetMGHubData().usedtime
		}, {
			1
		})

		if var_93_0 then
			pg.NewStoryMgr.GetInstance():Play(var_93_0)
		end

		setText(self.menuLastTimesText, self:GetMGHubData().count)
		setActive(self.menuStartTip, self:GetMGHubData().count > 0)
		self:UpdateMenuAwardList()
	end

	return
end

function ToLoveGameView:ShowRank()
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = ToLoveGameVo.game_id,
		callback = function(self)
			local var_95_0 = {}

			for iter_95_0 = 1, #self do
				local var_95_1 = {}

				for iter_95_1, iter_95_2 in pairs(self[iter_95_0]) do
					var_95_1[iter_95_1] = iter_95_2
				end

				table.insert(var_95_0, var_95_1)
			end

			table.sort(var_95_0, function(arg_96_0, arg_96_1)
				if arg_96_0.score ~= arg_96_1.score then
					return arg_96_0.score > arg_96_1.score
				elseif arg_96_0.time_data ~= arg_96_1.time_data then
					return arg_96_0.time_data > arg_96_1.time_data
				else
					return arg_96_0.player_id < arg_96_1.player_id
				end

				return
			end)
			self:SetRankUI(var_95_0)

			return
		end
	})

	return
end

function ToLoveGameView:SetRankUI(arg_97_1)
	setActive(self.rankUI, true)

	local var_97_0
	local var_97_1 = 0

	self.rankPlayerList:make(function(arg_98_0, arg_98_1, arg_98_2)
		local var_98_0 = arg_97_1[arg_98_1 + 1]

		setText(arg_98_2:Find("rank/count"), arg_98_1 + 1)

		if arg_98_1 + 1 == 1 then
			self:SetRankColor(arg_98_2, "ea69fd", var_98_0.name, var_98_0.score)
		elseif arg_98_1 + 1 == 2 then
			self:SetRankColor(arg_98_2, "11bfff", var_98_0.name, var_98_0.score)
		elseif arg_98_1 + 1 == 3 then
			self:SetRankColor(arg_98_2, "51edca", var_98_0.name, var_98_0.score)
		else
			self:SetRankColor(arg_98_2, "83919c", var_98_0.name, var_98_0.score)
		end

		local var_98_1 = getProxy(PlayerProxy):isSelf(var_98_0.player_id)

		if var_98_1 then
			var_97_0 = var_98_0
			var_97_1 = arg_98_1 + 1
		end

		setActive(arg_98_2:Find("1"), arg_98_1 + 1 == 1)
		setActive(arg_98_2:Find("2"), arg_98_1 + 1 == 2)
		setActive(arg_98_2:Find("3"), arg_98_1 + 1 == 3)
		setActive(arg_98_2:Find("rank/1"), arg_98_1 + 1 == 1)
		setActive(arg_98_2:Find("rank/2"), arg_98_1 + 1 == 2)
		setActive(arg_98_2:Find("rank/3"), arg_98_1 + 1 == 3)
		setActive(arg_98_2:Find("imgMe"), var_98_1)

		return
	end)
	self.rankPlayerList:align(#arg_97_1)
	setText(self.rankMyself:Find("nameText"), getProxy(PlayerProxy).data:GetName())

	if nil then
		setText(self.rankMyself:Find("rank/count"), var_97_1)

		if var_97_1 == 1 then
			self:SetRankColor(self.rankMyself, "ea69fd", (nil).name, (nil).score)
		elseif var_97_1 == 2 then
			self:SetRankColor(self.rankMyself, "11bfff", (nil).name, (nil).score)
		elseif var_97_1 == 3 then
			self:SetRankColor(self.rankMyself, "51edca", (nil).name, (nil).score)
		else
			self:SetRankColor(self.rankMyself, "83919c", (nil).name, (nil).score)
		end

		setActive(self.rankMyself:Find("1"), var_97_1 == 1)
		setActive(self.rankMyself:Find("2"), var_97_1 == 2)
		setActive(self.rankMyself:Find("3"), var_97_1 == 3)
		setActive(self.rankMyself:Find("rank/1"), var_97_1 == 1)
		setActive(self.rankMyself:Find("rank/2"), var_97_1 == 2)
		setActive(self.rankMyself:Find("rank/3"), var_97_1 == 3)
	end

	return
end

function ToLoveGameView:SetRankColor(arg_99_1, arg_99_2, arg_99_3, arg_99_4)
	setText(arg_99_1:Find("nameText"), "<color=#" .. arg_99_2 .. ">" .. arg_99_3 .. "</color>")
	setText(arg_99_1:Find("score"), "<color=#" .. arg_99_2 .. ">" .. arg_99_4 .. "</color>")

	return
end

function ToLoveGameView:ShowBuff()
	setActive(self.buffUI, true)

	local var_100_0 = ToLoveGameVo.GetBuffList(self:GetMGHubData())

	self.buffList:make(function(arg_101_0, arg_101_1, arg_101_2)
		setText(arg_101_2:Find("name"), var_100_0[arg_101_1 + 1][1])
		setText(arg_101_2:Find("desc"), var_100_0[arg_101_1 + 1][2])
		setText(arg_101_2:Find("lock/unlockTime"), var_100_0[arg_101_1 + 1][3])
		setText(arg_101_2:Find("useToggle/onText"), i18n("tolovegame_buff_switch_1"))
		setText(arg_101_2:Find("useToggle/using/offText"), i18n("tolovegame_buff_switch_2"))

		for iter_101_0 = 1, 7 do
			setActive(arg_101_2:Find("buffImg"):GetChild(iter_101_0 - 1), arg_101_1 + 1 == iter_101_0)
		end

		onToggle(self, arg_101_2:Find("useToggle"), function(arg_102_0)
			if arg_102_0 then
				PlayerPrefs.SetInt("ToLoveGameBuff", arg_101_1 + 1)
				PlayerPrefs.Save()
				setActive(arg_101_2:Find("buffImg/select"), true)
				setActive(arg_101_2:Find("useToggle/using"), true)
			else
				PlayerPrefs.DeleteKey("ToLoveGameBuff")
				setActive(arg_101_2:Find("buffImg/select"), false)
				setActive(arg_101_2:Find("useToggle/using"), false)
			end

			return
		end, SFX_PANEL)

		if arg_101_1 + 1 == PlayerPrefs.GetInt("ToLoveGameBuff", 0) then
			triggerToggle(arg_101_2:Find("useToggle"), true)
		end

		if var_100_0[arg_101_1 + 1][3] == "" then
			setActive(arg_101_2:Find("name"), true)
			setActive(arg_101_2:Find("desc"), true)
			setActive(arg_101_2:Find("lock"), false)
			setActive(arg_101_2:Find("useToggle"), true)
		else
			setActive(arg_101_2:Find("name"), false)
			setActive(arg_101_2:Find("desc"), false)
			setActive(arg_101_2:Find("lock"), true)
			setActive(arg_101_2:Find("useToggle"), false)
		end

		return
	end)
	self.buffList:align(#var_100_0)
	PlayerPrefs.SetInt("toLoveGameBuffCount", self.unlockBuffCount)
	setActive(self.menuBuffTip, self:ShouldShowBuffTip())

	return
end

function ToLoveGameView:ShowTask()
	setActive(self.taskUI, true)
	self:GetTaskData()
	self.taskTasklist:make(function(arg_104_0, arg_104_1, arg_104_2)
		if arg_104_0 == UIItemList.EventUpdate then
			local var_104_0 = self.taskVOs[arg_104_1 + 1]
			local var_104_1 = self.taskVOs[arg_104_1 + 1]:getConfig("target_num")
			local var_104_2 = math.min(self.taskVOs[arg_104_1 + 1]:getProgress(), var_104_1)

			setText(arg_104_2:Find("frame/progress"), var_104_2 .. "/" .. var_104_1)

			arg_104_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_104_2 / var_104_1

			setText(arg_104_2:Find("frame/go_btn/Text"), i18n("tolovegame_proceed"))
			setText(arg_104_2:Find("frame/get_btn/Text"), i18n("tolovegame_collect"))
			setText(arg_104_2:Find("frame/got_btn/Text"), i18n("tolovegame_collected"))

			local var_104_3 = arg_104_2:Find("frame/awards")

			self:updateAwards(self.taskVOs[arg_104_1 + 1]:getConfig("award_display"), var_104_3, (var_104_3:GetChild(0)))

			local var_104_4 = arg_104_2:Find("frame/go_btn")
			local var_104_5 = arg_104_2:Find("frame/get_btn")
			local var_104_6 = arg_104_2:Find("frame/got_btn")
			local var_104_7 = arg_104_2:Find("frame/leftBar")
			local var_104_8 = arg_104_2:Find("frame/leftBarGot")

			if self.taskVOs[arg_104_1 + 1]:getTaskStatus() == 0 then
				setActive(var_104_4, true)
				setActive(var_104_5, false)
				setActive(var_104_6, false)
				setActive(var_104_7, true)
				setActive(var_104_8, false)
				self:SetTaskColor(arg_104_2, "4de3c2", self.taskVOs[arg_104_1 + 1]:getConfig("desc"))
			elseif self.taskVOs[arg_104_1 + 1]:getTaskStatus() == 1 then
				setActive(var_104_4, false)
				setActive(var_104_5, true)
				setActive(var_104_6, false)
				setActive(var_104_7, true)
				setActive(var_104_8, false)
				self:SetTaskColor(arg_104_2, "4de3c2", self.taskVOs[arg_104_1 + 1]:getConfig("desc"))
			elseif self.taskVOs[arg_104_1 + 1]:getTaskStatus() == 2 then
				setActive(var_104_4, false)
				setActive(var_104_5, false)
				setActive(var_104_6, true)
				setActive(var_104_7, false)
				setActive(var_104_8, true)
				self:SetTaskColor(arg_104_2, "616161", self.taskVOs[arg_104_1 + 1]:getConfig("desc"))
			end

			onButton(self, var_104_4, function()
				setActive(self.taskUI, false)
				self:ShowBuff()
				self:GetTaskData()
				setActive(self.menuTaskTip, self.canGetAward)

				return
			end, SFX_PANEL)
			onButton(self, var_104_5, function()
				local var_106_0 = var_104_0:getConfig("award_display")
				local var_106_1 = getProxy(PlayerProxy):getRawData()
				local var_106_2, var_106_3 = Task.StaticJudgeOverflow(var_106_1.gold, var_106_1.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_106_0)
				local var_106_4 = {}

				if var_106_2 then
					table.insert(var_106_4, function(arg_107_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("award_max_warning"),
							items = var_106_3,
							onYes = arg_107_0
						})

						return
					end)
				end

				seriesAsync(var_106_4, function()
					pg.m02:sendNotification(GAME.SUBMIT_TASK, var_104_0.id)

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.taskTasklist:align(#self.taskVOs)

	return
end

function ToLoveGameView:GetTaskData()
	self.taskVOs = {}
	self.taskIds = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID):getConfig("config_client").task_ids

	for iter_109_0, iter_109_1 in pairs(self.taskIds) do
		table.insert(self.taskVOs, getProxy(TaskProxy):getTaskVO(iter_109_1))
	end

	local var_109_0 = {}

	self.canGetAward = false

	for iter_109_2, iter_109_3 in pairs(self.taskVOs) do
		if iter_109_3:getTaskStatus() == 1 then
			table.insert(var_109_0, iter_109_3)

			self.canGetAward = true
		end
	end

	for iter_109_4, iter_109_5 in pairs(self.taskVOs) do
		if iter_109_5:getTaskStatus() == 0 then
			table.insert(var_109_0, iter_109_5)
		end
	end

	for iter_109_6, iter_109_7 in pairs(self.taskVOs) do
		if iter_109_7:getTaskStatus() == 2 then
			table.insert(var_109_0, iter_109_7)
		end
	end

	self.taskVOs = var_109_0

	return
end

function ToLoveGameView:updateAwards(arg_110_1, arg_110_2, arg_110_3)
	local var_110_0 = _.slice(arg_110_1, 1, 3)

	for iter_110_0 = arg_110_2.childCount, #var_110_0 - 1 do
		cloneTplTo(arg_110_3, arg_110_2)
	end

	for iter_110_1 = 1, arg_110_2.childCount do
		local var_110_1 = arg_110_2:GetChild(iter_110_1 - 1)
		local var_110_2 = iter_110_1 <= #var_110_0

		setActive(var_110_1, iter_110_1 <= #var_110_0)

		if var_110_2 then
			local var_110_3 = {
				type = var_110_0[iter_110_1][1],
				id = var_110_0[iter_110_1][2],
				count = var_110_0[iter_110_1][3]
			}

			updateDrop(var_110_1, var_110_3)
			onButton(self, var_110_1, function()
				self:emit(BaseUI.ON_DROP, var_110_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function ToLoveGameView:SetTaskColor(arg_112_1, arg_112_2, arg_112_3)
	setText(arg_112_1:Find("frame/desc"), "<color=#" .. arg_112_2 .. ">" .. arg_112_3 .. "</color>")

	return
end

function ToLoveGameView:pauseGame()
	self.gameStop = true

	self:timerStop()

	return
end

function ToLoveGameView:resumeGame()
	self.gameStop = false

	self:timerStart()

	return
end

function ToLoveGameView:UpdateTaskProgress()
	local var_115_0 = getProxy(TaskProxy)

	for iter_115_0 = 1, 7 do
		if ToLoveGameVo.buffIndex == iter_115_0 then
			if var_115_0:getTaskById(self.taskIds[iter_115_0]) then
				pg.m02:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
					progressAdd = 1,
					taskId = self.taskIds[iter_115_0]
				})
			end

			if var_115_0:getTaskById(self.taskIds[iter_115_0 + 7]) then
				self:UpdateTaskScore(self.taskIds[iter_115_0 + 7])
			end

			break
		end
	end

	return
end

function ToLoveGameView:UpdateTaskScore(arg_116_1)
	local var_116_0 = getProxy(TaskProxy):getTaskById(arg_116_1).progress

	if var_116_0 < ToLoveGameVo.score then
		local var_116_1 = 0

		var_116_1 = ToLoveGameVo.score > 2000 and 2000 - var_116_0 or ToLoveGameVo.score - var_116_0

		pg.m02:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
			taskId = arg_116_1,
			progressAdd = var_116_1
		})
	end

	return
end

function ToLoveGameView:changeBgm(arg_117_1)
	local var_117_0

	if arg_117_1 == ToLoveGameConst.bgm_type_default then
		var_117_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_117_1 == ToLoveGameConst.bgm_type_menu then
		var_117_0 = ToLoveGameConst.menu_bgm
	elseif arg_117_1 == ToLoveGameConst.bgm_type_game then
		var_117_0 = ToLoveGameConst.game_bgm
	end

	if self.bgm ~= var_117_0 then
		self.bgm = var_117_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_117_0)
	end

	return
end

function ToLoveGameView:OnApplicationPaused()
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

	return
end

function ToLoveGameView:initEvent()
	if not self.handle and IsUnityEditor then
		self.handle = UpdateBeat:CreateListener(self.Update, self)

		UpdateBeat:AddListener(self.handle)
	end

	return
end

function ToLoveGameView:Update()
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.W) then
			triggerButton(self.gamingUp)
		end

		if Input.GetKeyUp(KeyCode.S) then
			triggerButton(self.gamingDown)
		end

		if Input.GetKeyDown(KeyCode.A) then
			triggerButton(self.gamingLeft)
		end

		if Input.GetKeyUp(KeyCode.D) then
			triggerButton(self.gamingRight)
		end
	end

	return
end

function ToLoveGameView:willExit()
	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	self.timer = nil

	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	return
end

function ToLoveGameView:onBackPressed()
	if self.readyStartFlag then
		return
	end

	if not self.gameStartFlag then
		return
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			self:resumeGame()
			setActive(self.pauseUI, false)
		elseif isActive(self.leaveUI) then
			self:resumeGame()
			setActive(self.leaveUI, false)
		elseif not isActive(self.pauseUI) and not isActive(self.pauseUI) then
			if not ToLoveGameVo.startSettlement then
				self:pauseGame()
				setActive(self.pauseUI, true)
			end
		else
			self:resumeGame()
		end
	end

	return
end

return ToLoveGameView
