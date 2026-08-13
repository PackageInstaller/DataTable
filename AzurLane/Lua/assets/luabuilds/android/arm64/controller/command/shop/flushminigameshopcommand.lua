class = var_0_10000

local var_0_0 = "FlushMiniGameShopCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1

	var_1_1 = arg_1_1.getBody(var_1_0) and var_2.callback
	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 26154, {
		type = 0
	}, 26155, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			-- block empty
		else
			pg = var_2

			local var_2_1 = var_2.TipsMgr.GetInstance()
			local var_2_2 = var_2.ShowTips

			ERROR_MESSAGE = var_2_10005

			var_2_2(var_2_1, var_2_10005[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
