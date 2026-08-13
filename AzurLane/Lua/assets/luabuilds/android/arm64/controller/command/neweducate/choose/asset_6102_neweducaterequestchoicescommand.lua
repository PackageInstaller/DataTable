class = var_0_10000

local var_0_0 = "NewEducateRequestChoicesCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29107, {
		id = var_1_0
	}, 29108, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.GetPriorityState(var_2_2)

			var_2.UpdataData(var_2_3, arg_2_0.cache)

			existCall = var_3

			var_3(var_1_1)
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_4, "NewEducate_RequestChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
