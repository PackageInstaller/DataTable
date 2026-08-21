local var_0_0 = {}

manager.net:Bind(65511, function(arg_1_0)
	SwimsuitBattleData:initDataFromServer(arg_1_0)
end)
manager.net:Bind(65513, function(arg_2_0)
	SwimsuitBattleData:initVoteFromServer(arg_2_0)
end)

function var_0_0.RequireVoteRoundInfo(arg_3_0)
	manager.net:SendWithLoadingNew(65504, {
		activity_id = arg_3_0
	}, 65505, var_0_0.OnRequireVoteRoundInfo)
end

function var_0_0.OnRequireVoteRoundInfo(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		SwimsuitBattleData:UpdateVoteFromServer(arg_4_0)
		manager.notify:Invoke(SWIMSUIT_BATTLE_VOTE_UPDATE)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.VoteForHero(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {
		activity_id = arg_5_0,
		schedule_id = arg_5_1,
		competition_list = {
			{
				competition_id = arg_5_2,
				competition_value = arg_5_3
			}
		}
	}

	manager.net:SendWithLoadingNew(65506, var_5_0, 65507, var_0_0.OnVoteForHero)
end

function var_0_0.OnVoteForHero(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		-- block empty
	else
		ShowTips(arg_6_0.result)
	end
end

manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_7_0)
	if ActivityTools.GetActivityType(arg_7_0) == ActivityTemplateConst.ACTIVITY_SWIMSUIT_BATTLE_HERO_STAGE then
		var_0_0.CheckSwimsuitBattleHeroStageOpen()
	end
end)
manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function()
	if #TaskTools:GetCanGetActivityTaskList(282951) > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_REWARD, 0)
	end

	if #TaskTools:GetCanGetActivityTaskList(282961) > 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_REWARD, 0)
	end
end)

function var_0_0.CheckSwimsuitBattleHeroStageOpen()
	local var_9_0 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_SWIMSUIT_BATTLE_HERO_STAGE] or {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		if ActivityData:GetActivityIsOpen(iter_9_1) and not getData("SwimsuitBattleHeroRedPoint", "battle" .. iter_9_1) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, iter_9_1), 1)
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_SWIMSUIT_BATTLE_HERO, iter_9_1), 0)
		end
	end
end

function var_0_0.CheckSwimsuitVoteTicketNum()
	if ItemTools.getItemNum(53106) > 0 and not SwimsuitBattleData:GetRedPointClickTag() then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET, 1)
	else
		manager.redPoint:setTip(RedPointConst.ACTIVITY_SWIMSUIT_VOTE_TICKET, 0)
	end
end

return var_0_0
