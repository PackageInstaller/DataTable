class = var_0_10000

local var_0_0 = "ActivityBeatMonsterNianCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if not var_4.getActivityById(var_1_1, var_2.activity_id) or var_4:isEnd() then
		return
	end

	pg = var_1_1

	local var_1_2 = var_1_1.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 11202, {
		activity_id = var_2.activity_id,
		cmd = var_2.cmd,
		arg1 = var_2.arg1,
		arg2 = var_2.arg2,
		arg_list = {}
	}, 11203, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.award_list)
			var_0.data2 = var_0.data2 + 1
			var_0.data3 = arg_2_0.number[1]
			var_2_10003 = var_0

			if var_2.GetDataConfig(var_2_10003, "hp") - var_0.data3 <= 0 then
				var_2_10003 = var_0
				var_2_10003.data1 = 1
			end

			getProxy = var_2_10003
			ActivityProxy = var_4

			local var_2_1 = var_2_10003(var_4)

			var_2_10003.updateActivity(var_2_1, var_0)

			if var_1_0 then
				var_1_0(var_2_0)
			end
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_3(var_2_2, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
