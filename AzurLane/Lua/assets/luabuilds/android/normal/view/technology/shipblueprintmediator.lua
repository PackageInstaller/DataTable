class = var_0_10000

local var_0_0 = "ShipBluePrintMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_CLICK_SPEEDUP_BTN = "ShipBluePrintMediator:ON_CLICK_SPEEDUP_BTN"
var_0_1.ON_START = "ShipBluePrintMediator:ON_START"
var_0_1.ON_FINISHED = "ShipBluePrintMediator:ON_FINISHED"
var_0_1.ON_ITEM_UNLOCK = "ShipBluePrintMediator:ON_ITEM_UNLOCK"
var_0_1.ON_FINISH_TASK = "ShipBluePrintMediator:ON_FINISH_TASK"
var_0_1.ON_MOD = "ShipBluePrintMediator:ON_MOD"
var_0_1.ON_PURSUING = "ShipBluePrintMediator:ON_PURSUING"
var_0_1.ON_TASK_OPEN = "ShipBluePrintMediator:ON_TASK_OPEN"
var_0_1.ON_CHECK_TAKES = "ShipBluePrintMediator:ON_CHECK_TAKES"
var_0_1.SHOW_SKILL_INFO = "ShipBluePrintMediator:SHOW_SKILL_INFO"
var_0_1.SET_TECHNOLOGY_VERSION = "ShipBluePrintMediator:SET_TECHNOLOGY_VERSION"
var_0_1.SIMULATION_BATTLE = "ShipBluePrintMediator:SIMULATION_BATTLE"
var_0_1.QUICK_EXCHAGE_BLUEPRINT = "ShipBluePrintMediator:QUICK_EXCHAGE_BLUEPRINT"
var_0_1.FINISH_PHANTOM_QUEST = "ShipBluePrintMediator.FINISH_PHANTOM_QUEST"
var_0_1.OPEN_PHANTOM_LAYER = "ShipBluePrintMediator.OPEN_PHANTOM_LAYER"

