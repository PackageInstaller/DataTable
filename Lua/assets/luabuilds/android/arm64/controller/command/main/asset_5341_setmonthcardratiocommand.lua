local SetMonthCardRatioCommand = class("SetMonthCardRatioCommand", pm.SimpleCommand)

function SetMonthCardRatioCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(11601, {
		ratio = var_1_0
	}, 11602, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(PlayerProxy)
			local var_2_1 = var_2_0:getData()
			local var_2_2 = var_2_1:getCardById(VipCard.MONTH)

			if var_2_2 and not var_2_2:isExpire() then
				var_2_2.data = var_1_0

				var_2_1:addVipCard(var_2_2)
				var_2_0:updatePlayer(var_2_1)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("month_card_set_ratio_success"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("month_card_set_ratio_fail", arg_2_0.result))
		end

		return
	end)

	return
end

return SetMonthCardRatioCommand
