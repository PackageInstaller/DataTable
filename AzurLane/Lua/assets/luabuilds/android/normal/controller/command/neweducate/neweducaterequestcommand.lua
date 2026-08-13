class = var_0_10000

local var_0_0 = "NewEducateRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29001, {
		id = var_1_1
	}, 29002, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.UpdateChar(var_2_0, arg_2_0.tb, arg_2_0.permanent)

			existCall = var_1

			var_1(var_1_0)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_1, "NewEducate_Request: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
