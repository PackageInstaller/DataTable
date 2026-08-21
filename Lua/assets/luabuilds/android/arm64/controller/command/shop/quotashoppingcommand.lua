local var_0_0 = class("QuotaShoppingCommand", pm.SimpleCommand)

var_0_0.QUOTA_SHOP = 4

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.count
	local var_1_4 = getProxy(ShopsProxy)
	local var_1_5 = getProxy(ShopsProxy):getQuotaShop():getGoodsCfg(var_1_0.id)
	local var_1_6 = Drop.New({
		type = var_1_5.resource_category,
		id = var_1_5.resource_type
	})

	if var_1_6:getOwnedCount() < var_1_5.resource_num * var_1_0.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_x", var_1_6:getName()))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(16201, {
		id = var_1_0.id,
		type = var_0_0.QUOTA_SHOP,
		count = var_1_0.count
	}, 16202, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_4:updateQuotaShop((var_1_4:getQuotaShop()))
			reducePlayerOwn({
				type = var_1_5.resource_category,
				id = var_1_5.resource_type,
				count = var_1_5.resource_num * var_1_2
			})
			arg_1_0:sendNotification(GAME.QUOTA_SHOPPING_DONE, {
				awards = PlayerConst.addTranDrop(arg_2_0.drop_list),
				id = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
