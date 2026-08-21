local var_0_0 = class("ChargeConfirmCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.payId
	local var_1_2 = var_1_0.bsId or ""
	local var_1_3 = getProxy(ShopsProxy)

	pg.ConnectionMgr.GetInstance():Send(11504, {
		pay_id = var_1_0.payId,
		pay_id_bili = var_1_2
	}, 11505, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:removeChargeTimer(var_1_1)
			arg_1_0:sendNotification(GAME.CHARGE_SUCCESS, {
				shopId = arg_2_0.shop_id,
				payId = var_1_1,
				gem = arg_2_0.gem,
				gem_free = arg_2_0.gem_free
			})
		elseif arg_2_0.result == 4 then
			arg_1_0:sendNotification(GAME.CHARGE_CONFIRM_FAILED, {
				payId = var_1_1,
				bsId = var_1_2
			})
		else
			var_1_3:removeChargeTimer(var_1_1)

			if arg_2_0.result ~= 1 then
				pg.TipsMgr.GetInstance():ShowTips(errorTip("charge", arg_2_0.result))
			end
		end

		return
	end)

	return
end

return var_0_0
