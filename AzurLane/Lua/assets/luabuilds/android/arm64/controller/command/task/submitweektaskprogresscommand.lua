local var_0_0 = class("SubmitWeekTaskProgressCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(TaskProxy):GetWeekTaskProgressInfo()

	if not getProxy(TaskProxy):GetWeekTaskProgressInfo():CanUpgrade() then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(20110, {
		id = 0
	}, 20111, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_1:Upgrade()
			arg_1_0:sendNotification(GAME.SUBMIT_WEEK_TASK_PROGRESS_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.award_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
