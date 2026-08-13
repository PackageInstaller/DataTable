class = var_0_10000

local var_0_0 = "TaskMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_TASK_SUBMIT = "TaskMediator:ON_TASK_SUBMIT"
var_0_1.ON_TASK_GO = "TaskMediator:ON_TASK_GO"
var_0_1.TASK_FILTER = "TaskMediator:TASK_FILTER"
var_0_1.ON_SUBMIT_AVATAR_TASK = "TaskMediator:ON_SUBMIT_AVATAR_TASK"
var_0_1.ON_SUBMIT_WEEK_PROGREE = "TaskMediator:ON_SUBMIT_WEEK_PROGREE"
var_0_1.ON_BATCH_SUBMIT_WEEK_TASK = "TaskMediator:ON_BATCH_SUBMIT_WEEK_TASK"
var_0_1.ON_SUBMIT_WEEK_TASK = "TaskMediator:ON_SUBMIT_WEEK_TASK"
var_0_1.CLICK_GET_ALL = "TaskMediator:CLICK_GET_ALL"
var_0_1.ON_DROP = "TaskMediator:ON_DROP"
var_0_1.STORE_ACTIVITY_AWARDS = "TaskMediator:STORE_ACTIVITY_AWARDS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SUBMIT_WEEK_TASK, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.SUBMIT_WEEK_TASK, {
			id = arg_2_1.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_AVATAR_TASK, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_3_1:getActId(),
			task_ids = {
				arg_3_1.id
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUBMIT_WEEK_PROGREE, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.SUBMIT_WEEK_TASK_PROGRESS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BATCH_SUBMIT_WEEK_TASK, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.BATCH_SUBMIT_WEEK_TASK, {
			ids = arg_5_1,
			callback = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_DROP, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_6_1.type

		DROP_TYPE_EQUIP = var_2_10004

		if var_6_0 == var_2_10004 then
			var_2_10004 = arg_1_0

			local var_6_1 = var_3.addSubLayers

			Context = var_2_10005
			var_2_10005 = var_2_10005.New
			var_2_10006 = {}
			EquipmentInfoMediator = var_2_10007
			var_2_10006.mediator = var_2_10007
			EquipmentInfoLayer = var_2_10007
			var_2_10006.viewComponent = var_2_10007
			var_2_10007 = {
				equipmentId = arg_6_1:getConfig("id")
			}
			EquipmentInfoMediator = var_8
			var_2_10007.type = var_8.TYPE_DISPLAY
			var_2_10007.onRemoved = arg_6_2
			var_2_10006.data = var_2_10007

			var_6_1(var_2_10004, var_2_10005(var_2_10006))
		else
			local var_6_2 = arg_6_1.type

			DROP_TYPE_SPWEAPON = var_2_10004

			if var_6_2 == var_2_10004 then
				local var_6_3 = arg_1_0

				var_6_2 = var_6_2.addSubLayers
				Context = var_2_10005

				local var_6_4 = var_2_10005.New

				var_2_10006 = {}
				SpWeaponInfoMediator = var_2_10007
				var_2_10006.mediator = var_2_10007
				SpWeaponInfoLayer = var_2_10007
				var_2_10006.viewComponent = var_2_10007

				local var_6_5 = {
					spWeaponConfigId = arg_6_1:getConfig("id")
				}

				SpWeaponInfoLayer = var_8
				var_6_5.type = var_8.TYPE_DISPLAY
				var_6_5.onRemoved = arg_6_2
				var_2_10006.data = var_6_5

				var_6_2(var_6_3, var_6_4(var_2_10006))
			else
				pg = var_6_2

				local var_6_6 = var_6_2.MsgboxMgr.GetInstance()
				local var_6_7 = var_3.ShowMsgBox
				local var_6_8 = {}

				MSGBOX_TYPE_SINGLE_ITEM = var_2_10006
				var_6_8.type = var_2_10006
				var_6_8.drop = arg_6_1
				var_6_8.onNo = arg_6_2
				var_6_8.onYes = arg_6_2

				var_6_7(var_6_6, var_6_8)
			end
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10003

		local var_7_0 = var_2_10002(var_2_10003)
		local var_7_1 = var_2.getActivityById

		ActivityConst = var_2_10005

		if var_7_1(var_7_0, var_2_10005.JYHZ_ACTIVITY_ID) then
			local var_7_2 = var_3
			local var_7_3 = var_3.getConfig(var_7_2, "config_data")

			_ = var_7_2

			local var_7_4 = var_7_2.flatten(var_7_3)

			if arg_7_1.id == var_7_4[#var_7_4] then
				pg = var_2_10006

				local var_7_5 = var_2_10006.NewStoryMgr.GetInstance()

				var_2_10006.Play(var_7_5, "YIXIAN8", function()
					local var_8_0 = arg_1_0
					local var_8_1 = var_0.sendNotification

					GAME = var_3_10002

					var_8_1(var_8_0, var_3_10002.SUBMIT_TASK, arg_7_1.id)

					return
				end)

				return
			end
		end

		if arg_7_1.index then
			local var_7_6 = arg_1_0
			local var_7_7 = var_4.sendNotification

			GAME = var_2_10006

			var_7_7(var_7_6, var_2_10006.SUBMIT_TASK, {
				taskId = arg_7_1.id,
				index = arg_7_1.index
			})
		else
			local var_7_8 = arg_1_0
			local var_7_9 = var_4.sendNotification

			GAME = var_2_10006

			var_7_9(var_7_8, var_2_10006.SUBMIT_TASK, arg_7_1.id)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10004

		var_9_1(var_9_0, var_2_10004.TASK_GO, {
			taskVO = arg_9_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.STORE_ACTIVITY_AWARDS, function(arg_10_0, arg_10_1)
		arg_1_0.storeActivityAwardFlag = arg_10_1

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.SetTaskVOs(var_1_0)

	getProxy = var_1
	TaskProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_2.SetWeekTaskProgressInfo(var_1_2, var_1_1:GetWeekTaskProgressInfo())

	return
end

function var_0_1.SetTaskVOs(arg_11_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.getData(var_11_0)

	getProxy = var_11_0
	BagProxy = var_1_10004

	local var_11_2 = var_11_0(var_1_10004)

	pairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_11_1) do
		local var_11_3 = iter_11_1
		local var_11_4 = iter_11_1.getConfig(var_11_3, "sub_type")

		TASK_SUB_TYPE_GIVE_ITEM = var_11_3

		if var_11_4 == var_11_3 then
			tonumber = var_11_4

			local var_11_5 = var_11_4(iter_11_1:getConfig("target_id"))
			local var_11_6 = var_11_2
			local var_11_7 = var_11_2.getItemCountById

			tonumber = var_12
			iter_11_1.progress = var_11_7(var_11_6, var_12(var_11_5))
		else
			local var_11_8 = iter_11_1
			local var_11_9 = iter_11_1.getConfig(var_11_8, "sub_type")

			TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_11_8

			if var_11_9 == var_11_8 then
				tonumber = var_11_9

				local var_11_10 = iter_11_1
				local var_11_11 = var_11_9(iter_11_1.getConfig(var_11_10, "target_id"))

				getProxy = var_10
				ActivityProxy = var_11_10

				local var_11_12 = var_10(var_11_10)

				iter_11_1.progress = var_10.getVirtualItemNumber(var_11_12, var_11_11)
			end
		end
	end

	local var_11_13 = arg_11_0.viewComponent

	var_4.setTaskVOs(var_11_13, var_11_1)

	return
end

function var_0_1.enterLevel(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10003

	local var_12_0 = var_1_10002(var_1_10003)

	if var_2.getChapterById(var_12_0, arg_12_1) then
		local var_12_1 = {
			mapIdx = var_3:getConfig("map")
		}

		if var_3.active then
			var_12_1.chapterId = var_3.id
		else
			var_12_1.openChapterId = arg_12_1
		end

		local var_12_2 = arg_12_0
		local var_12_3 = arg_12_0.sendNotification

		GAME = var_7

		local var_12_4 = var_7.GO_SCENE

		SCENE = var_1_10008

		var_12_3(var_12_2, var_12_4, var_1_10008.LEVEL, var_12_1)
	end

	return
end

function var_0_1.listNotificationInterests(arg_13_0)
	local var_13_0 = {}

	TaskProxy = var_1_10002
	var_13_0[1] = var_1_10002.TASK_ADDED
	TaskProxy = var_2
	var_13_0[2] = var_2.TASK_UPDATED
	TaskProxy = var_2
	var_13_0[3] = var_2.TASK_REMOVED
	TaskProxy = var_2
	var_13_0[4] = var_2.TASK_DELETE
	GAME = var_2
	var_13_0[5] = var_2.SUBMIT_TASK_DONE
	var_13_0[6] = var_0_1.TASK_FILTER
	GAME = var_2
	var_13_0[7] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_13_0[8] = var_2.CHAPTER_OP_DONE
	TaskProxy = var_2
	var_13_0[9] = var_2.WEEK_TASK_UPDATED
	TaskProxy = var_2
	var_13_0[10] = var_2.WEEK_TASKS_ADDED
	TaskProxy = var_2
	var_13_0[11] = var_2.WEEK_TASKS_DELETED
	GAME = var_2
	var_13_0[12] = var_2.SUBMIT_WEEK_TASK_DONE
	GAME = var_2
	var_13_0[13] = var_2.SUBMIT_WEEK_TASK_PROGRESS_DONE
	GAME = var_2
	var_13_0[14] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_13_0[15] = var_2.SUBMIT_AVATAR_TASK_DONE
	TaskProxy = var_2
	var_13_0[16] = var_2.WEEK_TASK_RESET
	GAME = var_2
	var_13_0[17] = var_2.MERGE_TASK_ONE_STEP_AWARD_DONE
	AvatarFrameProxy = var_2
	var_13_0[18] = var_2.FRAME_TASK_TIME_OUT

	return var_13_0
end

function var_0_1.handleNotification(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1
	local var_14_2 = arg_14_1.getBody(var_14_1)

	TaskProxy = var_14_1

	local var_14_4

	if var_14_0 == var_14_1.TASK_ADDED then
		local var_14_3 = var_14_2

		var_14_4 = var_14_2.getConfig(var_14_3, "sub_type")
		TASK_SUB_TYPE_GIVE_ITEM = var_14_3

		if var_14_4 == var_14_3 then
			tonumber = var_14_4
			var_1_10006 = var_14_2
			var_14_4 = var_14_4(var_14_2.getConfig(var_1_10006, "target_id"))
			getProxy = var_5
			BagProxy = var_1_10006
			var_1_10006 = var_5(var_1_10006)

			local var_14_5 = var_5.getItemCountById

			tonumber = var_1_10007
			var_14_2.progress = var_14_5(var_1_10006, var_1_10007(var_14_4))
		else
			local var_14_6 = var_14_2

			var_14_4 = var_14_2.getConfig(var_14_6, "sub_type")
			TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_14_6

			if var_14_4 == var_14_6 then
				tonumber = var_14_4
				var_1_10006 = var_14_2
				var_14_4 = var_14_4(var_14_2.getConfig(var_1_10006, "target_id"))
				getProxy = var_5
				ActivityProxy = var_1_10006
				var_1_10006 = var_5(var_1_10006)
				var_14_2.progress = var_5.getVirtualItemNumber(var_1_10006, var_14_4)
			end
		end

		local var_14_7 = arg_14_0.viewComponent

		var_14_4.addTask(var_14_7, var_14_2)

		goto label_14_0
	end

	GAME = var_14_4

	if var_14_0 == var_14_4.CHAPTER_OP_DONE then
		if arg_14_0.chapterId then
			arg_14_0:enterLevel(arg_14_0.chapterId)

			arg_14_0.chapterId = nil
		end

		goto label_14_0
	end

	TaskProxy = var_4

	local var_14_9

	if var_14_0 == var_4.TASK_UPDATED then
		local var_14_8 = var_14_2

		var_14_9 = var_14_2.getConfig(var_14_8, "sub_type")
		TASK_SUB_TYPE_GIVE_ITEM = var_14_8

		if var_14_9 == var_14_8 then
			tonumber = var_14_9
			var_1_10006 = var_14_2
			var_14_9 = var_14_9(var_14_2.getConfig(var_1_10006, "target_id"))
			getProxy = var_5
			BagProxy = var_1_10006
			var_1_10006 = var_5(var_1_10006)

			local var_14_10 = var_5.getItemCountById

			tonumber = var_1_10007
			var_14_2.progress = var_14_10(var_1_10006, var_1_10007(var_14_9))
		else
			local var_14_11 = var_14_2

			var_14_9 = var_14_2.getConfig(var_14_11, "sub_type")
			TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_14_11

			if var_14_9 == var_14_11 then
				tonumber = var_14_9
				var_1_10006 = var_14_2
				var_14_9 = var_14_9(var_14_2.getConfig(var_1_10006, "target_id"))
				getProxy = var_5
				ActivityProxy = var_1_10006
				var_1_10006 = var_5(var_1_10006)
				var_14_2.progress = var_5.getVirtualItemNumber(var_1_10006, var_14_9)
			end
		end

		local var_14_12 = arg_14_0.viewComponent

		var_14_9.updateTask(var_14_12, var_14_2)

		goto label_14_0
	end

	TaskProxy = var_14_9

	if var_14_0 ~= var_14_9.TASK_REMOVED then
		TaskProxy = var_4

		if var_14_0 == var_4.TASK_DELETE then
			local var_14_13 = arg_14_0.viewComponent

			var_4.removeTask(var_14_13, var_14_2)

			goto label_14_0
		end

		if var_14_0 == var_0_1.TASK_FILTER then
			local var_14_14 = arg_14_0.viewComponent

			var_4.GoToFilter(var_14_14, var_14_2)

			goto label_14_0
		end

		GAME = var_4

		local var_14_15

		if var_14_0 == var_4.SUBMIT_TASK_DONE then
			var_14_15 = arg_14_1:getType()

			local var_14_16 = var_14_2

			getProxy = var_1_10006
			TaskProxy = var_1_10007
			var_1_10006 = var_1_10006(var_1_10007)
			var_1_10007 = arg_14_0.viewComponent
			var_1_10007.onShowAwards = true

			if arg_14_0.activityAwards and #arg_14_0.activityAwards > 0 then
				ipairs = var_1_10007

				for iter_14_0, iter_14_1 in var_1_10007(arg_14_0.activityAwards) do
					table = var_1_10012

					var_1_10012.insert(var_14_16, iter_14_1)
				end

				arg_14_0.activityAwards = {}
			end

			arg_14_0:addAwardShow(var_14_16, function()
				arg_14_0.viewComponent.onShowAwards = nil

				local var_15_0 = arg_14_0

				var_0.accepetActivityTask(var_15_0)

				local var_15_1 = arg_14_0.viewComponent

				var_0.refreshPage(var_15_1)

				local var_15_2 = arg_14_0.viewComponent

				var_0.updateOneStepBtn(var_15_2)

				local var_15_3 = {}

				ipairs = var_15_2

				for iter_15_0, iter_15_1 in var_15_2(var_14_15) do
					table = var_2_10006

					var_2_10006.insert(var_15_3, function(arg_16_0)
						local var_16_0 = arg_14_0

						var_1.PlayStoryForTaskAct(var_16_0, iter_15_1, arg_16_0)

						return
					end)
				end

				local var_15_5

				if arg_14_0.refreshWeekTaskPageFlag then
					local var_15_4 = arg_14_0.viewComponent

					var_15_5.RefreshWeekTaskPage(var_15_4)

					var_15_5 = arg_14_0
					var_15_5.refreshWeekTaskPageFlag = nil
				end

				table = var_15_5

				var_15_5.insert(var_15_3, function(arg_17_0)
					getProxy = var_3_10001
					FeastProxy = var_3_10002

					local var_17_0 = var_3_10001(var_3_10002)

					var_1.HandleTaskStories(var_17_0, var_14_15, arg_17_0)

					return
				end)

				if #var_15_3 > 0 then
					seriesAsync = var_1

					var_1(var_15_3)
				end

				return
			end)

			goto label_14_0
		end

		GAME = var_14_15

		local var_14_18

		if var_14_0 == var_14_15.BEGIN_STAGE_DONE then
			local var_14_17 = arg_14_0

			var_14_18 = arg_14_0.sendNotification
			GAME = var_1_10006
			var_1_10006 = var_1_10006.GO_SCENE
			SCENE = var_1_10007

			var_14_18(var_14_17, var_1_10006, var_1_10007.COMBATLOAD, var_14_2)

			goto label_14_0
		end

		TaskProxy = var_14_18

		if var_14_0 ~= var_14_18.WEEK_TASKS_ADDED then
			TaskProxy = var_4

			if var_14_0 ~= var_4.WEEK_TASKS_DELETED then
				TaskProxy = var_4

				if var_14_0 == var_4.WEEK_TASK_UPDATED then
					local var_14_19 = arg_14_0.viewComponent

					var_4.RefreshWeekTaskPage(var_14_19)

					goto label_14_0
				end

				GAME = var_4

				local var_14_21

				if var_14_0 == var_4.SUBMIT_WEEK_TASK_DONE then
					local var_14_20 = arg_14_0.viewComponent

					var_14_21.RefreshWeekTaskPageBefore(var_14_20, var_14_2.id)

					function var_14_21()
						local var_18_0 = arg_14_0.viewComponent

						var_0.RefreshWeekTaskPage(var_18_0)

						return
					end

					local var_14_22 = #var_14_2.awards

					if 0 < var_14_22 then
						var_1_10006 = arg_14_0.viewComponent

						local var_14_23 = var_5.emit

						BaseUI = var_1_10007

						var_14_23(var_1_10006, var_1_10007.ON_ACHIEVE, var_14_2.awards, var_14_21)
					else
						var_14_21()
					end

					goto label_14_0
				end

				GAME = var_14_21

				local var_14_24

				if var_14_0 == var_14_21.SUBMIT_WEEK_TASK_PROGRESS_DONE then
					function var_14_24()
						local var_19_0 = arg_14_0.viewComponent

						var_0.RefreshWeekTaskProgress(var_19_0)

						return
					end

					local var_14_25 = #var_14_2.awards

					if 0 < var_14_25 then
						var_1_10006 = arg_14_0.viewComponent

						local var_14_26 = var_5.emit

						BaseUI = var_1_10007

						var_14_26(var_1_10006, var_1_10007.ON_ACHIEVE, var_14_2.awards, var_14_24)
					else
						var_14_24()
					end

					goto label_14_0
				end

				GAME = var_14_24

				if var_14_0 ~= var_14_24.SUBMIT_AVATAR_TASK_DONE then
					GAME = var_14_27

					do
						local var_14_27

						if var_14_0 == var_14_27.SUBMIT_ACTIVITY_TASK_DONE then
							function var_14_27()
								local var_20_0 = arg_14_0.viewComponent

								var_0.refreshPage(var_20_0)

								arg_14_0.refreshWeekTaskPageFlag = true

								return
							end

							local var_14_28 = #var_14_2.awards

							if 0 < var_14_28 then
								if arg_14_0.storeActivityAwardFlag then
									if not arg_14_0.activityAwards then
										arg_14_0.activityAwards = {}
									end

									ipairs = var_5

									for iter_14_2, iter_14_3 in var_5(var_14_2.awards) do
										table = iter_14_0

										iter_14_0.insert(arg_14_0.activityAwards, iter_14_3)
									end
								else
									var_1_10006 = arg_14_0

									arg_14_0.addAwardShow(var_1_10006, var_14_2.awards, var_14_27)
								end
							else
								var_14_27()
							end
						else
							TaskProxy = var_14_27

							if var_14_0 == var_14_27.WEEK_TASK_RESET then
								arg_14_0:SetTaskVOs()

								local var_14_29 = arg_14_0.viewComponent

								var_4.ResetWeekTaskPage(var_14_29)
							else
								GAME = var_4

								local var_14_31

								if var_14_0 == var_4.MERGE_TASK_ONE_STEP_AWARD_DONE then
									arg_14_0.refreshWeekTaskPageFlag = true

									local var_14_30 = arg_14_0

									var_14_31 = arg_14_0.sendNotification
									GAME = var_1_10006

									var_14_31(var_14_30, var_1_10006.SUBMIT_TASK_DONE, var_14_2.awards, var_14_2.taskIds)
								else
									AvatarFrameProxy = var_14_31

									if var_14_0 == var_14_31.FRAME_TASK_TIME_OUT then
										local var_14_32 = arg_14_0.viewComponent

										var_4.refreshPage(var_14_32)
									end
								end
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

function var_0_1.addAwardShow(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1 or #arg_21_1 == 0 then
		return
	end

	if not arg_21_0.awardsShowList then
		arg_21_0.awardsShowList = {}
	end

	table = var_3

	var_3.insert(arg_21_0.awardsShowList, {
		awards = arg_21_1,
		callback = arg_21_2
	})

	if arg_21_0.isShowAwardFlag then
		return
	else
		arg_21_0:showAwardList()
	end

	return
end

function var_0_1.showAwardList(arg_22_0)
	if arg_22_0.isShowAwardFlag then
		return
	end

	if arg_22_0.awardsShowList and #arg_22_0.awardsShowList > 0 then
		arg_22_0.isShowAwardFlag = true
		table = var_1

		local var_22_0 = var_1.remove(arg_22_0.awardsShowList, 1)
		local var_22_1 = arg_22_0.viewComponent
		local var_22_2 = var_2.emit

		BaseUI = var_1_10004

		var_22_2(var_22_1, var_1_10004.ON_ACHIEVE, var_22_0.awards, function()
			if var_22_0.callback then
				var_22_0.callback()
			end

			arg_22_0.isShowAwardFlag = false

			local var_23_0 = arg_22_0

			var_0.showAwardList(var_23_0)

			return
		end)
	end

	return
end

function var_0_1.accepetActivityTask(arg_24_0)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.sendNotification

	GAME = var_1_10003

	var_24_1(var_24_0, var_1_10003.ACCEPT_ACTIVITY_TASK)

	return
end

function var_0_1.PlayStoryForTaskAct(arg_25_0, arg_25_1, arg_25_2)
	getProxy = var_1_10003
	ActivityProxy = var_1_10004

	local var_25_0 = var_1_10003(var_1_10004)
	local var_25_1 = var_3.getActivitiesByType

	ActivityConst = var_1_10005

	local var_25_2 = var_25_1(var_25_0, var_1_10005.ACTIVITY_TYPE_TASK_LIST)
	local var_25_3

	ipairs = var_5

	for iter_25_0, iter_25_1 in var_5(var_25_2) do
		if iter_25_1 and not iter_25_1:isEnd() then
			local var_25_4 = iter_25_1:getConfig("config_data")
			local var_25_5 = 0
			local var_25_6 = 0

			ipairs = var_1_10013

			for iter_25_2, iter_25_3 in var_1_10013(var_25_4) do
				ipairs = var_1_10018

				for iter_25_4, iter_25_5 in var_1_10018(iter_25_3) do
					if iter_25_5 == arg_25_1 then
						var_25_5 = iter_25_2
						var_25_6 = iter_25_4
					end
				end
			end

			if not iter_25_1:getConfig("config_client").story then
				var_1_10013 = {}
			end

			if var_1_10013[var_25_5] and var_1_10013[var_25_5][var_25_6] then
				pg = var_15

				local var_25_7 = var_15.NewStoryMgr.GetInstance()

				if not var_15.IsPlayed(var_25_7, var_14) then
					var_25_3 = var_14
				end
			end
		end
	end

	if var_25_3 then
		pg = var_5

		local var_25_8 = var_5.NewStoryMgr.GetInstance()

		var_5.Play(var_25_8, var_25_3, arg_25_2)
	else
		arg_25_2()
	end

	return
end

return var_0_1
