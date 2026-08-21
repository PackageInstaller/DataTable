local var_0_0 = class("WorldPortShoppingCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().goods

	if var_1_0.count <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buy_countLimit"))

		return
	end

	local var_1_1 = var_1_0.moneyItem

	if var_1_0.moneyItem:getOwnedCount() < var_1_0.moneyItem.count then
		pg.TipsMgr.GetInstance():ShowTips(i18n("buyProp_noResource_error", var_1_1:getName()))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(33403, {
		count = 1,
		shop_type = 1,
		shop_id = var_1_0.id
	}, 33404, function(arg_2_0)
		local var_2_9000

		if arg_2_0.result == 0 then
			var_1_0:UpdateCount(var_1_0.count - 1)
			reducePlayerOwn(var_1_1)

			local var_2_0 = nowWorld()
			local var_2_1 = var_2_0:GetActiveMap()
			local var_2_2 = var_2_1.GetPort(var_2_9000)

			var_2_0:GetAtlas().UpdatePortMark(var_2_1, var_2_2.id, #underscore.filter(var_2_2.goods, function(arg_3_0)
				return arg_3_0.count > 0
			end) > 0)
			arg_1_0:sendNotification(GAME.WORLD_PORT_SHOPPING_DONE, {
				drops = PlayerConst.addTranDrop(arg_2_0.drop_list)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("world_port_shopping_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
