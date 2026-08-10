local var_0_0 = class("ChallengeRogueTeamRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikestatuspopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}
	arg_3_0.stateController_ = arg_3_0.controllerEx_:GetController("status")
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.triggerValue
	local var_4_1 = var_4_0.itemList

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if arg_4_0.itemList_[iter_4_0] == nil then
			arg_4_0.itemList_[iter_4_0] = ChallengeRogueTeamTreasureItem.New(arg_4_0.itemParent_, iter_4_0)
		end

		iter_4_1.descRaycastFlag = true
		iter_4_1.needShowCampFlag = true

		arg_4_0.itemList_[iter_4_0]:SetData(iter_4_1)
	end

	for iter_4_2 = #arg_4_0.itemList_, #var_4_1 + 1, -1 do
		arg_4_0.itemList_[iter_4_2]:Dispose()

		arg_4_0.itemList_[iter_4_2] = nil
	end

	local var_4_2 = var_4_1[1].operate

	if var_4_2 == ChallengeRogueTeamConst.ITEM_OPERATE.DELETE then
		arg_4_0.stateController_:SetSelectedState("discard")
	else
		arg_4_0.stateController_:SetSelectedState("obtained")
	end

	local var_4_3 = RogueTeamItemCfg[var_4_1[1].id].type

	arg_4_0.titleText_.text = ChallengeRogueTeamTools.GetItemPopText(var_4_0.sourceType, var_4_0.sourceItemID, var_4_2, var_4_3)
end

function var_0_0.OnExit(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.itemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.itemList_ = nil

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

return var_0_0
