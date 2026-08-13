class = var_0_10000

local var_0_0 = "GetSummaryInfoCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).activityId

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 26021, {
		act_id = var_1_1
	}, 26022, function(arg_2_0)
		if arg_2_0.result == 0 then
			Summary = var_1

			local var_2_0 = var_1.New(arg_2_0)

			getProxy = var_2_10002
			PlayerProxy = var_2_10004

			local var_2_1 = var_2_10002(var_2_10004)

			var_2.setSummaryInfo(var_2_1, var_2_0)

			local var_2_2 = arg_1_0
			local var_2_3 = var_3.sendNotification

			GAME = var_6

			local var_2_4 = var_6.GET_PLAYER_SUMMARY_INFO_DONE

			Clone = var_2_10007

			var_2_3(var_2_2, var_2_4, var_2_10007(var_2_0))
		end

		return
	end)

	return
end

return var_0_1
