class = var_0_10000

local var_0_0 = "NewEducateGiveUpChoiceCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 29101, {
		id = var_1_1
	}, 29102, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.GetPriorityState(var_2_2)

			var_2.MarkFinish(var_2_3)
			var_1:CheckPriorityStystem()

			NewEducateDropHelper = var_3

			local var_2_4 = var_3.HandleDrops(arg_2_0.drop)
			local var_2_5 = arg_1_0
			local var_2_6 = var_4.sendNotification

			GAME = var_2_10007

			var_2_6(var_2_5, var_2_10007.NEW_EDUCATE_GIVE_UP_CHOICE_DONE, {
				drops = var_2_4
			})
		else
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_7, "NewEducate_GiveUpChoice_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
