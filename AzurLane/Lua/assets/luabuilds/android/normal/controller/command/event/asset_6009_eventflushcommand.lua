class = var_0_10000

local var_0_0 = "EventFlushCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 13009, {
		type = 0
	}, 13010, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			EventProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.updateAll(var_2_0, arg_2_0.collection_list)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_2(var_2_1, var_2_10003("event_flush_fail", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
