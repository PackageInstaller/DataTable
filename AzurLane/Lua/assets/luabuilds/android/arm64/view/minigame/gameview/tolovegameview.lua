local var_0_0 = class("ToLoveGameView", import("..BaseMiniGameView"))
local var_0_1 = import("view.miniGame.gameView.ToLoveGame.ToLoveGameVo")

function var_0_0.getUIName(arg_1_0)
	return "ToLoveGameUI"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:initEvent()
	arg_2_0:changeBgm(ToLoveGameConst.bgm_type_menu)

	return
end

function var_0_0.initData(arg_3_0)
	var_0_1.Init(arg_3_0:GetMGData().id, arg_3_0:GetMGHubData().id)

	local var_3_0 = var_0_1.frameRate

	if var_0_1.frameRate > 60 then
		var_3_0 = 60
	end

	arg_3_0.timer = Timer.New(function()
		arg_3_0:onTimer()

		return
	end, 1 / var_3_0, -1)

	arg_3_0:GetTaskData()

	return
end

function var_0_0.initUI(arg_5_0)
	arg_5_0:initMenuUI()
	arg_5_0:initGamingUI()
	arg_5_0:initPopUI()

	arg_5_0.clickMask = arg_5_0._tf:Find("clickMask")

	return
end

function var_0_0.initMenuUI(arg_6_0)
	arg_6_0.menuUI = arg_6_0._tf:Find("ui/menuUI")
	arg_6_0.menuBack = arg_6_0.menuUI:Find("btnBack")
	arg_6_0.menuHome = arg_6_0.menuUI:Find("btnHome")
	arg_6_0.menuHighestScoreText = arg_6_0.menuUI:Find("highestScore/Text")
	arg_6_0.menuRule = arg_6_0.menuUI:Find("btnRule")
	arg_6_0.menuStart = arg_6_0.menuUI:Find("btnStart")
	arg_6_0.menuRank = arg_6_0.menuUI:Find("btnRank")
	arg_6_0.menuBuff = arg_6_0.menuUI:Find("btnBuff")
	arg_6_0.menuTask = arg_6_0.menuUI:Find("btnTask")
	arg_6_0.menuLastTimesText = arg_6_0.menuUI:Find("lastTimes/desc")
	arg_6_0.menuAwardList = UIItemList.New(arg_6_0.menuUI:Find("awardsScrollView/Viewport/Content"), arg_6_0.menuUI:Find("awardsScrollView/Viewport/Content/award"))
	arg_6_0.menuStartTip = arg_6_0.menuStart:Find("tip")
	arg_6_0.menuBuffTip = arg_6_0.menuBuff:Find("tip")
	arg_6_0.menuTaskTip = arg_6_0.menuTask:Find("tip")

	setText(arg_6_0.menuUI:Find("awards/Text"), i18n("tolovegame_join_reward"))
	arg_6_0.menuUI:Find("title"):GetComponent(typeof(Image)):SetNativeSize()
	arg_6_0.menuUI:Find("desc"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_6_0.menuUI, true)
	onButton(arg_6_0, arg_6_0.menuBack, function()
		arg_6_0:closeView()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.menuHome, function()
		arg_6_0:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	if arg_6_0:GetMGHubData().highScores[var_0_1.game_id] and arg_6_0:GetMGHubData().highScores[var_0_1.game_id][1] then
		var_0_1.highestScore = arg_6_0:GetMGHubData().highScores[var_0_1.game_id][1]
	end

	setText(arg_6_0.menuHighestScoreText, var_0_1.highestScore)
	onButton(arg_6_0, arg_6_0.menuRule, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[ToLoveGameConst.rule_tip].tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.menuStart, function()
		arg_6_0:readyStart()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.menuRank, function()
		setActive(arg_6_0.menuUI, false)
		arg_6_0:ShowRank()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.menuBuff, function()
		setActive(arg_6_0.menuUI, false)
		arg_6_0:ShowBuff()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.menuTask, function()
		setActive(arg_6_0.menuUI, false)
		arg_6_0:ShowTask()

		return
	end, SFX_PANEL)
	setText(arg_6_0.menuLastTimesText, arg_6_0:GetMGHubData().count)
	arg_6_0:UpdateMenuAwardList()
	setActive(arg_6_0.menuStartTip, arg_6_0:GetMGHubData().count > 0)
	setActive(arg_6_0.menuBuffTip, arg_6_0:ShouldShowBuffTip())
	setActive(arg_6_0.menuTaskTip, arg_6_0.canGetAward)

	return
end

function var_0_0.UpdateMenuAwardList(arg_14_0)
	arg_14_0.menuAwardList:make(function(arg_15_0, arg_15_1, arg_15_2)
		updateDrop(arg_15_2, {
			type = var_0_1.drop[arg_15_1 + 1][1],
			id = var_0_1.drop[arg_15_1 + 1][2],
			count = var_0_1.drop[arg_15_1 + 1][3]
		})
		onButton(arg_14_0, arg_15_2, function()
			arg_14_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_15_0 = arg_14_0:GetMGHubData().usedtime

		setActive(arg_15_2:Find("lock"), arg_15_1 + 1 > arg_14_0:GetMGHubData().count + var_15_0)
		setActive(arg_15_2:Find("got"), var_15_0 >= arg_15_1 + 1)

		return
	end)
	arg_14_0.menuAwardList:align(#var_0_1.drop)

	return
end

function var_0_0.ShouldShowBuffTip(arg_17_0)
	arg_17_0.unlockBuffCount = 0

	for iter_17_0, iter_17_1 in ipairs((var_0_1.GetBuffList(arg_17_0:GetMGHubData()))) do
		if iter_17_1[3] == "" then
			arg_17_0.unlockBuffCount = arg_17_0.unlockBuffCount + 1
		end
	end

	if arg_17_0.unlockBuffCount ~= PlayerPrefs.GetInt("toLoveGameBuffCount", 0) then
		return true
	end

	return false
end

function var_0_0.initGamingUI(arg_18_0)
	arg_18_0.gamingUI = arg_18_0._tf:Find("ui/gamingUI")
	arg_18_0.gamingBack = arg_18_0.gamingUI:Find("back")
	arg_18_0.gamingPause = arg_18_0.gamingUI:Find("pause")
	arg_18_0.gamingScoreText = arg_18_0.gamingUI:Find("bgScore/score")
	arg_18_0.gamingTimeText = arg_18_0.gamingUI:Find("bgTime/time")
	arg_18_0.gamingBuff = arg_18_0.gamingUI:Find("buff")
	arg_18_0.gamingOperationArea = arg_18_0.gamingUI:Find("operationArea")
	arg_18_0.gamingUp = arg_18_0.gamingUI:Find("operationArea/up")
	arg_18_0.gamingDown = arg_18_0.gamingUI:Find("operationArea/down")
	arg_18_0.gamingLeft = arg_18_0.gamingUI:Find("operationArea/left")
	arg_18_0.gamingRight = arg_18_0.gamingUI:Find("operationArea/right")
	arg_18_0.gamingMap = arg_18_0.gamingUI:Find("map")

	setActive(arg_18_0.gamingUI, false)
	setActive(arg_18_0.gamingOperationArea, false)
	onButton(arg_18_0, arg_18_0.gamingBack, function()
		if not var_0_1.startSettlement then
			arg_18_0:pauseGame()
			setActive(arg_18_0.leaveUI, true)
			setActive(arg_18_0.gamingBack, false)
			setActive(arg_18_0.gamingPause, false)
			setActive(arg_18_0.gamingOperationArea, false)
			setActive(arg_18_0.gamingBuff, false)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.gamingPause, function()
		if not var_0_1.startSettlement then
			arg_18_0:pauseGame()
			setActive(arg_18_0.pauseUI, true)
			setActive(arg_18_0.gamingBack, false)
			setActive(arg_18_0.gamingPause, false)
			setActive(arg_18_0.gamingOperationArea, false)
			setActive(arg_18_0.gamingBuff, false)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.gamingUp, function()
		if var_0_1.canMove then
			var_0_1.canMove = false

			arg_18_0:OperateMapPlayer(function(arg_22_0)
				local var_22_9000
				local var_22_0 = arg_22_0:Find("player").GetComponent(var_22_9000, typeof(Animator))
				local var_22_1 = arg_22_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_22_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_22_2 = var_0_1.currentPlayerPosition[1] - 1

				if var_0_1.currentPlayerPosition[1] - 1 == 0 then
					var_22_2 = 5
				end

				arg_18_0:OperateMap(ToLoveGameConst.map[var_22_2][var_0_1.currentPlayerPosition[2]], function(arg_23_0)
					arg_23_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, -86)

					return
				end)
				arg_22_0:Find("player"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					var_22_1:SetEndEvent(nil)
					arg_18_0:OperateMapPlayer(function(arg_25_0)
						setActive(arg_25_0:Find("player"), false)

						return
					end)

					var_0_1.currentPlayerPosition[1] = var_22_2

					arg_18_0:OperateMapPlayer(function(arg_26_0)
						setActive(arg_26_0:Find("player"), true)
						setActive(arg_26_0:Find("player/arrow"), false)
						setActive(arg_26_0:Find("player/happy"), false)
						setActive(arg_26_0:Find("player/sad"), false)

						if var_0_1.shieldCount > 0 then
							setActive(arg_26_0:Find("player/shield"), true)
						else
							setActive(arg_26_0:Find("player/shield"), false)
						end

						arg_26_0:Find("player"):GetComponent(typeof(Animator)):Play("playerDownBack")

						return
					end)

					return
				end)
				var_22_0:Play("playerUp")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.gamingDown, function()
		if var_0_1.canMove then
			var_0_1.canMove = false

			arg_18_0:OperateMapPlayer(function(arg_28_0)
				local var_28_9000
				local var_28_0 = arg_28_0:Find("player").GetComponent(var_28_9000, typeof(Animator))
				local var_28_1 = arg_28_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_28_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_28_2 = var_0_1.currentPlayerPosition[1] + 1

				if var_0_1.currentPlayerPosition[1] + 1 == 6 then
					var_28_2 = 1
				end

				arg_18_0:OperateMap(ToLoveGameConst.map[var_28_2][var_0_1.currentPlayerPosition[2]], function(arg_29_0)
					arg_29_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 86)

					return
				end)
				arg_28_0:Find("player"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					var_28_1:SetEndEvent(nil)
					arg_18_0:OperateMapPlayer(function(arg_31_0)
						setActive(arg_31_0:Find("player"), false)

						return
					end)

					var_0_1.currentPlayerPosition[1] = var_28_2

					arg_18_0:OperateMapPlayer(function(arg_32_0)
						setActive(arg_32_0:Find("player"), true)
						setActive(arg_32_0:Find("player/arrow"), false)
						setActive(arg_32_0:Find("player/happy"), false)
						setActive(arg_32_0:Find("player/sad"), false)

						if var_0_1.shieldCount > 0 then
							setActive(arg_32_0:Find("player/shield"), true)
						else
							setActive(arg_32_0:Find("player/shield"), false)
						end

						arg_32_0:Find("player"):GetComponent(typeof(Animator)):Play("playerUpBack")

						return
					end)

					return
				end)
				var_28_0:Play("playerDown")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.gamingLeft, function()
		if var_0_1.canMove then
			var_0_1.canMove = false

			arg_18_0:OperateMapPlayer(function(arg_34_0)
				local var_34_9000
				local var_34_0 = arg_34_0:Find("player").GetComponent(var_34_9000, typeof(Animator))
				local var_34_1 = arg_34_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_34_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_34_2 = var_0_1.currentPlayerPosition[2] - 1

				if var_0_1.currentPlayerPosition[2] - 1 == 0 then
					var_34_2 = 5
				end

				arg_18_0:OperateMap(ToLoveGameConst.map[var_0_1.currentPlayerPosition[1]][var_34_2], function(arg_35_0)
					arg_35_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(82.5, 0)

					return
				end)
				arg_34_0:Find("player"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					var_34_1:SetEndEvent(nil)
					arg_18_0:OperateMapPlayer(function(arg_37_0)
						setActive(arg_37_0:Find("player"), false)

						return
					end)

					var_0_1.currentPlayerPosition[2] = var_34_2

					arg_18_0:OperateMapPlayer(function(arg_38_0)
						setActive(arg_38_0:Find("player"), true)
						setActive(arg_38_0:Find("player/arrow"), false)
						setActive(arg_38_0:Find("player/happy"), false)
						setActive(arg_38_0:Find("player/sad"), false)

						if var_0_1.shieldCount > 0 then
							setActive(arg_38_0:Find("player/shield"), true)
						else
							setActive(arg_38_0:Find("player/shield"), false)
						end

						arg_38_0:Find("player"):GetComponent(typeof(Animator)):Play("playerRightBack")

						return
					end)

					return
				end)
				var_34_0:Play("playerLeft")

				return
			end)
		end

		return
	end, SFX_PANEL)
	onButton(arg_18_0, arg_18_0.gamingRight, function()
		if var_0_1.canMove then
			var_0_1.canMove = false

			arg_18_0:OperateMapPlayer(function(arg_40_0)
				local var_40_9000
				local var_40_0 = arg_40_0:Find("player").GetComponent(var_40_9000, typeof(Animator))
				local var_40_1 = arg_40_0:Find("player"):GetComponent(typeof(DftAniEvent))

				arg_40_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

				local var_40_2 = var_0_1.currentPlayerPosition[2] + 1

				if var_0_1.currentPlayerPosition[2] + 1 == 6 then
					var_40_2 = 1
				end

				arg_18_0:OperateMap(ToLoveGameConst.map[var_0_1.currentPlayerPosition[1]][var_40_2], function(arg_41_0)
					arg_41_0:Find("player"):GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(-82.5, 0)

					return
				end)
				arg_40_0:Find("player"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
					var_40_1:SetEndEvent(nil)
					arg_18_0:OperateMapPlayer(function(arg_43_0)
						setActive(arg_43_0:Find("player"), false)

						return
					end)

					var_0_1.currentPlayerPosition[2] = var_40_2

					arg_18_0:OperateMapPlayer(function(arg_44_0)
						setActive(arg_44_0:Find("player"), true)
						setActive(arg_44_0:Find("player/arrow"), false)
						setActive(arg_44_0:Find("player/happy"), false)
						setActive(arg_44_0:Find("player/sad"), false)

						if var_0_1.shieldCount > 0 then
							setActive(arg_44_0:Find("player/shield"), true)
						else
							setActive(arg_44_0:Find("player/shield"), false)
						end

						arg_44_0:Find("player"):GetComponent(typeof(Animator)):Play("playerLeftBack")

						return
					end)

					return
				end)
				var_40_0:Play("playerRight")

				return
			end)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initPopUI(arg_45_0)
	arg_45_0.popUI = arg_45_0._tf:Find("ui/popUI")

	arg_45_0:initCountUI()
	arg_45_0:initSettlementUI()
	arg_45_0:initLeavelUI()
	arg_45_0:initPauseUI()
	arg_45_0:initRankUI()
	arg_45_0:initBuffUI()
	arg_45_0:initTaskUI()

	return
end

function var_0_0.initCountUI(arg_46_0)
	arg_46_0.countUI = arg_46_0.popUI:Find("countUI")
	arg_46_0.count = arg_46_0.countUI:Find("count")
	arg_46_0.countAnimator = arg_46_0.count:GetComponent(typeof(Animator))
	arg_46_0.countDft = arg_46_0.count:GetComponent(typeof(DftAniEvent))

	setActive(arg_46_0.countUI, false)
	arg_46_0.countDft:SetEndEvent(function()
		arg_46_0:gameStart()

		return
	end)

	return
end

function var_0_0.initSettlementUI(arg_48_0)
	arg_48_0.settlementUI = arg_48_0.popUI:Find("settleMentUI")
	arg_48_0.settlementCurrentText = arg_48_0.settlementUI:Find("ad/currentText")
	arg_48_0.settlementHighText = arg_48_0.settlementUI:Find("ad/highText")
	arg_48_0.settlementOverBtn = arg_48_0.settlementUI:Find("ad/btnOver")
	arg_48_0.settlementNew = arg_48_0.settlementUI:Find("ad/new")
	arg_48_0.settlementClose = arg_48_0.settlementUI:Find("ad/btnClose")

	arg_48_0.settlementUI:Find("ad/CurImg"):GetComponent(typeof(Image)):SetNativeSize()
	arg_48_0.settlementUI:Find("ad/HighImg"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_48_0.settlementUI, false)
	onButton(arg_48_0, arg_48_0.settlementOverBtn, function()
		if not arg_48_0.sendSuccessFlag then
			arg_48_0.sendSuccessFlag = true

			arg_48_0:SendSuccess(0)
		end

		setActive(arg_48_0.settlementUI, false)
		setActive(arg_48_0.menuUI, true)
		setActive(arg_48_0.gamingUI, false)
		setText(arg_48_0.menuHighestScoreText, var_0_1.highestScore)
		arg_48_0:GetTaskData()
		setActive(arg_48_0.menuTaskTip, arg_48_0.canGetAward)
		arg_48_0:changeBgm(ToLoveGameConst.bgm_type_menu)

		return
	end, SFX_PANEL)
	onButton(arg_48_0, arg_48_0.settlementClose, function()
		triggerButton(arg_48_0.settlementOverBtn)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initLeavelUI(arg_51_0)
	arg_51_0.leaveUI = arg_51_0.popUI:Find("leaveUI")
	arg_51_0.leaveOkBtn = arg_51_0.leaveUI:Find("ad/btnOk")
	arg_51_0.leaveCancelBtn = arg_51_0.leaveUI:Find("ad/btnCancel")
	arg_51_0.leaveClose = arg_51_0.leaveUI:Find("ad/btnClose")

	arg_51_0.leaveUI:Find("ad/desc"):GetComponent(typeof(Image)):SetNativeSize()
	arg_51_0.leaveUI:Find("ad/desc2"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_51_0.leaveUI, false)
	onButton(arg_51_0, arg_51_0.leaveOkBtn, function()
		setActive(arg_51_0.leaveUI, false)
		arg_51_0:resumeGame()
		arg_51_0:onGameOver()

		return
	end, SFX_PANEL)
	onButton(arg_51_0, arg_51_0.leaveCancelBtn, function()
		setActive(arg_51_0.leaveUI, false)
		setActive(arg_51_0.gamingBack, true)
		setActive(arg_51_0.gamingPause, true)

		if var_0_1.playerMoveFlag then
			setActive(arg_51_0.gamingOperationArea, true)
		end

		setActive(arg_51_0.gamingBuff, true)
		arg_51_0:resumeGame()

		return
	end, SFX_PANEL)
	onButton(arg_51_0, arg_51_0.leaveClose, function()
		triggerButton(arg_51_0.leaveCancelBtn)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initPauseUI(arg_55_0)
	arg_55_0.pauseUI = arg_55_0.popUI:Find("pauseUI")
	arg_55_0.pauseOkBtn = arg_55_0.pauseUI:Find("ad/btnOk")
	arg_55_0.pauseClose = arg_55_0.pauseUI:Find("ad/btnClose")

	arg_55_0.pauseUI:Find("ad/desc"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_55_0.pauseUI, false)
	onButton(arg_55_0, arg_55_0.pauseOkBtn, function()
		setActive(arg_55_0.pauseUI, false)
		setActive(arg_55_0.gamingBack, true)
		setActive(arg_55_0.gamingPause, true)

		if var_0_1.playerMoveFlag then
			setActive(arg_55_0.gamingOperationArea, true)
		end

		setActive(arg_55_0.gamingBuff, true)
		arg_55_0:resumeGame()

		return
	end, SFX_PANEL)
	onButton(arg_55_0, arg_55_0.pauseClose, function()
		triggerButton(arg_55_0.pauseOkBtn)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initRankUI(arg_58_0)
	arg_58_0.rankUI = arg_58_0.popUI:Find("rankUI")
	arg_58_0.rankCloseBtn = arg_58_0.rankUI:Find("ad/btnClose")
	arg_58_0.rankPlayerList = UIItemList.New(arg_58_0.rankUI:Find("ad/Scroll View/Viewport/Content"), arg_58_0.rankUI:Find("ad/Scroll View/Viewport/Content/playerTpl"))
	arg_58_0.rankMyself = arg_58_0.rankUI:Find("ad/myself")
	arg_58_0.rankDesc = arg_58_0.rankUI:Find("ad/desc")

	setText(arg_58_0.rankUI:Find("ad/score"), i18n("tolovegame_score"))
	setText(arg_58_0.rankUI:Find("ad/desc"), i18n("tolovegame_rank_tip"))
	arg_58_0.rankUI:Find("ad/bg/titleBg/title"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_58_0.rankUI, false)
	onButton(arg_58_0, arg_58_0.rankCloseBtn, function()
		setActive(arg_58_0.rankUI, false)
		setActive(arg_58_0.menuUI, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initBuffUI(arg_60_0)
	arg_60_0.buffUI = arg_60_0.popUI:Find("buffUI")
	arg_60_0.buffCloseBtn = arg_60_0.buffUI:Find("ad/btnClose")
	arg_60_0.buffList = UIItemList.New(arg_60_0.buffUI:Find("ad/Scroll View/Viewport/Content"), arg_60_0.buffUI:Find("ad/Scroll View/Viewport/Content/buff"))

	arg_60_0.buffUI:Find("ad/bg/titleBg/title"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_60_0.buffUI, false)
	onButton(arg_60_0, arg_60_0.buffCloseBtn, function()
		setActive(arg_60_0.buffUI, false)
		setActive(arg_60_0.menuUI, true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.initTaskUI(arg_62_0)
	arg_62_0.taskUI = arg_62_0.popUI:Find("taskUI")
	arg_62_0.taskCloseBtn = arg_62_0.taskUI:Find("ad/btnClose")
	arg_62_0.taskTasklist = UIItemList.New(arg_62_0.taskUI:Find("ad/Scroll View/Viewport/Content"), arg_62_0.taskUI:Find("ad/Scroll View/Viewport/Content/Tasktpl"))

	arg_62_0.taskUI:Find("ad/bg/titleBg/title"):GetComponent(typeof(Image)):SetNativeSize()
	setActive(arg_62_0.taskUI, false)
	onButton(arg_62_0, arg_62_0.taskCloseBtn, function()
		setActive(arg_62_0.taskUI, false)
		setActive(arg_62_0.menuUI, true)
		arg_62_0:GetTaskData()
		setActive(arg_62_0.menuTaskTip, arg_62_0.canGetAward)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.onTimer(arg_64_0)
	arg_64_0:stepRunTimeData()
	arg_64_0:TimeStep(var_0_1.deltaTime)
	arg_64_0:ShowArrowAndPlayerMove()

	if var_0_1.gameTime <= 0 then
		if var_0_1.buffIndex == 6 then
			if math.random() >= 0.5 then
				var_0_1.gameTime = var_0_1.gameTime + ToLoveGameConst.addTime
			else
				arg_64_0:onGameOver()
			end
		else
			arg_64_0:onGameOver()
		end
	end

	return
end

function var_0_0.stepRunTimeData(arg_65_0)
	local var_65_0 = Time.deltaTime

	if not var_0_1.startSettlement then
		var_0_1.gameTime = var_0_1.gameTime - var_65_0

		if var_0_1.gameTime < 0 then
			var_0_1.gameTime = 0
		end

		var_0_1.gameStepTime = var_0_1.gameStepTime + var_65_0

		if (var_0_1.showArrowFlag or var_0_1.playerMoveFlag) and var_0_1.gameStepTime >= ToLoveGameConst.motionTime then
			var_0_1.gameStepTime = var_0_1.gameStepTime - ToLoveGameConst.motionTime

			var_0_1.ChangeMotion()
		end

		if var_0_1.waitingFlag and var_0_1.gameStepTime >= ToLoveGameConst.waitingTime then
			var_0_1.gameStepTime = var_0_1.gameStepTime - ToLoveGameConst.waitingTime

			var_0_1.ChangeMotion()
		end

		var_0_1.gameArrowTime = var_0_1.gameArrowTime + var_65_0
		var_0_1.gameMoveTime = var_0_1.gameMoveTime + var_65_0
		var_0_1.gameBombTime = var_0_1.gameBombTime + var_65_0

		if var_0_1.bombBlast then
			var_0_1.gameBombBlastTime = var_0_1.gameBombBlastTime + var_65_0
		end
	end

	var_0_1.deltaTime = var_65_0

	return
end

function var_0_0.TimeStep(arg_66_0, arg_66_1)
	local var_66_0 = math.floor(var_0_1.gameTime)

	setText(arg_66_0.gamingTimeText, string.format("%02d", (math.floor(var_66_0 / 60))) .. "  :  " .. string.format("%02d", var_66_0 % 60))

	return
end

function var_0_0.ShowArrowAndPlayerMove(arg_67_0)
	if var_0_1.showArrowFlag then
		if not var_0_1.hasDone then
			var_0_1.hasDone = true

			setActive(arg_67_0.gamingOperationArea, false)
		end

		if var_0_1.gameArrowTime >= var_0_1.doTime then
			var_0_1.gameArrowTime = var_0_1.gameArrowTime - var_0_1.doTime

			arg_67_0:OperateMapPlayer(function(arg_68_0)
				setActive(arg_68_0:Find("player/arrow"), true)
				arg_67_0:ShowArraw(arg_68_0:Find("player/arrow"), var_0_1.arrowList[var_0_1.nowArrowIndex])

				var_0_1.nowArrowIndex = var_0_1.nowArrowIndex + 1

				return
			end)
		end
	elseif var_0_1.playerMoveFlag then
		if not var_0_1.hasDone then
			var_0_1.hasDone = true

			setActive(arg_67_0.gamingOperationArea, true)
			arg_67_0:OperateMapPlayer(function(arg_69_0)
				setActive(arg_69_0:Find("player/arrow"), false)

				return
			end)
		end

		if var_0_1.gameMoveTime >= var_0_1.doTime and var_0_1.moveCount > 0 then
			var_0_1.moveCount = var_0_1.moveCount - 1
			var_0_1.gameMoveTime = var_0_1.gameMoveTime - var_0_1.doTime
			var_0_1.canMove = true
		end
	end

	arg_67_0:BombBlast()

	return
end

function var_0_0.ShowArraw(arg_70_0, arg_70_1, arg_70_2)
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

	if var_0_1.arrowVideoCount > 0 then
		var_0_1.arrowVideoCount = var_0_1.arrowVideoCount - 1

		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-di")
	end

	return
end

function var_0_0.BombBlast(arg_71_0)
	if var_0_1.nowBombIndex <= #var_0_1.safeList and var_0_1.gameBombTime >= var_0_1.doTime then
		var_0_1.gameBombTime = var_0_1.gameBombTime - var_0_1.doTime
		var_0_1.safeCellPosition = var_0_1.GetSafeCellPosition(var_0_1.safeList[var_0_1.nowBombIndex])
		var_0_1.previousPlayerPosition = Clone(var_0_1.currentPlayerPosition)
		var_0_1.nowBombIndex = var_0_1.nowBombIndex + 1
		arg_71_0.isOk = true

		arg_71_0:OperateMapOthers(function(arg_72_0)
			setActive(arg_72_0:Find("bomb"), true)

			if isActive(arg_72_0:Find("player")) then
				arg_71_0.isOk = false
			end

			return
		end, var_0_1.safeCellPosition)
		pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-bomb")

		if arg_71_0.isOk then
			arg_71_0:AddScore()
			setText(arg_71_0.gamingScoreText, var_0_1.score)

			if var_0_1.buffIndex == 4 then
				var_0_1.shieldGetCombo = var_0_1.shieldGetCombo + 1

				if var_0_1.shieldGetCombo == 5 then
					var_0_1.shieldGetCombo = 0

					if var_0_1.shieldCount < 2 then
						var_0_1.shieldCount = var_0_1.shieldCount + 1

						arg_71_0:OperateMapPlayer(function(arg_73_0)
							setActive(arg_73_0:Find("player/shield"), true)

							return
						end)
					end
				end
			end

			arg_71_0:OperateMapPlayer(function(arg_74_0)
				setActive(arg_74_0:Find("player/happy"), true)

				return
			end)
		else
			if var_0_1.shieldCount > 0 then
				var_0_1.combo = 0
				var_0_1.shieldCount = var_0_1.shieldCount - 1

				arg_71_0:OperateMapPlayer(function(arg_75_0)
					if var_0_1.shieldCount > 0 then
						setActive(arg_75_0:Find("player/shield"), true)
					else
						setActive(arg_75_0:Find("player/shield"), false)
					end

					return
				end)
			else
				arg_71_0:onGameOver()
			end

			arg_71_0:OperateMapPlayer(function(arg_76_0)
				setActive(arg_76_0:Find("player/sad"), true)

				return
			end)
		end

		var_0_1.bombBlast = true
	end

	if var_0_1.bombBlast and var_0_1.gameBombBlastTime >= ToLoveGameConst.bombBlastTime then
		var_0_1.bombBlast = false
		var_0_1.gameBombBlastTime = 0

		arg_71_0:OperateMapOthers(function(arg_77_0)
			setActive(arg_77_0:Find("bomb"), false)

			return
		end, var_0_1.safeCellPosition)
	end

	return
end

function var_0_0.readyStart(arg_78_0)
	arg_78_0.readyStartFlag = true

	var_0_1.Prepare()
	setActive(arg_78_0.countUI, true)
	setActive(arg_78_0.menuUI, false)
	setActive(arg_78_0.gamingUI, false)
	arg_78_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1.SFX_COUNT_DOWN)
	arg_78_0:OperateMapAll(function(arg_79_0)
		setActive(arg_79_0:Find("bomb"), false)

		return
	end)

	return
end

function var_0_0.gameStart(arg_80_0)
	arg_80_0.readyStartFlag = false
	arg_80_0.gameStartFlag = true
	arg_80_0.sendSuccessFlag = false

	setActive(arg_80_0.countUI, false)
	setActive(arg_80_0.gamingUI, true)
	arg_80_0:ResetMapAndPlayer()
	arg_80_0:timerStart()
	arg_80_0:changeBgm(ToLoveGameConst.bgm_type_game)
	setText(arg_80_0.gamingScoreText, var_0_1.score)
	arg_80_0:SetGamingBuff()
	setActive(arg_80_0.gamingBack, true)
	setActive(arg_80_0.gamingPause, true)
	setActive(arg_80_0.gamingBuff, true)

	return
end

function var_0_0.ResetMapAndPlayer(arg_81_0)
	for iter_81_0 = 0, arg_81_0.gamingMap.childCount - 1 do
		local var_81_0 = arg_81_0.gamingMap:GetChild(iter_81_0)

		setActive(var_81_0:Find("player/happy"), false)
		setActive(var_81_0:Find("player/sad"), false)

		local var_81_1 = var_81_0:Find("player")

		var_81_1:GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(0, 0)

		if iter_81_0 == ToLoveGameConst.map[var_0_1.currentPlayerPosition[1]][var_0_1.currentPlayerPosition[2]] then
			setActive(var_81_0:Find("player"), true)
			setActive(var_81_0:Find("player/arrow"), false)

			if var_0_1.shieldCount > 0 then
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

function var_0_0.OperateMapAll(arg_82_0, arg_82_1)
	for iter_82_0 = 0, arg_82_0.gamingMap.childCount - 1 do
		arg_82_1((arg_82_0.gamingMap:GetChild(iter_82_0)))
	end

	return
end

function var_0_0.OperateMapPlayer(arg_83_0, arg_83_1)
	for iter_83_0 = 0, arg_83_0.gamingMap.childCount - 1 do
		local var_83_0 = arg_83_0.gamingMap:GetChild(iter_83_0)

		if iter_83_0 == ToLoveGameConst.map[var_0_1.currentPlayerPosition[1]][var_0_1.currentPlayerPosition[2]] then
			arg_83_1(var_83_0)

			break
		end
	end

	return
end

function var_0_0.OperateMapOthers(arg_84_0, arg_84_1, arg_84_2)
	for iter_84_0 = 0, arg_84_0.gamingMap.childCount - 1 do
		local var_84_0 = arg_84_0.gamingMap:GetChild(iter_84_0)

		if iter_84_0 ~= ToLoveGameConst.map[arg_84_2[1]][arg_84_2[2]] then
			arg_84_1(var_84_0)
		end
	end

	return
end

function var_0_0.OperateMap(arg_85_0, arg_85_1, arg_85_2)
	for iter_85_0 = 0, arg_85_0.gamingMap.childCount - 1 do
		local var_85_0 = arg_85_0.gamingMap:GetChild(iter_85_0)

		if iter_85_0 == arg_85_1 then
			arg_85_2(var_85_0)

			break
		end
	end

	return
end

function var_0_0.SetGamingBuff(arg_86_0)
	for iter_86_0 = 1, 7 do
		setActive(arg_86_0.gamingBuff:GetChild(iter_86_0 - 1), var_0_1.buffIndex == iter_86_0)
	end

	return
end

function var_0_0.timerStart(arg_87_0)
	if not arg_87_0.timer.running then
		arg_87_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_88_0)
	if arg_88_0.timer.running then
		arg_88_0.timer:Stop()
	end

	return
end

function var_0_0.AddScore(arg_89_0)
	var_0_1.combo = var_0_1.combo + 1

	local var_89_0 = 100

	for iter_89_0 = #ToLoveGameConst.comboNum, 1, -1 do
		if var_0_1.combo >= ToLoveGameConst.comboNum[iter_89_0] then
			var_89_0 = var_89_0 + ToLoveGameConst.comboAdd[iter_89_0]

			break
		end
	end

	local var_89_1 = var_0_1.GetScoreMultiplyRate()
	local var_89_2 = 1

	if var_0_1.buffIndex == 2 or var_0_1.buffIndex == 7 then
		var_89_2 = 1.2
	elseif var_0_1.buffIndex == 5 then
		var_89_2 = 1.2 + 0.01 * math.floor(var_0_1.combo / 5)
	end

	var_0_1.score = var_0_1.score + math.ceil(var_89_0 * var_89_1 * var_89_2)

	return
end

function var_0_0.onGameOver(arg_90_0)
	if arg_90_0.settlementFlag then
		return
	end

	arg_90_0.settlementFlag = true

	arg_90_0:timerStop()

	var_0_1.startSettlement = true

	setActive(arg_90_0.clickMask, true)
	LeanTween.delayedCall(go(arg_90_0._tf), 0.2, System.Action(function()
		arg_90_0.settlementFlag = false
		arg_90_0.gameStartFlag = false

		setActive(arg_90_0.clickMask, false)
		arg_90_0:ShowSettlementUI()

		return
	end))
	arg_90_0:UpdateTaskProgress()

	return
end

function var_0_0.ShowSettlementUI(arg_92_0)
	setActive(arg_92_0.settlementUI, true)
	setActive(arg_92_0.gamingBack, false)
	setActive(arg_92_0.gamingPause, false)
	setActive(arg_92_0.gamingOperationArea, false)
	setActive(arg_92_0.gamingBuff, false)
	setText(arg_92_0.settlementCurrentText, var_0_1.score)
	setActive(arg_92_0.settlementNew, false)

	if var_0_1.score > var_0_1.highestScore then
		var_0_1.highestScore = var_0_1.score

		setActive(arg_92_0.settlementNew, true)
		getProxy(MiniGameProxy):UpdataHighScore(var_0_1.game_id, {
			var_0_1.highestScore,
			var_0_1.gameTime
		})
	end

	setText(arg_92_0.settlementHighText, var_0_1.highestScore)

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_93_0, arg_93_1)
	if arg_93_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_93_0 = checkExist(var_0_1.story, {
			arg_93_0:GetMGHubData().usedtime
		}, {
			1
		})

		if var_93_0 then
			pg.NewStoryMgr.GetInstance():Play(var_93_0)
		end

		setText(arg_93_0.menuLastTimesText, arg_93_0:GetMGHubData().count)
		setActive(arg_93_0.menuStartTip, arg_93_0:GetMGHubData().count > 0)
		arg_93_0:UpdateMenuAwardList()
	end

	return
end

function var_0_0.ShowRank(arg_94_0)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = var_0_1.game_id,
		callback = function(arg_95_0)
			for iter_95_0 = 1, #arg_95_0 do
				for iter_95_1, iter_95_2 in pairs(arg_95_0[iter_95_0]) do
					({})[iter_95_1] = iter_95_2
				end

				table.insert({}, {})
			end

			table.sort({}, function(arg_96_0, arg_96_1)
				if arg_96_0.score ~= arg_96_1.score then
					return arg_96_0.score > arg_96_1.score
				elseif arg_96_0.time_data ~= arg_96_1.time_data then
					return arg_96_0.time_data > arg_96_1.time_data
				else
					return arg_96_0.player_id < arg_96_1.player_id
				end

				return
			end)
			arg_94_0:SetRankUI({})

			return
		end
	})

	return
end

function var_0_0.SetRankUI(arg_97_0, arg_97_1)
	setActive(arg_97_0.rankUI, true)

	local var_97_0
	local var_97_1 = 0

	arg_97_0.rankPlayerList:make(function(arg_98_0, arg_98_1, arg_98_2)
		local var_98_0 = arg_97_1[arg_98_1 + 1]

		setText(arg_98_2:Find("rank/count"), arg_98_1 + 1)

		if arg_98_1 + 1 == 1 then
			arg_97_0:SetRankColor(arg_98_2, "ea69fd", var_98_0.name, var_98_0.score)
		elseif arg_98_1 + 1 == 2 then
			arg_97_0:SetRankColor(arg_98_2, "11bfff", var_98_0.name, var_98_0.score)
		elseif arg_98_1 + 1 == 3 then
			arg_97_0:SetRankColor(arg_98_2, "51edca", var_98_0.name, var_98_0.score)
		else
			arg_97_0:SetRankColor(arg_98_2, "83919c", var_98_0.name, var_98_0.score)
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
	arg_97_0.rankPlayerList:align(#arg_97_1)
	setText(arg_97_0.rankMyself:Find("nameText"), getProxy(PlayerProxy).data:GetName())

	if nil then
		setText(arg_97_0.rankMyself:Find("rank/count"), var_97_1)

		if var_97_1 == 1 then
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "ea69fd", (nil).name, (nil).score)
		elseif var_97_1 == 2 then
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "11bfff", (nil).name, (nil).score)
		elseif var_97_1 == 3 then
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "51edca", (nil).name, (nil).score)
		else
			arg_97_0:SetRankColor(arg_97_0.rankMyself, "83919c", (nil).name, (nil).score)
		end

		setActive(arg_97_0.rankMyself:Find("1"), var_97_1 == 1)
		setActive(arg_97_0.rankMyself:Find("2"), var_97_1 == 2)
		setActive(arg_97_0.rankMyself:Find("3"), var_97_1 == 3)
		setActive(arg_97_0.rankMyself:Find("rank/1"), var_97_1 == 1)
		setActive(arg_97_0.rankMyself:Find("rank/2"), var_97_1 == 2)
		setActive(arg_97_0.rankMyself:Find("rank/3"), var_97_1 == 3)
	end

	return
end

function var_0_0.SetRankColor(arg_99_0, arg_99_1, arg_99_2, arg_99_3, arg_99_4)
	setText(arg_99_1:Find("nameText"), "<color=#" .. arg_99_2 .. ">" .. arg_99_3 .. "</color>")
	setText(arg_99_1:Find("score"), "<color=#" .. arg_99_2 .. ">" .. arg_99_4 .. "</color>")

	return
end

function var_0_0.ShowBuff(arg_100_0)
	setActive(arg_100_0.buffUI, true)

	local var_100_0 = var_0_1.GetBuffList(arg_100_0:GetMGHubData())

	arg_100_0.buffList:make(function(arg_101_0, arg_101_1, arg_101_2)
		setText(arg_101_2:Find("name"), var_100_0[arg_101_1 + 1][1])
		setText(arg_101_2:Find("desc"), var_100_0[arg_101_1 + 1][2])
		setText(arg_101_2:Find("lock/unlockTime"), var_100_0[arg_101_1 + 1][3])
		setText(arg_101_2:Find("useToggle/onText"), i18n("tolovegame_buff_switch_1"))
		setText(arg_101_2:Find("useToggle/using/offText"), i18n("tolovegame_buff_switch_2"))

		for iter_101_0 = 1, 7 do
			local var_101_0 = arg_101_2:Find("buffImg")

			setActive(var_101_0:GetChild(iter_101_0 - 1), arg_101_1 + 1 == iter_101_0)
		end

		onToggle(arg_100_0, arg_101_2:Find("useToggle"), function(arg_102_0)
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
	arg_100_0.buffList:align(#var_0_1.GetBuffList(arg_100_0:GetMGHubData()))
	PlayerPrefs.SetInt("toLoveGameBuffCount", arg_100_0.unlockBuffCount)
	setActive(arg_100_0.menuBuffTip, arg_100_0:ShouldShowBuffTip())

	return
end

function var_0_0.ShowTask(arg_103_0)
	setActive(arg_103_0.taskUI, true)
	arg_103_0:GetTaskData()
	arg_103_0.taskTasklist:make(function(arg_104_0, arg_104_1, arg_104_2)
		if arg_104_0 == UIItemList.EventUpdate then
			local var_104_0 = arg_103_0.taskVOs[arg_104_1 + 1]
			local var_104_1 = arg_103_0.taskVOs[arg_104_1 + 1]:getConfig("target_num")
			local var_104_2 = math.min(arg_103_0.taskVOs[arg_104_1 + 1]:getProgress(), var_104_1)

			setText(arg_104_2:Find("frame/progress"), var_104_2 .. "/" .. var_104_1)

			arg_104_2:Find("frame/slider"):GetComponent(typeof(Slider)).value = var_104_2 / var_104_1

			setText(arg_104_2:Find("frame/go_btn/Text"), i18n("tolovegame_proceed"))
			setText(arg_104_2:Find("frame/get_btn/Text"), i18n("tolovegame_collect"))
			setText(arg_104_2:Find("frame/got_btn/Text"), i18n("tolovegame_collected"))

			local var_104_3 = arg_104_2:Find("frame/awards")

			arg_103_0:updateAwards(arg_103_0.taskVOs[arg_104_1 + 1]:getConfig("award_display"), var_104_3, (var_104_3:GetChild(0)))

			local var_104_4 = arg_104_2:Find("frame/go_btn")
			local var_104_5 = arg_104_2:Find("frame/get_btn")
			local var_104_6 = arg_104_2:Find("frame/got_btn")
			local var_104_7 = arg_104_2:Find("frame/leftBar")
			local var_104_8 = arg_104_2:Find("frame/leftBarGot")

			if arg_103_0.taskVOs[arg_104_1 + 1]:getTaskStatus() == 0 then
				setActive(var_104_4, true)
				setActive(var_104_5, false)
				setActive(var_104_6, false)
				setActive(var_104_7, true)
				setActive(var_104_8, false)
				arg_103_0:SetTaskColor(arg_104_2, "4de3c2", arg_103_0.taskVOs[arg_104_1 + 1]:getConfig("desc"))
			elseif arg_103_0.taskVOs[arg_104_1 + 1]:getTaskStatus() == 1 then
				setActive(var_104_4, false)
				setActive(var_104_5, true)
				setActive(var_104_6, false)
				setActive(var_104_7, true)
				setActive(var_104_8, false)
				arg_103_0:SetTaskColor(arg_104_2, "4de3c2", arg_103_0.taskVOs[arg_104_1 + 1]:getConfig("desc"))
			elseif arg_103_0.taskVOs[arg_104_1 + 1]:getTaskStatus() == 2 then
				setActive(var_104_4, false)
				setActive(var_104_5, false)
				setActive(var_104_6, true)
				setActive(var_104_7, false)
				setActive(var_104_8, true)
				arg_103_0:SetTaskColor(arg_104_2, "616161", arg_103_0.taskVOs[arg_104_1 + 1]:getConfig("desc"))
			end

			onButton(arg_103_0, var_104_4, function()
				setActive(arg_103_0.taskUI, false)
				arg_103_0:ShowBuff()
				arg_103_0:GetTaskData()
				setActive(arg_103_0.menuTaskTip, arg_103_0.canGetAward)

				return
			end, SFX_PANEL)
			onButton(arg_103_0, var_104_5, function()
				local var_106_0 = var_104_0:getConfig("award_display")
				local var_106_1 = getProxy(PlayerProxy):getRawData()
				local var_106_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
				local var_106_3, var_106_4 = Task.StaticJudgeOverflow(var_106_1.gold, var_106_1.oil, var_106_2, true, true, var_106_0)

				if var_106_3 then
					table.insert({}, function(arg_107_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("award_max_warning"),
							items = var_106_4,
							onYes = arg_107_0
						})

						return
					end)
				end

				seriesAsync({}, function()
					pg.m02:sendNotification(GAME.SUBMIT_TASK, var_104_0.id)

					return
				end)

				return
			end, SFX_PANEL)
		end

		return
	end)
	arg_103_0.taskTasklist:align(#arg_103_0.taskVOs)

	return
end

function var_0_0.GetTaskData(arg_109_0)
	arg_109_0.taskVOs = {}
	arg_109_0.taskIds = getProxy(ActivityProxy):getActivityById(ActivityConst.TOLOVE_MINIGAME_TASK_ID):getConfig("config_client").task_ids

	for iter_109_0, iter_109_1 in pairs(arg_109_0.taskIds) do
		local var_109_0 = getProxy(TaskProxy)

		table.insert(arg_109_0.taskVOs, var_109_0:getTaskVO(iter_109_1))
	end

	arg_109_0.canGetAward = false

	for iter_109_2, iter_109_3 in pairs(arg_109_0.taskVOs) do
		if iter_109_3:getTaskStatus() == 1 then
			table.insert({}, iter_109_3)

			arg_109_0.canGetAward = true
		end
	end

	for iter_109_4, iter_109_5 in pairs(arg_109_0.taskVOs) do
		if iter_109_5:getTaskStatus() == 0 then
			table.insert({}, iter_109_5)
		end
	end

	for iter_109_6, iter_109_7 in pairs(arg_109_0.taskVOs) do
		if iter_109_7:getTaskStatus() == 2 then
			table.insert({}, iter_109_7)
		end
	end

	arg_109_0.taskVOs = {}

	return
end

function var_0_0.updateAwards(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	local var_110_0 = _.slice(arg_110_1, 1, 3)

	for iter_110_0 = arg_110_2.childCount, #var_110_0 - 1 do
		cloneTplTo(arg_110_3, arg_110_2)
	end

	for iter_110_1 = 1, arg_110_2.childCount do
		local var_110_1 = arg_110_2:GetChild(iter_110_1 - 1)
		local var_110_2 = iter_110_1 <= #var_110_0

		setActive(var_110_1, iter_110_1 <= #var_110_0)

		if var_110_2 then
			updateDrop(var_110_1, {
				type = var_110_0[iter_110_1][1],
				id = var_110_0[iter_110_1][2],
				count = var_110_0[iter_110_1][3]
			})
			onButton(arg_110_0, var_110_1, function()
				arg_110_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function var_0_0.SetTaskColor(arg_112_0, arg_112_1, arg_112_2, arg_112_3)
	setText(arg_112_1:Find("frame/desc"), "<color=#" .. arg_112_2 .. ">" .. arg_112_3 .. "</color>")

	return
end

function var_0_0.pauseGame(arg_113_0)
	arg_113_0.gameStop = true

	arg_113_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_114_0)
	arg_114_0.gameStop = false

	arg_114_0:timerStart()

	return
end

function var_0_0.UpdateTaskProgress(arg_115_0)
	local var_115_0 = getProxy(TaskProxy)

	for iter_115_0 = 1, 7 do
		if var_0_1.buffIndex == iter_115_0 then
			if var_115_0:getTaskById(arg_115_0.taskIds[iter_115_0]) then
				pg.m02:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
					progressAdd = 1,
					taskId = arg_115_0.taskIds[iter_115_0]
				})
			end

			if var_115_0:getTaskById(arg_115_0.taskIds[iter_115_0 + 7]) then
				arg_115_0:UpdateTaskScore(arg_115_0.taskIds[iter_115_0 + 7])
			end

			break
		end
	end

	return
end

function var_0_0.UpdateTaskScore(arg_116_0, arg_116_1)
	local var_116_0 = getProxy(TaskProxy):getTaskById(arg_116_1).progress

	if var_116_0 < var_0_1.score then
		local var_116_1 = 0

		var_116_1 = var_0_1.score > 2000 and 2000 - var_116_0 or var_0_1.score - var_116_0

		pg.m02:sendNotification(GAME.MINI_GAME_TASK_PROGRESS_UPDATE, {
			taskId = arg_116_1,
			progressAdd = var_116_1
		})
	end

	return
end

function var_0_0.changeBgm(arg_117_0, arg_117_1)
	local var_117_0

	if arg_117_1 == ToLoveGameConst.bgm_type_default then
		var_117_0 = arg_117_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_117_1 == ToLoveGameConst.bgm_type_menu then
		var_117_0 = ToLoveGameConst.menu_bgm
	elseif arg_117_1 == ToLoveGameConst.bgm_type_game then
		var_117_0 = ToLoveGameConst.game_bgm
	end

	if arg_117_0.bgm ~= var_117_0 then
		arg_117_0.bgm = var_117_0

		pg.BgmMgr.GetInstance():Push(arg_117_0.__cname, var_117_0)
	end

	return
end

function var_0_0.OnApplicationPaused(arg_118_0)
	if not arg_118_0.gameStartFlag then
		return
	end

	if arg_118_0.readyStartFlag then
		return
	end

	if arg_118_0.settlementFlag then
		return
	end

	arg_118_0:pauseGame()

	return
end

function var_0_0.initEvent(arg_119_0)
	if not arg_119_0.handle and IsUnityEditor then
		arg_119_0.handle = UpdateBeat:CreateListener(arg_119_0.Update, arg_119_0)

		UpdateBeat:AddListener(arg_119_0.handle)
	end

	return
end

function var_0_0.Update(arg_120_0)
	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.W) then
			triggerButton(arg_120_0.gamingUp)
		end

		if Input.GetKeyUp(KeyCode.S) then
			triggerButton(arg_120_0.gamingDown)
		end

		if Input.GetKeyDown(KeyCode.A) then
			triggerButton(arg_120_0.gamingLeft)
		end

		if Input.GetKeyUp(KeyCode.D) then
			triggerButton(arg_120_0.gamingRight)
		end
	end

	return
end

function var_0_0.willExit(arg_121_0)
	if arg_121_0.timer and arg_121_0.timer.running then
		arg_121_0.timer:Stop()
	end

	arg_121_0.timer = nil

	if arg_121_0.handle then
		UpdateBeat:RemoveListener(arg_121_0.handle)
	end

	return
end

function var_0_0.onBackPressed(arg_122_0)
	if arg_122_0.readyStartFlag then
		return
	end

	if not arg_122_0.gameStartFlag then
		return
	else
		if arg_122_0.settlementFlag then
			return
		end

		if isActive(arg_122_0.pauseUI) then
			arg_122_0:resumeGame()
			setActive(arg_122_0.pauseUI, false)
		elseif isActive(arg_122_0.leaveUI) then
			arg_122_0:resumeGame()
			setActive(arg_122_0.leaveUI, false)
		elseif not isActive(arg_122_0.pauseUI) and not isActive(arg_122_0.pauseUI) then
			if not var_0_1.startSettlement then
				arg_122_0:pauseGame()
				setActive(arg_122_0.pauseUI, true)
			end
		else
			arg_122_0:resumeGame()
		end
	end

	return
end

return var_0_0
