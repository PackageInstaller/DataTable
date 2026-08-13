class = var_0_10000

local var_0_0 = "NewBattleResultBackSceneHandler"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.Mediator)

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	pg = var_2

	local var_1_0 = var_2.m02

	var_2.registerMediator(var_1_0, arg_1_0)

	arg_1_0.contextData = arg_1_1

	return
end

function var_0_1.Execute(arg_2_0)
	local var_2_0 = arg_2_0.contextData.system

	SYSTEM_DUEL = var_1_10003

	if var_2_0 == var_1_10003 then
		var_1_10005 = arg_2_0

		arg_2_0.ExitDuelSystem(var_1_10005, var_1)

		goto label_2_0
	end

	SYSTEM_ACT_BOSS = var_1_10003

	if var_2_0 == var_1_10003 then
		var_1_10005 = arg_2_0

		arg_2_0.ExitActBossSystem(var_1_10005, var_1)

		goto label_2_0
	end

	SYSTEM_ROUTINE = var_1_10003

	if var_2_0 ~= var_1_10003 then
		SYSTEM_SUB_ROUTINE = var_1_10003

		if var_2_0 == var_1_10003 then
			var_1_10005 = arg_2_0

			arg_2_0.ExitRoutineSystem(var_1_10005, var_1)

			goto label_2_0
		end

		SYSTEM_SCENARIO = var_1_10003

		if var_2_0 == var_1_10003 then
			var_1_10005 = arg_2_0

			arg_2_0.ExitScenarioSystem(var_1_10005, var_1)

			goto label_2_0
		end

		SYSTEM_CHALLENGE = var_1_10003

		if var_2_0 == var_1_10003 then
			var_1_10005 = arg_2_0

			arg_2_0.ExitChallengeSystem(var_1_10005, var_1)

			goto label_2_0
		end

		SYSTEM_HP_SHARE_ACT_BOSS = var_1_10003

		if var_2_0 ~= var_1_10003 then
			SYSTEM_BOSS_EXPERIMENT = var_1_10003

			if var_2_0 ~= var_1_10003 then
				SYSTEM_ACT_BOSS_SP = var_1_10003

				if var_2_0 == var_1_10003 then
					var_1_10005 = arg_2_0

					arg_2_0.ExitShareBossSystem(var_1_10005, var_1)

					goto label_2_0
				end

				SYSTEM_WORLD_BOSS = var_1_10003

				if var_2_0 == var_1_10003 then
					var_1_10005 = arg_2_0

					arg_2_0.ExitWorldBossSystem(var_1_10005, var_1)

					goto label_2_0
				end

				SYSTEM_WORLD = var_1_10003

				if var_2_0 == var_1_10003 then
					var_1_10005 = arg_2_0

					arg_2_0.ExitWorldSystem(var_1_10005, var_1)

					goto label_2_0
				end

				SYSTEM_BOSS_RUSH = var_1_10003

				if var_2_0 ~= var_1_10003 then
					SYSTEM_BOSS_RUSH_EX = var_1_10003

					if var_2_0 ~= var_1_10003 then
						SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10003

						if var_2_0 == var_1_10003 then
							var_1_10005 = arg_2_0

							if arg_2_0.CheckBossRushSystem(var_1_10005, var_1) then
								var_1_10005 = arg_2_0

								arg_2_0.ResultRushBossSystem(var_1_10005, var_1)
							end
						else
							SYSTEM_LIMIT_CHALLENGE = var_1_10003

							if var_2_0 == var_1_10003 then
								var_1_10005 = arg_2_0

								arg_2_0.ExitLimitChallengeSystem(var_1_10005, var_1)
							else
								SYSTEM_BOSS_SINGLE = var_1_10003

								if var_2_0 == var_1_10003 then
									var_1_10005 = arg_2_0

									arg_2_0.ExitBossSingleSystem(var_1_10005, var_1)
								else
									SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10003

									if var_2_0 == var_1_10003 then
										var_1_10005 = arg_2_0

										arg_2_0.ExitBossSingleVariableSystem(var_1_10005, var_1)
									else
										SYSTEM_REWARD_PERFORM = var_1_10003

										if var_2_0 == var_1_10003 then
											var_1_10005 = arg_2_0

											arg_2_0.ExitRewardPerform(var_1_10005, var_1)
										else
											var_1_10005 = arg_2_0

											arg_2_0.ExitCommonSystem(var_1_10005, var_1)
										end
									end
								end
							end
						end

						::label_2_0::

						getProxy = var_1_10003
						MetaCharacterProxy = var_1_10005

						local var_2_1 = var_1_10003(var_1_10005)

						var_3.clearLastMetaSkillExpInfoList(var_2_1)

						return
					end
				end
			end
		end
	end
end

