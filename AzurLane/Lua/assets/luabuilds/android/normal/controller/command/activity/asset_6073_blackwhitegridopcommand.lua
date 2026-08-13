class = var_0_10000

local var_0_0 = "BlackWhiteGridOPCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.activityId
	local var_1_2 = var_2.cmd

	if var_2.score < 0 then
		return
	end

	getProxy = var_7
	ActivityProxy = var_1_10008

	local var_1_3 = var_7(var_1_10008)

	if not var_7.getActivityById(var_1_3, var_1_1) or var_8:isEnd() then
		return
	end

	pg = var_1_3

	local var_1_4 = var_1_3.ConnectionMgr.GetInstance()

	var_9.Send(var_1_4, 11202, {
		cmd = 1,
		activity_id = var_1_1,
		arg1 = var_1_0,
		arg2 = var_6,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
			table = var_2

			if not var_2.contains(var_0.data1_list, var_1_0) then
				table = var_2

				var_2.insert(var_0.data1_list, var_1_0)
			end

			table = var_2

			local var_2_1 = var_2.indexof(var_0.data1_list, var_1_0)

			assert = var_3

			var_3(var_2_1)

			var_0.data2_list[var_2_1] = var_0

			local var_2_2 = var_0

			var_3.updateActivity(var_2_2, var_0)

			local var_2_3 = arg_1_0
			local var_2_4 = var_3.sendNotification

			GAME = var_5

			var_2_4(var_2_3, var_5.BLACK_WHITE_GRID_OP_DONE, {
				awards = var_2_0
			})
		else
			originalPrint = var_2_0

			var_2_0(arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
