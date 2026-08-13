class = var_0_10000

local var_0_0 = "SortGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = 84

var_0_1.WANTED_ITEM_REFRESH = "SortGameView:wanted item refresh"
var_0_1.UPDATE_PLAYER = "SortGameView:update player"
var_0_1.PLAYER_SPEAK = "SortGameView:player speak"
var_0_1.GAME_OVER_TIME = "SortGameView:game over time"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	SortGameVo = var_1
	arg_1_0._gameVo = var_1.New(var_0_2)

	return
end

function var_0_1.getUIName(arg_2_0)
	SortGameConst = var_1_10001

	return var_1_10001.game_ui
end

function var_0_1.getBGM(arg_3_0)
	SortGameConst = var_1_10001

	return var_1_10001.menu_bgm
end

function var_0_1.didEnter(arg_4_0)
	arg_4_0:initEvent()
	arg_4_0:initUI()
	arg_4_0:readyStart()

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

	SimpleMGEvent = var_1_10004

	var_5_1(var_5_0, var_1_10004.LEVEL_GAME, function(arg_6_0, arg_6_1, arg_6_2)
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

	SimpleMGEvent = var_4

	var_5_3(var_5_2, var_4.COUNT_DOWN, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_5_0

		var_3.gameStart(var_7_0)

		return
	end)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_5(var_5_4, var_4.ON_HOME, function(arg_8_0, arg_8_1, arg_8_2)
		local var_8_0 = arg_5_0
		local var_8_1 = var_3.emit

		BaseUI = var_2_10006

		var_8_1(var_8_0, var_2_10006.ON_HOME)

		return
	end)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_7(var_5_6, var_4.OPEN_PAUSE_UI, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_5_0.popUI

		var_3.PopPauseUI(var_9_0)

		return
	end)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_9(var_5_8, var_4.OPEN_LEVEL_UI, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_5_0.popUI

		var_3.PopLeaveUI(var_10_0)

		return
	end)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.bind

	SimpleMGEvent = var_4

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

	SimpleMGEvent = var_4

	var_5_13(var_5_12, var_4.BACK_MENU, function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = arg_5_0.gameScene

		var_3.ShowContainer(var_12_0, false)

		local var_12_1 = arg_5_0
		local var_12_2 = var_3.changeBgm

		SortGameConst = var_6

		var_12_2(var_12_1, var_6.menu_bgm)

		local var_12_3 = arg_5_0

		var_3.closeView(var_12_3)

		return
	end)

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_15(var_5_14, var_4.CLOSE_GAME, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_5_0

		var_3.closeView(var_13_0)

		return
	end)

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_17(var_5_16, var_4.GAME_OVER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_5_0

		var_3.onGameOver(var_14_0, arg_14_1)

		return
	end)

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_19(var_5_18, var_4.SHOW_RULE, function(arg_15_0, arg_15_1, arg_15_2)
		pg = var_2_10003

		local var_15_0 = var_2_10003.MsgboxMgr.GetInstance()
		local var_15_1 = var_3.ShowMsgBox
		local var_15_2 = {}

		MSGBOX_TYPE_HELP = var_2_10007
		var_15_2.type = var_2_10007
		pg = var_2_10007

		local var_15_3 = var_2_10007.gametip

		SortGameConst = var_2_10008
		var_15_2.helps = var_15_3[var_2_10008.rule_tip].tip

		var_15_1(var_15_0, var_15_2)

		return
	end)

	local var_5_20 = arg_5_0
	local var_5_21 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_21(var_5_20, var_4.SHOW_RANK, function(arg_16_0, arg_16_1, arg_16_2)
		local var_16_0 = arg_5_0
		local var_16_1 = var_3.getRankData
		local var_16_2 = arg_5_0._gameVo

		var_16_1(var_16_0, var_6.GetGameId(var_16_2), function(arg_17_0)
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

	SimpleMGEvent = var_4

	var_5_23(var_5_22, var_4.READY_START, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_5_0

		var_3.readyStart(var_18_0, arg_18_1)

		return
	end)

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_25(var_5_24, var_4.STORE_SERVER, function(arg_19_0, arg_19_1, arg_19_2)
		getProxy = var_2_10003
		MiniGameProxy = var_2_10005

		local var_19_0 = var_2_10003(var_2_10005)
		local var_19_1 = var_3.UpdataHighScore
		local var_19_2 = arg_5_0._gameVo

		var_19_1(var_19_0, var_6.GetGameId(var_19_2), arg_19_1)

		return
	end)

	local var_5_26 = arg_5_0
	local var_5_27 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_27(var_5_26, var_4.SUBMIT_GAME_SUCCESS, function(arg_20_0, arg_20_1, arg_20_2)
		if not arg_5_0.sendSuccessFlag then
			arg_5_0.sendSuccessFlag = true

			local var_20_0 = arg_5_0

			var_3.SendSuccess(var_20_0, 0)
		end

		return
	end)

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.bind

	SimpleMGEvent = var_4

	var_5_29(var_5_28, var_4.ADD_SCORE, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_5_0._gameVo

		var_3.AddScore(var_21_0, arg_21_1.num)

		local var_21_1 = arg_5_0.gameUI

		var_3.AddScore(var_21_1, arg_21_1)

		return
	end)

	local var_5_30 = arg_5_0
	local var_5_31 = arg_5_0.bind

	SortGameView = var_4

	var_5_31(var_5_30, var_4.WANTED_ITEM_REFRESH, function(arg_22_0, arg_22_1, arg_22_2)
		local var_22_0 = arg_5_0.gameUI

		var_3.RefreshWantedItem(var_22_0, arg_22_1.item_id, arg_22_1.player_prefab)

		return
	end)

	local var_5_32 = arg_5_0
	local var_5_33 = arg_5_0.bind

	SortGameView = var_4

	var_5_33(var_5_32, var_4.UPDATE_PLAYER, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = arg_5_0.gameUI

		var_3.UpdatePlayer(var_23_0, arg_23_1)

		return
	end)

	local var_5_34 = arg_5_0
	local var_5_35 = arg_5_0.bind

	SortGameView = var_4

	var_5_35(var_5_34, var_4.PLAYER_SPEAK, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_5_0.gameUI

		var_3.SetPlayerSpeak(var_24_0, arg_24_1)

		return
	end)

	local var_5_36 = arg_5_0
	local var_5_37 = arg_5_0.bind

	SortGameView = var_4

	var_5_37(var_5_36, var_4.GAME_OVER_TIME, function(arg_25_0, arg_25_1, arg_25_2)
		arg_5_0.gameStop = true

		local var_25_0 = arg_5_0.gameUI

		var_3.StepTimeToScore(var_25_0)

		return
	end)

	return
end

function var_0_1.initUI(arg_26_0)
	findTF = var_1_10001
	arg_26_0.clickMask = var_1_10001(arg_26_0._tf, "clickMask")
	SortGamePopUI = var_1
	arg_26_0.popUI = var_1.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	local var_26_0 = arg_26_0.popUI

	var_1.ClearUI(var_26_0)

	SortGamingUI = var_1
	arg_26_0.gameUI = var_1.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	local var_26_1 = arg_26_0.gameUI

	var_1.Show(var_26_1, false)

	SortGameMenuUI = var_1
	arg_26_0.menuUI = var_1.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	local var_26_2 = arg_26_0.menuUI

	var_1.Update(var_26_2)

	local var_26_3 = arg_26_0.menuUI

	var_1.Show(var_26_3, true)

	SortGameScene = var_1
	arg_26_0.gameScene = var_1.New(arg_26_0._tf, arg_26_0, arg_26_0._gameVo)

	return
end

function var_0_1.changeBgm(arg_27_0, arg_27_1)
	local var_27_0

	if not arg_27_1 then
		if not arg_27_0:getBGM() then
			pg = var_1_10003

			local var_27_1 = var_1_10003.CriMgr.GetInstance()

			if var_1_10003.IsDefaultBGM(var_27_1) then
				pg = var_1_10003
				var_27_0 = var_1_10003.voice_bgm.NewMainScene.default_bgm
			else
				pg = var_1_10003
				var_27_0 = var_1_10003.voice_bgm.NewMainScene.bgm
			end
		end
	else
		SortGameConst = var_1_10003

		if arg_27_1 == var_1_10003.menu_bgm then
			SortGameConst = var_3
			var_27_0 = var_3.menu_bgm
		else
			SortGameConst = var_3

			if arg_27_1 == var_3.game_bgm then
				SortGameConst = var_3
				var_27_0 = var_3.game_bgm
			end
		end
	end

	if arg_27_0.bgm ~= var_27_0 then
		arg_27_0.bgm = var_27_0
		pg = var_3

		local var_27_2 = var_3.BgmMgr.GetInstance()

		var_3.Push(var_27_2, arg_27_0.__cname, var_27_0)
	end

	return
end

function var_0_1.OnUpdate(arg_28_0)
	arg_28_0:gameStep()

	return
end

function var_0_1.readyStart(arg_29_0, arg_29_1)
	arg_29_0.readyStartFlag = true

	local var_29_0 = arg_29_0._gameVo

	var_2.Prepare(var_29_0)

	local var_29_1 = arg_29_0.popUI

	var_2.ReadyStart(var_29_1)

	local var_29_2 = arg_29_0.menuUI

	var_2.Show(var_29_2, false)

	local var_29_3 = arg_29_0.gameUI

	var_2.Show(var_29_3, false)

	local var_29_4 = arg_29_0.gameScene

	var_2.Prepare(var_29_4)

	return
end

function var_0_1.gameStart(arg_30_0)
	arg_30_0.readyStartFlag = false
	arg_30_0.gameStartFlag = true
	arg_30_0.sendSuccessFlag = false

	local var_30_0 = arg_30_0.popUI

	var_1.PopCountUI(var_30_0, false)

	local var_30_1 = arg_30_0.gameUI

	var_1.Start(var_30_1)

	local var_30_2 = arg_30_0.gameUI

	var_1.Show(var_30_2, true)

	local var_30_3 = arg_30_0.gameScene

	var_1.Start(var_30_3)
	arg_30_0:timerStart()

	local var_30_4 = arg_30_0
	local var_30_5 = arg_30_0.changeBgm

	SortGameConst = var_4

	var_30_5(var_30_4, var_4.game_bgm)

	return
end

function var_0_1.gameStep(arg_31_0)
	local var_31_1

	if arg_31_0.gameStartFlag and not arg_31_0.gameStop and not arg_31_0.settlementFlag then
		arg_31_0:stepRunTimeData()

		local var_31_0 = arg_31_0.gameUI

		var_31_1 = var_31_1.Step

		local var_31_2 = arg_31_0._gameVo

		var_31_1(var_31_0, var_4.GetDeltaTime(var_31_2))

		local var_31_3 = arg_31_0.gameScene

		var_31_1.Step(var_31_3)

		local var_31_4 = arg_31_0._gameVo

		if var_31_1.GetTime(var_31_4) <= 0 then
			arg_31_0:onGameOver()
		end
	end

	IsUnityEditor = var_31_1

	if var_31_1 then
		-- block empty
	end

	return
end

function var_0_1.timerStart(arg_32_0)
	arg_32_0.gameStop = false

	return
end

function var_0_1.timerResume(arg_33_0)
	arg_33_0.gameStop = false

	local var_33_0 = arg_33_0.gameScene

	var_1.Resume(var_33_0)

	return
end

function var_0_1.timerStop(arg_34_0)
	arg_34_0.gameStop = true

	local var_34_0 = arg_34_0.gameScene

	var_1.Stop(var_34_0)

	return
end

function var_0_1.getRankData(arg_35_0, arg_35_1, arg_35_2)
	pg = var_1_10003

	local var_35_0 = var_1_10003.m02
	local var_35_1 = var_3.sendNotification

	GAME = var_1_10006

	var_35_1(var_35_0, var_1_10006.MINI_GAME_FRIEND_RANK, {
		id = arg_35_1,
		callback = function(arg_36_0)
			local var_36_0 = {}

			for iter_36_0 = 1, #arg_36_0 do
				local var_36_1 = {}

				pairs = var_2_10007

				for iter_36_1, iter_36_2 in var_2_10007(arg_36_0[iter_36_0]) do
					var_36_1[iter_36_1] = iter_36_2
				end

				table = var_2_10007

				var_2_10007.insert(var_36_0, var_36_1)
			end

			table = var_2

			var_2.sort(var_36_0, function(arg_37_0, arg_37_1)
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
				arg_35_2(var_36_0)
			end

			return
		end
	})

	return
end

function var_0_1.stepRunTimeData(arg_38_0)
	local var_38_0 = arg_38_0._gameVo
	local var_38_1 = var_1.Step

	Time = var_1_10004

	var_38_1(var_38_0, var_1_10004.deltaTime)

	return
end

function var_0_1.onGameOver(arg_39_0, arg_39_1)
	if arg_39_0.settlementFlag then
		return
	end

	arg_39_0:timerStop()

	local var_39_0 = arg_39_0._gameVo

	var_2.SetSettlement(var_39_0, true)

	arg_39_0.settlementFlag = true
	arg_39_0.gameStartFlag = false
	setActive = var_2

	var_2(arg_39_0.clickMask, true)

	local var_39_1 = arg_39_0.gameUI

	var_2.GameOver(var_39_1)

	LeanTween = var_2

	local var_39_2 = var_2.delayedCall

	go = var_39_1

	local var_39_3 = var_39_1(arg_39_0._tf)
	local var_39_4 = 0.1

	System = var_6

	var_39_2(var_39_3, var_39_4, var_6.Action(function()
		arg_39_0.settlementFlag = false

		local var_40_0 = arg_39_0

		var_0.clearController(var_40_0)

		local var_40_1 = arg_39_0._gameVo

		var_0.SetSettlement(var_40_1, false)

		setActive = var_0

		var_0(arg_39_0.clickMask, false)

		local var_40_2 = arg_39_0.popUI

		var_0.UpdateSettlementUI(var_40_2)

		local var_40_3 = arg_39_0.popUI

		var_0.PopSettlementUI(var_40_3, true)

		return
	end))

	return
end

function var_0_1.OnApplicationPaused(arg_41_0)
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

	local var_41_0 = arg_41_0.popUI

	var_1.PopPauseUI(var_41_0)

	return
end

function var_0_1.clearController(arg_42_0)
	local var_42_0 = arg_42_0.gameScene

	var_1.Clear(var_42_0)

	return
end

function var_0_1.pauseGame(arg_43_0)
	arg_43_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_44_0)
	arg_44_0:timerResume()

	return
end

function var_0_1.onBackPressed(arg_45_0)
	if arg_45_0.gameStartFlag and not arg_45_0.settlementFlag and not arg_45_0.readyStartFlag then
		local var_45_0 = arg_45_0.popUI

		var_1.BackPressed(var_45_0)
	end

	if not arg_45_0.gameStartFlag and not arg_45_0.settlementFlag and not arg_45_0.readyStartFlag then
		arg_45_0:closeView()
	end

	return
end

function var_0_1.willExit(arg_46_0)
	if arg_46_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_46_0.handle)
	end

	local var_46_0

	if arg_46_0._tf then
		LeanTween = var_46_0
		var_46_0 = var_46_0.isTweening
		go = var_1_10003

		if var_46_0(var_1_10003(arg_46_0._tf)) then
			LeanTween = var_46_0
			var_46_0 = var_46_0.cancel
			go = var_3

			var_46_0(var_3(arg_46_0._tf))
		end
	end

	Time = var_46_0
	var_46_0.timeScale = 1

	if arg_46_0._gameVo then
		local var_46_1 = arg_46_0._gameVo

		var_1.Clear(var_46_1)

		arg_46_0._gameVo = nil
	end

	return
end

return var_0_1
