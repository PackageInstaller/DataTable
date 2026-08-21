local var_0_0 = class("GetChargeListCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(16104, {
		type = 0
	}, 16105, function(arg_2_0)
		for iter_2_0, iter_2_1 in ipairs(arg_2_0.pay_list) do
			local var_2_0 = Goods.Create(iter_2_1, Goods.TYPE_CHARGE)

			;({})[var_2_0.id] = var_2_0
		end

		for iter_2_2, iter_2_3 in ipairs(arg_2_0.first_pay_list) do
			table.insert({}, iter_2_3)
		end

		for iter_2_4, iter_2_5 in ipairs(arg_2_0.normal_list) do
			local var_2_1 = Goods.Create(iter_2_5, Goods.TYPE_GIFT_PACKAGE)

			;({})[var_2_1.id] = var_2_1

			table.insert({}, iter_2_5)
		end

		for iter_2_6, iter_2_7 in ipairs(arg_2_0.normal_group_list) do
			table.insert({}, iter_2_7)
		end

		local var_2_2 = getProxy(ShopsProxy)

		var_2_2.refreshChargeList = false

		var_2_2:setChargedList({})
		var_2_2:setFirstChargeList({})
		var_2_2:setNormalList({})
		var_2_2:setNormalGroupList({})
		arg_1_0:sendNotification(GAME.GET_CHARGE_LIST_DONE, {
			chargedList = {},
			firstChargeIds = {},
			normalList = {},
			normalGroupList = {}
		})

		if var_1_0 and var_1_0.callback then
			var_1_0.callback()
		end

		return
	end)

	return
end

return var_0_0
