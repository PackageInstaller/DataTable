local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	AntitheticalCoupletData:Init()
	manager.net:Bind(61083, function(arg_2_0)
		AntitheticalCoupletData:InitData(arg_2_0)
		AntitheticalCoupletAction:RefreshRedPoint(arg_2_0.activity_id)
	end)
end

function var_0_0.InitRedPointKey(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = ActivityData:GetActivityData(arg_3_0).subActivityIdList

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		table.insert(var_3_0, RedPointConst.ANTITHETICAL_COUPLET .. "_" .. iter_3_1)
		manager.redPoint:addGroup(RedPointConst.ANTITHETICAL_COUPLET .. "_" .. iter_3_1, {
			RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. iter_3_1,
			RedPointConst.ANTITHETICAL_COUPLET_REWARD .. "_" .. iter_3_1
		})
	end

	manager.redPoint:addGroup(RedPointConst.ANTITHETICAL_COUPLET .. "_" .. arg_3_0, var_3_0)
end

function var_0_0.GetReward(arg_4_0, arg_4_1)
	local var_4_0 = {
		activity_id = arg_4_1
	}

	manager.net:SendWithLoadingNew(61080, var_4_0, 61081, handler(var_0_0, var_0_0.OnGetReward))
end

function var_0_0.OnGetReward(arg_5_0, arg_5_1, arg_5_2)
	if isSuccess(arg_5_1.result) then
		local var_5_0 = ActivitySpringFestivalCoupletsCfg[arg_5_2.activity_id]
		local var_5_1 = arg_5_1.reward_list

		AntitheticalCoupletData:SetReward(arg_5_2.activity_id)
		getReward2(var_5_1)
		arg_5_0:RefreshRewardRedPoint(arg_5_2.activity_id)
		manager.notify:CallUpdateFunc(ANTITHETICAL_COUPLET_REWARD)
	else
		ShowTips(arg_5_1.result)
	end
end

function var_0_0.ChooseStoryID(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		activity_id = arg_6_1,
		select_id = arg_6_2
	}

	manager.net:SendWithLoadingNew(61084, var_6_0, 61085, handler(var_0_0, var_0_0.OnChooseStoryID))
end

function var_0_0.OnChooseStoryID(arg_7_0, arg_7_1, arg_7_2)
	if isSuccess(arg_7_1.result) then
		AntitheticalCoupletData:SetChooseID(arg_7_2.activity_id, arg_7_2.select_id)
		arg_7_0:RefreshRedPoint(arg_7_2.activity_id)
	else
		ShowTips(arg_7_1.result)
	end
end

function var_0_0.RefreshRedPoint(arg_8_0, arg_8_1)
	arg_8_0:RefreshOpenRedPoint(arg_8_1)
	arg_8_0:RefreshRewardRedPoint(arg_8_1)
end

function var_0_0.RefreshOpenRedPoint(arg_9_0, arg_9_1)
	local var_9_0 = AntitheticalCoupletData:GetData(arg_9_1)

	if not var_9_0 or var_9_0.isOpen then
		manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. arg_9_1, 0)
	else
		manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_OPEN .. "_" .. arg_9_1, 1)
	end
end

function var_0_0.RefreshRewardRedPoint(arg_10_0, arg_10_1)
	local var_10_0 = AntitheticalCoupletData:GetData(arg_10_1)

	if var_10_0 and var_10_0.chooseID ~= 0 and not var_10_0.isReward then
		manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_REWARD .. "_" .. arg_10_1, 1)
	else
		manager.redPoint:setTip(RedPointConst.ANTITHETICAL_COUPLET_REWARD .. "_" .. arg_10_1, 0)
	end
end

return var_0_0
