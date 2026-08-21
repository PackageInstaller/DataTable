local var_0_0 = class("SubmitWeekTaskCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = getProxy(TaskProxy):GetWeekTaskProgressInfo()
	local var_1_2 = getProxy(TaskProxy):GetWeekTaskProgressInfo():GetSubTask(var_1_0)

	if not var_1_2 or not var_1_2:IsFinished() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(20106, {
		id = var_1_0
	}, 20107, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2:GetAward()

			table.insert({}, Drop.Create(var_2_0))
			var_1_1:AddProgress(var_2_0[3])
			var_1_1:RemoveSubTask(var_1_0)

			if arg_2_0.next and arg_2_0.next.id ~= 0 then
				var_1_1:AddSubTask((WeekPtTask.New(arg_2_0.next)))
			end

			arg_1_0:sendNotification(GAME.SUBMIT_WEEK_TASK_DONE, {
				awards = {},
				id = var_1_0
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
