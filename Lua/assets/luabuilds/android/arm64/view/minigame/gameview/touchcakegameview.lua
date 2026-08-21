local var_0_0 = class("TouchCakeGameView", import("..BaseMiniGameView"))
local var_0_1 = import("view.miniGame.gameView.TouchCakeGame.TouchCakeGameVo")
local var_0_2 = import("view.miniGame.gameView.TouchCakeGame.TouchCakeGameConst")
local var_0_3 = import("view.miniGame.gameView.TouchCakeGame.TouchCakeGameEvent")

function var_0_0.getUIName(arg_1_0)
	return var_0_1.game_ui
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

	arg_6_0:bind(var_0_3.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			arg_6_0:resumeGame()
			arg_6_0:onGameOver()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(var_0_3.COUNT_DOWN, function(arg_8_0, arg_8_1, arg_8_2)
		arg_6_0:gameStart()

		return
	end)
	arg_6_0:bind(var_0_3.ON_HOME, function(arg_9_0, arg_9_1, arg_9_2)
		arg_6_0:emit(BaseUI.ON_HOME)

		return
	end)
	arg_6_0:bind(var_0_3.OPEN_PAUSE_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_6_0.popUI:popPauseUI()

		return
	end)
	arg_6_0:bind(var_0_3.OPEN_LEVEL_UI, function(arg_11_0, arg_11_1, arg_11_2)
		arg_6_0.popUI:popLeaveUI()

		return
	end)
	arg_6_0:bind(var_0_3.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			arg_6_0:pauseGame()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(var_0_3.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		arg_6_0.gameStop = false

		arg_6_0.gameScene:resume()
		arg_6_0.menuUI:update(arg_6_0:GetMGHubData())
		arg_6_0.menuUI:show(true)
		arg_6_0.gameUI:show(false)
		arg_6_0.gameScene:showContainer(false)
		arg_6_0:changeBgm(var_0_2.bgm_type_default)

		return
	end)
	arg_6_0:bind(var_0_3.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		arg_6_0:closeView()

		return
	end)
	arg_6_0:bind(var_0_3.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		arg_6_0:onGameOver()

		return
	end)
	arg_6_0:bind(var_0_3.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_1.rule_tip].tip
		})

		return
	end)
	arg_6_0:bind(var_0_3.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		arg_6_0:getRankData()
		arg_6_0.popUI:showRank(true)

		return
	end)
	arg_6_0:bind(var_0_3.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		arg_6_0:readyStart()

		return
	end)
	arg_6_0:bind(var_0_3.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy(MiniGameProxy):UpdataHighScore(var_0_1.game_id, arg_19_1)

		return
	end)
	arg_6_0:bind(var_0_3.PRESS_DIRECT, function(arg_20_0, arg_20_1, arg_20_2)
		if arg_6_0.gameScene then
			arg_6_0.gameScene:touchDirect(arg_20_1, true)
		end

		return
	end)
	arg_6_0:bind(var_0_3.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			arg_6_0:SendSuccess(0)
		end

		return
	end)
	arg_6_0:bind(var_0_3.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		arg_6_0:addScore(arg_22_1)
		arg_6_0.gameUI:updateScore()

		return
	end)
	arg_6_0:bind(var_0_3.ADD_COMBO, function(arg_23_0, arg_23_1, arg_23_2)
		arg_6_0:addCombo()
		arg_6_0.gameUI:updateCombo()

		return
	end)
	arg_6_0:bind(var_0_3.PLAYER_DIZZI, function(arg_24_0, arg_24_1, arg_24_2)
		arg_6_0:clearCombo()
		arg_6_0.gameUI:updateCombo()

		return
	end)
	arg_6_0:bind(var_0_3.PLAYER_BOOM, function(arg_25_0, arg_25_1, arg_25_2)
		arg_6_0:clearCombo()
		arg_6_0.gameUI:updateCombo()

		return
	end)

	return
end

function var_0_0.initUI(arg_26_0)
	if IsUnityEditor then
		setActive(findTF(arg_26_0._tf, "tpl"), false)
	end

	arg_26_0.clickMask = findTF(arg_26_0._tf, "clickMask")
	arg_26_0.popUI = TouchCakePopUI.New(arg_26_0._tf, arg_26_0)

	arg_26_0.popUI:clearUI()

	arg_26_0.gameUI = TouchCakeGamingUI.New(arg_26_0._tf, arg_26_0)

	arg_26_0.gameUI:show(false)

	arg_26_0.menuUI = TouchCakeMenuUI.New(arg_26_0._tf, arg_26_0)

	arg_26_0.menuUI:update(arg_26_0:GetMGHubData())
	arg_26_0.menuUI:show(true)

	arg_26_0.gameScene = TouchCakeScene.New(arg_26_0._tf, arg_26_0)

	return
end

function var_0_0.changeBgm(arg_27_0, arg_27_1)
	local var_27_0

	if arg_27_1 == var_0_2.bgm_type_default then
		var_27_0 = arg_27_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_27_1 == var_0_2.bgm_type_menu then
		var_27_0 = var_0_1.menu_bgm
	elseif arg_27_1 == var_0_2.bgm_type_game then
		var_27_0 = var_0_1.game_bgm
	end

	if arg_27_0.bgm ~= var_27_0 then
		arg_27_0.bgm = var_27_0

		pg.BgmMgr.GetInstance():Push(arg_27_0.__cname, var_27_0)
	end

	return
end

function var_0_0.UpdateBeat(arg_28_0)
	if arg_28_0.gameStop or arg_28_0.settlementFlag or not arg_28_0.gameStartFlag then
		return
	end

	if Input.GetKeyDown(KeyCode.A) then
		arg_28_0.gameScene:press(KeyCode.A, true)
	elseif Input.GetKeyDown(KeyCode.D) then
		arg_28_0.gameScene:press(KeyCode.D, true)
	end

	return
