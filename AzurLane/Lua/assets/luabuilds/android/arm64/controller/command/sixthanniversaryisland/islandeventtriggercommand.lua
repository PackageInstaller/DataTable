class = var_0_10000

local var_0_0 = "IslandEventTriggerCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_10003
	SixthAnniversaryIslandProxy = var_1_10005

	local var_1_2 = var_1_10003(var_1_10005)
	local var_1_3 = var_3.GetNode(var_1_2, var_1_1.node_id)

	IslandEvent = var_1_0

	local var_1_4 = var_1_0.New({
		id = var_1_3.eventId
	})
	local var_1_5, var_1_6 = var_4.CheckTrigger(var_1_4, var_1_1.op)

	if not var_1_5 then
		pg = var_1_4

		local var_1_7 = var_1_4.TipsMgr.GetInstance()

		var_1_4.ShowTips(var_1_7, var_1_6)

		return
	end

	pg = var_1_4

	local var_1_8 = var_1_4.ConnectionMgr.GetInstance()

	var_7.Send(var_1_8, 11202, {
		cmd = 1,
		activity_id = var_1_1.act_id,
		arg1 = var_1_1.node_id,
		arg2 = var_1_1.op
	}, 11203, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.AfterTrigger(var_2_0, var_1_1.op)

			getProxy = var_2_2
			SixthAnniversaryIslandProxy = var_2_0

			local var_2_1 = var_2_2(var_2_0)

			var_2_2 = var_2_2.GetNode(var_2_1, var_1_1.node_id)
			var_2_2.eventId = arg_2_0.number[1]
			PlayerConst = var_2

			local var_2_3 = var_2.addTranDrop(arg_2_0.award_list)

			pg = var_2_1

			local var_2_4 = var_2_1.m02
			local var_2_5 = var_3.sendNotification

			GAME = var_2_10006

			var_2_5(var_2_4, var_2_10006.ISLAND_EVENT_TRIGGER_DONE, {
				awards = var_2_3,
				node_id = var_2_2.id
			})
		else
			pg = var_2_2

			local var_2_6 = var_2_2.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_6, "Trigger island event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