function var_0_1.ExitDuelSystem(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_3_0 = var_1_10002(var_1_10004)
	local var_3_1 = var_2.getContextByMediator

	MilitaryExerciseMediator = var_1_10006

	if var_3_1(var_3_0, var_1_10006) then
		local var_3_2 = var_3

		var_1_10004 = var_3.getContextByMediator
		ExercisePreCombatMediator = var_1_10007
		var_1_10004 = var_1_10004(var_3_2, var_1_10007)
		var_1_10007 = var_3

		var_3.removeChild(var_1_10007, var_1_10004)
	end

	pg = var_1_10004

	local var_3_3 = var_1_10004.m02
	local var_3_4 = var_4.sendNotification

	GAME = var_1_10007

	var_3_4(var_3_3, var_1_10007.GO_BACK)

	return
end

function var_0_1.ExitActBossSystem(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)
	local var_4_1 = var_2.getContextByMediator

	ActivityBossPreCombatMediator = var_1_10006

	local var_4_2, var_4_3 = var_4_1(var_4_0, var_1_10006)

	if var_4_2 then
		var_1_10007 = var_4_3

		var_4_3.removeChild(var_1_10007, var_4_2)
	end

	getProxy = var_4_0
	ContextProxy = var_1_10007

	local var_4_4 = var_4_0(var_1_10007)
	local var_4_5 = var_5.getCurrentContext(var_4_4)
	local var_4_6 = var_5.getContextByMediator

	ContinuousOperationMediator = var_1_10008

	if var_4_6(var_4_5, var_1_10008) then
		arg_4_0:CheckActBossSystem(arg_4_1)
	else
		pg = var_5

		local var_4_7 = var_5.m02
		local var_4_8 = var_5.sendNotification

		GAME = var_1_10008

		var_4_8(var_4_7, var_1_10008.GO_BACK)
	end

	return
end

function var_0_1.ExitRoutineSystem(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_5_0 = var_1_10002(var_1_10004)
	local var_5_1 = var_2.getContextByMediator

	DailyLevelMediator = var_1_10006

	if var_5_1(var_5_0, var_1_10006) then
		local var_5_2 = var_3

		var_1_10004 = var_3.getContextByMediator
		PreCombatMediator = var_1_10007
		var_1_10004 = var_1_10004(var_5_2, var_1_10007)
		var_1_10007 = var_3

		var_3.removeChild(var_1_10007, var_1_10004)
	end

	pg = var_1_10004

	local var_5_3 = var_1_10004.m02
	local var_5_4 = var_4.sendNotification

	GAME = var_1_10007

	var_5_4(var_5_3, var_1_10007.GO_BACK)

	return
end

function var_0_1.ExitScenarioSystem(arg_6_0, arg_6_1)
	if not arg_6_1.needHelpMessage then
		local var_6_0 = arg_6_1.score

		ys = var_1_10003

		if var_6_0 == var_1_10003.Battle.BattleConst.BattleScore.C then
			getProxy = var_6_0
			ChapterProxy = var_1_10004
			var_1_10004 = var_6_0(var_1_10004)
			var_6_0 = var_6_0.StopAutoFight
			ChapterConst = var_1_10005

			var_6_0(var_1_10004, var_1_10005.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
		end

		getProxy = var_6_0
		ContextProxy = var_1_10004

		local var_6_1 = var_6_0(var_1_10004)
		local var_6_2 = var_2.getContextByMediator

		LevelMediator2 = var_1_10006

		if var_6_2(var_6_1, var_1_10006) then
			var_1_10006 = var_3

			local var_6_3 = var_3.getContextByMediator

			ChapterPreCombatMediator = var_1_10007

			if var_6_3(var_1_10006, var_1_10007) then
				var_1_10007 = var_3

				var_3.removeChild(var_1_10007, var_4)
			end
		end

		local var_6_4 = arg_6_1.score

		ys = var_6_1

		if var_6_4 > var_6_1.Battle.BattleConst.BattleScore.C then
			var_1_10006 = arg_6_0

			arg_6_0.ShowExtraChapterActSocre(var_1_10006, arg_6_1)
		end

		getProxy = var_6_4
		ChapterProxy = var_1_10006

		local var_6_5 = var_6_4(var_1_10006)

		var_4.WriteBackOnExitBattleResult(var_6_5)

		pg = var_4

		local var_6_6 = var_4.m02
		local var_6_7 = var_4.sendNotification

		GAME = var_1_10007

		var_6_7(var_6_6, var_1_10007.GO_BACK)

		return
	end
end

function var_0_1.ExitChallengeSystem(arg_7_0, arg_7_1)
	getProxy = var_1_10002
	ChallengeProxy = var_1_10004

	local var_7_0 = var_1_10002(var_1_10004)

	var_2.WriteBackOnExitBattleResult(var_7_0, arg_7_0.contextData.score, arg_7_0.contextData.mode)

	local var_7_1

	if not arg_7_1.goToNext then
		arg_7_1.goToNext = nil
		getProxy = var_2
		ContextProxy = var_7_0
		var_7_1 = var_2(var_7_0)

		local var_7_2 = var_2.getContextByMediator

		ChallengeMainMediator = var_6

		if var_7_2(var_7_1, var_6) then
			local var_7_3 = var_3
			local var_7_4 = var_3.getContextByMediator

			ChallengePreCombatMediator = var_1_10007

			local var_7_5 = var_7_4(var_7_3, var_1_10007)

			var_3:removeChild(var_7_5)
		end
	end

	pg = var_2

	local var_7_6 = var_2.m02
	local var_7_7 = var_2.sendNotification

	GAME = var_7_1

	var_7_7(var_7_6, var_7_1.GO_BACK)

	return
end

function var_0_1.ExitShareBossSystem(arg_8_0, arg_8_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_8_0 = var_1_10002(var_1_10004)
	local var_8_1 = var_2.getContextByMediator

	ActivityBossPreCombatMediator = var_1_10006

	local var_8_2, var_8_3 = var_8_1(var_8_0, var_1_10006)

	if var_8_2 then
		var_8_3:removeChild(var_8_2)
	end

	pg = var_8_0

	local var_8_4 = var_8_0.m02
	local var_8_5 = var_5.sendNotification

	GAME = var_1_10008

	var_8_5(var_8_4, var_1_10008.GO_BACK)

	return
end

function var_0_1.ExitWorldBossSystem(arg_9_0, arg_9_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_9_0 = var_1_10002(var_1_10004)
	local var_9_1 = var_2.getContextByMediator

	WorldBossMediator = var_1_10006

	local var_9_2 = var_9_1(var_9_0, var_1_10006)
	local var_9_3 = var_3.getContextByMediator

	WorldBossFormationMediator = var_1_10007

	if var_9_3(var_9_2, var_1_10007) and not arg_9_1.isSimulate then
		var_3:removeChild(var_4)
	end

	pg = var_9_0

	local var_9_4 = var_9_0.m02
	local var_9_5 = var_5.sendNotification

	GAME = var_1_10008

	var_9_5(var_9_4, var_1_10008.WORLD_BOSS_BATTLE_QUIT, {
		id = arg_9_1.bossId
	})

	pg = var_9_5

	local var_9_6 = var_9_5.m02
	local var_9_7 = var_5.sendNotification

	GAME = var_8

	var_9_7(var_9_6, var_8.GO_BACK)

	return
end

function var_0_1.ExitWorldSystem(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_10_0 = var_1_10002(var_1_10004)
	local var_10_1 = var_2.getContextByMediator

	WorldMediator = var_1_10006

	local var_10_2 = var_10_1(var_10_0, var_1_10006)
	local var_10_3 = var_3.getContextByMediator

	WorldPreCombatMediator = var_1_10007

	local var_10_5

	if not var_10_3(var_10_2, var_1_10007) then
		local var_10_4 = var_3

		var_10_5 = var_3.getContextByMediator
		WorldBossInformationMediator = var_1_10007
		var_10_5 = var_10_5(var_10_4, var_1_10007)
	end

	if var_10_5 then
		var_3:removeChild(var_10_5)
	end

	pg = var_10_0

	local var_10_6 = var_10_0.m02
	local var_10_7 = var_5.sendNotification

	GAME = var_1_10008

	var_10_7(var_10_6, var_1_10008.GO_BACK)

	return
end

function var_0_1.ResultRushBossSystem(arg_11_0, arg_11_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_11_0 = var_1_10002(var_1_10004)
	local var_11_1 = var_2.getContextByMediator

	BossRushPreCombatMediator = var_1_10006

	local var_11_2, var_11_3 = var_11_1(var_11_0, var_1_10006)

	if var_11_2 then
		var_11_3:removeChild(var_11_2)
	end

	local var_11_4 = var_2
	local var_11_5 = var_2.getContextByMediator

	BossRushFleetSelectMediator = var_1_10008

	local var_11_6, var_11_7 = var_11_5(var_11_4, var_1_10008)

	if var_11_6 then
		var_1_10009 = var_11_7

		var_11_7.removeChild(var_1_10009, var_11_6)
	end

	local var_11_8 = arg_11_1.score

	ys = var_1_10008

	local var_11_9

	if not (var_1_10008.Battle.BattleConst.BattleScore.C < var_11_8) then
		var_11_9 = arg_11_1.system
		SYSTEM_BOSS_RUSH_EX = var_1_10009

		if var_11_9 == var_1_10009 then
			local var_11_10 = arg_11_0

			var_11_9 = arg_11_0.addSubLayers
			Context = var_1_10011
			var_1_10011 = var_1_10011.New

			local var_11_11 = {}

			BattleFailTipMediator = var_1_10014
			var_11_11.mediator = var_1_10014
			BattleFailTipLayer = var_1_10014
			var_11_11.viewComponent = var_1_10014
			var_11_11.data = {
				mainShips = arg_11_1.newMainShips,
				battleSystem = arg_11_1.system
			}

			function var_11_11.onRemoved()
				pg = var_2_10000

				local var_12_0 = var_2_10000.m02
				local var_12_1 = var_0.sendNotification

				GAME = var_2_10003

				var_12_1(var_12_0, var_2_10003.GO_BACK)

				return
			end

			var_11_9(var_11_10, var_1_10011(var_11_11))

			return
		end
	end

	pg = var_11_9

	local var_11_12 = var_11_9.m02
	local var_11_13 = var_8.sendNotification

	GAME = var_1_10011

	var_11_13(var_11_12, var_1_10011.BOSSRUSH_SETTLE, {
		actId = arg_11_1.actId
	})

	return
end

function var_0_1.ExitRushBossSystem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1.system
	local var_13_1 = arg_13_1.actId
	local var_13_2 = arg_13_2.seriesData
	local var_13_3 = arg_13_1.score

	ys = var_1_10007

	local var_13_4 = var_13_3 > var_1_10007.Battle.BattleConst.BattleScore.C
	local var_13_5
	local var_13_6

	SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10009

	if var_13_0 == var_1_10009 then
		BossRushDALBattleResultMediator = var_13_5
		BossRushDALBattleResultLayer = var_13_6
	else
		SYSTEM_BOSS_RUSH_EX = var_1_10009

		if var_13_0 == var_1_10009 then
			BossRushBattleResultMediator = var_13_5
			BossRushConst = var_1_10009
			var_13_6 = var_1_10009.GetEXBattleResultLayer(var_13_1)
		else
			BossRushBattleResultMediator = var_13_5
			BossRushBattleResultLayer = var_13_6
		end
	end

	local var_13_7 = arg_13_0
	local var_13_8 = arg_13_0.addSubLayers

	Context = var_1_10012

	var_13_8(var_13_7, var_1_10012.New({
		mediator = var_13_5,
		viewComponent = var_13_6,
		data = {
			awards = arg_13_2.awards,
			system = var_13_0,
			actId = var_13_1,
			seriesData = var_13_2,
			win = var_13_4,
			OnClose = arg_13_2.callback,
			isAutoFight = arg_13_0.contextData.isAutoFight
		}
	}), true)

	LoadContextCommand = var_13_8

	local var_13_9 = var_13_8.RemoveLayerByMediator

	NewBattleResultMediator = var_13_7

	var_13_9(var_13_7)

	return
end

function var_0_1.ExitLimitChallengeSystem(arg_14_0, arg_14_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_14_0 = var_1_10002(var_1_10004)
	local var_14_1 = var_2.getContextByMediator

	LimitChallengeMediator = var_1_10006

	if var_14_1(var_14_0, var_1_10006) then
		local var_14_2 = var_3

		var_1_10004 = var_3.getContextByMediator
		LimitChallengePreCombatMediator = var_1_10007

		if var_1_10004(var_14_2, var_1_10007) then
			var_1_10007 = var_3

			var_3.removeChild(var_1_10007, var_1_10004)
		end
	end

	pg = var_1_10004

	local var_14_3 = var_1_10004.m02
	local var_14_4 = var_4.sendNotification

	GAME = var_1_10007

	var_14_4(var_14_3, var_1_10007.GO_BACK)

	return
end

function var_0_1.ExitBossSingleSystem(arg_15_0, arg_15_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_15_0 = var_1_10002(var_1_10004)
	local var_15_1 = var_2.getContextByMediator

	BossSinglePreCombatMediator = var_1_10006

	local var_15_2, var_15_3 = var_15_1(var_15_0, var_1_10006)

	if var_15_2 then
		var_1_10007 = var_15_3
		var_15_0 = var_15_3.removeChild(var_1_10007, var_15_2)
	end

	getProxy = var_15_0
	ContextProxy = var_1_10007

	local var_15_4 = var_15_0(var_1_10007)
	local var_15_5 = var_5.getCurrentContext(var_15_4)
	local var_15_6 = var_5.getContextByMediator

	BossSingleContinuousOperationMediator = var_1_10008

	if var_15_6(var_15_5, var_1_10008) then
		arg_15_0:CheckBossSingleSystem(arg_15_1)
	else
		pg = var_5

		local var_15_7 = var_5.m02
		local var_15_8 = var_5.sendNotification

		GAME = var_1_10008

		var_15_8(var_15_7, var_1_10008.GO_BACK)
	end

	return
end

function var_0_1.ExitBossSingleVariableSystem(arg_16_0, arg_16_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_16_0 = var_1_10002(var_1_10004)
	local var_16_1 = var_2.getContextByMediator

	BossSinglePreCombatMediator = var_1_10006

	local var_16_2, var_16_3 = var_16_1(var_16_0, var_1_10006)

	if var_16_2 then
		var_1_10007 = var_16_3
		var_16_0 = var_16_3.removeChild(var_1_10007, var_16_2)
	end

	getProxy = var_16_0
	ContextProxy = var_1_10007

	local var_16_4 = var_16_0(var_1_10007)
	local var_16_5 = var_5.getCurrentContext(var_16_4)
	local var_16_6 = var_5.getContextByMediator

	BossSingleContinuousOperationMediator = var_1_10008

	if var_16_6(var_16_5, var_1_10008) then
		arg_16_0:CheckBossSingleSystem(arg_16_1)
	else
		pg = var_5

		local var_16_7 = var_5.m02
		local var_16_8 = var_5.sendNotification

		GAME = var_1_10008

		var_16_8(var_16_7, var_1_10008.GO_BACK)
	end

	return
end

function var_0_1.ExitRewardPerform(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_17_0 = var_1_10002(var_1_10004)
	local var_17_1 = var_2.getContextByMediator

	BossSinglePreCombatLiteMediator = var_1_10006

	local var_17_2, var_17_3 = var_17_1(var_17_0, var_1_10006)

	if var_17_2 then
		var_17_0 = var_17_3:removeChild(var_17_2)
	end

	pg = var_17_0

	local var_17_4 = var_17_0.m02
	local var_17_5 = var_5.sendNotification

	GAME = var_1_10008

	var_17_5(var_17_4, var_1_10008.GO_BACK)

	return
end

function var_0_1.ExitCommonSystem(arg_18_0, arg_18_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_18_0 = var_1_10002(var_1_10004)
	local var_18_1 = var_2.getContextByMediator

	LevelMediator2 = var_1_10006

	if var_18_1(var_18_0, var_1_10006) then
		local var_18_2 = var_3

		var_1_10004 = var_3.getContextByMediator
		PreCombatMediator = var_1_10007

		if var_1_10004(var_18_2, var_1_10007) then
			var_1_10007 = var_3

			var_3.removeChild(var_1_10007, var_1_10004)
		end
	end

	pg = var_1_10004

	local var_18_3 = var_1_10004.m02
	local var_18_4 = var_4.sendNotification

	GAME = var_1_10007

	var_18_4(var_18_3, var_1_10007.GO_BACK)

	return
end

local function var_0_2()
	getProxy = var_1_10000
	ActivityProxy = var_1_10002

	local var_19_0 = var_1_10000(var_1_10002)
	local var_19_1 = var_0.getActivitiesByType

	ActivityConst = var_1_10004

	local var_19_2 = var_19_1(var_19_0, var_1_10004.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK)
	local var_19_3 = {}

	ipairs = var_19_0

	for iter_19_0, iter_19_1 in var_19_0(var_19_2) do
		if iter_19_1 and not iter_19_1:isEnd() then
			table = var_8

			var_8.insert(var_19_3, iter_19_1)
		end
	end

	return var_19_3
end

function var_0_1.ShowExtraChapterActSocre(arg_20_0, arg_20_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_20_0 = var_1_10002(var_1_10004)
	local var_20_1 = var_2.getActiveChapter(var_20_0)
	local var_20_2 = var_0_2()

	ipairs = var_20_0

	for iter_20_0, iter_20_1 in var_20_0(var_20_2) do
		local var_20_3 = iter_20_1:getConfig("config_data")
		local var_20_4 = arg_20_1.stageId

		if var_20_3[1] == var_20_4 and var_20_1:IsEXChapter() then
			math = var_12

			local var_20_5 = var_12.floor(arg_20_1.statistics._totalTime)

			ActivityLevelConst = var_13

			local var_20_6 = var_13.getShipsPower
			local var_20_7

			if not arg_20_1.prefabFleet then
				var_20_7 = arg_20_1.oldMainShips
			end

			local var_20_8 = var_20_6(var_20_7)

			ActivityLevelConst = var_14

			local var_20_9, var_20_10 = var_14.getExtraChapterSocre(var_20_4, var_20_5, var_20_8, iter_20_1)

			if var_20_10 < var_20_9 then
				i18n = var_20_11

				local var_20_11

				if not var_20_11("extra_chapter_record_updated") then
					i18n = var_20_11
					var_20_11 = var_20_11("extra_chapter_record_not_updated")
				end

				if var_20_10 < var_20_9 then
					iter_20_1.data1 = var_20_9
					getProxy = var_17
					ActivityProxy = var_19

					local var_20_12 = var_17(var_19)

					var_17.updateActivity(var_20_12, iter_20_1)

					var_20_10 = var_20_9
				end

				pg = var_17

				local var_20_13 = var_17.MsgboxMgr.GetInstance()
				local var_20_14 = var_17.ShowMsgBox
				local var_20_15 = {
					hideNo = true
				}

				i18n = var_1_10021
				var_20_15.content = var_1_10021("extra_chapter_socre_tip", var_20_9, var_20_10, var_20_11)

				var_20_14(var_20_13, var_20_15)
			end
		end
	end

	return
end

local function var_0_3(arg_21_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)
	local var_21_1 = var_1.getActivityById(var_21_0, arg_21_0.actId)
	local var_21_2 = var_1.getConfig(var_21_1, "config_id")

	pg = var_21_0

	local var_21_3 = var_21_0.activity_event_worldboss[var_21_2]
	local var_21_4 = var_1:IsOilLimit(arg_21_0.stageId)

	getProxy = var_5
	FleetProxy = var_7

	local var_21_5 = var_5(var_7)
	local var_21_6 = var_5.getActivityFleets(var_21_5)[arg_21_0.actId]
	local var_21_7 = 0
	local var_21_8 = var_21_3.use_oil_limit[arg_21_0.mainFleetId]

	local function var_21_9(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:GetCostSum().oil

		if 0 < arg_22_1 then
			math = var_3
			var_22_0 = var_3.min(var_22_0, arg_22_1)
		end

		var_21_7 = var_21_7 + var_22_0

		return
	end

	local var_21_10 = var_21_6[arg_21_0.mainFleetId]
	local var_21_11

	if not var_21_4 or not var_21_8[1] then
		var_21_11 = 0
	end

	var_21_9(var_21_10, var_21_11)

	local var_21_12 = var_9
	local var_21_13 = var_21_6[arg_21_0.mainFleetId + 10]
	local var_21_14

	if not var_21_4 or not var_21_8[2] then
		var_21_14 = 0
	end

	var_21_12(var_21_13, var_21_14)

	return var_21_7
end

local function var_0_4(arg_23_0, arg_23_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_23_0 = var_1_10002(var_1_10004)
	local var_23_1 = var_2.getCurrentContext(var_23_0)
	local var_23_2 = var_2.getContextByMediator

	ContinuousOperationMediator = var_1_10005

	local var_23_3

	if not var_23_2(var_23_1, var_1_10005) or not var_2.data.autoFlag then
		var_23_3 = nil
	end

	getProxy = var_23_1
	ChapterProxy = var_1_10006

	local var_23_4 = var_23_1(var_1_10006)
	local var_23_5 = var_4.PopActBossRewards(var_23_4)

	LoadContextCommand = var_1_10005

	local var_23_6 = var_1_10005.LoadLayerOnTopContext

	Context = var_1_10007

	local var_23_7 = var_1_10007.New
	local var_23_8 = {}

	ActivityBossTotalRewardPanelMediator = var_1_10010
	var_23_8.mediator = var_1_10010
	ActivityBossTotalRewardPanel = var_1_10010
	var_23_8.viewComponent = var_1_10010
	var_23_8.data = {
		onClose = function()
			pg = var_2_10000

			local var_24_0 = var_2_10000.m02
			local var_24_1 = var_0.sendNotification

			GAME = var_2_10003

			var_24_1(var_24_0, var_2_10003.GO_BACK)

			return
		end,
		stopReason = arg_23_1,
		rewards = var_23_5,
		isAutoFight = var_23_3,
		continuousBattleTimes = arg_23_0.continuousBattleTimes,
		totalBattleTimes = arg_23_0.totalBattleTimes
	}

	var_23_6(var_23_7(var_23_8))

	return
end

local function var_0_5(arg_25_0, arg_25_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_25_0 = var_1_10002(var_1_10004)
	local var_25_1 = var_2.getCurrentContext(var_25_0)
	local var_25_2 = var_2.getContextByMediator

	BossSingleContinuousOperationMediator = var_1_10005

	local var_25_3

	if not var_25_2(var_25_1, var_1_10005) or not var_2.data.autoFlag then
		var_25_3 = nil
	end

	getProxy = var_25_1
	ChapterProxy = var_1_10006

	local var_25_4 = var_25_1(var_1_10006)
	local var_25_5 = var_4.PopBossSingleRewards(var_25_4)

	LoadContextCommand = var_1_10005

	local var_25_6 = var_1_10005.LoadLayerOnTopContext

	Context = var_1_10007

	local var_25_7 = var_1_10007.New
	local var_25_8 = {}

	BossSingleTotalRewardPanelMediator = var_1_10010
	var_25_8.mediator = var_1_10010
	BossSingleTotalRewardPanel = var_1_10010
	var_25_8.viewComponent = var_1_10010
	var_25_8.data = {
		onConfirm = function()
			pg = var_2_10000

			local var_26_0 = var_2_10000.m02
			local var_26_1 = var_0.sendNotification

			GAME = var_2_10003

			var_26_1(var_26_0, var_2_10003.GO_BACK)

			return
		end,
		onClose = function()
			getProxy = var_2_10000
			ContextProxy = var_2_10002

			local var_27_0 = var_2_10000(var_2_10002)
			local var_27_1 = var_0.getContextByMediator

			ClueMapMediator = var_2_10003

			if var_27_1(var_27_0, var_2_10003) then
				var_0.cleanChild = true
				warning = var_2_10001

				var_2_10001("ClueMapMediator")
			end

			getProxy = var_2_10001
			ContextProxy = var_2_10003

			local var_27_2 = var_2_10001(var_2_10003)
			local var_27_3 = var_1.getContextByMediator

			BossSinglePreCombatMediator = var_2_10004

			if var_27_3(var_27_2, var_2_10004) then
				var_0.skipBack = true
				warning = var_1

				var_1("BossSinglePreCombatMediator")
			end

			pg = var_0

			local var_27_4 = var_0.m02
			local var_27_5 = var_0.sendNotification

			GAME = var_27_2

			var_27_5(var_27_4, var_27_2.GO_BACK)

			return
		end,
		stopReason = arg_25_1,
		rewards = var_25_5,
		isAutoFight = var_25_3,
		continuousBattleTimes = arg_25_0.continuousBattleTimes,
		totalBattleTimes = arg_25_0.totalBattleTimes
	}

	var_25_6(var_25_7(var_25_8))

	return
end

local function var_0_6()
	pg = var_1_10000

	local var_28_0 = var_1_10000.GuildMsgBoxMgr.GetInstance()

	if var_0.GetShouldShowBattleTip(var_28_0) then
		getProxy = var_1
		GuildProxy = var_28_0

		local var_28_1 = var_1(var_28_0)

		if var_1.getRawData(var_28_1) and var_1:getWeeklyTask() and var_2.id ~= 0 then
			var_0:SubmitTask(function(arg_29_0, arg_29_1)
				if arg_29_1 then
					local var_29_0 = var_0

					var_2.CancelShouldShowBattleTip(var_29_0)
				end

				return
			end)
		end
	end

	return
end

function var_0_1.CheckActBossSystem(arg_30_0, arg_30_1)
	pg = var_1_10002

	local var_30_0 = var_1_10002.m02
	local var_30_1 = var_2.sendNotification

	ContinuousOperationMediator = var_1_10005

	var_30_1(var_30_0, var_1_10005.CONTINUE_OPERATION)

	local var_30_2 = var_0_3(arg_30_1)

	getProxy = var_1_10003
	PlayerProxy = var_5

	local var_30_3 = var_1_10003(var_5)
	local var_30_4

	if var_3.getRawData(var_30_3).oil < var_30_2 then
		var_30_2 = var_0_4
		var_30_4 = arg_30_1
		i18n = var_30_3

		var_30_2(var_30_4, var_30_3("multiple_sorties_stop_reason1"))

		return
	end

	getProxy = var_30_2
	BayProxy = var_30_4

	local var_30_5 = var_30_2(var_30_4)
	local var_30_6 = var_2.getShipCount(var_30_5)

	getProxy = var_3
	PlayerProxy = var_30_3

	local var_30_7 = var_3(var_30_3)
	local var_30_8 = var_3.getRawData(var_30_7)

	if var_30_6 >= var_3.getMaxShipBag(var_30_8) then
		var_30_6 = var_0_4
		var_30_5 = arg_30_1
		i18n = var_30_8

		var_30_6(var_30_5, var_30_8("multiple_sorties_stop_reason3"))

		return
	end

	getProxy = var_30_6
	FleetProxy = var_30_5

	local var_30_9 = var_30_6(var_30_5)
	local var_30_10 = var_2.getActivityFleets(var_30_9)[arg_30_1.actId][arg_30_1.mainFleetId]

	_ = var_30_8

	local var_30_11 = var_30_8.map

	_ = var_1_10007

	local var_30_12 = #var_30_11(var_1_10007.values(var_30_10.ships), function(arg_31_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_31_0 = var_2_10001(var_2_10003)

		if var_1.getShipById(var_31_0, arg_31_0) then
			local var_31_1 = var_1.energy

			Ship = var_31_0

			if var_31_1 == var_31_0.ENERGY_LOW then
				return var_1
			end
		end

		return
	end)
	local var_30_14, var_30_15

	if 0 < var_30_12 then
		Fleet = var_30_12

		local var_30_13 = var_30_12.DEFAULT_NAME_BOSS_ACT[arg_30_1.mainFleetId]

		_ = var_30_14
		var_30_14 = var_30_14.map(var_5, function(arg_32_0)
			return "「" .. arg_32_0:getConfig("name") .. "」"
		end)
		var_30_15 = var_0_4
		var_1_10010 = arg_30_1
		i18n = var_1_10011

		local var_30_16 = "multiple_sorties_stop_reason2"
		local var_30_17 = var_30_13

		table = var_1_10015

		var_30_15(var_1_10010, var_1_10011(var_30_16, var_30_17, var_1_10015.concat(var_30_14, "")))

		return
	end

	local var_30_18 = arg_30_1.statistics._battleScore

	ys = var_30_14

	if var_30_18 <= var_30_14.Battle.BattleConst.BattleScore.C then
		local var_30_19 = var_0_4

		var_30_15 = arg_30_1
		i18n = var_9

		var_30_19(var_30_15, var_9("multiple_sorties_stop_reason4"))

		return
	end

	var_0_6()

	getProxy = var_6
	ContextProxy = var_30_15

	local var_30_20 = var_6(var_30_15)

	getProxy = var_7
	ContextProxy = var_9

	local var_30_21 = var_7(var_9)
	local var_30_22 = var_7.getCurrentContext(var_30_21)
	local var_30_23 = var_7.getContextByMediator

	ContinuousOperationMediator = var_1_10010

	if var_30_23(var_30_22, var_1_10010) and not var_7.data.autoFlag then
		var_0_4(arg_30_1)

		return
	end

	if arg_30_1.continuousBattleTimes < 1 then
		var_0_4(arg_30_1)

		return
	end

	pg = var_8

	local var_30_24 = var_8.m02
	local var_30_25 = var_8.sendNotification

	NewBattleResultMediator = var_1_10011

	var_30_25(var_30_24, var_1_10011.ON_COMPLETE_BATTLE_RESULT)

	return
end

function var_0_1.ContinuousBossRush(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5, arg_33_6)
	pg = var_1_10007

	local var_33_0 = var_1_10007.m02
	local var_33_1 = var_7.sendNotification

	GAME = var_1_10010

	var_33_1(var_33_0, var_1_10010.BEGIN_STAGE, {
		system = arg_33_1,
		actId = arg_33_2,
		continuousBattleTimes = arg_33_5,
		totalBattleTimes = arg_33_6,
		curIndex = arg_33_3 - 1,
		maxIndex = #arg_33_4
	})

	return
end

function var_0_1.CheckBossRushSystem(arg_34_0, arg_34_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_34_0 = var_1_10002(var_1_10004)
	local var_34_1 = arg_34_1.score

	ys = var_1_10004

	local var_34_2 = var_34_1 > var_1_10004.Battle.BattleConst.BattleScore.C
	local var_34_3 = arg_34_1.actId

	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_34_4 = var_1_10005(var_1_10007)
	local var_34_5 = var_5.getActivityById(var_34_4, var_34_3)
	local var_34_6 = var_5.GetSeriesData(var_34_5)

	assert = var_34_4

	var_34_4(var_34_6)

	local var_34_7 = var_34_6:GetStaegLevel() + 1
	local var_34_8 = var_34_6:GetExpeditionIds()
	local var_34_9 = var_34_0:getCurrentContext()
	local var_34_10 = var_9.getContextByMediator

	ContinuousOperationMediator = var_1_10012

	if var_34_10(var_34_9, var_1_10012) then
		var_0_6()
	end

	local var_34_11 = var_34_0:getCurrentContext()
	local var_34_12 = var_9.getContextByMediator

	ContinuousOperationMediator = var_1_10012

	local var_34_13 = not var_34_12(var_34_11, var_1_10012) or var_9.data.autoFlag
	local var_34_14 = not var_34_2 or var_34_7 > #var_34_8 or not var_34_13

	arg_34_0.contextData.isAutoFight = var_34_13

	if not var_34_14 then
		arg_34_0:ContinuousBossRush(arg_34_1.system, var_34_3, var_34_7, var_34_8, arg_34_1.continuousBattleTimes, arg_34_1.totalBattleTimes)
	end

	return var_34_14
end

local function var_0_7(arg_35_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_35_0 = var_1_10001(var_1_10003)
	local var_35_1 = var_1.getActivityById(var_35_0, arg_35_0.actId)
	local var_35_2 = var_1.GetEnemyDataByStageId(var_35_1, arg_35_0.stageId)
	local var_35_3 = var_2.GetOilLimit(var_35_2)

	getProxy = var_35_1
	FleetProxy = var_1_10006

	local var_35_4 = var_35_1(var_1_10006)
	local var_35_5 = var_4.getActivityFleets(var_35_4)[arg_35_0.actId]
	local var_35_6 = 0

	local function var_35_7(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_0:GetCostSum().oil

		if 0 < arg_36_1 then
			math = var_3
			var_36_0 = var_3.min(var_36_0, arg_36_1)
		end

		var_35_6 = var_35_6 + var_36_0

		return
	end

	local var_35_8 = var_35_5[arg_35_0.mainFleetId]
	local var_35_9

	if not var_35_3[1] then
		var_35_9 = 0
	end

	var_35_7(var_35_8, var_35_9)

	local var_35_10 = var_1:getConfig("type")

	ActivityConst = var_1_10009

	if var_35_10 == var_1_10009.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		Fleet = var_35_10

		local var_35_11

		if not var_35_10.MEGA_SUBMARINE_FLEET_OFFSET then
			var_35_11 = 10
		end

		local var_35_12 = var_7
		local var_35_13 = var_35_5[arg_35_0.mainFleetId + var_35_11]
		local var_35_14

		if not var_35_3[2] then
			var_35_14 = 0
		end

		var_35_12(var_35_13, var_35_14)

		return var_35_6
	end
end

function var_0_1.CheckBossSingleSystem(arg_37_0, arg_37_1)
	pg = var_1_10002

	local var_37_0 = var_1_10002.m02
	local var_37_1 = var_2.sendNotification

	BossSingleContinuousOperationMediator = var_1_10005

	var_37_1(var_37_0, var_1_10005.CONTINUE_OPERATION)

	local var_37_2 = var_0_7(arg_37_1)

	getProxy = var_1_10003
	PlayerProxy = var_5

	local var_37_3 = var_1_10003(var_5)
	local var_37_4

	if var_3.getRawData(var_37_3).oil < var_37_2 then
		var_37_2 = var_0_5
		var_37_4 = arg_37_1
		i18n = var_37_3

		var_37_2(var_37_4, var_37_3("multiple_sorties_stop_reason1"))

		return
	end

	getProxy = var_37_2
	BayProxy = var_37_4

	local var_37_5 = var_37_2(var_37_4)
	local var_37_6 = var_2.getShipCount(var_37_5)

	getProxy = var_3
	PlayerProxy = var_37_3

	local var_37_7 = var_3(var_37_3)
	local var_37_8 = var_3.getRawData(var_37_7)

	if var_37_6 >= var_3.getMaxShipBag(var_37_8) then
		var_37_6 = var_0_5
		var_37_5 = arg_37_1
		i18n = var_37_8

		var_37_6(var_37_5, var_37_8("multiple_sorties_stop_reason3"))

		return
	end

	getProxy = var_37_6
	FleetProxy = var_37_5

	local var_37_9 = var_37_6(var_37_5)
	local var_37_10 = var_2.getActivityFleets(var_37_9)[arg_37_1.actId][arg_37_1.mainFleetId]

	_ = var_37_8

	local var_37_11 = var_37_8.map

	_ = var_1_10007

	local var_37_12 = #var_37_11(var_1_10007.values(var_37_10.ships), function(arg_38_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_38_0 = var_2_10001(var_2_10003)

		if var_1.getShipById(var_38_0, arg_38_0) then
			local var_38_1 = var_1.energy

			Ship = var_38_0

			if var_38_1 == var_38_0.ENERGY_LOW then
				return var_1
			end
		end

		return
	end)
	local var_37_14, var_37_15

	if 0 < var_37_12 then
		Fleet = var_37_12

		local var_37_13 = var_37_12.DEFAULT_NAME_BOSS_ACT[arg_37_1.mainFleetId]

		_ = var_37_14
		var_37_14 = var_37_14.map(var_5, function(arg_39_0)
			return "「" .. arg_39_0:getConfig("name") .. "」"
		end)
		var_37_15 = var_0_5
		var_1_10010 = arg_37_1
		i18n = var_1_10011

		local var_37_16 = "multiple_sorties_stop_reason2"
		local var_37_17 = var_37_13

		table = var_1_10015

		var_37_15(var_1_10010, var_1_10011(var_37_16, var_37_17, var_1_10015.concat(var_37_14, "")))

		return
	end

	local var_37_18 = arg_37_1.statistics._battleScore

	ys = var_37_14

	if var_37_18 <= var_37_14.Battle.BattleConst.BattleScore.C then
		local var_37_19 = var_0_5

		var_37_15 = arg_37_1
		i18n = var_9

		var_37_19(var_37_15, var_9("multiple_sorties_stop_reason4"))

		return
	end

	var_0_6()

	getProxy = var_6
	ContextProxy = var_37_15

	local var_37_20 = var_6(var_37_15)

	getProxy = var_7
	ContextProxy = var_9

	local var_37_21 = var_7(var_9)
	local var_37_22 = var_7.getCurrentContext(var_37_21)
	local var_37_23 = var_7.getContextByMediator

	BossSingleContinuousOperationMediator = var_1_10010

	if var_37_23(var_37_22, var_1_10010) and not var_7.data.autoFlag then
		var_0_5(arg_37_1)

		return
	end

	if arg_37_1.continuousBattleTimes < 1 then
		var_0_5(arg_37_1)

		return
	end

	pg = var_8

	local var_37_24 = var_8.m02
	local var_37_25 = var_8.sendNotification

	NewBattleResultMediator = var_1_10011

	var_37_25(var_37_24, var_1_10011.ON_COMPLETE_BATTLE_RESULT)

	return
end

local function var_0_8(arg_40_0, arg_40_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_40_0 = var_1_10002(var_1_10004)
	local var_40_1 = var_2.getActivityById(var_40_0, arg_40_0)
	local var_40_2 = var_2.getConfig(var_40_1, "config_id")

	pg = var_40_0

	local var_40_3 = var_40_0.activity_event_worldboss[var_40_2].ticket

	getProxy = var_6
	PlayerProxy = var_1_10008

	local var_40_4 = var_6(var_1_10008)
	local var_40_5 = var_6.getRawData(var_40_4)
	local var_40_6 = var_6.getResource(var_40_5, var_40_3)

	if var_2:GetStageBonus(arg_40_1) == 0 then
		getProxy = var_40_5
		SettingsProxy = var_10

		local var_40_7 = var_40_5(var_10)

		if var_8.isTipActBossExchangeTicket(var_40_7) == 1 and var_40_6 > 0 then
			return true
		end
	end

	return false
end

local function var_0_9(arg_41_0)
	pg = var_1_10001

	local var_41_0 = var_1_10001.m02
	local var_41_1 = var_1.sendNotification

	GAME = var_1_10004

	var_41_1(var_41_0, var_1_10004.BEGIN_STAGE, {
		stageId = arg_41_0.stageId,
		mainFleetId = arg_41_0.mainFleetId,
		system = arg_41_0.system,
		actId = arg_41_0.actId,
		rivalId = arg_41_0.rivalId,
		continuousBattleTimes = arg_41_0.continuousBattleTimes,
		variableBuffList = arg_41_0.variableBuffList,
		totalBattleTimes = arg_41_0.totalBattleTimes,
		useVariableTicket = arg_41_0.useVariableTicket
	})

	return
end

function var_0_1.listNotificationInterests(arg_42_0)
	local var_42_0 = {}

	GAME = var_1_10002
	var_42_0[1] = var_1_10002.BOSSRUSH_SETTLE_DONE
	ContinuousOperationMediator = var_2
	var_42_0[2] = var_2.ON_REENTER
	BossSingleContinuousOperationMediator = var_2
	var_42_0[3] = var_2.ON_REENTER

	return var_42_0
end

function var_0_1.handleNotification(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1
	local var_43_1 = arg_43_1.getName(var_43_0)
	local var_43_2 = arg_43_1:getBody()

	GAME = var_43_0

	if var_43_1 == var_43_0.BOSSRUSH_SETTLE_DONE then
		arg_43_0:ExitRushBossSystem(arg_43_0.contextData, var_43_2)
	else
		ContinuousOperationMediator = var_4

		local var_43_4

		if var_43_1 == var_4.ON_REENTER then
			if not var_43_2.autoFlag then
				var_0_4(arg_43_0.contextData)

				return
			end

			if var_0_8(arg_43_0.contextData.actId, arg_43_0.contextData.stageId) then
				pg = var_43_4

				local var_43_3 = var_43_4.m02

				var_43_4 = var_43_4.sendNotification
				GAME = var_7

				var_43_4(var_43_3, var_7.ACT_BOSS_EXCHANGE_TICKET, {
					stageId = arg_43_0.contextData.stageId
				})
			else
				var_0_9(arg_43_0.contextData)
			end
		else
			BossSingleContinuousOperationMediator = var_43_4

			if var_43_1 == var_43_4.ON_REENTER then
				if not var_43_2.autoFlag then
					var_0_5(arg_43_0.contextData)

					return
				end

				var_0_9(arg_43_0.contextData)
			end
		end
	end

	return
end

function var_0_1.addSubLayers(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	assert = var_1_10004
	isa = var_1_10006

	local var_44_0 = arg_44_1

	Context = var_1_10009

	var_1_10004(var_1_10006(var_44_0, var_1_10009), "should be an instance of Context")

	getProxy = var_1_10004
	ContextProxy = var_6

	local var_44_1 = var_1_10004(var_6)
	local var_44_2 = var_4.getCurrentContext(var_44_1)
	local var_44_3 = var_5.getContextByMediator

	NewBattleResultMediator = var_1_10009

	local var_44_4 = var_44_3(var_44_2, var_1_10009)

	if arg_44_2 then
		while var_44_4.parent do
			var_44_4 = var_44_4.parent
		end
	end

	local var_44_5 = arg_44_0
	local var_44_6 = arg_44_0.sendNotification

	GAME = var_1_10010

	var_44_6(var_44_5, var_1_10010.LOAD_LAYERS, {
		parentContext = var_44_4,
		context = arg_44_1,
		callback = arg_44_3
	})

	return
end

function var_0_1.Dispose(arg_45_0)
	pg = var_1_10001

	local var_45_0 = var_1_10001.m02

	var_1.removeMediator(var_45_0, arg_45_0.__cname)

	return
end

return var_0_1
