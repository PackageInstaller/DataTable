local var_0_0 = {}

manager.net:Bind(17027, function(arg_1_0)
	AccumulateSignData:InitAccumulateSignData(arg_1_0)
	var_0_0.UpdateRedpoint()
end)
manager.net:Bind(17033, function(arg_2_0)
	AccumulateSignData:InitDiscountData(arg_2_0)
end)

function var_0_0.OpenAccumulateSignView()
	manager.net:SendWithLoadingNew(17028, {}, 17029, var_0_0.OnDailySignCallBack)
end

function var_0_0.OnDailySignCallBack(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		AccumulateSignData:UpdateAccumulateViewOpen(false)
	end
end

function var_0_0.GetAccumulateRewardView(arg_5_0)
	manager.net:SendWithLoadingNew(17030, {
		id_list = arg_5_0
	}, 17031, var_0_0.OnGetAccumulateRewardView)
end

function var_0_0.OnGetAccumulateRewardView(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		getReward(arg_6_0.item, nil, function()
			manager.notify:CallUpdateFunc(ACCUMULATE_LOGIN)
		end)
		AccumulateSignData:UpdateAwardID(arg_6_1.id_list)
		var_0_0.UpdateRedpoint()
	end
end

function var_0_0.UpdateRedpoint()
	manager.redPoint:setTip(RedPointConst.ACCUMULATE_LOGIN, AccumulateSignData:GetCanReward() and 1 or 0)
end

return var_0_0