end

function var_0_0.readyStart(arg_29_0)
	arg_29_0.readyStartFlag = true

	var_0_1.Prepare()
	arg_29_0.popUI:readyStart()
	arg_29_0.menuUI:show(false)
	arg_29_0.gameUI:show(false)

	return
end

function var_0_0.gameStart(arg_30_0)
	arg_30_0.readyStartFlag = false
	arg_30_0.gameStartFlag = true
	arg_30_0.sendSuccessFlag = false

	arg_30_0.popUI:popCountUI(false)
	arg_30_0.gameUI:start()
	arg_30_0.gameUI:show(true)
	arg_30_0.gameScene:start()
	arg_30_0:timerStart()
	arg_30_0:changeBgm(var_0_2.bgm_type_game)

	return
end

function var_0_0.onTimer(arg_31_0)
	arg_31_0:gameStep()

	return
end

function var_0_0.gameStep(arg_32_0)
	arg_32_0:stepRunTimeData()
	arg_32_0.gameScene:step(var_0_1.deltaTime)
	arg_32_0.gameUI:step(var_0_1.deltaTime)

	if var_0_1.gameTime <= 0 then
		var_0_1.gameTime = 0

		arg_32_0:onGameOver()
	end

	return
end

function var_0_0.timerStart(arg_33_0)
	if not arg_33_0.timer.running then
		arg_33_0.timer:Start()
	end

	return
end

function var_0_0.timerResume(arg_34_0)
	if not arg_34_0.timer.running then
		arg_34_0.timer:Start()
	end

	arg_34_0.gameScene:resume()

	return
end

function var_0_0.timerStop(arg_35_0)
	if arg_35_0.timer.running then
		arg_35_0.timer:Stop()
	end

	return
end

function var_0_0.stepRunTimeData(arg_36_0)
	var_0_1.gameTime = var_0_1.gameTime - Time.deltaTime
	var_0_1.gameStepTime = var_0_1.gameStepTime + Time.deltaTime
	var_0_1.deltaTime = Time.deltaTime

	return
end

function var_0_0.addScore(arg_37_0, arg_37_1)
	var_0_1.scoreNum = var_0_1.scoreNum + arg_37_1

	return
end

function var_0_0.addCombo(arg_38_0)
	var_0_1.comboNum = var_0_1.comboNum + 1

	return
end

function var_0_0.clearCombo(arg_39_0)
	var_0_1.comboNum = 0

	return
end

function var_0_0.onGameOver(arg_40_0)
	if arg_40_0.settlementFlag then
		return
	end

	arg_40_0:pauseGame()
	arg_40_0:clearController()

	arg_40_0.settlementFlag = true

	setActive(arg_40_0.clickMask, true)
	LeanTween.delayedCall(go(arg_40_0._tf), 0.1, System.Action(function()
		arg_40_0.settlementFlag = false
		arg_40_0.gameStartFlag = false

		setActive(arg_40_0.clickMask, false)
		arg_40_0.popUI:updateSettlementUI()
		arg_40_0.popUI:popSettlementUI(true)
		arg_40_0:OnApplicationPaused()

		return
	end))

	return
end

function var_0_0.OnApplicationPaused(arg_42_0)
	if not arg_42_0.gameStartFlag then
		return
	end

	if arg_42_0.readyStartFlag then
		return
	end

	if arg_42_0.settlementFlag then
		return
	end

	arg_42_0:pauseGame()
	arg_42_0.popUI:popPauseUI()

	return
end

function var_0_0.clearController(arg_43_0)
	arg_43_0.gameScene:clear()

	return
end

function var_0_0.pauseGame(arg_44_0)
	arg_44_0.gameStop = true

	arg_44_0.gameScene:stop()
	arg_44_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_45_0)
	arg_45_0.gameStop = false

	arg_45_0.gameScene:resume()
	arg_45_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_46_0)
	if arg_46_0.readyStartFlag then
		return
	end

	if not arg_46_0.gameStartFlag then
		arg_46_0:closeView()

		return
	else
		if arg_46_0.settlementFlag then
			return
		end

		arg_46_0.popUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_47_0, arg_47_1)
	return
end

function var_0_0.getRankData(arg_48_0)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = var_0_1.game_id,
		callback = function(arg_49_0)
			for iter_49_0 = 1, #arg_49_0 do
				for iter_49_1, iter_49_2 in pairs(arg_49_0[iter_49_0]) do
					({})[iter_49_1] = iter_49_2
				end

				table.insert({}, {})
			end

			table.sort({}, function(arg_50_0, arg_50_1)
				if arg_50_0.score ~= arg_50_1.score then
					return arg_50_0.score > arg_50_1.score
				elseif arg_50_0.time_data ~= arg_50_1.time_data then
					return arg_50_0.time_data > arg_50_1.time_data
				else
					return arg_50_0.player_id < arg_50_1.player_id
				end

				return
			end)
			arg_48_0.popUI:updateRankData({})

			return
		end
	})

	return
end

function var_0_0.willExit(arg_51_0)
	if arg_51_0.handle then
		UpdateBeat:RemoveListener(arg_51_0.handle)
	end

	if arg_51_0._tf and LeanTween.isTweening(go(arg_51_0._tf)) then
		LeanTween.cancel(go(arg_51_0._tf))
	end

	if arg_51_0.timer and arg_51_0.timer.running then
		arg_51_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_51_0.timer = nil

	if arg_51_0.gameUI then
		arg_51_0.gameUI:dispose()
	end

	var_0_1.Clear()

	return
end

return var_0_0
