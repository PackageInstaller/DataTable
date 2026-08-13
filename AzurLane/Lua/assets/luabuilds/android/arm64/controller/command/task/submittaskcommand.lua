class = var_0_10000

local var_0_0 = "SubmitTaskCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.GetSubmitActivityTask(arg_1_0)
	GAME = var_1_10001

	return var_1_10001.SUBMIT_ACTIVITY_TASK
end

function var_0_1.GetSubmitTaskDone(arg_2_0)
	GAME = var_1_10001

	return var_1_10001.SUBMIT_TASK_DONE
end

function var_0_1.GetSubmitTaskAwardDone(arg_3_0)
	GAME = var_1_10001

	return var_1_10001.SUBMIT_TASK_AWARD_DOWN
end

function var_0_1.execute(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()
	local var_4_1 = arg_4_1:getType()
	local var_4_2
	local var_4_3 = {}

	getProxy = var_1_10006
	TaskProxy = var_1_10008

	local var_4_4 = var_1_10006(var_1_10008)
	local var_4_5 = true

	type = var_1_10008

	if var_1_10008(var_4_0) ~= "number" then
		type = var_8

		if var_8(var_4_0) == "string" then
			var_4_2 = var_4_0
		else
			type = var_8

			if var_8(var_4_0) == "table" then
				if var_4_0.normal_submit then
					var_4_5 = var_4_0.virtual ~= nil and var_4_0.virtual
					var_4_2 = var_4_0.taskId
				else
					var_4_2 = var_4_0.taskId

					local var_4_6 = var_4_0.index
					local var_4_7 = var_4_4

					var_1_10009 = var_4_4.getTaskById(var_4_7, var_4_2)
					assert = var_10

					var_10(var_1_10009:isSelectable())

					var_1_10012 = var_1_10009

					local var_4_8 = var_1_10009.getConfig(var_1_10012, "award_choice")[var_4_6]

					ipairs = var_4_7

					for iter_4_0, iter_4_1 in var_4_7(var_4_8) do
						table = var_1_10016

						var_1_10016.insert(var_4_3, {
							type = iter_4_1[1],
							id = iter_4_1[2],
							number = iter_4_1[3]
						})
					end
				end
			end
		end

		if not var_4_4:getTaskById(var_4_2) then
			pg = var_1_10009

			local var_4_9 = var_1_10009.TipsMgr.GetInstance()
			local var_4_10 = var_9.ShowTips

			i18n = var_1_10012

			var_4_10(var_4_9, var_1_10012("task_is_not_existence", var_4_2))

			if var_4_1 then
				var_4_1(false)
			end

			return
		end

		if not var_8:isFinish() then
			pg = var_9

			local var_4_11 = var_9.TipsMgr.GetInstance()
			local var_4_12 = var_9.ShowTips

			i18n = var_1_10012

			var_4_12(var_4_11, var_1_10012("task_submitTask_error_notFinish"))

			if var_4_1 then
				var_4_1(false)
			end

			return
		end

		if var_8:isActivityTask() then
			pg = var_9

			local var_4_13 = var_9.m02

			var_9.sendNotification(var_4_13, arg_4_0:GetSubmitActivityTask(), {
				act_id = var_8:getActId(),
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

		local var_4_14 = {}

		if var_8:IsOverflowShipExpItem() and not arg_4_0:InTaskScene() then
			table = var_10

			var_10.insert(var_4_14, function(arg_6_0)
				pg = var_2_10001

				local var_6_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_6_1 = var_1.ShowMsgBox
				local var_6_2 = {}

				i18n = var_2_10005
				var_6_2.content = var_2_10005("player_expResource_mail_fullBag")
				var_6_2.onYes = arg_6_0

				function var_6_2.onNo()
					local var_7_0 = var_4_4

					var_0.removeSubmittingTask(var_7_0, var_4_2)

					if var_4_1 then
						var_4_1(false)
					end

					return
				end

				var_6_1(var_6_0, var_6_2)

				return
			end)
		end

		seriesAsync = var_10

		var_10(var_4_14, function()
			pg = var_2_10000

			local var_8_0 = var_2_10000.ConnectionMgr.GetInstance()

			var_0.Send(var_8_0, 20005, {
				id = var_0.id,
				choice_award = var_4_3
			}, 20006, function(arg_9_0)
				local var_9_0 = var_4_4

				var_1.removeSubmittingTask(var_9_0, var_4_2)

				local var_9_1, var_9_3

				if arg_9_0.result == 0 then
					PlayerConst = var_9_1
					var_9_1 = var_9_1.addTranDrop(arg_9_0.award_list, {
						taskId = var_0.id
					})

					if not var_4_5 then
						for iter_9_0 = #var_9_1, 1, -1 do
							local var_9_2 = var_9_1[iter_9_0].type

							DROP_TYPE_VITEM = var_3_10007

							if var_9_2 == var_3_10007 then
								table = var_9_2

								var_9_2.remove(var_9_1, iter_9_0)
							end
						end
					end

					var_0_1.OnSubmitSuccess(var_0, var_4_1)

					pg = var_2
					var_9_3 = var_2.m02

					local var_9_4 = var_2.sendNotification
					local var_9_5 = arg_4_0

					var_9_4(var_9_3, var_5.GetSubmitTaskDone(var_9_5), var_9_1, {
						var_0.id
					})

					pg = var_9_4
					var_9_3 = var_9_4.m02

					local var_9_6 = var_2.sendNotification
					local var_9_7 = arg_4_0

					var_9_6(var_9_3, var_5.GetSubmitTaskAwardDone(var_9_7), {
						awards = var_9_1
					}, {
						var_0.id
					})
				else
					pg = var_9_1

					local var_9_8 = var_9_1.TipsMgr.GetInstance()
					local var_9_9 = var_1.ShowTips

					errorTip = var_9_3

					var_9_9(var_9_8, var_9_3("task_submitTask", arg_9_0.result))

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
end

function var_0_1.OnSubmitSuccess(arg_10_0, arg_10_1)
	var_0_1.CheckTaskSub(arg_10_0)
	var_0_1.AddGuildLivness(arg_10_0)
	var_0_1.CheckTaskType(arg_10_0)
	var_0_1.UpdateActivity(arg_10_0)

	if arg_10_1 then
		arg_10_1(true)
	end

	return
end

function var_0_1.CheckTaskSub(arg_11_0)
	local var_11_0 = arg_11_0:getConfig("sub_type")

	TASK_SUB_TYPE_GIVE_ITEM = var_1_10002

	if var_11_0 == var_1_10002 then
		tonumber = var_11_0

		local var_11_1 = var_11_0(arg_11_0:getConfig("target_id"))

		var_1_10002 = arg_11_0:getConfig("target_num")
		getProxy = var_3
		BagProxy = var_5

		local var_11_2 = var_3(var_5)
		local var_11_3 = var_3.removeItemById

		tonumber = var_1_10007

		local var_11_4 = var_1_10007(var_11_1)

		tonumber = var_1_10008

		var_11_3(var_11_2, var_11_4, var_1_10008(var_1_10002))
	else
		local var_11_5 = arg_11_0:getConfig("sub_type")

		TASK_SUB_TYPE_GIVE_VIRTUAL_ITEM = var_1_10002

		if var_11_5 == var_1_10002 then
			tonumber = var_11_5

			local var_11_6 = var_11_5(arg_11_0:getConfig("target_id"))

			var_1_10002 = arg_11_0:getConfig("target_num")
			getProxy = var_3
			ActivityProxy = var_5

			local var_11_7 = var_3(var_5)

			var_3.removeVitemById(var_11_7, var_11_6, var_1_10002)
		else
			local var_11_8 = arg_11_0:getConfig("sub_type")

			TASK_SUB_TYPE_PLAYER_RES = var_1_10002

			if var_11_8 == var_1_10002 then
				tonumber = var_11_8

				local var_11_9 = var_11_8(arg_11_0:getConfig("target_id"))
				local var_11_10 = arg_11_0:getConfig("target_num")

				getProxy = var_3
				PlayerProxy = var_5

				local var_11_11 = var_3(var_5)
				local var_11_12 = var_3.getData(var_11_11)
				local var_11_13 = var_4.consume
				local var_11_14 = {}

				id2res = var_1_10009
				var_11_14[var_1_10009(var_11_9)] = var_11_10

				var_11_13(var_11_12, var_11_14)
				var_3:updatePlayer(var_4)
			end
		end
	end

	return
end

function var_0_1.CheckTaskType(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("type")

	Task = var_1_10002

	local var_12_1

	if var_12_0 == var_1_10002.TYPE_REFLUX then
		getProxy = var_2
		RefluxProxy = var_12_1
		var_12_1 = var_2(var_12_1)

		var_2.addPtAfterSubTasks(var_12_1, {
			arg_12_0
		})
	end

	Task = var_2

	if var_12_0 == var_2.TYPE_REPEATABLE then
		-- block empty
	elseif var_12_0 == 8 then
		arg_12_0.submitTime = 1
		getProxy = var_2
		TaskProxy = var_12_1
		var_12_1 = var_2(var_12_1)

		var_2.updateTask(var_12_1, arg_12_0)
	else
		getProxy = var_2
		TaskProxy = var_12_1

		local var_12_2 = var_2(var_12_1)

		var_2.removeTask(var_12_2, arg_12_0)
	end

	return
end

function var_0_1.AddGuildLivness(arg_13_0)
	local var_13_0 = arg_13_0

	if arg_13_0.IsGuildAddLivnessType(var_13_0) then
		getProxy = var_1
		GuildProxy = var_13_0

		local var_13_1 = var_1(var_13_0)
		local var_13_2 = var_1.getData(var_13_1)
		local var_13_3 = 0
		local var_13_4 = false

		if var_13_2 and arg_13_0:isGuildTask() then
			var_13_2:setWeeklyTaskFlag(1)

			if var_13_2:getWeeklyTask() then
				var_1_10008 = var_5
				var_13_3 = var_5.GetLivenessAddition(var_1_10008)
			end

			var_13_4 = true
		elseif arg_13_0:IsRoutineType() then
			pg = var_5
			var_13_3 = var_5.guildset.new_daily_task_guild_active.key_value
		elseif arg_13_0:IsWeeklyType() then
			pg = var_5
			var_13_3 = var_5.guildset.new_weekly_task_guild_active.key_value
		end

		if var_13_2 and var_13_3 and var_13_3 > 0 then
			local var_13_5 = var_13_2
			local var_13_6 = var_13_2.getMemberById

			getProxy = var_1_10008
			PlayerProxy = var_1_10010

			local var_13_7 = var_1_10008(var_1_10010)
			local var_13_8 = var_13_6(var_13_5, var_8.getRawData(var_13_7).id)

			var_5.AddLiveness(var_13_8, var_13_3)

			var_13_4 = true
		end

		if var_13_4 then
			var_1:updateGuild(var_13_2)
		end
	end

	return
end

function var_0_1.UpdateActivity(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)
	local var_14_1 = var_1.getActivityByType

	ActivityConst = var_1_10005

	if var_14_1(var_14_0, var_1_10005.ACTIVITY_TYPE_TASK_LIST_MONITOR) and not var_2:isEnd() then
		local var_14_2

		if not var_2:getConfig("config_data")[1] then
			var_14_2 = {}
		end

		table = var_14_0

		if var_14_0.contains(var_14_2, arg_14_0.id) then
			var_1:monitorTaskList(var_2)
		end
	end

	return
end

function var_0_1.InTaskScene(arg_15_0)
	getProxy = var_1_10001
	ContextProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)
	local var_15_1 = var_1.getCurrentContext(var_15_0).mediator

	TaskMediator = var_15_0

	return var_15_1 == var_15_0
end

return var_0_1
