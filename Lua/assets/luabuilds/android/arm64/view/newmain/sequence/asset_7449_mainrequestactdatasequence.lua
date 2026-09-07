local MainRequestActDataSequence = class("MainRequestActDataSequence")

function MainRequestActDataSequence:Execute(arg_1_1)
	self:RequestReturnAwardAct()
	self:RequestActivityTask()
	self:RequestColoring()
	self:RequestMetaData()
	self:RequestManualSignAct()
	self:RequestRandomDailyTask()
	self:RequestDALDailyTask()
	self:RequestStoryAutoUnlock()
	arg_1_1()

	return
end

function MainRequestActDataSequence:RequestReturnAwardAct()
	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RETURN_AWARD)

	if var_2_0 and not var_2_0:isEnd() and (var_2_0.data1 == 0 or var_2_0.data1 == 1 and var_2_0.data2 == 0) then
		pg.m02:sendNotification(GAME.RETURN_AWARD_OP, {
			activity_id = var_2_0.id,
			cmd = ActivityConst.RETURN_AWARD_OP_ACTIVTION
		})
	end

	local var_2_1 = var_2_0

	if var_2_0 and not var_2_1:isEnd() then
		local var_2_2 = var_2_1:ShouldAcceptTasks()

		if var_2_2 and var_2_1:IsInviter() then
			pg.m02:sendNotification(GAME.RETURN_AWARD_OP, {
				activity_id = var_2_1.id,
				cmd = ActivityConst.RETURN_AWARD_OP_ACCEPT_TASK
			})
		elseif var_2_2 and var_2_1:IsReturner() then
			pg.m02:sendNotification(GAME.RETURN_AWARD_OP, {
				activity_id = var_2_1.id,
				cmd = ActivityConst.RETURN_AWARD_OP_RETURNER_GET_AWARD
			})
		end
	end

	return
end

function MainRequestActDataSequence:RequestActivityTask()
	local var_3_0 = getProxy(ActivityProxy)

	_.each(var_3_0:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_TASK_LIST,
		ActivityConst.ACTIVITY_TYPE_TASK_RES
	}), function(arg_4_0)
		if not arg_4_0:isEnd() then
			updateActivityTaskStatus(arg_4_0)
		end

		return
	end)
	underscore.each(var_3_0:getActivitiesByTypes({
		ActivityConst.ACTIVITY_TYPE_PT_CRUSING
	}), function(arg_5_0)
		if not arg_5_0:isEnd() then
			updateCrusingActivityTask(arg_5_0)
		end

		return
	end)

	return
end

function MainRequestActDataSequence:RequestColoring()
	local var_6_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_COLORING_ALPHA)

	if var_6_0 and not var_6_0:isEnd() then
		pg.m02:sendNotification(GAME.COLORING_FETCH, {
			activityId = var_6_0.id
		})
	end

	return
end

function MainRequestActDataSequence:RequestMetaData()
	getProxy(MetaCharacterProxy):requestMetaTacticsInfo()

	return
end

function MainRequestActDataSequence:RequestManualSignAct()
	for iter_8_0, iter_8_1 in pairs((getProxy(ActivityProxy):getRawData())) do
		if iter_8_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MANUAL_SIGN and not iter_8_1:TodayIsSigned() then
			pg.m02:sendNotification(GAME.ACT_MANUAL_SIGN, {
				activity_id = iter_8_1.id,
				cmd = ManualSignActivity.OP_SIGN
			})
		end
	end

	return
end

function MainRequestActDataSequence:RequestRandomDailyTask()
	local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RANDOM_DAILY_TASK)

	if not var_9_0 or var_9_0:isEnd() then
		return
	end

	if pg.TimeMgr.GetInstance():IsSameDay(var_9_0.data1, (pg.TimeMgr.GetInstance():GetServerTime())) then
		return
	end

	pg.m02:sendNotification(GAME.ACT_RANDOM_DAILY_TASK, {
		activity_id = var_9_0.id,
		cmd = ActivityConst.RANDOM_DAILY_TASK_OP_RANDOM
	})

	return
end

function MainRequestActDataSequence:RequestDALDailyTask()
	local var_10_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB)

	if not var_10_0 then
		return 0
	end

	pg.m02:sendNotification(GAME.COLLABRATE_BOSS_RUSH_REQUEST_DATA, {
		actId = var_10_0.id
	})

	return
end

function MainRequestActDataSequence:RequestStoryAutoUnlock()
	local var_11_0 = false
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(pg.memory_group.all) do
		if type(pg.memory_group[iter_11_1].auto_unlock) == "table" then
			local var_11_2 = getProxy(ActivityProxy):getActivityById(pg.memory_group[iter_11_1].link_event)
			local var_11_3 = pg.NewStoryMgr.GetInstance()

			if var_11_2 then
				if var_11_2:isEnd() then
					local var_11_4 = {}

					for iter_11_2, iter_11_3 in ipairs(pg.memory_group[iter_11_1].auto_unlock) do
						local var_11_5 = var_11_3:StoryName2StoryId(pg.memory_template[iter_11_3].story)

						if var_11_3:GetPlayedFlag(var_11_5) then
							table.insert(var_11_4, var_11_5)
						else
							table.insert(var_11_1, var_11_5)
						end
					end

					if #var_11_4 > 0 and #var_11_1 > 0 then
						var_11_0 = true
					end
				end
			end
		end
	end

	if var_11_0 then
		pg.m02:sendNotification(GAME.STORY_UPDATE_LIST, {
			storyIds = var_11_1
		})
	end

	return
end

return MainRequestActDataSequence
