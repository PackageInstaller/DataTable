local var_0_0 = {}

manager.net:Bind(31207, function(arg_1_0)
	CommunityData:SetWelfareType(arg_1_0.state)
	CommunityAction:RefreshRedPoint()
end)
manager.net:Bind(31209, function(arg_2_0)
	CommunityData:RefreshCurrencyA(arg_2_0.num)
	CommunityData:SetWealfareExchangeCnt(arg_2_0.special_reward_remain_time)
end)

function var_0_0.OpenWelfare(arg_3_0)
	manager.net:SendWithLoadingNew(31200, {}, 31201, handler(arg_3_0, arg_3_0.OnOpenWelfare))
end

function var_0_0.OnOpenWelfare(arg_4_0, arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		ShowTips("CLUB_WELFARE_OPEN")
		CommunityData:SetWelfareType(CommunityConst.WELFARE_TYPE.RECEIVE)
		arg_4_0:RefreshRedPoint()
	else
		ShowTips(arg_4_1.result)
	end
end

function var_0_0.BuySpecialWelfare(arg_5_0, arg_5_1)
	local var_5_0 = {
		num = arg_5_1
	}

	manager.net:SendWithLoadingNew(31202, var_5_0, 31203, handler(arg_5_0, arg_5_0.OnBuySpecialWelfare))
end

function var_0_0.OnBuySpecialWelfare(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_1.result) then
		local var_6_0 = CommunityData:GetWelfareExchangeCnt() - arg_6_2.num

		CommunityData:SetWealfareExchangeCnt(var_6_0)
		manager.notify:CallUpdateFunc(COMMUNITY_BUY_SPECIAL_WELFARE)
		manager.notify:CallUpdateFunc(COMMUNITY_REFRESH_WELFARE)
	else
		ShowTips(arg_6_1.result)
	end
end

function var_0_0.ReceiveWelfare(arg_7_0)
	manager.net:SendWithLoadingNew(31204, {}, 31205, handler(arg_7_0, arg_7_0.OnReceiveWelfare))
end

function var_0_0.OnReceiveWelfare(arg_8_0, arg_8_1, arg_8_2)
	if isSuccess(arg_8_1.result) then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_1.give_items or {}) do
			local var_8_1 = {
				id = iter_8_1.id,
				num = iter_8_1.num
			}

			table.insert(var_8_0, var_8_1)
		end

		getReward(var_8_0)
		CommunityData:SetWelfareType(CommunityConst.WELFARE_TYPE.FINISH)
		arg_8_0:RefreshRedPoint()
		manager.notify:CallUpdateFunc(COMMUNITY_RECEIVE_WELFARE)
	else
		ShowTips(arg_8_1.result)
	end
end

function var_0_0.RefreshCurrencyA(arg_9_0)
	manager.net:SendWithLoadingNew(31208, {}, 31209)
end

function var_0_0.RefreshRedPoint(arg_10_0)
	arg_10_0:RefreshWelfare()
end

function var_0_0.RefreshWelfare(arg_11_0)
	local var_11_0 = CommunityData:GetWelfareType()

	manager.redPoint:setTip(RedPointConst.CLUB_WELFARE, var_11_0 == CommunityConst.WELFARE_TYPE.RECEIVE and 1 or 0)
	manager.notify:CallUpdateFunc(COMMUNITY_REFRESH_WELFARE)
end

return var_0_0
