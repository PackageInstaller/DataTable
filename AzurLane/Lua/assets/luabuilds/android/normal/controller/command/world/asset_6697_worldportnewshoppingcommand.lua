class = var_0_10000

local var_0_0 = "WorldPortNewShoppingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().goods
	local var_1_1 = var_2.count

	if not var_1_0:canPurchase() then
		pg = var_5

		local var_1_2 = var_5.TipsMgr.GetInstance()
		local var_1_3 = var_5.ShowTips

		i18n = var_1_10007

		var_1_3(var_1_2, var_1_10007("buy_countLimit"))

		return
	end

	var_5.count = var_1_0:GetPriceInfo().count * var_1_1

	local var_1_5

	if var_5:getOwnedCount() < var_5.count then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10008

		var_1_5(var_1_4, var_1_10008("buyProp_noResource_error", var_5:getName()))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_6.Send(var_1_6, 33403, {
		shop_type = 2,
		shop_id = var_1_0.id,
		count = var_1_1
	}, 33404, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			reducePlayerOwn = var_2_2

			var_2_2(var_0)

			nowWorld = var_2_2

			local var_2_0 = var_2_2()
			local var_2_1 = var_2_2.GetAtlas(var_2_0)

			var_2_2.UpdateNShopGoodsCount(var_2_1, var_1_0.id, var_1_1)

			PlayerConst = var_2_2
			var_2_2 = var_2_2.addTranDrop(arg_2_0.drop_list)
			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.WORLD_PORT_NEW_SHOPPING_DONE, {
				drops = var_2_2
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("world_port_shopping_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
