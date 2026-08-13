class = var_0_10000

local var_0_0 = "EducateMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateContextMediator"))

var_0_1.ON_DEFAULT_TARGET_SET = "EducateMediator:ON_DEFAULT_TARGET_SET"
var_0_1.ON_UPGRADE_FAVOR = "EducateMediator:ON_UPGRADE_FAVOR"
var_0_1.ON_SPECIAL_EVENT_TRIGGER = "EducateMediator:ON_SPECIAL_EVENT_TRIGGER"
var_0_1.ON_EVENT_TRIGGER = "EducateMediator:ON_EVENT_TRIGGER"
var_0_1.ON_GET_EVENT = "EducateMediator:ON_GET_EVENT"
var_0_1.ON_EXECTUE_PLANS = "EducateMediator:ON_EXECTUE_PLANS"
var_0_1.ON_ENDING_TRIGGER = "EducateMediator:ON_ENDING_TRIGGER"
var_0_1.ON_GAME_RESET = "EducateMediator:ON_GAME_RESET"
var_0_1.ENTER_VIRTUAL_STAGE = "EducateMediator.ENTER_VIRTUAL_STAGE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_DEFAULT_TARGET_SET, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.EDUCATE_SET_TARGET, {
			id = arg_2_1.id,
			callback = arg_2_1.callback
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPGRADE_FAVOR, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.EDUCATE_UPGRADE_FAVOR, {
			callback = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SPECIAL_EVENT_TRIGGER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.EDUCATE_TRIGGER_SPEC_EVENT, {
			eventId = arg_4_1.id,
			callback = arg_4_1.callback
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_EVENT_TRIGGER, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.EDUCATE_TRIGGER_EVENT, {
			eventId = arg_5_1.id,
			callback = arg_5_1.callback
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GET_EVENT, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.EDUCATE_GET_EVENTS, {
			callback = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_EXECTUE_PLANS, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.EDUCATE_EXECUTE_PLANS, {
			callback = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ENDING_TRIGGER, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_8_2 = var_2_10005.New
		local var_8_3 = {}

		EducateSelEndingMediator = var_2_10008
		var_8_3.mediator = var_2_10008
		EducateSelEndingLayer = var_2_10008
		var_8_3.viewComponent = var_2_10008

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_GAME_RESET, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.EDUCATE_RESET)

		return
	end)
	arg_1_0:bind(var_0_1.ENTER_VIRTUAL_STAGE, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0.viewComponent

		var_2.updateResPanel(var_10_0)

		local var_10_1 = arg_1_0.viewComponent

		var_2.updatePaintingUI(var_10_1)

		local var_10_2 = arg_1_0.viewComponent

		var_2.updateArchivePanel(var_10_2)

		local var_10_3 = arg_1_0.viewComponent

		var_2.PlayBGM(var_10_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	EducateProxy = var_1_10002
	var_11_0[1] = var_1_10002.RESOURCE_UPDATED
	EducateProxy = var_2
	var_11_0[2] = var_2.ATTR_UPDATED
	EducateProxy = var_2
	var_11_0[3] = var_2.TIEM_UPDATED
	EducateProxy = var_2
	var_11_0[4] = var_2.TIME_WEEKDAY_UPDATED
	EducateProxy = var_2
	var_11_0[5] = var_2.BUFF_ADDED
	EducateTaskProxy = var_2
	var_11_0[6] = var_2.TASK_UPDATED
	GAME = var_2
	var_11_0[7] = var_2.EDUCATE_UPGRADE_FAVOR_DONE
	GAME = var_2
	var_11_0[8] = var_2.EDUCATE_TRIGGER_SPEC_EVENT_DONE
	GAME = var_2
	var_11_0[9] = var_2.EDUCATE_TRIGGER_EVENT_DONE
	GAME = var_2
	var_11_0[10] = var_2.EDUCATE_SET_TARGET_DONE
	GAME = var_2
	var_11_0[11] = var_2.EDUCATE_TRIGGER_END_DONE
	GAME = var_2
	var_11_0[12] = var_2.EDUCATE_RESET_DONE
	GAME = var_2
	var_11_0[13] = var_2.EDUCATE_REFRESH_DONE
	GAME = var_2
	var_11_0[14] = var_2.EDUCATE_EXECUTE_PLANS_DONE
	GAME = var_2
	var_11_0[15] = var_2.EDUCATE_SUBMIT_TASK_DONE
	GAME = var_2
	var_11_0[16] = var_2.EDUCATE_GET_TARGET_AWARD_DONE
	EducateProxy = var_2
	var_11_0[17] = var_2.GUIDE_CHECK
	EducateProxy = var_2
	var_11_0[18] = var_2.MAIN_SCENE_ADD_LAYER
	EducateProxy = var_2
	var_11_0[19] = var_2.POLAROID_ADDED
	EducateProxy = var_2
	var_11_0[20] = var_2.MEMORY_ADDED
	EducateTaskProxy = var_2
	var_11_0[21] = var_2.TASK_ADDED
	EducateTaskProxy = var_2
	var_11_0[22] = var_2.TASK_REMOVED
	EducateProxy = var_2
	var_11_0[23] = var_2.CLEAR_NEW_TIP

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.getName(var_12_0)
	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.getBody(var_12_2)

	EducateProxy = var_12_0

	if var_12_1 == var_12_0.RESOURCE_UPDATED then
		local var_12_4 = arg_12_0.viewComponent

		var_4.updateResPanel(var_12_4)

		local var_12_5 = arg_12_0.viewComponent

		var_4.updateTargetPanel(var_12_5)

		goto label_12_0
	end

	EducateProxy = var_4

	if var_12_1 == var_4.ATTR_UPDATED then
		local var_12_6 = arg_12_0.viewComponent

		var_4.updateArchivePanel(var_12_6)

		local var_12_7 = arg_12_0.viewComponent

		var_4.updateTargetPanel(var_12_7)

		goto label_12_0
	end

	EducateProxy = var_4

	if var_12_1 == var_4.TIEM_UPDATED then
		local var_12_8 = arg_12_0.viewComponent

		var_4.updateDatePanel(var_12_8)

		local var_12_9 = arg_12_0.viewComponent

		var_4.updateTargetPanel(var_12_9)

		local var_12_10 = arg_12_0.viewComponent

		var_4.updatePaintingData(var_12_10)

		goto label_12_0
	end

	EducateProxy = var_4

	if var_12_1 == var_4.TIME_WEEKDAY_UPDATED then
		local var_12_11 = arg_12_0.viewComponent

		var_4.updateWeekDay(var_12_11, var_12_3.weekDay)

		goto label_12_0
	end

	EducateProxy = var_4

	if var_12_1 == var_4.BUFF_ADDED then
		local var_12_12 = arg_12_0.viewComponent

		var_4.updateArchivePanel(var_12_12)

		pg = var_4

		local var_12_13 = var_4.NewStoryMgr.GetInstance()

		if not var_4.IsPlayed(var_12_13, "tb_10") then
			local var_12_14 = arg_12_0.viewComponent

			var_4.showArchivePanel(var_12_14)
		end

		local var_12_15 = arg_12_0.viewComponent

		var_4.OnCheckGuide(var_12_15)

		goto label_12_0
	end

	EducateTaskProxy = var_4

	if var_12_1 == var_4.TASK_UPDATED then
		local var_12_16 = arg_12_0.viewComponent

		var_4.updateTargetPanel(var_12_16)

		goto label_12_0
	end

	GAME = var_4

	if var_12_1 == var_4.EDUCATE_UPGRADE_FAVOR_DONE then
		local var_12_17 = arg_12_0.viewComponent

		var_4.ShowFavorUpgrade(var_12_17, var_12_3.drops, var_12_3.performs, var_12_3.cb)

		goto label_12_0
	end

	GAME = var_4

	if var_12_1 == var_4.EDUCATE_TRIGGER_SPEC_EVENT_DONE then
		local var_12_18 = var_12_3.type

		EducateSpecialEvent = var_12_2

		if var_12_18 ~= var_12_2.TYPE_BUBBLE_MIND then
			var_12_18 = var_12_3.type
			EducateSpecialEvent = var_12_2

			if var_12_18 == var_12_2.TYPE_BUBBLE_DISCOUNT then
				local var_12_19 = arg_12_0.viewComponent

				var_12_18.ShowSpecialEvent(var_12_19, var_12_3.id, var_12_3.drops, var_12_3.cb)

				goto label_12_0

				GAME = var_12_18

				local var_12_20

				if var_12_1 == var_12_18.EDUCATE_TRIGGER_EVENT_DONE then
					pg = var_12_20
					var_12_20 = var_12_20.child_event[var_12_3.id].type
					EducateEvent = var_12_2

					if var_12_20 == var_12_2.TYPE_BUBBLE then
						var_1_10007 = arg_12_0.viewComponent

						var_12_2.ShowEvent(var_1_10007, var_12_3.id, var_12_3.drops, var_12_3.cb)
					end

					goto label_12_0
				end

				GAME = var_12_20

				local var_12_22

				if var_12_1 == var_12_20.EDUCATE_SET_TARGET_DONE then
					local var_12_21 = arg_12_0

					var_12_22 = arg_12_0.addSubLayers
					Context = var_1_10007
					var_1_10007 = var_1_10007.New

					local var_12_23 = {}

					EducateTargetMediator = var_1_10010
					var_12_23.mediator = var_1_10010
					EducateTargetLayer = var_1_10010
					var_12_23.viewComponent = var_1_10010

					var_12_22(var_12_21, var_1_10007(var_12_23))

					local var_12_24 = arg_12_0.viewComponent

					var_12_22.updateBottomPanel(var_12_24)

					local var_12_25 = arg_12_0.viewComponent

					var_12_22.updateDatePanel(var_12_25)

					local var_12_26 = arg_12_0.viewComponent

					var_12_22.updateTargetPanel(var_12_26)

					local var_12_27 = arg_12_0.viewComponent

					var_12_22.updateMindTip(var_12_27)

					local var_12_28 = arg_12_0.viewComponent

					var_12_22.OnCheckGuide(var_12_28)

					goto label_12_0
				end

				GAME = var_12_22

				if var_12_1 == var_12_22.EDUCATE_TRIGGER_END_DONE then
					local var_12_29 = arg_12_0.viewComponent

					var_4.updateBottomPanel(var_12_29)

					local var_12_30 = arg_12_0.viewComponent

					var_4.updateDatePanel(var_12_30)

					local var_12_31 = arg_12_0.viewComponent

					var_4.updateTargetPanel(var_12_31)

					local var_12_32 = arg_12_0.viewComponent

					var_4.updateMindTip(var_12_32)

					local var_12_33 = arg_12_0.viewComponent

					var_4.OnCheckGuide(var_12_33)

					goto label_12_0
				end

				GAME = var_4

				if var_12_1 ~= var_4.EDUCATE_RESET_DONE then
					GAME = var_12_35

					local var_12_35

					if var_12_1 == var_12_35.EDUCATE_REFRESH_DONE then
						local var_12_34 = arg_12_0.viewComponent

						var_12_35 = var_12_35.emit
						EducateBaseUI = var_1_10007

						local var_12_36 = var_1_10007.EDUCATE_CHANGE_SCENE

						SCENE = var_1_10008

						var_12_35(var_12_34, var_12_36, var_1_10008.EDUCATE)

						goto label_12_0
					end

					GAME = var_12_35

					local var_12_37

					if var_12_1 == var_12_35.EDUCATE_EXECUTE_PLANS_DONE then
						var_12_37 = var_12_3.isSkip
						var_12_2 = var_12_3.isSkipEvent

						arg_12_0:playPlansPerform(var_12_37, var_12_2, var_12_3)

						goto label_12_0
					end

					GAME = var_12_37

					if var_12_1 == var_12_37.EDUCATE_SUBMIT_TASK_DONE then
						local var_12_38 = arg_12_0.viewComponent

						var_4.updateTargetPanel(var_12_38)

						local var_12_39 = arg_12_0.viewComponent

						var_4.updateMindTip(var_12_39)

						goto label_12_0
					end

					GAME = var_4

					if var_12_1 == var_4.EDUCATE_GET_TARGET_AWARD_DONE then
						local var_12_40 = arg_12_0.viewComponent

						var_4.updateTargetPanel(var_12_40)

						goto label_12_0
					end

					EducateProxy = var_4

					if var_12_1 == var_4.GUIDE_CHECK then
						if var_12_3.view == arg_12_0.viewComponent.__cname then
							local var_12_41 = arg_12_0.viewComponent

							var_4.OnCheckGuide(var_12_41, function()
								if var_12_3.popActivityWindow == true then
									getProxy = var_0
									EducateProxy = var_2_10002

									local var_13_0 = var_0(var_2_10002)

									if var_0.IsFirstGame(var_13_0) == 1 then
										local var_13_1 = arg_12_0
										local var_13_2 = var_0.addSubLayers

										Context = var_2_10003

										local var_13_3 = var_2_10003.New
										local var_13_4 = {}

										CultivatingPlantMediator = var_2_10006
										var_13_4.mediator = var_2_10006
										CultivatingPlantScene = var_2_10006
										var_13_4.viewComponent = var_2_10006

										local var_13_5 = {}

										getProxy = var_2_10007
										EducateProxy = var_2_10009

										local var_13_6 = var_2_10007(var_2_10009)

										var_13_5.id = var_7.GetCharData(var_13_6).id
										var_13_4.data = var_13_5

										var_13_2(var_13_1, var_13_3(var_13_4))
									end
								end

								return
							end)
						end

						goto label_12_0
					end

					EducateProxy = var_4

					if var_12_1 == var_4.MAIN_SCENE_ADD_LAYER then
						arg_12_0:addSubLayers(var_12_3)

						goto label_12_0
					end

					EducateProxy = var_4

					if var_12_1 ~= var_4.POLAROID_ADDED then
						EducateProxy = var_4

						if var_12_1 == var_4.MEMORY_ADDED then
							local var_12_42 = arg_12_0.viewComponent

							var_4.updateBookNewTip(var_12_42)

							goto label_12_0
						end

						EducateTaskProxy = var_4

						if var_12_1 ~= var_4.TASK_ADDED then
							EducateTaskProxy = var_4

							if var_12_1 == var_4.TASK_REMOVED then
								local var_12_43 = arg_12_0.viewComponent

								var_4.updateMindNewTip(var_12_43)

								local var_12_44 = arg_12_0.viewComponent

								var_4.updateTargetPanel(var_12_44)

								goto label_12_0
							end

							EducateProxy = var_4

							if var_12_1 == var_4.CLEAR_NEW_TIP then
								local var_12_45 = var_12_3.index

								EducateTipHelper = var_12_2

								if var_12_45 ~= var_12_2.NEW_MEMORY then
									do
										local var_12_46 = var_12_3.index

										EducateTipHelper = var_5

										if var_12_46 == var_5.NEW_POLAROID then
											local var_12_47 = arg_12_0.viewComponent

											var_4.updateBookNewTip(var_12_47)
										else
											local var_12_48 = var_12_3.index

											EducateTipHelper = var_5

											if var_12_48 == var_5.NEW_MIND_TASK then
												local var_12_49 = arg_12_0.viewComponent

												var_4.updateMindNewTip(var_12_49)
											end
										end
									end

									::label_12_0::

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

function var_0_1.playPlansPerform(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}

	table = var_1_10005

	var_1_10005.insert(var_14_0, function(arg_15_0)
		local var_15_0 = arg_14_0
		local var_15_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_15_2 = var_2_10004.New
		local var_15_3 = {}

		EducateCalendarLayer = var_2_10007
		var_15_3.viewComponent = var_2_10007
		EducateCalendarMediator = var_2_10007
		var_15_3.mediator = var_2_10007
		var_15_3.data = {
			onExit = arg_15_0
		}

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)

	if not arg_14_1 or not arg_14_2 then
		table = var_5

		var_5.insert(var_14_0, function(arg_16_0)
			local var_16_0 = arg_14_0
			local var_16_1 = var_1.addSubLayers

			Context = var_2_10004

			local var_16_2 = var_2_10004.New
			local var_16_3 = {}

			EducateSchedulePerformLayer = var_2_10007
			var_16_3.viewComponent = var_2_10007
			EducateSchedulePerformMediator = var_2_10007
			var_16_3.mediator = var_2_10007
			var_16_3.data = {
				gridData = arg_14_3.gridData,
				plan_results = arg_14_3.plan_results,
				events = arg_14_3.events,
				skip = arg_14_1,
				skipEvent = arg_14_2,
				onExit = arg_16_0
			}

			var_16_1(var_16_0, var_16_2(var_16_3))

			return
		end)
	end

	table = var_5

	var_5.insert(var_14_0, function(arg_17_0)
		local var_17_0 = arg_14_0
		local var_17_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_17_2 = var_2_10004.New
		local var_17_3 = {}

		EducateScheduleResultLayer = var_2_10007
		var_17_3.viewComponent = var_2_10007
		EducateScheduleResultMediator = var_2_10007
		var_17_3.mediator = var_2_10007
		var_17_3.data = {
			plan_results = arg_14_3.plan_results,
			onExit = arg_17_0
		}

		var_17_1(var_17_0, var_17_2(var_17_3))

		return
	end)

	seriesAsync = var_5

	var_5(var_14_0, function()
		local var_18_0 = arg_14_0.viewComponent

		var_0.FlushView(var_18_0)

		return
	end)

	return
end

return var_0_1
