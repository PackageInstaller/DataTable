class = var_0_10000

local var_0_0 = "NewEducateClearNodeChainCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 29032, {
		id = var_1_1
	}, 29033, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			getProxy = var_2_3
			NewEducateProxy = var_2_10003

			local var_2_0 = var_2_3(var_2_10003)
			local var_2_1 = var_2_3.GetCurChar(var_2_0)

			var_2_3.InitFSM(var_2_1, arg_2_0.fsm)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_4

			var_2_3(var_2_2, var_4.NEW_EDUCATE_CHECK_FSM)
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_4, "NewEducate_ClearNodeChain: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
