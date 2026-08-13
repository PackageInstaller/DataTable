class = var_0_10000

local var_0_0 = "BuildPoolExchangeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity_id

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getActivityById(var_1_1, var_1_0) or var_4:isEnd() then
		pg = var_1_1

		local var_1_2 = var_1_1.TipsMgr.GetInstance()

		var_1_1 = var_1_1.ShowTips
		i18n = var_1_10007

		var_1_1(var_1_2, var_1_10007("common_activity_end"))

		return
	end

	pg = var_1_1

	local var_1_3 = var_1_1.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11202, {
		cmd = 2,
		arg1 = 0,
		arg2 = 0,
		activity_id = var_1_0,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_0
			var_2_0.data2 = var_0.data2 + 1
			getProxy = var_2_0
			ActivityProxy = var_2

			local var_2_1 = var_2_0(var_2)

			var_2_0.updateActivity(var_2_1, var_0)

			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
			var_2_10003 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_2_10004

			var_2_2(var_2_10003, var_2_10004.ACTIVITY_BUILD_POOL_EXCHANGE_DONE, {
				awards = var_2_0
			})
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
