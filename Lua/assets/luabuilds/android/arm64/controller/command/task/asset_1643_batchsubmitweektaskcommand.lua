local BatchSubmitWeekTaskCommand = class("BatchSubmitWeekTaskCommand", pm.SimpleCommand)

function BatchSubmitWeekTaskCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.ids
	local var_1_2 = var_1_0.callback
	local var_1_3 = var_1_0.dontSendMsg
	local var_1_4 = getProxy(TaskProxy):GetWeekTaskProgressInfo()

	if #var_1_0.ids <= 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(20108, {
		id = var_1_0.ids
	}, 20109, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = {}
			local var_2_1 = var_1_4:GetSubTask(var_1_1[1]):GetAward()

			table.insert(var_2_0, Drop.New({
				type = var_2_1[1],
				id = var_2_1[2],
				count = arg_2_0.pt
			}))
			var_1_4:RemoveSubTasks(var_1_1)
			var_1_4:AddProgress(arg_2_0.pt)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.next) do
				var_1_4:AddSubTask((WeekPtTask.New(iter_2_1)))
			end

			if not var_1_3 then
				self:sendNotification(GAME.BATCH_SUBMIT_WEEK_TASK_DONE, {
					awards = var_2_0,
					ids = var_1_1
				})
			end

			if var_1_2 then
				var_1_2(var_2_0)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return BatchSubmitWeekTaskCommand
