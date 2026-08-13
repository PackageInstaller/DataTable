class = var_0_10000

local var_0_0 = "ExchangeLoveLetterItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	ActivityProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getActivityById(var_1_2, var_1_1.activity_id) or var_4:isEnd() or var_4.data1 <= 0 then
		return
	end

	pg = var_1_2

	local var_1_3 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 11202, {
		cmd = 1,
		activity_id = var_1_1.activity_id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_0 = var_1.getActivityById(var_2_0, var_1_1.activity_id)
			var_0.data1 = var_0.data1 - 1

			local var_2_1 = var_0

			var_1.updateActivity(var_2_1, var_0)

			ipairs = var_1

			for iter_2_0, iter_2_1 in var_1(arg_2_0.award_list) do
				Drop = var_2_10006

				local var_2_2 = var_2_10006.New({
					type = iter_2_1.type,
					id = iter_2_1.id,
					count = iter_2_1.number
				})

				var_2_10006 = var_2_10006.getSubClass(var_2_2)
				getProxy = var_2_2
				BagProxy = var_8

				local var_2_3 = var_2_2(var_8)

				var_7.removeItemById(var_2_3, var_2_10006.id, var_2_10006.count, var_2_10006.extra)
			end

			pg = var_1

			local var_2_4 = var_1.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			i18n = var_2_10003

			var_2_5(var_2_4, var_2_10003("loveletter_exchange_tip3"))
		elseif arg_2_0.result == 20 then
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10003

			var_2_7(var_2_6, var_2_10003("loveletter_exchange_tip1"))
		else
			local var_2_9

			if arg_2_0.result == 21 then
				pg = var_2_9

				local var_2_8 = var_2_9.TipsMgr.GetInstance()

				var_2_9 = var_2_9.ShowTips
				i18n = var_2_10003

				var_2_9(var_2_8, var_2_10003("loveletter_exchange_tip2"))
			else
				pg = var_2_9

				local var_2_10 = var_2_9.TipsMgr.GetInstance()
				local var_2_11 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_11(var_2_10, var_2_10003("", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
