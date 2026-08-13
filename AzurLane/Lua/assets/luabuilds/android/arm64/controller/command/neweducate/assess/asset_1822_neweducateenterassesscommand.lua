class = var_0_10000

local var_0_0 = "NewEducateEnterAssessCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback
	local var_1_1 = var_2.id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 29050, {
		id = var_1_1
	}, 29051, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10003

			local var_2_0 = var_1(var_2_10003)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)

			var_1.SetCurNode(var_2_2, 0)

			local var_2_3 = var_1
			local var_2_4 = var_1.SetSystemNo

			NewEducateFSM = var_5

			var_2_4(var_2_3, var_5.SYSTEM.ASSESS)

			getProxy = var_2_4
			NewEducateProxy = var_2_3

			local var_2_5 = var_2_4(var_2_3)
			local var_2_6 = var_2.GetCurChar(var_2_5)
			local var_2_7 = var_2.GetAssessRankIdx(var_2_6)

			NewEducateAssessState = var_2_1

			local var_2_8 = var_2_1.New({
				is_finished = var_2_7 == 0 and 1 or 0
			})
			local var_2_9 = var_1
			local var_2_10 = var_1.SetState

			NewEducateFSM = var_2_10007

			var_2_10(var_2_9, var_2_10007.SYSTEM.ASSESS, var_2_8)

			NewEducateDropHelper = var_2_10

			local var_2_11 = var_2_10.HandleDrops(arg_2_0.drop)
			local var_2_12 = arg_1_0
			local var_2_13 = var_5.sendNotification

			GAME = var_8

			var_2_13(var_2_12, var_8.NEW_EDUCATE_ENTER_ASSESS_DONE, {
				drops = var_2_11,
				callback = var_1_0
			})
		else
			pg = var_1

			local var_2_14 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_14, "NewEducate_EnterAssess: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
