local var_0_0 = class("SubmitTaskCommand", pm.SimpleCommand)

function var_0_0.GetSubmitActivityTask(arg_1_0)
	return GAME.SUBMIT_ACTIVITY_TASK
end

function var_0_0.GetSubmitTaskDone(arg_2_0)
	return GAME.SUBMIT_TASK_DONE
end

function var_0_0.GetSubmitTaskAwardDone(arg_3_0)
	return GAME.SUBMIT_TASK_AWARD_DOWN
end

function var_0_0.execute(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()
	local var_4_1 = arg_4_1:getType()
	local var_4_2
	local var_4_3 = {}
	local var_4_4 = getProxy(TaskProxy)
	local var_4_5 = true

	if type(var_4_0) == "number" or type(var_4_0) == "string" then
		var_4_2 = var_4_0
	elseif type(var_4_0) == "table" then
		if var_4_0.normal_submit then
			var_4_5 = var_4_0.virtual ~= nil and var_4_0.virtual
			var_4_2 = var_4_0.taskId
		else
			var_4_2 = var_4_0.taskId

			local var_4_6 = var_4_4:getTaskById(var_4_0.taskId)

			assert(var_4_6:isSelectable())

			for iter_4_0, iter_4_1 in ipairs(var_4_6:getConfig("award_choice")[var_4_0.index]) do
				table.insert({}, {
					type = iter_4_1[1],
					id = iter_4_1[2],
					number = iter_4_1[3]
				})
			end
		end
	end

	local var_4_7 = var_4_4:getTaskById(var_4_2)

	if not var_4_7 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_is_not_existence", var_4_2))

		if var_4_1 then
			var_4_1(false)
		end

		return
	end

	if not var_4_7:isFinish() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_submitTask_error_notFinish"))

		if var_4_1 then
			var_4_1(false)
		end

		return
	end

	if var_4_7:isActivityTask() then
		pg.m02:sendNotification(arg_4_0:GetSubmitActivityTask(), {
			act_id = var_4_7:getActId(),
			task_ids = {
				var_4_2
			},
			callback = function(arg_5_0, arg_5_1)
				if arg_5_0 and var_4_1 then
					var_4_1(arg_5_0)
				end

				return
			end
		})

		return
	end

	if var_4_4:isSubmitting(var_4_2) then
		return
	else
		var_4_4:addSubmittingTask(var_4_2)
	end

	local var_4_8 = {}

	if var_4_7:IsOverflowShipExpItem() and not arg_4_0:InTaskScene() then
		table.insert(var_4_8, function(arg_6_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("player_expResource_mail_fullBag"),
				onYes = arg_6_0,
				onNo = function()
					var_4_4:removeSubmittingTask(var_4_2)

					if var_4_1 then
						var_4_1(false)
					end

					return
				end
			})

			return
		end)
	end

	seriesAsync(var_4_8, function()
		pg.ConnectionMgr.GetInstance():Send(20005, {
			id = var_4_7.id,
			choice_award = var_4_3
		}, 20006, function(arg_9_0)
			var_4_4:removeSubmittingTask(var_4_2)

			if arg_9_0.result == 0 then
				local var_9_0 = PlayerConst.addTranDrop(arg_9_0.award_list, {
					taskId = var_4_7.id
				})

				if not var_4_5 then
					for iter_9_0 = #var_9_0, 1, -1 do
						if var_9_0[iter_9_0].type == DROP_TYPE_VITEM then
							table.remove(var_9_0, iter_9_0)
						end
					end
				end

				var_0_0.OnSubmitSuccess(var_4_7, var_4_1)
				pg.m02:sendNotification(arg_4_0:GetSubmitTaskDone(), var_9_0, {
					var_4_7.id
				})
				pg.m02:sendNotification(arg_4_0:GetSubmitTaskAwardDone(), {
					awards = var_9_0
				}, {
					var_4_7.id
				})
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("task_submitTask", arg_9_0.result))

				if var_4_1 then
					var_4_1(false)
				end
			end

			return
		end)

		return
	end)

	return
