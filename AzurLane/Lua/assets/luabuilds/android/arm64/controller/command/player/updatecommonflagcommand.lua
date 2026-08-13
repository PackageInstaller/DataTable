class = var_0_10000

local var_0_0 = "UpdateCommonFlagCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).flagID

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 11019, {
		flag_id = var_1_1
	}, 11020, function(arg_2_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		if var_2_10001(var_2_10003) then
			local var_2_0 = var_1:getData()

			var_2.UpdateCommonFlag(var_2_0, var_1_1)
			var_1:updatePlayer(var_2)
		end

		return
	end)

	return
end

return var_0_1
