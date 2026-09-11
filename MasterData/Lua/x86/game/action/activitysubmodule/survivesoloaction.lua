local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	SurviveSoloData:Init()
	manager.net:Bind(61053, function(arg_2_0)
		SurviveSoloData:InitData(arg_2_0.activity_info)
		SurviveSoloAction:RefreshRedPoint(arg_2_0.activity_info.activity_id)
	end)
end

function var_0_0.InitRedPointKey(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityData:GetActivityData(arg_3_0).subActivityIdList) do
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
	manager.net:SendWithLoadingNew(61054, {
		id = arg_4_1,
		time = arg_4_2
	}, 61055, handler(var_0_0, var_0_0.OnGetReward))
end

function var_0_0:OnGetReward(arg_5_1, arg_5_2)
	if isSuccess(arg_5_1.result) then
		SurviveSoloData:SetReward(arg_5_2.id, arg_5_2.time)
		getReward2(arg_5_1.reward_list)
		self:RefreshRewardRedPoint(arg_5_2.id)
		manager.notify:CallUpdateFunc(SURVIVE_SOLO_REWARD)
	else
		ShowTips(arg_5_1.result)
	end
end

function var_0_0:RefreshRedPoint(arg_6_1)
	local var_6_0 = ActivityData:GetActivityData(arg_6_1)

	if not var_6_0 or not var_6_0:IsActivitying() then
		self:ClearRed(arg_6_1)

		return
	end

	self:RefreshOpenRedPoint(arg_6_1)
	self:RefreshRewardRedPoint(arg_6_1)
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
		for iter_8_0, iter_8_1 in ipairs(ActivitySoloSlayerCfg[arg_8_1].reward_item_list) do
			if var_8_0.time >= iter_8_1[1] and not table.indexof(var_8_0.rewards, iter_8_1[1]) then
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
	for iter_9_0, iter_9_1 in ipairs(ActivityData:GetActivityData(arg_9_1).subActivityIdList) do
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. iter_9_1, 0)
		manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. iter_9_1, 0)
	end

	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. arg_9_1, 0)
	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. arg_9_1, 0)
	manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE .. "_" .. arg_9_1, 0)
end

return var_0_0
