class = var_0_10000

local var_0_0 = "PlayRoomMatchReadyCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).arg

	getProxy = var_1_0
	PlayRoomProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	var_4.SetExitMatchFlag(var_1_2, var_1_1)

	pg = var_4

	local var_1_3 = var_4.ConnectionMgr.GetInstance()

	var_4.Send(var_1_3, 23019, {
		ready = var_1_1
	}, 23020, function(arg_2_0)
		if arg_2_0.result == 0 then
			-- block empty
		else
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_1(var_2_0, var_2_10004("", arg_2_0.result))
		end

		return
	end, false)

	return
end

return var_0_1
