class = var_0_10000

local var_0_0 = "IslandNodeMarkCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 11202, {
		cmd = 2,
		activity_id = var_1_0.act_id,
		arg1 = var_1_0.node_id
	}, 11203, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			getProxy = var_2_1
			SixthAnniversaryIslandProxy = var_2_10003

			local var_2_0 = var_2_1(var_2_10003)

			var_2_1 = var_2_1.GetNode(var_2_0, var_1_0.node_id)
			var_2_1.isNew = false
			pg = var_2_1

			local var_2_2 = var_2_1.m02

			var_2_1 = var_2_1.sendNotification
			GAME = var_4

			var_2_1(var_2_2, var_4.ISLAND_NODE_MARK_DONE, {
				node_id = var_1_0.node_id
			})
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_3, "Trigger island event failed:" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
