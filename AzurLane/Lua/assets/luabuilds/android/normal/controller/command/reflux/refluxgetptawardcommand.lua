class = var_0_10000

local var_0_0 = "RefluxGetPTAwardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.ConnectionMgr.GetInstance()

	var_1.Send(var_1_0, 11755, {
		type = 0
	}, 11756, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			RefluxProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.addPTStage(var_2_0)

			PlayerConst = var_2

			local var_2_1 = var_2.addTranDrop(arg_2_0.award_list)

			pg = var_3

			local var_2_2 = var_3.m02
			local var_2_3 = var_3.sendNotification

			GAME = var_2_10005

			var_2_3(var_2_2, var_2_10005.REFLUX_GET_PT_AWARD_DONE, {
				awards = var_2_1
			})
		end

		return
	end)

	return
end

return var_0_1
