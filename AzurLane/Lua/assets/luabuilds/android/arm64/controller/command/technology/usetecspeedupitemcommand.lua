class = var_0_10000

local var_0_0 = "UseTecSpeedUpItemCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().blueprintid
	local var_1_1 = var_2.itemid
	local var_1_2 = var_2.number
	local var_1_3 = var_2.taskID

	pg = var_1_10007

	local var_1_4 = var_1_10007.ConnectionMgr.GetInstance()

	var_7.Send(var_1_4, 63210, {
		blueprintid = var_1_0,
		itemid = var_1_1,
		number = var_1_2,
		task_id = var_1_3
	}, 63211, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			getProxy = var_2_2
			BagProxy = var_2_10003

			local var_2_0 = var_2_2(var_2_10003)

			var_2_2.removeItemById(var_2_0, var_1_1, var_1_2)

			local var_2_1 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_4

			var_2_2(var_2_1, var_4.USE_TEC_SPEEDUP_ITEM_DONE)
		else
			pg = var_2_2

			local var_2_3 = var_2_2.TipsMgr.GetInstance()

			var_1.ShowTips(var_2_3, "Error Code" .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
