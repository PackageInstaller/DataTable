class = var_0_10000

local var_0_0 = "ActivityStoreDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.activity_id

	getProxy = var_1_10005
	ActivityProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getActivityById(var_1_2, var_2.activity_id) or var_5:isEnd() then
		return
	end

	local var_1_3

	if not var_2.intValue then
		var_1_3 = 0
	end

	local var_1_4

	if not var_2.strValue then
		var_1_4 = ""
	end

	pg = var_1_10008

	local var_1_5 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 26160, {
		act_id = var_1_1,
		int_value = var_1_3,
		str_value = var_1_4
	}, 26161, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = var_0
			var_2_0.data1 = var_1_3
			var_2_0 = var_0
			var_2_0.str_data1 = var_1_4
			getProxy = var_2_0
			ActivityProxy = var_2

			local var_2_1 = var_2_0(var_2)

			var_2_0.updateActivity(var_2_1, var_0)

			if var_1_0 then
				var_1_0()
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
