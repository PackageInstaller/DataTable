class = var_0_10000

local var_0_0 = "BattleMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_BATTLE_RESULT = "BattleMediator:ON_BATTLE_RESULT"
var_0_1.ON_PAUSE = "BattleMediator:ON_PAUSE"
var_0_1.ENTER = "BattleMediator:ENTER"
var_0_1.ON_BACK_PRE_SCENE = "BattleMediator:ON_BACK_PRE_SCENE"
var_0_1.ON_LEAVE = "BattleMediator:ON_LEAVE"
var_0_1.ON_QUIT_BATTLE_MANUALLY = "BattleMediator:ON_QUIT_BATTLE_MANUALLY"
var_0_1.HIDE_ALL_BUTTONS = "BattleMediator:HIDE_ALL_BUTTONS"
var_0_1.ON_CHAT = "BattleMediator:ON_CHAT"
var_0_1.CLOSE_CHAT = "BattleMediator:CLOSE_CHAT"
var_0_1.ON_AUTO = "BattleMediator:ON_AUTO"
var_0_1.UPDATE_AUTO_COUNT = "BattleMediator:UPDATE_AUTO_COUNT"
var_0_1.ON_PUZZLE_RELIC = "BattleMediator.ON_PUZZLE_RELIC"
var_0_1.ON_PUZZLE_CARD = "BattleMediator.ON_PUZZLE_CARD"

