local var_0_0 = class("SailBoatGameView", import("..BaseMiniGameView"))

var_0_0.LEVEL_GAME = "leavel game"
var_0_0.PAUSE_GAME = "pause game "
var_0_0.OPEN_PAUSE_UI = "open pause ui"
var_0_0.OPEN_LEVEL_UI = "open leave ui"
var_0_0.BACK_MENU = "back menu"
var_0_0.OPEN_EQUIP_UI = "open equip ui"
var_0_0.CLOSE_GAME = "close game"
var_0_0.SHOW_RULE = "show rule"
var_0_0.READY_START = "ready start"
var_0_0.COUNT_DOWN = "count down"
var_0_0.STORE_SERVER = "store server"
var_0_0.SUBMIT_GAME_SUCCESS = "submit game success"
var_0_0.ADD_SCORE = "add score"
var_0_0.GAME_OVER = "game over"
var_0_0.USE_SKILL = "use skill"
var_0_0.JOYSTICK_ACTIVE_CHANGE = "joy stick active change"

local var_0_1 = import("view.miniGame.gameView.SailBoatGame.SailBoatGameVo")

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
		arg_6_0.handle = UpdateBeat:CreateListener(arg_6_0.Update, arg_6_0)

		UpdateBeat:AddListener(arg_6_0.handle)
	end

	arg_6_0:bind(var_0_0.LEVEL_GAME, function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_1 then
			arg_6_0:resumeGame()
			arg_6_0:onGameOver()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(var_0_0.USE_SKILL, function(arg_8_0, arg_8_1, arg_8_2)
		arg_6_0.gameScene:useSkill()

		return
	end)
	arg_6_0:bind(var_0_0.COUNT_DOWN, function(arg_9_0, arg_9_1, arg_9_2)
		arg_6_0:gameStart()

		return
	end)
	arg_6_0:bind(var_0_0.OPEN_EQUIP_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_6_0.equipUI:show(true)
		arg_6_0.menuUI:show(false)

		return
	end)
	arg_6_0:bind(var_0_0.OPEN_PAUSE_UI, function(arg_11_0, arg_11_1, arg_11_2)
		arg_6_0.popUI:popPauseUI()

		return
	end)
	arg_6_0:bind(var_0_0.OPEN_LEVEL_UI, function(arg_12_0, arg_12_1, arg_12_2)
		arg_6_0.popUI:popLeaveUI()

		return
	end)
	arg_6_0:bind(var_0_0.PAUSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 then
			arg_6_0:pauseGame()
		else
			arg_6_0:resumeGame()
		end

		return
	end)
	arg_6_0:bind(var_0_0.BACK_MENU, function(arg_14_0, arg_14_1, arg_14_2)
		arg_6_0.menuUI:update(arg_6_0:GetMGHubData())
		arg_6_0.menuUI:show(true)
		arg_6_0.gameUI:show(false)
		arg_6_0.gameScene:showContainer(false)

		local var_14_0 = arg_6_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

		if arg_6_0.bgm ~= var_14_0 then
			arg_6_0.bgm = var_14_0

			pg.BgmMgr.GetInstance():Push(arg_6_0.__cname, var_14_0)
		end

		arg_6_0:initBgAnimation()

		return
	end)
	arg_6_0:bind(var_0_0.CLOSE_GAME, function(arg_15_0, arg_15_1, arg_15_2)
		arg_6_0:closeView()

		return
	end)
	arg_6_0:bind(var_0_0.GAME_OVER, function(arg_16_0, arg_16_1, arg_16_2)
		arg_6_0:onGameOver()

		return
	end)
	arg_6_0:bind(var_0_0.SHOW_RULE, function(arg_17_0, arg_17_1, arg_17_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[var_0_1.rule_tip].tip
		})

		return
	end)
	arg_6_0:bind(var_0_0.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		arg_6_0:readyStart()

		return
	end)
	arg_6_0:bind(var_0_0.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		arg_6_0:StoreDataToServer({
			arg_19_1
		})

		return
	end)
	arg_6_0:bind(var_0_0.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_6_0.sendSuccessFlag then
			arg_6_0.sendSuccessFlag = true

			arg_6_0:SendSuccess(0)
		end

		return
	end)
	arg_6_0:bind(var_0_0.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		arg_6_0:addScore(arg_21_1.num)
		arg_6_0.gameUI:addScore(arg_21_1)

		return
	end)
	arg_6_0:bind(var_0_0.JOYSTICK_ACTIVE_CHANGE, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_6_0.gameStartFlag then
			arg_6_0.gameScene:joystickActive(arg_22_1)
		end

		return
	end)

	return
