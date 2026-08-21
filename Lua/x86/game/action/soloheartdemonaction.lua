local var_0_0 = {}
local var_0_1

manager.net:Bind(75001, function(arg_1_0)
	SoloHeartDemonData:InitSoloHeartDemonData(arg_1_0)

	var_0_1 = arg_1_0.open_edition

	var_0_0.InitRedPointKey(arg_1_0.open_edition)
	var_0_0.UpdateRewardRedPoint()
	var_0_0.UpdateRefreshRedPoint(arg_1_0)
	manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_UPDATE)
end)
manager.net:Bind(75005, function(arg_2_0)
	SoloHeartDemonData:UpdateBattleFinishScore(arg_2_0.score)
	manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_SCORE_UPDATE)
end)

function var_0_0.GetReward(arg_3_0)
	manager.net:SendWithLoadingNew(75002, arg_3_0, 75003, var_0_0.OnGetRewardCallback)
end

function var_0_0.OnGetRewardCallback(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		SoloHeartDemonData:UpdateRewardList(arg_4_1)
		var_0_0.UpdateRewardRedPoint()
		getReward2(mergeReward2(arg_4_0.reward_list))
		manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_REWARD_UPDATE, arg_4_1)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.InitRedPointKey(arg_5_0)
	var_0_1 = arg_5_0

	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), {
		RedPointConst.SOLO_HEART_DEMON_REWARD,
		RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW
	})

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	if getData("SOLO_HEART_DEMON", "ENTER_VIEW" .. var_0_1) ~= "1" then
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 1)
	end
end

function var_0_0.UpdateRefreshRedPoint(arg_6_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	if var_0_1 == nil then
		return
	end

	local var_6_0 = getData("SOLO_HEART_DEMON", "STAGE")
	local var_6_1 = getData("SOLO_HEART_DEMON", "STAGE_VIEW")
	local var_6_2 = arg_6_0.challenge_stage

	saveData("SOLO_HEART_DEMON", "STAGE", tostring(var_6_2))

	if var_6_1 ~= "1" and var_6_2 == 0 then
		manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW, 1)

		return
	end

	if var_6_2 == 0 and var_6_0 ~= "0" then
		manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW, 1)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 1)
		saveData("SOLO_HEART_DEMON", "STAGE_VIEW", "0")
		saveData("SOLO_HEART_DEMON", "ENTER_VIEW" .. var_0_1, "0")
	end
end

function var_0_0.UpdateViewRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	saveData("SOLO_HEART_DEMON", "STAGE_VIEW", "1")
	manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_FIRST_VIEW, 0)
end

function var_0_0.UpdateEnterRedPoint(arg_8_0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	if var_0_1 == nil then
		return
	end

	saveData("SOLO_HEART_DEMON", "ENTER_VIEW" .. var_0_1, "1")
	manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 0)
end

function var_0_0.UpdateRewardRedPoint()
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	local var_9_0 = SoloHeartDemonData:GetDataByPara("taskData")
	local var_9_1 = SoloHeartDemonData:GetDataByPara("rewardList")

	manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_REWARD, 0)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if var_9_1[iter_9_0] ~= 1 and iter_9_1[1] >= iter_9_1[2] then
			manager.redPoint:setTip(RedPointConst.SOLO_HEART_DEMON_REWARD, 1)
		end
	end
end

manager.notify:RegistListener(PLAYER_LEVEL_UP, function()
	var_0_0.UpdateRefreshRedPoint({
		challenge_stage = SoloHeartDemonData:GetDataByPara("challengeStage")
	})

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SOLO_HEART_DEMON) then
		return
	end

	if var_0_1 == nil then
		return
	end

	if getData("SOLO_HEART_DEMON", "ENTER_VIEW" .. var_0_1) ~= "1" then
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(var_0_1), var_0_1), 1)
	end
end)
manager.notify:RegistListener(ACTIVITY_TIMER_UPDATE, function(arg_11_0)
	if var_0_1 == arg_11_0 then
		manager.notify:CallUpdateFunc(SOLO_HEART_DEMON_UPDATE)
	end
end)

return var_0_0
