local var_0_0 = class("CastleGameView", import("..BaseMiniGameView"))

var_0_0.LEVEL_GAME = "leavel game"
var_0_0.PAUSE_GAME = "pause game "
var_0_0.OPEN_PAUSE_UI = "open pause ui"
var_0_0.OPEN_LEVEL_UI = "open leave ui"
var_0_0.BACK_MENU = "back menu"
var_0_0.CLOSE_GAME = "close game"
var_0_0.SHOW_RULE = "show rule"
var_0_0.READY_START = "ready start"
var_0_0.COUNT_DOWN = "count down"
var_0_0.STORE_SERVER = "store server"
var_0_0.SUBMIT_GAME_SUCCESS = "submit game success"
var_0_0.ADD_SCORE = "add score"
var_0_0.GAME_OVER = "game over"

function var_0_0.getUIName(arg_1_0)
	return CastleGameVo.game_ui
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initEvent()
	arg_2_0:initUI()
	arg_2_0:initController()

	return
end

function var_0_0.initData(arg_3_0)
	CastleGameVo.Init(arg_3_0:GetMGData().id, arg_3_0:GetMGHubData().id)

	local var_3_0 = CastleGameVo.frameRate

	if CastleGameVo.frameRate > 60 then
		var_3_0 = 60
	end

	arg_3_0.timer = Timer.New(function()
		arg_3_0:onTimer()

		return
	end, 1 / var_3_0, -1)

	return
end

