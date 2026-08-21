local var_0_0 = class("SellItemCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.items
	local var_1_2 = var_1_0.callback
	local var_1_3 = getProxy(BagProxy)

	for iter_1_0, iter_1_1 in pairs(var_1_0.items) do
		if var_1_3:getItemCountById(iter_1_1.id) < iter_1_1.count then
			local var_1_4 = var_1_3:RawGetItemById(iter_1_1.id)

			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", var_1_4:getConfig("name")))

			if var_1_0.callback then
				var_1_0.callback(false)
			end

			return
		end
	end

	pg.ConnectionMgr.GetInstance():Send(15008, {
		item_list = var_1_0.items
	}, 15009, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in pairs(var_1_1) do
				reducePlayerOwn(Drop.Create({
					DROP_TYPE_ITEM,
					iter_2_1.id,
					iter_2_1.count
				}))
			end

			for iter_2_2, iter_2_3 in pairs((var_1_3:GetSellingPrice(var_1_1))) do
				local var_2_0 = Drop.Create(iter_2_3)

				if var_2_0.count > 0 then
					addPlayerOwn(var_2_0)
					table.insert({}, var_2_0)
				end
			end

			arg_1_0:sendNotification(GAME.SELL_ITEM_DONE, {
				awards = {}
			})

			if var_1_2 then
				var_1_2({})
			end
		else
			if var_1_2 then
				var_1_2(nil)
			end

			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
