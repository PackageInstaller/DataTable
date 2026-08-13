class = var_0_10000

local var_0_0 = "QuotaShoppingCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

var_0_1.QUOTA_SHOP = 4

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count
	local var_1_2 = var_2.type

	getProxy = var_1_10006
	ShopsProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)
	local var_1_4 = var_6.getQuotaShop(var_1_3)
	local var_1_5 = var_7.getGoodsCfg(var_1_4, var_1_0)

	Drop = var_1_3

	local var_1_6 = var_1_3.New({
		type = var_1_5.resource_category,
		id = var_1_5.resource_type
	})
	local var_1_8

	if var_9.getOwnedCount(var_1_6) < var_1_5.resource_num * var_1_1 then
		pg = var_1_8

		local var_1_7 = var_1_8.TipsMgr.GetInstance()

		var_1_8 = var_1_8.ShowTips
		i18n = var_1_10013

		var_1_8(var_1_7, var_1_10013("common_no_x", var_9:getName()))

		return
	end

	pg = var_1_8

	local var_1_9 = var_1_8.ConnectionMgr.GetInstance()

	var_10.Send(var_1_9, 16201, {
		id = var_1_0,
		type = var_0_1.QUOTA_SHOP,
		count = var_1_1
	}, 16202, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			PlayerConst = var_2_0
			var_2_0 = var_2_0.addTranDrop(arg_2_0.drop_list)
			var_2_10004 = var_0

			local var_2_1 = var_2.getQuotaShop(var_2_10004)
			local var_2_2 = var_0

			var_3.updateQuotaShop(var_2_2, var_2_1)

			reducePlayerOwn = var_3

			var_3({
				type = var_1_5.resource_category,
				id = var_1_5.resource_type,
				count = var_1_5.resource_num * var_1_1
			})

			local var_2_3 = arg_1_0
			local var_2_4 = var_3.sendNotification

			GAME = var_6

			var_2_4(var_2_3, var_6.QUOTA_SHOPPING_DONE, {
				awards = var_2_0,
				id = var_1_0
			})
		else
			pg = var_2_0

			local var_2_5 = var_2_0.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_6(var_2_5, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