end

function var_0_0.initUI(arg_23_0)
	if IsUnityEditor then
		setActive(findTF(arg_23_0._tf, "tpl"), false)
	end

	arg_23_0.clickMask = findTF(arg_23_0._tf, "clickMask")
	arg_23_0.popUI = SailBoatGamePopUI.New(arg_23_0._tf, arg_23_0)

	arg_23_0.popUI:clearUI()

	arg_23_0.gameUI = SailBoatGamingUI.New(arg_23_0._tf, arg_23_0)

	arg_23_0.gameUI:show(false)

	arg_23_0.menuUI = SailBoatGameMenuUI.New(arg_23_0._tf, arg_23_0)

	arg_23_0.menuUI:update(arg_23_0:GetMGHubData())
	arg_23_0.menuUI:show(true)

	arg_23_0.equipUI = SailBoatEquipUI.New(arg_23_0._tf, arg_23_0)

	arg_23_0.equipUI:show(false)

	arg_23_0.gameScene = SailBoatGameScene.New(arg_23_0._tf, arg_23_0)

	arg_23_0:initBgAnimation()

	return
end

function var_0_0.initBgAnimation(arg_24_0)
	local var_24_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.BOAT_QIAN_SHAO_ZHAN)
	local var_24_1 = getProxy(TaskProxy)
	local var_24_2 = var_24_0:getConfig("config_data")
	local var_24_3 = var_24_0.data3

	if var_24_1:getFinishTaskById(var_24_2[var_24_0.data3][1]) ~= nil and var_24_1:getFinishTaskById(var_24_2[var_24_3][2]) ~= nil then
		var_24_3 = var_24_3 + 1
	end

	GetComponent(findTF(arg_24_0._tf, "sceneBg/1"), typeof(Animator)):Play(({
		"Phase_00",
		"Phase_01",
		"Phase_02",
		"Phase_03",
		"Phase_04",
		"Phase_05",
		"Phase_06",
		"Phase_07"
	})[var_24_3])

	return
end

function var_0_0.Update(arg_25_0)
	if arg_25_0.gameStop or arg_25_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.S) then
			arg_25_0.gameUI:press(KeyCode.S, true)
		end

		if Input.GetKeyUp(KeyCode.S) then
			arg_25_0.gameUI:press(KeyCode.S, false)
		end

		if Input.GetKeyDown(KeyCode.W) then
			arg_25_0.gameUI:press(KeyCode.W, true)
		end

		if Input.GetKeyUp(KeyCode.W) then
			arg_25_0.gameUI:press(KeyCode.W, false)
		end

		if Input.GetKeyDown(KeyCode.A) then
			arg_25_0.gameUI:press(KeyCode.A, true)
		end

		if Input.GetKeyUp(KeyCode.A) then
			arg_25_0.gameUI:press(KeyCode.A, false)
		end

		if Input.GetKeyDown(KeyCode.D) then
			arg_25_0.gameUI:press(KeyCode.D, true)
		end

		if Input.GetKeyUp(KeyCode.D) then
			arg_25_0.gameUI:press(KeyCode.D, false)
		end

		if Input.GetKeyDown(KeyCode.J) then
			arg_25_0.gameScene:press(KeyCode.J, true)
		end
	end

	return
end

function var_0_0.readyStart(arg_26_0)
	arg_26_0.readyStartFlag = true

	var_0_1.Prepare()
	arg_26_0.popUI:readyStart()
	arg_26_0.menuUI:show(false)
	arg_26_0.gameUI:show(false)
	arg_26_0.equipUI:show(false)
	setActive(findTF(arg_26_0._tf, "sceneBg"), false)

	return
end

function var_0_0.gameStart(arg_27_0)
	arg_27_0.readyStartFlag = false
	arg_27_0.gameStartFlag = true
	arg_27_0.sendSuccessFlag = false

	arg_27_0.popUI:popCountUI(false)
	arg_27_0.gameUI:start()
	arg_27_0.gameUI:show(true)

	if arg_27_0.bgm ~= var_0_1.game_bgm then
		arg_27_0.bgm = var_0_1.game_bgm

		pg.BgmMgr.GetInstance():Push(arg_27_0.__cname, var_0_1.game_bgm)
	end

	arg_27_0.gameScene:start()
	arg_27_0:timerStart()

	return
