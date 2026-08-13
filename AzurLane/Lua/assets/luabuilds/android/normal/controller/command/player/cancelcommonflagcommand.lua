class = var_0_10000

local var_0_0 = "CancelCommonFlagCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().flagID

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 11021, {
		flag_id = var_1_0
	}, 11022, function(arg_2_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		if var_2_10001(var_2_10002) then
			local var_2_0 = var_1:getData()

			var_2.CancelCommonFlag(var_2_0, var_1_0)
			var_1:updatePlayer(var_2)
		end

		return
	end)

	return
end

return var_0_1
