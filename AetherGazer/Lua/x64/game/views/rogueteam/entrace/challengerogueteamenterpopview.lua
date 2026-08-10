local var_0_0 = class("ChallengeRogueTeamEnterPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueRewardPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.rewardItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, CommonItemView)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = clone(ItemTemplateData)

	var_5_0.id = arg_5_0.rewardList_[arg_5_1].id
	var_5_0.number = arg_5_0.rewardList_[arg_5_1].num

	arg_5_2:SetData(var_5_0)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.backBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityId_ = arg_8_0.params_.activityId
	arg_8_0.templateId_ = ChallengeRogueTeamData:GetCacheTemplateID()
	arg_8_0.level_ = ChallengeRogueTeamTools.GetCurrentSurveyLevel(arg_8_0.templateId_)

	local var_8_0 = ChallengeRogueTeamData:GetScoreIDListByActivityID(arg_8_0.activityId_)
	local var_8_1 = ChallengeRogueTeamData:GetRewardedScoreList(arg_8_0.templateId_)

	arg_8_0.rewardList_ = {}

	for iter_8_0 = 1, #var_8_0 do
		if iter_8_0 > arg_8_0.level_ or not table.indexof(var_8_1, var_8_0[iter_8_0]) then
			local var_8_2 = ActivityPointRewardCfg[var_8_0[iter_8_0]].reward_item_list[1]

			table.insert(arg_8_0.rewardList_, {
				id = var_8_2[1],
				num = var_8_2[2]
			})
		end
	end

	arg_8_0.rewardList_ = mergeReward(arg_8_0.rewardList_)
	arg_8_0.rewardList_ = sortReward(arg_8_0.rewardList_)

	arg_8_0.rewardItemList_:StartScroll(#arg_8_0.rewardList_)
end

function var_0_0.OnExit(arg_9_0)
	var_0_0.super.OnExit(arg_9_0)
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.rewardItemList_ then
		arg_10_0.rewardItemList_:Dispose()

		arg_10_0.rewardItemList_ = nil
	end

	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
