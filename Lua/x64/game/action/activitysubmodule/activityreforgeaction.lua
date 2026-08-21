local var_0_0 = {
	InitRedPointKey = function(arg_1_0)
		local var_1_0 = RedPointConst.ACTIVITY_REFORGE_SKILL .. arg_1_0
		local var_1_1 = {}

		for iter_1_0, iter_1_1 in pairs(ActivityReforgeSkillCfg.all) do
			local var_1_2 = RedPointConst.ACTIVITY_REFORGE_SKILL .. iter_1_1

			table.insert(var_1_1, var_1_2)
			manager.redPoint:setTip(var_1_2, 0)
		end

		manager.redPoint:addGroup(var_1_0, var_1_1)

		local var_1_3 = RedPointConst.ACTIVITY_REFORGE .. arg_1_0
		local var_1_4 = RedPointConst.ACTIVITY_REFORGE_TASK .. arg_1_0
		local var_1_5 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. arg_1_0
		local var_1_6 = {}

		for iter_1_2, iter_1_3 in pairs(ActivityCfg[arg_1_0].sub_activity_list) do
			local var_1_7 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. iter_1_3

			table.insert(var_1_6, var_1_7)
		end

		manager.redPoint:addGroup(var_1_5, var_1_6)
		manager.redPoint:addGroup(var_1_3, {
			var_1_4,
			var_1_5
		})
	end
}

manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	var_0_0.UpdateTaskRedPoint()
end)

function var_0_0.UpdateTaskRedPoint()
	for iter_3_0, iter_3_1 in pairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_REFORGE]) do
		local var_3_0 = RedPointConst.ACTIVITY_REFORGE_TASK .. iter_3_1

		if ActivityData:GetActivityIsOpen(iter_3_1) then
			if #TaskTools:GetCanGetActivityTaskList(iter_3_1) > 0 then
				manager.redPoint:setTip(var_3_0, 1)
			else
				manager.redPoint:setTip(var_3_0, 0)
			end
		else
			manager.redPoint:setTip(var_3_0, 0)
		end
	end
end

manager.net:Bind(84001, function(arg_4_0)
	ActivityReforgeData:SetActivityData(arg_4_0)
	var_0_0.InitRedPointKey(arg_4_0.activity_id)
	var_0_0.UpdateTaskRedPoint()
end)
manager.net:Bind(84003, function(arg_5_0)
	ActivityReforgeData:SetChapterData(arg_5_0)
	var_0_0.UpdateNewChapterRedPoint(arg_5_0.chapter_id)
	manager.notify:CallUpdateFunc(ACTIVITY_REFORGE_CURLEVEL_UPDATE)
end)
manager.net:Bind(84027, function(arg_6_0)
	ActivityReforgeData:SetCurLevelData(arg_6_0)
	manager.notify:CallUpdateFunc(ACTIVITY_REFORGE_CURLEVEL_UPDATE)
end)

function var_0_0.UpdateNewChapterRedPoint(arg_7_0)
	local var_7_0 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. arg_7_0

	if ActivityData:GetActivityIsOpen(arg_7_0) then
		if ActivityReforgeData:GetChapterIsUnlock(arg_7_0) and ActivityReforgeData:GetChapterFinishLevelNum(arg_7_0) <= 0 then
			manager.redPoint:setTip(var_7_0, 1)
		else
			manager.redPoint:setTip(var_7_0, 0)
		end
	else
		manager.redPoint:setTip(var_7_0, 0)
	end
end

function var_0_0.StartLevel(arg_8_0, arg_8_1, arg_8_2)
	manager.net:SendWithLoadingNew(84004, {
		chapter_id = arg_8_0,
		stage_id = arg_8_1
	}, 84005, function(arg_9_0, arg_9_1)
		var_0_0:OnStartLevel(arg_9_0, arg_9_1, arg_8_2)
	end)
end

