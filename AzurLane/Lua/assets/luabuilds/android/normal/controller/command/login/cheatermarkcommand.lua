class = var_0_10000

local var_0_0 = "CheaterMarkCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().reason

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 10994, {
		type = var_1_0
	}, 10995, function(arg_2_0)
		local var_2_0 = var_1_0

		CC_TYPE_99 = var_2_10002

		if var_2_0 ~= var_2_10002 then
			local var_2_1 = var_1_0

			CC_TYPE_100 = var_2_10002

			if var_2_1 ~= var_2_10002 then
				pg = var_2_1

				local var_2_2 = var_2_1.m02
				local var_2_3 = var_1.sendNotification

				GAME = var_2_10003

				var_2_3(var_2_2, var_2_10003.LOGOUT, {
					code = 7
				})
			end
		end

		return
	end)

	return
end

return var_0_1
