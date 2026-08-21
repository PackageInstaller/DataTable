local var_0_0 = class("CutFruitGameView", import("..BaseMiniGameView"))

var_0_0.EVENT_DIRECT = "CutFruitGameView:EVENT_DIRECT"

local var_0_1 = 83

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0._gameVo = CutFruitGameVo.New(var_0_1)

	return
end

function var_0_0.getUIName(arg_2_0)
	return CutFruitGameConst.game_ui
end

function var_0_0.getBGM(arg_3_0)
	return CutFruitGameConst.menu_bgm
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

	arg_5_0:bind(SimpleMGEvent.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
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
	arg_5_0:bind(SimpleMGEvent.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		arg_5_0.popUI:PopLeaveUI()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.STOP_TIME_STEP, function(arg_11_0, arg_11_1, arg_11_2)
		arg_5_0._gameVo:StopTimeStep(arg_11_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.PAUSE_GAME, function(arg_12_0, arg_12_1, arg_12_2)
		if arg_12_1 then
			arg_5_0:pauseGame()
		else
			arg_5_0:resumeGame()
		end

		return
	end)
	arg_5_0:bind(SimpleMGEvent.BACK_MENU, function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_1 and arg_13_1.restart then
			arg_5_0:readyStart(arg_13_1)
		else
			arg_5_0.menuUI:Update(arg_5_0:GetMGHubData())
			arg_5_0.menuUI:Show(true)
			arg_5_0.gameUI:Show(false)
			arg_5_0.popUI:PopSelectUI(true)
			arg_5_0.gameScene:ShowContainer(false)
			arg_5_0:changeBgm(CutFruitGameConst.bgm_type_default)
		end

		return
	end)
	arg_5_0:bind(SimpleMGEvent.CLOSE_GAME, function(arg_14_0, arg_14_1, arg_14_2)
		arg_5_0:closeView()

		return
	end)
	arg_5_0:bind(SimpleMGEvent.GAME_OVER, function(arg_15_0, arg_15_1, arg_15_2)
		arg_5_0:onGameOver(arg_15_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SHOW_RULE, function(arg_16_0, arg_16_1, arg_16_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[CutFruitGameConst.rule_tip].tip
		})

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SHOW_RANK, function(arg_17_0, arg_17_1, arg_17_2)
		arg_5_0:getRankData(arg_5_0._gameVo:GetGameId(), function(arg_18_0)
			arg_5_0.popUI:UpdateRankData(arg_18_0)

			return
		end)
		arg_5_0.popUI:PopRankUI(true)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.READY_START, function(arg_19_0, arg_19_1, arg_19_2)
		arg_5_0:readyStart(arg_19_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.STORE_SERVER, function(arg_20_0, arg_20_1, arg_20_2)
		getProxy(MiniGameProxy):UpdataHighScore(arg_5_0._gameVo:GetGameId(), arg_20_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_21_0, arg_21_1, arg_21_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			arg_5_0:SendSuccess(0)
		end

		return
	end)
	arg_5_0:bind(SimpleMGEvent.ADD_SCORE, function(arg_22_0, arg_22_1, arg_22_2)
		arg_5_0:addScore(arg_22_1.num)

		return
	end)

	return
end

function var_0_0.initUI(arg_23_0)
	arg_23_0.clickMask = findTF(arg_23_0._tf, "clickMask")
	arg_23_0.popUI = CutFruitGamePopUI.New(arg_23_0._tf, arg_23_0, arg_23_0._gameVo)

	arg_23_0.popUI:ClearUI()

	arg_23_0.gameUI = CutFruitGamingUI.New(arg_23_0._tf, arg_23_0, arg_23_0._gameVo)

	arg_23_0.gameUI:Show(false)

	arg_23_0.menuUI = CutFruitGameMenuUI.New(arg_23_0._tf, arg_23_0, arg_23_0._gameVo)

	arg_23_0.menuUI:Update()
	arg_23_0.menuUI:Show(true)
	arg_23_0.popUI:PopSelectUI(true)

	arg_23_0.gameScene = CutFruitGameScene.New(arg_23_0._tf, arg_23_0, arg_23_0._gameVo)

	return
end

function var_0_0.changeBgm(arg_24_0, arg_24_1)
	local var_24_0

	if arg_24_1 == CutFruitGameConst.bgm_type_default then
		var_24_0 = arg_24_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_24_1 == CutFruitGameConst.bgm_type_menu then
		var_24_0 = CutFruitGameConst.menu_bgm
	elseif arg_24_1 == CutFruitGameConst.bgm_type_game then
		var_24_0 = CutFruitGameConst.game_bgm
	end

	if arg_24_0.bgm ~= var_24_0 then
		arg_24_0.bgm = var_24_0

		pg.BgmMgr.GetInstance():Push(arg_24_0.__cname, var_24_0)
	end

	return
end

function var_0_0.OnUpdate(arg_25_0)
	arg_25_0:gameStep()

	return
end

function var_0_0.readyStart(arg_26_0, arg_26_1)
	arg_26_0.readyStartFlag = true

	arg_26_0._gameVo:Prepare()
	arg_26_0.popUI:ReadyStart()
	arg_26_0.menuUI:Show(false)
	arg_26_0.gameUI:Show(false)
	arg_26_0.gameScene:Prepare(arg_26_1)

	return
end

function var_0_0.gameStart(arg_27_0)
	arg_27_0.readyStartFlag = false
	arg_27_0.gameStartFlag = true
	arg_27_0.sendSuccessFlag = false

	arg_27_0.popUI:PopCountUI(false)
	arg_27_0.gameUI:Start()
	arg_27_0.gameUI:Show(true)
	arg_27_0.gameScene:Start()
	arg_27_0:timerStart()
	arg_27_0:changeBgm(CutFruitGameConst.bgm_type_game)

	return
end

function var_0_0.gameStep(arg_28_0)
	if arg_28_0.gameStartFlag and not arg_28_0.gameStop and not arg_28_0.settlementFlag then
		arg_28_0:stepRunTimeData()
		arg_28_0.gameUI:Step()
		arg_28_0.gameScene:Step()

		if arg_28_0._gameVo:GetTime() <= 0 then
			arg_28_0:onGameOver(false)
		end
	end

	if IsUnityEditor then
		if Input.GetKeyDown(KeyCode.A) then
			arg_28_0:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_LEFT)
		end

		if Input.GetKeyDown(KeyCode.D) then
			arg_28_0:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_RIGHT)
		end

		if Input.GetKeyDown(KeyCode.W) then
			arg_28_0:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_UP)
		end

		if Input.GetKeyDown(KeyCode.S) then
			arg_28_0:emit(CutFruitGameView.EVENT_DIRECT, CutFruitGameConst.DIRECT_DOWN)
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

	arg_30_0.gameScene:Resume()

	return
end

function var_0_0.timerStop(arg_31_0)
	arg_31_0.gamestop = true

	arg_31_0.gameScene:Stop()

	return
end

function var_0_0.getRankData(arg_32_0, arg_32_1, arg_32_2)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = arg_32_1,
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

			if arg_32_2 then
				arg_32_2({})
			end

			return
		end
	})

	return