function var_0_0.OnStartLevel(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if isSuccess(arg_10_1.result) then
		ActivityReforgeData:InitCurLevelData(arg_10_2.chapter_id, arg_10_2.stage_id)

		if arg_10_3 then
			arg_10_3()
		end
	else
		ShowTips(GetTips(arg_10_1.result))
	end
end

function var_0_0.SetWaveTeam(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	manager.net:SendWithLoadingNew(84006, {
		chapter_id = arg_11_0,
		stage_id = arg_11_1,
		wave_id = arg_11_2,
		team_id = arg_11_3
	}, 84007, function(arg_12_0, arg_12_1)
		var_0_0:OnSetWaveTeam(arg_12_0, arg_12_1, arg_11_4)
	end)
end

function var_0_0.OnSetWaveTeam(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if isSuccess(arg_13_1.result) then
		-- block empty
	else
		ShowTips(GetTips(arg_13_1.result))
	end

	if arg_13_3 then
		arg_13_3()
	end
end

function var_0_0.TeamLevelUp(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = ActivityReforgeData:GetTeamInfo(arg_14_2)
	local var_14_1 = ActivityReforgeTeamCfg[arg_14_2].cost[var_14_0.level]

	if ActivityReforgeAction.CheckGold(var_14_1, true) then
		manager.net:SendWithLoadingNew(84008, {
			chapter_id = arg_14_0,
			stage_id = arg_14_1,
			team_id = arg_14_2
		}, 84009, function(arg_15_0, arg_15_1)
			var_0_0:OnTeamLevelUp(arg_15_0, arg_15_1, arg_14_3)
		end)
	end
end

function var_0_0.OnTeamLevelUp(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if isSuccess(arg_16_1.result) then
		ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_UP")

		if arg_16_3 then
			arg_16_3()
		end
	else
		ShowTips(GetTips(arg_16_1.result))
	end
end

function var_0_0.ResetTeamLevel(arg_17_0, arg_17_1, arg_17_2)
	manager.net:SendWithLoadingNew(84010, {
		chapter_id = arg_17_0,
		stage_id = arg_17_1,
		team_id = arg_17_2
	}, 84011, function(arg_18_0, arg_18_1)
		var_0_0:OnResetTeamLevel(arg_18_0, arg_18_1)
	end)
end

function var_0_0.OnResetTeamLevel(arg_19_0, arg_19_1, arg_19_2)
	if isSuccess(arg_19_1.result) then
		ShowTips("ACTIVITY_REFORGE_RESET_TEAM_LEVEL")
	else
		ShowTips(GetTips(arg_19_1.result))
	end
end

function var_0_0.BuySkill(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = ActivityReforgeSkillCfg[arg_20_2].cost

	if ActivityReforgeAction.CheckGold(var_20_0, true) then
		manager.net:SendWithLoadingNew(84012, {
			chapter_id = arg_20_0,
			stage_id = arg_20_1,
			skill_id = arg_20_2
		}, 84013, function(arg_21_0, arg_21_1)
			var_0_0:OnBuySkill(arg_21_0, arg_21_1, arg_20_3)
		end)
	end
end

function var_0_0.OnBuySkill(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if isSuccess(arg_22_1.result) then
		if arg_22_3 then
			arg_22_3()
		end
	else
		ShowTips(GetTips(arg_22_1.result))
	end
end

function var_0_0.SelectSkill(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	manager.net:SendWithLoadingNew(84014, {
		chapter_id = arg_23_0,
		stage_id = arg_23_1,
		skill_id = arg_23_2
	}, 84015, function(arg_24_0, arg_24_1)
		var_0_0:OnSelectSkill(arg_24_0, arg_24_1, arg_23_3)
	end)
end

function var_0_0.OnSelectSkill(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if isSuccess(arg_25_1.result) then
		if arg_25_3 then
			arg_25_3()
		end
	else
		ShowTips(GetTips(arg_25_1.result))
	end
end

function var_0_0.UnSelectSkill(arg_26_0, arg_26_1, arg_26_2)
	manager.net:SendWithLoadingNew(84016, {
		chapter_id = arg_26_0,
		stage_id = arg_26_1,
		skill_id = arg_26_2
	}, 84017, function(arg_27_0, arg_27_1)
		var_0_0:OnUnSelectSkill(arg_27_0, arg_27_1)
	end)
end

function var_0_0.OnUnSelectSkill(arg_28_0, arg_28_1, arg_28_2)
	if isSuccess(arg_28_1.result) then
		ShowTips("ACTIVITY_REFORGE_UNUSE_SKILL")
	else
		ShowTips(GetTips(arg_28_1.result))
	end
end

function var_0_0.SellSkill(arg_29_0, arg_29_1, arg_29_2)
	manager.net:SendWithLoadingNew(84018, {
		chapter_id = arg_29_0,
		stage_id = arg_29_1,
		skill_id = arg_29_2
	}, 84019, function(arg_30_0, arg_30_1)
		var_0_0:OnSellSkill(arg_30_0, arg_30_1)
	end)
end

function var_0_0.OnSellSkill(arg_31_0, arg_31_1, arg_31_2)
	if isSuccess(arg_31_1.result) then
		ShowTips("ACTIVITY_REFORGE_SELL_SKILL")
	else
		ShowTips(GetTips(arg_31_1.result))
	end
end

function var_0_0.GiveUpCurLevel(arg_32_0, arg_32_1)
	manager.net:SendWithLoadingNew(84020, {
		chapter_id = arg_32_0,
		stage_id = arg_32_1
	}, 84021, function(arg_33_0, arg_33_1)
		var_0_0:OnGiveUpCurLevel(arg_33_0, arg_33_1)
	end)
end

function var_0_0.OnGiveUpCurLevel(arg_34_0, arg_34_1, arg_34_2)
	if isSuccess(arg_34_1.result) then
		ActivityReforgeData:ClearCurLevelData()
		manager.notify:CallUpdateFunc(ACTIVITY_REFORGE_GIVEUP_LEVEL)
	else
		ShowTips(GetTips(arg_34_1.result))
	end
end

function var_0_0.LevelFinish(arg_35_0, arg_35_1, arg_35_2)
	manager.net:SendWithLoadingNew(84022, {
		chapter_id = arg_35_0,
		stage_id = arg_35_1
	}, 84023, function(arg_36_0, arg_36_1)
		var_0_0:OnLevelFinish(arg_36_0, arg_36_1, arg_35_2)
	end)
end

function var_0_0.OnLevelFinish(arg_37_0, arg_37_1, arg_37_2, arg_37_3)
	if isSuccess(arg_37_1.result) then
		ActivityReforgeData:SetCurFinishLevelServerData(arg_37_1.stage_info)

		if arg_37_3 then
			arg_37_3()
		end
	else
		ShowTips(GetTips(arg_37_1.result))
	end
end

function var_0_0.RequestAllPlayerLevelData(arg_38_0, arg_38_1, arg_38_2)
	manager.net:SendWithLoadingNew(84024, {
		chapter_id = arg_38_0,
		stage_id = arg_38_1
	}, 84025, function(arg_39_0, arg_39_1)
		var_0_0:OnRequestAllPlayerLevelData(arg_39_0, arg_39_1, arg_38_2)
	end)
end

function var_0_0.OnRequestAllPlayerLevelData(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if isSuccess(arg_40_1.result) then
		ActivityReforgeData:SetLevelAllPlayerServerData(arg_40_2.chapter_id, arg_40_2.stage_id, arg_40_1.all_player_stage_info)

		if arg_40_3 then
			arg_40_3()
		end
	else
		ShowTips(GetTips(arg_40_1.result))
	end
end

function var_0_0.CheckGold(arg_41_0, arg_41_1)
	if arg_41_0 > ActivityReforgeData:GetCurCanUseGold() then
		if arg_41_1 then
			ShowTips("ACTIVITY_REFORGE_NEED_GLOD_LESS_THEN_HAVE")
		end

		return false
	end

	return true
end

return var_0_0
