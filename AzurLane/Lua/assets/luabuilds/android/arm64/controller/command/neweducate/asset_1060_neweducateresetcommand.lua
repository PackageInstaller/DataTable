class = var_0_10000

local var_0_0 = "NewEducateResetCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id
	local var_1_2 = var_2.difficulty

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 29007, {
		id = var_1_1,
		difficulty = var_1_2
	}, 29008, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)

			var_1.ResetChar(var_2_0, var_1_1, arg_2_0.tb)

			getProxy = var_1
			NewEducateProxy = var_2_0

			local var_2_1 = var_1(var_2_0)
			local var_2_2 = var_1.GetCurChar(var_2_1)
			local var_2_3 = var_1.GetFSM(var_2_2)
			local var_2_4 = var_1.SetSystemNo

			NewEducateFSM = var_5

			var_2_4(var_2_3, var_5.SYSTEM.INIT)

			existCall = var_2_4

			var_2_4(var_1_0)
		else
			pg = var_1

			local var_2_5 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_5, "NewEducate_Reset: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
