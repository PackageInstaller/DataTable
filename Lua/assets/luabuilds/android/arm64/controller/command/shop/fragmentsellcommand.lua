local var_0_0 = class("FragmentSellCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(BagProxy)
	local var_1_1 = getProxy(PlayerProxy):getRawData()
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs((arg_1_1:getBody())) do
		if var_1_0:getItemCountById(iter_1_1.id) < iter_1_1.count then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", iter_1_1:getConfig("name")))

			return
		end

		local var_1_3 = iter_1_1:getConfig("price")
		local var_1_4 = ({})[var_1_3[1]]

		if not ({})[var_1_3[1]] then
			var_1_4 = 0
		end

		;({})[var_1_3[1]] = var_1_4 + var_1_3[2] * iter_1_1.count

		table.insert({}, {
			id = iter_1_1.id,
			count = iter_1_1.count
		})
	end

	pg.ConnectionMgr.GetInstance():Send(15008, {
		item_list = {}
	}, 15009, function(arg_2_0)
		if arg_2_0.result == 0 then
			for iter_2_0, iter_2_1 in ipairs(var_0) do
				reducePlayerOwn(iter_2_1)
			end

			for iter_2_2, iter_2_3 in pairs(var_1_2) do
				addPlayerOwn({
					type = DROP_TYPE_RESOURCE,
					id = iter_2_2,
					count = iter_2_3
				})
				table.insert({}, {
					type = DROP_TYPE_RESOURCE,
					id = iter_2_2,
					count = iter_2_3
				})
			end

			arg_1_0:sendNotification(GAME.FRAG_SELL_DONE, {
				awards = {}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
