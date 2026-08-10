local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	ValentineGameData:Init()
	manager.net:Bind(64073, function(arg_2_0)
		ValentineGameData:InitData(arg_2_0)
		ValentineGameAction:RefreshRedPoint(arg_2_0.activity_id)
	end)
end

function var_0_0.InitRedPointKey(arg_3_0)
	if arg_3_0 == ActivityConst.TYR_VALENTINE_GAME then
		local var_3_0 = {}
		local var_3_1 = {}
		local var_3_2 = {}
		local var_3_3 = ActivityData:GetActivityData(arg_3_0).subActivityIdList

		for iter_3_0, iter_3_1 in ipairs(var_3_3) do
			table.insert(var_3_0, RedPointConst.VALENTINE_GAME .. "_" .. iter_3_1)
			table.insert(var_3_1, RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_3_1)
			table.insert(var_3_2, RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_3_1)
			manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. iter_3_1, {
				RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_3_1,
				RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_3_1
			})
		end

		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. arg_3_0, var_3_0)
		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. arg_3_0, var_3_1)
		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_3_0, var_3_2)
	elseif arg_3_0 == ActivityConst.INDIA_VALENTINE_GAME_V2 then
		local var_3_4 = {}
		local var_3_5 = ActivityData:GetActivityData(arg_3_0).subActivityIdList

		for iter_3_2, iter_3_3 in ipairs(var_3_5) do
			manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. iter_3_3, {
				RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_3_3,
				RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_3_3
			})
			table.insert(var_3_4, RedPointConst.VALENTINE_GAME .. "_" .. iter_3_3)
		end

		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. arg_3_0, var_3_4)
	end
end

function var_0_0.GetReward(arg_4_0, arg_4_1)
	local var_4_0 = {
		activity_id = arg_4_1
	}

	manager.net:SendWithLoadingNew(64070, var_4_0, 64071, handler(var_0_0, var_0_0.OnGetReward))
end

function var_0_0.OnGetReward(arg_5_0, arg_5_1, arg_5_2)
	if isSuccess(arg_5_1.result) then
		local var_5_0 = arg_5_1.reward_list

		getReward2(var_5_0)
		ValentineGameData:SetReward(arg_5_2.activity_id)
		arg_5_0:RefreshRewardRedPoint(arg_5_2.activity_id)
		manager.notify:CallUpdateFunc(VALENTINE_GAME_REWARD)
	else
		ShowTips(arg_5_1.result)
	end
end

function var_0_0.SetPoint(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if ActivityTools.GetMainActivityId(arg_6_1) == ActivityConst.INDIA_VALENTINE_GAME_V2 then
		local var_6_0, var_6_1 = ValentineGameData:GetQID()
		local var_6_2 = {
			activity_id = arg_6_1,
			point = arg_6_2,
			qa_id = var_6_1,
			choose_id = var_6_0
		}

		manager.net:SendWithLoadingNew(64074, var_6_2, 64075, function(arg_7_0, arg_7_1)
			var_0_0:OnSetPoint(arg_7_0, arg_7_1, arg_6_3)
		end)
	else
		local var_6_3 = {
			activity_id = arg_6_1,
			point = arg_6_2
		}

		manager.net:SendWithLoadingNew(64074, var_6_3, 64075, function(arg_8_0, arg_8_1)
			var_0_0:OnSetPoint(arg_8_0, arg_8_1)
		end)
	end
end

function var_0_0.OnSetPoint(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if ActivityTools.GetMainActivityId(arg_9_2.activity_id) == ActivityConst.INDIA_VALENTINE_GAME_V2 then
		if isSuccess(arg_9_1.result) then
			ValentineGameData:SetClear(arg_9_2.activity_id, arg_9_2.choose_id, arg_9_2.qa_id)

			if arg_9_3 then
				arg_9_3()
			end
		else
			ShowTips(arg_9_1.result)
		end
	elseif isSuccess(arg_9_1.result) then
		ValentineGameData:SetPoint(arg_9_2.activity_id, arg_9_2.point)
		manager.notify:CallUpdateFunc(VALENTINE_RESULT)
	else
		JumpTools.OpenPageByJump("/valentineGameTest", {
			activityID = arg_9_2.activity_id
		})
		ShowTips(arg_9_1.result)
	end
end

function var_0_0.RefreshRedPoint(arg_10_0, arg_10_1)
	arg_10_0:RefreshOpenRedPoint(arg_10_1)
	arg_10_0:RefreshRewardRedPoint(arg_10_1)
end

function var_0_0.RefreshOpenRedPoint(arg_11_0, arg_11_1)
	local var_11_0 = ValentineGameData:GetData(arg_11_1)

	if ActivityData:GetActivityIsOpen(arg_11_1) and (not var_11_0 or var_11_0.isOpen) then
		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. arg_11_1, 1)
	else
		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. arg_11_1, 0)
	end
