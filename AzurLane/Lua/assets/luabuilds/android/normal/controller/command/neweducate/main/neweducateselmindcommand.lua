class = var_0_10000

local var_0_0 = "NewEducateSelMindCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id

	getProxy = var_1_10004
	NewEducateProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetCurChar(var_1_1)
	local var_1_3 = var_4.GetFSM(var_1_2)
	local var_1_5

	if var_4.CheckPriorityStystem(var_1_3) then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10006

		var_1_5(var_1_4, var_1_10006("child2_priority_tip"))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_4.Send(var_1_6, 29090, {
		id = var_1_0
	}, 29091, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			NewEducateProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)
			local var_2_1 = var_1.GetCurChar(var_2_0)
			local var_2_2 = var_1.GetFSM(var_2_1)
			local var_2_3 = var_1.SetSystemNo

			NewEducateFSM = var_2_10004

			var_2_3(var_2_2, var_2_10004.SYSTEM.MIND)

			NewEducateStateBase = var_2_3

			local var_2_4 = var_2_3.New()
			local var_2_5 = var_1
			local var_2_6 = var_1.SetState

			NewEducateFSM = var_2_10005

			var_2_6(var_2_5, var_2_10005.SYSTEM.MIND, var_2_4)

			NewEducateDropHelper = var_2_6

			local var_2_7 = var_2_6.HandleDrops(arg_2_0.drop)
			local var_2_8 = arg_1_0
			local var_2_9 = var_4.sendNotification

			GAME = var_6

			var_2_9(var_2_8, var_6.NEW_EDUCATE_SEL_MIND_DONE, {
				drops = var_2_7,
				node = arg_2_0.first_node
			})
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_10, "NewEducate_SelMind: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
