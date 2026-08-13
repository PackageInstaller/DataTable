class = var_0_10000

local var_0_0 = "BattleResultMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_BACK_TO_LEVEL_SCENE = "BattleResultMediator.ON_BACK_TO_LEVEL_SCENE"
var_0_1.ON_BACK_TO_DUEL_SCENE = "BattleResultMediator.ON_BACK_TO_DUEL_SCENE"
var_0_1.ON_GO_TO_TASK_SCENE = "BattleResultMediator.ON_GO_TO_TASK_SCENE"
var_0_1.GET_NEW_SHIP = "BattleResultMediator.GET_NEW_SHIP"
var_0_1.ON_GO_TO_MAIN_SCENE = "BattleResultMediator.ON_GO_TO_MAIN_SCENE"
var_0_1.ON_NEXT_CHALLENGE = "BattleResultMediator.ON_NEXT_CHALLENGE"
var_0_1.ON_CHALLENGE_RANK = "BattleResultMediator:ON_CHALLENGE_RANK"
var_0_1.ON_CHALLENGE_SHARE = "BattleResultMediator:ON_CHALLENGE_SHARE"
var_0_1.ON_CHALLENGE_DEFEAT_SCENE = "BattleResultMediator:ON_CHALLENGE_DEFEAT_SCENE"
var_0_1.DIRECT_EXIT = "BattleResultMediator:DIRECT_EXIT"
var_0_1.REENTER_STAGE = "BattleResultMediator:REENTER_STAGE"
var_0_1.OPEN_FAIL_TIP_LAYER = "BattleResultMediator:OPEN_FAIL_TIP_LAYER"
var_0_1.PRE_BATTLE_FAIL_EXIT = "BattleResultMediator:PRE_BATTLE_FAIL_EXIT"
var_0_1.ON_ENTER_BATTLE_RESULT = "BattleResultMediator:ON_ENTER_BATTLE_RESULT"
var_0_1.SET_SKIP_FLAG = "BattleResultMediator:SET_SKIP_FLAG"
var_0_1.ON_COMPLETE_BATTLE_RESULT = "BattleResultMediator:ON_COMPLETE_BATTLE_RESULT"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getData(var_1_0)

	getProxy = var_1_10003
	FleetProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)

	getProxy = var_1_0
	BayProxy = var_1_10006

	local var_1_3 = var_1_0(var_1_10006)

	getProxy = var_1_10005
	ChapterProxy = var_1_10007

	local var_1_4 = var_1_10005(var_1_10007)

	getProxy = var_1_10006
	ActivityProxy = var_1_10008

	local var_1_5 = var_1_10006(var_1_10008)
	local var_1_6 = arg_1_0.contextData.system

	SYSTEM_DUEL = var_1_10008

	if var_1_6 == var_1_10008 then
		getProxy = var_1_10008
		MilitaryExerciseProxy = var_1_10010
		var_1_10011 = var_1_10008(var_1_10010)
		var_1_10009 = var_1_10008.getPreRivalById(var_1_10011, arg_1_0.contextData.rivalId)
		assert = var_1_10010

		var_1_10010(var_1_10009, "should exist rival--" .. arg_1_0.contextData.rivalId)

		var_1_10012 = arg_1_0.viewComponent

		var_1_10010.setRivalVO(var_1_10012, var_1_10009)

		var_1_10012 = arg_1_0.viewComponent
		var_1_10010 = var_1_10010.setRank
		var_1_10013 = var_1_1
		iter_1_14 = var_1_10008

		var_1_10010(var_1_10012, var_1_10013, var_1_10008.getSeasonInfo(iter_1_14))

		goto label_1_0
	end

	SYSTEM_CHALLENGE = var_1_10008

	if var_1_6 == var_1_10008 then
		getProxy = var_1_10008
		ChallengeProxy = var_1_10010
		var_1_10011 = var_1_10008(var_1_10010)
		var_1_10009 = var_1_10008.getUserChallengeInfo(var_1_10011, arg_1_0.contextData.mode)
		var_1_10012 = arg_1_0.viewComponent
		var_1_10010 = var_1_10010.setChallengeInfo
		var_1_10013 = var_1_10009
		iter_1_14 = var_1_10008

		var_1_10010(var_1_10012, var_1_10013, var_1_10008.userSeaonExpire(iter_1_14, arg_1_0.contextData.mode))

		goto label_1_0
	end

	SYSTEM_SCENARIO = var_1_10008

	if var_1_6 ~= var_1_10008 then
		SYSTEM_ROUTINE = var_1_10008

		if var_1_6 ~= var_1_10008 then
			SYSTEM_ACT_BOSS = var_1_10008

			if var_1_6 ~= var_1_10008 then
				SYSTEM_BOSS_SINGLE = var_1_10008

				if var_1_6 ~= var_1_10008 then
					SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10008

					if var_1_6 ~= var_1_10008 then
						SYSTEM_HP_SHARE_ACT_BOSS = var_1_10008

						if var_1_6 ~= var_1_10008 then
							SYSTEM_SUB_ROUTINE = var_1_10008

							if var_1_6 ~= var_1_10008 then
								SYSTEM_WORLD = var_1_10008

								if var_1_6 == var_1_10008 then
									_ = var_1_10008

									local var_1_7 = var_1_10008.detect

									BuffHelper = var_1_10010
									var_1_10010 = var_1_10010.GetBuffsByActivityType
									ActivityConst = var_1_10012

									local var_1_8 = var_1_7(var_1_10010(var_1_10012.ACTIVITY_TYPE_BUFF), function(arg_2_0)
										return arg_2_0:getConfig("benefit_type") == "rookie_battle_exp"
									end)

									var_1_10011 = var_1_5
									var_1_10009 = var_1_5.getBuffShipList(var_1_10011)
									var_1_10012 = arg_1_0.viewComponent

									var_1_10010.setExpBuff(var_1_10012, var_1_8, var_1_10009)
								end

								var_1_10010 = arg_1_0.viewComponent

								var_8.setPlayer(var_1_10010, var_1_1)

								::label_1_0::

								local var_1_9

								SYSTEM_SCENARIO = var_1_10009

								if var_1_6 == var_1_10009 then
									var_1_9 = {}
									var_1_10009 = nil
									SYSTEM_SCENARIO = var_1_10010

									if var_1_6 == var_1_10010 then
										var_1_10012 = var_1_4
										var_1_10009 = var_1_4.getActiveChapter(var_1_10012)
									end

									var_1_10010 = var_1_10009.fleet
									TeamType = var_1_10011
									var_1_10011 = var_1_10010[var_1_10011.Main]
									TeamType = var_1_10012
									var_1_10012 = var_1_10010[var_1_10012.Vanguard]
									ipairs = var_1_10013

									for iter_1_14, iter_1_1 in var_1_10013(var_1_10011) do
										table = iter_1_13

										iter_1_13.insert(var_1_9, iter_1_1)
									end

									ipairs = var_13

									for iter_1_14, iter_1_3 in var_13(var_1_10012) do
										table = iter_1_13

										iter_1_13.insert(var_1_9, iter_1_3)
									end

									_ = var_13

									if var_13.detect(var_1_10009.fleets, function(arg_3_0)
										local var_3_0 = arg_3_0:getFleetType()

										FleetType = var_2_10002

										return var_3_0 == var_2_10002.Submarine
									end) then
										iter_1_14 = var_13

										local var_1_10 = var_13.getShipsByTeam

										TeamType = iter_1_3

										local var_1_11 = var_1_10(iter_1_14, iter_1_3.Submarine, true)

										ipairs = var_1_10015

										for iter_1_13, iter_1_10 in var_1_10015(var_1_11) do
											table = var_1_10020

											var_1_10020.insert(var_1_9, iter_1_10)
										end
									end

									iter_1_14 = arg_1_0.viewComponent

									local var_1_12 = var_14.SetSkipFlag

									iter_1_10 = var_1_4

									var_1_12(iter_1_14, var_1_4.GetChapterAutoFlag(iter_1_10, var_1_10009.id) == 1)

									goto label_1_1
								end

								SYSTEM_WORLD = var_1_10009

								if var_1_6 == var_1_10009 then
									var_1_9 = {}
									nowWorld = var_1_10009
									var_1_10012 = var_1_10009()

									local var_1_13 = var_1_10009.GetActiveMap(var_1_10012)
									local var_1_14 = var_1_10010.GetFleet(var_1_13)

									var_1_10012 = var_1_10011.GetTeamShipVOs
									TeamType = var_1_10015
									var_1_10012 = var_1_10012(var_1_14, var_1_10015.Main, true)
									var_1_10015 = var_1_10011

									local var_1_15 = var_1_10011.GetTeamShipVOs

									TeamType = iter_1_14

									local var_1_16 = var_1_15(var_1_10015, iter_1_14.Vanguard, true)

									ipairs = var_1_14

									for iter_1_6, iter_1_13 in var_1_14(var_1_10012) do
										table = iter_1_10

										iter_1_10.insert(var_1_9, iter_1_13)
									end

									ipairs = var_14

									for iter_1_8, iter_1_13 in var_14(var_1_16) do
										table = iter_1_10

										iter_1_10.insert(var_1_9, iter_1_13)
									end

									iter_1_14 = var_1_10010

									if var_1_10010.GetSubmarineFleet(iter_1_14) then
										local var_1_17 = var_14

										var_1_10015 = var_14.GetTeamShipVOs
										TeamType = iter_1_13
										var_1_10015 = var_1_10015(var_1_17, iter_1_13.Submarine, true)
										ipairs = iter_1_14

										for iter_1_10, iter_1_11 in iter_1_14(var_1_10015) do
											table = var_1_10021

											var_1_10021.insert(var_1_9, iter_1_11)
										end
									end

									local var_1_18 = arg_1_0.viewComponent

									var_1_10015.SetSkipFlag(var_1_18, var_1_10009.isAutoFight)

									goto label_1_1
								end

								SYSTEM_CHALLENGE = var_1_10009

								if var_1_6 == var_1_10009 then
									var_1_10011 = arg_1_0

									arg_1_0.bind(var_1_10011, var_0_1.ON_CHALLENGE_SHARE, function(arg_4_0)
										local var_4_0 = arg_1_0
										local var_4_1 = var_1.addSubLayers

										Context = var_2_10004

										local var_4_2 = var_2_10004.New
										local var_4_3 = {}

										ChallengeShareMediator = var_2_10007
										var_4_3.mediator = var_2_10007
										ChallengeShareLayer = var_2_10007
										var_4_3.viewComponent = var_2_10007
										var_4_3.data = {
											mode = arg_1_0.contextData.mode
										}

										var_4_1(var_4_0, var_4_2(var_4_3))

										return
									end)

									var_1_10011 = arg_1_0

									arg_1_0.bind(var_1_10011, var_0_1.ON_CHALLENGE_DEFEAT_SCENE, function(arg_5_0, arg_5_1)
										local var_5_0 = arg_5_1.callback
										local var_5_1 = arg_1_0
										local var_5_2 = var_3.addSubLayers

										Context = var_2_10006

										local var_5_3 = var_2_10006.New
										local var_5_4 = {}

										ChallengePassedMediator = var_2_10009
										var_5_4.mediator = var_2_10009
										ChallengePassedLayer = var_2_10009
										var_5_4.viewComponent = var_2_10009
										var_5_4.data = {
											mode = arg_1_0.contextData.mode
										}
										var_5_4.onRemoved = var_5_0

										var_5_2(var_5_1, var_5_3(var_5_4))

										return
									end)

									goto label_1_1
								end

								SYSTEM_WORLD_BOSS = var_1_10009

								if var_1_6 == var_1_10009 then
									nowWorld = var_1_10009
									var_1_10012 = var_1_10009()

									local var_1_19 = var_1_10009.GetBossProxy(var_1_10012)

									var_1_10011 = var_1_10010.GetFleet(var_1_19, arg_1_0.contextData.bossId)
									getProxy = var_1_10012
									BayProxy = var_14
									var_1_10015 = var_1_10012(var_14)
									var_1_9 = var_1_10012.getShipsByFleet(var_1_10015, var_1_10011)

									local var_1_20 = arg_1_0.contextData.name

									iter_1_14 = arg_1_0.viewComponent

									var_14.setTitle(iter_1_14, var_1_20)

									goto label_1_1
								end

								SYSTEM_DODGEM = var_1_10009

								if var_1_6 == var_1_10009 then
									goto label_1_1
								end

								SYSTEM_SUBMARINE_RUN = var_1_10009

								if var_1_6 == var_1_10009 then
									goto label_1_1
								end

								SYSTEM_REWARD_PERFORM = var_1_10009

								if var_1_6 == var_1_10009 then
									goto label_1_1
								end

								SYSTEM_AIRFIGHT = var_1_10009

								if var_1_6 == var_1_10009 then
									goto label_1_1
								end

								SYSTEM_CARDPUZZLE = var_1_10009

								if var_1_6 == var_1_10009 then
									goto label_1_1
								end

								SYSTEM_HP_SHARE_ACT_BOSS = var_1_10009

								if var_1_6 ~= var_1_10009 then
									SYSTEM_ACT_BOSS = var_1_10009

									if var_1_6 ~= var_1_10009 then
										SYSTEM_BOSS_SINGLE = var_1_10009

										if var_1_6 ~= var_1_10009 then
											SYSTEM_BOSS_SINGLE_VARIABLE = var_1_10009

											if var_1_6 ~= var_1_10009 then
												SYSTEM_BOSS_EXPERIMENT = var_1_10009

												if var_1_6 == var_1_10009 then
													var_1_10009 = arg_1_0.contextData.actId
													SYSTEM_HP_SHARE_ACT_BOSS = var_1_10010

													if var_1_6 == var_1_10010 then
														var_1_10012 = arg_1_0.viewComponent

														var_1_10010.setActId(var_1_10012, var_1_10009)
													end

													var_1_10012 = var_1_2
													var_1_10011 = var_1_2.getActivityFleets(var_1_10012)[var_1_10009][arg_1_0.contextData.mainFleetId]

													local var_1_21 = var_1_3

													var_1_9 = var_1_3.getShipsByFleet(var_1_21, var_1_10011)
													var_1_10012 = var_1_10010[arg_1_0.contextData.mainFleetId + 10]
													var_1_10015 = var_1_3

													local var_1_22 = var_1_3.getShipsByFleet(var_1_10015, var_1_10012)

													ipairs = var_1_21

													for iter_1_12, iter_1_13 in var_1_21(var_1_22) do
														table = iter_1_10

														iter_1_10.insert(var_1_9, iter_1_13)
													end

													goto label_1_1
												end

												SYSTEM_GUILD = var_1_10009

												if var_1_6 == var_1_10009 then
													var_1_9 = {}
													getProxy = var_1_10009
													GuildProxy = var_1_10011

													local var_1_23 = var_1_10009(var_1_10011)

													var_1_10012 = var_1_10009.getData(var_1_23)

													local var_1_24 = var_1_10009.GetActiveEvent(var_1_10012)
													local var_1_25 = var_1_10010.GetBossMission(var_1_24)

													var_1_10012 = var_11.GetMainFleet(var_1_25)
													ipairs = var_1_24

													for iter_1_14, iter_1_15 in var_1_24(var_1_10012:GetShips()) do
														table = iter_1_13

														iter_1_13.insert(var_1_9, iter_1_15.ship)
													end

													var_1_10015 = var_11

													local var_1_26 = var_11.GetSubFleet(var_1_10015)

													ipairs = var_14

													for iter_1_16, iter_1_17 in var_14(var_1_26:GetShips()) do
														table = iter_1_10

														iter_1_10.insert(var_1_9, iter_1_17.ship)
													end

													goto label_1_1
												end

												SYSTEM_BOSS_RUSH = var_1_10009

												if var_1_6 ~= var_1_10009 then
													SYSTEM_BOSS_RUSH_EX = var_1_10009

													if var_1_6 ~= var_1_10009 then
														SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10009

														if var_1_6 == var_1_10009 then
															local var_1_27 = arg_1_0.contextData.actId

															getProxy = var_1_10010
															ActivityProxy = var_1_10012

															local var_1_28 = var_1_10010(var_1_10012)
															local var_1_29 = var_1_10010.getActivityById(var_1_28, var_1_27)
															local var_1_30 = var_1_10010.GetSeriesData(var_1_29)

															assert = var_1_28

															var_1_28(var_1_30)

															local var_1_31 = var_1_30:GetStaegLevel()

															var_1_10015 = var_1_30

															local var_1_32 = var_1_30.GetStageFleets(var_1_10015, var_1_30:GetMode(), var_1_31)

															iter_1_14 = var_1_2
															var_1_10015 = var_1_2.getActivityFleets(iter_1_14)[var_1_27][var_1_32]
															var_1_9 = var_1_3:getShipsByFleet(var_1_10015)
														else
															local var_1_33 = arg_1_0.contextData.mainFleetId

															var_1_10010 = var_1_2:getFleetById(var_1_33)
															var_1_9 = var_1_3:getShipsByFleet(var_1_10010)
														end

														::label_1_1::

														local var_1_34 = arg_1_0.viewComponent

														var_9.setShips(var_1_34, var_1_9)
														arg_1_0:bind(var_0_1.ON_BACK_TO_LEVEL_SCENE, function(arg_6_0, arg_6_1)
															getProxy = var_2_10002
															ContextProxy = var_2_10004

															local var_6_0 = var_2_10002(var_2_10004)
															local var_6_1 = var_1_6

															SYSTEM_DUEL = var_2_10004

															if var_6_1 == var_2_10004 then
																var_2_10005 = arg_1_0.viewComponent

																local var_6_2 = var_3.emit

																BattleResultMediator = var_2_10006

																var_6_2(var_2_10005, var_2_10006.ON_BACK_TO_DUEL_SCENE)

																do return end

																goto label_6_3
															end

															local var_6_3 = var_1_6

															SYSTEM_ACT_BOSS = var_2_10004

															if var_6_3 == var_2_10004 then
																var_2_10005 = var_6_0

																local var_6_4 = var_6_0.getContextByMediator

																PreCombatMediator = var_2_10006

																local var_6_5

																var_6_5, var_2_10004 = var_6_4(var_2_10005, var_2_10006)

																if var_6_5 then
																	var_2_10007 = var_2_10004

																	var_2_10004.removeChild(var_2_10007, var_6_5)
																end

																var_2_10007 = var_6_0
																var_2_10007 = var_6_0.getCurrentContext(var_2_10007)
																var_2_10005 = var_2_10005.getContextByMediator
																ContinuousOperationMediator = var_2_10008

																if var_2_10005(var_2_10007, var_2_10008) then
																	var_2_10007 = arg_1_0
																	var_2_10005 = var_2_10005.sendNotification
																	ContinuousOperationMediator = var_2_10008

																	var_2_10005(var_2_10007, var_2_10008.CONTINUE_OPERATION)

																	existCall = var_2_10005

																	var_2_10005(arg_1_0.viewComponent.HideConfirmPanel, arg_1_0.viewComponent)

																	getProxy = var_2_10005
																	ActivityProxy = var_2_10007
																	var_2_10007 = var_2_10005(var_2_10007)
																	var_2_10008 = var_2_10005.getActivityById(var_2_10007, arg_1_0.contextData.actId)
																	var_2_10006 = var_2_10005.getConfig(var_2_10008, "config_id")
																	pg = var_2_10007
																	var_2_10007 = var_2_10007.activity_event_worldboss[var_2_10006]
																	var_2_10008 = var_2_10005:IsOilLimit(arg_1_0.contextData.stageId)
																	getProxy = var_2_10009
																	FleetProxy = var_2_10011
																	var_2_10011 = var_2_10009(var_2_10011)

																	local var_6_6 = var_2_10009.getActivityFleets(var_2_10011)[arg_1_0.contextData.actId]

																	var_2_10011 = 0
																	var_2_10012 = var_2_10007.use_oil_limit[arg_1_0.contextData.mainFleetId]

																	function var_2_10014(arg_7_0, arg_7_1)
																		local var_7_0 = arg_7_0:GetCostSum().oil

																		if 0 < arg_7_1 then
																			math = var_3
																			var_7_0 = var_3.min(var_7_0, arg_7_1)
																		end

																		var_2_10011 = var_2_10011 + var_7_0

																		return
																	end

																	var_2_10016 = var_6_6[arg_1_0.contextData.mainFleetId]

																	if not var_2_10008 or not var_2_10012[1] then
																		var_2_10017 = 0
																	end

																	var_2_10014(var_2_10016, var_2_10017)

																	var_2_10014 = var_13
																	var_2_10016 = var_6_6[arg_1_0.contextData.mainFleetId + 10]

																	if not var_2_10008 or not var_2_10012[2] then
																		var_2_10017 = 0
																	end

																	var_2_10014(var_2_10016, var_2_10017)

																	getProxy = var_2_10014
																	PlayerProxy = var_2_10016
																	var_2_10016 = var_2_10014(var_2_10016)

																	if var_2_10014.getRawData(var_2_10016).oil < var_2_10011 then
																		i18n = var_2_10015
																		var_2_10015 = var_2_10015("multiple_sorties_stop_reason1")
																		var_2_10018 = arg_1_0

																		var_2_10016.DisplayTotalReward(var_2_10018, var_2_10015)

																		return
																	end

																	getProxy = var_2_10015
																	BayProxy = var_2_10017
																	var_2_10017 = var_2_10015(var_2_10017)
																	var_2_10015 = var_2_10015.getShipCount(var_2_10017)
																	getProxy = var_2_10016
																	PlayerProxy = var_2_10018

																	local var_6_7 = var_2_10016(var_2_10018)
																	local var_6_8 = var_2_10016.getRawData(var_6_7)

																	if var_2_10016.getMaxShipBag(var_6_8) <= var_2_10015 then
																		i18n = var_2_10016
																		var_2_10016 = var_2_10016("multiple_sorties_stop_reason3")
																		var_2_10019 = arg_1_0

																		var_2_10017.DisplayTotalReward(var_2_10019, var_2_10016)

																		return
																	end

																	var_2_10016 = var_6_6[arg_1_0.contextData.mainFleetId]
																	_ = var_2_10017
																	var_2_10017 = var_2_10017.map
																	_ = var_2_10019

																	local var_6_9 = #var_2_10017(var_2_10019.values(var_2_10016.ships), function(arg_8_0)
																		getProxy = var_3_10001
																		BayProxy = var_3_10003

																		local var_8_0 = var_3_10001(var_3_10003)

																		if var_1.getShipById(var_8_0, arg_8_0) then
																			local var_8_1 = var_1.energy

																			Ship = var_8_0

																			if var_8_1 == var_8_0.ENERGY_LOW then
																				return var_1
																			end
																		end

																		return
																	end)

																	if 0 < var_6_9 then
																		Fleet = var_6_9

																		local var_6_10 = var_6_9.DEFAULT_NAME_BOSS_ACT[arg_1_0.contextData.mainFleetId]

																		_ = var_2_10019
																		var_2_10019 = var_2_10019.map(var_2_10017, function(arg_9_0)
																			return "「" .. arg_9_0:getConfig("name") .. "」"
																		end)
																		i18n = var_2_10020
																		var_2_10022 = "multiple_sorties_stop_reason2"
																		var_2_10023 = var_6_10
																		table = var_2_10024
																		var_2_10020 = var_2_10020(var_2_10022, var_2_10023, var_2_10024.concat(var_2_10019, ""))
																		var_2_10023 = arg_1_0

																		var_2_10021.DisplayTotalReward(var_2_10023, var_2_10020)

																		return
																	end

																	local var_6_11 = arg_1_0.contextData.statistics._battleScore

																	ys = var_2_10019

																	if var_6_11 <= var_2_10019.Battle.BattleConst.BattleScore.C then
																		i18n = var_6_11
																		var_6_11 = var_6_11("multiple_sorties_stop_reason4")
																		var_2_10021 = arg_1_0

																		var_2_10019.DisplayTotalReward(var_2_10021, var_6_11)

																		return
																	end

																	pg = var_6_11
																	var_2_10021 = var_6_11.GuildMsgBoxMgr.GetInstance()

																	if var_18.GetShouldShowBattleTip(var_2_10021) then
																		getProxy = var_2_10019
																		GuildProxy = var_2_10021
																		var_2_10021 = var_2_10019(var_2_10021)

																		if var_2_10019.getRawData(var_2_10021) then
																			::label_6_0::

																			var_2_10022 = var_2_10019
																			var_2_10020 = var_2_10019.getWeeklyTask(var_2_10022)
																		end

																		if var_2_10020 and var_2_10020.id ~= 0 then
																			var_2_10023 = var_18

																			var_18.SubmitTask(var_2_10023, function(arg_10_0, arg_10_1)
																				if arg_10_1 then
																					local var_10_0 = var_0

																					var_2.CancelShouldShowBattleTip(var_10_0)
																				end

																				return
																			end)
																		end
																	end

																	var_2_10021 = var_6_0
																	var_2_10021 = var_6_0.getCurrentContext(var_2_10021)
																	var_2_10019 = var_2_10019.getContextByMediator
																	ContinuousOperationMediator = var_2_10022

																	if var_2_10019(var_2_10021, var_2_10022) and not var_2_10019.data.autoFlag then
																		local var_6_12 = arg_1_0

																		var_2_10020.DisplayTotalReward(var_6_12)

																		return
																	end

																	if arg_1_0.contextData.continuousBattleTimes < 1 then
																		local var_6_13 = arg_1_0

																		var_2_10020.DisplayTotalReward(var_6_13)

																		return
																	end

																	local var_6_14 = arg_1_0

																	var_2_10020 = var_2_10020.sendNotification
																	BattleResultMediator = var_2_10023

																	var_2_10020(var_6_14, var_2_10023.ON_COMPLETE_BATTLE_RESULT)

																	return
																end

																goto label_6_3
															end

															local var_6_15 = var_1_6

															SYSTEM_ROUTINE = var_2_10004

															if var_6_15 ~= var_2_10004 then
																local var_6_16 = var_1_6

																SYSTEM_SUB_ROUTINE = var_2_10004

																if var_6_16 == var_2_10004 then
																	var_2_10005 = var_6_0

																	local var_6_17 = var_6_0.getContextByMediator

																	DailyLevelMediator = var_2_10006

																	if var_6_17(var_2_10005, var_2_10006) then
																		var_2_10006 = var_3
																		var_2_10004 = var_3.getContextByMediator
																		PreCombatMediator = var_2_10007
																		var_2_10004 = var_2_10004(var_2_10006, var_2_10007)
																		var_2_10007 = var_3

																		var_3.removeChild(var_2_10007, var_2_10004)
																	end

																	goto label_6_3
																end

																local var_6_18 = var_1_6

																SYSTEM_SCENARIO = var_2_10004

																if var_6_18 == var_2_10004 then
																	var_2_10005 = var_6_0

																	local var_6_19 = var_6_0.getContextByMediator

																	LevelMediator2 = var_2_10006
																	var_2_10006 = var_6_19(var_2_10005, var_2_10006)
																	var_2_10004 = var_3.getContextByMediator
																	ChapterPreCombatMediator = var_2_10007

																	if var_2_10004(var_2_10006, var_2_10007) then
																		var_2_10007 = var_3

																		var_3.removeChild(var_2_10007, var_2_10004)
																	end

																	var_2_10005 = arg_1_0.contextData.score

																	if 1 < var_2_10005 then
																		var_2_10007 = arg_1_0

																		var_2_10005.showExtraChapterActSocre(var_2_10007)
																	end

																	getProxy = var_2_10005
																	ChapterProxy = var_2_10007
																	var_2_10008 = var_2_10005(var_2_10007)

																	if var_2_10005.getActiveChapter(var_2_10008) then
																		var_2_10009 = var_2_10006

																		if var_2_10006.existOni(var_2_10009) then
																			var_2_10009 = var_2_10006

																			var_2_10006.clearSubmarineFleet(var_2_10009)

																			var_2_10009 = var_2_10005

																			var_2_10005.updateChapter(var_2_10009, var_2_10006)
																		else
																			var_2_10009 = var_2_10006

																			if var_2_10006.isPlayingWithBombEnemy(var_2_10009) then
																				var_2_10006.fleets = {
																					var_2_10006.fleet
																				}
																				var_2_10006.findex = 1
																				var_2_10009 = var_2_10005

																				var_2_10005.updateChapter(var_2_10009, var_2_10006)
																			end
																		end
																	end

																	goto label_6_3
																end

																local var_6_20 = var_1_6

																SYSTEM_CHALLENGE = var_2_10004

																if var_6_20 == var_2_10004 then
																	getProxy = var_6_20
																	ChallengeProxy = var_2_10005

																	local var_6_21 = var_6_20(var_2_10005)

																	var_2_10004 = arg_1_0.contextData.mode
																	var_2_10007 = var_6_21
																	var_2_10005 = var_6_21.getUserChallengeInfo(var_2_10007, var_2_10004)
																	var_2_10006 = arg_1_0.contextData.score
																	ys = var_2_10007

																	if var_2_10006 < var_2_10007.Battle.BattleConst.BattleScore.S then
																		var_2_10008 = arg_1_0
																		var_2_10006 = var_2_10006.sendNotification
																		GAME = var_2_10009

																		var_2_10006(var_2_10008, var_2_10009.CHALLENGE2_RESET, {
																			mode = var_2_10004
																		})
																	else
																		var_2_10008 = var_2_10005
																		var_2_10006 = var_2_10005.IsFinish(var_2_10008)

																		var_2_10005:updateLevelForward()

																		var_2_10007 = var_2_10005:getMode()
																		ChallengeProxy = var_2_10008

																		if var_2_10007 == var_2_10008.MODE_INFINITE and var_2_10006 then
																			var_2_10005:setInfiniteDungeonIDListByLevel()
																		end
																	end

																	var_2_10008 = var_6_21
																	var_2_10006 = var_6_21.getChallengeInfo(var_2_10008)

																	local var_6_22 = var_6_21

																	var_2_10007 = var_6_21.userSeaonExpire
																	var_2_10012 = var_2_10005

																	if not var_2_10007(var_6_22, var_2_10005.getMode(var_2_10012)) then
																		var_2_10006:checkRecord(var_2_10005)
																	end

																	if not arg_6_1.goToNext then
																		local var_6_23 = var_6_0

																		var_2_10007 = var_6_0.getContextByMediator
																		ChallengeMainMediator = var_10

																		if var_2_10007(var_6_23, var_10) then
																			local var_6_24 = var_2_10007

																			var_2_10008 = var_2_10007.getContextByMediator
																			ChallengePreCombatMediator = var_2_10011
																			var_2_10008 = var_2_10008(var_6_24, var_2_10011)

																			var_2_10007:removeChild(var_2_10008)
																		end
																	end

																	goto label_6_3
																end

																local var_6_25 = var_1_6

																SYSTEM_HP_SHARE_ACT_BOSS = var_2_10004

																if var_6_25 == var_2_10004 then
																	var_2_10005 = var_6_0

																	local var_6_26 = var_6_0.getContextByMediator

																	PreCombatMediator = var_2_10006

																	local var_6_27

																	var_6_27, var_2_10004 = var_6_26(var_2_10005, var_2_10006)

																	if var_6_27 then
																		var_2_10007 = var_2_10004

																		var_2_10004.removeChild(var_2_10007, var_6_27)
																	end

																	goto label_6_3
																end

																local var_6_28 = var_1_6

																SYSTEM_WORLD_BOSS = var_2_10004

																if var_6_28 == var_2_10004 then
																	var_2_10005 = var_6_0

																	local var_6_29 = var_6_0.getContextByMediator

																	WorldBossMediator = var_2_10006
																	var_2_10006 = var_6_29(var_2_10005, var_2_10006)
																	var_2_10004 = var_3.getContextByMediator
																	WorldBossFormationMediator = var_2_10007

																	if var_2_10004(var_2_10006, var_2_10007) then
																		var_2_10007 = var_3

																		var_3.removeChild(var_2_10007, var_2_10004)
																	end

																	goto label_6_3
																end

																local var_6_30 = var_1_6

																SYSTEM_WORLD = var_2_10004

																if var_6_30 == var_2_10004 then
																	var_2_10005 = var_6_0

																	local var_6_31 = var_6_0.getContextByMediator

																	WorldMediator = var_2_10006
																	var_2_10006 = var_6_31(var_2_10005, var_2_10006)
																	var_2_10004 = var_3.getContextByMediator
																	WorldPreCombatMediator = var_2_10007

																	if not var_2_10004(var_2_10006, var_2_10007) then
																		var_2_10006 = var_3
																		var_2_10004 = var_3.getContextByMediator
																		WorldBossInformationMediator = var_2_10007
																		var_2_10004 = var_2_10004(var_2_10006, var_2_10007)
																	end

																	if var_2_10004 then
																		var_2_10007 = var_3

																		var_3.removeChild(var_2_10007, var_2_10004)
																	end

																	goto label_6_3
																end

																local var_6_32 = var_1_6

																SYSTEM_BOSS_RUSH = var_2_10004

																if var_6_32 ~= var_2_10004 then
																	local var_6_33 = var_1_6

																	SYSTEM_BOSS_RUSH_EX = var_2_10004

																	if var_6_33 ~= var_2_10004 then
																		local var_6_34 = var_1_6

																		SYSTEM_BOSS_RUSH_COLLABRATE = var_2_10004

																		if var_6_34 == var_2_10004 then
																			local var_6_35 = arg_1_0.contextData.score

																			ys = var_2_10004

																			local var_6_36 = var_2_10004.Battle.BattleConst.BattleScore.C < var_6_35

																			var_2_10004 = arg_1_0.contextData.actId
																			getProxy = var_2_10005
																			ActivityProxy = var_2_10007
																			var_2_10007 = var_2_10005(var_2_10007)
																			var_2_10008 = var_5.getActivityById(var_2_10007, var_2_10004)
																			var_2_10006 = var_5.GetSeriesData(var_2_10008)
																			assert = var_2_10007

																			var_2_10007(var_2_10006)

																			var_2_10007 = var_2_10006:GetStaegLevel() + 1
																			var_2_10008 = var_2_10006:GetExpeditionIds()

																			local var_6_37 = var_6_0:getCurrentContext()
																			local var_6_38 = var_9.getContextByMediator

																			ContinuousOperationMediator = var_2_10012

																			local var_6_39 = not var_6_38(var_6_37, var_2_10012) or var_9.data.autoFlag

																			arg_1_0.contextData.isAutoFight = var_6_39

																			local var_6_40 = var_6_0:getCurrentContext()
																			local var_6_41 = var_11.getContextByMediator

																			ContinuousOperationMediator = var_2_10014

																			if var_6_41(var_6_40, var_2_10014) then
																				pg = var_11

																				local var_6_42 = var_11.GuildMsgBoxMgr.GetInstance()

																				if var_11.GetShouldShowBattleTip(var_6_42) then
																					getProxy = var_2_10012
																					GuildProxy = var_6_42

																					local var_6_43 = var_2_10012(var_6_42)
																					local var_6_44

																					if var_2_10012.getRawData(var_6_43) then
																						::label_6_1::

																						var_2_10015 = var_2_10012
																						var_6_44 = var_2_10012.getWeeklyTask(var_2_10015)
																					end

																					if var_6_44 and var_6_44.id ~= 0 then
																						var_2_10016 = var_11

																						var_11.SubmitTask(var_2_10016, function(arg_11_0, arg_11_1)
																							if arg_11_1 then
																								local var_11_0 = var_0

																								var_2.CancelShouldShowBattleTip(var_11_0)
																							end

																							return
																						end)
																					end
																				end
																			end

																			if not var_6_36 or #var_2_10008 < var_2_10007 or not var_6_39 then
																				local var_6_45 = var_6_0:GetPrevContext(1)

																				var_2_10012 = var_11.getContextByMediator
																				BossRushPreCombatMediator = var_2_10015

																				if var_2_10012(var_6_45, var_2_10015) then
																					var_2_10015 = var_11

																					var_11.removeChild(var_2_10015, var_2_10012)
																				end

																				var_2_10015 = var_11

																				local var_6_46 = var_11.getContextByMediator

																				BossRushFleetSelectMediator = var_2_10016

																				if var_6_46(var_2_10015, var_2_10016) then
																					var_2_10016 = var_11

																					var_11.removeChild(var_2_10016, var_13)
																				end

																				var_2_10016 = arg_1_0

																				local var_6_47 = var_14.sendNotification

																				GAME = var_2_10017

																				var_6_47(var_2_10016, var_2_10017.BOSSRUSH_SETTLE, {
																					actId = arg_1_0.contextData.actId
																				})
																			else
																				seriesAsync = var_11

																				var_11({
																					function(arg_12_0)
																						local var_12_0 = arg_1_0
																						local var_12_1 = var_1.addSubLayers

																						Context = var_3_10004

																						local var_12_2 = var_3_10004.New
																						local var_12_3 = {}

																						ChallengePassedMediator = var_3_10007
																						var_12_3.mediator = var_3_10007
																						BossRushPassedLayer = var_3_10007
																						var_12_3.viewComponent = var_3_10007
																						var_12_3.data = {
																							curIndex = var_2_10007 - 1,
																							maxIndex = #var_2_10008
																						}
																						var_12_3.onRemoved = arg_12_0

																						var_12_1(var_12_0, var_12_2(var_12_3))

																						return
																					end,
																					function(arg_13_0)
																						local var_13_0 = arg_1_0
																						local var_13_1 = var_1.sendNotification

																						GAME = var_3_10004

																						var_13_1(var_13_0, var_3_10004.BEGIN_STAGE, {
																							system = arg_1_0.contextData.system,
																							actId = var_2_10004,
																							continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes,
																							totalBattleTimes = arg_1_0.contextData.totalBattleTimes
																						})

																						return
																					end
																				})
																			end

																			do return end

																			goto label_6_3
																		end

																		local var_6_48 = var_1_6

																		SYSTEM_CARDPUZZLE = var_2_10004

																		if var_6_48 == var_2_10004 then
																			goto label_6_3
																		end

																		local var_6_49 = var_1_6

																		SYSTEM_BOSS_SINGLE = var_2_10004

																		if var_6_49 ~= var_2_10004 then
																			do
																				local var_6_50 = var_1_6

																				SYSTEM_BOSS_SINGLE_VARIABLE = var_2_10004

																				if var_6_50 == var_2_10004 then
																					local var_6_51 = var_6_0
																					local var_6_52 = var_6_0.getContextByMediator

																					PreCombatMediator = var_2_10006

																					local var_6_53, var_6_54 = var_6_52(var_6_51, var_2_10006)

																					if var_6_53 then
																						var_2_10007 = var_6_54

																						var_6_54.removeChild(var_2_10007, var_6_53)
																					end

																					var_2_10007 = var_6_0
																					var_2_10007 = var_6_0.getCurrentContext(var_2_10007)

																					local var_6_55 = var_5.getContextByMediator

																					BossSingleContinuousOperationMediator = var_2_10008

																					if var_6_55(var_2_10007, var_2_10008) then
																						var_2_10007 = arg_1_0

																						local var_6_56 = var_5.sendNotification

																						BossSingleContinuousOperationMediator = var_2_10008

																						var_6_56(var_2_10007, var_2_10008.CONTINUE_OPERATION)

																						existCall = var_6_56

																						var_6_56(arg_1_0.viewComponent.HideConfirmPanel, arg_1_0.viewComponent)

																						getProxy = var_6_56
																						ActivityProxy = var_2_10007
																						var_2_10007 = var_6_56(var_2_10007)

																						local var_6_57 = var_5.getActivityById(var_2_10007, arg_1_0.contextData.actId)

																						getProxy = var_2_10006
																						FleetProxy = var_8

																						local var_6_58 = var_2_10006(var_8)

																						var_2_10007 = var_2_10006.getActivityFleets(var_6_58)[arg_1_0.contextData.actId]

																						local var_6_59 = 0
																						local var_6_60 = var_6_57:GetOilLimits()[arg_1_0.contextData.mainFleetId]

																						local function var_6_61(arg_14_0, arg_14_1)
																							local var_14_0 = arg_14_0:GetCostSum().oil

																							if 0 < arg_14_1 then
																								math = var_3
																								var_14_0 = var_3.min(var_14_0, arg_14_1)
																							end

																							var_6_59 = var_6_59 + var_14_0

																							return
																						end

																						local var_6_62 = var_2_10007[arg_1_0.contextData.mainFleetId]
																						local var_6_63

																						if not var_6_60[1] then
																							var_6_63 = 0
																						end

																						var_6_61(var_6_62, var_6_63)

																						local var_6_64 = var_10
																						local var_6_65 = var_2_10007[arg_1_0.contextData.mainFleetId + 10]
																						local var_6_66

																						if not var_6_60[2] then
																							var_6_66 = 0
																						end

																						var_6_64(var_6_65, var_6_66)

																						getProxy = var_6_64
																						PlayerProxy = var_6_65

																						local var_6_67 = var_6_64(var_6_65)

																						if var_6_59 > var_11.getRawData(var_6_67).oil then
																							i18n = var_2_10012
																							var_2_10012 = var_2_10012("multiple_sorties_stop_reason1")
																							var_2_10015 = arg_1_0

																							var_6_67.DisplayBossSingleTotalReward(var_2_10015, var_2_10012)

																							return
																						end

																						getProxy = var_2_10012
																						BayProxy = var_6_66

																						local var_6_68 = var_2_10012(var_6_66)
																						local var_6_69 = var_12.getShipCount(var_6_68)

																						getProxy = var_6_67
																						PlayerProxy = var_2_10015

																						local var_6_70 = var_6_67(var_2_10015)
																						local var_6_71 = var_13.getRawData(var_6_70)

																						if var_13.getMaxShipBag(var_6_71) <= var_6_69 then
																							i18n = var_13

																							local var_6_72 = var_13("multiple_sorties_stop_reason3")

																							var_2_10016 = arg_1_0

																							var_6_68.DisplayBossSingleTotalReward(var_2_10016, var_6_72)

																							return
																						end

																						local var_6_73 = var_2_10007[arg_1_0.contextData.mainFleetId]

																						_ = var_6_68

																						local var_6_74 = var_6_68.map

																						_ = var_2_10016

																						local var_6_75 = #var_6_74(var_2_10016.values(var_6_73.ships), function(arg_15_0)
																							getProxy = var_3_10001
																							BayProxy = var_3_10003

																							local var_15_0 = var_3_10001(var_3_10003)

																							if var_1.getShipById(var_15_0, arg_15_0) then
																								local var_15_1 = var_1.energy

																								Ship = var_15_0

																								if var_15_1 == var_15_0.ENERGY_LOW then
																									return var_1
																								end
																							end

																							return
																						end)
																						local var_6_77

																						if 0 < var_6_75 then
																							Fleet = var_6_75

																							local var_6_76 = var_6_75.DEFAULT_NAME_BOSS_ACT[arg_1_0.contextData.mainFleetId]

																							_ = var_6_77
																							var_6_77 = var_6_77.map(var_14, function(arg_16_0)
																								return "「" .. arg_16_0:getConfig("name") .. "」"
																							end)
																							i18n = var_17
																							var_2_10019 = "multiple_sorties_stop_reason2"
																							var_2_10020 = var_6_76
																							table = var_2_10021

																							local var_6_78 = var_17(var_2_10019, var_2_10020, var_2_10021.concat(var_6_77, ""))

																							var_2_10020 = arg_1_0

																							var_18.DisplayBossSingleTotalReward(var_2_10020, var_6_78)

																							return
																						end

																						local var_6_79 = arg_1_0.contextData.statistics._battleScore

																						ys = var_6_77

																						if var_6_79 <= var_6_77.Battle.BattleConst.BattleScore.C then
																							i18n = var_6_79
																							var_6_79 = var_6_79("multiple_sorties_stop_reason4")

																							local var_6_80 = arg_1_0

																							var_16.DisplayBossSingleTotalReward(var_6_80, var_6_79)

																							return
																						end

																						pg = var_6_79

																						local var_6_81 = var_6_79.GuildMsgBoxMgr.GetInstance()

																						if var_15.GetShouldShowBattleTip(var_6_81) then
																							getProxy = var_16
																							GuildProxy = var_6_81

																							local var_6_82 = var_16(var_6_81)
																							local var_6_83

																							if var_16.getRawData(var_6_82) then
																								::label_6_2::

																								var_2_10019 = var_16
																								var_6_83 = var_16.getWeeklyTask(var_2_10019)
																							end

																							if var_6_83 and var_6_83.id ~= 0 then
																								var_2_10020 = var_15

																								var_15.SubmitTask(var_2_10020, function(arg_17_0, arg_17_1)
																									if arg_17_1 then
																										local var_17_0 = var_0

																										var_2.CancelShouldShowBattleTip(var_17_0)
																									end

																									return
																								end)
																							end
																						end

																						local var_6_84 = var_6_0:getCurrentContext()
																						local var_6_85 = var_16.getContextByMediator

																						BossSingleContinuousOperationMediator = var_2_10019

																						if var_6_85(var_6_84, var_2_10019) and not var_16.data.autoFlag then
																							local var_6_86 = arg_1_0

																							var_17.DisplayBossSingleTotalReward(var_6_86)

																							return
																						end

																						if arg_1_0.contextData.continuousBattleTimes < 1 then
																							local var_6_87 = arg_1_0

																							var_17.DisplayBossSingleTotalReward(var_6_87)

																							return
																						end

																						local var_6_88 = arg_1_0
																						local var_6_89 = var_17.sendNotification

																						BattleResultMediator = var_2_10020

																						var_6_89(var_6_88, var_2_10020.ON_COMPLETE_BATTLE_RESULT)

																						return
																					end
																				else
																					local var_6_90 = var_6_0
																					local var_6_91 = var_6_0.getContextByMediator

																					LevelMediator2 = var_2_10006

																					if var_6_91(var_6_90, var_2_10006) then
																						var_2_10006 = var_3

																						local var_6_92 = var_3.getContextByMediator

																						PreCombatMediator = var_2_10007

																						local var_6_93 = var_6_92(var_2_10006, var_2_10007)

																						var_3:removeChild(var_6_93)
																					end
																				end
																			end

																			::label_6_3::

																			local var_6_94 = arg_1_0
																			local var_6_95 = var_3.sendNotification

																			GAME = var_2_10006

																			var_6_95(var_6_94, var_2_10006.GO_BACK)

																			return
																		end
																	end
																end
															end
														end)
														arg_1_0:bind(var_0_1.ON_GO_TO_MAIN_SCENE, function(arg_18_0)
															local var_18_0 = arg_1_0
															local var_18_1 = var_1.sendNotification

															GAME = var_2_10004

															local var_18_2 = var_2_10004.CHANGE_SCENE

															SCENE = var_2_10005

															var_18_1(var_18_0, var_18_2, var_2_10005.MAINUI)

															return
														end)
														arg_1_0:bind(var_0_1.ON_GO_TO_TASK_SCENE, function(arg_19_0)
															getProxy = var_2_10001
															ContextProxy = var_2_10003

															local var_19_0 = var_2_10001(var_2_10003)
															local var_19_1 = var_1.getContextByMediator

															LevelMediator2 = var_2_10005

															if var_19_1(var_19_0, var_2_10005) then
																local var_19_2 = var_2
																local var_19_3 = var_2.getContextByMediator

																PreCombatMediator = var_2_10006

																local var_19_4 = var_19_3(var_19_2, var_2_10006)

																var_2_10006 = var_2

																var_2.removeChild(var_2_10006, var_19_4)
															end

															local var_19_5 = arg_1_0
															local var_19_6 = var_3.sendNotification

															GAME = var_2_10006

															local var_19_7 = var_2_10006.CHANGE_SCENE

															SCENE = var_2_10007

															var_19_6(var_19_5, var_19_7, var_2_10007.TASK)

															return
														end)
														arg_1_0:bind(var_0_1.ON_BACK_TO_DUEL_SCENE, function(arg_20_0)
															getProxy = var_2_10001
															ContextProxy = var_2_10003

															local var_20_0 = var_2_10001(var_2_10003)
															local var_20_1 = var_1.getContextByMediator

															MilitaryExerciseMediator = var_2_10005

															if var_20_1(var_20_0, var_2_10005) then
																local var_20_2 = var_2
																local var_20_3 = var_2.getContextByMediator

																ExercisePreCombatMediator = var_2_10006

																local var_20_4 = var_20_3(var_20_2, var_2_10006)

																var_2_10006 = var_2

																var_2.removeChild(var_2_10006, var_20_4)
															end

															local var_20_5 = arg_1_0
															local var_20_6 = var_3.sendNotification

															GAME = var_2_10006

															var_20_6(var_20_5, var_2_10006.GO_BACK)

															return
														end)
														arg_1_0:bind(var_0_1.GET_NEW_SHIP, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
															local var_21_0 = arg_1_0
															local var_21_1 = var_4.addSubLayers

															Context = var_2_10007

															local var_21_2 = var_2_10007.New
															local var_21_3 = {}

															NewShipMediator = var_2_10010
															var_21_3.mediator = var_2_10010
															NewShipLayer = var_2_10010
															var_21_3.viewComponent = var_2_10010
															var_21_3.data = {
																ship = arg_21_1,
																autoExitTime = arg_21_3
															}
															var_21_3.onRemoved = arg_21_2

															var_21_1(var_21_0, var_21_2(var_21_3))

															return
														end)
														arg_1_0:bind(var_0_1.OPEN_FAIL_TIP_LAYER, function(arg_22_0)
															setActive = var_2_10001

															var_2_10001(arg_1_0.viewComponent._tf, false)

															local var_22_0 = arg_1_0
															local var_22_1 = var_1.addSubLayers

															Context = var_4

															local var_22_2 = var_4.New
															local var_22_3 = {}

															BattleFailTipMediator = var_2_10007
															var_22_3.mediator = var_2_10007
															BattleFailTipLayer = var_2_10007
															var_22_3.viewComponent = var_2_10007
															var_22_3.data = {
																mainShips = var_1_9,
																battleSystem = arg_1_0.contextData.system
															}

															function var_22_3.onRemoved()
																local var_23_0 = arg_1_0.viewComponent
																local var_23_1 = var_0.emit

																BattleResultMediator = var_3_10003

																var_23_1(var_23_0, var_3_10003.ON_BACK_TO_DUEL_SCENE)

																return
															end

															var_22_1(var_22_0, var_22_2(var_22_3))

															return
														end)
														arg_1_0:bind(var_0_1.DIRECT_EXIT, function(arg_24_0, arg_24_1)
															local var_24_0 = arg_1_0
															local var_24_1 = var_2.sendNotification

															GAME = var_2_10005

															var_24_1(var_24_0, var_2_10005.GO_BACK)

															return
														end)
														arg_1_0:bind(var_0_1.REENTER_STAGE, function(arg_25_0)
															local var_25_0 = arg_1_0
															local var_25_1 = var_1.sendNotification

															GAME = var_2_10004

															var_25_1(var_25_0, var_2_10004.BEGIN_STAGE, {
																stageId = arg_1_0.contextData.stageId,
																mainFleetId = arg_1_0.contextData.mainFleetId,
																system = arg_1_0.contextData.system,
																actId = arg_1_0.contextData.actId,
																rivalId = arg_1_0.contextData.rivalId,
																variableBuffList = arg_1_0.contextData.variableBuffList,
																continuousBattleTimes = arg_1_0.contextData.continuousBattleTimes,
																totalBattleTimes = arg_1_0.contextData.totalBattleTimes,
																useVariableTicket = arg_1_0.contextData.useVariableTicket
															})

															return
														end)
														arg_1_0:bind(var_0_1.PRE_BATTLE_FAIL_EXIT, function(arg_26_0)
															local var_26_0 = var_1_6

															SYSTEM_SCENARIO = var_2_10002

															if var_26_0 == var_2_10002 then
																getProxy = var_26_0
																ChapterProxy = var_2_10003

																local var_26_1 = var_26_0(var_2_10003)
																local var_26_2 = var_1.StopAutoFight

																ChapterConst = var_2_10004

																var_26_2(var_26_1, var_2_10004.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
															end

															return
														end)

														local var_1_35 = arg_1_0
														local var_1_36 = arg_1_0.bind

														GAME = var_12

														var_1_36(var_1_35, var_12.ACT_BOSS_EXCHANGE_TICKET, function(arg_27_0, arg_27_1)
															local var_27_0 = arg_1_0
															local var_27_1 = var_2.sendNotification

															GAME = var_2_10005

															var_27_1(var_27_0, var_2_10005.ACT_BOSS_EXCHANGE_TICKET, {
																stageId = arg_27_1
															})

															return
														end)

														local var_1_37 = 0

														if var_1_9 then
															ipairs = var_1_10010

															for iter_1_18, iter_1_19 in var_1_10010(var_1_9) do
																var_1_37 = iter_1_19:getBattleTotalExpend() + var_1_37
															end
														end

														originalPrint = var_1_10010

														var_1_10010("耗时：", arg_1_0.contextData.statistics._totalTime, "秒")

														originalPrint = var_1_10010

														var_1_10010("编队基础油耗：", var_1_37)

														if arg_1_0.contextData.statistics._enemyInfoList then
															pairs = var_10

															for iter_1_20, iter_1_21 in var_10(arg_1_0.contextData.statistics._enemyInfoList) do
																originalPrint = var_1_10015

																var_1_10015("目标ID>>", iter_1_21.id, "<< 受到伤害共 >>", iter_1_21.damage, "<< 点")
															end
														end

														local var_1_38 = false

														SYSTEM_SCENARIO = var_1_35

														if var_1_6 == var_1_35 then
															iter_1_20 = var_1_4
															var_1_35 = var_1_4.getActiveChapter(iter_1_20)
															getProxy = var_12
															ChapterProxy = iter_1_21

															local var_1_39 = var_12(iter_1_21)

															var_1_38 = var_12.GetChapterAutoFlag(var_1_39, var_1_35.id) == 1
														else
															SYSTEM_WORLD = var_1_35

															if var_1_6 == var_1_35 then
																nowWorld = var_1_35
																var_1_38 = var_1_35().isAutoFight
															end
														end

														PlayerPrefs = var_1_35

														local var_1_40 = var_1_35.GetInt

														AUTO_BATTLE_LABEL = iter_1_20

														local var_1_41 = var_1_40(iter_1_20, 0)
														local var_1_42 = 0 < var_1_41

														ys = var_12

														if var_12.Battle.BattleState.IsAutoBotActive() and var_1_42 and not var_1_38 then
															pg = iter_1_20

															local var_1_43 = iter_1_20.CriMgr.GetInstance()
															local var_1_44 = var_13.PlaySoundEffect_V3

															SFX_AUTO_BATTLE = iter_1_14

															var_1_44(var_1_43, iter_1_14)

															LuaHelper = var_1_44

															var_1_44.Vibrate()
														end

														arg_1_0:sendNotification(var_0_1.ON_ENTER_BATTLE_RESULT)

														return
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_1.showExtraChapterActSocre(arg_28_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_28_0 = var_1_10001(var_1_10003)
	local var_28_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10005

	local var_28_2 = var_28_1(var_28_0, var_1_10005.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK)

	getProxy = var_1_10003
	ChapterProxy = var_5

	local var_28_3 = var_1_10003(var_5)
	local var_28_4 = var_3.getActiveChapter(var_28_3) and var_3:getMapById(var_4:getConfig("map"))

	ipairs = var_28_3

	for iter_28_0, iter_28_1 in var_28_3(var_28_2) do
		if iter_28_1 and not iter_28_1:isEnd() then
			local var_28_5 = iter_28_1:getConfig("config_data")
			local var_28_6 = arg_28_0.contextData.stageId

			if var_28_5[1] == var_28_6 and var_28_4 and var_28_4:isActExtra() then
				math = var_13

				local var_28_7 = var_13.floor(arg_28_0.contextData.statistics._totalTime)

				ActivityLevelConst = var_14

				local var_28_8 = var_14.getShipsPower
				local var_28_9

				if not arg_28_0.contextData.prefabFleet then
					var_28_9 = arg_28_0.contextData.oldMainShips
				end

				local var_28_10 = var_28_8(var_28_9)

				ActivityLevelConst = var_15

				local var_28_11, var_28_12 = var_15.getExtraChapterSocre(var_28_6, var_28_7, var_28_10, iter_28_1)

				if var_28_12 < var_28_11 then
					i18n = var_28_13

					local var_28_13

					if not var_28_13("extra_chapter_record_updated") then
						i18n = var_28_13
						var_28_13 = var_28_13("extra_chapter_record_not_updated")
					end

					if var_28_12 < var_28_11 then
						iter_28_1.data1 = var_28_11

						var_1:updateActivity(iter_28_1)

						var_28_12 = var_28_11
					end

					pg = var_18

					local var_28_14 = var_18.MsgboxMgr.GetInstance()
					local var_28_15 = var_18.ShowMsgBox
					local var_28_16 = {
						hideNo = true
					}

					i18n = var_1_10022
					var_28_16.content = var_1_10022("extra_chapter_socre_tip", var_28_11, var_28_12, var_28_13)

					var_28_15(var_28_14, var_28_16)
				end
			end
		end
	end

	return
end

function var_0_1.listNotificationInterests(arg_29_0)
	local var_29_0 = {}

	GAME = var_1_10002
	var_29_0[1] = var_1_10002.BEGIN_STAGE_DONE
	GAME = var_2
	var_29_0[2] = var_2.ACT_BOSS_EXCHANGE_TICKET_DONE
	ContinuousOperationMediator = var_2
	var_29_0[3] = var_2.CONTINUE_OPERATION
	var_29_0[4] = var_0_1.SET_SKIP_FLAG
	GAME = var_2
	var_29_0[5] = var_2.BOSSRUSH_SETTLE_DONE
	ContinuousOperationMediator = var_2
	var_29_0[6] = var_2.ON_REENTER
	BossSingleContinuousOperationMediator = var_2
	var_29_0[7] = var_2.CONTINUE_OPERATION
	BossSingleContinuousOperationMediator = var_2
	var_29_0[8] = var_2.ON_REENTER

	return var_29_0
end

function var_0_1.handleNotification(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1
	local var_30_1 = arg_30_1.getName(var_30_0)
	local var_30_2 = arg_30_1:getBody()

	GAME = var_30_0

	local var_30_3

	if var_30_1 == var_30_0.BEGIN_STAGE_DONE then
		var_1_10006 = arg_30_0
		var_30_3 = arg_30_0.sendNotification
		GAME = var_1_10007

		local var_30_4 = var_1_10007.CHANGE_SCENE

		SCENE = var_1_10008

		var_30_3(var_1_10006, var_30_4, var_1_10008.COMBATLOAD, var_30_2)
	else
		GAME = var_30_3

		if var_30_1 == var_30_3.ACT_BOSS_EXCHANGE_TICKET_DONE then
			existCall = var_4

			var_4(arg_30_0.viewComponent.OnActBossExchangeTicket, arg_30_0.viewComponent)
		elseif var_30_1 == var_0_1.SET_SKIP_FLAG then
			var_1_10006 = arg_30_0.viewComponent

			var_4.SetSkipFlag(var_1_10006, var_30_2)
		else
			ContinuousOperationMediator = var_4

			local var_30_5

			if var_30_1 == var_4.CONTINUE_OPERATION then
				var_30_5 = arg_30_0.contextData
				var_30_5.continuousBattleTimes = arg_30_0.contextData.continuousBattleTimes - 1
			else
				GAME = var_30_5

				local var_30_6

				if var_30_1 == var_30_5.BOSSRUSH_SETTLE_DONE then
					var_30_6 = arg_30_0.contextData.system

					local var_30_7 = arg_30_0.contextData.actId

					var_1_10006 = var_30_2.seriesData

					local var_30_8 = arg_30_0.contextData.score

					ys = var_1_10008

					if not (var_1_10008.Battle.BattleConst.BattleScore.C < var_30_8) then
						SYSTEM_BOSS_RUSH_EX = var_8

						if var_30_6 == var_8 then
							var_1_10010 = arg_30_0.viewComponent

							local var_30_9 = var_8.emit

							BattleResultMediator = var_1_10011

							var_30_9(var_1_10010, var_1_10011.OPEN_FAIL_TIP_LAYER)

							return
						end
					end

					local var_30_10
					local var_30_11

					SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10010

					if var_30_6 == var_1_10010 then
						BossRushDALBattleResultMediator = var_30_10
						BossRushDALBattleResultLayer = var_30_11
					else
						SYSTEM_BOSS_RUSH_EX = var_1_10010

						if var_30_6 == var_1_10010 then
							BossRushBattleResultMediator = var_30_10
							BossRushConst = var_1_10010
							var_30_11 = var_1_10010.GetEXBattleResultLayer(var_30_7)
						else
							BossRushBattleResultMediator = var_30_10
							BossRushBattleResultLayer = var_30_11
						end
					end

					local var_30_12 = arg_30_0

					var_1_10010 = arg_30_0.addSubLayers
					Context = var_1_10013

					var_1_10010(var_30_12, var_1_10013.New({
						mediator = var_30_10,
						viewComponent = var_30_11,
						data = {
							awards = var_30_2.awards,
							system = arg_30_0.contextData.system,
							actId = var_30_7,
							seriesData = var_1_10006,
							win = var_7,
							OnClose = var_30_2.callback,
							isAutoFight = arg_30_0.contextData.isAutoFight
						}
					}), true)

					local var_30_13 = arg_30_0.viewComponent

					var_1_10010.closeView(var_30_13)
				else
					ContinuousOperationMediator = var_30_6

					if var_30_1 == var_30_6.ON_REENTER then
						if not var_30_2.autoFlag then
							var_1_10006 = arg_30_0

							arg_30_0.DisplayTotalReward(var_1_10006)

							return
						end

						getProxy = var_4
						ActivityProxy = var_1_10006

						local var_30_14 = var_4(var_1_10006)
						local var_30_15 = var_4.getActivityById(var_30_14, arg_30_0.contextData.actId)
						local var_30_16 = var_4.getConfig(var_30_15, "config_id")

						pg = var_30_14

						local var_30_17 = var_30_14.activity_event_worldboss[var_30_16].ticket

						getProxy = var_8
						PlayerProxy = var_1_10010

						local var_30_18 = var_8(var_1_10010)
						local var_30_19 = var_8.getRawData(var_30_18)
						local var_30_20 = var_8.getResource(var_30_19, var_30_17)

						if var_4:GetStageBonus(arg_30_0.contextData.stageId) == 0 then
							getProxy = var_30_19
							SettingsProxy = var_12

							local var_30_21 = var_30_19(var_12)

							if var_10.isTipActBossExchangeTicket(var_30_21) == 1 and var_30_20 > 0 then
								local var_30_22 = arg_30_0
								local var_30_23 = arg_30_0.sendNotification

								GAME = var_1_10014

								var_30_23(var_30_22, var_1_10014.ACT_BOSS_EXCHANGE_TICKET, {
									stageId = arg_30_0.contextData.stageId
								})

								return
							end
						end

						local var_30_24 = arg_30_0.viewComponent

						var_10.emit(var_30_24, var_0_1.REENTER_STAGE)
					else
						BossSingleContinuousOperationMediator = var_4

						local var_30_25

						if var_30_1 == var_4.CONTINUE_OPERATION then
							var_30_25 = arg_30_0.contextData
							var_30_25.continuousBattleTimes = arg_30_0.contextData.continuousBattleTimes - 1
						else
							BossSingleContinuousOperationMediator = var_30_25

							if var_30_1 == var_30_25.ON_REENTER then
								if not var_30_2.autoFlag then
									arg_30_0:DisplayBossSingleTotalReward()

									return
								end

								local var_30_26 = arg_30_0.viewComponent

								var_4.emit(var_30_26, var_0_1.REENTER_STAGE)
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.DisplayTotalReward(arg_31_0, arg_31_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_31_0 = var_1_10002(var_1_10004)
	local var_31_1 = var_2.getCurrentContext(var_31_0)
	local var_31_2 = var_2.getContextByMediator

	ContinuousOperationMediator = var_1_10005

	local var_31_3

	if not var_31_2(var_31_1, var_1_10005) or not var_2.data.autoFlag then
		var_31_3 = nil
	end

	getProxy = var_31_1
	ChapterProxy = var_1_10006

	local var_31_4 = var_31_1(var_1_10006)
	local var_31_5 = var_4.PopActBossRewards(var_31_4)

	LoadContextCommand = var_1_10005

	local var_31_6 = var_1_10005.LoadLayerOnTopContext

	Context = var_1_10007

	local var_31_7 = var_1_10007.New
	local var_31_8 = {}

	ActivityBossTotalRewardPanelMediator = var_1_10010
	var_31_8.mediator = var_1_10010
	ActivityBossTotalRewardPanel = var_1_10010
	var_31_8.viewComponent = var_1_10010
	var_31_8.data = {
		onClose = function()
			local var_32_0 = arg_31_0.viewComponent
			local var_32_1 = var_0.emit

			BaseUI = var_2_10003

			var_32_1(var_32_0, var_2_10003.ON_BACK)

			return
		end,
		stopReason = arg_31_1,
		rewards = var_31_5,
		isAutoFight = var_31_3,
		continuousBattleTimes = arg_31_0.contextData.continuousBattleTimes,
		totalBattleTimes = arg_31_0.contextData.totalBattleTimes
	}

	var_31_6(var_31_7(var_31_8))

	return
end

function var_0_1.DisplayBossSingleTotalReward(arg_33_0, arg_33_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_33_0 = var_1_10002(var_1_10004)
	local var_33_1 = var_2.getCurrentContext(var_33_0)
	local var_33_2 = var_2.getContextByMediator

	BossSingleContinuousOperationMediator = var_1_10005

	local var_33_3

	if not var_33_2(var_33_1, var_1_10005) or not var_2.data.autoFlag then
		var_33_3 = nil
	end

	getProxy = var_33_1
	ChapterProxy = var_1_10006

	local var_33_4 = var_33_1(var_1_10006)
	local var_33_5 = var_4.PopBossSingleRewards(var_33_4)

	LoadContextCommand = var_1_10005

	local var_33_6 = var_1_10005.LoadLayerOnTopContext

	Context = var_1_10007

	local var_33_7 = var_1_10007.New
	local var_33_8 = {}

	BossSingleTotalRewardPanelMediator = var_1_10010
	var_33_8.mediator = var_1_10010
	BossSingleTotalRewardPanel = var_1_10010
	var_33_8.viewComponent = var_1_10010
	var_33_8.data = {
		onConfirm = function()
			local var_34_0 = arg_33_0.viewComponent
			local var_34_1 = var_0.emit

			BaseUI = var_2_10003

			var_34_1(var_34_0, var_2_10003.ON_BACK)

			return
		end,
		onClose = function()
			getProxy = var_2_10000
			ContextProxy = var_2_10002

			local var_35_0 = var_2_10000(var_2_10002)
			local var_35_1 = var_0.getContextByMediator

			ClueMapMediator = var_2_10003

			if var_35_1(var_35_0, var_2_10003) then
				var_0.cleanChild = true
				warning = var_2_10001

				var_2_10001("ClueMapMediator")
			end

			getProxy = var_2_10001
			ContextProxy = var_2_10003

			local var_35_2 = var_2_10001(var_2_10003)
			local var_35_3 = var_1.getContextByMediator

			BossSinglePreCombatMediator = var_2_10004

			if var_35_3(var_35_2, var_2_10004) then
				var_0.skipBack = true
				warning = var_1

				var_1("BossSinglePreCombatMediator")
			end

			local var_35_4 = arg_33_0.viewComponent
			local var_35_5 = var_0.emit

			BaseUI = var_35_2

			var_35_5(var_35_4, var_35_2.ON_BACK)

			return
		end,
		stopReason = arg_33_1,
		rewards = var_33_5,
		isAutoFight = var_33_3,
		continuousBattleTimes = arg_33_0.contextData.continuousBattleTimes,
		totalBattleTimes = arg_33_0.contextData.totalBattleTimes
	}

	var_33_6(var_33_7(var_33_8))

	return
end

function var_0_1.GetResultView(arg_36_0)
	local var_36_0 = var_0_1
	local var_36_1

	if not var_0_1.RESULT_VIEW_TRANSFORM then
		var_36_1 = {}
		SYSTEM_CHALLENGE = var_1_10003
		BattleChallengeResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_DODGEM = var_1_10003
		BattleDodgemResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_SUBMARINE_RUN = var_1_10003
		BattleSubmarineRunResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_SUB_ROUTINE = var_1_10003
		BattleSubmarineRoutineResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_HP_SHARE_ACT_BOSS = var_1_10003
		BattleContributionResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_BOSS_EXPERIMENT = var_1_10003
		BattleExperimentResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_ACT_BOSS = var_1_10003
		BattleActivityBossResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_WORLD_BOSS = var_1_10003
		BattleWorldBossResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_REWARD_PERFORM = var_1_10003
		BattleRewardPerformResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_AIRFIGHT = var_1_10003
		BattleAirFightResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_GUILD = var_1_10003
		BattleGuildBossResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
		SYSTEM_CARDPUZZLE = var_1_10003
		BattleAirFightResultLayer = var_1_10004
		var_36_1[var_1_10003] = var_1_10004
	end

	var_36_0.RESULT_VIEW_TRANSFORM = var_36_1

	if not var_0_1.RESULT_VIEW_TRANSFORM[arg_36_0] then
		BattleResultLayer = var_1
	end

	return var_1
end

return var_0_1
