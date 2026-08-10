local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	CowboyData:Init()
	manager.net:Bind(61013, function(arg_2_0)
		CowboyData:InitData(arg_2_0)
		CowboyAction:RefreshRedPoint(arg_2_0.activity_id)
	end)
end

function var_0_0.InitRedPointKey(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = ActivityData:GetActivityData(arg_3_0).subActivityIdList

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		table.insert(var_3_0, RedPointConst.COWBOY_OPEN .. "_" .. iter_3_1)
		table.insert(var_3_1, RedPointConst.COWBOY_REWARD .. "_" .. iter_3_1)
	end

	manager.redPoint:addGroup(RedPointConst.COWBOY_OPEN .. "_" .. arg_3_0, var_3_0)
	manager.redPoint:addGroup(RedPointConst.COWBOY_REWARD .. "_" .. arg_3_0, var_3_1)
	manager.redPoint:addGroup(RedPointConst.COWBOY .. "_" .. arg_3_0, {
		RedPointConst.COWBOY_OPEN .. "_" .. arg_3_0,
		RedPointConst.COWBOY_REWARD .. "_" .. arg_3_0
	})
end

function var_0_0.SendActivityInfo(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = {
		activity_id = arg_4_2,
		activity_point = arg_4_3
	}

	manager.net:SendWithLoadingNew(61014, var_4_0, 61015, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			if arg_4_4 then
				arg_4_4()
			end

			arg_4_0:RefreshReward(arg_4_2)
		else
			ShowTips(arg_5_0.result)
			JumpTools.OpenPageByJump("/cowboy", {
				activityID = arg_4_1
			})
		end
	end)
end

function var_0_0.GetReward(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		point_id = arg_6_2
	}

	manager.net:SendWithLoadingNew(61010, var_6_0, 61011, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			CowboyData:SetReward(arg_6_1, arg_6_2)

			local var_7_0 = arg_7_0.reward_list

			getReward2(var_7_0)
			var_0_0:RefreshReward(arg_6_1)
			manager.notify:CallUpdateFunc(COWBOY_REWARD)
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.RefreshRedPoint(arg_8_0, arg_8_1)
	if not ActivityData:GetActivityData(arg_8_1):IsActivitying() then
		manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. arg_8_1, 0)
		manager.redPoint:setTip(RedPointConst.COWBOY_REWARD .. "_" .. arg_8_1, 0)

		return
	end

	arg_8_0:RefreshOpen(arg_8_1)
	arg_8_0:RefreshReward(arg_8_1)
end

function var_0_0.RefreshOpen(arg_9_0, arg_9_1)
	if ActivityCfg[arg_9_1].activity_template == ActivityTemplateConst.COWBOY then
		return
	end

	local var_9_0 = CowboyData:GetOpen(arg_9_1)
	local var_9_1 = ActivityData:GetActivityData(arg_9_1)

	if not var_9_0 and var_9_1:IsActivitying() then
		manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. arg_9_1, 1)
	else
		manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. arg_9_1, 0)
	end
end

function var_0_0.RefreshReward(arg_10_0, arg_10_1)
	if not ActivityData:GetActivityData(arg_10_1):IsActivitying() then
		return
	end

	manager.redPoint:setTip(RedPointConst.COWBOY_REWARD .. "_" .. arg_10_1, CowboyData:IsRewardRedPointShow(arg_10_1) and 1 or 0)
end

function var_0_0.CloseActivity(arg_11_0, arg_11_1)
	if ActivityData:GetActivityData(arg_11_1):IsActivitying() then
		return
	end

	local var_11_0 = ActivityCfg[arg_11_1].sub_activity_list or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		manager.redPoint:setTip(RedPointConst.COWBOY_OPEN .. "_" .. iter_11_1, 0)
		manager.redPoint:setTip(RedPointConst.COWBOY_REWARD .. "_" .. iter_11_1, 0)
	end
end

return var_0_0
