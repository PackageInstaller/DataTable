class = var_0_10000

local var_0_0 = "RefluxSignCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.ConnectionMgr.GetInstance()

	var_1.Send(var_1_0, 11753, {
		type = 0
	}, 11754, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			RefluxProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.setSignLastTimestamp(var_2_0)
			var_1:addSignCount()

			PlayerConst = var_2

			local var_2_1 = var_2.addTranDrop(arg_2_0.award_list)

			pg = var_2_10003

			local var_2_2 = var_2_10003.m02
			local var_2_3 = var_3.sendNotification

			GAME = var_2_10006

			var_2_3(var_2_2, var_2_10006.REFLUX_SIGN_DONE, {
				awards = var_2_1
			})
		else
			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_4, "Sign Error:" .. arg_2_0.result)

			getProxy = var_1
			RefluxProxy = var_2_4

			local var_2_5 = var_1(var_2_4)

			var_1.setAutoActionForbidden(var_2_5, true)
		end

		return
	end)

	return
end

return var_0_1