function var_0_0.initEvent(arg_5_0)
	if not arg_5_0.handle and IsUnityEditor then
		arg_5_0.handle = UpdateBeat:CreateListener(arg_5_0.Update, arg_5_0)

		UpdateBeat:AddListener(arg_5_0.handle)
	end

	arg_5_0:bind(var_0_0.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			arg_5_0:resumeGame()
			arg_5_0:onGameOver()
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(var_0_0.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		arg_5_0:gameStart()

		return
	end)
	arg_5_0:bind(var_0_0.OPEN_PAUSE_UI, function(arg_8_0, arg_8_1, arg_8_2)
		arg_5_0.popUI:popPauseUI()

		return
	end)
	arg_5_0:bind(var_0_0.OPEN_LEVEL_UI, function(arg_9_0, arg_9_1, arg_9_2)
		arg_5_0.popUI:popLeaveUI()

		return
	end)
	arg_5_0:bind(var_0_0.PAUSE_GAME, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_1 then
			arg_5_0:pauseGame()
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(var_0_0.BACK_MENU, function(arg_11_0, arg_11_1, arg_11_2)
		arg_5_0.menuUI:update(arg_5_0:GetMGHubData())
		arg_5_0.menuUI:show(true)
		arg_5_0.gameUI:show(false)
		arg_5_0.gameScene:showContainer(false)

		local var_11_0 = arg_5_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

		if arg_5_0.bgm ~= var_11_0 then
			arg_5_0.bgm = var_11_0

			pg.BgmMgr.GetInstance():Push(arg_5_0.__cname, var_11_0)
		end

		return
	end)
	arg_5_0:bind(var_0_0.CLOSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		arg_5_0:closeView()

		return
	end)
	arg_5_0:bind(var_0_0.GAME_OVER, function(arg_13_0, arg_13_1, arg_13_2)
		arg_5_0:onGameOver()

		return
	end)
	arg_5_0:bind(var_0_0.SHOW_RULE, function(arg_14_0, arg_14_1, arg_14_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[CastleGameVo.rule_tip].tip
		})

		return
	end)
	arg_5_0:bind(var_0_0.READY_START, function(arg_15_0, arg_15_1, arg_15_2)
		arg_5_0:readyStart()

		return
	end)
	arg_5_0:bind(var_0_0.STORE_SERVER, function(arg_16_0, arg_16_1, arg_16_2)
		arg_5_0:StoreDataToServer({
			arg_16_1
		})

		return
	end)
	arg_5_0:bind(var_0_0.SUBMIT_GAME_SUCCESS, function(arg_17_0, arg_17_1, arg_17_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			arg_5_0:SendSuccess(0)
		end

		return
	end)
	arg_5_0:bind(var_0_0.ADD_SCORE, function(arg_18_0, arg_18_1, arg_18_2)
		arg_5_0:addScore(arg_18_1.num)
		arg_5_0.gameUI:addScore(arg_18_1)

		return
	end)

	return
end

function var_0_0.initUI(arg_19_0)
	arg_19_0.clickMask = findTF(arg_19_0._tf, "clickMask")
	arg_19_0.popUI = CastleGamePopUI.New(arg_19_0._tf, arg_19_0)

	arg_19_0.popUI:clearUI()

	arg_19_0.gameUI = CastleGamingUI.New(arg_19_0._tf, arg_19_0)
	arg_19_0.menuUI = CastleGameMenuUI.New(arg_19_0._tf, arg_19_0)

	arg_19_0.menuUI:update(arg_19_0:GetMGHubData())
	arg_19_0.menuUI:show(true)

	return
end

function var_0_0.initController(arg_20_0)
	arg_20_0.gameScene = CastleGameScene.New(arg_20_0._tf, arg_20_0)

	return
end

function var_0_0.Update(arg_21_0)
	if arg_21_0.gameStop or arg_21_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.S) then
			arg_21_0.gameUI:press(KeyCode.S, true)
		end

		if Input.GetKeyUp(KeyCode.S) then
			arg_21_0.gameUI:press(KeyCode.S, false)
		end

		if Input.GetKeyDown(KeyCode.W) then
			arg_21_0.gameUI:press(KeyCode.W, true)
		end

		if Input.GetKeyUp(KeyCode.W) then
			arg_21_0.gameUI:press(KeyCode.W, false)
		end

		if Input.GetKeyDown(KeyCode.A) then
			arg_21_0.gameUI:press(KeyCode.A, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			arg_21_0.gameUI:press(KeyCode.A, false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			arg_21_0.gameUI:press(KeyCode.D, true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			arg_21_0.gameUI:press(KeyCode.D, false)
		end
	end

	return
end

function var_0_0.readyStart(arg_22_0)
	arg_22_0.readyStartFlag = true

	CastleGameVo.Prepare()
	arg_22_0.popUI:readyStart()
	arg_22_0.menuUI:show(false)
	arg_22_0.gameUI:show(false)

	return
end

function var_0_0.gameStart(arg_23_0)
	arg_23_0.readyStartFlag = false
	arg_23_0.gameStartFlag = true
	arg_23_0.sendSuccessFlag = false

	arg_23_0.popUI:popCountUI(false)
	arg_23_0.gameUI:start()
	arg_23_0.gameUI:show(true)
	arg_23_0.gameScene:start()
	arg_23_0:timerStart()

	return
end

function var_0_0.changeSpeed(arg_24_0, arg_24_1)
	return
end

function var_0_0.onTimer(arg_25_0)
	arg_25_0:gameStep()

	return
end

function var_0_0.gameStep(arg_26_0)
	arg_26_0:stepRunTimeData()
	arg_26_0.gameScene:step()
	arg_26_0.gameUI:step()

	if CastleGameVo.gameTime <= 0 then
		arg_26_0:onGameOver()
	end

	return
end

function var_0_0.timerStart(arg_27_0)
	if not arg_27_0.timer.running then
		arg_27_0.timer:Start()
	end

	return
end

function var_0_0.timerResume(arg_28_0)
	if not arg_28_0.timer.running then
		arg_28_0.timer:Start()
	end

	arg_28_0.gameScene:resume()

	return
end

function var_0_0.timerStop(arg_29_0)
	if arg_29_0.timer.running then
		arg_29_0.timer:Stop()
	end

	arg_29_0.gameScene:stop()

	return
end

function var_0_0.stepRunTimeData(arg_30_0)
	local var_30_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_30_0 = 0.016
	end

	CastleGameVo.gameTime = CastleGameVo.gameTime - var_30_0
	CastleGameVo.gameStepTime = CastleGameVo.gameStepTime + var_30_0
	CastleGameVo.deltaTime = var_30_0

	return
end

function var_0_0.addScore(arg_31_0, arg_31_1)
	CastleGameVo.scoreNum = CastleGameVo.scoreNum + arg_31_1

	return
end

function var_0_0.onGameOver(arg_32_0)
	if arg_32_0.settlementFlag then
		return
	end

	arg_32_0:timerStop()
	arg_32_0:clearController()

	arg_32_0.settlementFlag = true

	setActive(arg_32_0.clickMask, true)
	LeanTween.delayedCall(go(arg_32_0._tf), 0.1, System.Action(function()
		arg_32_0.settlementFlag = false
		arg_32_0.gameStartFlag = false

		setActive(arg_32_0.clickMask, false)
		arg_32_0.popUI:updateSettlementUI()
		arg_32_0.popUI:popSettlementUI(true)

		return
	end))

	return
end

function var_0_0.OnApplicationPaused(arg_34_0)
	if not arg_34_0.gameStartFlag then
		return
	end

	if arg_34_0.readyStartFlag then
		return
	end

	if arg_34_0.settlementFlag then
		return
	end

	arg_34_0:pauseGame()
	arg_34_0.popUI:popPauseUI()

	return
end

function var_0_0.clearController(arg_35_0)
	arg_35_0.gameScene:clear()

	return
end

function var_0_0.pauseGame(arg_36_0)
	arg_36_0.gameStop = true

	arg_36_0:changeSpeed(0)
	arg_36_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_37_0)
	arg_37_0.gameStop = false

	arg_37_0:changeSpeed(1)
	arg_37_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_38_0)
	if arg_38_0.readyStartFlag then
		return
	end

	if not arg_38_0.gameStartFlag then
		arg_38_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_38_0.settlementFlag then
			return
		end

		arg_38_0.popUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_39_0, arg_39_1)
	return
end

function var_0_0.willExit(arg_40_0)
	if arg_40_0.handle then
		UpdateBeat:RemoveListener(arg_40_0.handle)
	end

	if arg_40_0._tf and LeanTween.isTweening(go(arg_40_0._tf)) then
		LeanTween.cancel(go(arg_40_0._tf))
	end

	if arg_40_0.timer and arg_40_0.timer.running then
		arg_40_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_40_0.timer = nil

	return
end

return var_0_0
