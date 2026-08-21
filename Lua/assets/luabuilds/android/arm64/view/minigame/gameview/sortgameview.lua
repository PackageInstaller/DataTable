local var_0_0 = class("SortGameView", import("..BaseMiniGameView"))
local var_0_1 = 84

var_0_0.WANTED_ITEM_REFRESH = "SortGameView:wanted item refresh"
var_0_0.UPDATE_PLAYER = "SortGameView:update player"
var_0_0.PLAYER_SPEAK = "SortGameView:player speak"
var_0_0.GAME_OVER_TIME = "SortGameView:game over time"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0._gameVo = SortGameVo.New(var_0_1)

	return
end

function var_0_0.getUIName(arg_2_0)
	return SortGameConst.game_ui
end

function var_0_0.getBGM(arg_3_0)
	return SortGameConst.menu_bgm
end

function var_0_0.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()
	arg_4_0:readyStart()

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
	arg_5_0:bind(SimpleMGEvent.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		arg_5_0:onGameOver(arg_14_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip[SortGameConst.rule_tip].tip
		})

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		arg_5_0:getRankData(arg_5_0._gameVo:GetGameId(), function(arg_17_0)
			arg_5_0.popUI:UpdateRankData(arg_17_0)

			return
		end)
		arg_5_0.popUI:PopRankUI(true)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		arg_5_0:readyStart(arg_18_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy(MiniGameProxy):UpdataHighScore(arg_5_0._gameVo:GetGameId(), arg_19_1)

		return
	end)
	arg_5_0:bind(SimpleMGEvent.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			arg_5_0:SendSuccess(0)
		end

		return
	end)
	arg_5_0:bind(SimpleMGEvent.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		arg_5_0._gameVo:AddScore(arg_21_1.num)
		arg_5_0.gameUI:AddScore(arg_21_1)

		return
	end)
	arg_5_0:bind(SortGameView.WANTED_ITEM_REFRESH, function(arg_22_0, arg_22_1, arg_22_2)
		arg_5_0.gameUI:RefreshWantedItem(arg_22_1.item_id, arg_22_1.player_prefab)

		return
	end)
	arg_5_0:bind(SortGameView.UPDATE_PLAYER, function(arg_23_0, arg_23_1, arg_23_2)
		arg_5_0.gameUI:UpdatePlayer(arg_23_1)

		return
	end)
	arg_5_0:bind(SortGameView.PLAYER_SPEAK, function(arg_24_0, arg_24_1, arg_24_2)
		arg_5_0.gameUI:SetPlayerSpeak(arg_24_1)

		return
	end)
	arg_5_0:bind(SortGameView.GAME_OVER_TIME, function(arg_25_0, arg_25_1, arg_25_2)
		arg_5_0.gameStop = true

		arg_5_0.gameUI:StepTimeToScore()

		return
	end)

	return
end

function var_0_0.initUI(arg_26_0)
	arg_26_0.clickMask = findTF(arg_26_0._tf, "clickMask")
	arg_26_0.popUI = SortGamePopUI.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	arg_26_0.popUI:ClearUI()

	arg_26_0.gameUI = SortGamingUI.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	arg_26_0.gameUI:Show(false)

	arg_26_0.menuUI = SortGameMenuUI.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	arg_26_0.menuUI:Update()
	arg_26_0.menuUI:Show(true)

	arg_26_0.gameScene = SortGameScene.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	return
end

function var_0_0.changeBgm(arg_27_0, arg_27_1)
	local var_27_0

	if not arg_27_1 then
		var_27_0 = arg_27_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm
	elseif arg_27_1 == SortGameConst.menu_bgm then
		var_27_0 = SortGameConst.menu_bgm
	elseif arg_27_1 == SortGameConst.game_bgm then
		var_27_0 = SortGameConst.game_bgm
	end

	if arg_27_0.bgm ~= var_27_0 then
		arg_27_0.bgm = var_27_0

		pg.BgmMgr.GetInstance():Push(arg_27_0.__cname, var_27_0)
	end

	return
end

function var_0_0.OnUpdate(arg_28_0)
	arg_28_0:gameStep()

	return
end

function var_0_0.readyStart(arg_29_0, arg_29_1)
	arg_29_0.readyStartFlag = true

	arg_29_0._gameVo:Prepare()
	arg_29_0.popUI:ReadyStart()
	arg_29_0.menuUI:Show(false)
	arg_29_0.gameUI:Show(false)
	arg_29_0.gameScene:Prepare()

	return
end

