class = var_0_10000

local var_0_0 = "WorldPortShoppingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if arg_1_1:getBody().goods.count <= 0 then
		pg = var_4

		local var_1_0 = var_4.TipsMgr.GetInstance()
		local var_1_1 = var_4.ShowTips

		i18n = var_1_10006

		var_1_1(var_1_0, var_1_10006("buy_countLimit"))

		return
	end

	local var_1_2 = var_3.moneyItem
	local var_1_4

	if var_4.getOwnedCount(var_1_2) < var_4.count then
		pg = var_1_4

		local var_1_3 = var_1_4.TipsMgr.GetInstance()

		var_1_4 = var_1_4.ShowTips
		i18n = var_1_10007

		var_1_4(var_1_3, var_1_10007("buyProp_noResource_error", var_4:getName()))

		return
	end

	pg = var_1_4

	local var_1_5 = var_1_4.ConnectionMgr.GetInstance()

	var_5.Send(var_1_5, 33403, {
		count = 1,
		shop_type = 1,
		shop_id = var_3.id
	}, 33404, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_1.UpdateCount(var_2_0, var_0.count - 1)

			reducePlayerOwn = var_1

			var_1(var_0)

			nowWorld = var_1
			var_2_10003 = var_1()
			var_2_10003 = var_1.GetActiveMap(var_2_10003)

			local var_2_1 = var_2.GetPort(var_2_10003)

			underscore = var_2_10003
			var_2_10003 = var_2_10003.filter(var_2_1.goods, function(arg_3_0)
				return arg_3_0.count > 0
			end)

			local var_2_2 = var_1:GetAtlas()

			var_4.UpdatePortMark(var_2_2, var_2_1.id, #var_2_10003 > 0)

			PlayerConst = var_4

			local var_2_3 = var_4.addTranDrop(arg_2_0.drop_list)
			local var_2_4 = arg_1_0
			local var_2_5 = var_5.sendNotification

			GAME = var_7

			var_2_5(var_2_4, var_7.WORLD_PORT_SHOPPING_DONE, {
				drops = var_2_3
			})
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_7(var_2_6, var_2_10003("world_port_shopping_error_", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
