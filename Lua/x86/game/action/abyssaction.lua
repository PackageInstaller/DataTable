local var_0_0 = {}

manager.notify:RegistListener(NEW_DAY, function()
	var_0_0.UpdateChallengeRedPoints()
end)
manager.net:Bind(55001, function(arg_2_0)
	AbyssData:InitFromServer(arg_2_0)
	var_0_0.UpdateRedPoints()
	manager.notify:CallUpdateFunc(ABYSS_TIME_OUT_UPDATE)
end)
manager.net:Bind(55009, function(arg_3_0)
	AbyssData:UpdateResetTime(arg_3_0)
	var_0_0.UpdateRedPoints()
end)
manager.net:Bind(55023, function(arg_4_0)
	manager.notify:CallUpdateFunc(ABYSS_REFRESH)
end)
manager.net:Bind(55011, function(arg_5_0)
	AbyssData:UpdateBossInfo(arg_5_0)
	var_0_0.UpdateRedPoints()
end)
manager.net:Bind(55017, function(arg_6_0)
	AbyssData:UpdateLayerUnlock(arg_6_0)
	var_0_0.UpdateRedPoints()
end)

function var_0_0.UpdateRedPoints()
	var_0_0.UpdateRewardRedPoints()
	var_0_0.UpdateChallengeRedPoints()
end

function var_0_0.UpdateRewardRedPoints()
	local var_8_0 = AbyssData:GetCanGetLayers()

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_ABYSS) and true or false then
		manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 0)
	elseif #var_8_0 > 0 then
		manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.ABYSS_REWARD, 0)
	end
end

function var_0_0.UpdateChallengeRedPoints()
	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(AbyssData:GetCurrentIdList()) do
		local var_9_1 = AbyssCfg[iter_9_1]
		local var_9_2 = var_9_1.level

		for iter_9_2, iter_9_3 in ipairs(var_9_1.stage_list) do
			local var_9_3 = AbyssData:GetStageData(var_9_2, iter_9_2)

			if var_9_3 and var_9_3.is_completed then
				var_9_0 = true

				break
			end
		end

		if var_9_0 then
			break
		end
	end

	local var_9_4 = AbyssData:HaveGetBonusNum()
	local var_9_5 = getData("abyss", "click_time") or 0
	local var_9_6 = _G.gameTimer:GetNextDayFreshTime()

	if ChapterClientCfg[502] then
		if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.BATTLE_ABYSS) and true or false then
			manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 0)
		elseif var_9_0 or var_9_4 > 0 or var_9_6 > 0 and var_9_6 <= var_9_5 then
			manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 0)
		else
			manager.redPoint:setTip(RedPointConst.ABYSS_CHALLENGE, 1)
		end
	end
end

function var_0_0.ClickChallengeRedPoint()
	saveData("abyss", "click_time", _G.gameTimer:GetNextDayFreshTime())
	var_0_0.UpdateChallengeRedPoints()
end

function var_0_0.ResetLayer(arg_11_0)
	local var_11_0 = {
		layer = arg_11_0
	}

	manager.net:SendWithLoadingNew(55002, var_11_0, 55003, var_0_0.OnResetLayerCallback)
end

function var_0_0.OnResetLayerCallback(arg_12_0, arg_12_1)
	if isSuccess(arg_12_0.result) then
		local var_12_0 = AbyssData:GetAbyssCfg(arg_12_1.layer)

		for iter_12_0, iter_12_1 in ipairs(var_12_0.stage_list) do
			if iter_12_1[1] == 3 then
				AbyssTools.SetLayerBossTeamCacheFlag(arg_12_1.layer, iter_12_0, false)
			end

			ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.ABYSS, iter_12_1[2])
		end

		AbyssData:OnResetLayer(arg_12_1.layer)
		var_0_0.UpdateRedPoints()
	else
		ShowTips(GetTips(arg_12_0.result))
	end
end

local var_0_1
local var_0_2

function var_0_0.ResetStage(arg_13_0, arg_13_1, arg_13_2)
	var_0_1 = arg_13_0
	var_0_2 = arg_13_1

	local var_13_0 = {
		stage_id = arg_13_2
	}

	manager.net:SendWithLoadingNew(55004, var_13_0, 55005, var_0_0.OnResetStageCallback)
end

function var_0_0.OnResetStageCallback(arg_14_0, arg_14_1)
	if isSuccess(arg_14_0.result) then
		if AbyssData:GetAbyssCfg(var_0_1).stage_list[var_0_2][1] == 3 then
			AbyssTools.SetLayerBossTeamCacheFlag(var_0_1, var_0_2, false)
		end

		ReserveTools.ResetContData(ReserveConst.RESERVE_TYPE.ABYSS, arg_14_1.stage_id)
		AbyssData:OnResetStage(var_0_1, var_0_2, arg_14_1.stage_id)

		var_0_1 = nil
		var_0_2 = nil

		var_0_0.UpdateRedPoints()
	else
		ShowTips(GetTips(arg_14_0.result))
	end
end

function var_0_0.GetLayerBonus(arg_15_0)
	local var_15_0 = {
		layer_list = arg_15_0
	}

	manager.net:SendWithLoadingNew(55006, var_15_0, 55007, var_0_0.OnGetLayerBonusCallback)
end

function var_0_0.OnGetLayerBonusCallback(arg_16_0, arg_16_1)
	if isSuccess(arg_16_0.result) then
		local var_16_0 = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_1.layer_list) do
			local var_16_1 = AbyssData:GetAbyssCfg(iter_16_1).reward_list

			table.insertto(var_16_0, var_16_1)
		end

		local var_16_2 = formatRewardCfgList(var_16_0)
		local var_16_3 = mergeReward(var_16_2)

		getReward(var_16_3)
		AbyssData:OnLayerBonusGet(arg_16_1.layer_list)
		var_0_0.UpdateRedPoints()
	else
		ShowTips(GetTips(arg_16_0.result))
	end
end

function var_0_0.SaveProgress(arg_17_0, arg_17_1)
	local var_17_0 = {
		stage_id = arg_17_0,
		is_save = arg_17_1
	}

	manager.net:SendWithLoadingNew(55012, var_17_0, 55013, var_0_0.OnSaveProgressCallback)
end

function var_0_0.OnSaveProgressCallback(arg_18_0, arg_18_1)
	if isSuccess(arg_18_0.result) then
		var_0_0.UpdateRedPoints()
	else
		ShowTips(GetTips(arg_18_0.result))
	end
end

function var_0_0.ReadBackFlag()
	local var_19_0 = {}

	manager.net:SendWithLoadingNew(55020, var_19_0, 55021, var_0_0.OnReadBackFlagCallback)
end

function var_0_0.OnReadBackFlagCallback(arg_20_0, arg_20_1)
	if isSuccess(arg_20_0.result) then
		AbyssData:OnReadBackFlag()
	else
		ShowTips(GetTips(arg_20_0.result))
	end
end

function var_0_0.ClearTeamCache(arg_21_0)
	AbyssData:ClearTeamCache(arg_21_0)
end

return var_0_0