function var_0_0.gameStart(arg_30_0)
	arg_30_0.readyStartFlag = false
	arg_30_0.gameStartFlag = true
	arg_30_0.sendSuccessFlag = false

	arg_30_0.popUI:PopCountUI(false)
	arg_30_0.gameUI:Start()
	arg_30_0.gameUI:Show(true)
	arg_30_0.gameScene:Start()
	arg_30_0:timerStart()
	arg_30_0:changeBgm(SortGameConst.game_bgm)

	return
end

function var_0_0.gameStep(arg_31_0)
	if arg_31_0.gameStartFlag and not arg_31_0.gameStop and not arg_31_0.settlementFlag then
		arg_31_0:stepRunTimeData()
		arg_31_0.gameUI:Step(arg_31_0._gameVo:GetDeltaTime())
		arg_31_0.gameScene:Step()

		if arg_31_0._gameVo:GetTime() <= 0 then
			arg_31_0:onGameOver()
		end
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.timerStart(arg_32_0)
	arg_32_0.gameStop = false

	return
end

function var_0_0.timerResume(arg_33_0)
	arg_33_0.gameStop = false

	arg_33_0.gameScene:Resume()

	return
end

function var_0_0.timerStop(arg_34_0)
	arg_34_0.gameStop = true

	arg_34_0.gameScene:Stop()

	return
end

function var_0_0.getRankData(arg_35_0, arg_35_1, arg_35_2)
	pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
		id = arg_35_1,
		callback = function(arg_36_0)
			for iter_36_0 = 1, #arg_36_0 do
				for iter_36_1, iter_36_2 in pairs(arg_36_0[iter_36_0]) do
					({})[iter_36_1] = iter_36_2
				end

				table.insert({}, {})
			end

			table.sort({}, function(arg_37_0, arg_37_1)
				if arg_37_0.score ~= arg_37_1.score then
					return arg_37_0.score > arg_37_1.score
				elseif arg_37_0.time_data ~= arg_37_1.time_data then
					return arg_37_0.time_data > arg_37_1.time_data
				else
					return arg_37_0.player_id < arg_37_1.player_id
				end

				return
			end)

			if arg_35_2 then
				arg_35_2({})
			end

			return
		end
	})

	return
end

function var_0_0.stepRunTimeData(arg_38_0)
	arg_38_0._gameVo:Step(Time.deltaTime)

	return
end

function var_0_0.onGameOver(arg_39_0, arg_39_1)
	if arg_39_0.settlementFlag then
		return
	end

	arg_39_0:timerStop()
	arg_39_0._gameVo:SetSettlement(true)

	arg_39_0.settlementFlag = true
	arg_39_0.gameStartFlag = false

	setActive(arg_39_0.clickMask, true)
	arg_39_0.gameUI:GameOver()
	LeanTween.delayedCall(go(arg_39_0._tf), 0.1, System.Action(function()
		arg_39_0.settlementFlag = false

		arg_39_0:clearController()
		arg_39_0._gameVo:SetSettlement(false)
		setActive(arg_39_0.clickMask, false)
		arg_39_0.popUI:UpdateSettlementUI()
		arg_39_0.popUI:PopSettlementUI(true)

		return
	end))

	return
end

function var_0_0.OnApplicationPaused(arg_41_0)
	if not arg_41_0.gameStartFlag then
		return
	end

	if arg_41_0.readyStartFlag then
		return
	end

	if arg_41_0.settlementFlag then
		return
	end

	arg_41_0:pauseGame()
	arg_41_0.popUI:PopPauseUI()

	return
end

function var_0_0.clearController(arg_42_0)
	arg_42_0.gameScene:Clear()

	return
end

function var_0_0.pauseGame(arg_43_0)
	arg_43_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_44_0)
	arg_44_0:timerResume()

	return
end

function var_0_0.onBackPressed(arg_45_0)
	if arg_45_0.gameStartFlag and not arg_45_0.settlementFlag and not arg_45_0.readyStartFlag then
		arg_45_0.popUI:BackPressed()
	end

	if not arg_45_0.gameStartFlag and not arg_45_0.settlementFlag and not arg_45_0.readyStartFlag then
		arg_45_0:closeView()
	end

	return
end

function var_0_0.willExit(arg_46_0)
	if arg_46_0.handle then
		UpdateBeat:RemoveListener(arg_46_0.handle)
	end

	if arg_46_0._tf and LeanTween.isTweening(go(arg_46_0._tf)) then
		LeanTween.cancel(go(arg_46_0._tf))
	end

	Time.timeScale = 1

	if arg_46_0._gameVo then
		arg_46_0._gameVo:Clear()

		arg_46_0._gameVo = nil
	end

	return
end

return var_0_0
