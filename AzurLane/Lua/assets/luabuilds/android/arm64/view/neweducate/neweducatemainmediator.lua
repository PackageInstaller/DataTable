class = var_0_10000

local var_0_0 = "NewEducateMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateContextMediator"))

var_0_1.OPEN_COLLECT_LAYER = "NewEducateMainMediator.OPEN_COLLECT_LAYER"
var_0_1.ON_SELECT_MIND = "NewEducateMainMediator.ON_SELECT_MIND"
var_0_1.ON_UPGRADE_FAVOR = "NewEducateMainMediator.ON_UPGRADE_FAVOR"
var_0_1.ON_TRIGGER_MAIN_EVENT = "NewEducateMainMediator.ON_TRIGGER_MAIN_EVENT"
var_0_1.ON_REQ_TALENTS = "NewEducateMainMediator.ON_REQ_TALENTS"
var_0_1.ON_REQ_CHOOSE = "NewEducateMainMediator.ON_REQ_CHOOSE"
var_0_1.ON_REQ_TOPICS = "NewEducateMainMediator.ON_REQ_TOPICS"
var_0_1.ON_SELECT_TOPIC = "NewEducateMainMediator.ON_SELECT_TOPIC"
var_0_1.ON_ENTER_ASSESS = "NewEducateMainMediator.ON_ENTER_ASSESS"
var_0_1.ON_SET_ASSESS_RANK = "NewEducateMainMediator.ON_SET_ASSESS_RANK"
var_0_1.ON_STAGE_CHANGE = "NewEducateMainMediator.ON_STAGE_CHANGE"
var_0_1.ON_NEXT_PLAN = "NewEducateMainMediator.ON_NEXT_PLAN"
var_0_1.ON_REQ_MAP = "NewEducateMainMediator.ON_REQ_MAP"
var_0_1.ON_REQ_ENDINGS = "NewEducateMainMediator.ON_REQ_ENDINGS"
var_0_1.ON_RESET = "NewEducateMainMediator.ON_RESET"
var_0_1.ON_SELECT_ENDING = "NewEducateMainMediator.ON_SELECT_ENDING"
var_0_1.ON_START_ENDLESS = "NewEducateMainMediator.ON_START_ENDLESS"
var_0_1.ON_CLEAR_NODE_CHAIN = "NewEducateMainMediator.ON_CLEAR_NODE_CHAIN"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_COLLECT_LAYER, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		NewEducateCollectEntranceMediator = var_2_10007
		var_2_3.mediator = var_2_10007
		NewEducateCollectEntranceLayer = var_2_10007
		var_2_3.viewComponent = var_2_10007

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_MIND, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.NEW_EDUCATE_SEL_MIND, {
			id = arg_1_0.contextData.char.id,
			callback = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPGRADE_FAVOR, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.NEW_EDUCATE_UPGRADE_FAVOR, {
			id = arg_1_0.contextData.char.id,
			callback = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TRIGGER_MAIN_EVENT, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.NEW_EDUCATE_MAIN_EVENT, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REQ_TALENTS, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.NEW_EDUCATE_GET_TALENTS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REQ_CHOOSE, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.NEW_EDUCATE_GET_CHOOSE, {
			id = arg_1_0.contextData.char.id,
			callback = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REQ_TOPICS, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.NEW_EDUCATE_GET_TOPICS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_TOPIC, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.NEW_EDUCATE_SEL_TOPIC, {
			id = arg_1_0.contextData.char.id,
			topicId = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_NEXT_PLAN, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10005

		var_10_1(var_10_0, var_2_10005.NEW_EDUCATE_NEXT_PLAN, {
			rePlay = true,
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ENTER_ASSESS, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10005

		var_11_1(var_11_0, var_2_10005.NEW_EDUCATE_ENTER_ASSESS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_11_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SET_ASSESS_RANK, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = arg_1_0
		local var_12_1 = var_4.sendNotification

		GAME = var_2_10007

		var_12_1(var_12_0, var_2_10007.NEW_EDUCATE_ASSESS, {
			id = arg_1_0.contextData.char.id,
			rank = arg_12_1,
			endlessFail = arg_12_2,
			callback = arg_12_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_STAGE_CHANGE, function(arg_13_0)
		local var_13_0 = arg_1_0
		local var_13_1 = var_1.sendNotification

		GAME = var_2_10004

		var_13_1(var_13_0, var_2_10004.NEW_EDUCATE_CHANGE_PHASE, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REQ_MAP, function(arg_14_0)
		local var_14_0 = arg_1_0
		local var_14_1 = var_1.sendNotification

		GAME = var_2_10004

		var_14_1(var_14_0, var_2_10004.NEW_EDUCATE_GET_MAP, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REQ_ENDINGS, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10005

		var_15_1(var_15_0, var_2_10005.NEW_EDUCATE_GET_ENDINGS, {
			id = arg_1_0.contextData.char.id,
			callback = arg_15_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_RESET, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_1_0
		local var_16_1 = var_2.sendNotification

		GAME = var_2_10005

		var_16_1(var_16_0, var_2_10005.NEW_EDUCATE_RESET, {
			id = arg_1_0.contextData.char.id,
			difficulty = arg_1_0.contextData.char.difficulty,
			callback = arg_16_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SELECT_ENDING, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_1_0
		local var_17_1 = var_2.sendNotification

		GAME = var_2_10005

		var_17_1(var_17_0, var_2_10005.NEW_EDUCATE_SEL_ENDING, {
			isMain = true,
			id = arg_1_0.contextData.char.id,
			endingId = arg_17_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_START_ENDLESS, function(arg_18_0)
		local var_18_0 = arg_1_0
		local var_18_1 = var_1.sendNotification

		GAME = var_2_10004

		var_18_1(var_18_0, var_2_10004.NEW_EDUCATE_CHANGE_PHASE, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CLEAR_NODE_CHAIN, function(arg_19_0)
		local var_19_0 = arg_1_0
		local var_19_1 = var_1.sendNotification

		GAME = var_2_10004

		var_19_1(var_19_0, var_2_10004.NEW_EDUCATE_CLEAR_NODE_CHAIN, {
			id = arg_1_0.contextData.char.id
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_20_0)
	local var_20_0 = {}

	NewEducateProxy = var_1_10002
	var_20_0[1] = var_1_10002.RESOURCE_UPDATED
	NewEducateProxy = var_2
	var_20_0[2] = var_2.ATTR_UPDATED
	NewEducateProxy = var_2
	var_20_0[3] = var_2.PERSONALITY_UPDATED
	NewEducateProxy = var_2
	var_20_0[4] = var_2.TALENT_UPDATED
	NewEducateProxy = var_2
	var_20_0[5] = var_2.STATUS_UPDATED
	NewEducateProxy = var_2
	var_20_0[6] = var_2.TAROT_UPDATED
	NewEducateProxy = var_2
	var_20_0[7] = var_2.NEXT_ROUND
	GAME = var_2
	var_20_0[8] = var_2.NEW_EDUCATE_SEL_TOPIC_DONE
	GAME = var_2
	var_20_0[9] = var_2.NEW_EDUCATE_NODE_START
	GAME = var_2
	var_20_0[10] = var_2.NEW_EDUCATE_NEXT_NODE
	GAME = var_2
	var_20_0[11] = var_2.NEW_EDUCATE_CHECK_FSM
	GAME = var_2
	var_20_0[12] = var_2.NEW_EDUCATE_CHECK_PRIORITY_FSM
	GAME = var_2
	var_20_0[13] = var_2.NEW_EDUCATE_GET_EXTRA_DROP_DONE
	GAME = var_2
	var_20_0[14] = var_2.NEW_EDUCATE_UPGRADE_FAVOR_DONE
	GAME = var_2
	var_20_0[15] = var_2.NEW_EDUCATE_REFRESH_DONE
	GAME = var_2
	var_20_0[16] = var_2.NEW_EDUCATE_ENTER_ASSESS_DONE
	GAME = var_2
	var_20_0[17] = var_2.NEW_EDUCATE_ASSESS_DONE
	GAME = var_2
	var_20_0[18] = var_2.NEW_EDUCATE_CHANGE_PHASE_DONE
	GAME = var_2
	var_20_0[19] = var_2.NEW_EDUCATE_NEXT_PLAN_DONE
	GAME = var_2
	var_20_0[20] = var_2.NEW_EDUCATE_GET_MAP_DONE
	GAME = var_2
	var_20_0[21] = var_2.NEW_EDUCATE_SEL_MIND_DONE
	GAME = var_2
	var_20_0[22] = var_2.NEW_EDUCATE_SEL_ENDING_DONE
	GAME = var_2
	var_20_0[23] = var_2.NEW_EDUCATE_SET_CALL_DONE

	return var_20_0
end

function var_0_1.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_1.getName(var_21_0)
	local var_21_2 = arg_21_1:getBody()

	NewEducateProxy = var_21_0

	if var_21_1 == var_21_0.RESOURCE_UPDATED then
		local var_21_3 = arg_21_0.viewComponent

		var_4.OnResUpdate(var_21_3)
	else
		NewEducateProxy = var_4

		if var_21_1 == var_4.ATTR_UPDATED then
			local var_21_4 = arg_21_0.viewComponent

			var_4.OnAttrUpdate(var_21_4)
		else
			NewEducateProxy = var_4

			if var_21_1 == var_4.PERSONALITY_UPDATED then
				local var_21_5 = arg_21_0.viewComponent

				var_4.OnPersonalityUpdate(var_21_5, var_21_2.number, var_21_2.oldTag)
			else
				NewEducateProxy = var_4

				if var_21_1 == var_4.TALENT_UPDATED then
					local var_21_6 = arg_21_0.viewComponent

					var_4.OnTalentUpdate(var_21_6)
				else
					NewEducateProxy = var_4

					if var_21_1 == var_4.STATUS_UPDATED then
						local var_21_7 = arg_21_0.viewComponent

						var_4.OnStatusUpdate(var_21_7)
					else
						NewEducateProxy = var_4

						if var_21_1 == var_4.TAROT_UPDATED then
							local var_21_8 = arg_21_0.viewComponent

							var_4.OnTarotUpdate(var_21_8)
						else
							NewEducateProxy = var_4

							if var_21_1 == var_4.NEXT_ROUND then
								local var_21_9 = arg_21_0.viewComponent

								var_4.OnNextRound(var_21_9)
							else
								GAME = var_4

								if var_21_1 == var_4.NEW_EDUCATE_NODE_START then
									local var_21_10 = arg_21_0.viewComponent

									var_4.OnNodeStart(var_21_10, var_21_2.node)
								else
									GAME = var_4

									if var_21_1 == var_4.NEW_EDUCATE_NEXT_NODE then
										local var_21_11 = arg_21_0.viewComponent

										var_4.OnNextNode(var_21_11, var_21_2)
									else
										GAME = var_4

										if var_21_1 == var_4.NEW_EDUCATE_CHECK_FSM then
											local var_21_12 = arg_21_0.viewComponent

											var_4.CheckFSM(var_21_12)
										else
											GAME = var_4

											if var_21_1 == var_4.NEW_EDUCATE_CHECK_PRIORITY_FSM then
												arg_21_0:CheckPriorityState()
											else
												GAME = var_4

												local var_21_14

												if var_21_1 == var_4.NEW_EDUCATE_GET_EXTRA_DROP_DONE then
													if #var_21_2.drops == 0 then
														arg_21_0:AddResultLayer(var_21_2)
													else
														local var_21_13 = arg_21_0.viewComponent

														var_21_14 = var_21_14.emit
														NewEducateBaseUI = var_1_10007

														var_21_14(var_21_13, var_1_10007.ON_DROP, {
															items = var_21_2.drops,
															removeFunc = function()
																local var_22_0 = arg_21_0

																var_0.AddResultLayer(var_22_0, var_21_2)

																return
															end
														})
													end
												else
													GAME = var_21_14

													local var_21_17

													if var_21_1 == var_21_14.NEW_EDUCATE_UPGRADE_FAVOR_DONE then
														local var_21_15 = arg_21_0.viewComponent

														var_21_17.UpdateFavorInfo(var_21_15)

														local var_21_16 = arg_21_0.viewComponent

														var_21_17 = var_21_17.emit
														NewEducateBaseUI = var_1_10007

														var_21_17(var_21_16, var_1_10007.ON_DROP, {
															isFavor = true,
															items = var_21_2.drops,
															removeFunc = function()
																local var_23_0 = arg_21_0.viewComponent

																var_0.CheckFavorUpgrade(var_23_0, var_21_2.callback)

																return
															end
														})
													else
														GAME = var_21_17

														if var_21_1 == var_21_17.NEW_EDUCATE_REFRESH_DONE then
															local var_21_18 = arg_21_0.viewComponent

															var_4.OnReset(var_21_18)
														else
															GAME = var_4

															if var_21_1 == var_4.NEW_EDUCATE_SEL_TOPIC_DONE then
																arg_21_0:StartNodeWithCheckDrops(var_21_2)
															else
																GAME = var_4

																local var_21_20

																if var_21_1 == var_4.NEW_EDUCATE_ENTER_ASSESS_DONE then
																	if #var_21_2.drops == 0 then
																		existCall = var_21_20

																		var_21_20(var_21_2.callback)
																	else
																		local var_21_19 = arg_21_0.viewComponent

																		var_21_20 = var_21_20.emit
																		NewEducateBaseUI = var_1_10007

																		var_21_20(var_21_19, var_1_10007.ON_DROP, {
																			items = var_21_2.drops,
																			removeFunc = var_21_2.callback
																		})
																	end
																else
																	GAME = var_21_20

																	if var_21_1 == var_21_20.NEW_EDUCATE_ASSESS_DONE then
																		seriesAsync = var_4

																		var_4({
																			function(arg_24_0)
																				if #var_21_2.drops == 0 then
																					arg_24_0()
																				else
																					local var_24_0 = arg_21_0.viewComponent
																					local var_24_1 = var_1.emit

																					NewEducateBaseUI = var_2_10004

																					var_24_1(var_24_0, var_2_10004.ON_DROP, {
																						items = var_21_2.drops,
																						removeFunc = arg_24_0
																					})
																				end

																				return
																			end
																		}, function(arg_25_0)
																			if var_21_2.node ~= 0 then
																				local var_25_0 = arg_21_0.viewComponent

																				var_1.OnNodeStart(var_25_0, var_21_2.node)
																			else
																				local var_25_1 = arg_21_0.viewComponent

																				var_1.SeriesCheck(var_25_1)
																			end

																			return
																		end)
																	else
																		GAME = var_4

																		if var_21_1 == var_4.NEW_EDUCATE_CHANGE_PHASE_DONE then
																			local var_21_21 = arg_21_0.viewComponent

																			var_4.AddNewRoundDrops(var_21_21, var_21_2.drops)
																			arg_21_0:CheckFirstNodeExist(var_21_2.node)
																		else
																			GAME = var_4

																			local var_21_22

																			if var_21_1 == var_4.NEW_EDUCATE_NEXT_PLAN_DONE then
																				function var_21_22()
																					if var_21_2.isFristNode then
																						local var_26_0 = arg_21_0.viewComponent

																						var_0.OnNodeStart(var_26_0, var_21_2.node)
																					else
																						local var_26_1 = arg_21_0.viewComponent

																						var_0.OnNextNode(var_26_1, var_21_2)
																					end

																					return
																				end

																				if #var_21_2.drops == 0 then
																					var_21_22()
																				else
																					var_1_10007 = arg_21_0.viewComponent

																					local var_21_23 = var_5.emit

																					NewEducateBaseUI = var_1_10008

																					var_21_23(var_1_10007, var_1_10008.ON_DROP, {
																						items = var_21_2.drops,
																						removeFunc = var_21_22
																					})
																				end
																			else
																				GAME = var_21_22

																				local var_21_26

																				if var_21_1 == var_21_22.NEW_EDUCATE_GET_MAP_DONE then
																					if #var_21_2.drops == 0 then
																						local var_21_24 = arg_21_0.viewComponent

																						var_21_26.CheckFSM(var_21_24)
																					else
																						local var_21_25 = arg_21_0.viewComponent

																						var_21_26 = var_21_26.emit
																						NewEducateBaseUI = var_1_10007

																						var_21_26(var_21_25, var_1_10007.ON_DROP, {
																							items = var_21_2.drops,
																							removeFunc = function()
																								local var_27_0 = arg_21_0.viewComponent

																								var_0.CheckFSM(var_27_0)

																								return
																							end
																						})
																					end
																				else
																					GAME = var_21_26

																					if var_21_1 == var_21_26.NEW_EDUCATE_SEL_MIND_DONE then
																						arg_21_0:StartNodeWithCheckDrops(var_21_2)
																					else
																						GAME = var_4

																						if var_21_1 == var_4.NEW_EDUCATE_SEL_ENDING_DONE then
																							if var_21_2.isMain then
																								local var_21_27 = arg_21_0.viewComponent

																								var_4.OnSelDone(var_21_27, var_21_2.id)
																							end
																						else
																							GAME = var_4

																							if var_21_1 == var_4.NEW_EDUCATE_SET_CALL_DONE then
																								local var_21_28 = arg_21_0.viewComponent

																								var_4.UpdateCallName(var_21_28)
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
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.CheckFirstNodeExist(arg_28_0, arg_28_1)
	if arg_28_1 == 0 then
		local var_28_0 = arg_28_0.viewComponent

		var_2.SeriesCheck(var_28_0)
	else
		local var_28_1 = arg_28_0.viewComponent

		var_2.OnNodeStart(var_28_1, arg_28_1)
	end

	return
end

function var_0_1.StartNodeWithCheckDrops(arg_29_0, arg_29_1)
	if #arg_29_1.drops == 0 then
		local var_29_0 = arg_29_0.viewComponent

		var_2.OnNodeStart(var_29_0, arg_29_1.node)
	else
		local var_29_1 = arg_29_0.viewComponent
		local var_29_2 = var_2.emit

		NewEducateBaseUI = var_1_10005

		var_29_2(var_29_1, var_1_10005.ON_DROP, {
			items = arg_29_1.drops,
			removeFunc = function()
				local var_30_0 = arg_29_0.viewComponent

				var_0.OnNodeStart(var_30_0, arg_29_1.node)

				return
			end
		})
	end

	return
end

function var_0_1.AddResultLayer(arg_31_0, arg_31_1)
	if #arg_31_1.scheduleDrops > 0 then
		local var_31_0 = arg_31_0
		local var_31_1 = arg_31_0.addSubLayers

		Context = var_1_10005

		local var_31_2 = var_1_10005.New
		local var_31_3 = {}

		NewEducateScheduleResultLayer = var_1_10008
		var_31_3.viewComponent = var_1_10008
		NewEducateScheduleResultMediator = var_1_10008
		var_31_3.mediator = var_1_10008
		var_31_3.data = {
			drops = arg_31_1.scheduleDrops,
			onExit = function()
				local var_32_0 = arg_31_0.viewComponent

				var_0.CheckFSM(var_32_0)

				return
			end
		}

		var_31_1(var_31_0, var_31_2(var_31_3))
	else
		local var_31_4 = arg_31_0.viewComponent

		var_2.CheckFSM(var_31_4)
	end

	return
end

return var_0_1
