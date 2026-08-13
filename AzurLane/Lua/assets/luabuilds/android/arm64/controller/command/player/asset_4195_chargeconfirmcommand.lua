class = var_0_10000

local var_0_0 = "ChargeConfirmCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().payId
	local var_1_1

	if not var_2.bsId then
		var_1_1 = ""
	end

	getProxy = var_1_10005
	ShopsProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 11504, {
		pay_id = var_1_0,
		pay_id_bili = var_1_1
	}, 11505, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = var_1_2

			var_1.removeChargeTimer(var_2_0, var_1_0)

			local var_2_1 = arg_1_0
			local var_2_2 = var_1.sendNotification

			GAME = var_2_10004

			var_2_2(var_2_1, var_2_10004.CHARGE_SUCCESS, {
				shopId = arg_2_0.shop_id,
				payId = var_1_0,
				gem = arg_2_0.gem,
				gem_free = arg_2_0.gem_free
			})
		elseif arg_2_0.result == 4 then
			local var_2_3 = arg_1_0
			local var_2_4 = var_1.sendNotification

			GAME = var_2_10004

			var_2_4(var_2_3, var_2_10004.CHARGE_CONFIRM_FAILED, {
				payId = var_1_0,
				bsId = var_1_1
			})
		else
			local var_2_5 = var_1_2

			var_1.removeChargeTimer(var_2_5, var_1_0)

			if arg_2_0.result ~= 1 then
				pg = var_1

				local var_2_6 = var_1.TipsMgr.GetInstance()
				local var_2_7 = var_1.ShowTips

				errorTip = var_4

				var_2_7(var_2_6, var_4("charge", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
