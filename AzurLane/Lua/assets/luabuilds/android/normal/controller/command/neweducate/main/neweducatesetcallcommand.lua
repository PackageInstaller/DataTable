class = var_0_10000

local var_0_0 = "NewEducateSetCallCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.name

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29009, {
		id = var_1_0,
		name = var_1_1
	}, 29010, function(arg_2_0)
		local var_2_3

		if arg_2_0.result == 0 then
			getProxy = var_2_3
			NewEducateProxy = var_2_10002

			local var_2_0 = var_2_3(var_2_10002)
			local var_2_1 = var_2_3.GetCurChar(var_2_0)

			var_2_3.SetCallName(var_2_1, var_1_1)

			local var_2_2 = arg_1_0

			var_2_3 = var_2_3.sendNotification
			GAME = var_3

			var_2_3(var_2_2, var_3.NEW_EDUCATE_SET_CALL_DONE)
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_4, "NewEducate_SetCall: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
