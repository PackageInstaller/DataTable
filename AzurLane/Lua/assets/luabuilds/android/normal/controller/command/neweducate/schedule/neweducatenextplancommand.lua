class = var_0_10000

local var_0_0 = "NewEducateNextPlanCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.rePlay

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29042, {
		id = var_1_0
	}, 29043, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)

			var_1.SetCurNode(var_2_2, arg_2_0.first_node)

			local var_2_3 = var_1
			local var_2_4 = var_1.GetState

			NewEducateFSM = var_4

			local var_2_5 = var_2_4(var_2_3, var_4.SYSTEM.PLAN)

			var_2.SetNextPlanIdx(var_2_5)

			NewEducateDropHelper = var_3

			local var_2_6 = var_3.HandleDrops(arg_2_0.drop)
			local var_2_7 = var_2:GetCurIdx() == var_2:GetIdxList()[1]
			local var_2_8 = arg_1_0
			local var_2_9 = var_5.sendNotification

			GAME = var_2_10007

			var_2_9(var_2_8, var_2_10007.NEW_EDUCATE_NEXT_PLAN_DONE, {
				drops = var_2_6,
				node = arg_2_0.first_node,
				isFristNode = var_2_7 or var_1_1
			})
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_10, "NewEducate_NextPlan: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
