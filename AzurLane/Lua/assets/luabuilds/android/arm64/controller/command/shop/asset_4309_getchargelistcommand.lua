class = var_0_10000

local var_0_0 = "GetChargeListCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 16104, {
		type = 0
	}, 16105, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.pay_list) do
			Goods = var_2_10007
			var_2_10007 = var_2_10007.Create
			var_2_10009 = iter_2_1
			Goods = var_2_10010
			var_2_0[var_2_10007(var_2_10009, var_2_10010.TYPE_CHARGE).id] = var_2_10007
		end

		local var_2_1 = {}

		ipairs = var_3

		for iter_2_2, iter_2_3 in var_3(arg_2_0.first_pay_list) do
			table = var_2_10008

			var_2_10008.insert(var_2_1, iter_2_3)
		end

		local var_2_2 = {}

		ipairs = var_4

		for iter_2_4, iter_2_5 in var_4(arg_2_0.normal_list) do
			Goods = var_2_10009
			var_2_10009 = var_2_10009.Create

			local var_2_3 = iter_2_5

			Goods = var_2_10012
			var_2_2[var_2_10009(var_2_3, var_2_10012.TYPE_GIFT_PACKAGE).id] = var_2_10009
			table = var_2_10010

			var_2_10010.insert(var_2_2, iter_2_5)
		end

		local var_2_4 = {}

		ipairs = var_5

		for iter_2_6, iter_2_7 in var_5(arg_2_0.normal_group_list) do
			table = var_2_10010

			var_2_10010.insert(var_2_4, iter_2_7)
		end

		getProxy = var_5
		ShopsProxy = var_7

		local var_2_5 = var_5(var_7)

		var_2_5.refreshChargeList = false

		var_2_5:setChargedList(var_2_0)
		var_2_5:setFirstChargeList(var_2_1)
		var_2_5:setNormalList(var_2_2)
		var_2_5:setNormalGroupList(var_2_4)

		local var_2_6 = arg_1_0
		local var_2_7 = var_6.sendNotification

		GAME = var_9

		var_2_7(var_2_6, var_9.GET_CHARGE_LIST_DONE, {
			chargedList = var_2_0,
			firstChargeIds = var_2_1,
			normalList = var_2_2,
			normalGroupList = var_2_4
		})

		if var_1_0 and var_1_0.callback then
			var_1_0.callback()
		end

		return
	end)

	return
end

return var_0_1
