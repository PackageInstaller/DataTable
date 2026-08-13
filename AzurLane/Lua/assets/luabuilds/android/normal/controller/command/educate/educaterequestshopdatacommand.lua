class = var_0_10000

local var_0_0 = "EducateRequestShopDataCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	pg = var_1_10004

	local var_1_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_1_1, 27043, {
		shop_id = var_2.shopId,
		goods = var_2.goods
	}, 27044, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			EducateShop = var_2_0
			var_2_0 = var_2_0.New(arg_2_0.shop_data.shop_id, arg_2_0.shop_data.goods)
			getProxy = var_2
			EducateProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)
			var_2_10003 = var_2.GetShopProxy(var_2_10003)

			var_2.UpdateShop(var_2_10003, var_2_0)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.EDUCATE_REQUEST_SHOP_DATA_DONE)

			if var_1_0 then
				var_1_0()
			end
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_3(var_2_2, var_2_10003("educate request shop data error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
