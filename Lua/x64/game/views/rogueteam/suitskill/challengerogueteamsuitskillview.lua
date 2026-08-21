local var_0_0 = class("ChallengeRogueTeamSuitSkillView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikeGenremovesPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.triggerValue.itemList[1].id
	local var_4_1 = RogueTeamItemCfg[var_4_0]

	arg_4_0.nameText_.text = var_4_1.name
	arg_4_0.descText_.text = ChallengeRogueTeamTools.GetItemDesc(var_4_0, nil, arg_4_0.descText_.color)
	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_4_0))
end

function var_0_0.OnExit(arg_5_0)
	ChallengeRogueTeamAction.RemovePopWindowCnt()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.closeBtn_, nil, function()
		ChallengeRogueTeamData:ClearObtainData()
		ChallengeRogueTeamData:RemoveServerTriggerQueue()
		arg_7_0:Back()
		ChallengeRogueTeamAction.RemovePopWindowCnt()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
	end)
end

function var_0_0.Cacheable(arg_9_0)
	return false
end

return var_0_0
