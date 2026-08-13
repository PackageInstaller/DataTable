class = var_0_10000

local var_0_0 = "EducateSetTargetCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.open

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 27019, {
		id = var_2.id
	}, 27020, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			EducateProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)
			var_2_10003 = var_1.GetTaskProxy(var_2_10003)

			var_2.UpdateTargetAwardStatus(var_2_10003, false)

			var_2_10003 = var_1
			var_2_10003 = var_1.GetTaskProxy(var_2_10003)

			var_2.SetTarget(var_2_10003, var_0.id)

			var_2_10003 = var_1

			var_1.UpdateGameStatus(var_2_10003)

			var_2_10003 = arg_1_0

			local var_2_0 = var_2.sendNotification

			GAME = var_4

			var_2_0(var_2_10003, var_4.EDUCATE_SET_TARGET_DONE, {
				autoOpen = var_1_1
			})

			if var_1_0 then
				var_1_0()
			end
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_2(var_2_1, var_2_10003("educate set target error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
