local var_0_0 = {}

manager.net:Bind(34101, function(arg_1_0)
	BigMonthCardData:InitData(arg_1_0)
	var_0_0.RefreshRedPoint()
end)

function var_0_0.SignToday()
	manager.net:SendWithLoadingNew(34110, {}, 34111, var_0_0.OnSignToday)
end

function var_0_0.OnSignToday(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		BigMonthCardData:SetRecord(arg_3_0.daily_record)
		BigMonthCardData:UpdateIsSign(arg_3_0.is_sign)
		BigMonthCardData:UpdateSignData(arg_3_0.total_sign_times)

		local var_3_0 = BigMonthCardData:GetHaveSign()
		local var_3_1 = -1

		if #arg_3_0.total_sign_receive_list > #var_3_0 then
			local var_3_2 = arg_3_0.total_sign_receive_list[1]
			local var_3_3 = BigMonthCardAccumulationCfg[var_3_2].template_id

			var_3_1 = table.indexof(BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_3_3], var_3_2)

			BigMonthCardData:SignAccumulate(arg_3_0.total_sign_receive_list)
		end

		manager.notify:CallUpdateFunc(BIG_MONTH_CARD_SIGN, arg_3_0.rewards, arg_3_0, var_3_1)
		var_0_0.RefreshRedPoint()
	else
		ShowTips(arg_3_0.result)
	end
end

function var_0_0.BuyBigMonthCard()
	manager.net:SendWithLoadingNew(34114, {}, 34115, var_0_0.OnBuyBigMonthCard)
end

function var_0_0.OnBuyBigMonthCard(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		manager.notify:Invoke(BUY_BIG_MONTH_CARD)
		ShowTips("TRANSACTION_SUCCESS")
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.RefreshRedPoint()
	if BigMonthCardData:HaveMonthCard() and (not BigMonthCardData:IsSignToday() or BigMonthCardData:IsNeedAccumulatSign()) then
		manager.redPoint:setTip(RedPointConst.BIG_MONTH_CARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.BIG_MONTH_CARD, 0)
	end
end

function var_0_0.FirstLoginSinceMonthCardFinish()
	manager.net:SendWithLoadingNew(34116, {}, 34117, var_0_0.OnFirstLoginSinceMonthCardFinish)
end

function var_0_0.OnFirstLoginSinceMonthCardFinish(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		BigMonthCardData:SetIsExpireTip()
	else
		ShowTips(arg_8_0.result)
	end
end

return var_0_0
