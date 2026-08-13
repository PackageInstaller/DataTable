class = var_0_10000

local var_0_0 = "ColoringClearCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().activityId
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 26006, {
		act_id = var_1_0,
		id = var_1_1
	}, 26007, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ColoringProxy = var_2_10002
			var_2_10003 = var_1(var_2_10002)

			local var_2_0 = var_1.getColorGroup(var_2_10003, var_1_1)

			var_2.clearFill(var_2_0)

			local var_2_1 = arg_1_0

			var_2_10003 = var_2_10003.sendNotification
			GAME = var_2_10005

			var_2_10003(var_2_1, var_2_10005.COLORING_CLEAR_DONE)
		else
			pg = var_1

			local var_2_2 = var_1.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("coloring_clear", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
