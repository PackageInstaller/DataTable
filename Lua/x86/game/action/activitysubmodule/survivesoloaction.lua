local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	SurviveSoloData:Init()
	manager.net:Bind(61053, function(arg_2_0)
		local var_2_0 = arg_2_0.activity_info

		SurviveSoloData:InitData(var_2_0)
		SurviveSoloAction:RefreshRedPoint(var_2_0.activity_id)
	end)
end

function var_0_0.InitRedPointKey(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = ActivityData:GetActivityData(arg_3_0).subActivityIdList

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		table.insert(var_3_0, RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_3_1)
		table.insert(var_3_1, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. iter_3_1)
	end

	manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_3_0, var_3_0)
	manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_3_0, var_3_1)
	manager.redPoint:addGroup(RedPointConst.SOLO_SURVIVE .. "_" .. arg_3_0, {
		RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_3_0,
		RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_3_0
	})
end

function var_0_0.GetReward(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		id = arg_4_1,
		time = arg_4_2
	}

	manager.net:SendWithLoadingNew(61054, var_4_0, 61055, handler(var_0_0, var_0_0.OnGetReward))
end

function var_0_0.OnGetReward(arg_5_0, arg_5_1, arg_5_2)
	if isSuccess(arg_5_1.result) then
		local var_5_0 = arg_5_1.reward_list

		SurviveSoloData:SetReward(arg_5_2.id, arg_5_2.time)
		getReward2(var_5_0)
		arg_5_0:RefreshRewardRedPoint(arg_5_2.id)
		manager.notify:CallUpdateFunc(SURVIVE_SOLO_REWARD)
	else
		ShowTips(arg_5_1.result)
	end
end

function var_0_0.RefreshRedPoint(arg_6_0, arg_6_1)
	local var_6_0 = ActivityData:GetActivityData(arg_6_1)

	if not var_6_0 or not var_6_0:IsActivitying() then
		arg_6_0:ClearRed(arg_6_1)

		return
	end

	arg_6_0:RefreshOpenRedPoint(arg_6_1)
	arg_6_0:RefreshRewardRedPoint(arg_6_1)
end

function var_0_0.RefreshOpenRedPoint(arg_7_0, arg_7_1)
	local var_7_0 = SurviveSoloData:GetData(arg_7_1)

	if not var_7_0 or var_7_0.time >= 0 then
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_7_1, 0)
	else
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_7_1, 1)
	end
end

function var_0_0.RefreshRewardRedPoint(arg_8_0, arg_8_1)
	local var_8_0 = SurviveSoloData:GetData(arg_8_1)
	local var_8_1 = false

	if var_8_0 then
		local var_8_2 = var_8_0.time
		local var_8_3 = var_8_0.rewards
		local var_8_4 = ActivitySoloSlayerCfg[arg_8_1]

		for iter_8_0, iter_8_1 in ipairs(var_8_4.reward_item_list) do
			if var_8_2 >= iter_8_1[1] and not table.indexof(var_8_3, iter_8_1[1]) then
				var_8_1 = true

				break
			end
		end
	else
		var_8_1 = false
	end

	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_8_1, var_8_1 and 1 or 0)
end

function var_0_0.ClearRed(arg_9_0, arg_9_1)
	local var_9_0 = ActivityData:GetActivityData(arg_9_1).subActivityIdList

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_9_1, 0)
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. iter_9_1, 0)
	end

	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_9_1, 0)
	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_9_1, 0)
	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE .. "_" .. arg_9_1, 0)
end

return var_0_0
