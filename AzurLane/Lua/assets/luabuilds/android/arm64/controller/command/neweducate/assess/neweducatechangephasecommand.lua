class = var_0_10000

local var_0_0 = "NewEducateChangePhaseCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).id

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 29025, {
		id = var_1_1
	}, 29026, function(arg_2_0)
		if arg_2_0.result == 0 then
			NewEducateHelper = var_1

			var_1.TrackRoundEnd()

			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)

			var_2.SetCurNode(var_2_2, arg_2_0.first_node)

			local var_2_3 = var_1:GetFSM()
			local var_2_4 = var_2.SetSystemNo

			NewEducateFSM = var_5

			var_2_4(var_2_3, var_5.SYSTEM.PHASE)

			getProxy = var_2_4
			NewEducateProxy = var_2_3

			local var_2_5 = var_2_4(var_2_3)

			var_2.NextRound(var_2_5)

			NewEducateDropHelper = var_2

			local var_2_6 = var_2.HandleDrops(arg_2_0.drop)
			local var_2_7 = arg_1_0
			local var_2_8 = var_3.sendNotification

			GAME = var_2_10006

			var_2_8(var_2_7, var_2_10006.NEW_EDUCATE_CHANGE_PHASE_DONE, {
				drops = var_2_6,
				node = arg_2_0.first_node
			})
		else
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_9, "NewEducate_ChangePhase: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