end

function var_0_0.changeSpeed(arg_28_0, arg_28_1)
	return
end

function var_0_0.onTimer(arg_29_0)
	arg_29_0:gameStep()

	return
end

function var_0_0.gameStep(arg_30_0)
	arg_30_0:stepRunTimeData()
	arg_30_0.gameScene:step(var_0_1.deltaTime)
	arg_30_0.gameUI:step(var_0_1.deltaTime)

	if var_0_1.gameTime <= 0 then
		arg_30_0:onGameOver()
	end

	return
end

function var_0_0.timerStart(arg_31_0)
	if not arg_31_0.timer.running then
		arg_31_0.timer:Start()
	end

	return
end

function var_0_0.timerResume(arg_32_0)
	if not arg_32_0.timer.running then
		arg_32_0.timer:Start()
	end

	arg_32_0.gameScene:resume()

	return
end

function var_0_0.timerStop(arg_33_0)
	if arg_33_0.timer.running then
		arg_33_0.timer:Stop()
	end

	arg_33_0.gameScene:stop()

	return
end

function var_0_0.stepRunTimeData(arg_34_0)
	local var_34_0 = Time.deltaTime

	if Time.deltaTime > 0.016 then
		var_34_0 = 0.016
	end

	var_0_1.gameTime = var_0_1.gameTime - var_34_0
	var_0_1.gameStepTime = var_0_1.gameStepTime + var_34_0
	var_0_1.deltaTime = var_34_0

	local var_34_1 = var_0_1.GetSceneSpeed()

	var_34_1.x = var_0_1.moveAmount.x * var_34_0
	var_34_1.y = var_0_1.moveAmount.y * var_34_0

	var_0_1.SetSceneSpeed(var_34_1)

	return
end

function var_0_0.addScore(arg_35_0, arg_35_1)
	var_0_1.scoreNum = var_0_1.scoreNum + arg_35_1

	return
end

function var_0_0.onGameOver(arg_36_0)
	if arg_36_0.settlementFlag then
		return
	end

	arg_36_0:timerStop()
	arg_36_0:clearController()

	arg_36_0.settlementFlag = true

	setActive(arg_36_0.clickMask, true)
	LeanTween.delayedCall(go(arg_36_0._tf), 0.1, System.Action(function()
		arg_36_0.settlementFlag = false
		arg_36_0.gameStartFlag = false

		setActive(arg_36_0.clickMask, false)
		arg_36_0.popUI:updateSettlementUI()
		arg_36_0.popUI:popSettlementUI(true)

		return
	end))
	setActive(findTF(arg_36_0._tf, "sceneBg"), true)

	return
end

function var_0_0.OnApplicationPaused(arg_38_0)
	if not arg_38_0.gameStartFlag then
		return
	end

	if arg_38_0.readyStartFlag then
		return
	end

	if arg_38_0.settlementFlag then
		return
	end

	arg_38_0:pauseGame()
	arg_38_0.popUI:popPauseUI()

	return
end

function var_0_0.clearController(arg_39_0)
	arg_39_0.gameScene:clear()

	return
end

function var_0_0.pauseGame(arg_40_0)
	arg_40_0.gameStop = true

	arg_40_0:changeSpeed(0)
	arg_40_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_41_0)
	arg_41_0.gameStop = false

	arg_41_0:changeSpeed(1)
	arg_41_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_42_0)
	if arg_42_0.readyStartFlag then
		return
	end

	if not arg_42_0.gameStartFlag then
		arg_42_0:emit(var_0_0.ON_BACK_PRESSED)

		return
	else
		if arg_42_0.settlementFlag then
			return
		end

		arg_42_0.popUI:backPressed()
	end

	return
end

function var_0_0.OnSendMiniGameOPDone(arg_43_0, arg_43_1)
	return
end

function var_0_0.willExit(arg_44_0)
	if arg_44_0.handle then
		UpdateBeat:RemoveListener(arg_44_0.handle)
	end

	if arg_44_0._tf and LeanTween.isTweening(go(arg_44_0._tf)) then
		LeanTween.cancel(go(arg_44_0._tf))
	end

	if arg_44_0.timer and arg_44_0.timer.running then
		arg_44_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_44_0.timer = nil

	var_0_1.Clear()

	return
end

return var_0_0
