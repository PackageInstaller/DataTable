local var_0_0 = {}

manager.net:Bind(34101, function(arg_1_0)
	BigMonthCardData:InitData(arg_1_0)
	var_0_0.RefreshRedPoint()
end)

function var_0_0.SignToday()
	manager.net:SendWithLoadingNew(34110, {}, 34111, var_0_0.OnSignToday)
end

function var_0_0:OnSignToday(arg_3_1)
	if isSuccess(self.result) then
		BigMonthCardData:SetRecord(self.daily_record)
		BigMonthCardData:UpdateIsSign(self.is_sign)
		BigMonthCardData:UpdateSignData(self.total_sign_times)

		local var_3_0 = -1

		if #self.total_sign_receive_list > #BigMonthCardData:GetHaveSign() then
			var_3_0 = table.indexof(BigMonthCardAccumulationCfg.get_id_list_by_template_id[BigMonthCardAccumulationCfg[self.total_sign_receive_list[1]].template_id], self.total_sign_receive_list[1])

			BigMonthCardData:SignAccumulate(self.total_sign_receive_list)
		end

		manager.notify:CallUpdateFunc(BIG_MONTH_CARD_SIGN, self.rewards, self, var_3_0)
		var_0_0.RefreshRedPoint()
	else
		ShowTips(self.result)
	end
end

function var_0_0.BuyBigMonthCard()
	manager.net:SendWithLoadingNew(34114, {}, 34115, var_0_0.OnBuyBigMonthCard)
end

function var_0_0:OnBuyBigMonthCard(arg_5_1)
	if isSuccess(self.result) then
		manager.notify:Invoke(BUY_BIG_MONTH_CARD)
		ShowTips("TRANSACTION_SUCCESS")
	else
		ShowTips(self.result)
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

function var_0_0:OnFirstLoginSinceMonthCardFinish(arg_8_1)
	if isSuccess(self.result) then
		BigMonthCardData:SetIsExpireTip()
	else
		ShowTips(self.result)
	end
end

return var_0_0
