class = var_0_10000

local var_0_0 = "NewEducateGiveUpEntryUpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 29124, {
		id = var_1_1
	}, 29125, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.GetPriorityState(var_2_2)

			var_2.MarkFinish(var_2_3)
			var_1:CheckPriorityStystem()

			local var_2_4 = arg_1_0
			local var_2_5 = var_3.sendNotification

			GAME = var_2_10006

			var_2_5(var_2_4, var_2_10006.NEW_EDUCATE_GIVE_UP_ENTRY_UP_DONE)
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, "NewEducate_GiveUpEntry_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
