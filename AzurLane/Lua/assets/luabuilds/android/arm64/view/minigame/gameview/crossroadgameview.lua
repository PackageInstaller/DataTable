local var_0_0 = class("CrossRoadGameView", import("..BaseMiniGameView"))
local var_0_1 = 89

var_0_0.LEAVEL_GAME = "leavel game"
var_0_0.OPEN_LEAVEL_UI = "open leave ui"
var_0_0.SUB_LIFE = "sub life"
var_0_0.ADD_LIFE = "add life"
var_0_0.AGAIN = "reGameAgain"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0._gameVo = CrossRoadGameVo.New(var_0_1)

	return
end

function var_0_0.getUIName(arg_2_0)
	return CrossRoadGameConst.game_ui
end

function var_0_0.getBGM(arg_3_0)
	return CrossRoadGameConst.menu_bgm
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()

	return
end

function var_0_0.initEvent(arg_5_0)
	if not arg_5_0.handle then
		arg_5_0.handle = UpdateBeat:CreateListener(arg_5_0.OnUpdate, arg_5_0)

		UpdateBeat:AddListener(arg_5_0.handle)
	end

	arg_5_0:bind(CrossRoadGameView.LEAVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			arg_5_0:resumeGame()
			arg_5_0:onGameOver(false)
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(SimpleMGEvent.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		arg_5_0:gameStart()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		arg_5_0:emit(BaseUI.ON_HOME)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		arg_5_0.popUI:PopPauseUI()

		return
	end)
	arg_5_0:bind(CrossRoadGameView.OPEN_LEAVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_5_0.popUI:PopLeaveUI()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			arg_5_0:pauseGame()
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(SimpleMGEvent.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		arg_5_0.gameScene:ShowContainer(false)
		arg_5_0:changeBgm(SortGameConst.menu_bgm)
		arg_5_0:closeView()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		arg_5_0:closeView()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SHOW_RULE, function(arg_14_0, arg_14_1, arg_14_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.crossroad_minigame_help.tip
		})

		return
	end)
	arg_5_0:bind(SimpleMGEvent.READY_START, function(arg_15_0, arg_15_1, arg_15_2)
		arg_5_0:readyStart()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.ADD_SCORE, function(arg_16_0, arg_16_1, arg_16_2)
		arg_5_0:addScore(arg_16_1.score)

		return
	end)
	arg_5_0:bind(CrossRoadGameView.SUB_LIFE, function(arg_17_0, arg_17_1, arg_17_2)
		arg_5_0:changeLife(-1)

		return
	end)
	arg_5_0:bind(CrossRoadGameView.ADD_LIFE, function(arg_18_0, arg_18_1, arg_18_2)
		arg_5_0:changeLife(CrossRoadGameConst.HONGCHA_GET_LIFE)

		return
	end)
	arg_5_0:bind(CrossRoadGameView.AGAIN, function(arg_19_0, arg_19_1, arg_19_2)
		arg_5_0:readyStart()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			arg_5_0:SendSuccess(0)
			getProxy(MiniGameProxy):UpdataHighScore(var_0_1, {
				arg_20_1.num,
				arg_20_1.cnt
			})
		end

		return
	end)

	return
end

function var_0_0.initUI(arg_21_0)
	setActive(findTF(arg_21_0._tf, "tpl"), false)

	arg_21_0.clickMask = findTF(arg_21_0._tf, "clickMask")
	arg_21_0.menuUIbg1 = findTF(arg_21_0._tf, "ui/bg")
	arg_21_0.menuUIbg2 = findTF(arg_21_0._tf, "ui/bg_1")
	arg_21_0.popUI = CrossRoadPopUI.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	arg_21_0.popUI:ClearUI()

	arg_21_0.gameUI = CrossRoadGamingUI.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	arg_21_0.gameUI:Show(false)

	arg_21_0.menuUI = CrossRoadMenuUI.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	arg_21_0.menuUI:Update()
	arg_21_0.menuUI:Show(true)
	setActive(arg_21_0.menuUIbg1, true)
	setActive(arg_21_0.menuUIbg2, true)

	arg_21_0.gameScene = CrossRoadScene.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	arg_21_0.gameScene:ShowContainer(true)

	return
end

function var_0_0.changeBgm(arg_22_0, arg_22_1)
	local var_22_0

	if arg_22_1 == PipeGameConst.bgm_type_default then
		var_22_0 = arg_22_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_22_1 == PipeGameConst.bgm_type_menu then
		var_22_0 = CrossRoadGameConst.menu_bgm
	elseif arg_22_1 == PipeGameConst.bgm_type_game then
		var_22_0 = CrossRoadGameConst.game_bgm
	end

	if arg_22_0.bgm ~= var_22_0 then
		arg_22_0.bgm = var_22_0

		pg.BgmMgr.GetInstance():Push(arg_22_0.__cname, var_22_0)
	end

	return
end

function var_0_0.OnUpdate(arg_23_0)
	arg_23_0:gameStep()

	return
end

function var_0_0.readyStart(arg_24_0)
	arg_24_0.readyStartFlag = true

	arg_24_0._gameVo:Prepare()
	arg_24_0.popUI:ReadyStart()
	arg_24_0.menuUI:Show(false)
	arg_24_0.gameUI:Show(false)
	setActive(arg_24_0.menuUIbg1, false)
	setActive(arg_24_0.menuUIbg2, false)
	arg_24_0.gameScene:Prepare()

	return
end

function var_0_0.gameStart(arg_25_0)
	arg_25_0.readyStartFlag = false
	arg_25_0.gameStartFlag = true
	arg_25_0.sendSuccessFlag = false

	arg_25_0.popUI:PopCountUI(false)
	arg_25_0.gameUI:Start()
	arg_25_0.gameUI:Show(true)
	arg_25_0.gameScene:Start()
	arg_25_0:timerStart()
	arg_25_0:changeBgm(PipeGameConst.bgm_type_game)

	return
end

function var_0_0.gameStep(arg_26_0)
	if arg_26_0.gameStartFlag and not arg_26_0.gameStop and not arg_26_0.settlementFlag then
		arg_26_0:stepRunTimeData()
		arg_26_0.gameUI:Step()
		arg_26_0.gameScene:Step()

		if arg_26_0._gameVo:GetTime() <= 0 then
			arg_26_0:onGameOver()
		end
	end

	return
end

function var_0_0.timerStart(arg_27_0)
	arg_27_0.gamestop = false

	return
end

function var_0_0.timerStop(arg_28_0)
	arg_28_0.gamestop = true

	arg_28_0.gameScene:Stop()

	return
end

function var_0_0.stepRunTimeData(arg_29_0)
	arg_29_0._gameVo:Step(Time.deltaTime)

	return
end

function var_0_0.addScore(arg_30_0, arg_30_1)
	arg_30_0._gameVo:AddScore(arg_30_1)

	return
end

function var_0_0.changeLife(arg_31_0, arg_31_1)
	if arg_31_0._gameVo:GetLife() + arg_31_1 <= 0 then
		arg_31_0:onGameOver()

		return
	end

	arg_31_0._gameVo:changeLife(arg_31_1)

	return
end

function var_0_0.onGameOver(arg_32_0, arg_32_1)
	if arg_32_0.settlementFlag then
		return
	end

	arg_32_0:timerStop()
	arg_32_0._gameVo:SetSettlement(true)

	arg_32_0.settlementFlag = true
	arg_32_0.gameStartFlag = false

	setActive(arg_32_0.clickMask, true)
	LeanTween.delayedCall(go(arg_32_0._tf), 0.1, System.Action(function()
		arg_32_0.settlementFlag = false

		arg_32_0:clearController()
		arg_32_0._gameVo:SetSettlement(false)
		setActive(arg_32_0.clickMask, false)
		arg_32_0.popUI:UpdateSettlementUI()
		arg_32_0.popUI:PopSettlementUI(true)

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
	arg_34_0.popUI:PopPauseUI()

	return
end

function var_0_0.clearController(arg_35_0)
	arg_35_0.gameScene:Clear()

	return
end

function var_0_0.pauseGame(arg_36_0)
	arg_36_0.gameStop = true

	arg_36_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_37_0)
	arg_37_0.gameStop = false

	arg_37_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_38_0)
	if arg_38_0.gameStartFlag and not arg_38_0.settlementFlag and not arg_38_0.readyStartFlag then
		arg_38_0.popUI:BackPressed()
	end

	if not arg_38_0.gameStartFlag and not arg_38_0.settlementFlag and not arg_38_0.readyStartFlag then
		arg_38_0.menuUI:Show(false)
		arg_38_0:closeView()
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

	Time.timeScale = 1

	if arg_40_0._gameVo then
		arg_40_0._gameVo:Clear()

		arg_40_0._gameVo = nil
	end

	return
end

return var_0_0
