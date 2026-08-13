class = var_0_10000

local var_0_0 = "ColoringFetchCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activityId

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 26008, {
		act_id = var_1_0
	}, 26001, function(arg_2_0)
		getProxy = var_2_10001
		ColoringProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)

		var_1.netUpdateData(var_2_0, arg_2_0)

		local var_2_1 = arg_1_0
		local var_2_2 = var_2.sendNotification

		GAME = var_4

		var_2_2(var_2_1, var_4.COLORING_FETCH_DONE)

		return
	end)

	return
end

return var_0_1
