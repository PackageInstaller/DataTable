local var_0_0 = singletonClass("CommunityData")
local var_0_1 = {
	welfareType = 0,
	currenyA = 0
}

function var_0_0.Init(arg_1_0)
	var_0_1 = {
		welfareType = 0,
		currenyA = 0
	}
	arg_1_0.welfareExchangeCnt_ = 0
end

function var_0_0.RefreshCurrencyA(arg_2_0, arg_2_1)
	var_0_1.currenyA = arg_2_1

	manager.notify:Invoke(CURRENCY_UPDATE, CurrencyConst.CURRENCY_TYPE_CLUB_COIN_A)
end

function var_0_0.GetIdentity(arg_3_0)
	return GuildData:GetGuildInfo().post or 1
end

function var_0_0.SetWelfareType(arg_4_0, arg_4_1)
	var_0_1.welfareType = arg_4_1
end

function var_0_0.GetWelfareType(arg_5_0)
	return var_0_1.welfareType
end

function var_0_0.GetCurrenyA(arg_6_0)
	return var_0_1.currenyA
end

function var_0_0.SetWealfareExchangeCnt(arg_7_0, arg_7_1)
	arg_7_0.welfareExchangeCnt_ = arg_7_1

	manager.notify:Invoke(GUILD_WELFRE_CNT_REFRESH)
end

function var_0_0.GetWelfareExchangeCnt(arg_8_0)
	return arg_8_0.welfareExchangeCnt_
end

function var_0_0.CommunityExit(arg_9_0)
	arg_9_0:SetWelfareType(CommunityConst.WELFARE_TYPE.CLOSE)
	CommunityAction:RefreshRedPoint()
end

return var_0_0
