class = var_0_10000

local var_0_0 = "GetChargeListCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_3.Send(var_1_2, 16104, {
		type = 0
	}, 16105, function(arg_2_0)
		local var_2_0 = {}

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.pay_list) do
			Goods = var_2_10007
			var_2_10007 = var_2_10007.Create
			var_2_10008 = iter_2_1
			Goods = var_2_10009
			var_2_0[var_2_10007(var_2_10008, var_2_10009.TYPE_CHARGE).id] = var_2_10007
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
			var_2_10010 = iter_2_5
			Goods = var_2_10011
			var_2_2[var_2_10009(var_2_10010, var_2_10011.TYPE_GIFT_PACKAGE).id] = var_2_10009
			table = var_2_10010

			var_2_10010.insert(var_2_2, iter_2_5)
		end

		local var_2_3 = {}

		ipairs = var_5

		for iter_2_6, iter_2_7 in var_5(arg_2_0.normal_group_list) do
			table = var_2_10010

			var_2_10010.insert(var_2_3, iter_2_7)
		end

		getProxy = var_5
		ShopsProxy = var_6

		local var_2_4 = var_5(var_6)

		var_2_4.refreshChargeList = false

		var_2_4:setChargedList(var_2_0)
		var_2_4:setFirstChargeList(var_2_1)
		var_2_4:setNormalList(var_2_2)
		var_2_4:setNormalGroupList(var_2_3)

		local var_2_5 = arg_1_0
		local var_2_6 = var_6.sendNotification

		GAME = var_8

		var_2_6(var_2_5, var_8.GET_CHARGE_LIST_DONE, {
			chargedList = var_2_0,
			firstChargeIds = var_2_1,
			normalList = var_2_2,
			normalGroupList = var_2_3
		})

		if var_1_1 and var_1_1.callback then
			var_1_1.callback()
		end

		return
	end)

	return
end

return var_0_1
