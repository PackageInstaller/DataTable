class = var_0_10000

local var_0_0 = var_0_10000("MainRequestActDataSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	arg_1_0:RequestReturnAwardAct()
	arg_1_0:RequestActivityTask()
	arg_1_0:RequestColoring()
	arg_1_0:RequestMetaData()
	arg_1_0:RequestManualSignAct()
	arg_1_0:RequestRandomDailyTask()
	arg_1_0:RequestDALDailyTask()
	arg_1_0:RequestStoryAutoUnlock()
	arg_1_1()

	return
end

function var_0_0.RequestReturnAwardAct(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_2_1(var_2_0, var_1_10003.ACTIVITY_TYPE_RETURN_AWARD) and not var_1:isEnd() and (var_1.data1 == 0 or var_1.data1 == 1 and var_1.data2 == 0) then
		pg = var_2

		local var_2_2 = var_2.m02
		local var_2_3 = var_2.sendNotification

		GAME = var_1_10004

		local var_2_4 = var_1_10004.RETURN_AWARD_OP
		local var_2_5 = {
			activity_id = var_1.id
		}

		ActivityConst = var_1_10006
		var_2_5.cmd = var_1_10006.RETURN_AWARD_OP_ACTIVTION

		var_2_3(var_2_2, var_2_4, var_2_5)
	end

	if var_1 and not var_2:isEnd() then
		if var_2:ShouldAcceptTasks() and var_2:IsInviter() then
			pg = var_4

			local var_2_6 = var_4.m02
			local var_2_7 = var_4.sendNotification

			GAME = var_1_10006
			var_1_10006 = var_1_10006.RETURN_AWARD_OP

			local var_2_8 = {
				activity_id = var_2.id
			}

			ActivityConst = var_8
			var_2_8.cmd = var_8.RETURN_AWARD_OP_ACCEPT_TASK

			var_2_7(var_2_6, var_1_10006, var_2_8)
		elseif var_3 and var_2:IsReturner() then
			pg = var_4

			local var_2_9 = var_4.m02
			local var_2_10 = var_4.sendNotification

			GAME = var_1_10006

			local var_2_11 = var_1_10006.RETURN_AWARD_OP
			local var_2_12 = {
				activity_id = var_2.id
			}

			ActivityConst = var_8
			var_2_12.cmd = var_8.RETURN_AWARD_OP_RETURNER_GET_AWARD

			var_2_10(var_2_9, var_2_11, var_2_12)
		end
	end

	return
end

function var_0_0.RequestActivityTask(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_3_0 = var_1_10001(var_1_10002)

	_ = var_1_10002

	local var_3_1 = var_1_10002.each
	local var_3_2 = var_3_0
	local var_3_3 = var_3_0.getActivitiesByTypes
	local var_3_4 = {}

	ActivityConst = var_1_10006
	var_3_4[1] = var_1_10006.ACTIVITY_TYPE_TASK_LIST
	ActivityConst = var_6
	var_3_4[2] = var_6.ACTIVITY_TYPE_TASK_RES

	var_3_1(var_3_3(var_3_2, var_3_4), function(arg_4_0)
		if not arg_4_0:isEnd() then
			updateActivityTaskStatus = var_1

			var_1(arg_4_0)
		end

		return
	end)

	underscore = var_3_1

	local var_3_5 = var_3_1.each
	local var_3_6 = var_3_0
	local var_3_7 = var_3_0.getActivitiesByTypes
	local var_3_8 = {}

	ActivityConst = var_6
	var_3_8[1] = var_6.ACTIVITY_TYPE_PT_CRUSING

	var_3_5(var_3_7(var_3_6, var_3_8), function(arg_5_0)
		if not arg_5_0:isEnd() then
			updateCrusingActivityTask = var_1

			var_1(arg_5_0)
		end

		return
	end)

	return
end

function var_0_0.RequestColoring(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_6_1(var_6_0, var_1_10003.ACTIVITY_TYPE_COLORING_ALPHA) and not var_1:isEnd() then
		pg = var_2

		local var_6_2 = var_2.m02
		local var_6_3 = var_2.sendNotification

		GAME = var_1_10004

		var_6_3(var_6_2, var_1_10004.COLORING_FETCH, {
			activityId = var_1.id
		})
	end

	return
end

function var_0_0.RequestMetaData(arg_7_0)
	getProxy = var_1_10001
	MetaCharacterProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	var_1.requestMetaTacticsInfo(var_7_0)

	return
end

function var_0_0.RequestManualSignAct(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.getRawData(var_8_0)

	pairs = var_8_0

	for iter_8_0, iter_8_1 in var_8_0(var_8_1) do
		local var_8_2 = iter_8_1
		local var_8_3 = iter_8_1.getConfig(var_8_2, "type")

		ActivityConst = var_8_2

		if var_8_3 == var_8_2.ACTIVITY_TYPE_MANUAL_SIGN and not iter_8_1:TodayIsSigned() then
			pg = var_7

			local var_8_4 = var_7.m02
			local var_8_5 = var_7.sendNotification

			GAME = var_9

			local var_8_6 = var_9.ACT_MANUAL_SIGN
			local var_8_7 = {
				activity_id = iter_8_1.id
			}

			ManualSignActivity = var_11
			var_8_7.cmd = var_11.OP_SIGN

			var_8_5(var_8_4, var_8_6, var_8_7)
		end
	end

	return
end

function var_0_0.RequestRandomDailyTask(arg_9_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_9_0 = var_1_10001(var_1_10002)
	local var_9_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_9_1(var_9_0, var_1_10003.ACTIVITY_TYPE_RANDOM_DAILY_TASK) or var_1:isEnd() then
		return
	end

	pg = var_9_0

	local var_9_2 = var_9_0.TimeMgr.GetInstance()
	local var_9_3 = var_2.GetServerTime(var_9_2)

	pg = var_9_2

	local var_9_4 = var_9_2.TimeMgr.GetInstance()

	if var_3.IsSameDay(var_9_4, var_1.data1, var_9_3) then
		return
	end

	pg = var_9_4

	local var_9_5 = var_9_4.m02
	local var_9_6 = var_4.sendNotification

	GAME = var_6

	local var_9_7 = var_6.ACT_RANDOM_DAILY_TASK
	local var_9_8 = {
		activity_id = var_1.id
	}

	ActivityConst = var_8
	var_9_8.cmd = var_8.RANDOM_DAILY_TASK_OP_RANDOM

	var_9_6(var_9_5, var_9_7, var_9_8)

	return
end

function var_0_0.RequestDALDailyTask(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_10_1(var_10_0, var_1_10003.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB) then
		return 0
	end

	pg = var_10_0

	local var_10_2 = var_10_0.m02
	local var_10_3 = var_2.sendNotification

	GAME = var_1_10004

	var_10_3(var_10_2, var_1_10004.COLLABRATE_BOSS_RUSH_REQUEST_DATA, {
		actId = var_1.id
	})

	return
end

function var_0_0.RequestStoryAutoUnlock(arg_11_0)
	local var_11_0 = false
	local var_11_1 = {}

	ipairs = var_1_10003
	pg = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10003(var_1_10004.memory_group.all) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.memory_group[iter_11_1]
		type = var_1_10009

		if var_1_10009(var_1_10008.auto_unlock) == "table" then
			getProxy = var_1_10009
			ActivityProxy = var_10

			local var_11_2 = var_1_10009(var_10)

			var_1_10009 = var_1_10009.getActivityById(var_11_2, var_1_10008.link_event)
			pg = var_11_2

			local var_11_3 = var_11_2.NewStoryMgr.GetInstance()

			if not var_1_10009 or var_1_10009:isEnd() then
				local var_11_4 = var_1_10008.auto_unlock
				local var_11_5 = {}

				ipairs = var_1_10013

				for iter_11_2, iter_11_3 in var_1_10013(var_11_4) do
					local var_11_6 = var_11_3
					local var_11_7 = var_11_3.StoryName2StoryId

					pg = var_1_10020

					local var_11_8 = var_11_7(var_11_6, var_1_10020.memory_template[iter_11_3].story)

					var_1_10020 = var_11_3

					if var_11_3.GetPlayedFlag(var_1_10020, var_11_8) then
						table = var_19

						var_19.insert(var_11_5, var_11_8)
					else
						table = var_19

						var_19.insert(var_11_1, var_11_8)
					end
				end

				if #var_11_5 > 0 and #var_11_1 > 0 then
					var_11_0 = true
				end
			end
		end
	end

	if var_11_0 then
		pg = var_3

		local var_11_9 = var_3.m02
		local var_11_10 = var_3.sendNotification

		GAME = var_5

		var_11_10(var_11_9, var_5.STORY_UPDATE_LIST, {
			storyIds = var_11_1
		})
	end

	return
end

return var_0_0
