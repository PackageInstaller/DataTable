class = var_0_10000

local var_0_0 = "WorldKillCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	pg = var_1_10002

	local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

	var_2.Send(var_1_0, 33112, {
		type = 0
	}, 33113, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2
			WorldProxy = var_2_10004
			var_2_10005 = var_2(var_2_10004)

			local var_2_1 = var_2.BuildWorld

			World = var_2_10006

			var_2_1(var_2_10005, var_2_10006.TypeFull)
		else
			pg = var_2

			local var_2_2 = var_2.TipsMgr.GetInstance()
			local var_2_3 = var_2.ShowTips

			errorTip = var_2_10005

			var_2_3(var_2_2, var_2_10005("world_reset_error_", arg_2_0.result))
		end

		local var_2_4 = arg_1_0
		local var_2_5 = var_2.sendNotification

		GAME = var_2_10005

		var_2_5(var_2_4, var_2_10005.WORLD_KILL_DONE, {
			result = arg_2_0.result
		})

		return
	end)

	return
end

return var_0_1
