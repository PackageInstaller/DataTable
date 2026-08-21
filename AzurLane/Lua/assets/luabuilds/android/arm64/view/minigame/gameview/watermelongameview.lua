local var_0_0 = class("WatermelonGameView", import("..BaseMiniGameView"))
local var_0_1
local var_0_2 = 76

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0._gameVo = WatermelonGameVo.New(var_0_2)
	var_0_1 = arg_1_0._gameVo

	return
end

function var_0_0.getUIName(arg_2_0)
	return WatermelonGameConst.game_ui
end

function var_0_0.getBGM(arg_3_0)
	return WatermelonGameConst.menu_bgm
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()

	return
end

function var_0_0.initEvent(arg_5_0)
	if not arg_5_0.handle then
		arg_5_0.handle = FixedUpdateBeat:CreateListener(arg_5_0.OnUpdate, arg_5_0)

		FixedUpdateBeat:AddListener(arg_5_0.handle)
	end

	arg_5_0:bind(WatermelonGameEvent.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			arg_5_0:resumeGame()
			arg_5_0:onGameOver(false)
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		arg_5_0:gameStart()

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		arg_5_0:emit(BaseUI.ON_HOME)

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		arg_5_0.popUI:popPauseUI()

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_5_0.popUI:popLeaveUI()

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			arg_5_0:pauseGame()
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		arg_5_0.menuUI:update(arg_5_0:GetMGHubData())
		arg_5_0.menuUI:show(true)
		arg_5_0.gameUI:show(false)
		arg_5_0.gameScene:showContainer(false)
		arg_5_0:changeBgm(PipeGameConst.bgm_type_default)

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		arg_5_0:closeView()

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		arg_5_0:onGameOver(arg_14_1)

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[WatermelonGameConst.rule_tip].tip
		})

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		arg_5_0:getRankData()
		arg_5_0.popUI:showRank(true)

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		arg_5_0:readyStart()

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		getProxy(MiniGameProxy):UpdataHighScore(var_0_1.gameId, arg_18_1)

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			arg_5_0:SendSuccess(0)
		end

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.ADD_SCORE, function(arg_20_0, arg_20_1, arg_20_2)
		arg_5_0:addScore(arg_20_1.num)
		arg_5_0.gameUI:addScore(arg_20_1)

		return
	end)
	arg_5_0:bind(WatermelonGameEvent.UPDATE_NEXT_BALL, function(arg_21_0, arg_21_1, arg_21_2)
		arg_5_0.gameUI:updateBallId(arg_21_1)

		return
	end)

	return
end

function var_0_0.initUI(arg_22_0)
	var_0_1:setGameTpl(findTF(arg_22_0._tf, "tpl"))
	setActive(findTF(arg_22_0._tf, "tpl"), false)

	arg_22_0.clickMask = findTF(arg_22_0._tf, "clickMask")
	arg_22_0.popUI = WatermelonGamePopUI.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	arg_22_0.popUI:clearUI()

	arg_22_0.gameUI = WatermelonGamingUI.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	arg_22_0.gameUI:show(false)

	arg_22_0.menuUI = WatermelonGameMenuUI.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	arg_22_0.menuUI:update(arg_22_0:GetMGHubData())
	arg_22_0.menuUI:show(true)

	arg_22_0.gameScene = WatermelonGameScene.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	return
end

function var_0_0.changeBgm(arg_23_0, arg_23_1)
	local var_23_0

	if arg_23_1 == PipeGameConst.bgm_type_default then
		var_23_0 = arg_23_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_menu then
		var_23_0 = WatermelonGameConst.menu_bgm
	elseif arg_23_1 == PipeGameConst.bgm_type_game then
		var_23_0 = WatermelonGameConst.game_bgm
	end

	if arg_23_0.bgm ~= var_23_0 then
		arg_23_0.bgm = var_23_0

		pg.BgmMgr.GetInstance():Push(arg_23_0.__cname, var_23_0)
	end

	return
end

function var_0_0.OnUpdate(arg_24_0)
	arg_24_0:gameStep()

	return
end

function var_0_0.readyStart(arg_25_0)
	arg_25_0.readyStartFlag = true

	var_0_1:prepare()
	arg_25_0.popUI:readyStart()
	arg_25_0.menuUI:show(false)
	arg_25_0.gameUI:show(false)

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