end

function var_0_0.stepRunTimeData(arg_35_0)
	arg_35_0._gameVo:Step(Time.deltaTime)

	return
end

function var_0_0.addScore(arg_36_0, arg_36_1)
	arg_36_0._gameVo:AddScore(arg_36_1)

	return
end

function var_0_0.onGameOver(arg_37_0, arg_37_1)
	if arg_37_0.settlementFlag then
		return
	end

	arg_37_0:timerStop()
	arg_37_0._gameVo:SetSuccess(arg_37_1 and true or false)
	arg_37_0._gameVo:SetSettlement(true)
	arg_37_0.gameScene:GameOver()

	arg_37_0.settlementFlag = true
	arg_37_0.gameStartFlag = false

	setActive(arg_37_0.clickMask, true)
	LeanTween.delayedCall(go(arg_37_0._tf), 1, System.Action(function()
		arg_37_0.settlementFlag = false

		arg_37_0:clearController()
		arg_37_0._gameVo:SetSettlement(false)
		setActive(arg_37_0.clickMask, false)
		arg_37_0.popUI:UpdateSettlementUI()
		arg_37_0.popUI:PopSettlementUI(true)

		return
	end))

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

	return
end

function var_0_0.clearController(arg_40_0)
	arg_40_0.gameScene:Clear()

	return
end

function var_0_0.pauseGame(arg_41_0)
	arg_41_0.gameStop = true

	arg_41_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_42_0)
	arg_42_0.gameStop = false

	arg_42_0:timerStart()

	return
end

function var_0_0.onBackPressed(arg_43_0)
	if not arg_43_0.gameStartFlag and not arg_43_0.settlementFlag and not arg_43_0.readyStartFlag then
		arg_43_0:closeView()
	end

	return
end

function var_0_0.willExit(arg_44_0)
	if arg_44_0.handle then
		UpdateBeat:RemoveListener(arg_44_0.handle)
	end

	if arg_44_0._tf and LeanTween.isTweening(go(arg_44_0._tf)) then
		LeanTween.cancel(go(arg_44_0._tf))
	end

	Time.timeScale = 1

	if arg_44_0._gameVo then
		arg_44_0._gameVo:Clear()

		arg_44_0._gameVo = nil
	end

	return
end

return var_0_0
