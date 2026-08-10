local var_0_0 = class("ChallengeRogueTeamIllustratedEntraceView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Illustrated/IllustratedMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	arg_4_0.templateID_ = arg_4_0.params_.templateID or ChallengeRogueTeamData:GetActiveTemplateID()

	arg_4_0:RefreshUI()

	local var_4_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_4_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))
	local var_4_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_4_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))
	local var_4_2 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_CAMP, arg_4_0.templateID_)
	local var_4_3 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_END, arg_4_0.templateID_)

	manager.redPoint:bindUIandKey(arg_4_0.remainsBtn_.transform, var_4_0)
	manager.redPoint:bindUIandKey(arg_4_0.eventBtn_.transform, var_4_1)
	manager.redPoint:bindUIandKey(arg_4_0.schoolBtn_.transform, var_4_2)
	manager.redPoint:bindUIandKey(arg_4_0.outcomeBtn_.transform, var_4_3)
end

function var_0_0.OnExit(arg_5_0)
	local var_5_0 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.RELIC))
	local var_5_1 = string.format("%s_%s", RedPointConst.ACTIVITY_TASK, ChallengeRogueTeamTools.GetCollectActivityIDByType(arg_5_0.templateID_, ChallengeRogueTeamConst.COLLECTION_TASK_TYPE.EVENT))
	local var_5_2 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_CAMP, arg_5_0.templateID_)
	local var_5_3 = string.format("%s_%s", RedPointConst.CHALLENGE_ROGUE_TEAM_ILLUSTRATED_END, arg_5_0.templateID_)

	manager.redPoint:unbindUIandKey(arg_5_0.remainsBtn_.transform, var_5_0)
	manager.redPoint:unbindUIandKey(arg_5_0.eventBtn_.transform, var_5_1)
	manager.redPoint:unbindUIandKey(arg_5_0.schoolBtn_.transform, var_5_2)
	manager.redPoint:unbindUIandKey(arg_5_0.outcomeBtn_.transform, var_5_3)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.mechanismBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedMechanism")
	end)
	arg_7_0:AddBtnListener(arg_7_0.schoolBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedTreasureEntrace")
	end)
	arg_7_0:AddBtnListener(arg_7_0.eventBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedEvent")
	end)
	arg_7_0:AddBtnListener(arg_7_0.outcomeBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedEndingEntrace")
	end)
	arg_7_0:AddBtnListener(arg_7_0.remainsBtn_, nil, function()
		JumpTools.OpenPageByJump("/challengeRogueTeamIllustratedRelic", {
			templateID = arg_7_0.templateID_
		})
	end)
end

function var_0_0.RefreshUI(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = RogueTeamCfg[arg_13_0.templateID_].item_temp

	var_13_0[1] = ChallengeRogueTeamData:GetAllCampTreasureIDListByTemp(var_13_1)
	var_13_0[3] = ChallengeRogueTeamData:GetAllItemIDByTempAndType(var_13_1, ChallengeRogueTeamConst.ITEM_TYPE.RELIC)
	var_13_0[2] = RogueTeamEventCfg.get_id_list_by_event_group[1]
	var_13_0[4] = ChallengeRogueTeamData:GetAllItemIDByTempAndType(var_13_1, ChallengeRogueTeamConst.ITEM_TYPE.MECHANISM)
	var_13_0[5] = RogueTeamEndingCfg.get_id_list_by_temp_id_ending_state[1][1]

	for iter_13_0 = 1, 5 do
		local var_13_2 = ChallengeRogueTeamData:GetIllustratedDataByType(arg_13_0.templateID_, iter_13_0)

		arg_13_0["progressText" .. iter_13_0 .. "_"].text = #var_13_2 .. "/" .. #var_13_0[iter_13_0]
	end
end

function var_0_0.OnTop(arg_14_0)
	arg_14_0:RefreshUI()
end

return var_0_0