function var_0_1.register(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.BrightnessMgr.GetInstance()

	var_1.SetScreenNeverSleep(var_1_0, true)
	arg_1_0:GenBattleData()

	local var_1_1 = arg_1_0.contextData

	var_1_1.battleData = arg_1_0._battleData
	ys = var_1_1

	local var_1_2 = var_1_1.Battle.BattleState.GetInstance()
	local var_1_3 = arg_1_0.contextData.system

	arg_1_0:bind(var_0_1.ON_BATTLE_RESULT, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.FINISH_STAGE, {
			token = arg_1_0.contextData.token,
			mainFleetId = arg_1_0.contextData.mainFleetId,
			stageId = arg_1_0.contextData.stageId,
			rivalId = arg_1_0.contextData.rivalId,
			memory = arg_1_0.contextData.memory,
			bossId = arg_1_0.contextData.bossId,
			exitCallback = arg_1_0.contextData.exitCallback,
			system = var_1_3,
			statistics = arg_2_1,
			actId = arg_1_0.contextData.actId,
			mode = arg_1_0.contextData.mode,
			puzzleCombatID = arg_1_0.contextData.puzzleCombatID,
			useVariableTicket = arg_1_0.contextData.useVariableTicket,
			isSimulate = arg_1_0.contextData.isSimulate
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_AUTO, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.onAutoBtn(var_3_0, arg_3_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_PAUSE, function(arg_4_0)
		local var_4_0 = arg_1_0

		var_1.onPauseBtn(var_4_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_LEAVE, function(arg_5_0)
		local var_5_0 = arg_1_0

		var_1.warnFunc(var_5_0)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHAT, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_6_2 = var_2_10005.New
		local var_6_3 = {}

		NotificationMediator = var_2_10008
		var_6_3.mediator = var_2_10008
		NotificationLayer = var_2_10008
		var_6_3.viewComponent = var_2_10008

		local var_6_4 = {}

		NotificationLayer = var_2_10009
		var_6_4.form = var_2_10009.FORM_BATTLE
		var_6_3.data = var_6_4

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.ENTER, function(arg_7_0)
		local var_7_0 = var_1_2

		var_1.EnterBattle(var_7_0, arg_1_0._battleData, arg_1_0.contextData.prePause)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BACK_PRE_SCENE, function()
		getProxy = var_2_10000
		ContextProxy = var_2_10002

		local var_8_0 = var_2_10000(var_2_10002)
		local var_8_1 = var_0.getContextByMediator

		DailyLevelMediator = var_2_10004

		local var_8_2 = var_8_1(var_8_0, var_2_10004)
		local var_8_3 = var_0
		local var_8_4 = var_0.getContextByMediator

		LevelMediator2 = var_2_10005

		local var_8_5 = var_8_4(var_8_3, var_2_10005)
		local var_8_6 = var_0
		local var_8_7 = var_0.getContextByMediator

		ChallengeMainMediator = var_2_10006

		local var_8_8 = var_8_7(var_8_6, var_2_10006)
		local var_8_9 = var_0
		local var_8_10 = var_0.getContextByMediator

		ActivityBossMediatorTemplate = var_2_10007

		local var_8_11 = var_8_10(var_8_9, var_2_10007)
		local var_8_12 = var_0
		local var_8_13 = var_0.getContextByMediator

		WorldMediator = var_2_10008

		local var_8_14 = var_8_13(var_8_12, var_2_10008)
		local var_8_15 = var_0
		local var_8_16 = var_0.getContextByMediator

		WorldBossMediator = var_2_10009

		local var_8_17 = var_8_16(var_8_15, var_2_10009)
		local var_8_18 = var_0
		local var_8_19 = var_0.getContextByMediator

		BossSinglePreCombatMediator = var_2_10010

		local var_8_20, var_8_21 = var_8_19(var_8_18, var_2_10010)

		if var_8_17 and arg_1_0.contextData.bossId then
			local var_8_22 = arg_1_0
			local var_8_23 = var_9.sendNotification

			GAME = var_2_10012

			var_8_23(var_8_22, var_2_10012.WORLD_BOSS_BATTLE_QUIT, {
				id = arg_1_0.contextData.bossId
			})

			local var_8_24 = var_8_17
			local var_8_25 = var_8_17.getContextByMediator

			WorldBossFormationMediator = var_2_10012

			if var_8_25(var_8_24, var_2_10012) then
				var_2_10012 = var_8_17

				var_8_17.removeChild(var_2_10012, var_9)
			end
		elseif var_8_14 then
			local var_8_26 = var_8_14
			local var_8_27 = var_8_14.getContextByMediator

			WorldPreCombatMediator = var_2_10012

			local var_8_29

			if not var_8_27(var_8_26, var_2_10012) then
				local var_8_28 = var_8_14

				var_8_29 = var_8_14.getContextByMediator
				WorldBossInformationMediator = var_2_10012
				var_8_29 = var_8_29(var_8_28, var_2_10012)
			end

			if var_8_29 then
				var_2_10012 = var_8_14

				var_8_14.removeChild(var_2_10012, var_8_29)
			end
		elseif var_8_2 then
			local var_8_30 = var_8_2
			local var_8_31 = var_8_2.getContextByMediator

			PreCombatMediator = var_2_10012

			local var_8_32 = var_8_31(var_8_30, var_2_10012)

			var_2_10012 = var_8_2

			var_8_2.removeChild(var_2_10012, var_8_32)
		elseif var_8_8 then
			local var_8_33 = arg_1_0
			local var_8_34 = var_9.sendNotification

			GAME = var_2_10012

			var_8_34(var_8_33, var_2_10012.CHALLENGE2_RESET, {
				mode = arg_1_0.contextData.mode
			})

			local var_8_35 = var_8_8
			local var_8_36 = var_8_8.getContextByMediator

			ChallengePreCombatMediator = var_2_10012

			local var_8_37 = var_8_36(var_8_35, var_2_10012)

			var_2_10012 = var_8_8

			var_8_8.removeChild(var_2_10012, var_8_37)
		elseif var_8_5 then
			local var_8_38 = var_1_3

			SYSTEM_DUEL = var_2_10010

			if var_8_38 == var_2_10010 then
				-- block empty
			else
				local var_8_39 = var_1_3

				SYSTEM_SCENARIO = var_2_10010

				if var_8_39 == var_2_10010 then
					local var_8_40 = var_8_5
					local var_8_41 = var_8_5.getContextByMediator

					ChapterPreCombatMediator = var_2_10012

					if var_8_41(var_8_40, var_2_10012) then
						var_2_10012 = var_8_5

						var_8_5.removeChild(var_2_10012, var_9)
					end
				else
					local var_8_42 = var_1_3

					SYSTEM_PERFORM = var_2_10010

					if var_8_42 ~= var_2_10010 then
						local var_8_43 = var_1_3

						SYSTEM_SIMULATION = var_2_10010

						if var_8_43 ~= var_2_10010 then
							local var_8_44 = var_8_5
							local var_8_45 = var_8_5.getContextByMediator

							PreCombatMediator = var_2_10012

							if var_8_45(var_8_44, var_2_10012) then
								var_2_10012 = var_8_5

								var_8_5.removeChild(var_2_10012, var_9)
							end
						end
					end
				end
			end
		elseif var_8_11 then
			local var_8_46 = var_8_11
			local var_8_47 = var_8_11.getContextByMediator

			PreCombatMediator = var_2_10012

			if var_8_47(var_8_46, var_2_10012) then
				var_2_10012 = var_8_11

				var_8_11.removeChild(var_2_10012, var_9)
			end
		elseif var_8_20 then
			local var_8_48 = var_8_21:removeChild(var_8_20)
		end

		local var_8_49 = arg_1_0
		local var_8_50 = var_9.sendNotification

		GAME = var_2_10012

		var_8_50(var_8_49, var_2_10012.GO_BACK)

		return
	end)
	arg_1_0:bind(var_0_1.ON_QUIT_BATTLE_MANUALLY, function(arg_9_0)
		local var_9_0 = var_1_3

		SYSTEM_SCENARIO = var_2_10002

		if var_9_0 == var_2_10002 then
			getProxy = var_9_0
			ChapterProxy = var_2_10003
			var_2_10003 = var_9_0(var_2_10003)

			local var_9_1 = var_1.StopAutoFight

			ChapterConst = var_2_10004

			var_9_1(var_2_10003, var_2_10004.AUTOFIGHT_STOP_REASON.MANUAL)

			goto label_9_0
		end

		local var_9_2 = var_1_3

		SYSTEM_WORLD = var_2_10002

		if var_9_2 == var_2_10002 then
			nowWorld = var_9_2
			var_2_10003 = var_9_2()

			var_1.TriggerAutoFight(var_2_10003, false)

			goto label_9_0
		end

		local var_9_3 = var_1_3

		SYSTEM_ACT_BOSS = var_2_10002

		if var_9_3 == var_2_10002 then
			getProxy = var_9_3
			ContextProxy = var_2_10003
			var_2_10003 = var_9_3(var_2_10003)
			var_2_10003 = var_1.getCurrentContext(var_2_10003)

			local var_9_4 = var_1.getContextByMediator

			ContinuousOperationMediator = var_2_10004

			if var_9_4(var_2_10003, var_2_10004) then
				getProxy = var_1
				ContextProxy = var_2_10003
				var_2_10003 = var_1(var_2_10003)
				var_2_10004 = var_1.GetPrevContext(var_2_10003, 1)
				var_2_10002 = var_1.addChild
				Context = var_2_10005
				var_2_10005 = var_2_10005.New

				local var_9_5 = {}

				ActivityBossTotalRewardPanelMediator = var_2_10008
				var_9_5.mediator = var_2_10008
				ActivityBossTotalRewardPanel = var_2_10008
				var_9_5.viewComponent = var_2_10008
				var_2_10008 = {
					isLayer = true,
					isAutoFight = false
				}
				getProxy = var_2_10009
				ChapterProxy = var_2_10011
				var_2_10011 = var_2_10009(var_2_10011)
				var_2_10008.rewards = var_2_10009.PopActBossRewards(var_2_10011)
				var_2_10008.continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes
				var_2_10008.totalBattleTimes = arg_1_0.contextData.totalBattleTimes
				var_9_5.data = var_2_10008

				var_2_10002(var_2_10004, var_2_10005(var_9_5))
			end

			goto label_9_0
		end

		local var_9_6 = var_1_3

		SYSTEM_BOSS_RUSH = var_2_10002

		if var_9_6 ~= var_2_10002 then
			var_9_6 = var_1_3
			SYSTEM_BOSS_RUSH_COLLABRATE = var_2_10002

			if var_9_6 == var_2_10002 then
				getProxy = var_9_6
				ContextProxy = var_2_10003
				var_2_10003 = var_9_6(var_2_10003)
				var_2_10003 = var_1.getCurrentContext(var_2_10003)

				local var_9_7 = var_1.getContextByMediator

				ContinuousOperationMediator = var_2_10004

				if var_9_7(var_2_10003, var_2_10004) then
					getProxy = var_1
					ActivityProxy = var_2_10003
					var_2_10003 = var_1(var_2_10003)

					local var_9_8 = var_1.PopBossRushAwards(var_2_10003)

					getProxy = var_2_10002
					ContextProxy = var_2_10004
					var_2_10004 = var_2_10002(var_2_10004)
					var_2_10005 = var_2_10002.GetPrevContext(var_2_10004, 1)
					var_2_10003 = var_2_10002.addChild
					Context = var_2_10006

					local var_9_9 = var_2_10006.New

					var_2_10008 = {}
					BossRushTotalRewardPanelMediator = var_2_10009
					var_2_10008.mediator = var_2_10009
					BossRushTotalRewardPanel = var_2_10009
					var_2_10008.viewComponent = var_2_10009
					var_2_10008.data = {
						isAutoFight = false,
						isLayer = true,
						rewards = var_9_8
					}

					var_2_10003(var_2_10005, var_9_9(var_2_10008))
				end

				goto label_9_0
			end

			local var_9_10 = var_1_3

			SYSTEM_BOSS_SINGLE = var_2_10002

			if var_9_10 ~= var_2_10002 then
				var_9_10 = var_1_3
				SYSTEM_BOSS_SINGLE_VARIABLE = var_2_10002

				if var_9_10 == var_2_10002 then
					getProxy = var_9_10
					ContextProxy = var_2_10003

					local var_9_11 = var_9_10(var_2_10003)
					local var_9_12 = var_1.getCurrentContext(var_9_11)
					local var_9_13 = var_1.getContextByMediator

					BossSingleContinuousOperationMediator = var_2_10004

					if var_9_13(var_9_12, var_2_10004) then
						getProxy = var_1
						ContextProxy = var_9_12

						local var_9_14 = var_1(var_9_12)
						local var_9_15 = var_1.GetPrevContext(var_9_14, 1)
						local var_9_16 = var_1.addChild

						Context = var_2_10005

						local var_9_17 = var_2_10005.New
						local var_9_18 = {}

						BossSingleTotalRewardPanelMediator = var_2_10008
						var_9_18.mediator = var_2_10008
						BossSingleTotalRewardPanel = var_2_10008
						var_9_18.viewComponent = var_2_10008

						local var_9_19 = {
							isLayer = true,
							isAutoFight = false
						}

						getProxy = var_2_10009
						ChapterProxy = var_2_10011

						local var_9_20 = var_2_10009(var_2_10011)

						var_9_19.rewards = var_9.PopBossSingleRewards(var_9_20)
						var_9_19.continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes
						var_9_19.totalBattleTimes = arg_1_0.contextData.totalBattleTimes
						var_9_18.data = var_9_19

						var_9_16(var_9_15, var_9_17(var_9_18))
					end
				end

				::label_9_0::

				return
			end
		end
	end)
	arg_1_0:bind(var_0_1.ON_PUZZLE_RELIC, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_10_2 = var_2_10005.New
		local var_10_3 = {}

		CardPuzzleRelicDeckMediator = var_2_10008
		var_10_3.mediator = var_2_10008
		CardPuzzleRelicDeckLayerCombat = var_2_10008
		var_10_3.viewComponent = var_2_10008
		var_10_3.data = arg_10_1

		var_10_1(var_10_0, var_10_2(var_10_3))

		local var_10_4 = var_1_2

		var_2.Pause(var_10_4)

		return
	end)

	local var_1_4 = arg_1_0

	arg_1_0.bind(var_1_4, var_0_1.ON_PUZZLE_CARD, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_11_2 = var_2_10005.New
		local var_11_3 = {}

		CardPuzzleCardDeckMediator = var_2_10008
		var_11_3.mediator = var_2_10008
		CardPuzzleCardDeckLayerCombat = var_2_10008
		var_11_3.viewComponent = var_2_10008
		var_11_3.data = arg_11_1

		var_11_1(var_11_0, var_11_2(var_11_3))

		local var_11_4 = var_1_2

		var_2.Pause(var_11_4)

		return
	end)

	if arg_1_0.contextData.continuousBattleTimes and arg_1_0.contextData.continuousBattleTimes > 0 then
		SYSTEM_BOSS_SINGLE = var_1_5

		if var_1_3 ~= var_1_5 then
			SYSTEM_BOSS_SINGLE_VARIABLE = var_1_5

			local var_1_5, var_1_6, var_1_8

			if var_1_3 == var_1_5 then
				getProxy = var_1_5
				ContextProxy = var_1_4
				var_1_4 = var_1_5(var_1_4)
				var_1_4 = var_1_5.getCurrentContext(var_1_4)
				var_1_5 = var_1_5.getContextByMediator
				BossSingleContinuousOperationMediator = var_1_6

				if not var_1_5(var_1_4, var_1_6) then
					CreateShell = var_1_5
					var_1_5 = var_1_5(arg_1_0.contextData)
					var_1_6 = arg_1_0

					local var_1_7 = arg_1_0.addSubLayers

					Context = var_1_8
					var_1_8 = var_1_8.New

					local var_1_9 = {}

					BossSingleContinuousOperationMediator = var_1_10010
					var_1_9.mediator = var_1_10010
					BossSingleContinuousOperationPanel = var_1_10010
					var_1_9.viewComponent = var_1_10010
					var_1_9.data = var_1_5

					var_1_7(var_1_6, var_1_8(var_1_9))
				end
			else
				getProxy = var_1_5
				ContextProxy = var_1_4
				var_1_4 = var_1_5(var_1_4)
				var_1_4 = var_1_5.getCurrentContext(var_1_4)
				var_1_5 = var_1_5.getContextByMediator
				ContinuousOperationMediator = var_1_6

				if not var_1_5(var_1_4, var_1_6) then
					CreateShell = var_1_5
					var_1_5 = var_1_5(arg_1_0.contextData)

					local var_1_10 = arg_1_0
					local var_1_11 = arg_1_0.addSubLayers

					Context = var_1_8

					local var_1_12 = var_1_8.New
					local var_1_13 = {}

					ContinuousOperationMediator = var_1_10010
					var_1_13.mediator = var_1_10010
					ContinuousOperationPanel = var_1_10010
					var_1_13.viewComponent = var_1_10010
					var_1_13.data = var_1_5

					var_1_11(var_1_10, var_1_12(var_1_13))
				end
			end

			var_1_5 = arg_1_0.contextData.battleData
			var_1_5.hideAllButtons = true
			getProxy = var_1_5
			PlayerProxy = var_1_4

			if var_1_5(var_1_4) then
				arg_1_0.player = var_3:getData()

				var_3:setFlag("battle", true)
				var_3:setFlag("random_skin", true)
			end

			return
		end
	end
end

function var_0_1.onAutoBtn(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.isOn
	local var_12_1 = arg_12_1.toggle
	local var_12_2 = arg_12_1.system
	local var_12_3 = arg_12_0
	local var_12_4 = arg_12_0.sendNotification

	GAME = var_1_10008

	var_12_4(var_12_3, var_1_10008.AUTO_BOT, {
		isActiveBot = var_12_0,
		toggle = var_12_1,
		system = var_12_2
	})

	return
end

function var_0_1.updateAutoCount(arg_13_0, arg_13_1)
	ys = var_1_10002

	local var_13_0 = var_1_10002.Battle.BattleState.GetInstance()
	local var_13_1 = var_2.GetProxyByName

	ys = var_1_10006

	local var_13_2 = var_13_1(var_13_0, var_1_10006.Battle.BattleDataProxy.__name)
	local var_13_3 = var_3.AutoStatistics(var_13_2, arg_13_1.isOn)

	return
end

function var_0_1.onPauseBtn(arg_14_0)
	ys = var_1_10001

	local var_14_0 = var_1_10001.Battle.BattleState.GetInstance()
	local var_14_1 = arg_14_0.contextData.system

	SYSTEM_PROLOGUE = var_1_10003

	if var_14_1 ~= var_1_10003 then
		local var_14_2 = arg_14_0.contextData.system

		SYSTEM_PERFORM = var_1_10003

		if var_14_2 == var_1_10003 then
			local var_14_3 = {}

			EPILOGUE_SKIPPABLE = var_1_10003

			if var_1_10003 then
				var_1_10003 = {
					text = "关爱胡德"
				}
				pg = var_1_10004
				var_1_10003.btnType = var_1_10004.MsgboxMgr.BUTTON_RED

				function var_1_10003.onCallback()
					local var_15_0 = var_14_0

					var_0.Deactive(var_15_0)

					local var_15_1 = arg_14_0
					local var_15_2 = var_0.sendNotification

					GAME = var_2_10003

					local var_15_3 = var_2_10003.CHANGE_SCENE

					SCENE = var_2_10004

					var_15_2(var_15_1, var_15_3, var_2_10004.CREATE_PLAYER)

					return
				end

				table = var_4

				var_4.insert(var_14_3, 1, var_1_10003)
			end

			pg = var_1_10003
			var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
			var_1_10003 = var_1_10003.ShowMsgBox

			local var_14_4 = {}

			MSGBOX_TYPE_HELP = var_1_10007
			var_14_4.type = var_1_10007
			i18n = var_1_10007
			var_14_4.helps = var_1_10007("help_battle_rule")

			function var_14_4.onClose()
				ys = var_2_10000

				local var_16_0 = var_2_10000.Battle.BattleState.GetInstance()

				var_0.Resume(var_16_0)

				return
			end

			function var_14_4.onNo()
				ys = var_2_10000

				local var_17_0 = var_2_10000.Battle.BattleState.GetInstance()

				var_0.Resume(var_17_0)

				return
			end

			var_14_4.custom = var_14_3

			var_1_10003(var_1_10005, var_14_4)

			var_1_10005 = var_14_0

			var_14_0.Pause(var_1_10005)

			goto label_14_0
		end

		local var_14_5 = arg_14_0.contextData.system

		SYSTEM_DODGEM = var_1_10003

		if var_14_5 == var_1_10003 then
			local var_14_6 = {
				text = "text_cancel_fight"
			}

			pg = var_1_10003
			var_14_6.btnType = var_1_10003.MsgboxMgr.BUTTON_RED

			function var_14_6.onCallback()
				local var_18_0 = arg_14_0

				var_0.warnFunc(var_18_0, function()
					ys = var_3_10000

					local var_19_0 = var_3_10000.Battle.BattleState.GetInstance()

					var_0.Resume(var_19_0)

					return
				end)

				return
			end

			pg = var_1_10003
			var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
			var_1_10003 = var_1_10003.ShowMsgBox

			local var_14_7 = {}

			MSGBOX_TYPE_HELP = var_1_10007
			var_14_7.type = var_1_10007
			i18n = var_1_10007
			var_14_7.helps = var_1_10007("help_battle_warspite")

			function var_14_7.onClose()
				ys = var_2_10000

				local var_20_0 = var_2_10000.Battle.BattleState.GetInstance()

				var_0.Resume(var_20_0)

				return
			end

			function var_14_7.onNo()
				ys = var_2_10000

				local var_21_0 = var_2_10000.Battle.BattleState.GetInstance()

				var_0.Resume(var_21_0)

				return
			end

			var_14_7.custom = {
				var_14_6
			}

			var_1_10003(var_1_10005, var_14_7)

			var_1_10005 = var_14_0

			var_14_0.Pause(var_1_10005)

			goto label_14_0
		end

		local var_14_8 = arg_14_0.contextData.system

		SYSTEM_SIMULATION = var_1_10003

		if var_14_8 == var_1_10003 then
			local var_14_9 = {
				text = "text_cancel_fight"
			}

			pg = var_1_10003
			var_14_9.btnType = var_1_10003.MsgboxMgr.BUTTON_RED

			function var_14_9.onCallback()
				local var_22_0 = arg_14_0

				var_0.warnFunc(var_22_0, function()
					ys = var_3_10000

					local var_23_0 = var_3_10000.Battle.BattleState.GetInstance()

					var_0.Resume(var_23_0)

					return
				end)

				return
			end

			pg = var_1_10003
			var_1_10005 = var_1_10003.MsgboxMgr.GetInstance()
			var_1_10003 = var_1_10003.ShowMsgBox

			local var_14_10 = {}

			MSGBOX_TYPE_HELP = var_1_10007
			var_14_10.type = var_1_10007
			i18n = var_1_10007
			var_14_10.helps = var_1_10007("help_battle_rule")

			function var_14_10.onClose()
				ys = var_2_10000

				local var_24_0 = var_2_10000.Battle.BattleState.GetInstance()

				var_0.Resume(var_24_0)

				return
			end

			function var_14_10.onNo()
				ys = var_2_10000

				local var_25_0 = var_2_10000.Battle.BattleState.GetInstance()

				var_0.Resume(var_25_0)

				return
			end

			var_14_10.custom = {
				var_14_9
			}

			var_1_10003(var_1_10005, var_14_10)

			var_1_10005 = var_14_0

			var_14_0.Pause(var_1_10005)

			goto label_14_0
		end

		local var_14_11 = arg_14_0.contextData.system

		SYSTEM_SUBMARINE_RUN = var_1_10003

		if var_14_11 ~= var_1_10003 then
			local var_14_12 = arg_14_0.contextData.system

			SYSTEM_SUB_ROUTINE = var_1_10003

			if var_14_12 ~= var_1_10003 then
				local var_14_13 = arg_14_0.contextData.system

				SYSTEM_REWARD_PERFORM = var_1_10003

				if var_14_13 ~= var_1_10003 then
					do
						local var_14_14 = arg_14_0.contextData.system

						SYSTEM_AIRFIGHT = var_1_10003

						if var_14_14 == var_1_10003 then
							var_14_0:Pause()
							arg_14_0:warnFunc(function()
								ys = var_2_10000

								local var_26_0 = var_2_10000.Battle.BattleState.GetInstance()

								var_0.Resume(var_26_0)

								return
							end)
						else
							local var_14_15 = arg_14_0.contextData.system

							SYSTEM_CARDPUZZLE = var_1_10003

							if var_14_15 == var_1_10003 then
								local var_14_16 = arg_14_0
								local var_14_17 = arg_14_0.addSubLayers

								Context = var_1_10005

								local var_14_18 = var_1_10005.New
								local var_14_19 = {}

								CardPuzzleCombatPauseMediator = var_1_10008
								var_14_19.mediator = var_1_10008
								CardPuzzleCombatPauseLayer = var_1_10008
								var_14_19.viewComponent = var_1_10008

								var_14_17(var_14_16, var_14_18(var_14_19))
								var_14_0:Pause()
							else
								local var_14_20 = arg_14_0.viewComponent

								var_2.updatePauseWindow(var_14_20)
								var_14_0:Pause()
							end
						end
					end

					::label_14_0::

					return
				end
			end
		end
	end
end

function var_0_1.warnFunc(arg_27_0, arg_27_1)
	ys = var_1_10002

	local var_27_0 = var_1_10002.Battle.BattleState.GetInstance()
	local var_27_1 = arg_27_0.contextData.system
	local var_27_2
	local var_27_3

	local function var_27_4()
		local var_28_0 = var_27_0

		var_0.Stop(var_28_0)

		return
	end

	if arg_27_0.contextData.warnMsg then
		var_1_10008 = #var_7

		if 0 < var_1_10008 then
			i18n = var_1_10008
			var_27_3 = var_1_10008(var_7)

			goto label_27_0
		end
	end

	SYSTEM_CHALLENGE = var_1_10008

	if var_27_1 == var_1_10008 then
		i18n = var_1_10008
		var_27_3 = var_1_10008("battle_battleMediator_clear_warning")
	else
		SYSTEM_SIMULATION = var_1_10008

		if var_27_1 == var_1_10008 then
			i18n = var_1_10008
			var_27_3 = var_1_10008("tech_simulate_quit")
		else
			SYSTEM_SCENARIO_SUB_STRIKE = var_1_10008

			if var_27_1 == var_1_10008 then
				i18n = var_1_10008
				var_27_3 = var_1_10008("battle_battleMediator_quest_exist_submarine_support")

				function var_27_4()
					local var_29_0 = var_27_0
					local var_29_1 = var_0.GetCommandByName

					ys = var_2_10003

					local var_29_2 = var_29_1(var_29_0, var_2_10003.Battle.BattleScenarioSubStrikeCommand.__name)

					var_0.CalcBattleEnd(var_29_2)

					local var_29_3 = arg_27_0.viewComponent

					var_1.ClosePauseWindow(var_29_3)

					return
				end
			else
				i18n = var_1_10008
				var_27_3 = var_1_10008("battle_battleMediator_quest_exist")
			end
		end
	end

	::label_27_0::

	local function var_27_5()
		if arg_27_1 then
			arg_27_1()
		end

		local var_30_0 = arg_27_0.viewComponent.leaveBtn
		local var_30_1 = var_0.GetComponent

		typeof = var_2_10003
		Animation = var_2_10005

		if var_30_1(var_30_0, var_2_10003(var_2_10005)) then
			var_0:Play("msgbox_btn_into")
		end

		return
	end

	pg = var_1_10009

	local var_27_6 = var_1_10009.MsgboxMgr.GetInstance()
	local var_27_7 = var_9.ShowMsgBox
	local var_27_8 = {
		modal = true,
		hideYes = true,
		hideNo = true,
		content = var_27_3,
		onClose = var_27_5
	}
	local var_27_9 = {}
	local var_27_10 = {
		text = "text_cancel",
		onCallback = var_27_5
	}

	SFX_CANCEL = var_1_10015
	var_27_10.sound = var_1_10015
	var_27_9[1] = var_27_10

	local var_27_11 = {
		text = "text_exit"
	}

	pg = var_1_10015
	var_27_11.btnType = var_1_10015.MsgboxMgr.BUTTON_RED
	var_27_11.onCallback = var_27_4
	SFX_CONFIRM = var_15
	var_27_11.sound = var_15
	var_27_9[2] = var_27_11
	var_27_8.custom = var_27_9

	var_27_7(var_27_6, var_27_8)

	return
end

function var_0_1.guideDispatch(arg_31_0)
	return
end

local function var_0_2(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = {}

	ipairs = var_1_10005

	for iter_32_0, iter_32_1 in var_1_10005(arg_32_1:getActiveEquipments()) do
		if iter_32_1 then
			var_32_0[#var_32_0 + 1] = {
				id = iter_32_1.configId,
				skin = iter_32_1.skinId,
				equipmentInfo = iter_32_1
			}
		else
			var_32_0[#var_32_0 + 1] = {
				skin = 0,
				id = iter_32_1,
				equipmentInfo = iter_32_1
			}
		end
	end

	local var_32_1 = {}

	local function var_32_2(arg_33_0)
		local var_33_0 = {
			level = arg_33_0.level
		}
		local var_33_1 = arg_33_0.id
		local var_33_2 = arg_32_1
		local var_33_3 = var_3.RemapSkillId(var_33_2, var_33_1, true)

		ys = var_3
		var_33_0.id = var_3.Battle.BattleDataFunction.SkillTranform(arg_32_0, var_33_3)

		return var_33_0
	end

	ys = var_7

	local var_32_3 = var_7.Battle.BattleDataFunction.GenerateHiddenBuff(arg_32_1.configId)

	pairs = iter_32_0

	for iter_32_2, iter_32_3 in iter_32_0(var_32_3) do
		var_32_1[var_32_2(iter_32_3).id] = var_13
	end

	pairs = var_8

	for iter_32_4, iter_32_5 in var_8(arg_32_1.skills) do
		if iter_32_5 and iter_32_5.id == 14900 and not arg_32_1.transforms[16412] then
			-- block empty
		else
			var_32_1[var_32_2(iter_32_5).id] = var_13
		end
	end

	ys = var_8

	local var_32_4 = var_8.Battle.BattleDataFunction.GetEquipSkill(var_32_0)

	ipairs = var_9

	for iter_32_6, iter_32_7 in var_9(var_32_4) do
		local var_32_5 = {
			level = iter_32_7.buffLV
		}

		ys = var_15
		var_32_5.id = var_15.Battle.BattleDataFunction.SkillTranform(arg_32_0, iter_32_7.buffID)
		var_32_1[var_32_5.id] = var_32_5
	end

	local var_32_6

	;(function()
		local var_34_0 = arg_32_1

		var_32_6 = var_0.GetSpWeapon(var_34_0)

		if not var_32_6 then
			return
		end

		local var_34_1 = var_32_6

		if var_0.GetEffect(var_34_1) == 0 then
			return
		end

		local var_34_2 = {}

		var_34_2.level = 1
		ys = var_2
		var_34_2.id = var_2.Battle.BattleDataFunction.SkillTranform(arg_32_0, var_0)
		var_32_1[var_34_2.id] = var_34_2

		return
	end)()

	pairs = var_11

	for iter_32_8, iter_32_9 in var_11(arg_32_1:getTriggerSkills()) do
		local var_32_7 = {
			level = iter_32_9.level
		}

		ys = var_17
		var_32_7.id = var_17.Battle.BattleDataFunction.SkillTranform(arg_32_0, iter_32_9.id)
		var_32_1[var_32_7.id] = var_32_7
	end

	SYSTEM_WORLD = var_11

	local var_32_8 = arg_32_0 == var_11
	local var_32_9 = false

	if var_32_8 then
		WorldConst = var_13

		if var_13.FetchWorldShip(arg_32_1.id) then
			var_32_9 = var_13:IsBroken()
		end
	end

	if var_32_9 then
		pairs = var_13

		for iter_32_10, iter_32_11 in var_13(var_32_1) do
			pg = var_1_10018

			local var_32_10 = var_1_10018.skill_data_template[iter_32_10].world_death_mark[1]

			ys = var_1_10020

			if var_32_10 == var_1_10020.Battle.BattleConst.DEATH_MARK_SKILL.DEACTIVE then
				var_32_1[iter_32_10] = nil
			else
				ys = var_1_10020

				if var_32_10 == var_1_10020.Battle.BattleConst.DEATH_MARK_SKILL.IGNORE then
					-- block empty
				end
			end
		end
	end

	return {
		id = arg_32_1.id,
		tmpID = arg_32_1.configId,
		skinId = arg_32_1.skinId,
		level = arg_32_1.level,
		equipment = var_32_0,
		properties = arg_32_1:getProperties(arg_32_2, arg_32_3, var_32_8),
		baseProperties = arg_32_1:getShipProperties(),
		proficiency = arg_32_1:getEquipProficiencyList(),
		rarity = arg_32_1:getRarity(),
		intimacy = arg_32_1:getCVIntimacy(),
		shipGS = arg_32_1:getShipCombatPower(),
		skills = var_32_1,
		baseList = arg_32_1:getBaseList(),
		preloasList = arg_32_1:getPreLoadCount(),
		name = arg_32_1:getName(),
		deathMark = var_32_9,
		spWeapon = var_32_6
	}
end

local function var_0_3(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:getProperties(arg_35_1)
	local var_35_1 = arg_35_0:getConfig("id")

	return {
		shipGS = 100,
		intimacy = 100,
		rarity = 1,
		deathMark = false,
		id = var_35_1,
		tmpID = var_35_1,
		skinId = arg_35_0:getConfig("skin_id"),
		level = arg_35_0:getConfig("level"),
		equipment = arg_35_0:getConfig("default_equip"),
		properties = var_35_0,
		baseProperties = var_35_0,
		proficiency = {
			1,
			1,
			1
		},
		skills = {},
		baseList = {
			1,
			1,
			1
		},
		preloasList = {
			0,
			0,
			0
		},
		name = var_35_1,
		fleetIndex = arg_35_0:getConfig("location")
	}
end

function var_0_1.GenBattleData(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = arg_36_0.contextData.system

	arg_36_0._battleData = var_36_0
	var_36_0.battleType = arg_36_0.contextData.system
	var_36_0.StageTmpId = arg_36_0.contextData.stageId
	var_36_0.CMDArgs = arg_36_0.contextData.cmdArgs
	var_36_0.isMemory = arg_36_0.contextData.memory
	var_36_0.MainUnitList = {}
	var_36_0.VanguardUnitList = {}
	var_36_0.SubUnitList = {}
	var_36_0.AidUnitList = {}
	var_36_0.SupportUnitList = {}
	var_36_0.SubFlag = -1
	var_36_0.ActID = arg_36_0.contextData.actId
	var_36_0.bossLevel = arg_36_0.contextData.bossLevel
	var_36_0.bossConfigId = arg_36_0.contextData.bossConfigId
	pg = var_3

	local var_36_2 = var_3.battle_cost_template[var_36_1].global_buff_effected

	if 0 < var_36_2 then
		BuffHelper = var_36_2
		var_36_2 = var_36_2.GetBattleBuffs(var_36_1)
		underscore = var_4
		var_36_0.GlobalBuffIDs = var_4.filter(var_36_2, function(arg_37_0)
			local var_37_0
			local var_37_1 = {
				"dungeon"
			}
			local var_37_2 = var_36_1

			SYSTEM_SCENARIO = var_2_10004

			if var_37_2 == var_2_10004 then
				table = var_37_2

				var_37_2.insert(var_37_1, "chapter")

				getProxy = var_37_2
				ChapterProxy = var_5

				local var_37_3 = var_37_2(var_5)

				var_37_0 = var_37_2.getActiveChapter(var_37_3).id
			end

			underscore = var_37_2

			return var_37_2.all(var_37_1, function(arg_38_0)
				switch = var_3_10001

				return var_3_10001(arg_38_0, {
					chapter = function()
						local var_39_0 = arg_37_0

						return var_0.checkChaper(var_39_0, var_37_0)
					end,
					dungeon = function()
						local var_40_0 = arg_37_0

						return var_0.checkDungeon(var_40_0, arg_36_0.contextData.stageId)
					end
				}, function()
					return false
				end)
			end)
		end)
	end

	pg = var_36_2

	local var_36_3 = var_36_2.battle_cost_template[var_36_1]

	getProxy = var_4
	BayProxy = var_1_10006

	local var_36_4 = var_4(var_1_10006)
	local var_36_5 = {}

	SYSTEM_SCENARIO = var_1_10006

	if var_36_1 == var_1_10006 then
		getProxy = var_1_10006
		ChapterProxy = var_1_10008
		var_1_10009 = var_1_10006(var_1_10008)
		var_1_10010 = var_1_10006.getActiveChapter(var_1_10009)
		var_36_0.RepressInfo = var_1_10007.getRepressInfo(var_1_10010)
		var_1_10010 = arg_36_0.viewComponent

		var_1_10008.setChapter(var_1_10010, var_1_10007)

		var_1_10008 = var_1_10007.fleet
		var_36_0.KizunaJamming = var_1_10007:getExtraFlags()
		var_36_0.DefeatCount = var_1_10008:getDefeatCount()
		var_1_10009, var_1_10010 = var_1_10007:getFleetBattleBuffs(var_1_10008)
		var_36_0.CommanderList = var_1_10010
		var_36_0.ChapterBuffIDs = var_1_10009
		var_36_0.StageWaveFlags = var_1_10007:GetStageFlags()
		var_36_0.ChapterWeatherIDS = var_1_10007:GetWeather(var_1_10008.line.row, var_1_10008.line.column)
		var_36_0.MapAuraSkills = var_1_10006.GetChapterAuraBuffs(var_1_10007)
		var_36_0.MapAidSkills = {}
		var_36_0.ChapterType = var_1_10007:getPlayType()
		var_1_10009 = var_1_10006.GetChapterAidBuffs(var_1_10007)
		pairs = var_1_10010

		for iter_36_0, iter_36_1 in var_1_10010(var_1_10009) do
			iter_36_19 = var_1_10007
			var_1_10015 = var_1_10007.getFleetByShipVO(iter_36_19, iter_36_0)
			_ = iter_36_18
			iter_36_18 = iter_36_18.values
			var_1_10020 = var_1_10015
			iter_36_18 = iter_36_18(var_1_10015.getCommanders(var_1_10020))
			iter_36_19 = var_0_2(var_36_1, iter_36_0, iter_36_18)
			table = var_1_10018

			var_1_10018.insert(var_36_0.AidUnitList, iter_36_19)

			ipairs = var_1_10018

			for iter_36_17, iter_36_41 in var_1_10018(iter_36_1) do
				table = iter_36_10

				iter_36_10.insert(var_36_0.MapAidSkills, iter_36_41)
			end
		end

		var_1_10012 = var_1_10008
		var_1_10010 = var_1_10008.getShipsByTeam
		TeamType = iter_36_0
		var_1_10010 = var_1_10010(var_1_10012, iter_36_0.Main, false)

		local var_36_6 = var_1_10008
		local var_36_7 = var_1_10008.getShipsByTeam

		TeamType = var_14

		local var_36_8 = var_36_7(var_36_6, var_14.Vanguard, false)

		var_1_10012 = {}
		_ = var_36_6

		local var_36_9 = var_36_6.values

		iter_36_19 = var_1_10008

		local var_36_10 = var_36_9(var_1_10008.getCommanders(iter_36_19))
		local var_36_11 = {}

		var_1_10015, iter_36_18 = var_1_10006.getSubAidFlag(var_1_10007, arg_36_0.contextData.stageId)

		if var_1_10015 == true or 0 < var_1_10015 then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
			iter_36_62 = iter_36_18
			iter_36_19 = iter_36_18.getShipsByTeam
			TeamType = var_1_10020
			var_1_10012 = iter_36_19(iter_36_62, var_1_10020.Submarine, false)
			_ = iter_36_19
			iter_36_19 = iter_36_19.values
			iter_36_17 = iter_36_18
			var_36_11 = iter_36_19(iter_36_18.getCommanders(iter_36_17))
			iter_36_62 = var_1_10007
			iter_36_19, var_1_10018 = var_1_10007.getFleetBattleBuffs(iter_36_62, iter_36_18)
			var_36_0.SubCommanderList = var_1_10018
		else
			var_36_0.SubFlag = var_1_10015
			ys = iter_36_19

			if var_1_10015 ~= iter_36_19.Battle.BattleConst.SubAidFlag.AID_EMPTY then
				var_36_0.TotalSubAmmo = 0
			end
		end

		arg_36_0.mainShips = {}

		function iter_36_19(arg_42_0, arg_42_1, arg_42_2)
			local var_42_0 = arg_42_0.id
			local var_42_1 = arg_42_0.hpRant * 0.0001

			table = var_2_10005

			if var_2_10005.contains(var_36_5, var_42_0) then
				BattleVertify = var_5
				var_5.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = var_42_0

			local var_42_2 = var_0_2(var_36_1, arg_42_0, arg_42_1)

			var_42_2.initHPRate = var_42_1
			table = var_6

			var_6.insert(arg_36_0.mainShips, arg_42_0)

			table = var_6

			var_6.insert(arg_42_2, var_42_2)

			return
		end

		ipairs = var_1_10018

		for iter_36_17, iter_36_41 in var_1_10018(var_1_10010) do
			iter_36_19(iter_36_41, var_36_10, var_36_0.MainUnitList)
		end

		ipairs = var_1_10018

		for iter_36_17, iter_36_41 in var_1_10018(var_36_8) do
			iter_36_19(iter_36_41, var_36_10, var_36_0.VanguardUnitList)
		end

		ipairs = var_1_10018

		for iter_36_17, iter_36_41 in var_1_10018(var_1_10012) do
			iter_36_19(iter_36_41, var_36_11, var_36_0.SubUnitList)
		end

		local var_36_12 = var_1_10007

		if var_1_10007.getChapterSupportFleet(var_36_12) then
			iter_36_17 = var_1_10018
			iter_36_62 = var_1_10018.getShips(iter_36_17)
			pairs = var_36_12

			for iter_36_10, iter_36_11 in var_36_12(iter_36_62) do
				iter_36_19(iter_36_11, {}, var_36_0.SupportUnitList)
			end
		end

		iter_36_17 = arg_36_0.viewComponent

		iter_36_62.setFleet(iter_36_17, var_1_10010, var_36_8, var_1_10012)

		goto label_36_0
	end

	SYSTEM_CHALLENGE = var_1_10006

	if var_36_1 == var_1_10006 then
		var_1_10006 = arg_36_0.contextData.mode
		getProxy = var_1_10007
		ChallengeProxy = var_1_10009
		var_1_10010 = var_1_10007(var_1_10009)
		var_36_0.ChallengeInfo = var_1_10007.getUserChallengeInfo(var_1_10010, var_1_10006)

		local var_36_13 = arg_36_0.viewComponent

		var_1_10009.setChapter(var_36_13, var_1_10008)

		var_1_10012 = var_1_10008:getRegularFleet()
		var_36_0.CommanderList = var_1_10009.buildBattleBuffList(var_1_10012)
		_ = var_1_10010
		var_1_10010 = var_1_10010.values(var_1_10009:getCommanders())

		local var_36_14 = {}
		local var_36_15 = var_1_10009

		var_1_10012 = var_1_10009.getShipsByTeam
		TeamType = var_1_10015
		var_1_10012 = var_1_10012(var_36_15, var_1_10015.Main, false)

		local var_36_16 = var_1_10009
		local var_36_17 = var_1_10009.getShipsByTeam

		TeamType = iter_36_18

		local var_36_18 = var_36_17(var_36_16, iter_36_18.Vanguard, false)
		local var_36_19 = {}

		iter_36_19 = var_1_10008
		var_1_10018 = var_1_10008.getSubmarineFleet(iter_36_19)
		iter_36_18 = var_15.getShipsByTeam
		TeamType = iter_36_62
		iter_36_18 = #iter_36_18(var_1_10018, iter_36_62.Submarine, false)

		if 0 < iter_36_18 then
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
			_ = iter_36_18
			var_36_14 = iter_36_18.values(var_15:getCommanders())
			var_1_10018 = var_15
			var_36_0.SubCommanderList = var_15.buildBattleBuffList(var_1_10018)
		else
			var_36_0.SubFlag = 0
			var_36_0.TotalSubAmmo = 0
		end

		arg_36_0.mainShips = {}

		function iter_36_18(arg_43_0, arg_43_1, arg_43_2)
			local var_43_0 = arg_43_0.id
			local var_43_1 = arg_43_0.hpRant * 0.0001

			table = var_2_10005

			if var_2_10005.contains(var_36_5, var_43_0) then
				BattleVertify = var_5
				var_5.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = var_43_0

			local var_43_2 = var_0_2(var_36_1, arg_43_0, arg_43_1)

			var_43_2.initHPRate = var_43_1
			table = var_6

			var_6.insert(arg_36_0.mainShips, arg_43_0)

			table = var_6

			var_6.insert(arg_43_2, var_43_2)

			return
		end

		ipairs = iter_36_19

		for iter_36_12, iter_36_17 in iter_36_19(var_1_10012) do
			iter_36_18(iter_36_17, var_1_10010, var_36_0.MainUnitList)
		end

		ipairs = iter_36_19

		for iter_36_14, iter_36_17 in iter_36_19(var_36_18) do
			iter_36_18(iter_36_17, var_1_10010, var_36_0.VanguardUnitList)
		end

		ipairs = iter_36_19

		for iter_36_16, iter_36_17 in iter_36_19(var_14) do
			iter_36_18(iter_36_17, var_36_14, var_36_0.SubUnitList)
		end

		iter_36_62 = arg_36_0.viewComponent

		iter_36_19.setFleet(iter_36_62, var_1_10012, var_36_18, var_14)

		goto label_36_0
	end

	SYSTEM_WORLD = var_1_10006

	if var_36_1 == var_1_10006 then
		nowWorld = var_1_10006
		var_1_10009 = var_1_10006()
		var_1_10010 = var_1_10006.GetActiveMap(var_1_10009)
		var_1_10008 = var_1_10007.GetFleet(var_1_10010)
		var_1_10012 = var_1_10007:GetCell(var_1_10008.row, var_1_10008.column)
		var_1_10010 = var_1_10009.GetStageEnemy(var_1_10012)

		if arg_36_0.contextData.hpRate then
			var_36_0.RepressInfo = {
				repressEnemyHpRant = arg_36_0.contextData.hpRate
			}
		end

		table = var_11

		local var_36_20 = var_11.mergeArray
		local var_36_21 = var_1_10010:GetBattleLuaBuffs()

		iter_36_18 = var_1_10007

		local var_36_22 = var_1_10007.GetBattleLuaBuffs

		WorldMap = iter_36_19
		var_36_0.AffixBuffList = var_36_20(var_36_21, var_36_22(iter_36_18, iter_36_19.FactionEnemy, var_1_10010))

		local function var_36_23(arg_44_0)
			local var_44_0 = {}

			ipairs = var_2_10002

			for iter_44_0, iter_44_1 in var_2_10002(arg_44_0) do
				local var_44_1 = {}

				ys = var_2_10008
				var_44_1.id = var_2_10008.Battle.BattleDataFunction.SkillTranform(var_36_1, iter_44_1.id)
				var_44_1.level = iter_44_1.level
				table = var_2_10008

				var_2_10008.insert(var_44_0, var_44_1)
			end

			return var_44_0
		end

		var_36_0.DefeatCount = var_1_10008:getDefeatCount()

		local var_36_24

		var_1_10012, var_36_24 = var_1_10007:getFleetBattleBuffs(var_1_10008, true)
		var_36_0.CommanderList = var_36_24
		var_36_0.ChapterBuffIDs = var_1_10012
		var_36_0.MapAuraSkills = var_1_10007:GetChapterAuraBuffs()
		var_36_0.MapAuraSkills = var_36_23(var_36_0.MapAuraSkills)
		var_36_0.MapAidSkills = {}
		var_1_10012 = var_1_10007:GetChapterAidBuffs()
		pairs = var_36_24

		for iter_36_18, iter_36_19 in var_36_24(var_1_10012) do
			var_1_10018 = var_1_10007:GetFleet(iter_36_18.fleetId)
			_ = iter_36_62
			iter_36_62 = iter_36_62.values
			iter_36_10 = var_1_10018
			iter_36_62 = iter_36_62(var_1_10018.getCommanders(iter_36_10, true))

			local var_36_25 = var_0_2

			iter_36_41 = var_36_1
			WorldConst = iter_36_10

			local var_36_26 = var_36_25(iter_36_41, iter_36_10.FetchShipVO(iter_36_18.id), iter_36_62)

			table = iter_36_17

			iter_36_17.insert(var_36_0.AidUnitList, var_36_26)

			table = iter_36_17
			var_36_0.MapAidSkills = iter_36_17.mergeArray(var_36_0.MapAidSkills, var_36_23(iter_36_19))
		end

		local var_36_27 = var_1_10008
		local var_36_28 = var_1_10008.GetTeamShipVOs

		TeamType = iter_36_18

		local var_36_29 = var_36_28(var_36_27, iter_36_18.Main, false)

		iter_36_18 = var_1_10008

		local var_36_30 = var_1_10008.GetTeamShipVOs

		TeamType = iter_36_19

		local var_36_31 = var_36_30(iter_36_18, iter_36_19.Vanguard, false)
		local var_36_32 = {}

		_ = iter_36_18
		iter_36_18 = iter_36_18.values(var_1_10008:getCommanders(true))
		iter_36_19 = {}

		if var_1_10006:GetSubAidFlag() == true then
			iter_36_17 = var_1_10007
			iter_36_62 = var_1_10007.GetSubmarineFleet(iter_36_17)
			var_36_0.SubFlag = 1
			var_36_0.TotalSubAmmo = 1
			iter_36_41 = iter_36_62

			local var_36_33 = iter_36_62.GetTeamShipVOs

			TeamType = iter_36_10
			var_36_32 = var_36_33(iter_36_41, iter_36_10.Submarine, false)
			_ = var_20

			local var_36_34 = var_20.values

			iter_36_11 = iter_36_62
			iter_36_19 = var_36_34(iter_36_62.getCommanders(iter_36_11, true))
			iter_36_41 = var_1_10007

			local var_36_35

			var_36_35, iter_36_17 = var_1_10007.getFleetBattleBuffs(iter_36_41, iter_36_62, true)
			var_36_0.SubCommanderList = iter_36_17
		else
			var_36_0.SubFlag = 0
			ys = iter_36_62

			if var_1_10018 ~= iter_36_62.Battle.BattleConst.SubAidFlag.AID_EMPTY then
				var_36_0.TotalSubAmmo = 0
			end
		end

		arg_36_0.mainShips = {}
		ipairs = iter_36_62

		for iter_36_41, iter_36_21 in iter_36_62(var_36_29) do
			iter_36_11 = iter_36_21.id
			WorldConst = var_1_10025
			var_1_10025 = var_1_10025.FetchWorldShip(iter_36_21.id).hpRant * 0.0001
			table = var_1_10026

			if var_1_10026.contains(var_36_5, iter_36_11) then
				BattleVertify = var_1_10026
				var_1_10026.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = iter_36_11
			var_1_10026 = var_0_2(var_36_1, iter_36_21, iter_36_18)
			var_1_10026.initHPRate = var_1_10025
			table = var_1_10027

			var_1_10027.insert(arg_36_0.mainShips, iter_36_21)

			table = var_1_10027

			var_1_10027.insert(var_36_0.MainUnitList, var_1_10026)
		end

		ipairs = iter_36_62

		for iter_36_41, iter_36_23 in iter_36_62(var_36_31) do
			iter_36_11 = iter_36_23.id
			WorldConst = var_1_10025
			var_1_10025 = var_1_10025.FetchWorldShip(iter_36_23.id).hpRant * 0.0001
			table = var_1_10026

			if var_1_10026.contains(var_36_5, iter_36_11) then
				BattleVertify = var_1_10026
				var_1_10026.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = iter_36_11
			var_1_10026 = var_0_2(var_36_1, iter_36_23, iter_36_18)
			var_1_10026.initHPRate = var_1_10025
			table = var_1_10027

			var_1_10027.insert(arg_36_0.mainShips, iter_36_23)

			table = var_1_10027

			var_1_10027.insert(var_36_0.VanguardUnitList, var_1_10026)
		end

		ipairs = iter_36_62

		for iter_36_41, iter_36_25 in iter_36_62(var_36_32) do
			iter_36_11 = iter_36_25.id
			WorldConst = var_1_10025
			var_1_10025 = var_1_10025.FetchWorldShip(iter_36_25.id).hpRant * 0.0001
			table = var_1_10026

			if var_1_10026.contains(var_36_5, iter_36_11) then
				BattleVertify = var_1_10026
				var_1_10026.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = iter_36_11
			var_1_10026 = var_0_2(var_36_1, iter_36_25, iter_36_19)
			var_1_10026.initHPRate = var_1_10025
			table = var_1_10027

			var_1_10027.insert(arg_36_0.mainShips, iter_36_25)

			table = var_1_10027

			var_1_10027.insert(var_36_0.SubUnitList, var_1_10026)
		end

		iter_36_17 = arg_36_0.viewComponent

		iter_36_62.setFleet(iter_36_17, var_36_29, var_36_31, var_36_32)

		pg = iter_36_62

		local var_36_36 = iter_36_62.expedition_data_template[arg_36_0.contextData.stageId].difficulty

		ys = iter_36_17

		if var_36_36 == iter_36_17.Battle.BattleConst.Difficulty.WORLD then
			var_36_0.WorldMapId = var_1_10007.config.expedition_map_id
			WorldConst = var_20
			var_36_0.WorldLevel = var_20.WorldLevelCorrect(var_1_10007.config.expedition_level, iter_36_62.type)
		end

		goto label_36_0
	end

	SYSTEM_WORLD_BOSS = var_1_10006

	if var_36_1 == var_1_10006 then
		nowWorld = var_1_10006
		var_1_10009 = var_1_10006()
		var_1_10007 = var_1_10006.GetBossProxy(var_1_10009)
		var_1_10008 = arg_36_0.contextData.bossId
		var_1_10009 = var_1_10007:GetFleet(var_1_10008)
		var_1_10012 = var_1_10007
		var_1_10010 = var_1_10007.GetBossById(var_1_10012, var_1_10008)

		if arg_36_0.contextData.hpRate then
			var_36_0.RepressInfo = {
				repressEnemyHpRant = arg_36_0.contextData.hpRate
			}
		end

		_ = var_11

		local var_36_37 = var_11.values(var_1_10009:getCommanders())

		var_36_0.CommanderList = var_1_10009:buildBattleBuffList()
		arg_36_0.mainShips = var_36_4:getShipsByFleet(var_1_10009)
		var_1_10012 = {}

		local var_36_38 = {}
		local var_36_39 = {}

		iter_36_19 = var_1_10009

		local var_36_40 = var_1_10009.getTeamByName

		TeamType = var_1_10018

		local var_36_41 = var_36_40(iter_36_19, var_1_10018.Main)

		ipairs = iter_36_18

		for iter_36_62, iter_36_27 in iter_36_18(var_36_41) do
			table = iter_36_17

			if iter_36_17.contains(var_36_5, iter_36_27) then
				BattleVertify = iter_36_17
				iter_36_17.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = iter_36_27

			local var_36_42 = var_36_4

			iter_36_17 = var_36_4.getShipById(var_36_42, iter_36_27)
			iter_36_41 = var_0_2(var_36_1, iter_36_17, var_36_37)
			table = var_36_42

			var_36_42.insert(var_1_10012, iter_36_17)

			table = var_23

			var_23.insert(var_36_0.MainUnitList, iter_36_41)
		end

		var_1_10018 = var_1_10009
		iter_36_18 = var_1_10009.getTeamByName
		TeamType = iter_36_62
		iter_36_18 = iter_36_18(var_1_10018, iter_36_62.Vanguard)
		ipairs = iter_36_19

		for iter_36_28, iter_36_29 in iter_36_19(iter_36_18) do
			table = iter_36_41

			if iter_36_41.contains(var_36_5, iter_36_29) then
				BattleVertify = iter_36_41
				iter_36_41.cloneShipVertiry = true
			end

			var_36_5[#var_36_5 + 1] = iter_36_29
			iter_36_11 = var_36_4
			iter_36_41 = var_36_4.getShipById(iter_36_11, iter_36_29)

			local var_36_43 = var_0_2(var_36_1, iter_36_41, var_36_37)

			table = iter_36_11

			iter_36_11.insert(var_36_38, iter_36_41)

			table = iter_36_11

			iter_36_11.insert(var_36_0.VanguardUnitList, var_36_43)
		end

		iter_36_62 = arg_36_0.viewComponent

		iter_36_19.setFleet(iter_36_62, var_1_10012, var_36_38, var_36_39)

		var_36_0.MapAidSkills = {}

		if var_1_10010 then
			iter_36_62 = var_1_10010

			if var_1_10010.IsSelf(iter_36_62) then
				iter_36_19, var_1_10018, iter_36_62 = var_1_10007.GetSupportValue()

				if iter_36_19 then
					table = var_20

					var_20.insert(var_36_0.MapAidSkills, {
						level = 1,
						id = iter_36_62
					})
				end
			end
		end

		goto label_36_0
	end

	SYSTEM_HP_SHARE_ACT_BOSS = var_1_10006

	if var_36_1 ~= var_1_10006 then
		SYSTEM_ACT_BOSS = var_1_10006

		if var_36_1 ~= var_1_10006 then
			SYSTEM_ACT_BOSS_SP = var_1_10006

			if var_36_1 ~= var_1_10006 then
				SYSTEM_BOSS_EXPERIMENT = var_1_10006

				if var_36_1 == var_1_10006 then
					if arg_36_0.contextData.mainFleetId then
						getProxy = var_1_10006
						FleetProxy = var_1_10008
						var_1_10009 = var_1_10006(var_1_10008)
						var_1_10008 = var_1_10006.getActivityFleets(var_1_10009)[arg_36_0.contextData.actId][arg_36_0.contextData.mainFleetId]
						_ = var_1_10009
						var_1_10009 = var_1_10009.values(var_1_10008:getCommanders())
						var_1_10012 = var_1_10008
						var_36_0.CommanderList = var_1_10008.buildBattleBuffList(var_1_10012)
						arg_36_0.mainShips = {}
						var_1_10010 = {}

						local var_36_44 = {}

						var_1_10012 = {}

						local function var_36_45(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
							table = var_2_10004

							if var_2_10004.contains(var_36_5, arg_45_0) then
								BattleVertify = var_4
								var_4.cloneShipVertiry = true
							end

							var_36_5[#var_36_5 + 1] = arg_45_0

							local var_45_0 = var_36_4
							local var_45_1 = var_4.getShipById(var_45_0, arg_45_0)
							local var_45_2 = var_0_2(var_36_1, var_45_1, arg_45_1)

							table = var_45_0

							var_45_0.insert(arg_36_0.mainShips, var_45_1)

							table = var_6

							var_6.insert(arg_45_3, var_45_1)

							table = var_6

							var_6.insert(arg_45_2, var_45_2)

							return
						end

						iter_36_18 = var_1_10008

						local var_36_46 = var_1_10008.getTeamByName

						TeamType = iter_36_19

						local var_36_47 = var_36_46(iter_36_18, iter_36_19.Main)

						iter_36_19 = var_1_10008

						local var_36_48 = var_1_10008.getTeamByName

						TeamType = var_1_10018

						local var_36_49 = var_36_48(iter_36_19, var_1_10018.Vanguard)

						ipairs = iter_36_18

						for iter_36_62, iter_36_31 in iter_36_18(var_36_47) do
							var_36_45(iter_36_31, var_1_10009, var_36_0.MainUnitList, var_1_10010)
						end

						ipairs = iter_36_18

						for iter_36_62, iter_36_33 in iter_36_18(var_36_49) do
							var_36_45(iter_36_33, var_1_10009, var_36_0.VanguardUnitList, var_36_44)
						end

						iter_36_18 = var_1_10007[arg_36_0.contextData.mainFleetId + 10]
						_ = iter_36_19
						iter_36_19 = iter_36_19.values

						local var_36_50 = iter_36_18

						iter_36_19 = iter_36_19(iter_36_18.getCommanders(var_36_50))

						local var_36_51 = iter_36_18

						var_1_10018 = iter_36_18.getTeamByName
						TeamType = var_36_50
						var_1_10018 = var_1_10018(var_36_51, var_36_50.Submarine)
						ipairs = iter_36_62

						for iter_36_41, iter_36_35 in iter_36_62(var_1_10018) do
							var_36_45(iter_36_35, iter_36_19, var_36_0.SubUnitList, var_1_10012)
						end

						getProxy = iter_36_62
						PlayerProxy = var_21
						iter_36_41 = iter_36_62(var_21)

						local var_36_52 = iter_36_62.getRawData(iter_36_41)

						getProxy = var_21
						ActivityProxy = iter_36_35

						local var_36_53 = var_21(iter_36_35)

						iter_36_11 = var_21.getActivityById(var_36_53, arg_36_0.contextData.actId)
						iter_36_41 = var_21.getConfig(iter_36_11, "config_id")
						pg = var_36_53
						iter_36_11 = var_36_53.activity_event_worldboss[iter_36_41].use_oil_limit[arg_36_0.contextData.mainFleetId]
						var_1_10027 = var_21
						var_1_10025 = var_21.IsOilLimit(var_1_10027, arg_36_0.contextData.stageId)

						local var_36_54 = 0

						var_1_10027 = var_36_3.oil_cost > 0

						local function var_36_55(arg_46_0, arg_46_1)
							if var_1_10027 then
								local var_46_0 = arg_46_0
								local var_46_1 = arg_46_0.getEndCost(var_46_0).oil

								if arg_46_1 > 0 then
									local var_46_2 = arg_46_0:getStartCost().oil

									math = var_46_0

									local var_46_3 = var_46_0.clamp(arg_46_1 - var_46_2, 0, var_46_1)
									local var_46_4 = cost
								end

								var_36_54 = var_36_54 + var_46_1
							end

							return
						end

						SYSTEM_ACT_BOSS_SP = var_1_10029

						if var_36_1 == var_1_10029 then
							getProxy = var_1_10029
							ActivityProxy = var_1_10031

							local var_36_56 = var_1_10029(var_1_10031)

							var_1_10029 = var_1_10029.GetActivityBossRuntime(var_36_56, arg_36_0.contextData.actId).buffIds
							_ = var_1_10030

							local var_36_57 = var_1_10030.map(var_1_10029, function(arg_47_0)
								ActivityBossBuff = var_2_10001

								return var_2_10001.New({
									configId = arg_47_0
								})
							end)

							_ = var_36_56

							local var_36_58 = var_36_56.map

							_ = var_33
							var_36_0.ExtraBuffList = var_36_58(var_33.select(var_36_57, function(arg_48_0)
								return arg_48_0:CastOnEnemy()
							end), function(arg_49_0)
								return arg_49_0:GetBuffID()
							end)
							_ = var_31

							local var_36_59 = var_31.map

							_ = var_33
							var_36_0.ChapterBuffIDs = var_36_59(var_33.select(var_36_57, function(arg_50_0)
								return not arg_50_0:CastOnEnemy()
							end), function(arg_51_0)
								return arg_51_0:GetBuffID()
							end)
						else
							var_1_10029 = var_36_55

							local var_36_60 = var_1_10008
							local var_36_61

							if not var_1_10025 or not iter_36_11[1] then
								var_36_61 = 0
							end

							var_1_10029(var_36_60, var_36_61)

							var_1_10029 = var_36_55

							local var_36_62 = iter_36_18
							local var_36_63

							if not var_1_10025 or not iter_36_11[2] then
								var_36_63 = 0
							end

							var_1_10029(var_36_62, var_36_63)
						end

						if iter_36_18:isLegalToFight() == true then
							SYSTEM_BOSS_EXPERIMENT = var_1_10029

							if var_36_1 == var_1_10029 or var_36_54 <= var_36_52.oil then
								var_36_0.SubFlag = 1
								var_36_0.TotalSubAmmo = 1
							end
						end

						var_36_0.SubCommanderList = iter_36_18:buildBattleBuffList()

						local var_36_64 = arg_36_0.viewComponent

						var_1_10029.setFleet(var_36_64, var_1_10010, var_36_44, var_1_10012)
					end

					goto label_36_0
				end

				SYSTEM_GUILD = var_1_10006

				if var_36_1 == var_1_10006 then
					getProxy = var_1_10006
					GuildProxy = var_1_10008
					var_1_10009 = var_1_10006(var_1_10008)
					var_1_10009 = var_1_10006.getRawData(var_1_10009)
					var_1_10010 = var_1_10007.GetActiveEvent(var_1_10009)

					local var_36_65 = var_1_10007.GetBossMission(var_1_10010)

					var_1_10009 = var_1_10008.GetMainFleet(var_36_65)
					_ = var_1_10010
					var_1_10010 = var_1_10010.values(var_1_10009:getCommanders())
					var_36_0.CommanderList = var_1_10009:BuildBattleBuffList()
					arg_36_0.mainShips = {}

					local var_36_66 = {}

					var_1_10012 = {}

					local var_36_67 = {}

					local function var_36_68(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
						local var_52_0 = var_0_2(var_36_1, arg_52_0, arg_52_1)

						table = var_2_10005

						var_2_10005.insert(arg_36_0.mainShips, arg_52_0)

						table = var_5

						var_5.insert(arg_52_3, arg_52_0)

						table = var_5

						var_5.insert(arg_52_2, var_52_0)

						return
					end

					local var_36_69 = {}

					iter_36_18 = {}
					iter_36_62 = var_1_10009
					iter_36_19 = var_1_10009.GetShips(iter_36_62)
					pairs = var_1_10018

					for iter_36_36, iter_36_41 in var_1_10018(iter_36_19) do
						local var_36_70 = iter_36_41.ship

						iter_36_11 = var_23.getTeamType(var_36_70)
						TeamType = var_1_10025

						if iter_36_11 == var_1_10025.Main then
							table = iter_36_11

							iter_36_11.insert(var_36_69, var_23)
						else
							iter_36_11 = var_23:getTeamType()
							TeamType = var_1_10025

							if iter_36_11 == var_1_10025.Vanguard then
								table = iter_36_11

								iter_36_11.insert(iter_36_18, var_23)
							end
						end
					end

					ipairs = var_1_10018

					for iter_36_38, iter_36_41 in var_1_10018(var_36_69) do
						var_36_68(iter_36_41, var_1_10010, var_36_0.MainUnitList, var_36_66)
					end

					ipairs = var_1_10018

					for iter_36_40, iter_36_41 in var_1_10018(iter_36_18) do
						var_36_68(iter_36_41, var_1_10010, var_36_0.VanguardUnitList, var_1_10012)
					end

					var_1_10018 = var_1_10008:GetSubFleet()
					_ = iter_36_62
					iter_36_62 = iter_36_62.values(var_1_10018:getCommanders())

					local var_36_71 = {}
					local var_36_72 = var_1_10018:GetShips()

					pairs = iter_36_41

					for iter_36_42, iter_36_43 in iter_36_41(var_36_72) do
						local var_36_73 = iter_36_43.ship
						local var_36_74 = var_1_10027.getTeamType(var_36_73)

						TeamType = var_1_10029

						if var_36_74 == var_1_10029.Submarine then
							table = var_36_74

							var_36_74.insert(var_36_71, var_1_10027)
						end
					end

					ipairs = iter_36_41

					for iter_36_44, iter_36_45 in iter_36_41(var_36_71) do
						var_36_68(iter_36_45, iter_36_62, var_36_0.SubUnitList, var_36_67)
					end

					if #var_36_67 > 0 then
						var_36_0.SubFlag = 1
						var_36_0.TotalSubAmmo = 1
					end

					iter_36_11 = var_1_10018
					var_36_0.SubCommanderList = var_1_10018.BuildBattleBuffList(iter_36_11)
					iter_36_11 = arg_36_0.viewComponent

					iter_36_41.setFleet(iter_36_11, var_36_66, var_1_10012, var_36_67)

					goto label_36_0
				end

				SYSTEM_BOSS_RUSH = var_1_10006

				if var_36_1 ~= var_1_10006 then
					SYSTEM_BOSS_RUSH_EX = var_1_10006

					if var_36_1 ~= var_1_10006 then
						SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10006

						if var_36_1 == var_1_10006 then
							getProxy = var_1_10006
							ActivityProxy = var_1_10008
							var_1_10008 = var_1_10006(var_1_10008)
							var_1_10009 = var_1_10006.getActivityById(var_1_10008, arg_36_0.contextData.actId)
							var_1_10007 = var_1_10006.GetSeriesData(var_1_10009)
							assert = var_1_10008

							var_1_10008(var_1_10007)

							var_1_10010 = var_1_10007
							var_1_10008 = var_1_10007.GetStaegLevel(var_1_10010) + 1
							var_1_10009 = var_1_10007:GetMode()
							var_1_10012 = var_1_10007

							local var_36_75

							var_1_10010, var_36_75 = var_1_10007.GetStageFleets(var_1_10012, var_1_10009, var_1_10008)
							getProxy = var_1_10012
							FleetProxy = var_14

							local var_36_76 = var_1_10012(var_14)
							local var_36_77 = var_1_10012.getActivityFleets(var_36_76)[arg_36_0.contextData.actId]

							arg_36_0.mainShips = {}

							local var_36_78 = {}
							local var_36_79 = {}

							iter_36_18 = {}

							function iter_36_19(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
								table = var_2_10004

								if var_2_10004.contains(var_36_5, arg_53_0) then
									BattleVertify = var_4
									var_4.cloneShipVertiry = true
								end

								var_36_5[#var_36_5 + 1] = arg_53_0

								local var_53_0 = var_36_4
								local var_53_1 = var_4.getShipById(var_53_0, arg_53_0)
								local var_53_2 = var_0_2(var_36_1, var_53_1, arg_53_1)

								table = var_53_0

								var_53_0.insert(arg_36_0.mainShips, var_53_1)

								table = var_6

								var_6.insert(arg_53_3, var_53_1)

								table = var_6

								var_6.insert(arg_53_2, var_53_2)

								return
							end

							var_1_10018 = var_36_77[var_1_10010]
							_ = iter_36_62
							iter_36_62 = iter_36_62.values

							local var_36_80 = var_1_10018

							iter_36_62 = iter_36_62(var_1_10018.getCommanders(var_36_80))
							iter_36_41 = var_1_10018
							var_36_0.CommanderList = var_1_10018.buildBattleBuffList(iter_36_41)
							iter_36_41 = var_1_10018

							local var_36_81 = var_1_10018.getTeamByName

							TeamType = var_36_80

							local var_36_82 = var_36_81(iter_36_41, var_36_80.Main)
							local var_36_83 = var_1_10018
							local var_36_84 = var_1_10018.getTeamByName

							TeamType = iter_36_11

							local var_36_85 = var_36_84(var_36_83, iter_36_11.Vanguard)

							ipairs = iter_36_41

							for iter_36_46, iter_36_47 in iter_36_41(var_36_82) do
								iter_36_19(iter_36_47, iter_36_62, var_36_0.MainUnitList, var_36_78)
							end

							ipairs = iter_36_41

							for iter_36_48, iter_36_49 in iter_36_41(var_36_85) do
								iter_36_19(iter_36_49, iter_36_62, var_36_0.VanguardUnitList, var_36_79)
							end

							iter_36_41 = var_36_77[var_36_75]
							_ = var_23

							local var_36_86 = var_23.values

							var_1_10027 = iter_36_41

							local var_36_87 = var_36_86(iter_36_41.getCommanders(var_1_10027))

							var_36_0.SubCommanderList = iter_36_41:buildBattleBuffList()

							local var_36_88 = iter_36_41
							local var_36_89 = iter_36_41.getTeamByName

							TeamType = var_1_10027

							local var_36_90 = var_36_89(var_36_88, var_1_10027.Submarine)

							ipairs = var_25

							for iter_36_50, iter_36_51 in var_25(var_36_90) do
								iter_36_19(iter_36_51, var_36_87, var_36_0.SubUnitList, iter_36_18)
							end

							getProxy = var_25
							PlayerProxy = var_1_10027

							local var_36_91 = var_25(var_1_10027)
							local var_36_92 = var_25.getRawData(var_36_91)

							var_1_10027 = 0

							local var_36_93 = var_1_10007:GetOilLimit()
							local var_36_94 = var_36_3.oil_cost > 0

							var_1_10027 = var_1_10027 + (function(arg_54_0, arg_54_1)
								local var_54_0 = 0

								if var_36_94 then
									local var_54_1 = arg_54_0:getStartCost().oil

									var_54_0 = arg_54_0:getEndCost().oil

									if 0 < arg_54_1 then
										math = var_5
										var_54_0 = var_5.clamp(arg_54_1 - var_54_1, 0, var_4)
									end
								end

								return var_54_0
							end)(var_1_10018, var_36_93[1]) + var_30(iter_36_41, var_36_93[2])

							if iter_36_41:isLegalToFight() == true and var_1_10027 <= var_36_92.oil then
								var_36_0.SubFlag = 1
								var_36_0.TotalSubAmmo = 1
							end

							local var_36_95 = arg_36_0.viewComponent

							var_31.setFleet(var_36_95, var_36_78, var_36_79, iter_36_18)

							SYSTEM_BOSS_RUSH_COLLABRATE = var_31

							if var_36_1 == var_31 then
								var_36_0.ChapterBuffIDs = {}
								var_36_0.DALAidBuffIDs = {}

								local var_36_96 = var_1_10007:getConfig("aid_buff")

								if var_1_10007:GetBossHpRate() <= var_36_96[1] then
									table = var_32

									var_32.insert(var_36_0.DALAidBuffIDs, var_36_96[2])
								end
							end

							goto label_36_0
						end

						SYSTEM_LIMIT_CHALLENGE = var_1_10006

						if var_36_1 == var_1_10006 then
							LimitChallengeConst = var_1_10006
							var_1_10006 = var_1_10006.GetChallengeIDByStageID(arg_36_0.contextData.stageId)
							AcessWithinNull = var_1_10007
							pg = var_1_10009
							var_36_0.ExtraBuffList = var_1_10007(var_1_10009.expedition_constellation_challenge_template[var_1_10006], "buff_id")
							FleetProxy = var_1_10008
							var_1_10008 = var_1_10008.CHALLENGE_FLEET_ID
							FleetProxy = var_1_10009
							var_1_10009 = var_1_10009.CHALLENGE_SUB_FLEET_ID
							getProxy = var_1_10010
							FleetProxy = var_1_10012

							local var_36_97 = var_1_10010(var_1_10012)
							local var_36_98 = var_1_10010.getFleetById(var_36_97, var_1_10008)
							local var_36_99 = var_1_10010:getFleetById(var_1_10009)

							arg_36_0.mainShips = {}

							local var_36_100 = {}
							local var_36_101 = {}
							local var_36_102 = {}

							function iter_36_18(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
								table = var_2_10004

								if var_2_10004.contains(var_36_5, arg_55_0) then
									BattleVertify = var_4
									var_4.cloneShipVertiry = true
								end

								var_36_5[#var_36_5 + 1] = arg_55_0

								local var_55_0 = var_36_4
								local var_55_1 = var_4.getShipById(var_55_0, arg_55_0)
								local var_55_2 = var_0_2(var_36_1, var_55_1, arg_55_1)

								table = var_55_0

								var_55_0.insert(arg_36_0.mainShips, var_55_1)

								table = var_6

								var_6.insert(arg_55_3, var_55_1)

								table = var_6

								var_6.insert(arg_55_2, var_55_2)

								return
							end

							_ = iter_36_19
							iter_36_19 = iter_36_19.values

							local var_36_103 = var_36_98

							iter_36_19 = iter_36_19(var_36_98.getCommanders(var_36_103))
							var_36_0.CommanderList = var_36_98:buildBattleBuffList()

							local var_36_104 = var_36_98

							var_1_10018 = var_36_98.getTeamByName
							TeamType = var_36_103
							var_1_10018 = var_1_10018(var_36_104, var_36_103.Main)

							local var_36_105 = var_36_98

							iter_36_62 = var_36_98.getTeamByName
							TeamType = iter_36_41
							iter_36_62 = iter_36_62(var_36_105, iter_36_41.Vanguard)
							ipairs = var_36_104

							for iter_36_52, iter_36_53 in var_36_104(var_1_10018) do
								iter_36_18(iter_36_53, iter_36_19, var_36_0.MainUnitList, var_36_100)
							end

							ipairs = var_20

							for iter_36_54, iter_36_55 in var_20(iter_36_62) do
								iter_36_18(iter_36_55, iter_36_19, var_36_0.VanguardUnitList, var_36_101)
							end

							_ = var_20

							local var_36_106 = var_20.values
							local var_36_107 = var_36_99
							local var_36_108 = var_36_106(var_36_99.getCommanders(var_36_107))

							var_36_0.SubCommanderList = var_36_99:buildBattleBuffList()

							local var_36_109 = var_36_99
							local var_36_110 = var_36_99.getTeamByName

							TeamType = var_36_107

							local var_36_111 = var_36_110(var_36_109, var_36_107.Submarine)

							ipairs = iter_36_41

							for iter_36_56, iter_36_57 in iter_36_41(var_36_111) do
								iter_36_18(iter_36_57, var_36_108, var_36_0.SubUnitList, var_36_102)
							end

							getProxy = iter_36_41
							PlayerProxy = var_24

							local var_36_112 = iter_36_41(var_24)
							local var_36_113 = iter_36_41.getRawData(var_36_112)
							local var_36_114 = 0
							local var_36_115 = var_36_3.oil_cost > 0
							local var_36_116 = var_36_114 + (function(arg_56_0, arg_56_1)
								local var_56_0 = 0

								if var_36_115 then
									local var_56_1 = arg_56_0:getStartCost().oil

									var_56_0 = arg_56_0:getEndCost().oil

									if 0 < arg_56_1 then
										math = var_5
										var_56_0 = var_5.clamp(arg_56_1 - var_56_1, 0, var_4)
									end
								end

								return var_56_0
							end)(var_36_98, 0) + var_26(var_36_99, 0)

							if var_36_99:isLegalToFight() == true and var_36_116 <= var_36_113.oil then
								var_36_0.SubFlag = 1
								var_36_0.TotalSubAmmo = 1
							end

							local var_36_117 = arg_36_0.viewComponent

							var_1_10027.setFleet(var_36_117, var_36_100, var_36_101, var_36_102)

							goto label_36_0
						end

						SYSTEM_CARDPUZZLE = var_1_10006

						if var_36_1 == var_1_10006 then
							var_1_10006 = {}
							var_1_10007 = {}
							var_1_10008 = arg_36_0.contextData.relics
							ipairs = var_1_10009

							for iter_36_58, iter_36_59 in var_1_10009(arg_36_0.contextData.cardPuzzleFleet) do
								if var_0_3(iter_36_59, var_1_10008).fleetIndex == 1 then
									table = iter_36_18

									iter_36_18.insert(var_1_10007, var_14)

									table = iter_36_18

									iter_36_18.insert(var_36_0.VanguardUnitList, var_14)
								elseif var_15 == 2 then
									table = iter_36_18

									iter_36_18.insert(var_1_10006, var_14)

									table = iter_36_18

									iter_36_18.insert(var_36_0.MainUnitList, var_14)
								end
							end

							var_36_0.CardPuzzleCardIDList = arg_36_0.contextData.cards
							var_36_0.CardPuzzleCommonHPValue = arg_36_0.contextData.hp
							var_36_0.CardPuzzleRelicList = var_1_10008
							var_36_0.CardPuzzleCombatID = arg_36_0.contextData.puzzleCombatID

							goto label_36_0
						end

						SYSTEM_BOSS_SINGLE = var_1_10006

						if var_36_1 ~= var_1_10006 then
							SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10006

							if var_36_1 == var_1_10006 then
								if arg_36_0.contextData.mainFleetId then
									getProxy = var_1_10006
									FleetProxy = var_1_10008
									var_1_10009 = var_1_10006(var_1_10008)
									var_1_10008 = var_1_10006.getActivityFleets(var_1_10009)[arg_36_0.contextData.actId][arg_36_0.contextData.mainFleetId]
									_ = var_1_10009
									var_1_10009 = var_1_10009.values(var_1_10008:getCommanders())
									var_36_0.CommanderList = var_1_10008:buildBattleBuffList()
									arg_36_0.mainShips = {}
									var_1_10010 = {}

									local var_36_118 = {}
									local var_36_119 = {}

									local function var_36_120(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
										table = var_2_10004

										if var_2_10004.contains(var_36_5, arg_57_0) then
											BattleVertify = var_4
											var_4.cloneShipVertiry = true
										end

										var_36_5[#var_36_5 + 1] = arg_57_0

										local var_57_0 = var_36_4
										local var_57_1 = var_4.getShipById(var_57_0, arg_57_0)
										local var_57_2 = var_0_2(var_36_1, var_57_1, arg_57_1)

										table = var_57_0

										var_57_0.insert(arg_36_0.mainShips, var_57_1)

										table = var_6

										var_6.insert(arg_57_3, var_57_1)

										table = var_6

										var_6.insert(arg_57_2, var_57_2)

										return
									end

									iter_36_18 = var_1_10008

									local var_36_121 = var_1_10008.getTeamByName

									TeamType = iter_36_19

									local var_36_122 = var_36_121(iter_36_18, iter_36_19.Main)

									iter_36_19 = var_1_10008

									local var_36_123 = var_1_10008.getTeamByName

									TeamType = var_1_10018

									local var_36_124 = var_36_123(iter_36_19, var_1_10018.Vanguard)

									ipairs = iter_36_18

									for iter_36_62, iter_36_61 in iter_36_18(var_36_122) do
										var_36_120(iter_36_61, var_1_10009, var_36_0.MainUnitList, var_1_10010)
									end

									ipairs = iter_36_18

									for iter_36_62, iter_36_63 in iter_36_18(var_36_124) do
										var_36_120(iter_36_63, var_1_10009, var_36_0.VanguardUnitList, var_36_118)
									end

									SYSTEM_BOSS_SINGLE_VARIABLE = iter_36_18
									iter_36_18 = var_36_1 == iter_36_18 and 100 or 10

									if var_1_10007[arg_36_0.contextData.mainFleetId + iter_36_18] then
										_ = var_1_10018
										var_1_10018 = var_1_10018.values
										iter_36_41 = iter_36_19
										var_1_10018 = var_1_10018(iter_36_19.getCommanders(iter_36_41))

										local var_36_125 = iter_36_19

										iter_36_62 = iter_36_19.getTeamByName
										TeamType = iter_36_41
										iter_36_62 = iter_36_62(var_36_125, iter_36_41.Submarine)
										ipairs = iter_36_63

										for iter_36_64, iter_36_65 in iter_36_63(iter_36_62) do
											var_36_120(iter_36_65, var_1_10018, var_36_0.SubUnitList, var_36_119)
										end
									end

									getProxy = var_1_10018
									PlayerProxy = iter_36_63

									local var_36_126 = var_1_10018(iter_36_63)

									iter_36_62 = var_1_10018.getRawData(var_36_126)
									getProxy = iter_36_63
									ActivityProxy = iter_36_41

									local var_36_127 = iter_36_63(iter_36_41)
									local var_36_128 = var_20.getActivityById(var_36_127, arg_36_0.contextData.actId)

									var_36_0.ChapterBuffIDs = var_20.GetBuffIdsByStageId(var_36_128, arg_36_0.contextData.stageId)
									pg = var_21

									local var_36_129 = var_21.strategy_data_template

									if arg_36_0.contextData.variableBuffList then
										ipairs = var_22

										for iter_36_66, iter_36_67 in var_22(arg_36_0.contextData.variableBuffList) do
											table = var_1_10027

											var_1_10027.insert(var_36_0.ChapterBuffIDs, var_36_129[iter_36_67].buff_id)
										end
									end

									local var_36_130 = var_20:GetEnemyDataByStageId(arg_36_0.contextData.stageId)
									local var_36_131 = var_22.GetOilLimit(var_36_130)
									local var_36_132 = 0
									local var_36_133 = var_36_3.oil_cost > 0

									local function var_36_134(arg_58_0, arg_58_1)
										if var_36_133 then
											local var_58_0 = arg_58_0
											local var_58_1 = arg_58_0.getEndCost(var_58_0).oil

											if arg_58_1 > 0 then
												local var_58_2 = arg_58_0:getStartCost().oil

												math = var_58_0

												local var_58_3 = var_58_0.clamp(arg_58_1 - var_58_2, 0, var_58_1)
												local var_58_4 = cost
											end

											var_36_132 = var_36_132 + var_58_1
										end

										return
									end

									local var_36_135 = var_1_10008
									local var_36_136

									if not var_36_131[1] then
										var_36_136 = 0
									end

									var_36_134(var_36_135, var_36_136)

									if iter_36_19 then
										local var_36_137 = var_26
										local var_36_138 = iter_36_19
										local var_36_139

										if not var_36_131[2] then
											var_36_139 = 0
										end

										var_36_137(var_36_138, var_36_139)

										if iter_36_19:isLegalToFight() == true and var_36_132 <= iter_36_62.oil then
											var_36_0.SubFlag = 1
											var_36_0.TotalSubAmmo = 1
										end

										var_36_0.SubCommanderList = iter_36_19:buildBattleBuffList()
									end

									local var_36_140 = arg_36_0.viewComponent

									var_27.setFleet(var_36_140, var_1_10010, var_36_118, var_36_119)
								end
							else
								SYSTEM_SCENARIO_SUB_STRIKE = var_1_10006

								if var_36_1 == var_1_10006 then
									var_1_10006 = {}
									arg_36_0.mainShips = {}

									function var_1_10007(arg_59_0, arg_59_1, arg_59_2)
										ipairs = var_2_10003

										for iter_59_0, iter_59_1 in var_2_10003(arg_59_0) do
											table = var_2_10008

											if var_2_10008.contains(var_36_5, iter_59_1) then
												BattleVertify = var_2_10008
												var_2_10008.cloneShipVertiry = true
											end

											var_2_10008 = var_36_5
											var_2_10008[#var_36_5 + 1] = iter_59_1

											local var_59_0 = var_36_4

											var_2_10008 = var_2_10008.getShipById(var_59_0, iter_59_1)

											local var_59_1 = var_0_2(var_36_1, var_2_10008, nil)

											table = var_59_0

											var_59_0.insert(arg_59_1, var_2_10008)

											table = var_10

											var_10.insert(arg_36_0.mainShips, var_2_10008)

											table = var_10

											var_10.insert(arg_59_2, var_59_1)
										end

										return
									end

									getProxy = var_1_10008
									ChapterProxy = var_1_10010

									local var_36_141 = var_1_10008(var_1_10010)

									var_1_10009 = var_1_10008.getActiveChapter(var_36_141)

									local var_36_142 = arg_36_0.viewComponent

									var_10.setChapter(var_36_142, var_1_10009)

									local var_36_143 = arg_36_0.viewComponent

									var_10.setFleet(var_36_143, nil, nil, var_1_10006)

									local var_36_144 = var_1_10009:getChapterSupportFleet()
									local var_36_145 = var_10.getTeamByName

									TeamType = var_14

									local var_36_146 = var_36_145(var_36_144, var_14.Submarine)

									var_1_10007(var_36_146, var_1_10006, var_36_0.SubUnitList)
								elseif arg_36_0.contextData.mainFleetId then
									SYSTEM_DUEL = var_1_10006
									var_1_10006 = var_36_1 == var_1_10006
									getProxy = var_1_10007
									FleetProxy = var_1_10009

									local var_36_147 = var_1_10007(var_1_10009)

									var_1_10008 = nil
									var_1_10009 = nil
									var_1_10008 = var_36_147:getFleetById(arg_36_0.contextData.mainFleetId)
									arg_36_0.mainShips = var_36_4:getShipsByFleet(var_1_10008)

									local var_36_148 = {}
									local var_36_149 = {}
									local var_36_150 = {}

									local function var_36_151(arg_60_0, arg_60_1, arg_60_2)
										ipairs = var_2_10003

										for iter_60_0, iter_60_1 in var_2_10003(arg_60_0) do
											table = var_2_10008

											if var_2_10008.contains(var_36_5, iter_60_1) then
												BattleVertify = var_2_10008
												var_2_10008.cloneShipVertiry = true
											end

											var_2_10008 = var_36_5
											var_2_10008[#var_36_5 + 1] = iter_60_1

											local var_60_0 = var_36_4

											var_2_10008 = var_2_10008.getShipById(var_60_0, iter_60_1)

											local var_60_1 = var_0_2(var_36_1, var_2_10008, nil, var_1_10006)

											table = var_60_0

											var_60_0.insert(arg_60_1, var_2_10008)

											table = var_10

											var_10.insert(arg_60_2, var_60_1)
										end

										return
									end

									iter_36_18 = var_1_10008

									local var_36_152 = var_1_10008.getTeamByName

									TeamType = iter_36_19

									local var_36_153 = var_36_152(iter_36_18, iter_36_19.Main)
									local var_36_154 = var_1_10008
									local var_36_155 = var_1_10008.getTeamByName

									TeamType = var_1_10018

									local var_36_156 = var_36_155(var_36_154, var_1_10018.Vanguard)
									local var_36_157 = var_1_10008

									iter_36_18 = var_1_10008.getTeamByName
									TeamType = iter_36_62
									iter_36_18 = iter_36_18(var_36_157, iter_36_62.Submarine)

									var_36_151(var_36_153, var_36_148, var_36_0.MainUnitList)
									var_36_151(var_36_156, var_36_149, var_36_0.VanguardUnitList)
									var_36_151(iter_36_18, var_36_150, var_36_0.SubUnitList)

									local var_36_158 = arg_36_0.viewComponent

									var_17.setFleet(var_36_158, var_36_148, var_36_149, var_36_150)

									BATTLE_DEBUG = var_17

									if var_17 then
										BATTLE_FREE_SUBMARINE = var_17

										if var_17 then
											local var_36_159 = var_36_147:getFleetById(11)
											local var_36_160 = var_1_10009.getTeamByName

											TeamType = var_20

											if #var_36_160(var_36_159, var_20.Submarine) > 0 then
												var_36_0.SubFlag = 1
												var_36_0.TotalSubAmmo = 1
												_ = var_18

												local var_36_161 = var_18.values(var_1_10009:getCommanders())

												var_36_0.SubCommanderList = var_1_10009:buildBattleBuffList()
												ipairs = var_20

												for iter_36_68, iter_36_69 in var_20(var_17) do
													local var_36_162 = var_36_4
													local var_36_163 = var_36_4.getShipById(var_36_162, iter_36_69)
													local var_36_164 = var_0_2(var_36_1, var_36_163, var_36_161, var_1_10006)

													table = var_36_162

													var_36_162.insert(var_36_150, var_36_163)

													table = var_27

													var_27.insert(var_36_0.SubUnitList, var_36_164)
												end
											end
										end
									end
								end
							end

							::label_36_0::

							SYSTEM_WORLD = var_1_10006

							if var_36_1 == var_1_10006 then
								nowWorld = var_1_10006
								var_1_10009 = var_1_10006()

								local var_36_165 = var_6.GetActiveMap(var_1_10009)

								var_1_10008 = var_7.GetFleet(var_36_165)

								local var_36_166 = var_7
								local var_36_167 = var_7.GetCell(var_36_166, var_1_10008.row, var_1_10008.column)
								local var_36_168 = var_1_10009.GetStageEnemy(var_36_167)

								pg = var_36_166

								local var_36_169 = var_36_166.world_expedition_data[arg_36_0.contextData.stageId]
								local var_36_170 = var_6:GetWorldMapDifficultyBuffLevel()

								var_36_0.EnemyMapRewards = {
									var_36_170[1] * (1 + var_36_169.expedition_sairenvalueA / 16),
									var_36_170[2] * (1 + var_36_169.expedition_sairenvalueB / 16),
									var_36_170[3] * (1 + var_36_169.expedition_sairenvalueC / 16)
								}
								var_36_0.FleetMapRewards = var_6:GetWorldMapBuffLevel()
							end

							var_36_0.RivalMainUnitList, var_36_0.RivalVanguardUnitList = {}, {}

							local var_36_171

							SYSTEM_DUEL = var_7

							if var_36_1 == var_7 and arg_36_0.contextData.rivalId then
								getProxy = var_7
								MilitaryExerciseProxy = var_1_10009

								local var_36_172 = var_7(var_1_10009)

								var_36_171 = var_7.getRivalById(var_36_172, arg_36_0.contextData.rivalId)
								arg_36_0.oldRank = var_7:getSeasonInfo()
							end

							if var_36_171 then
								var_36_0.RivalVO = var_36_171

								local var_36_173 = 0

								ipairs = var_1_10008

								for iter_36_70, iter_36_71 in var_1_10008(var_36_171.mainShips) do
									var_36_173 = var_36_173 + iter_36_71.level
								end

								ipairs = var_8

								for iter_36_72, iter_36_73 in var_8(var_36_171.vanguardShips) do
									var_36_173 = var_36_173 + iter_36_73.level
								end

								BattleVertify = var_8

								local var_36_174

								var_36_174 = var_8 or {}
								BattleVertify = BattleVertify
								var_8.rivalLevel = var_36_173
								ipairs = var_8

								for iter_36_74, iter_36_75 in var_8(var_36_171.mainShips) do
									if not iter_36_75.hpRant or iter_36_75.hpRant > 0 then
										local var_36_175 = var_0_2(var_36_1, iter_36_75, nil, true)

										if iter_36_75.hpRant then
											var_36_175.initHPRate = iter_36_75.hpRant * 0.0001
										end

										table = var_14

										var_14.insert(var_36_0.RivalMainUnitList, var_36_175)
									end
								end

								ipairs = var_8

								for iter_36_76, iter_36_77 in var_8(var_36_171.vanguardShips) do
									if not iter_36_77.hpRant or iter_36_77.hpRant > 0 then
										local var_36_176 = var_0_2(var_36_1, iter_36_77, nil, true)

										if iter_36_77.hpRant then
											var_36_176.initHPRate = iter_36_77.hpRant * 0.0001
										end

										table = var_14

										var_14.insert(var_36_0.RivalVanguardUnitList, var_36_176)
									end
								end
							end

							local var_36_177 = arg_36_0.contextData.prefabFleet.main_unitList
							local var_36_178 = arg_36_0.contextData.prefabFleet.vanguard_unitList
							local var_36_179 = arg_36_0.contextData.prefabFleet.submarine_unitList

							if var_36_177 then
								ipairs = var_10

								for iter_36_78, iter_36_79 in var_10(var_36_177) do
									local var_36_180 = {}

									ipairs = iter_36_18

									for iter_36_80, iter_36_81 in iter_36_18(iter_36_79.equipment) do
										var_36_180[#var_36_180 + 1] = {
											skin = 0,
											id = iter_36_81
										}
									end

									iter_36_18 = {
										id = iter_36_79.id,
										tmpID = iter_36_79.configId,
										skinId = iter_36_79.skinId,
										level = iter_36_79.level,
										equipment = var_36_180,
										properties = iter_36_79.properties,
										baseProperties = iter_36_79.properties,
										proficiency = {
											1,
											1,
											1
										}
									}

									local var_36_181 = iter_36_79.skills

									iter_36_18.skills = var_36_181
									table = var_36_181

									var_36_181.insert(var_36_0.MainUnitList, iter_36_18)
								end
							end

							if var_36_178 then
								ipairs = var_10

								for iter_36_82, iter_36_83 in var_10(var_36_178) do
									local var_36_182 = {}

									ipairs = iter_36_18

									for iter_36_84, iter_36_85 in iter_36_18(iter_36_83.equipment) do
										var_36_182[#var_36_182 + 1] = {
											skin = 0,
											id = iter_36_85
										}
									end

									iter_36_18 = {
										id = iter_36_83.id,
										tmpID = iter_36_83.configId,
										skinId = iter_36_83.skinId,
										level = iter_36_83.level,
										equipment = var_36_182,
										properties = iter_36_83.properties,
										baseProperties = iter_36_83.properties,
										proficiency = {
											1,
											1,
											1
										}
									}

									local var_36_183 = iter_36_83.skills

									iter_36_18.skills = var_36_183
									table = var_36_183

									var_36_183.insert(var_36_0.VanguardUnitList, iter_36_18)
								end
							end

							if var_36_179 then
								ipairs = var_10

								for iter_36_86, iter_36_87 in var_10(var_36_179) do
									local var_36_184 = {}

									ipairs = iter_36_18

									for iter_36_88, iter_36_89 in iter_36_18(iter_36_87.equipment) do
										var_36_184[#var_36_184 + 1] = {
											skin = 0,
											id = iter_36_89
										}
									end

									iter_36_18 = {
										id = iter_36_87.id,
										tmpID = iter_36_87.configId,
										skinId = iter_36_87.skinId,
										level = iter_36_87.level,
										equipment = var_36_184,
										properties = iter_36_87.properties,
										baseProperties = iter_36_87.properties,
										proficiency = {
											1,
											1,
											1
										}
									}

									local var_36_185 = iter_36_87.skills

									iter_36_18.skills = var_36_185
									table = var_36_185

									var_36_185.insert(var_36_0.SubUnitList, iter_36_18)

									SYSTEM_SIMULATION = var_17

									if var_36_1 == var_17 and #var_36_0.SubUnitList > 0 then
										var_36_0.SubFlag = 1
										var_36_0.TotalSubAmmo = 1
									end
								end
							end

							return
						end
					end
				end
			end
		end
	end
end

function var_0_1.listNotificationInterests(arg_61_0)
	local var_61_0 = {}

	GAME = var_1_10002
	var_61_0[1] = var_1_10002.FINISH_STAGE_DONE
	GAME = var_2
	var_61_0[2] = var_2.FINISH_STAGE_ERROR
	GAME = var_2
	var_61_0[3] = var_2.STORY_BEGIN
	GAME = var_2
	var_61_0[4] = var_2.STORY_END
	GAME = var_2
	var_61_0[5] = var_2.END_GUIDE
	GAME = var_2
	var_61_0[6] = var_2.START_GUIDE
	GAME = var_2
	var_61_0[7] = var_2.PAUSE_BATTLE
	GAME = var_2
	var_61_0[8] = var_2.RESUME_BATTLE
	var_61_0[9] = var_0_1.CLOSE_CHAT
	GAME = var_2
	var_61_0[10] = var_2.QUIT_BATTLE
	var_61_0[11] = var_0_1.HIDE_ALL_BUTTONS
	var_61_0[12] = var_0_1.UPDATE_AUTO_COUNT

	return var_61_0
end

function var_0_1.handleNotification(arg_62_0, arg_62_1)
	local var_62_0 = arg_62_1
	local var_62_1 = arg_62_1.getName(var_62_0)
	local var_62_2 = arg_62_1:getBody()

	ys = var_62_0

	local var_62_3 = var_62_0.Battle.BattleState.GetInstance()
	local var_62_4 = arg_62_0.contextData.system

	GAME = var_1_10006

	if var_62_1 == var_1_10006.FINISH_STAGE_DONE then
		pg = var_62_6

		local var_62_5 = var_62_6.MsgboxMgr.GetInstance()

		var_62_6.hide(var_62_5)

		local var_62_6 = var_62_2.system

		SYSTEM_PROLOGUE = var_1_10007

		if var_62_6 == var_1_10007 then
			ys = var_1_10007

			local var_62_7 = var_1_10007.Battle.BattleState.GetInstance()

			var_1_10007.Deactive(var_62_7)

			local var_62_8 = arg_62_0

			var_1_10007 = arg_62_0.sendNotification
			GAME = var_1_10010
			var_1_10010 = var_1_10010.CHANGE_SCENE
			SCENE = var_1_10011

			var_1_10007(var_62_8, var_1_10010, var_1_10011.CREATE_PLAYER)

			goto label_62_0
		end

		SYSTEM_PERFORM = var_1_10007

		if var_62_6 ~= var_1_10007 then
			SYSTEM_SIMULATION = var_1_10007

			if var_62_6 == var_1_10007 then
				ys = var_1_10007

				local var_62_9 = var_1_10007.Battle.BattleState.GetInstance()

				var_1_10007.Deactive(var_62_9)

				local var_62_10 = arg_62_0.viewComponent

				var_1_10007.exitBattle(var_62_10)

				if var_62_2.exitCallback then
					var_62_2.exitCallback()
				end
			else
				BattleResultMediator = var_1_10007

				local var_62_11 = var_1_10007.GetResultView(var_62_6)
				local var_62_12 = {}

				SYSTEM_SCENARIO = var_9

				if var_62_6 == var_9 then
					getProxy = var_9
					ChapterProxy = var_1_10011
					var_1_10011 = var_9(var_1_10011)
					var_62_12 = var_9.getActiveChapter(var_1_10011).operationBuffList
				end

				var_1_10011 = arg_62_0

				local var_62_13 = arg_62_0.addSubLayers

				Context = var_1_10012
				var_1_10012 = var_1_10012.New
				var_1_10014 = {}
				NewBattleResultMediator = var_1_10015
				var_1_10014.mediator = var_1_10015
				NewBattleResultScene = var_1_10015
				var_1_10014.viewComponent = var_1_10015

				local var_62_14 = {
					system = var_62_6,
					rivalId = arg_62_0.contextData.rivalId,
					mainFleetId = arg_62_0.contextData.mainFleetId,
					stageId = arg_62_0.contextData.stageId
				}
				local var_62_15

				if not arg_62_0.mainShips then
					var_62_15 = {}
				end

				var_62_14.oldMainShips = var_62_15
				var_62_14.oldPlayer = arg_62_0.player
				var_62_14.oldRank = arg_62_0.oldRank
				var_62_14.statistics = var_62_2.statistics
				var_62_14.score = var_62_2.score
				var_62_14.drops = var_62_2.drops
				var_62_14.bossId = var_62_2.bossId
				var_62_14.name = var_62_2.name
				var_62_14.prefabFleet = var_62_2.prefabFleet
				var_62_14.commanderExps = var_62_2.commanderExps
				var_62_14.actId = arg_62_0.contextData.actId
				var_62_14.result = var_62_2.result
				var_62_14.extraDrops = var_62_2.extraDrops
				var_62_14.extraBuffList = var_62_12
				var_62_14.isLastBonus = var_62_2.isLastBonus
				var_62_14.continuousBattleTimes = arg_62_0.contextData.continuousBattleTimes
				var_62_14.totalBattleTimes = arg_62_0.contextData.totalBattleTimes
				var_62_14.mode = arg_62_0.contextData.mode
				var_62_14.cmdArgs = arg_62_0.contextData.cmdArgs
				var_62_14.variableBuffList = arg_62_0.contextData.variableBuffList
				var_62_14.useVariableTicket = arg_62_0.contextData.useVariableTicket
				var_1_10014.data = var_62_14

				var_62_13(var_1_10011, var_1_10012(var_1_10014))
			end

			if false then
				GAME = var_62_6

				if var_62_1 == var_62_6.STORY_BEGIN then
					var_62_3:Pause()
				else
					GAME = var_6

					if var_62_1 == var_6.STORY_END then
						var_62_3:Resume()
					else
						GAME = var_6

						if var_62_1 == var_6.START_GUIDE then
							var_62_3:Pause()
						else
							GAME = var_6

							if var_62_1 == var_6.END_GUIDE then
								var_62_3:Resume()
							else
								GAME = var_6

								if var_62_1 == var_6.PAUSE_BATTLE then
									if not var_62_3:IsPause() then
										arg_62_0:onPauseBtn()
									end
								else
									GAME = var_6

									if var_62_1 == var_6.RESUME_BATTLE then
										var_62_3:Resume()
									else
										GAME = var_6

										if var_62_1 == var_6.FINISH_STAGE_ERROR then
											gcAll = var_6

											var_6(true)

											getProxy = var_6
											ContextProxy = var_8

											local var_62_16 = var_6(var_8)
											local var_62_17 = var_6.getContextByMediator

											DailyLevelMediator = var_1_10010

											local var_62_18 = var_62_17(var_62_16, var_1_10010)

											var_1_10010 = var_6

											local var_62_19 = var_6.getContextByMediator

											LevelMediator2 = var_1_10011

											local var_62_20 = var_62_19(var_1_10010, var_1_10011)

											var_1_10011 = var_6

											local var_62_21 = var_6.getContextByMediator

											ChallengeMainMediator = var_1_10012

											local var_62_22 = var_62_21(var_1_10011, var_1_10012)
											local var_62_23 = var_6

											var_1_10010 = var_6.getContextByMediator
											ActivityBossMediatorTemplate = var_1_10013
											var_1_10010 = var_1_10010(var_62_23, var_1_10013)

											if var_62_18 then
												var_1_10013 = var_62_18
												var_1_10011 = var_62_18.getContextByMediator
												PreCombatMediator = var_1_10014
												var_1_10011 = var_1_10011(var_1_10013, var_1_10014)
												var_1_10014 = var_62_18

												var_62_18.removeChild(var_1_10014, var_1_10011)
											elseif var_62_22 then
												var_1_10013 = var_62_22
												var_1_10011 = var_62_22.getContextByMediator
												ChallengePreCombatMediator = var_1_10014
												var_1_10011 = var_1_10011(var_1_10013, var_1_10014)
												var_1_10014 = var_62_22

												var_62_22.removeChild(var_1_10014, var_1_10011)
											elseif var_62_20 then
												SYSTEM_DUEL = var_1_10011

												if var_62_4 == var_1_10011 then
													-- block empty
												else
													SYSTEM_SCENARIO = var_1_10011

													if var_62_4 == var_1_10011 then
														var_1_10013 = var_62_20
														var_1_10011 = var_62_20.getContextByMediator
														ChapterPreCombatMediator = var_1_10014
														var_1_10011 = var_1_10011(var_1_10013, var_1_10014)
														var_1_10014 = var_62_20

														var_62_20.removeChild(var_1_10014, var_1_10011)
													else
														SYSTEM_PERFORM = var_1_10011

														if var_62_4 ~= var_1_10011 then
															SYSTEM_SIMULATION = var_1_10011

															if var_62_4 ~= var_1_10011 then
																var_1_10013 = var_62_20
																var_1_10011 = var_62_20.getContextByMediator
																PreCombatMediator = var_1_10014

																if var_1_10011(var_1_10013, var_1_10014) then
																	var_1_10014 = var_62_20

																	var_62_20.removeChild(var_1_10014, var_1_10011)
																end
															end
														end
													end
												end
											elseif var_1_10010 then
												var_1_10013 = var_1_10010
												var_1_10011 = var_1_10010.getContextByMediator
												PreCombatMediator = var_1_10014

												if var_1_10011(var_1_10013, var_1_10014) then
													var_1_10014 = var_1_10010

													var_1_10010.removeChild(var_1_10014, var_1_10011)
												end
											end

											var_1_10013 = arg_62_0
											var_1_10011 = arg_62_0.sendNotification
											GAME = var_1_10014

											var_1_10011(var_1_10013, var_1_10014.GO_BACK)
										elseif var_62_1 == var_0_1.CLOSE_CHAT then
											local var_62_24 = arg_62_0.viewComponent

											var_6.OnCloseChat(var_62_24)
										elseif var_62_1 == var_0_1.HIDE_ALL_BUTTONS then
											ys = var_6

											local var_62_25 = var_6.Battle.BattleState.GetInstance()
											local var_62_26 = var_6.GetProxyByName

											ys = var_1_10010

											local var_62_27 = var_62_26(var_62_25, var_1_10010.Battle.BattleDataProxy.__name)
											local var_62_28 = var_7.DispatchEvent

											ys = var_1_10011

											local var_62_29 = var_1_10011.Event.New

											ys = var_1_10013

											var_62_28(var_62_27, var_62_29(var_1_10013.Battle.BattleEvent.HIDE_INTERACTABLE_BUTTONS, {
												isActive = var_62_2
											}))
										else
											GAME = var_6

											if var_62_1 == var_6.QUIT_BATTLE then
												var_62_3:Stop()
											elseif var_62_1 == var_0_1.UPDATE_AUTO_COUNT then
												arg_62_0:updateAutoCount(var_62_2)
											end
										end
									end
								end
							end
						end
					end
				end
			end

			::label_62_0::

			return
		end
	end
end

function var_0_1.remove(arg_63_0)
	pg = var_1_10001

	local var_63_0 = var_1_10001.BrightnessMgr.GetInstance()

	var_1.SetScreenNeverSleep(var_63_0, false)

	return
end

return var_0_1
