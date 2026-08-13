class = var_0_10000

local var_0_0 = "NewEducateMainEventCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 29011, {
		id = var_1_0
	}, 29012, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)

			var_1.SetCurNode(var_2_2, arg_2_0.first_node)

			local var_2_3 = var_1
			local var_2_4 = var_1.SetSystemNo

			NewEducateFSM = var_4

			var_2_4(var_2_3, var_4.SYSTEM.EVENT)

			if arg_2_0.first_node ~= 0 then
				local var_2_5 = arg_1_0
				local var_2_6 = var_2.sendNotification

				GAME = var_4

				var_2_6(var_2_5, var_4.NEW_EDUCATE_NODE_START, {
					node = arg_2_0.first_node
				})
			else
				local var_2_7 = arg_1_0
				local var_2_8 = var_2.sendNotification

				GAME = var_4

				var_2_8(var_2_7, var_4.NEW_EDUCATE_CHECK_FSM)
			end
		else
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_9, "NewEducate_MainEvent: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
