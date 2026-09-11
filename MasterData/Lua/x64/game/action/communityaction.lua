local var_0_0 = {}

manager.net:Bind(31207, function(arg_1_0)
	CommunityData:SetWelfareType(arg_1_0.state)
	CommunityAction:RefreshRedPoint()
end)
manager.net:Bind(31209, function(arg_2_0)
	CommunityData:RefreshCurrencyA(arg_2_0.num)
	CommunityData:SetWealfareExchangeCnt(arg_2_0.special_reward_remain_time)
end)

function var_0_0:OpenWelfare()
	manager.net:SendWithLoadingNew(31200, {}, 31201, handler(self, self.OnOpenWelfare))
end

function var_0_0:OnOpenWelfare(arg_4_1, arg_4_2)
	if isSuccess(arg_4_1.result) then
		ShowTips("CLUB_WELFARE_OPEN")
		CommunityData:SetWelfareType(CommunityConst.WELFARE_TYPE.RECEIVE)
		self:RefreshRedPoint()
	else
		ShowTips(arg_4_1.result)
	end
end

function var_0_0:BuySpecialWelfare(arg_5_1)
	manager.net:SendWithLoadingNew(31202, {
		num = arg_5_1
	}, 31203, handler(self, self.OnBuySpecialWelfare))
end

function var_0_0.OnBuySpecialWelfare(arg_6_0, arg_6_1, arg_6_2)
	if isSuccess(arg_6_1.result) then
		CommunityData:SetWealfareExchangeCnt(CommunityData:GetWelfareExchangeCnt() - arg_6_2.num)
		manager.notify:CallUpdateFunc(COMMUNITY_BUY_SPECIAL_WELFARE)
		manager.notify:CallUpdateFunc(COMMUNITY_REFRESH_WELFARE)
	else
		ShowTips(arg_6_1.result)
	end
end

function var_0_0:ReceiveWelfare()
	manager.net:SendWithLoadingNew(31204, {}, 31205, handler(self, self.OnReceiveWelfare))
end

function var_0_0:OnReceiveWelfare(arg_8_1, arg_8_2)
	if isSuccess(arg_8_1.result) then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_1.give_items or {}) do
			table.insert(var_8_0, {
				id = iter_8_1.id,
				num = iter_8_1.num
			})
		end

		getReward(var_8_0)
		CommunityData:SetWelfareType(CommunityConst.WELFARE_TYPE.FINISH)
		self:RefreshRedPoint()
		manager.notify:CallUpdateFunc(COMMUNITY_RECEIVE_WELFARE)
	else
		ShowTips(arg_8_1.result)
	end
end

function var_0_0.RefreshCurrencyA(arg_9_0)
	manager.net:SendWithLoadingNew(31208, {}, 31209)
end

function var_0_0:RefreshRedPoint()
	self:RefreshWelfare()
end

function var_0_0.RefreshWelfare(arg_11_0)
	manager.redPoint:setTip(RedPointConst.CLUB_WELFARE, CommunityData:GetWelfareType() == CommunityConst.WELFARE_TYPE.RECEIVE and 1 or 0)
	manager.notify:CallUpdateFunc(COMMUNITY_REFRESH_WELFARE)
end

return var_0_0
