class = var_0_10000

local var_0_0 = "AtelierRequestCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.body

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 26051, {
		act_id = var_1_0
	}, 26052, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			ActivityProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_2_10003 = var_1.getActivityById(var_2_0, var_1_0)

			var_1.InitItems(var_2_10003, arg_2_0.items)

			var_2_10003 = var_1

			var_1.InitFormulaUseCounts(var_2_10003, arg_2_0.recipes)

			var_2_10003 = var_1

			var_1.UpdateBuffSlots(var_2_10003, arg_2_0.slots)

			getProxy = var_2
			ActivityProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)

			var_2.updateActivity(var_2_10003, var_1)
		else
			pg = var_1

			local var_2_1 = var_1.TipsMgr.GetInstance()
			local var_2_2 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_2(var_2_1, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
