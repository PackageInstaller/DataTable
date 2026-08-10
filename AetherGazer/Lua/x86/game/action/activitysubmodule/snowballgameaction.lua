local var_0_0 = {}

manager.net:Bind(65427, function(arg_1_0)
	SnowballGameData:InitFromServer(arg_1_0)
end)

local function var_0_1(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(SnowballGameCfg.all) do
		if SnowballGameCfg[iter_2_1].activity_id == arg_2_0 then
			return true
		end
	end

	return false
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_3_0)
	if ActivityTools.GetActivityType(arg_3_0) == ActivityTemplateConst.MINIGAME_STAGE and var_0_1(acitvityID) then
		SnowballGameData:UpdateUnlockLevelRedPoint()
	end
end)
manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
	SnowballGameData:CheckTaskRedPoint()
end)

function var_0_0.EnterGameAction(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(65422, {
		activity_id = SnowballGameData.activityID,
		stage_id = arg_5_0
	}, 65423, function(arg_6_0)
		if isSuccess(arg_6_0.result) then
			if arg_5_1 then
				arg_5_1(arg_5_0)
			end
		else
			ShowTips(arg_6_0.result)
		end
	end)
end

function var_0_0.LevelClearAction(arg_7_0, arg_7_1)
	print(arg_7_0.level, arg_7_0.score, SnowballGameData.activityID)
	manager.net:SendWithLoadingNew(65424, {
		activity_id = SnowballGameData.activityID,
		stage_id = arg_7_0.level,
		score = arg_7_0.score,
		hero_id = arg_7_0.heroId,
		use_seconds = arg_7_0.seconds,
		enemy_list = arg_7_0.enemy_list
	}, 65425, function(arg_8_0)
		if isSuccess(arg_8_0.result) then
			SnowballGameData:OnLevelClear(arg_7_0.level, arg_7_0.score)
		else
			ShowTips(arg_8_0.result)
		end

		if arg_7_1 then
			arg_7_1(arg_7_0)
		end
	end)
end

return var_0_0
