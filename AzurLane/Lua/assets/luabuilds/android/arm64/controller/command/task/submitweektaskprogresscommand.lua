class = var_0_10000

local var_0_0 = "SubmitWeekTaskProgressCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	TaskProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)
	local var_1_2 = var_3.GetWeekTaskProgressInfo(var_1_1)

	if not var_4.CanUpgrade(var_1_2) then
		return
	end

	pg = var_5

	local var_1_3 = var_5.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 20110, {
		id = 0
	}, 20111, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
			var_2_10004 = var_0

			var_2.Upgrade(var_2_10004)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_2_10005

			var_2_1(var_2_10004, var_2_10005.SUBMIT_WEEK_TASK_PROGRESS_DONE, {
				awards = var_2_0
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
