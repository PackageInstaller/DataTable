class = var_0_10000

local var_0_0 = "BackYardRequestPopEventCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 19009, {
		type = 0
	}, 19010, function(arg_2_0)
		getProxy = var_2_10001
		DormProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_1 = var_1.getRawData(var_2_0)

		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.pop_list) do
			local var_2_2 = iter_2_1.id
			local var_2_3 = iter_2_1.intimacy
			local var_2_4 = iter_2_1.dorm_icon
			local var_2_5 = var_2_1

			var_2_1.AddInimacyAndMoney(var_2_5, var_2_2, var_2_3, var_2_4)

			getProxy = var_10
			DormProxy = var_2_5

			local var_2_6 = var_10(var_2_5)
			local var_2_7 = var_10.updateDrom
			local var_2_8 = var_2_1

			BackYardConst = var_13

			var_2_7(var_2_6, var_2_8, var_13.DORM_UPDATE_TYPE_SHIP)

			local var_2_9 = arg_1_0
			local var_2_10 = var_10.sendNotification

			DormProxy = var_2_8

			var_2_10(var_2_9, var_2_8.INIMACY_AND_MONEY_ADD, {
				id = var_2_2,
				intimacy = var_2_3,
				money = var_2_4
			})
		end

		return
	end)

	return
end

return var_0_1