function var_0_1.register(arg_1_0)
	PlayerPrefs = var_1_10001

	local var_1_0 = var_1_10001.SetString
	local var_1_1 = "technology_day_mark"

	pg = var_1_10003

	local var_1_2 = var_1_10003.TimeMgr.GetInstance()

	var_1_0(var_1_1, var_3.CurrentSTimeDesc(var_1_2, "%Y/%m/%d", true))

	getProxy = var_1_0
	TechnologyProxy = var_1_1

	local var_1_3 = var_1_0(var_1_1)

	if arg_1_0.contextData.shipId then
		getProxy = var_2
		BayProxy = var_3

		local var_1_4 = var_2(var_3)
		local var_1_5 = var_2.getShipById(var_1_4, arg_1_0.contextData.shipId)
		local var_1_6 = var_1_3:getBluePrintById(var_1_5.groupId)

		arg_1_0.contextData.shipBluePrintVO = var_1_6
	elseif arg_1_0.contextData.shipGroupId then
		local var_1_7 = var_1_3:getBluePrintById(arg_1_0.contextData.shipGroupId)

		arg_1_0.contextData.shipBluePrintVO = var_1_7
	end

	arg_1_0:bind(var_0_1.ON_CLICK_SPEEDUP_BTN, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.addSubLayers

		Context = var_2_10002

		local var_2_2 = var_2_10002.New
		local var_2_3 = {}

		TecSpeedUpLayer = var_2_10004
		var_2_3.viewComponent = var_2_10004
		TecSpeedUpMediator = var_2_10004
		var_2_3.mediator = var_2_10004

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_START, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.BUILD_SHIP_BLUEPRINT, {
			id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FINISHED, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.FINISH_SHIP_BLUEPRINT, {
			id = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ITEM_UNLOCK, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.ITEM_LOCK_SHIP_BLUPRINT, {
			id = arg_5_1,
			itemId = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FINISH_TASK, function(arg_6_0, arg_6_1)
		Task = var_2_10002

		local var_6_0 = var_2_10002.New({
			id = arg_6_1
		})
		local var_6_1 = var_2.getConfig(var_6_0, "sub_type")

		TASK_SUB_TYPE_GIVE_ITEM = var_6_0

		if var_6_1 == var_6_0 then
			getDropInfo = var_6_1

			local var_6_2 = {}
			local var_6_3 = {}

			DROP_TYPE_ITEM = var_2_10006
			var_6_3[1] = var_2_10006
			tonumber = var_2_10006
			var_6_3[2] = var_2_10006(var_2:getConfig("target_id"))

			local var_6_4 = var_2

			var_6_3[3] = var_2.getConfig(var_6_4, "target_num")
			var_6_2[1] = var_6_3

			local var_6_5 = var_6_1(var_6_2)

			pg = var_6_2

			local var_6_6 = var_6_2.MsgboxMgr.GetInstance()
			local var_6_7 = var_4.ShowMsgBox

			var_2_10006 = {}
			i18n = var_6_4
			var_2_10006.content = var_6_4("blueprint_commit_tip", var_6_5)

			function var_2_10006.onYes()
				local var_7_0 = arg_1_0
				local var_7_1 = var_0.sendNotification

				GAME = var_3_10002

				var_7_1(var_7_0, var_3_10002.SUBMIT_TASK, arg_6_1)

				return
			end

			var_6_7(var_6_6, var_2_10006)
		else
			local var_6_8 = var_2
			local var_6_9 = var_2.getConfig(var_6_8, "sub_type")

			TASK_SUB_TYPE_PLAYER_RES = var_6_8

			local var_6_11

			if var_6_9 == var_6_8 then
				getDropInfo = var_6_9

				local var_6_10 = {}

				var_6_11 = {}
				DROP_TYPE_RESOURCE = var_2_10006
				var_6_11[1] = var_2_10006
				tonumber = var_2_10006
				var_6_11[2] = var_2_10006(var_2:getConfig("target_id"))

				local var_6_12 = var_2

				var_6_11[3] = var_2.getConfig(var_6_12, "target_num")
				var_6_10[1] = var_6_11

				local var_6_13 = var_6_9(var_6_10)

				pg = var_6_10
				var_6_11 = var_6_10.MsgboxMgr.GetInstance()

				local var_6_14 = var_4.ShowMsgBox
				local var_6_15 = {}

				i18n = var_6_12
				var_6_15.content = var_6_12("blueprint_commit_tip", var_6_13)

				function var_6_15.onYes()
					local var_8_0 = arg_1_0
					local var_8_1 = var_0.sendNotification

					GAME = var_3_10002

					var_8_1(var_8_0, var_3_10002.SUBMIT_TASK, arg_6_1)

					return
				end

				var_6_14(var_6_11, var_6_15)
			else
				local var_6_16 = arg_1_0
				local var_6_17 = var_3.sendNotification

				GAME = var_6_11

				var_6_17(var_6_16, var_6_11.SUBMIT_TASK, arg_6_1)
			end
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_MOD, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_1_0
		local var_9_1 = var_3.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.MOD_BLUEPRINT, {
			id = arg_9_1,
			count = arg_9_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_PURSUING, function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = arg_1_0
		local var_10_1 = var_3.sendNotification

		GAME = var_2_10005

		var_10_1(var_10_0, var_2_10005.PURSUING_BLUEPRINT, {
			id = arg_10_1,
			count = arg_10_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_OPEN, function(arg_11_0, arg_11_1)
		getProxy = var_2_10002
		TaskProxy = var_2_10003

		local var_11_0 = var_2_10002(var_2_10003)

		if not var_2.isFinishPrevTasks(var_11_0, arg_11_1) then
			return
		end

		local var_11_1 = arg_1_0
		local var_11_2 = var_2.sendNotification

		GAME = var_4

		var_11_2(var_11_1, var_4.TRIGGER_TASK, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHECK_TAKES, function(arg_12_0, arg_12_1)
		getProxy = var_2_10002
		TechnologyProxy = var_2_10003

		local var_12_0 = var_2_10002(var_2_10003)
		local var_12_1 = var_2.getBluePrintById(var_12_0, arg_12_1)

		if var_3.isFinishedAllTasks(var_12_1) then
			var_3:finish()
			var_2:updateBluePrint(var_3)
		end

		return
	end)
	arg_1_0:bind(var_0_1.SHOW_SKILL_INFO, function(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = arg_1_0
		local var_13_1 = var_4.addSubLayers

		Context = var_2_10006

		local var_13_2 = var_2_10006.New
		local var_13_3 = {}

		SkillInfoMediator = var_2_10008
		var_13_3.mediator = var_2_10008
		SkillInfoLayer = var_2_10008
		var_13_3.viewComponent = var_2_10008
		var_13_3.data = {
			skillOnShip = arg_13_2,
			skillId = arg_13_1,
			onExit = arg_13_3
		}

		var_13_1(var_13_0, var_13_2(var_13_3))

		return
	end)
	arg_1_0:bind(var_0_1.SET_TECHNOLOGY_VERSION, function(arg_14_0, arg_14_1)
		local var_14_0 = var_1_3

		var_2.setVersion(var_14_0, arg_14_1)

		return
	end)
	arg_1_0:bind(var_0_1.SIMULATION_BATTLE, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_1_0
		local var_15_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_15_2 = var_2_10004.BEGIN_STAGE
		local var_15_3 = {}

		SYSTEM_SIMULATION = var_2_10006
		var_15_3.system = var_2_10006
		var_15_3.stageId = arg_15_1

		var_15_1(var_15_0, var_15_2, var_15_3)

		return
	end)
	arg_1_0:bind(var_0_1.QUICK_EXCHAGE_BLUEPRINT, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_1_0
		local var_16_1 = var_2.sendNotification

		GAME = var_2_10004

		var_16_1(var_16_0, var_2_10004.QUICK_EXCHANGE_BLUEPRINT, arg_16_1)

		return
	end)
	arg_1_0:bind(var_0_1.FINISH_PHANTOM_QUEST, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_1_0
		local var_17_1 = var_3.sendNotification

		GAME = var_2_10005

		var_17_1(var_17_0, var_2_10005.FINISH_PHANTOM_QUEST, {
			bluePrintId = arg_17_1,
			questId = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PHANTOM_LAYER, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_1_0
		local var_18_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_18_2 = var_2_10004.New
		local var_18_3 = {}

		DockyardMediator = var_2_10006
		var_18_3.mediator = var_2_10006
		DockyardScene = var_2_10006
		var_18_3.viewComponent = var_2_10006

		local var_18_4 = {}

		DockyardScene = var_2_10007
		var_18_4.mode = var_2_10007.MODE_SHIP_PHANTOM
		var_18_4.techVersion = arg_18_1
		var_18_3.data = var_18_4

		function var_18_3.onRemoved()
			local var_19_0 = arg_1_0.viewComponent

			var_0.changeEffectVisible(var_19_0, true)

			local var_19_1 = arg_1_0.viewComponent

			var_0.updateMod(var_19_1)

			return
		end

		var_18_1(var_18_0, var_18_2(var_18_3))

		local var_18_5 = arg_1_0.viewComponent

		var_2.changeEffectVisible(var_18_5, false)

		return
	end)

	local var_1_8 = var_1_3:getBluePrints()
	local var_1_9 = arg_1_0.viewComponent

	var_3.setShipBluePrints(var_1_9, var_1_8)

	getProxy = var_3
	BayProxy = var_1_9

	local var_1_10 = var_3(var_1_9)
	local var_1_11 = arg_1_0.viewComponent

	var_4.setShipVOs(var_1_11, var_1_10:getRawData())

	local var_1_12 = arg_1_0.viewComponent
	local var_1_13 = var_4.setVersion
	local var_1_14 = var_1_3

	var_1_13(var_1_12, var_1_3.getVersion(var_1_14))

	local var_1_15 = arg_1_0.viewComponent
	local var_1_16 = var_4.setTaskVOs

	getProxy = var_6
	TaskProxy = var_1_14

	local var_1_17 = var_6(var_1_14)

	var_1_16(var_1_15, var_6.getTasksForBluePrint(var_1_17))

	return
end

function var_0_1.listNotificationInterests(arg_20_0)
	local var_20_0 = {}

	GAME = var_1_10002
	var_20_0[1] = var_1_10002.BUILD_SHIP_BLUEPRINT_DONE
	TechnologyProxy = var_2
	var_20_0[2] = var_2.BLUEPRINT_UPDATED
	TaskProxy = var_2
	var_20_0[3] = var_2.TASK_ADDED
	TaskProxy = var_2
	var_20_0[4] = var_2.TASK_UPDATED
	TaskProxy = var_2
	var_20_0[5] = var_2.TASK_REMOVED
	TaskProxy = var_2
	var_20_0[6] = var_2.TASK_DELETE
	GAME = var_2
	var_20_0[7] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_20_0[8] = var_2.FINISH_SHIP_BLUEPRINT_DONE
	GAME = var_2
	var_20_0[9] = var_2.ITEM_LOCK_SHIP_BLUPRINT_DONE
	GAME = var_2
	var_20_0[10] = var_2.STOP_BLUEPRINT_DONE
	GAME = var_2
	var_20_0[11] = var_2.MOD_BLUEPRINT_DONE
	BayProxy = var_2
	var_20_0[12] = var_2.SHIP_ADDED
	BayProxy = var_2
	var_20_0[13] = var_2.SHIP_UPDATED
	GAME = var_2
	var_20_0[14] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_20_0[15] = var_2.MOD_BLUEPRINT_ANIM_LOCK
	GAME = var_2
	var_20_0[16] = var_2.PURSUING_RESET_DONE
	GAME = var_2
	var_20_0[17] = var_2.QUICK_EXCHANGE_BLUEPRINT_DONE
	GAME = var_2
	var_20_0[18] = var_2.FINISH_PHANTOM_QUEST_DONE

	return var_20_0
end

function var_0_1.handleNotification(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1:getName()
	local var_21_1 = arg_21_1
	local var_21_2 = arg_21_1.getBody(var_21_1)

	TechnologyProxy = var_21_1

	if var_21_0 == var_21_1.BLUEPRINT_UPDATED then
		var_1_10005 = arg_21_0.viewComponent

		var_4.updateShipBluePrintVO(var_1_10005, var_21_2)

		goto label_21_0
	end

	GAME = var_4

	if var_21_0 == var_4.EXCHANG_BLUEPRINT_DONE then
		var_1_10005 = arg_21_0.viewComponent

		var_4.clearSelected(var_1_10005)

		var_1_10005 = arg_21_0.viewComponent

		var_4.updateExchangeItems(var_1_10005)

		var_1_10005 = arg_21_0.viewComponent

		var_4.updateBuildInfo(var_1_10005)

		goto label_21_0
	end

	TaskProxy = var_4

	if var_21_0 ~= var_4.TASK_ADDED then
		TaskProxy = var_21_3

		if var_21_3.TASK_UPDATED ~= var_21_0 then
			TaskProxy = var_21_3

			if var_21_3.TASK_REMOVED ~= var_21_0 then
				TaskProxy = var_21_3

				local var_21_3

				if var_21_3.TASK_DELETE == var_21_0 then
					var_1_10005 = arg_21_0.viewComponent
					var_21_3 = var_21_3.setTaskVOs
					getProxy = var_1_10006
					TaskProxy = var_1_10007
					var_1_10007 = var_1_10006(var_1_10007)

					var_21_3(var_1_10005, var_1_10006.getTasksForBluePrint(var_1_10007))

					var_1_10005 = arg_21_0.viewComponent

					var_21_3.updateTaskList(var_1_10005)

					var_1_10005 = arg_21_0.viewComponent

					var_21_3.updateTasksProgress(var_1_10005)

					goto label_21_0
				end

				GAME = var_21_3

				if var_21_0 == var_21_3.SUBMIT_TASK_DONE then
					if arg_21_0.contextData.shipBluePrintVO then
						var_1_10006 = var_4

						if var_4.isDeving(var_1_10006) then
							var_1_10006 = var_4

							if var_4.isFinishedAllTasks(var_1_10006) then
								getProxy = var_1_10005
								TechnologyProxy = var_1_10006
								var_1_10007 = var_1_10005(var_1_10006)
								var_1_10008 = var_1_10005.getBluePrintById(var_1_10007, var_4.id)

								var_1_10006.finish(var_1_10008)

								var_1_10008 = var_1_10005

								var_1_10005.updateBluePrint(var_1_10008, var_1_10006)
							end
						end
					end

					goto label_21_0
				end

				GAME = var_4

				if var_21_0 ~= var_4.FINISH_SHIP_BLUEPRINT_DONE then
					GAME = var_21_4

					local var_21_4

					if var_21_0 == var_21_4.ITEM_LOCK_SHIP_BLUPRINT_DONE then
						var_1_10005 = arg_21_0
						var_21_4 = arg_21_0.addSubLayers
						Context = var_1_10006
						var_1_10006 = var_1_10006.New
						var_1_10007 = {}
						NewShipMediator = var_1_10008
						var_1_10007.mediator = var_1_10008
						NewShipLayer = var_1_10008
						var_1_10007.viewComponent = var_1_10008
						var_1_10007.data = {
							ship = var_21_2.ship,
							canSkipBatch = var_21_2.canSkipBatch
						}

						function var_1_10007.onRemoved()
							pg = var_2_10000

							local var_22_0 = var_2_10000.NewStoryMgr.GetInstance()

							var_0.Play(var_22_0, "FANGAN2", function()
								pg = var_3_10000

								local var_23_0 = var_3_10000.NewStoryMgr.GetInstance()

								if not var_0.IsPlayed(var_23_0, "PHANTOM_HELP") then
									pg = var_0

									local var_23_1 = var_0.NewGuideMgr.GetInstance()

									var_0.Play(var_23_1, "PHANTOM_HELP")

									pg = var_0

									local var_23_2 = var_0.m02
									local var_23_3 = var_0.sendNotification

									GAME = var_2

									var_23_3(var_23_2, var_2.STORY_UPDATE, {
										storyId = "PHANTOM_HELP"
									})
								end

								return
							end)

							return
						end

						var_21_4(var_1_10005, var_1_10006(var_1_10007))

						goto label_21_0
					end

					GAME = var_21_4

					if var_21_4.STOP_BLUEPRINT_DONE == var_21_0 then
						var_1_10005 = arg_21_0.viewComponent

						var_4.clearTimers(var_1_10005, var_21_2.id)

						goto label_21_0
					end

					GAME = var_4

					if var_4.MOD_BLUEPRINT_DONE == var_21_0 then
						var_1_10005 = arg_21_0.viewComponent

						var_4.doModAnim(var_1_10005, var_21_2.oldBluePrint, var_21_2.newBluePrint)

						var_1_10005 = arg_21_0.viewComponent

						var_4.updateAllPursuingCostTip(var_1_10005)

						goto label_21_0
					end

					BayProxy = var_4

					if var_21_0 ~= var_4.SHIP_ADDED then
						BayProxy = var_21_5

						do
							local var_21_5

							if var_21_5.SHIP_UPDATED == var_21_0 then
								getProxy = var_21_5
								BayProxy = var_1_10005
								var_21_5 = var_21_5(var_1_10005)
								var_1_10006 = arg_21_0.viewComponent

								var_5.setShipVOs(var_1_10006, var_21_5:getRawData())
							else
								GAME = var_21_5

								if var_21_5.BUILD_SHIP_BLUEPRINT_DONE == var_21_0 then
									local var_21_6 = arg_21_0.viewComponent

									var_4.buildStartAni(var_21_6, "researchStartWindow")
								else
									GAME = var_4

									local var_21_8

									if var_21_0 == var_4.BEGIN_STAGE_DONE then
										local var_21_7 = arg_21_0

										var_21_8 = arg_21_0.sendNotification
										GAME = var_1_10006
										var_1_10006 = var_1_10006.GO_SCENE
										SCENE = var_1_10007

										var_21_8(var_21_7, var_1_10006, var_1_10007.COMBATLOAD, var_21_2)
									else
										GAME = var_21_8

										local var_21_9

										if var_21_0 == var_21_8.MOD_BLUEPRINT_ANIM_LOCK then
											var_21_9 = arg_21_0.viewComponent
											var_21_9.noUpdateMod = true
										else
											GAME = var_21_9

											if var_21_0 == var_21_9.PURSUING_RESET_DONE then
												-- block empty
											else
												GAME = var_4

												local var_21_11

												if var_21_0 == var_4.QUICK_EXCHANGE_BLUEPRINT_DONE then
													local var_21_10 = arg_21_0.viewComponent

													var_21_11 = var_21_11.emit
													BaseUI = var_1_10006

													var_21_11(var_21_10, var_1_10006.ON_ACHIEVE, var_21_2, function()
														local var_24_0 = arg_21_0.viewComponent

														var_0.updateShipBluePrintVO(var_24_0)

														return
													end)
												else
													GAME = var_21_11

													if var_21_0 == var_21_11.FINISH_PHANTOM_QUEST_DONE then
														local var_21_12 = arg_21_0.viewComponent

														var_4.updatePhantomQuest(var_21_12)
													end
												end
											end
										end
									end
								end
							end
						end

						::label_21_0::

						return
					end
				end
			end
		end
	end
end

return var_0_1
