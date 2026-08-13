class = var_0_10000

local var_0_0 = "ActivityCardPuzzleCombatCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	getProxy = var_1_0
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if not var_4.getActivityById(var_1_2, var_2.activity_id) or var_4:isEnd() then
		return
	end

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11202, {
		cmd = 1,
		arg2 = 0,
		activity_id = var_2.activity_id,
		arg1 = var_2.arg1,
		arg_list = {}
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			table = var_1

			if not var_1.contains(var_0.data2_list, var_0.arg1) then
				table = var_1

				var_1.insert(var_0.data2_list, var_0.arg1)

				getProxy = var_1
				ActivityProxy = var_3

				local var_2_0 = var_1(var_3)

				var_1.updateActivity(var_2_0, var_0)
			end
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_2(var_2_1, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