end

function var_0_0.RefreshRewardRedPoint(arg_12_0, arg_12_1)
	local var_12_0 = ValentineGameData:GetData(arg_12_1)

	if var_12_0 and var_12_0.isClear and not var_12_0.isReward and ActivityData:GetActivityIsOpen(arg_12_1) then
		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_12_1, 1)
	else
		manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. arg_12_1, 0)
	end
end

manager.net:Bind(79421, function(arg_13_0)
	ValentineGameData:SetV3ServerData(arg_13_0)
	var_0_0:RefreshRedV3RedPoint(arg_13_0.activity_id)
end)

function var_0_0.InitValentineGameV3RedPointKey(arg_14_0)
	if ActivityData:GetActivityIsOpen(arg_14_0) then
		local var_14_0 = {}

		for iter_14_0, iter_14_1 in pairs(ActivityCfg[arg_14_0].sub_activity_list) do
			manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. iter_14_1, {
				RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_14_1,
				RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_14_1
			})
			table.insert(var_14_0, RedPointConst.VALENTINE_GAME .. "_" .. iter_14_1)
		end

		local var_14_1 = RedPointConst.VALENTINE_GAME_ENTER .. "_" .. arg_14_0

		manager.redPoint:addGroup(var_14_1, var_14_0)
		manager.redPoint:addGroup(RedPointConst.VALENTINE_GAME .. "_" .. arg_14_0, {
			var_14_1
		})
	end
end

function var_0_0.RefreshRedV3RedPoint(arg_15_0, arg_15_1)
	if ActivityData:GetActivityIsOpen(arg_15_1) then
		local var_15_0 = getModule("ActivityValentineV3StageData")

		if var_15_0 == nil then
			var_15_0 = {}
		end

		local var_15_1 = PlayerData:GetStoryList()

		for iter_15_0, iter_15_1 in pairs(ActivityCfg[arg_15_1].sub_activity_list) do
			if ActivityData:GetActivityIsOpen(iter_15_1) then
				local var_15_2 = ActivityValentineV3StageCfg[iter_15_1]

				if table.indexof(var_15_0, iter_15_1) then
					manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_15_1, 0)
				else
					manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_15_1, 1)
				end

				local var_15_3 = false

				for iter_15_2 = 1, 3 do
					if var_15_1[var_15_2["stage_storyid_and_dorpid_" .. iter_15_2][1]] == true and not ValentineGameData:GetStoryIDIsGetReward(var_15_2["stage_storyid_and_dorpid_" .. iter_15_2][1]) then
						var_15_3 = true

						break
					end
				end

				if var_15_3 then
					manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_15_1, 1)
				else
					manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_15_1, 0)
				end
			else
				manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_15_1, 0)
				manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_15_1, 0)
			end
		end
	else
		for iter_15_3, iter_15_4 in pairs(ActivityCfg[arg_15_1].sub_activity_list) do
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_OPEN .. "_" .. iter_15_4, 0)
			manager.redPoint:setTip(RedPointConst.VALENTINE_GAME_REWARD .. "_" .. iter_15_4, 0)
		end
	end
end

function var_0_0.GetStoryReward(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if not ValentineGameData:GetStoryIDIsGetReward(arg_16_3) then
		manager.net:SendWithLoadingNew(79422, {
			activity_id = arg_16_1,
			id = arg_16_2,
			story_id = arg_16_3
		}, 79423, handler(var_0_0, var_0_0.OnGetStoryReward))
	end
end

function var_0_0.OnGetStoryReward(arg_17_0, arg_17_1, arg_17_2)
	if isSuccess(arg_17_1.result) then
		local var_17_0 = {}

		for iter_17_0, iter_17_1 in ipairs(arg_17_1.reward_list) do
			table.insert(var_17_0, {
				id = iter_17_1.id,
				num = iter_17_1.num
			})
		end

		sortMergeGetReward(var_17_0)
		ValentineGameData:StoryIDGetReward(arg_17_2.story_id)
		arg_17_0:RefreshRedV3RedPoint(arg_17_2.activity_id)
		manager.notify:CallUpdateFunc(VALENTINE_GAME_V3_GET_REWARD)
	else
		ShowTips(arg_17_1.result)
	end
end

return var_0_0
