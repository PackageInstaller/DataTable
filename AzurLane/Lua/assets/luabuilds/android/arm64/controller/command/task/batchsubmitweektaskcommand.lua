local var_0_0 = class("BatchSubmitWeekTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
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
			local var_2_0 = var_1_4:GetSubTask(var_1_1[1]):GetAward()

			table.insert({}, Drop.New({
				type = var_2_0[1],
				id = var_2_0[2],
				count = arg_2_0.pt
			}))
			var_1_4:RemoveSubTasks(var_1_1)
			var_1_4:AddProgress(arg_2_0.pt)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.next) do
				var_1_4:AddSubTask((WeekPtTask.New(iter_2_1)))
			end

			if not var_1_3 then
				arg_1_0:sendNotification(GAME.BATCH_SUBMIT_WEEK_TASK_DONE, {
					awards = {},
					ids = var_1_1
				})
			end

			if var_1_2 then
				var_1_2({})
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
