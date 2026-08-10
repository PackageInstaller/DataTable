local var_0_0 = {}

manager.notify:RegistListener(MATERIAL_MODIFY, function(arg_1_0)
	for iter_1_0, iter_1_1 in pairs(IchiBanTeaserCfg.get_id_list_by_activity_id) do
		if IchiBanTeaserCfg[iter_1_1[1]].lottery_id == arg_1_0 then
			var_0_0.UpdateRedPoint(iter_1_0)
		end
	end
end)
manager.net:Bind(89511, function(arg_2_0)
	IchiBanData:InitChiBanData(arg_2_0)
end)

function var_0_0.SendRaffle(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(89512, {
		activity_id = arg_3_0,
		count = arg_3_1
	}, 89513, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			IchiBanData:SetUIRaffleData(arg_3_0, arg_4_0)
			arg_3_2()
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.ShowRewardList(arg_5_0, arg_5_1)
	getReward(IchiBanData:GetUIRewardList(arg_5_0), nil, arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(IchiBanData:GetUISeqList(arg_5_0)) do
		local var_5_0 = iter_5_1.level

		IchiBanData:SetIchiBanData(arg_5_0, var_5_0, iter_5_1.seq)

		local var_5_1 = IchiBanTeaserCfg.get_id_list_by_activity_id[arg_5_0][var_5_0]

		if IchiBanTools.IsGotAllLevelReward(var_5_1) then
			IchiBanData:SetUILevelReward(arg_5_0, var_5_0)
		end
	end

	IchiBanData:SortData(arg_5_0)
end

function var_0_0.InitRedPoint(arg_6_0)
	local var_6_0 = var_0_0.GetRedList(arg_6_0)

	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_6_0), arg_6_0), var_6_0)
end

function var_0_0.UpdateRedPoint(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0)
	local var_7_1 = manager.time:GetServerTime() + 1

	if var_7_1 >= var_7_0.stopTime then
		-- block empty
	elseif var_7_1 >= var_7_0.startTime and IchiBanTools.GetMaxRaffleCnt(arg_7_0) > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_ICHIBAN .. "_" .. arg_7_0, 1)

		return
	end

	manager.redPoint:setTip(RedPointConst.ACTIVITY_ICHIBAN .. "_" .. arg_7_0, 0)

	if IchiBanTools.GetUnRaffleCnt(arg_7_0) <= 0 then
		local var_7_2 = var_0_0.GetRedList(arg_7_0)

		manager.redPoint:delGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_7_0), arg_7_0), var_7_2)
	end
end

function var_0_0.GetRedList(arg_8_0)
	local var_8_0 = IchiBanTools.GetTaskActivityID(arg_8_0)

	return {
		RedPointConst.ACTIVITY_TASK .. "_" .. var_8_0,
		RedPointConst.ACTIVITY_ICHIBAN .. "_" .. arg_8_0
	}
end

return var_0_0
