local ExchangeLoveLetterItemCommand = class("ExchangeLoveLetterItemCommand", pm.SimpleCommand)

function ExchangeLoveLetterItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(ActivityProxy)
	local var_1_2 = var_1_1:getActivityById(var_1_0.activity_id)

	if not var_1_2 or var_1_2:isEnd() or var_1_2.data1 <= 0 then
		return
	end

	pg.ConnectionMgr.GetInstance():Send(11202, {
		cmd = 1,
		activity_id = var_1_0.activity_id
	}, 11203, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_2 = var_1_1:getActivityById(var_1_0.activity_id)
			var_1_2.data1 = var_1_2.data1 - 1

			var_1_1:updateActivity(var_1_2)

			for iter_2_0, iter_2_1 in ipairs(arg_2_0.award_list) do
				local var_2_0 = Drop.New({
					type = iter_2_1.type,
					id = iter_2_1.id,
					count = iter_2_1.number
				}):getSubClass()

				getProxy(BagProxy):removeItemById(var_2_0.id, var_2_0.count, var_2_0.extra)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_exchange_tip3"))
		elseif arg_2_0.result == 20 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_exchange_tip1"))
		elseif arg_2_0.result == 21 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_exchange_tip2"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ExchangeLoveLetterItemCommand
