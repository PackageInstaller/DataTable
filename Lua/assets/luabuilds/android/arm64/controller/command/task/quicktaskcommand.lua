local var_0_0 = class("QuickTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getType()
	local var_1_2 = arg_1_1:getBody()
	local var_1_3 = getProxy(TaskProxy)
	local var_1_4 = var_1_3:getTaskById(var_1_2)

	if not var_1_4 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("task_is_not_existence", var_1_2))

		if var_1_0 then
			var_1_0(false)
		end

		return
	end

	if var_1_4:getConfig("quick_finish") > getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

		if var_1_0 then
			var_1_0(false)
		end

		return
	end

	if var_1_3:isSubmitting(var_1_2) then
		return
	else
		var_1_3:addSubmittingTask(var_1_2)
	end

	local var_1_5 = {}

	if var_1_4:IsOverflowShipExpItem() then
		table.insert(var_1_5, function(arg_2_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("player_expResource_mail_fullBag"),
				onYes = arg_2_0,
				onNo = function()
					var_1_3:removeSubmittingTask(var_1_2)

					if var_1_0 then
						var_1_0(false)
					end

					return
				end
			})

			return
		end)
	end

	seriesAsync(var_1_5, function()
		local var_4_0 = false
		local var_4_1

		if var_1_4:isActivityTask() then
			var_4_1 = var_1_4:getActId()

			if table.contains(TotalTaskProxy.normal_task_type, pg.activity_template[var_4_1].type) then
				var_4_0 = true
			end
		end

		if var_4_0 then
			pg.ConnectionMgr.GetInstance():Send(20207, {
				act_id = var_4_1,
				task_id = var_1_4.id,
				item_cost = var_1_4:getConfig("quick_finish")
			}, 20208, function(arg_5_0)
				QuickTaskCommand.OnQuickTaskComplete(arg_5_0, var_1_4, var_1_0)

				return
			end)
		else
			pg.ConnectionMgr.GetInstance():Send(20013, {
				id = var_1_4.id,
				item_cost = var_1_4:getConfig("quick_finish")
			}, 20014, function(arg_6_0)
				QuickTaskCommand.OnQuickTaskComplete(arg_6_0, var_1_4, var_1_0)

				return
			end)
		end

		return
	end)

	return
end

function var_0_0.OnQuickTaskComplete(arg_7_0, arg_7_1, arg_7_2)
	getProxy(TaskProxy):removeSubmittingTask(arg_7_1.id)

	if arg_7_0.result == 0 then
		getProxy(BagProxy):removeItemById(tonumber(Item.QUICK_TASK_PASS_TICKET_ID), tonumber((arg_7_1:getConfig("quick_finish"))))
		QuickTaskCommand.AddGuildLivness(arg_7_1)
		SubmitTaskCommand.OnSubmitSuccess(arg_7_1)
		pg.TipsMgr.GetInstance():ShowTips(i18n("battlepass_task_quickfinish3"))
		pg.m02:sendNotification(GAME.SUBMIT_TASK_DONE, PlayerConst.addTranDrop(arg_7_0.award_list, {
			taskId = arg_7_1.id
		}), {
			arg_7_1.id
		})

		local var_7_0 = getProxy(ActivityProxy)
		local var_7_1 = var_7_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_TASK_LIST_MONITOR)

		if var_7_1 and not var_7_1:isEnd() then
			local var_7_2 = var_7_1:getConfig("config_data")[1] or {}

			if table.contains(var_7_2, arg_7_1.id) then
				var_7_0:monitorTaskList(var_7_1)
			end
		end

		if arg_7_2 then
			arg_7_2(true)
		end
	else
		pg.TipsMgr.GetInstance():ShowTips(errorTip("task_submitTask", arg_7_0.result))

		if arg_7_2 then
			arg_7_2(false)
		end
	end

	return
end

function var_0_0.AddGuildLivness(arg_8_0)
	if arg_8_0:IsGuildAddLivnessType() then
		local var_8_0 = getProxy(GuildProxy)
		local var_8_1 = var_8_0:getData()
		local var_8_2 = 0
		local var_8_3 = false

		if var_8_1 and arg_8_0:isGuildTask() then
			var_8_1:setWeeklyTaskFlag(1)

			local var_8_4 = var_8_1:getWeeklyTask()

			if var_8_4 then
				var_8_2 = var_8_4:GetLivenessAddition()
			end

			var_8_3 = true
		elseif arg_8_0:IsRoutineType() then
			var_8_2 = pg.guildset.new_daily_task_guild_active.key_value
		elseif arg_8_0:IsWeeklyType() then
			var_8_2 = pg.guildset.new_weekly_task_guild_active.key_value
		end

		if var_8_1 and var_8_2 and var_8_2 > 0 then
			var_8_1:getMemberById(getProxy(PlayerProxy):getRawData().id):AddLiveness(var_8_2)

			var_8_3 = true
		end

		if var_8_3 then
			var_8_0:updateGuild(var_8_1)
		end
	end

	return
end

return var_0_0