function var_0_0.gameStep(arg_28_0)
	if arg_28_0.gameStartFlag and not arg_28_0.gameStop then
		arg_28_0:stepRunTimeData()
		arg_28_0.gameUI:step(var_0_1.deltaTime)
		arg_28_0.gameScene:step(var_0_1.deltaTime)
		Physics2D.Simulate(var_0_1.deltaTime)
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			arg_28_0.gameUI:press(KeyCode.A, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			arg_28_0.gameUI:press(KeyCode.A, false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			arg_28_0.gameUI:press(KeyCode.D, true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			arg_28_0.gameUI:press(KeyCode.D, false)
		end

		if Input.GetKeyDown(KeyCode.J) then
			arg_28_0.gameUI:press(KeyCode.J, true)
		end
	end

	return
end

function var_0_0.timerStart(arg_29_0)
	arg_29_0.gamestop = false

	return
end

function var_0_0.timerResume(arg_30_0)
	arg_30_0.gamestop = false

	arg_30_0.gameScene:resume()

	return
end

function var_0_0.timerStop(arg_31_0)
	arg_31_0.gamestop = true

	arg_31_0.gameScene:stop()

	return
end

function var_0_0.getRankData(arg_32_0)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = var_0_1.gameId,
		callback = function(arg_33_0)
			for iter_33_0 = 1, #arg_33_0 do
				for iter_33_1, iter_33_2 in pairs(arg_33_0[iter_33_0]) do
					({})[iter_33_1] = iter_33_2
				end

				table.insert({}, {})
			end

			table.sort({}, function(arg_34_0, arg_34_1)
				if arg_34_0.score ~= arg_34_1.score then
					return arg_34_0.score > arg_34_1.score
				elseif arg_34_0.time_data ~= arg_34_1.time_data then
					return arg_34_0.time_data > arg_34_1.time_data
				else
					return arg_34_0.player_id < arg_34_1.player_id
				end

				return
			end)
			arg_32_0.popUI:updateRankData({})

			return
		end
	})

	return
end

function var_0_0.stepRunTimeData(arg_35_0)
	var_0_1.gameTime = var_0_1.gameTime - Time.fixedDeltaTime
	var_0_1.gameStepTime = var_0_1.gameStepTime + Time.fixedDeltaTime
	var_0_1.deltaTime = Time.fixedDeltaTime

	return
end

function var_0_0.addScore(arg_36_0, arg_36_1)
	var_0_1.scoreNum = var_0_1.scoreNum + arg_36_1

	return
end

function var_0_0.onGameOver(arg_37_0, arg_37_1)
	if arg_37_0.settlementFlag then
		return
	end

	arg_37_0:timerStop()
	arg_37_0:clearController()

	arg_37_0.settlementFlag = true

	setActive(arg_37_0.clickMask, true)
	LeanTween.delayedCall(go(arg_37_0._tf), 0.1, System.Action(function()
		arg_37_0.settlementFlag = false
		arg_37_0.gameStartFlag = false

		setActive(arg_37_0.clickMask, false)
		arg_37_0.popUI:updateSettlementUI()
		arg_37_0.popUI:popSettlementUI(true)

		return
	end))
	arg_37_0:emit(BaseMiniGameMediator.GAME_FINISH_TRACKING, {
		game_id = arg_37_0._gameVo.gameId,
		hub_id = arg_37_0._gameVo.hubId,
		isComplete = arg_37_1 and 1 or 0
	})

	return
end

function var_0_0.OnApplicationPaused(arg_39_0)
	if not arg_39_0.gameStartFlag then
		return
	end

	if arg_39_0.readyStartFlag then
		return
	end

	if arg_39_0.settlementFlag then
		return
	end

	arg_39_0:pauseGame()
	arg_39_0.popUI:popPauseUI()

	return
end

function var_0_0.clearController(arg_40_0)
	arg_40_0.gameScene:clear()

	return
end

function var_0_0.pauseGame(arg_41_0)
	arg_41_0.gameStop = true

	arg_41_0:changeSpeed(0)
	arg_41_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_42_0)
	arg_42_0.gameStop = false

	arg_42_0:changeSpeed(1)
	arg_42_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_43_0)
	if arg_43_0.readyStartFlag then
		return
	end

	if not arg_43_0.gameStartFlag then
		return
	else
		if arg_43_0.settlementFlag then
			return
		end

		arg_43_0.popUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_44_0, arg_44_1)
	return
end

function var_0_0.willExit(arg_45_0)
	if arg_45_0.handle then
		FixedUpdateBeat:RemoveListener(arg_45_0.handle)
	end

	if arg_45_0._tf and LeanTween.isTweening(go(arg_45_0._tf)) then
		LeanTween.cancel(go(arg_45_0._tf))
	end

	Time.timeScale = 1

	var_0_1:clear()

	return
end

return var_0_0
