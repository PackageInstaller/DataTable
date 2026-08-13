class = var_0_10000

local var_0_0 = "PacGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = 81

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	PacGameVo = var_1
	arg_1_0._gameVo = var_1.New(var_0_2)

	return
end

function var_0_1.getUIName(arg_2_0)
	PacGameConst = var_1_10001

	return var_1_10001.game_ui
end

function var_0_1.getBGM(arg_3_0)
	PacGameConst = var_1_10001

	return var_1_10001.menu_bgm
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()

	return
end

function var_0_1.initEvent(arg_5_0)
	if not arg_5_0.handle then
		UpdateBeat = var_1
		arg_5_0.handle = var_1:CreateListener(arg_5_0.OnUpdate, arg_5_0)
		UpdateBeat = var_1

		var_1:AddListener(arg_5_0.handle)
	end

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.bind

	SimpleMGEvent = var_1_10003

	var_5_1(var_5_0, var_1_10003.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_1 then
			local var_6_0 = arg_5_0

			var_3.resumeGame(var_6_0)

			local var_6_1 = arg_5_0

			var_3.onGameOver(var_6_1, false)
		else
			local var_6_2 = arg_5_0

			var_3.resumeGame(var_6_2)
		end

		return
	end)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_3(var_5_2, var_3.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_5_0

		var_3.gameStart(var_7_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_5(var_5_4, var_3.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_5_0
		local var_8_1 = var_3.emit

		BaseUI = var_2_10005

		var_8_1(var_8_0, var_2_10005.ON_HOME)

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_7(var_5_6, var_3.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_5_0.popUI

		var_3.PopPauseUI(var_9_0)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_9(var_5_8, var_3.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_5_0.popUI

		var_3.PopLeaveUI(var_10_0)

		return
	end)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_11(var_5_10, var_3.PAUSE_GAME, function(arg_11_0, arg_11_1, arg_11_2)
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

	SimpleMGEvent = var_3

	var_5_13(var_5_12, var_3.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_5_0.menuUI
		local var_12_1 = var_3.Update
		local var_12_2 = arg_5_0

		var_12_1(var_12_0, var_5.GetMGHubData(var_12_2))

		local var_12_3 = arg_5_0.menuUI

		var_3.Show(var_12_3, true)

		local var_12_4 = arg_5_0.gameUI

		var_3.Show(var_12_4, false)

		local var_12_5 = arg_5_0.gameScene

		var_3.ShowContainer(var_12_5, false)

		local var_12_6 = arg_5_0
		local var_12_7 = var_3.changeBgm

		PipeGameConst = var_5

		var_12_7(var_12_6, var_5.bgm_type_default)

		return
	end)

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_15(var_5_14, var_3.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_5_0

		var_3.closeView(var_13_0)

		return
	end)

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_17(var_5_16, var_3.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_5_0

		var_3.onGameOver(var_14_0, arg_14_1)

		return
	end)

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_19(var_5_18, var_3.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg = var_2_10003

		local var_15_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_15_1 = var_3.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10006
		var_15_2.type = var_2_10006
		pg = var_2_10006

		local var_15_3 = var_2_10006.gametip

		PacGameConst = var_2_10007
		var_15_2.helps = var_15_3[var_2_10007.rule_tip].tip

		var_15_1(var_15_0, var_15_2)

		return
	end)

	local var_5_20 = arg_5_0
	local var_5_21 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_21(var_5_20, var_3.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_5_0
		local var_16_1 = var_3.getRankData
		local var_16_2 = arg_5_0._gameVo

		var_16_1(var_16_0, var_5.GetGameId(var_16_2), function(arg_17_0)
			local var_17_0 = arg_5_0.popUI

			var_1.UpdateRankData(var_17_0, arg_17_0)

			return
		end)

		local var_16_3 = arg_5_0.popUI

		var_3.PopRankUI(var_16_3, true)

		return
	end)

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_23(var_5_22, var_3.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_18_1 and arg_18_1.editor and true or false

		print = var_2_10004

		local var_18_1 = "editor flag = "

		tostring = var_2_10006

		var_2_10004(var_18_1 .. var_2_10006(var_18_0))

		local var_18_2 = arg_5_0._gameVo

		var_4.SetEditor(var_18_2, var_18_0)

		local var_18_3 = arg_5_0

		var_4.readyStart(var_18_3, arg_18_1)

		return
	end)

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_25(var_5_24, var_3.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy = var_2_10003
		MiniGameProxy = var_2_10004

		local var_19_0 = var_2_10003(var_2_10004)
		local var_19_1 = var_3.UpdataHighScore
		local var_19_2 = arg_5_0._gameVo

		var_19_1(var_19_0, var_5.GetGameId(var_19_2), arg_19_1)

		return
	end)

	local var_5_26 = arg_5_0
	local var_5_27 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_27(var_5_26, var_3.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			local var_20_0 = arg_5_0

			var_3.SendSuccess(var_20_0, 0)
		end

		return
	end)

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.bind

	SimpleMGEvent = var_3

	var_5_29(var_5_28, var_3.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_5_0

		var_3.addScore(var_21_0, arg_21_1.num)

		return
	end)

	return
end

function var_0_1.initUI(arg_22_0)
	setActive = var_1_10001
	findTF = var_1_10002

	var_1_10001(var_1_10002(arg_22_0._tf, "tpl"), false)

	findTF = var_1_10001
	arg_22_0.clickMask = var_1_10001(arg_22_0._tf, "clickMask")
	PacGamePopUI = var_1
	arg_22_0.popUI = var_1.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	local var_22_0 = arg_22_0.popUI

	var_1.ClearUI(var_22_0)

	PacGamingUI = var_1
	arg_22_0.gameUI = var_1.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	local var_22_1 = arg_22_0.gameUI

	var_1.Show(var_22_1, false)

	PacGameMenuUI = var_1
	arg_22_0.menuUI = var_1.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	local var_22_2 = arg_22_0.menuUI

	var_1.Update(var_22_2)

	local var_22_3 = arg_22_0.menuUI

	var_1.Show(var_22_3, true)

	PacGameScene = var_1
	arg_22_0.gameScene = var_1.New(arg_22_0._tf, arg_22_0, arg_22_0._gameVo)

	return
end

function var_0_1.changeBgm(arg_23_0, arg_23_1)
	local var_23_0

	PipeGameConst = var_1_10003

	if arg_23_1 == var_1_10003.bgm_type_default then
		if not arg_23_0:getBGM() then
			pg = var_3

			local var_23_1 = var_3.CriMgr.GetInstance()

			if var_3.IsDefaultBGM(var_23_1) then
				pg = var_3
				var_23_0 = var_3.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_3
				var_23_0 = var_3.voice_bgm.NewMainScene.bgm
			end
		end
	else
		PipeGameConst = var_3

		if arg_23_1 == var_3.bgm_type_menu then
			PacGameConst = var_3
			var_23_0 = var_3.menu_bgm
		else
			PipeGameConst = var_3

			if arg_23_1 == var_3.bgm_type_game then
				PacGameConst = var_3
				var_23_0 = var_3.game_bgm
			end
		end
	end

	if arg_23_0.bgm ~= var_23_0 then
		arg_23_0.bgm = var_23_0
		pg = var_3

		local var_23_2 = var_3.BgmMgr.GetInstance()

		var_3.Push(var_23_2, arg_23_0.__cname, var_23_0)
	end

	return
end

function var_0_1.OnUpdate(arg_24_0)
	arg_24_0:gameStep()

	return
end

function var_0_1.readyStart(arg_25_0, arg_25_1)
	arg_25_0.readyStartFlag = true

	local var_25_0 = arg_25_0._gameVo

	var_2.Prepare(var_25_0)

	local var_25_1 = arg_25_0.popUI

	var_2.ReadyStart(var_25_1)

	local var_25_2 = arg_25_0.menuUI

	var_2.Show(var_25_2, false)

	local var_25_3 = arg_25_0.gameUI

	var_2.Show(var_25_3, false)

	local var_25_4 = arg_25_0.gameScene

	var_2.Prepare(var_25_4)

	return
end

function var_0_1.gameStart(arg_26_0)
	arg_26_0.readyStartFlag = false
	arg_26_0.gameStartFlag = true
	arg_26_0.sendSuccessFlag = false

	local var_26_0 = arg_26_0.popUI

	var_1.PopCountUI(var_26_0, false)

	local var_26_1 = arg_26_0.gameUI

	var_1.Start(var_26_1)

	local var_26_2 = arg_26_0.gameUI

	var_1.Show(var_26_2, true)

	local var_26_3 = arg_26_0.gameScene

	var_1.Start(var_26_3)
	arg_26_0:timerStart()

	local var_26_4 = arg_26_0
	local var_26_5 = arg_26_0.changeBgm

	PipeGameConst = var_3

	var_26_5(var_26_4, var_3.bgm_type_game)

	return
end

function var_0_1.changeSpeed(arg_27_0, arg_27_1)
	return
end

function var_0_1.gameStep(arg_28_0)
	if arg_28_0.gameStartFlag and not arg_28_0.gameStop and not arg_28_0.settlementFlag then
		var_1_10002 = arg_28_0

		arg_28_0.stepRunTimeData(var_1_10002)

		var_1_10002 = arg_28_0.gameUI

		var_1.Step(var_1_10002)

		var_1_10002 = arg_28_0.gameScene

		var_1.Step(var_1_10002)

		var_1_10002 = arg_28_0._gameVo

		if var_1.GetTime(var_1_10002) <= 0 then
			var_1_10002 = arg_28_0

			arg_28_0.onGameOver(var_1_10002)
		end
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_28_0 = var_1.GetKeyDown

		KeyCode = var_1_10002

		local var_28_1, var_28_2

		if var_28_0(var_1_10002.A) then
			var_28_1 = arg_28_0.gameUI
			var_28_2 = var_28_2.Press
			KeyCode = var_1_10003

			var_28_2(var_28_1, var_1_10003.A, true)
		end

		Input = var_28_2

		local var_28_3 = var_28_2.GetKeyUp

		KeyCode = var_28_1

		local var_28_4, var_28_5

		if var_28_3(var_28_1.A) then
			var_28_4 = arg_28_0.gameUI
			var_28_5 = var_28_5.Press
			KeyCode = var_1_10003

			var_28_5(var_28_4, var_1_10003.A, false)
		end

		Input = var_28_5

		local var_28_6 = var_28_5.GetKeyDown

		KeyCode = var_28_4

		local var_28_7, var_28_8

		if var_28_6(var_28_4.D) then
			var_28_7 = arg_28_0.gameUI
			var_28_8 = var_28_8.Press
			KeyCode = var_1_10003

			var_28_8(var_28_7, var_1_10003.D, true)
		end

		Input = var_28_8

		local var_28_9 = var_28_8.GetKeyUp

		KeyCode = var_28_7

		local var_28_10, var_28_11

		if var_28_9(var_28_7.D) then
			var_28_10 = arg_28_0.gameUI
			var_28_11 = var_28_11.Press
			KeyCode = var_1_10003

			var_28_11(var_28_10, var_1_10003.D, false)
		end

		Input = var_28_11

		local var_28_12 = var_28_11.GetKeyDown

		KeyCode = var_28_10

		local var_28_13, var_28_14

		if var_28_12(var_28_10.W) then
			var_28_13 = arg_28_0.gameUI
			var_28_14 = var_28_14.Press
			KeyCode = var_1_10003

			var_28_14(var_28_13, var_1_10003.W, true)
		end

		Input = var_28_14

		local var_28_15 = var_28_14.GetKeyUp

		KeyCode = var_28_13

		local var_28_16, var_28_17

		if var_28_15(var_28_13.W) then
			var_28_16 = arg_28_0.gameUI
			var_28_17 = var_28_17.Press
			KeyCode = var_1_10003

			var_28_17(var_28_16, var_1_10003.W, false)
		end

		Input = var_28_17

		local var_28_18 = var_28_17.GetKeyDown

		KeyCode = var_28_16

		local var_28_19, var_28_20

		if var_28_18(var_28_16.S) then
			var_28_19 = arg_28_0.gameUI
			var_28_20 = var_28_20.Press
			KeyCode = var_1_10003

			var_28_20(var_28_19, var_1_10003.S, true)
		end

		Input = var_28_20

		local var_28_21 = var_28_20.GetKeyUp

		KeyCode = var_28_19

		if var_28_21(var_28_19.S) then
			local var_28_22 = arg_28_0.gameUI
			local var_28_23 = var_1.Press

			KeyCode = var_1_10003

			var_28_23(var_28_22, var_1_10003.S, false)
		end
	end

	return
end

function var_0_1.timerStart(arg_29_0)
	arg_29_0.gamestop = false

	return
end

function var_0_1.timerResume(arg_30_0)
	arg_30_0.gamestop = false

	local var_30_0 = arg_30_0.gameScene

	var_1.Resume(var_30_0)

	return
end

function var_0_1.timerStop(arg_31_0)
	arg_31_0.gamestop = true

	local var_31_0 = arg_31_0.gameScene

	var_1.Stop(var_31_0)

	return
end

function var_0_1.getRankData(arg_32_0, arg_32_1, arg_32_2)
	pg = var_1_10003

	local var_32_0 = var_1_10003.m02
	local var_32_1 = var_3.sendNotification

	GAME = var_1_10005

	var_32_1(var_32_0, var_1_10005.MINI_GAME_FRIEND_RANK, {
		id = arg_32_1,
		callback = function(arg_33_0)
			local var_33_0 = {}

			for iter_33_0 = 1, #arg_33_0 do
				local var_33_1 = {}

				pairs = var_2_10007

				for iter_33_1, iter_33_2 in var_2_10007(arg_33_0[iter_33_0]) do
					var_33_1[iter_33_1] = iter_33_2
				end

				table = var_2_10007

				var_2_10007.insert(var_33_0, var_33_1)
			end

			table = var_2

			var_2.sort(var_33_0, function(arg_34_0, arg_34_1)
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
				arg_32_2(var_33_0)
			end

			return
		end
	})

	return
end

function var_0_1.stepRunTimeData(arg_35_0)
	local var_35_0 = arg_35_0._gameVo
	local var_35_1 = var_1.Step

	Time = var_1_10003

	var_35_1(var_35_0, var_1_10003.deltaTime)

	return
end

function var_0_1.addScore(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._gameVo

	var_2.AddScore(var_36_0, arg_36_1)

	return
end

function var_0_1.onGameOver(arg_37_0, arg_37_1)
	if arg_37_0.settlementFlag then
		return
	end

	arg_37_0:timerStop()

	local var_37_0 = arg_37_0._gameVo

	var_2.SetSettlement(var_37_0, true)

	arg_37_0.settlementFlag = true
	arg_37_0.gameStartFlag = false
	setActive = var_2

	var_2(arg_37_0.clickMask, true)

	LeanTween = var_2

	local var_37_1 = var_2.delayedCall

	go = var_3

	local var_37_2 = var_3(arg_37_0._tf)
	local var_37_3 = 0.1

	System = var_1_10005

	var_37_1(var_37_2, var_37_3, var_1_10005.Action(function()
		arg_37_0.settlementFlag = false

		local var_38_0 = arg_37_0

		var_0.clearController(var_38_0)

		local var_38_1 = arg_37_0._gameVo

		var_0.SetSettlement(var_38_1, false)

		setActive = var_0

		var_0(arg_37_0.clickMask, false)

		local var_38_2 = arg_37_0.popUI

		var_0.UpdateSettlementUI(var_38_2)

		local var_38_3 = arg_37_0.popUI

		var_0.PopSettlementUI(var_38_3, true)

		return
	end))

	return
end

function var_0_1.OnApplicationPaused(arg_39_0)
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

	local var_39_0 = arg_39_0.popUI

	var_1.PopPauseUI(var_39_0)

	return
end

function var_0_1.clearController(arg_40_0)
	local var_40_0 = arg_40_0.gameScene

	var_1.Clear(var_40_0)

	return
end

function var_0_1.pauseGame(arg_41_0)
	arg_41_0.gameStop = true

	arg_41_0:changeSpeed(0)
	arg_41_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_42_0)
	arg_42_0.gameStop = false

	arg_42_0:changeSpeed(1)
	arg_42_0:timerStart()

	return
end

function var_0_1.onBackPressed(arg_43_0)
	if arg_43_0.gameStartFlag and not arg_43_0.settlementFlag and not arg_43_0.readyStartFlag then
		local var_43_0 = arg_43_0.popUI

		var_1.BackPressed(var_43_0)
	end

	if not arg_43_0.gameStartFlag and not arg_43_0.settlementFlag and not arg_43_0.readyStartFlag then
		arg_43_0:closeView()
	end

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_44_0, arg_44_1)
	return
end

function var_0_1.willExit(arg_45_0)
	if arg_45_0.handle then
		UpdateBeat = var_1
		var_1_10002 = var_1

		var_1.RemoveListener(var_1_10002, arg_45_0.handle)
	end

	local var_45_0

	if arg_45_0._tf then
		LeanTween = var_45_0
		var_45_0 = var_45_0.isTweening
		go = var_1_10002

		if var_45_0(var_1_10002(arg_45_0._tf)) then
			LeanTween = var_45_0
			var_45_0 = var_45_0.cancel
			go = var_2

			var_45_0(var_2(arg_45_0._tf))
		end
	end

	Time = var_45_0
	var_45_0.timeScale = 1

	if arg_45_0._gameVo then
		local var_45_1 = arg_45_0._gameVo

		var_1.Clear(var_45_1)

		arg_45_0._gameVo = nil
	end

	return
end

return var_0_1
