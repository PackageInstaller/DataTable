class = var_0_10000

local var_0_0 = "BattleResultMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

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
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getData(var_1_0)

	getProxy = var_1_0
	FleetProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_1_3 = var_1_10004(var_1_10005)

	getProxy = var_1_10005
	ChapterProxy = var_1_10006

	local var_1_4 = var_1_10005(var_1_10006)

	getProxy = var_1_10006
	ActivityProxy = var_1_10007

	local var_1_5 = var_1_10006(var_1_10007)
	local var_1_6 = arg_1_0.contextData.system

	SYSTEM_DUEL = var_1_10008

	if var_1_6 == var_1_10008 then
		getProxy = var_1_10008
		MilitaryExerciseProxy = var_1_10009
		var_1_10010 = var_1_10008(var_1_10009)
		var_1_10009 = var_1_10008.getPreRivalById(var_1_10010, arg_1_0.contextData.rivalId)
		assert = var_1_10010

		var_1_10010(var_1_10009, "should exist rival--" .. arg_1_0.contextData.rivalId)

		var_1_10011 = arg_1_0.viewComponent

		var_1_10010.setRivalVO(var_1_10011, var_1_10009)

		var_1_10011 = arg_1_0.viewComponent
		var_1_10010 = var_1_10010.setRank
		var_1_10012 = var_1_1
		var_1_10014 = var_1_10008

		var_1_10010(var_1_10011, var_1_10012, var_1_10008.getSeasonInfo(var_1_10014))

		goto label_1_0
	end

	SYSTEM_CHALLENGE = var_1_10008

	if var_1_6 == var_1_10008 then
		getProxy = var_1_10008
		ChallengeProxy = var_1_10009
		var_1_10010 = var_1_10008(var_1_10009)
		var_1_10009 = var_1_10008.getUserChallengeInfo(var_1_10010, arg_1_0.contextData.mode)
		var_1_10011 = arg_1_0.viewComponent
		var_1_10010 = var_1_10010.setChallengeInfo
		var_1_10012 = var_1_10009
		var_1_10014 = var_1_10008

		var_1_10010(var_1_10011, var_1_10012, var_1_10008.userSeaonExpire(var_1_10014, arg_1_0.contextData.mode))

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

									BuffHelper = var_1_10009
									var_1_10009 = var_1_10009.GetBuffsByActivityType
									ActivityConst = var_1_10010

									local var_1_8 = var_1_7(var_1_10009(var_1_10010.ACTIVITY_TYPE_BUFF), function(arg_2_0)
										return arg_2_0:getConfig("benefit_type") == "rookie_battle_exp"
									end)

									var_1_10010 = var_1_5
									var_1_10009 = var_1_5.getBuffShipList(var_1_10010)
									var_1_10011 = arg_1_0.viewComponent

									var_1_10010.setExpBuff(var_1_10011, var_1_8, var_1_10009)
								end

								var_1_10009 = arg_1_0.viewComponent

								var_8.setPlayer(var_1_10009, var_1_1)

								::label_1_0::

								local var_1_9

								SYSTEM_SCENARIO = var_1_10009

								if var_1_6 == var_1_10009 then
									var_1_9 = {}
									var_1_10009 = nil
									SYSTEM_SCENARIO = var_1_10010

									if var_1_6 == var_1_10010 then
										var_1_10011 = var_1_4
										var_1_10009 = var_1_4.getActiveChapter(var_1_10011)
									end

									var_1_10010 = var_1_10009.fleet
									TeamType = var_1_10011
									var_1_10011 = var_1_10010[var_1_10011.Main]
									TeamType = var_1_10012

									local var_1_10 = var_1_10010[var_1_10012.Vanguard]

									ipairs = var_1_10013

									for iter_1_0, iter_1_1 in var_1_10013(var_1_10011) do
										table = iter_1_13

										iter_1_13.insert(var_1_9, iter_1_1)
									end

									ipairs = var_13

									for iter_1_2, iter_1_3 in var_13(var_1_10) do
										table = iter_1_13

										iter_1_13.insert(var_1_9, iter_1_3)
									end

									_ = var_13

									if var_13.detect(var_1_10009.fleets, function(arg_3_0)
										local var_3_0 = arg_3_0
										local var_3_1 = arg_3_0.getFleetType(var_3_0)

										FleetType = var_3_0

										return var_3_1 == var_3_0.Submarine
									end) then
										var_1_10015 = var_13
										var_1_10014 = var_13.getShipsByTeam
										TeamType = iter_1_2
										var_1_10014 = var_1_10014(var_1_10015, iter_1_2.Submarine, true)
										ipairs = var_1_10015

										for iter_1_13, iter_1_10 in var_1_10015(var_1_10014) do
											table = var_1_10020

											var_1_10020.insert(var_1_9, iter_1_10)
										end
									end

									var_1_10015 = arg_1_0.viewComponent

									var_1_10014.SetSkipFlag(var_1_10015, var_1_4:GetChapterAutoFlag(var_1_10009.id) == 1)

									goto label_1_1
								end

								SYSTEM_WORLD = var_1_10009

								if var_1_6 == var_1_10009 then
									var_1_9 = {}
									nowWorld = var_1_10009
									var_1_10011 = var_1_10009()

									local var_1_11 = var_1_10009.GetActiveMap(var_1_10011)
									local var_1_12 = var_1_10010.GetFleet(var_1_11)
									local var_1_13 = var_1_10011.GetTeamShipVOs

									TeamType = var_1_10014

									local var_1_14 = var_1_13(var_1_12, var_1_10014.Main, true)
									local var_1_15 = var_1_10011
									local var_1_16 = var_1_10011.GetTeamShipVOs

									TeamType = var_1_10015

									local var_1_17 = var_1_16(var_1_15, var_1_10015.Vanguard, true)

									ipairs = var_1_15

									for iter_1_6, iter_1_13 in var_1_15(var_1_14) do
										table = iter_1_10

										iter_1_10.insert(var_1_9, iter_1_13)
									end

									ipairs = var_14

									for iter_1_8, iter_1_13 in var_14(var_1_17) do
										table = iter_1_10

										iter_1_10.insert(var_1_9, iter_1_13)
									end

									var_1_10015 = var_1_10010

									if var_1_10010.GetSubmarineFleet(var_1_10015) then
										local var_1_18 = var_14

										var_1_10015 = var_14.GetTeamShipVOs
										TeamType = iter_1_8
										var_1_10015 = var_1_10015(var_1_18, iter_1_8.Submarine, true)
										ipairs = var_1_18

										for iter_1_10, iter_1_11 in var_1_18(var_1_10015) do
											table = var_1_10021

											var_1_10021.insert(var_1_9, iter_1_11)
										end
									end

									local var_1_19 = arg_1_0.viewComponent

									var_1_10015.SetSkipFlag(var_1_19, var_1_10009.isAutoFight)

									goto label_1_1
								end

								SYSTEM_CHALLENGE = var_1_10009

								if var_1_6 == var_1_10009 then
									var_1_10010 = arg_1_0

									arg_1_0.bind(var_1_10010, var_0_1.ON_CHALLENGE_SHARE, function(arg_4_0)
										local var_4_0 = arg_1_0
										local var_4_1 = var_1.addSubLayers

										Context = var_2_10003

										local var_4_2 = var_2_10003.New
										local var_4_3 = {}

										ChallengeShareMediator = var_2_10005
										var_4_3.mediator = var_2_10005
										ChallengeShareLayer = var_2_10005
										var_4_3.viewComponent = var_2_10005
										var_4_3.data = {
											mode = arg_1_0.contextData.mode
										}

										var_4_1(var_4_0, var_4_2(var_4_3))

										return
									end)

									var_1_10010 = arg_1_0

									arg_1_0.bind(var_1_10010, var_0_1.ON_CHALLENGE_DEFEAT_SCENE, function(arg_5_0, arg_5_1)
										local var_5_0 = arg_5_1.callback
										local var_5_1 = arg_1_0
										local var_5_2 = var_3.addSubLayers

										Context = var_2_10005

										local var_5_3 = var_2_10005.New
										local var_5_4 = {}

										ChallengePassedMediator = var_2_10007
										var_5_4.mediator = var_2_10007
										ChallengePassedLayer = var_2_10007
										var_5_4.viewComponent = var_2_10007
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
									var_1_10011 = var_1_10009()

									local var_1_20 = var_1_10009.GetBossProxy(var_1_10011)

									var_1_10011 = var_1_10010.GetFleet(var_1_20, arg_1_0.contextData.bossId)
									getProxy = var_1_20
									BayProxy = var_13

									local var_1_21 = var_1_20(var_13)

									var_1_9 = var_12.getShipsByFleet(var_1_21, var_1_10011)

									local var_1_22 = arg_1_0.contextData.name

									var_1_10015 = arg_1_0.viewComponent

									var_14.setTitle(var_1_10015, var_1_22)

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
														var_1_10011 = arg_1_0.viewComponent

														var_1_10010.setActId(var_1_10011, var_1_10009)
													end

													var_1_10011 = var_1_2
													var_1_10011 = var_1_2.getActivityFleets(var_1_10011)[var_1_10009][arg_1_0.contextData.mainFleetId]
													var_1_9 = var_1_3:getShipsByFleet(var_1_10011)

													local var_1_23 = var_1_10010[arg_1_0.contextData.mainFleetId + 10]
													local var_1_24 = var_1_3
													local var_1_25 = var_1_3.getShipsByFleet(var_1_24, var_1_23)

													ipairs = var_1_24

													for iter_1_12, iter_1_13 in var_1_24(var_1_25) do
														table = iter_1_10

														iter_1_10.insert(var_1_9, iter_1_13)
													end

													goto label_1_1
												end

												SYSTEM_GUILD = var_1_10009

												if var_1_6 == var_1_10009 then
													var_1_9 = {}
													getProxy = var_1_10009
													GuildProxy = var_1_10010
													var_1_10010 = var_1_10009(var_1_10010)
													var_1_10011 = var_1_10009.getData(var_1_10010)

													local var_1_26 = var_1_10009.GetActiveEvent(var_1_10011)
													local var_1_27 = var_1_10010.GetBossMission(var_1_26)
													local var_1_28 = var_1_10011.GetMainFleet(var_1_27)

													ipairs = var_1_27
													var_1_10015 = var_1_28

													for iter_1_14, iter_1_15 in var_1_27(var_1_28.GetShips(var_1_10015)) do
														table = iter_1_13

														iter_1_13.insert(var_1_9, iter_1_15.ship)
													end

													local var_1_29 = var_1_10011
													local var_1_30 = var_1_10011.GetSubFleet(var_1_29)

													ipairs = var_1_29

													for iter_1_16, iter_1_17 in var_1_29(var_1_30:GetShips()) do
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
															local var_1_31 = arg_1_0.contextData.actId

															getProxy = var_1_10010
															ActivityProxy = var_1_10011

															local var_1_32 = var_1_10010(var_1_10011)
															local var_1_33 = var_10.getActivityById(var_1_32, var_1_31)
															local var_1_34 = var_10.GetSeriesData(var_1_33)

															assert = var_1_33

															var_1_33(var_1_34)

															local var_1_35 = var_1_34:GetStaegLevel()
															local var_1_36 = var_1_34:GetStageFleets(var_1_34:GetMode(), var_1_35)

															var_1_10015 = var_1_2
															var_1_10015 = var_1_2.getActivityFleets(var_1_10015)[var_1_31][var_1_36]
															var_1_9 = var_1_3:getShipsByFleet(var_1_10015)
														else
															local var_1_37 = arg_1_0.contextData.mainFleetId
															local var_1_38 = var_1_2:getFleetById(var_1_37)

															var_1_9 = var_1_3:getShipsByFleet(var_1_38)
														end

														::label_1_1::

														local var_1_39 = arg_1_0.viewComponent

														var_9.setShips(var_1_39, var_1_9)
														arg_1_0:bind(var_0_1.ON_BACK_TO_LEVEL_SCENE, function(arg_6_0, arg_6_1)
															getProxy = var_2_10002
															ContextProxy = var_2_10003

															local var_6_0 = var_2_10002(var_2_10003)
															local var_6_1 = var_1_6

															SYSTEM_DUEL = var_2_10004

															if var_6_1 == var_2_10004 then
																var_2_10004 = arg_1_0.viewComponent

																local var_6_2 = var_3.emit

																BattleResultMediator = var_2_10005

																var_6_2(var_2_10004, var_2_10005.ON_BACK_TO_DUEL_SCENE)

																do return end

																goto label_6_3
															end

															local var_6_3 = var_1_6

															SYSTEM_ACT_BOSS = var_2_10004

															if var_6_3 == var_2_10004 then
																var_2_10004 = var_6_0

																local var_6_4 = var_6_0.getContextByMediator

																PreCombatMediator = var_2_10005

																local var_6_5

																var_6_5, var_2_10004 = var_6_4(var_2_10004, var_2_10005)

																if var_6_5 then
																	var_2_10006 = var_2_10004

																	var_2_10004.removeChild(var_2_10006, var_6_5)
																end

																var_2_10006 = var_6_0
																var_2_10006 = var_6_0.getCurrentContext(var_2_10006)
																var_2_10005 = var_2_10005.getContextByMediator
																ContinuousOperationMediator = var_2_10007

																if var_2_10005(var_2_10006, var_2_10007) then
																	var_2_10006 = arg_1_0
																	var_2_10005 = var_2_10005.sendNotification
																	ContinuousOperationMediator = var_2_10007

																	var_2_10005(var_2_10006, var_2_10007.CONTINUE_OPERATION)

																	existCall = var_2_10005

																	var_2_10005(arg_1_0.viewComponent.HideConfirmPanel, arg_1_0.viewComponent)

																	getProxy = var_2_10005
																	ActivityProxy = var_2_10006
																	var_2_10006 = var_2_10005(var_2_10006)
																	var_2_10007 = var_2_10005.getActivityById(var_2_10006, arg_1_0.contextData.actId)
																	var_2_10006 = var_2_10005.getConfig(var_2_10007, "config_id")
																	pg = var_2_10007
																	var_2_10007 = var_2_10007.activity_event_worldboss[var_2_10006]

																	local var_6_6 = var_2_10005

																	var_2_10008 = var_2_10005.IsOilLimit(var_6_6, arg_1_0.contextData.stageId)
																	getProxy = var_6_6
																	FleetProxy = var_10

																	local var_6_7 = var_6_6(var_10)
																	local var_6_8 = var_9.getActivityFleets(var_6_7)[arg_1_0.contextData.actId]

																	var_2_10011 = 0

																	local var_6_9 = var_2_10007.use_oil_limit[arg_1_0.contextData.mainFleetId]

																	function var_2_10014(arg_7_0, arg_7_1)
																		local var_7_0 = arg_7_0:GetCostSum().oil

																		if 0 < arg_7_1 then
																			math = var_3
																			var_7_0 = var_3.min(var_7_0, arg_7_1)
																		end

																		var_2_10011 = var_2_10011 + var_7_0

																		return
																	end

																	var_2_10015 = var_6_8[arg_1_0.contextData.mainFleetId]

																	if not var_2_10008 or not var_6_9[1] then
																		var_2_10016 = 0
																	end

																	var_2_10014(var_2_10015, var_2_10016)

																	var_2_10014 = var_2_10013
																	var_2_10015 = var_6_8[arg_1_0.contextData.mainFleetId + 10]

																	if not var_2_10008 or not var_6_9[2] then
																		var_2_10016 = 0
																	end

																	var_2_10014(var_2_10015, var_2_10016)

																	getProxy = var_2_10014
																	PlayerProxy = var_2_10015
																	var_2_10015 = var_2_10014(var_2_10015)

																	if var_2_10014.getRawData(var_2_10015).oil < var_2_10011 then
																		i18n = var_2_10015
																		var_2_10015 = var_2_10015("multiple_sorties_stop_reason1")
																		var_2_10017 = arg_1_0

																		var_2_10016.DisplayTotalReward(var_2_10017, var_2_10015)

																		return
																	end

																	getProxy = var_2_10015
																	BayProxy = var_2_10016
																	var_2_10016 = var_2_10015(var_2_10016)
																	var_2_10015 = var_2_10015.getShipCount(var_2_10016)
																	getProxy = var_2_10016
																	PlayerProxy = var_2_10017

																	local var_6_10 = var_2_10016(var_2_10017)
																	local var_6_11 = var_2_10016.getRawData(var_6_10)

																	if var_2_10016.getMaxShipBag(var_6_11) <= var_2_10015 then
																		i18n = var_2_10016
																		var_2_10016 = var_2_10016("multiple_sorties_stop_reason3")
																		var_2_10018 = arg_1_0

																		var_6_11.DisplayTotalReward(var_2_10018, var_2_10016)

																		return
																	end

																	var_2_10016 = var_6_8[arg_1_0.contextData.mainFleetId]
																	_ = var_6_11

																	local var_6_12 = var_6_11.map

																	_ = var_2_10018
																	var_2_10018 = #var_6_12(var_2_10018.values(var_2_10016.ships), function(arg_8_0)
																		getProxy = var_3_10001
																		BayProxy = var_3_10002

																		local var_8_0 = var_3_10001(var_3_10002)

																		if var_1.getShipById(var_8_0, arg_8_0) then
																			local var_8_1 = var_1.energy

																			Ship = var_3

																			if var_8_1 == var_3.ENERGY_LOW then
																				return var_1
																			end
																		end

																		return
																	end)

																	if 0 < var_2_10018 then
																		Fleet = var_2_10018
																		var_2_10018 = var_2_10018.DEFAULT_NAME_BOSS_ACT[arg_1_0.contextData.mainFleetId]
																		_ = var_2_10019
																		var_2_10019 = var_2_10019.map(var_17, function(arg_9_0)
																			return "「" .. arg_9_0:getConfig("name") .. "」"
																		end)
																		i18n = var_2_10020
																		var_2_10021 = "multiple_sorties_stop_reason2"
																		var_2_10022 = var_2_10018
																		table = var_2_10023
																		var_2_10020 = var_2_10020(var_2_10021, var_2_10022, var_2_10023.concat(var_2_10019, ""))
																		var_2_10022 = arg_1_0

																		var_2_10021.DisplayTotalReward(var_2_10022, var_2_10020)

																		return
																	end

																	var_2_10018 = arg_1_0.contextData.statistics._battleScore
																	ys = var_2_10019

																	if var_2_10018 <= var_2_10019.Battle.BattleConst.BattleScore.C then
																		i18n = var_2_10018
																		var_2_10018 = var_2_10018("multiple_sorties_stop_reason4")
																		var_2_10020 = arg_1_0

																		var_2_10019.DisplayTotalReward(var_2_10020, var_2_10018)

																		return
																	end

																	pg = var_2_10018
																	var_2_10020 = var_2_10018.GuildMsgBoxMgr.GetInstance()

																	if var_2_10018.GetShouldShowBattleTip(var_2_10020) then
																		getProxy = var_2_10019
																		GuildProxy = var_2_10020
																		var_2_10020 = var_2_10019(var_2_10020)

																		if var_2_10019.getRawData(var_2_10020) then
																			::label_6_0::

																			var_2_10021 = var_2_10019
																			var_2_10020 = var_2_10019.getWeeklyTask(var_2_10021)
																		end

																		if var_2_10020 and var_2_10020.id ~= 0 then
																			var_2_10022 = var_2_10018

																			var_2_10018.SubmitTask(var_2_10022, function(arg_10_0, arg_10_1)
																				if arg_10_1 then
																					local var_10_0 = var_2_10018

																					var_2.CancelShouldShowBattleTip(var_10_0)
																				end

																				return
																			end)
																		end
																	end

																	var_2_10020 = var_6_0
																	var_2_10020 = var_6_0.getCurrentContext(var_2_10020)
																	var_2_10019 = var_2_10019.getContextByMediator
																	ContinuousOperationMediator = var_2_10021

																	if var_2_10019(var_2_10020, var_2_10021) and not var_2_10019.data.autoFlag then
																		local var_6_13 = arg_1_0

																		var_2_10020.DisplayTotalReward(var_6_13)

																		return
																	end

																	if arg_1_0.contextData.continuousBattleTimes < 1 then
																		local var_6_14 = arg_1_0

																		var_2_10020.DisplayTotalReward(var_6_14)

																		return
																	end

																	local var_6_15 = arg_1_0

																	var_2_10020 = var_2_10020.sendNotification
																	BattleResultMediator = var_2_10022

																	var_2_10020(var_6_15, var_2_10022.ON_COMPLETE_BATTLE_RESULT)

																	return
																end

																goto label_6_3
															end

															local var_6_16 = var_1_6

															SYSTEM_ROUTINE = var_2_10004

															if var_6_16 ~= var_2_10004 then
																local var_6_17 = var_1_6

																SYSTEM_SUB_ROUTINE = var_2_10004

																if var_6_17 == var_2_10004 then
																	var_2_10004 = var_6_0

																	local var_6_18 = var_6_0.getContextByMediator

																	DailyLevelMediator = var_2_10005

																	if var_6_18(var_2_10004, var_2_10005) then
																		var_2_10005 = var_3
																		var_2_10004 = var_3.getContextByMediator
																		PreCombatMediator = var_2_10006
																		var_2_10004 = var_2_10004(var_2_10005, var_2_10006)
																		var_2_10006 = var_3

																		var_3.removeChild(var_2_10006, var_2_10004)
																	end

																	goto label_6_3
																end

																local var_6_19 = var_1_6

																SYSTEM_SCENARIO = var_2_10004

																if var_6_19 == var_2_10004 then
																	var_2_10004 = var_6_0

																	local var_6_20 = var_6_0.getContextByMediator

																	LevelMediator2 = var_2_10005
																	var_2_10005 = var_6_20(var_2_10004, var_2_10005)
																	var_2_10004 = var_3.getContextByMediator
																	ChapterPreCombatMediator = var_2_10006

																	if var_2_10004(var_2_10005, var_2_10006) then
																		var_2_10006 = var_3

																		var_3.removeChild(var_2_10006, var_2_10004)
																	end

																	var_2_10005 = arg_1_0.contextData.score

																	if 1 < var_2_10005 then
																		var_2_10006 = arg_1_0

																		var_2_10005.showExtraChapterActSocre(var_2_10006)
																	end

																	getProxy = var_2_10005
																	ChapterProxy = var_2_10006
																	var_2_10007 = var_2_10005(var_2_10006)

																	if var_2_10005.getActiveChapter(var_2_10007) then
																		var_2_10008 = var_2_10006

																		if var_2_10006.existOni(var_2_10008) then
																			var_2_10008 = var_2_10006

																			var_2_10006.clearSubmarineFleet(var_2_10008)

																			var_2_10008 = var_2_10005

																			var_2_10005.updateChapter(var_2_10008, var_2_10006)
																		else
																			var_2_10008 = var_2_10006

																			if var_2_10006.isPlayingWithBombEnemy(var_2_10008) then
																				var_2_10006.fleets = {
																					var_2_10006.fleet
																				}
																				var_2_10006.findex = 1
																				var_2_10008 = var_2_10005

																				var_2_10005.updateChapter(var_2_10008, var_2_10006)
																			end
																		end
																	end

																	goto label_6_3
																end

																local var_6_21 = var_1_6

																SYSTEM_CHALLENGE = var_2_10004

																if var_6_21 == var_2_10004 then
																	getProxy = var_6_21
																	ChallengeProxy = var_2_10004

																	local var_6_22 = var_6_21(var_2_10004)

																	var_2_10004 = arg_1_0.contextData.mode
																	var_2_10006 = var_6_22
																	var_2_10005 = var_6_22.getUserChallengeInfo(var_2_10006, var_2_10004)
																	var_2_10006 = arg_1_0.contextData.score
																	ys = var_2_10007

																	if var_2_10006 < var_2_10007.Battle.BattleConst.BattleScore.S then
																		var_2_10007 = arg_1_0
																		var_2_10006 = var_2_10006.sendNotification
																		GAME = var_2_10008

																		var_2_10006(var_2_10007, var_2_10008.CHALLENGE2_RESET, {
																			mode = var_2_10004
																		})
																	else
																		var_2_10007 = var_2_10005
																		var_2_10006 = var_2_10005.IsFinish(var_2_10007)

																		var_2_10005:updateLevelForward()

																		local var_6_23 = var_2_10005

																		var_2_10007 = var_2_10005.getMode(var_6_23)
																		ChallengeProxy = var_6_23

																		if var_2_10007 == var_6_23.MODE_INFINITE and var_2_10006 then
																			var_2_10005:setInfiniteDungeonIDListByLevel()
																		end
																	end

																	var_2_10007 = var_6_22
																	var_2_10006 = var_6_22.getChallengeInfo(var_2_10007)

																	local var_6_24 = var_6_22

																	var_2_10007 = var_6_22.userSeaonExpire

																	local var_6_25 = var_2_10005

																	if not var_2_10007(var_6_24, var_2_10005.getMode(var_6_25)) then
																		var_2_10006:checkRecord(var_2_10005)
																	end

																	if not arg_6_1.goToNext then
																		local var_6_26 = var_6_0

																		var_2_10007 = var_6_0.getContextByMediator
																		ChallengeMainMediator = var_9

																		if var_2_10007(var_6_26, var_9) then
																			local var_6_27 = var_2_10007
																			local var_6_28 = var_2_10007.getContextByMediator

																			ChallengePreCombatMediator = var_6_25

																			local var_6_29 = var_6_28(var_6_27, var_6_25)

																			var_2_10007:removeChild(var_6_29)
																		end
																	end

																	goto label_6_3
																end

																local var_6_30 = var_1_6

																SYSTEM_HP_SHARE_ACT_BOSS = var_2_10004

																if var_6_30 == var_2_10004 then
																	var_2_10004 = var_6_0

																	local var_6_31 = var_6_0.getContextByMediator

																	PreCombatMediator = var_2_10005

																	local var_6_32

																	var_6_32, var_2_10004 = var_6_31(var_2_10004, var_2_10005)

																	if var_6_32 then
																		var_2_10006 = var_2_10004

																		var_2_10004.removeChild(var_2_10006, var_6_32)
																	end

																	goto label_6_3
																end

																local var_6_33 = var_1_6

																SYSTEM_WORLD_BOSS = var_2_10004

																if var_6_33 == var_2_10004 then
																	var_2_10004 = var_6_0

																	local var_6_34 = var_6_0.getContextByMediator

																	WorldBossMediator = var_2_10005
																	var_2_10005 = var_6_34(var_2_10004, var_2_10005)
																	var_2_10004 = var_3.getContextByMediator
																	WorldBossFormationMediator = var_2_10006

																	if var_2_10004(var_2_10005, var_2_10006) then
																		var_2_10006 = var_3

																		var_3.removeChild(var_2_10006, var_2_10004)
																	end

																	goto label_6_3
																end

																local var_6_35 = var_1_6

																SYSTEM_WORLD = var_2_10004

																if var_6_35 == var_2_10004 then
																	var_2_10004 = var_6_0

																	local var_6_36 = var_6_0.getContextByMediator

																	WorldMediator = var_2_10005
																	var_2_10005 = var_6_36(var_2_10004, var_2_10005)
																	var_2_10004 = var_3.getContextByMediator
																	WorldPreCombatMediator = var_2_10006

																	if not var_2_10004(var_2_10005, var_2_10006) then
																		var_2_10005 = var_3
																		var_2_10004 = var_3.getContextByMediator
																		WorldBossInformationMediator = var_2_10006
																		var_2_10004 = var_2_10004(var_2_10005, var_2_10006)
																	end

																	if var_2_10004 then
																		var_2_10006 = var_3

																		var_3.removeChild(var_2_10006, var_2_10004)
																	end

																	goto label_6_3
																end

																local var_6_37 = var_1_6

																SYSTEM_BOSS_RUSH = var_2_10004

																if var_6_37 ~= var_2_10004 then
																	local var_6_38 = var_1_6

																	SYSTEM_BOSS_RUSH_EX = var_2_10004

																	if var_6_38 ~= var_2_10004 then
																		local var_6_39 = var_1_6

																		SYSTEM_BOSS_RUSH_COLLABRATE = var_2_10004

																		if var_6_39 == var_2_10004 then
																			local var_6_40 = arg_1_0.contextData.score

																			ys = var_2_10004

																			local var_6_41 = var_2_10004.Battle.BattleConst.BattleScore.C < var_6_40

																			var_2_10004 = arg_1_0.contextData.actId
																			getProxy = var_2_10005
																			ActivityProxy = var_2_10006
																			var_2_10006 = var_2_10005(var_2_10006)
																			var_2_10007 = var_2_10005.getActivityById(var_2_10006, var_2_10004)
																			var_2_10006 = var_2_10005.GetSeriesData(var_2_10007)
																			assert = var_2_10007

																			var_2_10007(var_2_10006)

																			var_2_10007 = var_2_10006:GetStaegLevel() + 1

																			local var_6_42 = var_2_10006:GetExpeditionIds()
																			local var_6_43 = var_6_0:getCurrentContext()
																			local var_6_44 = var_9.getContextByMediator

																			ContinuousOperationMediator = var_2_10011

																			local var_6_45 = not var_6_44(var_6_43, var_2_10011) or var_9.data.autoFlag

																			arg_1_0.contextData.isAutoFight = var_6_45

																			local var_6_46 = var_6_0:getCurrentContext()
																			local var_6_47 = var_11.getContextByMediator

																			ContinuousOperationMediator = var_2_10013

																			if var_6_47(var_6_46, var_2_10013) then
																				pg = var_11

																				local var_6_48 = var_11.GuildMsgBoxMgr.GetInstance()

																				if var_11.GetShouldShowBattleTip(var_6_48) then
																					getProxy = var_12
																					GuildProxy = var_6_48

																					local var_6_49 = var_12(var_6_48)
																					local var_6_50

																					if var_12.getRawData(var_6_49) then
																						::label_6_1::

																						var_2_10014 = var_12
																						var_6_50 = var_12.getWeeklyTask(var_2_10014)
																					end

																					if var_6_50 and var_6_50.id ~= 0 then
																						var_2_10015 = var_11

																						var_11.SubmitTask(var_2_10015, function(arg_11_0, arg_11_1)
																							if arg_11_1 then
																								local var_11_0 = var_0

																								var_2.CancelShouldShowBattleTip(var_11_0)
																							end

																							return
																						end)
																					end
																				end
																			end

																			if not var_6_41 or #var_6_42 < var_2_10007 or not var_6_45 then
																				local var_6_51 = var_6_0:GetPrevContext(1)
																				local var_6_52 = var_11.getContextByMediator

																				BossRushPreCombatMediator = var_2_10014

																				if var_6_52(var_6_51, var_2_10014) then
																					var_2_10014 = var_11

																					var_11.removeChild(var_2_10014, var_12)
																				end

																				var_2_10014 = var_11

																				local var_6_53 = var_11.getContextByMediator

																				BossRushFleetSelectMediator = var_2_10015

																				if var_6_53(var_2_10014, var_2_10015) then
																					var_2_10015 = var_11

																					var_11.removeChild(var_2_10015, var_13)
																				end

																				var_2_10015 = arg_1_0
																				var_2_10014 = var_2_10014.sendNotification
																				GAME = var_2_10016

																				var_2_10014(var_2_10015, var_2_10016.BOSSRUSH_SETTLE, {
																					actId = arg_1_0.contextData.actId
																				})
																			else
																				seriesAsync = var_11

																				var_11({
																					function(arg_12_0)
																						local var_12_0 = arg_1_0
																						local var_12_1 = var_1.addSubLayers

																						Context = var_3_10003

																						local var_12_2 = var_3_10003.New
																						local var_12_3 = {}

																						ChallengePassedMediator = var_3_10005
																						var_12_3.mediator = var_3_10005
																						BossRushPassedLayer = var_3_10005
																						var_12_3.viewComponent = var_3_10005
																						var_12_3.data = {
																							curIndex = var_2_10007 - 1,
																							maxIndex = #var_6_42
																						}
																						var_12_3.onRemoved = arg_12_0

																						var_12_1(var_12_0, var_12_2(var_12_3))

																						return
																					end,
																					function(arg_13_0)
																						local var_13_0 = arg_1_0
																						local var_13_1 = var_1.sendNotification

																						GAME = var_3_10003

																						var_13_1(var_13_0, var_3_10003.BEGIN_STAGE, {
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

																		local var_6_54 = var_1_6

																		SYSTEM_CARDPUZZLE = var_2_10004

																		if var_6_54 == var_2_10004 then
																			goto label_6_3
																		end

																		local var_6_55 = var_1_6

																		SYSTEM_BOSS_SINGLE = var_2_10004

																		if var_6_55 ~= var_2_10004 then
																			do
																				local var_6_56 = var_1_6

																				SYSTEM_BOSS_SINGLE_VARIABLE = var_2_10004

																				if var_6_56 == var_2_10004 then
																					local var_6_57 = var_6_0
																					local var_6_58 = var_6_0.getContextByMediator

																					PreCombatMediator = var_2_10005

																					local var_6_59, var_6_60 = var_6_58(var_6_57, var_2_10005)

																					if var_6_59 then
																						var_2_10006 = var_6_60

																						var_6_60.removeChild(var_2_10006, var_6_59)
																					end

																					var_2_10006 = var_6_0
																					var_2_10006 = var_6_0.getCurrentContext(var_2_10006)
																					var_2_10005 = var_2_10005.getContextByMediator
																					BossSingleContinuousOperationMediator = var_2_10007

																					if var_2_10005(var_2_10006, var_2_10007) then
																						var_2_10006 = arg_1_0
																						var_2_10005 = var_2_10005.sendNotification
																						BossSingleContinuousOperationMediator = var_2_10007

																						var_2_10005(var_2_10006, var_2_10007.CONTINUE_OPERATION)

																						existCall = var_2_10005

																						var_2_10005(arg_1_0.viewComponent.HideConfirmPanel, arg_1_0.viewComponent)

																						getProxy = var_2_10005
																						ActivityProxy = var_2_10006
																						var_2_10006 = var_2_10005(var_2_10006)
																						var_2_10005 = var_2_10005.getActivityById(var_2_10006, arg_1_0.contextData.actId)
																						getProxy = var_2_10006
																						FleetProxy = var_7

																						local var_6_61 = var_2_10006(var_7)
																						local var_6_62 = var_2_10006.getActivityFleets(var_6_61)[arg_1_0.contextData.actId]
																						local var_6_63 = 0
																						local var_6_64 = var_2_10005:GetOilLimits()[arg_1_0.contextData.mainFleetId]

																						local function var_6_65(arg_14_0, arg_14_1)
																							local var_14_0 = arg_14_0:GetCostSum().oil

																							if 0 < arg_14_1 then
																								math = var_3
																								var_14_0 = var_3.min(var_14_0, arg_14_1)
																							end

																							var_6_63 = var_6_63 + var_14_0

																							return
																						end

																						local var_6_66 = var_6_62[arg_1_0.contextData.mainFleetId]
																						local var_6_67

																						if not var_6_64[1] then
																							var_6_67 = 0
																						end

																						var_6_65(var_6_66, var_6_67)

																						local var_6_68 = var_10
																						local var_6_69 = var_6_62[arg_1_0.contextData.mainFleetId + 10]
																						local var_6_70

																						if not var_6_64[2] then
																							var_6_70 = 0
																						end

																						var_6_68(var_6_69, var_6_70)

																						getProxy = var_6_68
																						PlayerProxy = var_6_69

																						local var_6_71 = var_6_68(var_6_69)

																						if var_6_63 > var_11.getRawData(var_6_71).oil then
																							i18n = var_6_71
																							var_6_71 = var_6_71("multiple_sorties_stop_reason1")
																							var_2_10014 = arg_1_0

																							var_6_70.DisplayBossSingleTotalReward(var_2_10014, var_6_71)

																							return
																						end

																						getProxy = var_6_71
																						BayProxy = var_6_70

																						local var_6_72 = var_6_71(var_6_70)
																						local var_6_73 = var_12.getShipCount(var_6_72)

																						getProxy = var_6_72
																						PlayerProxy = var_2_10014

																						local var_6_74 = var_6_72(var_2_10014)
																						local var_6_75 = var_13.getRawData(var_6_74)

																						if var_13.getMaxShipBag(var_6_75) <= var_6_73 then
																							i18n = var_13

																							local var_6_76 = var_13("multiple_sorties_stop_reason3")

																							var_2_10015 = arg_1_0

																							var_6_75.DisplayBossSingleTotalReward(var_2_10015, var_6_76)

																							return
																						end

																						local var_6_77 = var_6_62[arg_1_0.contextData.mainFleetId]

																						_ = var_6_75

																						local var_6_78 = var_6_75.map

																						_ = var_2_10015

																						local var_6_79 = #var_6_78(var_2_10015.values(var_6_77.ships), function(arg_15_0)
																							getProxy = var_3_10001
																							BayProxy = var_3_10002

																							local var_15_0 = var_3_10001(var_3_10002)

																							if var_1.getShipById(var_15_0, arg_15_0) then
																								local var_15_1 = var_1.energy

																								Ship = var_3

																								if var_15_1 == var_3.ENERGY_LOW then
																									return var_1
																								end
																							end

																							return
																						end)
																						local var_6_81

																						if 0 < var_6_79 then
																							Fleet = var_6_79

																							local var_6_80 = var_6_79.DEFAULT_NAME_BOSS_ACT[arg_1_0.contextData.mainFleetId]

																							_ = var_6_81
																							var_6_81 = var_6_81.map(var_14, function(arg_16_0)
																								return "「" .. arg_16_0:getConfig("name") .. "」"
																							end)
																							i18n = var_17
																							var_2_10018 = "multiple_sorties_stop_reason2"
																							var_2_10019 = var_6_80
																							table = var_2_10020

																							local var_6_82 = var_17(var_2_10018, var_2_10019, var_2_10020.concat(var_6_81, ""))

																							var_2_10019 = arg_1_0

																							var_2_10018.DisplayBossSingleTotalReward(var_2_10019, var_6_82)

																							return
																						end

																						local var_6_83 = arg_1_0.contextData.statistics._battleScore

																						ys = var_6_81

																						if var_6_83 <= var_6_81.Battle.BattleConst.BattleScore.C then
																							i18n = var_6_83
																							var_6_83 = var_6_83("multiple_sorties_stop_reason4")

																							local var_6_84 = arg_1_0

																							var_16.DisplayBossSingleTotalReward(var_6_84, var_6_83)

																							return
																						end

																						pg = var_6_83

																						local var_6_85 = var_6_83.GuildMsgBoxMgr.GetInstance()

																						if var_15.GetShouldShowBattleTip(var_6_85) then
																							getProxy = var_16
																							GuildProxy = var_6_85

																							local var_6_86 = var_16(var_6_85)
																							local var_6_87

																							if var_16.getRawData(var_6_86) then
																								::label_6_2::

																								var_2_10018 = var_16
																								var_6_87 = var_16.getWeeklyTask(var_2_10018)
																							end

																							if var_6_87 and var_6_87.id ~= 0 then
																								var_2_10019 = var_15

																								var_15.SubmitTask(var_2_10019, function(arg_17_0, arg_17_1)
																									if arg_17_1 then
																										local var_17_0 = var_0

																										var_2.CancelShouldShowBattleTip(var_17_0)
																									end

																									return
																								end)
																							end
																						end

																						local var_6_88 = var_6_0:getCurrentContext()
																						local var_6_89 = var_16.getContextByMediator

																						BossSingleContinuousOperationMediator = var_2_10018

																						if var_6_89(var_6_88, var_2_10018) and not var_16.data.autoFlag then
																							local var_6_90 = arg_1_0

																							var_17.DisplayBossSingleTotalReward(var_6_90)

																							return
																						end

																						if arg_1_0.contextData.continuousBattleTimes < 1 then
																							local var_6_91 = arg_1_0

																							var_17.DisplayBossSingleTotalReward(var_6_91)

																							return
																						end

																						local var_6_92 = arg_1_0
																						local var_6_93 = var_17.sendNotification

																						BattleResultMediator = var_2_10019

																						var_6_93(var_6_92, var_2_10019.ON_COMPLETE_BATTLE_RESULT)

																						return
																					end
																				else
																					local var_6_94 = var_6_0
																					local var_6_95 = var_6_0.getContextByMediator

																					LevelMediator2 = var_2_10005

																					if var_6_95(var_6_94, var_2_10005) then
																						var_2_10005 = var_3

																						local var_6_96 = var_3.getContextByMediator

																						PreCombatMediator = var_2_10006

																						local var_6_97 = var_6_96(var_2_10005, var_2_10006)

																						var_3:removeChild(var_6_97)
																					end
																				end
																			end

																			::label_6_3::

																			local var_6_98 = arg_1_0
																			local var_6_99 = var_3.sendNotification

																			GAME = var_2_10005

																			var_6_99(var_6_98, var_2_10005.GO_BACK)

																			return
																		end
																	end
																end
															end
														end)
														arg_1_0:bind(var_0_1.ON_GO_TO_MAIN_SCENE, function(arg_18_0)
															local var_18_0 = arg_1_0
															local var_18_1 = var_1.sendNotification

															GAME = var_2_10003

															local var_18_2 = var_2_10003.CHANGE_SCENE

															SCENE = var_2_10004

															var_18_1(var_18_0, var_18_2, var_2_10004.MAINUI)

															return
														end)
														arg_1_0:bind(var_0_1.ON_GO_TO_TASK_SCENE, function(arg_19_0)
															getProxy = var_2_10001
															ContextProxy = var_2_10002

															local var_19_0 = var_2_10001(var_2_10002)
															local var_19_1 = var_1.getContextByMediator

															LevelMediator2 = var_2_10004

															if var_19_1(var_19_0, var_2_10004) then
																local var_19_2 = var_2
																local var_19_3 = var_2.getContextByMediator

																PreCombatMediator = var_2_10005

																local var_19_4 = var_19_3(var_19_2, var_2_10005)

																var_2_10005 = var_2

																var_2.removeChild(var_2_10005, var_19_4)
															end

															local var_19_5 = arg_1_0
															local var_19_6 = var_3.sendNotification

															GAME = var_2_10005

															local var_19_7 = var_2_10005.CHANGE_SCENE

															SCENE = var_2_10006

															var_19_6(var_19_5, var_19_7, var_2_10006.TASK)

															return
														end)
														arg_1_0:bind(var_0_1.ON_BACK_TO_DUEL_SCENE, function(arg_20_0)
															getProxy = var_2_10001
															ContextProxy = var_2_10002

															local var_20_0 = var_2_10001(var_2_10002)
															local var_20_1 = var_1.getContextByMediator

															MilitaryExerciseMediator = var_2_10004

															if var_20_1(var_20_0, var_2_10004) then
																local var_20_2 = var_2
																local var_20_3 = var_2.getContextByMediator

																ExercisePreCombatMediator = var_2_10005

																local var_20_4 = var_20_3(var_20_2, var_2_10005)

																var_2_10005 = var_2

																var_2.removeChild(var_2_10005, var_20_4)
															end

															local var_20_5 = arg_1_0
															local var_20_6 = var_3.sendNotification

															GAME = var_2_10005

															var_20_6(var_20_5, var_2_10005.GO_BACK)

															return
														end)
														arg_1_0:bind(var_0_1.GET_NEW_SHIP, function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
															local var_21_0 = arg_1_0
															local var_21_1 = var_4.addSubLayers

															Context = var_2_10006

															local var_21_2 = var_2_10006.New
															local var_21_3 = {}

															NewShipMediator = var_2_10008
															var_21_3.mediator = var_2_10008
															NewShipLayer = var_2_10008
															var_21_3.viewComponent = var_2_10008
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

															Context = var_3

															local var_22_2 = var_3.New
															local var_22_3 = {}

															BattleFailTipMediator = var_2_10005
															var_22_3.mediator = var_2_10005
															BattleFailTipLayer = var_2_10005
															var_22_3.viewComponent = var_2_10005
															var_22_3.data = {
																mainShips = var_1_9,
																battleSystem = arg_1_0.contextData.system
															}

															function var_22_3.onRemoved()
																local var_23_0 = arg_1_0.viewComponent
																local var_23_1 = var_0.emit

																BattleResultMediator = var_3_10002

																var_23_1(var_23_0, var_3_10002.ON_BACK_TO_DUEL_SCENE)

																return
															end

															var_22_1(var_22_0, var_22_2(var_22_3))

															return
														end)
														arg_1_0:bind(var_0_1.DIRECT_EXIT, function(arg_24_0, arg_24_1)
															local var_24_0 = arg_1_0
															local var_24_1 = var_2.sendNotification

															GAME = var_2_10004

															var_24_1(var_24_0, var_2_10004.GO_BACK)

															return
														end)
														arg_1_0:bind(var_0_1.REENTER_STAGE, function(arg_25_0)
															local var_25_0 = arg_1_0
															local var_25_1 = var_1.sendNotification

															GAME = var_2_10003

															var_25_1(var_25_0, var_2_10003.BEGIN_STAGE, {
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
																ChapterProxy = var_2_10002

																local var_26_1 = var_26_0(var_2_10002)
																local var_26_2 = var_1.StopAutoFight

																ChapterConst = var_2_10003

																var_26_2(var_26_1, var_2_10003.AUTOFIGHT_STOP_REASON.BATTLE_FAILED)
															end

															return
														end)

														local var_1_40 = arg_1_0
														local var_1_41 = arg_1_0.bind

														GAME = var_11

														var_1_41(var_1_40, var_11.ACT_BOSS_EXCHANGE_TICKET, function(arg_27_0, arg_27_1)
															local var_27_0 = arg_1_0
															local var_27_1 = var_2.sendNotification

															GAME = var_2_10004

															var_27_1(var_27_0, var_2_10004.ACT_BOSS_EXCHANGE_TICKET, {
																stageId = arg_27_1
															})

															return
														end)

														local var_1_42 = 0

														if var_1_9 then
															ipairs = var_1_40

															for iter_1_18, iter_1_19 in var_1_40(var_1_9) do
																var_1_42 = iter_1_19:getBattleTotalExpend() + var_1_42
															end
														end

														originalPrint = var_1_40

														var_1_40("耗时：", arg_1_0.contextData.statistics._totalTime, "秒")

														originalPrint = var_1_40

														var_1_40("编队基础油耗：", var_1_42)

														if arg_1_0.contextData.statistics._enemyInfoList then
															pairs = var_10

															for iter_1_20, iter_1_21 in var_10(arg_1_0.contextData.statistics._enemyInfoList) do
																originalPrint = var_1_10015

																var_1_10015("目标ID>>", iter_1_21.id, "<< 受到伤害共 >>", iter_1_21.damage, "<< 点")
															end
														end

														local var_1_43 = false

														SYSTEM_SCENARIO = var_1_45

														local var_1_44, var_1_45

														if var_1_6 == var_1_45 then
															var_1_44 = var_1_4
															var_1_45 = var_1_4.getActiveChapter(var_1_44)
															getProxy = var_1_44
															ChapterProxy = iter_1_20

															local var_1_46 = var_1_44(iter_1_20)

															var_1_43 = var_1_44.GetChapterAutoFlag(var_1_46, var_1_45.id) == 1
														else
															SYSTEM_WORLD = var_1_45

															if var_1_6 == var_1_45 then
																nowWorld = var_1_45
																var_1_43 = var_1_45().isAutoFight
															end
														end

														PlayerPrefs = var_1_45

														local var_1_47 = var_1_45.GetInt

														AUTO_BATTLE_LABEL = var_1_44

														local var_1_48 = var_1_47(var_1_44, 0)
														local var_1_49 = 0 < var_1_48

														ys = var_12

														if var_12.Battle.BattleState.IsAutoBotActive() and var_1_49 and not var_1_43 then
															pg = var_13

															local var_1_50 = var_13.CriMgr.GetInstance()
															local var_1_51 = var_13.PlaySoundEffect_V3

															SFX_AUTO_BATTLE = var_1_10015

															var_1_51(var_1_50, var_1_10015)

															LuaHelper = var_1_51

															var_1_51.Vibrate()
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
	ActivityProxy = var_1_10002

	local var_28_0 = var_1_10001(var_1_10002)
	local var_28_1 = var_1.getActivitiesByType

	ActivityConst = var_1_10004

	local var_28_2 = var_28_1(var_28_0, var_1_10004.ACTIVITY_TYPE_EXTRA_CHAPTER_RANK)

	getProxy = var_28_0
	ChapterProxy = var_4

	local var_28_3 = var_28_0(var_4)
	local var_28_4

	if var_3.getActiveChapter(var_28_3) then
		::label_28_0::

		var_1_10006 = var_3
		var_28_4 = var_3.getMapById(var_1_10006, var_4:getConfig("map"))
	end

	ipairs = var_1_10006

	for iter_28_0, iter_28_1 in var_1_10006(var_28_2) do
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

				ActivityLevelConst = var_28_9

				local var_28_11, var_28_12 = var_28_9.getExtraChapterSocre(var_28_6, var_28_7, var_28_10, iter_28_1)

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

					i18n = var_1_10021
					var_28_16.content = var_1_10021("extra_chapter_socre_tip", var_28_11, var_28_12, var_28_13)

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
	local var_30_0 = arg_30_1:getName()
	local var_30_1 = arg_30_1
	local var_30_2 = arg_30_1.getBody(var_30_1)

	GAME = var_30_1

	local var_30_3

	if var_30_0 == var_30_1.BEGIN_STAGE_DONE then
		var_1_10005 = arg_30_0
		var_30_3 = arg_30_0.sendNotification
		GAME = var_1_10006

		local var_30_4 = var_1_10006.CHANGE_SCENE

		SCENE = var_1_10007

		var_30_3(var_1_10005, var_30_4, var_1_10007.COMBATLOAD, var_30_2)
	else
		GAME = var_30_3

		if var_30_0 == var_30_3.ACT_BOSS_EXCHANGE_TICKET_DONE then
			existCall = var_4

			var_4(arg_30_0.viewComponent.OnActBossExchangeTicket, arg_30_0.viewComponent)
		elseif var_30_0 == var_0_1.SET_SKIP_FLAG then
			var_1_10005 = arg_30_0.viewComponent

			var_4.SetSkipFlag(var_1_10005, var_30_2)
		else
			ContinuousOperationMediator = var_4

			local var_30_5

			if var_30_0 == var_4.CONTINUE_OPERATION then
				var_30_5 = arg_30_0.contextData
				var_30_5.continuousBattleTimes = arg_30_0.contextData.continuousBattleTimes - 1
			else
				GAME = var_30_5

				local var_30_6

				if var_30_0 == var_30_5.BOSSRUSH_SETTLE_DONE then
					var_30_6 = arg_30_0.contextData.system
					var_1_10005 = arg_30_0.contextData.actId

					local var_30_7 = var_30_2.seriesData
					local var_30_8 = arg_30_0.contextData.score

					ys = var_1_10008

					if not (var_1_10008.Battle.BattleConst.BattleScore.C < var_30_8) then
						SYSTEM_BOSS_RUSH_EX = var_1_10008

						if var_30_6 == var_1_10008 then
							var_1_10009 = arg_30_0.viewComponent
							var_1_10008 = var_1_10008.emit
							BattleResultMediator = var_1_10010

							var_1_10008(var_1_10009, var_1_10010.OPEN_FAIL_TIP_LAYER)

							return
						end
					end

					var_1_10008 = nil
					var_1_10009 = nil
					SYSTEM_BOSS_RUSH_COLLABRATE = var_1_10010

					if var_30_6 == var_1_10010 then
						BossRushDALBattleResultMediator = var_1_10008
						BossRushDALBattleResultLayer = var_1_10009
					else
						SYSTEM_BOSS_RUSH_EX = var_1_10010

						if var_30_6 == var_1_10010 then
							BossRushBattleResultMediator = var_1_10008
							BossRushConst = var_1_10010
							var_1_10009 = var_1_10010.GetEXBattleResultLayer(var_1_10005)
						else
							BossRushBattleResultMediator = var_1_10008
							BossRushBattleResultLayer = var_1_10009
						end
					end

					local var_30_9 = arg_30_0
					local var_30_10 = arg_30_0.addSubLayers

					Context = var_1_10012

					var_30_10(var_30_9, var_1_10012.New({
						mediator = var_1_10008,
						viewComponent = var_1_10009,
						data = {
							awards = var_30_2.awards,
							system = arg_30_0.contextData.system,
							actId = var_1_10005,
							seriesData = var_30_7,
							win = var_7,
							OnClose = var_30_2.callback,
							isAutoFight = arg_30_0.contextData.isAutoFight
						}
					}), true)

					local var_30_11 = arg_30_0.viewComponent

					var_10.closeView(var_30_11)
				else
					ContinuousOperationMediator = var_30_6

					if var_30_0 == var_30_6.ON_REENTER then
						if not var_30_2.autoFlag then
							var_1_10005 = arg_30_0

							arg_30_0.DisplayTotalReward(var_1_10005)

							return
						end

						getProxy = var_4
						ActivityProxy = var_1_10005

						local var_30_12 = var_4(var_1_10005)
						local var_30_13 = var_4.getActivityById(var_30_12, arg_30_0.contextData.actId)
						local var_30_14 = var_4.getConfig(var_30_13, "config_id")

						pg = var_30_13

						local var_30_15 = var_30_13.activity_event_worldboss[var_30_14].ticket

						getProxy = var_1_10008
						PlayerProxy = var_1_10009

						local var_30_16 = var_1_10008(var_1_10009)
						local var_30_17 = var_8.getRawData(var_30_16)
						local var_30_18 = var_8.getResource(var_30_17, var_30_15)
						local var_30_19 = var_4

						if var_4.GetStageBonus(var_30_19, arg_30_0.contextData.stageId) == 0 then
							getProxy = var_30_19
							SettingsProxy = var_11

							local var_30_20 = var_30_19(var_11)

							if var_10.isTipActBossExchangeTicket(var_30_20) == 1 and var_30_18 > 0 then
								local var_30_21 = arg_30_0
								local var_30_22 = arg_30_0.sendNotification

								GAME = var_1_10013

								var_30_22(var_30_21, var_1_10013.ACT_BOSS_EXCHANGE_TICKET, {
									stageId = arg_30_0.contextData.stageId
								})

								return
							end
						end

						local var_30_23 = arg_30_0.viewComponent

						var_10.emit(var_30_23, var_0_1.REENTER_STAGE)
					else
						BossSingleContinuousOperationMediator = var_4

						local var_30_24

						if var_30_0 == var_4.CONTINUE_OPERATION then
							var_30_24 = arg_30_0.contextData
							var_30_24.continuousBattleTimes = arg_30_0.contextData.continuousBattleTimes - 1
						else
							BossSingleContinuousOperationMediator = var_30_24

							if var_30_0 == var_30_24.ON_REENTER then
								if not var_30_2.autoFlag then
									arg_30_0:DisplayBossSingleTotalReward()

									return
								end

								local var_30_25 = arg_30_0.viewComponent

								var_4.emit(var_30_25, var_0_1.REENTER_STAGE)
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
	ContextProxy = var_1_10003

	local var_31_0 = var_1_10002(var_1_10003)
	local var_31_1 = var_2.getCurrentContext(var_31_0)
	local var_31_2 = var_2.getContextByMediator

	ContinuousOperationMediator = var_1_10004

	local var_31_3

	if not var_31_2(var_31_1, var_1_10004) or not var_2.data.autoFlag then
		var_31_3 = nil
	end

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_31_4 = var_1_10004(var_1_10005)
	local var_31_5 = var_4.PopActBossRewards(var_31_4)

	LoadContextCommand = var_31_4

	local var_31_6 = var_31_4.LoadLayerOnTopContext

	Context = var_1_10006

	local var_31_7 = var_1_10006.New
	local var_31_8 = {}

	ActivityBossTotalRewardPanelMediator = var_1_10008
	var_31_8.mediator = var_1_10008
	ActivityBossTotalRewardPanel = var_1_10008
	var_31_8.viewComponent = var_1_10008
	var_31_8.data = {
		onClose = function()
			local var_32_0 = arg_31_0.viewComponent
			local var_32_1 = var_0.emit

			BaseUI = var_2_10002

			var_32_1(var_32_0, var_2_10002.ON_BACK)

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
	ContextProxy = var_1_10003

	local var_33_0 = var_1_10002(var_1_10003)
	local var_33_1 = var_2.getCurrentContext(var_33_0)
	local var_33_2 = var_2.getContextByMediator

	BossSingleContinuousOperationMediator = var_1_10004

	local var_33_3

	if not var_33_2(var_33_1, var_1_10004) or not var_2.data.autoFlag then
		var_33_3 = nil
	end

	getProxy = var_1_10004
	ChapterProxy = var_1_10005

	local var_33_4 = var_1_10004(var_1_10005)
	local var_33_5 = var_4.PopBossSingleRewards(var_33_4)

	LoadContextCommand = var_33_4

	local var_33_6 = var_33_4.LoadLayerOnTopContext

	Context = var_1_10006

	local var_33_7 = var_1_10006.New
	local var_33_8 = {}

	BossSingleTotalRewardPanelMediator = var_1_10008
	var_33_8.mediator = var_1_10008
	BossSingleTotalRewardPanel = var_1_10008
	var_33_8.viewComponent = var_1_10008
	var_33_8.data = {
		onConfirm = function()
			local var_34_0 = arg_33_0.viewComponent
			local var_34_1 = var_0.emit

			BaseUI = var_2_10002

			var_34_1(var_34_0, var_2_10002.ON_BACK)

			return
		end,
		onClose = function()
			getProxy = var_2_10000
			ContextProxy = var_2_10001

			local var_35_0 = var_2_10000(var_2_10001)
			local var_35_1 = var_0.getContextByMediator

			ClueMapMediator = var_2_10002

			if var_35_1(var_35_0, var_2_10002) then
				var_0.cleanChild = true
				warning = var_35_0

				var_35_0("ClueMapMediator")
			end

			getProxy = var_35_0
			ContextProxy = var_2_10002

			local var_35_2 = var_35_0(var_2_10002)
			local var_35_3 = var_1.getContextByMediator

			BossSinglePreCombatMediator = var_2_10003

			if var_35_3(var_35_2, var_2_10003) then
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
