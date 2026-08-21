local var_0_0 = class("GameRoomPipeView", import("..BaseMiniGameView"))
local var_0_1 = import("view.miniGame.gameView.PipeGame.PipeGameVo")

function var_0_0.getUIName(arg_1_0)
	return var_0_1.game_room_ui
end

function var_0_0.getBGM(arg_2_0)
	return var_0_1.menu_bgm
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:initData()
	arg_3_0:initEvent()
	arg_3_0:initUI()

	return
end

function var_0_0.initData(arg_4_0)
	var_0_1.Init(arg_4_0:GetMGData().id, arg_4_0:GetMGHubData().id)
	var_0_1.SetGameTpl(findTF(arg_4_0._tf, "tpl"))

	local var_4_0 = var_0_1.frameRate

	if var_0_1.frameRate > 60 then
		var_4_0 = 60
	end

	arg_4_0.timer = Timer.New(function()
		arg_4_0:onTimer()

		return
	end, 1 / var_4_0, -1)

	return
end

function var_0_0.initEvent(arg_6_0)
	if not arg_6_0.handle and IsUnityEditor then
		arg_6_0.handle = UpdateBeat:CreateListener(arg_6_0.UpdateBeat, arg_6_0)

		UpdateBeat:AddListener(arg_6_0.handle)
	end

	arg_6_0:bind(PipeGameEvent.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			arg_6_0:resumeGame()
			arg_6_0.gameScene:setGameOver()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(PipeGameEvent.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		arg_6_0:gameStart()

		return
	end)
	arg_6_0:bind(PipeGameEvent.ON_HOME, function(arg_9_0, arg_9_1, arg_9_2)
		arg_6_0:emit(BaseUI.ON_HOME)

		return
	end)
	arg_6_0:bind(PipeGameEvent.OPEN_PAUSE_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_6_0.popUI:popPauseUI()

		return
	end)
	arg_6_0:bind(PipeGameEvent.OPEN_LEVEL_UI, function(arg_11_0, arg_11_1, arg_11_2)
		arg_6_0.popUI:popLeaveUI()

		return
	end)
	arg_6_0:bind(PipeGameEvent.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			arg_6_0:pauseGame()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(PipeGameEvent.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		arg_6_0.menuUI:update(arg_6_0:GetMGHubData())
		arg_6_0.menuUI:show(true)
		arg_6_0.gameUI:show(false)
		arg_6_0.gameScene:showContainer(false)
		arg_6_0:changeBgm(PipeGameConst.bgm_type_default)
		arg_6_0:openCoinLayer(true)

		return
	end)
	arg_6_0:bind(PipeGameEvent.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		arg_6_0:closeView()

		return
	end)
	arg_6_0:bind(PipeGameEvent.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		arg_6_0:onGameOver()

		return
	end)
	arg_6_0:bind(PipeGameEvent.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		arg_6_0:openCoinLayer(not arg_16_1)

		return
	end)
	arg_6_0:bind(PipeGameEvent.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		arg_6_0:getRankData()
		arg_6_0.popUI:showRank(arg_17_1)

		return
	end)
	arg_6_0:bind(PipeGameEvent.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		arg_6_0:readyStart()

		return
	end)
	arg_6_0:bind(PipeGameEvent.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy(MiniGameProxy):UpdataHighScore(var_0_1.game_id, arg_19_1)

		return
	end)
	arg_6_0:bind(PipeGameEvent.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		arg_6_0:SendSuccess(var_0_1.scoreNum)

		return
	end)
	arg_6_0:bind(PipeGameEvent.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		arg_6_0:addScore(arg_21_1.num)
		arg_6_0.gameUI:addScore(arg_21_1)

		return
	end)

	return
end

function var_0_0.initUI(arg_22_0)
	if IsUnityEditor then
		setActive(findTF(arg_22_0._tf, "tpl"), false)
	end

	arg_22_0.clickMask = findTF(arg_22_0._tf, "clickMask")
	arg_22_0.popUI = PipeGamePopUI.New(arg_22_0._tf, arg_22_0)

	arg_22_0.popUI:clearUI()

	arg_22_0.gameUI = PipeGamingUI.New(arg_22_0._tf, arg_22_0)

	arg_22_0.gameUI:show(false)

	arg_22_0.menuUI = PipeGameMenuUI.New(arg_22_0._tf, arg_22_0)

	arg_22_0.menuUI:update(arg_22_0:GetMGHubData())
	arg_22_0.menuUI:setGameRoomUI(arg_22_0:getGameRoomData() and true or false)
	arg_22_0.menuUI:show(true)

	arg_22_0.gameScene = PipeGameScene.New(arg_22_0._tf, arg_22_0)

	return
end

function var_0_0.changeBgm(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_1 == PipeGameConst.bgm_type_default then
		var_23_0 = arg_23_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_menu then
		var_23_0 = var_0_1.menu_bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_game then
		var_23_0 = var_0_1.game_bgm
	end

	if arg_23_0.bgm ~= var_23_0 then
		arg_23_0.bgm = var_23_0

		pg.BgmMgr.GetInstance():Push(arg_23_0.__cname, var_23_0)
	end

	return
end

function var_0_0.UpdateBeat(arg_24_0)
	if arg_24_0.gameStop or arg_24_0.settlementFlag then
		return
	end

	return
end

function var_0_0.readyStart(arg_25_0)
	arg_25_0.readyStartFlag = true

	var_0_1.Prepare()
	arg_25_0.popUI:readyStart()
	arg_25_0.menuUI:show(false)
	arg_25_0.gameUI:show(false)
	arg_25_0:openCoinLayer(false)

	return
end

function var_0_0.gameStart(arg_26_0)
	arg_26_0.readyStartFlag = false
	arg_26_0.gameStartFlag = true
	arg_26_0.sendSuccessFlag = false

	arg_26_0.popUI:popCountUI(false)
	arg_26_0.gameUI:start()
	arg_26_0.gameUI:show(true)
	arg_26_0.gameScene:start()
	arg_26_0:timerStart()
	arg_26_0:changeBgm(PipeGameConst.bgm_type_game)

	return
end

function var_0_0.changeSpeed(arg_27_0, arg_27_1)
	return
end

function var_0_0.onTimer(arg_28_0)
	arg_28_0:gameStep()

	return
end

function var_0_0.gameStep(arg_29_0)
	arg_29_0:stepRunTimeData()
	arg_29_0.gameScene:step(var_0_1.deltaTime)
	arg_29_0.gameUI:step(var_0_1.deltaTime)

	return
end

function var_0_0.timerStart(arg_30_0)
	if not arg_30_0.timer.running then
		arg_30_0.timer:Start()
	end

	return
end

function var_0_0.timerResume(arg_31_0)
	if not arg_31_0.timer.running then
		arg_31_0.timer:Start()
	end

	arg_31_0.gameScene:resume()

	return
end

function var_0_0.timerStop(arg_32_0)
	if arg_32_0.timer.running then
		arg_32_0.timer:Stop()
	end

	arg_32_0.gameScene:stop()

	return
end

function var_0_0.stepRunTimeData(arg_33_0)
	var_0_1.gameTime = var_0_1.gameTime - Time.deltaTime

	if not var_0_1.startSettlement then
		var_0_1.gameDragTime = var_0_1.gameDragTime - Time.deltaTime

		if var_0_1.gameDragTime < 0 then
			var_0_1.gameDragTime = 0
		end
	end

	var_0_1.gameStepTime = var_0_1.gameStepTime + Time.deltaTime
	var_0_1.deltaTime = Time.deltaTime

	return
end

function var_0_0.addScore(arg_34_0, arg_34_1)
	var_0_1.scoreNum = var_0_1.scoreNum + arg_34_1

	return
end

function var_0_0.onGameOver(arg_35_0)
	if arg_35_0.settlementFlag then
		return
	end

	arg_35_0:timerStop()
	arg_35_0:clearController()

	arg_35_0.settlementFlag = true

	setActive(arg_35_0.clickMask, true)
	LeanTween.delayedCall(go(arg_35_0._tf), 0.1, System.Action(function()
		arg_35_0.settlementFlag = false
		arg_35_0.gameStartFlag = false

		setActive(arg_35_0.clickMask, false)
		arg_35_0.popUI:updateSettlementUI()
		arg_35_0.popUI:popSettlementUI(true)

		return
	end))

	return
end

function var_0_0.OnApplicationPaused(arg_37_0)
	if not arg_37_0.gameStartFlag then
		return
	end

	if arg_37_0.readyStartFlag then
		return
	end

	if arg_37_0.settlementFlag then
		return
	end

	arg_37_0:pauseGame()
	arg_37_0.popUI:popPauseUI()

	return
end

function var_0_0.clearController(arg_38_0)
	arg_38_0.gameScene:clear()

	return
end

function var_0_0.pauseGame(arg_39_0)
	arg_39_0.gameStop = true

	arg_39_0:changeSpeed(0)
	arg_39_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_40_0)
	arg_40_0.gameStop = false

	arg_40_0:changeSpeed(1)
	arg_40_0:timerStart()

	return
end

function var_0_0.getRankData(arg_41_0)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = var_0_1.game_id,
		callback = function(arg_42_0)
			for iter_42_0 = 1, #arg_42_0 do
				for iter_42_1, iter_42_2 in pairs(arg_42_0[iter_42_0]) do
					({})[iter_42_1] = iter_42_2
				end

				table.insert({}, {})
			end

			table.sort({}, function(arg_43_0, arg_43_1)
				if arg_43_0.score ~= arg_43_1.score then
					return arg_43_0.score > arg_43_1.score
				elseif arg_43_0.time_data ~= arg_43_1.time_data then
					return arg_43_0.time_data > arg_43_1.time_data
				else
					return arg_43_0.player_id < arg_43_1.player_id
				end

				return
			end)
			arg_41_0.popUI:updateRankData({})

			return
		end
	})

	return
end

function var_0_0.onBackPressed(arg_44_0)
	if arg_44_0.readyStartFlag then
		return
	end

	if not arg_44_0.gameStartFlag then
		return
	else
		if arg_44_0.settlementFlag then
			return
		end

		arg_44_0.popUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_45_0, arg_45_1)
	return
end

function var_0_0.willExit(arg_46_0)
	if arg_46_0.handle then
		UpdateBeat:RemoveListener(arg_46_0.handle)
	end

	if arg_46_0._tf and LeanTween.isTweening(go(arg_46_0._tf)) then
		LeanTween.cancel(go(arg_46_0._tf))
	end

	if arg_46_0.timer and arg_46_0.timer.running then
		arg_46_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_46_0.timer = nil

	var_0_1.Clear()

	return
end

return var_0_0
