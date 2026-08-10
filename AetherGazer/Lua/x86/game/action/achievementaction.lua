local var_0_0 = {}

manager.net:Bind(53001, function(arg_1_0)
	AchievementData:UpdateAchievementList(arg_1_0.achievement_list, true)
	AchievementData:InitAchievementStoryReadList(arg_1_0.story_line)
end)
manager.net:Bind(53003, function(arg_2_0)
	AchievementData:UpdateAchievementList(arg_2_0.achievement_progress, false)
end)

function var_0_0.GetReceiveReward(arg_3_0, arg_3_1)
	local var_3_0 = AchievementData:GetCurrentPoint()

	manager.net:SendWithLoadingNew(53004, {
		id = {
			arg_3_0
		}
	}, 53005, function(arg_4_0, arg_4_1)
		var_0_0.OnGetReceiveReward(arg_4_0, arg_4_1, var_3_0)
	end)
end

function var_0_0.OnGetReceiveReward(arg_5_0, arg_5_1, arg_5_2)
	if isSuccess(arg_5_0.result) then
		AchievementData:ChangedAchievementState(arg_5_1.id[1], -1)

		local var_5_0 = false
		local var_5_1 = AchievementData:GetCurrentLevelPoint()
		local var_5_2 = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.reward_list) do
			table.insert(var_5_2, {
				id = iter_5_1.id,
				num = iter_5_1.num
			})
		end

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			if iter_5_3.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT and arg_5_2 < var_5_1 and var_5_1 <= arg_5_2 + iter_5_3.num then
				var_5_0 = true
			end
		end

		getReward(var_5_2, nil, function()
			if var_5_0 then
				JumpTools.OpenPageByJump("achievementUpgrade", {
					currentPoint = arg_5_2,
					upgradePoint = var_5_1
				})
			end
		end, true)
	else
		ShowTips(arg_5_0.result)
	end
end

function var_0_0.TryToSubmitAchievementList(arg_7_0)
	local var_7_0 = AchievementData:GetReadyAchievementList(arg_7_0)
	local var_7_1 = AchievementData:GetCurrentPoint()

	manager.net:SendWithLoadingNew(53004, {
		id = var_7_0
	}, 53005, function(arg_8_0, arg_8_1)
		var_0_0.OnTryToSubmitAchievementList(arg_8_0, arg_8_1, var_7_1)
	end)
end

function var_0_0.OnTryToSubmitAchievementList(arg_9_0, arg_9_1, arg_9_2)
	if not isSuccess(arg_9_0.result) then
		ShowTips(arg_9_0.result)

		return
	end

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.id) do
		table.insert(var_9_0, iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs(var_9_0) do
		AchievementData:ChangedAchievementState(iter_9_3, -1)
	end

	local var_9_1 = {}
	local var_9_2 = mergeReward(arg_9_0.reward_list)
	local var_9_3 = false
	local var_9_4 = AchievementData:GetCurrentLevelPoint()

	for iter_9_4, iter_9_5 in ipairs(var_9_2) do
		if iter_9_5.id == CurrencyConst.CURRENCY_TYPE_ACHIEVEMENT_POINT and arg_9_2 < var_9_4 and var_9_4 <= arg_9_2 + iter_9_5.num then
			var_9_3 = true
		end
	end

	getReward(var_9_2, nil, function()
		if var_9_3 then
			JumpTools.OpenPageByJump("achievementUpgrade", {
				currentPoint = arg_9_2,
				upgradePoint = var_9_4
			})
		end
	end, true)
end

function var_0_0.ReadAchievementStory(arg_11_0, arg_11_1)
	manager.net:SendWithLoadingNew(53006, {
		id = arg_11_0
	}, 53007, function(arg_12_0)
		AchievementData:UpdateStoryRead(arg_11_0)
		arg_11_1(arg_12_0)
	end)
end

local var_0_1
local var_0_2
local var_0_3
local var_0_4
local var_0_5 = {}

manager.net:Bind(12089, function(arg_13_0)
	var_0_1 = arg_13_0.is_first_draw
	var_0_2 = arg_13_0.is_first_draw_limited
	var_0_3 = arg_13_0.is_first_draw_lucky
	var_0_4 = arg_13_0.total_buy_fatigue_times
end)

function var_0_0.GetFirstDraw()
	return var_0_1
end

function var_0_0.GetFirstDrawLimited()
	return var_0_2
end

function var_0_0.GetFirstDrawLucky()
	return var_0_3
end

function var_0_0.GetBuyFatigue()
	return var_0_4
end

function var_0_0.SetFirstDraw(arg_18_0)
	var_0_1 = arg_18_0
end

function var_0_0.SetFirstDrawLimited(arg_19_0)
	var_0_2 = arg_19_0
end

function var_0_0.SetFirstDrawLucky(arg_20_0)
	var_0_3 = arg_20_0
end

function var_0_0.AddBuyFatigue(arg_21_0)
	var_0_4 = var_0_4 + arg_21_0
end

function var_0_0.SendMessageForDrawAction(arg_22_0, arg_22_1)
	if var_0_1 == 1 then
		var_0_1 = 0

		SendMessageManagerToSDK("gacha_complete")
	end

	if var_0_2 == 1 and DrawPoolCfg[arg_22_1.pool].pool_type == 3 then
		var_0_2 = 0
	end

	local var_22_0 = false
	local var_22_1 = arg_22_0.item

	for iter_22_0, iter_22_1 in ipairs(var_22_1) do
		if ItemCfg[iter_22_1.id].rare == 5 then
			var_22_0 = true

			SendMessageManagerToSDK("roll_complete_140", {
				poolID = arg_22_1.pool
			})
		end
	end

	if var_22_0 and var_0_3 == 1 and DrawPoolCfg[arg_22_1.pool].pool_type == 5 then
		var_0_3 = 0

		SendMessageManagerToSDK("roll_complete_40")
	end
end

return var_0_0