end

function var_0_0.OnSubmitSuccess(arg_10_0, arg_10_1)
	var_0_0.CheckTaskSub(arg_10_0)
	var_0_0.AddGuildLivness(arg_10_0)
	var_0_0.CheckTaskType(arg_10_0)
	var_0_0.UpdateActivity(arg_10_0)

	if arg_10_1 then
		arg_10_1(true)
	end

	return
end

function var_0_0.CheckTaskSub(arg_11_0)
	if arg_11_0:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_ITEM then
		getProxy(BagProxy):removeItemById(tonumber((tonumber(arg_11_0:getConfig("target_id")))), tonumber((arg_11_0:getConfig("target_num"))))
	elseif arg_11_0:getConfig("sub_type") == TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM then
		getProxy(ActivityProxy):removeVitemById(tonumber(arg_11_0:getConfig("target_id")), (arg_11_0:getConfig("target_num")))
	elseif arg_11_0:getConfig("sub_type") == TASK_SUB_TYPE_PLAYER_RES then
		local var_11_0 = getProxy(PlayerProxy)
		local var_11_1 = var_11_0:getData()

		var_11_1:consume({
			[id2res((tonumber(arg_11_0:getConfig("target_id"))))] = arg_11_0:getConfig("target_num")
		})
		var_11_0:updatePlayer(var_11_1)
	end

	return
end

function var_0_0.CheckTaskType(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("type")

	if var_12_0 == Task.TYPE_REFLUX then
		getProxy(RefluxProxy):addPtAfterSubTasks({
			arg_12_0
		})
	end

	if var_12_0 == Task.TYPE_REPEATABLE then
		-- block empty
	elseif var_12_0 == 8 then
		arg_12_0.submitTime = 1

		getProxy(TaskProxy):updateTask(arg_12_0)
	else
		getProxy(TaskProxy):removeTask(arg_12_0)
	end

	return
end

function var_0_0.AddGuildLivness(arg_13_0)
	if arg_13_0:IsGuildAddLivnessType() then
		local var_13_0 = getProxy(GuildProxy)
		local var_13_1 = var_13_0:getData()
		local var_13_2 = 0
		local var_13_3 = false

		if var_13_1 and arg_13_0:isGuildTask() then
			var_13_1:setWeeklyTaskFlag(1)

			local var_13_4 = var_13_1:getWeeklyTask()

			if var_13_4 then
				var_13_2 = var_13_4:GetLivenessAddition()
			end

			var_13_3 = true
		elseif arg_13_0:IsRoutineType() then
			var_13_2 = pg.guildset.new_daily_task_guild_active.key_value
		elseif arg_13_0:IsWeeklyType() then
			var_13_2 = pg.guildset.new_weekly_task_guild_active.key_value
		end

		if var_13_1 and var_13_2 and var_13_2 > 0 then
			var_13_1:getMemberById(getProxy(PlayerProxy):getRawData().id):AddLiveness(var_13_2)

			var_13_3 = true
		end

		if var_13_3 then
			var_13_0:updateGuild(var_13_1)
		end
	end

	return
end

function var_0_0.UpdateActivity(arg_14_0)
	local var_14_0 = getProxy(ActivityProxy)
	local var_14_1 = var_14_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST_MONITOR)

	if var_14_1 and not var_14_1:isEnd() then
		local var_14_2 = var_14_1:getConfig("config_data")[1] or {}

		if table.contains(var_14_2, arg_14_0.id) then
			var_14_0:monitorTaskList(var_14_1)
		end
	end

	return
end

function var_0_0.InTaskScene(arg_15_0)
	local var_15_0 = getProxy(ContextProxy):getCurrentContext().mediator

	return var_15_0 == TaskMediator
end

return var_0_0
