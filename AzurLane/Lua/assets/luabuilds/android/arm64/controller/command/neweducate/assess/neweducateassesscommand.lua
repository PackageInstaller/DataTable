class = var_0_10000

local var_0_0 = "NewEducateAssessCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0

	var_1_0 = arg_1_1:getBody() and var_2.callback

	local var_1_1 = var_2.id
	local var_1_2 = var_2.rank
	local var_1_3 = var_2.endlessFail

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 29013, {
		id = var_1_1,
		rank = var_1_2
	}, 29014, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)

			var_2.SetCurNode(var_2_2, arg_2_0.first_node)

			local var_2_3 = var_1:GetFSM()
			local var_2_4 = var_2.SetSystemNo

			NewEducateFSM = var_5

			var_2_4(var_2_3, var_5.SYSTEM.ASSESS)

			local var_2_5 = var_1:GetFSM()
			local var_2_6 = var_2.GetState

			NewEducateFSM = var_5

			local var_2_7 = var_2_6(var_2_5, var_5.SYSTEM.ASSESS)

			var_2.MarkFinish(var_2_7)

			if var_1_3 then
				local var_2_8 = var_1:GetRoundData()

				var_2.SetEndlessFail(var_2_8)
			end

			var_1:AddAssessRecord(var_1:GetRoundData().round, var_1_2)

			NewEducateDropHelper = var_2

			local var_2_9 = var_2.HandleDrops(arg_2_0.drop)
			local var_2_10 = arg_1_0
			local var_2_11 = var_3.sendNotification

			GAME = var_6

			var_2_11(var_2_10, var_6.NEW_EDUCATE_ASSESS_DONE, {
				drops = var_2_9,
				node = arg_2_0.first_node
			})
		else
			pg = var_1

			local var_2_12 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_12, "NewEducate_Assess: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
