local var_0_0 = {}

manager.net:Bind(72121, function(arg_1_0)
	DestroyBoxGameData:InitData(arg_1_0)
end)
manager.net:Bind(72125, function(arg_2_0)
	DestroyBoxGameData:RefreshScore(arg_2_0)
end)

function var_0_0.RequestReward(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(72122, {
		main_activity_id = arg_3_0,
		reward_id_list = arg_3_1
	}, 72123, function(arg_4_0)
		if isSuccess(arg_4_0.result) then
			DestroyBoxGameData:UpdateReceiveRewardList(arg_3_0, arg_3_1)
			getReward2(arg_4_0.item_list)
			arg_3_2()
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.InitRedPoint(arg_5_0)
	local var_5_0 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 1, arg_5_0)
	local var_5_1 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 2, arg_5_0)
	local var_5_2 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 9, arg_5_0)
	local var_5_3 = {}
	local var_5_4 = {}
	local var_5_5 = {}
	local var_5_6 = {
		var_5_3,
		var_5_4,
		[9] = var_5_5
	}

	for iter_5_0, iter_5_1 in ipairs(ActivityCfg[arg_5_0].sub_activity_list) do
		for iter_5_2, iter_5_3 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[iter_5_1]) do
			if DestroyBoxGameCfg[iter_5_3].difficult == 9 then
				local var_5_7 = string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, DestroyBoxGameCfg[iter_5_3].difficult, iter_5_1)

				manager.redPoint:addGroup(var_5_7, {
					string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[iter_5_3].difficult, iter_5_1),
					string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, iter_5_1)
				})
				table.insert(var_5_6[DestroyBoxGameCfg[iter_5_3].difficult], var_5_7)
			else
				table.insert(var_5_6[DestroyBoxGameCfg[iter_5_3].difficult], string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[iter_5_3].difficult, iter_5_1))
			end
		end
	end

	manager.redPoint:addGroup(var_5_0, var_5_3)
	manager.redPoint:addGroup(var_5_1, var_5_4)
	manager.redPoint:addGroup(var_5_2, var_5_5)
	manager.redPoint:addGroup(string.format("%s%s", ActivityTools.GetRedPointKey(arg_5_0), arg_5_0), {
		string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, arg_5_0),
		var_5_0,
		var_5_1,
		var_5_2
	})
end

function var_0_0.UpdateAllRedPoint(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_main_activity_id[arg_6_0]) do
		var_0_0.UpdateRedPoint(DestroyBoxGameCfg[iter_6_1].activity_id)
	end
end

function var_0_0.UpdateRedPoint(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0)
	local var_7_1 = manager.time:GetServerTime() + 1

	if var_7_1 >= var_7_0.stopTime then
		for iter_7_0, iter_7_1 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[arg_7_0]) do
			manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[iter_7_1].difficult, arg_7_0), 0)
		end

		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_CHALLENGE_REWARD, arg_7_0), 0)
	elseif var_7_1 >= var_7_0.startTime then
		for iter_7_2, iter_7_3 in ipairs(DestroyBoxGameCfg.get_id_list_by_activity_id[arg_7_0]) do
			if not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_DESTROY_BOX_RAMGE + iter_7_3) and DestroyBoxGameData:IsFinishPreStage(iter_7_3) then
				manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[iter_7_3].difficult, arg_7_0), 1)
			end
		end
	end
end

function var_0_0.UpdateMainActivityRedPoint(arg_8_0)
	if manager.time:GetServerTime() >= ActivityData:GetActivityData(arg_8_0).stopTime then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, arg_8_0), 0)
	end
end

function var_0_0.ClickBoxStageItem(arg_9_0, arg_9_1)
	RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_DESTROY_BOX_RAMGE + arg_9_1)
	manager.redPoint:setTip(string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE_OPEN, DestroyBoxGameCfg[arg_9_1].difficult, arg_9_0), 0)
end

return var_0_0
