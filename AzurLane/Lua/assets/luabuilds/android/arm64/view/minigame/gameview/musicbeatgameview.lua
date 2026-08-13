class = var_0_10000

local var_0_0 = "MusicBeatGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	MusicBeatGameVo = var_1

	local var_1_0 = var_1.New

	MusicBeatGameConst = var_3
	arg_1_0._gameVo = var_1_0(var_3.mini_game_id)

	return
end

function var_0_1.getUIName(arg_2_0)
	MusicBeatGameConst = var_1_10001

	return var_1_10001.game_ui
end

function var_0_1.getBGM(arg_3_0)
	MusicBeatGameConst = var_1_10001

	return var_1_10001.menu_bgm
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()

	if arg_4_0.contextData.rank then
		local var_4_0 = arg_4_0.menuUI

		var_1.showRankUI(var_4_0)
	end

	return
end

function var_0_1.initEvent(arg_5_0)
	if not arg_5_0.handle then
		FixedUpdateBeat = var_1
		arg_5_0.handle = var_1:CreateListener(arg_5_0.OnUpdate, arg_5_0)
		FixedUpdateBeat = var_1

		var_1:AddListener(arg_5_0.handle)
	end

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	MusicBeatGameEvent = var_1_10004

	var_5_1(var_5_0, var_1_10004.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			local var_6_0 = arg_5_0

			var_3.onGameOver(var_6_0, false)
		else
			local var_6_1 = arg_5_0

			var_3.resumeGame(var_6_1)
		end

		return
	end)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_3(var_5_2, var_4.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_5_0

		var_3.gameStart(var_7_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_5(var_5_4, var_4.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_5_0
		local var_8_1 = var_3.emit

		BaseUI = var_2_10006

		var_8_1(var_8_0, var_2_10006.ON_HOME)

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_7(var_5_6, var_4.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_5_0.popUI

		var_3.popPauseUI(var_9_0)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_9(var_5_8, var_4.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_5_0.popUI

		var_3.popLeaveUI(var_10_0)

		return
	end)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_11(var_5_10, var_4.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 then
			local var_11_0 = arg_5_0

			var_3.pauseGame(var_11_0)
		else
			local var_11_1 = arg_5_0

			var_3.resumeGame(var_11_1)
		end

		return
	end)

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_13(var_5_12, var_4.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_5_0.menuUI
		local var_12_1 = var_3.update
		local var_12_2 = arg_5_0

		var_12_1(var_12_0, var_6.GetMGHubData(var_12_2))

		local var_12_3 = arg_5_0.menuUI

		var_3.show(var_12_3, true)

		local var_12_4 = arg_5_0.gameUI

		var_3.show(var_12_4, false)

		local var_12_5 = arg_5_0.gameScene

		var_3.showContainer(var_12_5, false)

		local var_12_6 = arg_5_0
		local var_12_7 = var_3.changeBgm

		MusicBeatGameConst = var_6

		var_12_7(var_12_6, var_6.bgm_type_menu)

		pg = var_12_7

		local var_12_8 = var_12_7.BgmMgr.GetInstance()

		var_3.ContinuePlay(var_12_8)

		local var_12_9 = arg_5_0

		var_3.clearGame(var_12_9)

		return
	end)

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_15(var_5_14, var_4.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_5_0

		var_3.closeView(var_13_0)

		return
	end)

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_17(var_5_16, var_4.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_5_0

		var_3.onGameOver(var_14_0, arg_14_1)

		return
	end)

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_19(var_5_18, var_4.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg = var_2_10003

		local var_15_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_15_1 = var_3.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10007
		var_15_2.type = var_2_10007
		pg = var_2_10007

		local var_15_3 = var_2_10007.gametip

		MusicBeatGameConst = var_2_10008
		var_15_2.helps = var_15_3[var_2_10008.rule_tip].tip

		var_15_1(var_15_0, var_15_2)

		return
	end)

	local var_5_20 = arg_5_0
	local var_5_21 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_21(var_5_20, var_4.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_5_0

		var_3.getRankData(var_16_0)

		local var_16_1 = arg_5_0.popUI

		var_3.showRank(var_16_1, true)

		return
	end)

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_23(var_5_22, var_4.READY_START, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_5_0

		var_3.readyStart(var_17_0)

		return
	end)

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_25(var_5_24, var_4.STORE_SERVER, function(arg_18_0, arg_18_1, arg_18_2)
		getProxy = var_2_10003
		MiniGameProxy = var_2_10005

		local var_18_0 = var_2_10003(var_2_10005)

		var_3.UpdataHighScore(var_18_0, arg_5_0._gameVo.gameId, arg_18_1)

		return
	end)

	local var_5_26 = arg_5_0
	local var_5_27 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_27(var_5_26, var_4.SUBMIT_GAME_SUCCESS, function(arg_19_0, arg_19_1, arg_19_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			local var_19_0 = arg_5_0

			var_3.SendSuccess(var_19_0, 0)
		end

		return
	end)

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.bind

	MusicBeatGameEvent = var_4

	var_5_29(var_5_28, var_4.ADD_SCORE, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_5_0

		var_3.addScore(var_20_0, arg_20_1.num)

		local var_20_1 = arg_5_0.gameUI

		var_3.addScore(var_20_1, arg_20_1)

		return
	end)

	return
end

function var_0_1.initUI(arg_21_0)
	local var_21_0 = arg_21_0._gameVo
	local var_21_1 = var_1.setGameTpl

	findTF = var_1_10004

	var_21_1(var_21_0, var_1_10004(arg_21_0._tf, "tpl"))

	setActive = var_21_1
	findTF = var_21_0

	var_21_1(var_21_0(arg_21_0._tf, "tpl"), false)

	findTF = var_21_1
	arg_21_0.clickMask = var_21_1(arg_21_0._tf, "clickMask")
	MusicBeatGamePopUI = var_1
	arg_21_0.popUI = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_2 = arg_21_0.popUI

	var_1.clearUI(var_21_2)

	MusicBeatGamingUI = var_1
	arg_21_0.gameUI = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_3 = arg_21_0.gameUI

	var_1.show(var_21_3, false)

	MusicBeatGameMenuUI = var_1
	arg_21_0.menuUI = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	local var_21_4 = arg_21_0.menuUI

	var_1.update(var_21_4, arg_21_0:GetMGHubData())

	local var_21_5 = arg_21_0.menuUI

	var_1.show(var_21_5, true)

	MusicBeatGameScene = var_1
	arg_21_0.gameScene = var_1.New(arg_21_0._tf, arg_21_0, arg_21_0._gameVo)

	return
end

function var_0_1.changeBgm(arg_22_0, arg_22_1)
	local var_22_0

	MusicBeatGameConst = var_1_10003

	if arg_22_1 == var_1_10003.bgm_type_default then
		if not arg_22_0:getBGM() then
			pg = var_3

			local var_22_1 = var_3.CriMgr.GetInstance()

			if var_3.IsDefaultBGM(var_22_1) then
				pg = var_3
				var_22_0 = var_3.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_3
				var_22_0 = var_3.voice_bgm.NewMainScene.bgm
			end
		end
	else
		MusicBeatGameConst = var_3

		if arg_22_1 == var_3.bgm_type_menu then
			MusicBeatGameConst = var_3
			var_22_0 = var_3.menu_bgm
		else
			MusicBeatGameConst = var_3

			if arg_22_1 == var_3.bgm_type_game then
				MusicBeatGameConst = var_3
				var_22_0 = var_3.game_bgm
			else
				MusicBeatGameConst = var_3

				if arg_22_1 == var_3.bgm_type_intro then
					MusicBeatGameConst = var_3
					var_22_0 = var_3.intro_bgm
				end
			end
		end
	end

	pg = var_3

	local var_22_2 = var_3.BgmMgr.GetInstance()

	var_3.Push(var_22_2, arg_22_0.__cname, var_22_0)

	return
end

function var_0_1.OnUpdate(arg_23_0)
	arg_23_0:gameStep()

	return
end

function var_0_1.readyStart(arg_24_0)
	pg = var_1_10001

	local var_24_0 = var_1_10001.BgmMgr.GetInstance()

	var_1.StopPlay(var_24_0)

	arg_24_0.readyStartFlag = true

	local var_24_1 = arg_24_0._gameVo

	var_1.prepare(var_24_1)

	local var_24_2 = arg_24_0.popUI

	var_1.readyStart(var_24_2)

	local var_24_3 = arg_24_0.menuUI

	var_1.show(var_24_3, false)

	local var_24_4 = arg_24_0.gameUI

	var_1.show(var_24_4, false)

	local var_24_5 = arg_24_0.gameScene

	var_1.readyStart(var_24_5)

	return
end

function var_0_1.gameStart(arg_25_0)
	arg_25_0.readyStartFlag = false
	arg_25_0.gameStartFlag = true
	arg_25_0.sendSuccessFlag = false

	local var_25_0 = arg_25_0.popUI

	var_1.popCountUI(var_25_0, false)

	local var_25_1 = arg_25_0.gameUI

	var_1.start(var_25_1)

	local var_25_2 = arg_25_0.gameUI

	var_1.show(var_25_2, true)

	local var_25_3 = arg_25_0.gameScene

	var_1.start(var_25_3)
	arg_25_0:timerStart()

	return
end

function var_0_1.gameStep(arg_26_0)
	if arg_26_0.gameStartFlag and not arg_26_0.gameStop then
		var_1_10003 = arg_26_0

		arg_26_0.stepRunTimeData(var_1_10003)

		var_1_10003 = arg_26_0.gameUI

		var_1.step(var_1_10003, arg_26_0._gameVo.deltaTime)

		var_1_10003 = arg_26_0.gameScene

		var_1.step(var_1_10003, arg_26_0._gameVo.deltaTime)

		Physics2D = var_1

		var_1.Simulate(arg_26_0._gameVo.deltaTime)
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_26_0 = var_1.GetKeyDown

		KeyCode = var_1_10003

		local var_26_1, var_26_2

		if var_26_0(var_1_10003.A) then
			var_26_1 = arg_26_0
			var_26_2 = arg_26_0.emit
			MusicBeatGameEvent = var_1_10004
			var_1_10004 = var_1_10004.KEY_CODE_DOWN
			KeyCode = var_1_10005

			var_26_2(var_26_1, var_1_10004, var_1_10005.A)
		end

		Input = var_26_2

		local var_26_3 = var_26_2.GetKeyDown

		KeyCode = var_26_1

		if var_26_3(var_26_1.D) then
			local var_26_4 = arg_26_0
			local var_26_5 = arg_26_0.emit

			MusicBeatGameEvent = var_1_10004

			local var_26_6 = var_1_10004.KEY_CODE_DOWN

			KeyCode = var_1_10005

			var_26_5(var_26_4, var_26_6, var_1_10005.D)
		end
	end

	return
end

function var_0_1.timerStart(arg_27_0)
	arg_27_0.gameStop = false

	return
end

function var_0_1.timerResume(arg_28_0)
	arg_28_0.gameStop = false

	local var_28_0 = arg_28_0.gameScene

	var_1.resume(var_28_0)

	return
end

function var_0_1.timerStop(arg_29_0)
	arg_29_0.gameStop = true

	local var_29_0 = arg_29_0.gameScene

	var_1.stop(var_29_0)

	return
end

function var_0_1.getRankData(arg_30_0)
	pg = var_1_10001

	local var_30_0 = var_1_10001.m02
	local var_30_1 = var_1.sendNotification

	GAME = var_1_10004

	var_30_1(var_30_0, var_1_10004.MINI_GAME_FRIEND_RANK, {
		id = arg_30_0._gameVo.gameId,
		callback = function(arg_31_0)
			local var_31_0 = {}

			for iter_31_0 = 1, #arg_31_0 do
				local var_31_1 = {}

				pairs = var_2_10007

				for iter_31_1, iter_31_2 in var_2_10007(arg_31_0[iter_31_0]) do
					var_31_1[iter_31_1] = iter_31_2
				end

				table = var_2_10007

				var_2_10007.insert(var_31_0, var_31_1)
			end

			table = var_2

			var_2.sort(var_31_0, function(arg_32_0, arg_32_1)
				if arg_32_0.score ~= arg_32_1.score then
					return arg_32_0.score > arg_32_1.score
				elseif arg_32_0.time_data ~= arg_32_1.time_data then
					return arg_32_0.time_data > arg_32_1.time_data
				else
					return arg_32_0.player_id < arg_32_1.player_id
				end

				return
			end)

			local var_31_2 = arg_30_0.popUI

			var_2.updateRankData(var_31_2, var_31_0)

			return
		end
	})

	return
end

function var_0_1.stepRunTimeData(arg_33_0)
	Time = var_1_10001

	local var_33_0 = var_1_10001.fixedDeltaTime

	arg_33_0._gameVo.gameTime = arg_33_0._gameVo.gameTime - var_33_0
	arg_33_0._gameVo.gameStepTime = arg_33_0._gameVo.gameStepTime + var_33_0
	arg_33_0._gameVo.deltaTime = var_33_0

	return
end

function var_0_1.addScore(arg_34_0, arg_34_1)
	arg_34_0._gameVo.scoreNum = arg_34_0._gameVo.scoreNum + arg_34_1

	return
end

function var_0_1.onGameOver(arg_35_0, arg_35_1)
	if arg_35_0.settlementFlag then
		return
	end

	arg_35_0:timerStop()
	arg_35_0:clearController()

	arg_35_0.settlementFlag = true
	setActive = var_2

	var_2(arg_35_0.clickMask, true)

	LeanTween = var_2

	local var_35_0 = var_2.delayedCall

	go = var_4

	local var_35_1 = var_4(arg_35_0._tf)
	local var_35_2 = 0.1

	System = var_6

	var_35_0(var_35_1, var_35_2, var_6.Action(function()
		arg_35_0.settlementFlag = false

		local var_36_0 = arg_35_0

		var_36_0.gameStartFlag = false
		setActive = var_36_0

		var_36_0(arg_35_0.clickMask, false)

		local var_36_1 = arg_35_0.popUI

		var_0.updateSettlementUI(var_36_1)

		local var_36_2 = arg_35_0.popUI

		var_0.popSettlementUI(var_36_2, true)

		return
	end))

	local var_35_3 = arg_35_1 and 1 or 0
	local var_35_4 = arg_35_0
	local var_35_5 = arg_35_0.emit

	BaseMiniGameMediator = var_6

	var_35_5(var_35_4, var_6.GAME_FINISH_TRACKING, {
		game_id = arg_35_0._gameVo.gameId,
		hub_id = arg_35_0._gameVo.hubId,
		isComplete = var_35_3
	})

	return
end

function var_0_1.OnApplicationPaused(arg_37_0)
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

	local var_37_0 = arg_37_0.popUI

	var_1.popPauseUI(var_37_0)

	return
end

function var_0_1.clearController(arg_38_0)
	local var_38_0 = arg_38_0.gameScene

	var_1.clear(var_38_0)

	return
end

function var_0_1.pauseGame(arg_39_0)
	arg_39_0.gameStop = true

	arg_39_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_40_0)
	arg_40_0.gameStop = false

	arg_40_0:timerStart()
	arg_40_0:timerResume()

	return
end

function var_0_1.clearGame(arg_41_0)
	arg_41_0.gameStop = true

	return
end

function var_0_1.onBackPressed(arg_42_0)
	if arg_42_0.readyStartFlag then
		return
	end

	if not arg_42_0.gameStartFlag then
		return
	else
		if arg_42_0.settlementFlag then
			return
		end

		local var_42_0 = arg_42_0.popUI

		var_1.backPressed(var_42_0)
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_43_0, arg_43_1)
	return
end

function var_0_1.willExit(arg_44_0)
	if arg_44_0.handle then
		FixedUpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_44_0.handle)
	end

	local var_44_0

	if arg_44_0._tf then
		LeanTween = var_44_0
		var_44_0 = var_44_0.isTweening
		go = var_1_10003

		if var_44_0(var_1_10003(arg_44_0._tf)) then
			LeanTween = var_44_0
			var_44_0 = var_44_0.cancel
			go = var_3

			var_44_0(var_3(arg_44_0._tf))
		end
	end

	Time = var_44_0
	var_44_0.timeScale = 1

	local var_44_1 = arg_44_0._gameVo

	var_1.clear(var_44_1)

	return
end

return var_0_1
