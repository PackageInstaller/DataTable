local var_0_0 = class("ChallengeRogueTeamScorePopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RoulikepointsPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.rewardItemList_ = {}
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		ShowPopItemOnly(POP_ITEM, {
			RogueTeamCfg[arg_5_0.templateID_].point_item,
			0
		})
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityId_ = arg_8_0.params_.activityId
	arg_8_0.templateID_ = ChallengeRogueTeamData:GetCacheTemplateID()
	arg_8_0.cfg_ = ActivityCfg[arg_8_0.activityId_]
	arg_8_0.isFirstSeason_ = ChallengeRogueTeamTools.GetRougeTeamSettingValue(ChallengeRogueTeamConst.SETTING_VALUE.SEASON, arg_8_0.templateID_)

	arg_8_0:RegistEventListener(ACTIVITY_REWARD_GET, handler(arg_8_0, arg_8_0.RefreshUI))
	arg_8_0:RefreshUI()
end

function var_0_0.OnTop(arg_9_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ROGUE_TEAM_SCORE_DESC")
end

function var_0_0.OnExit(arg_10_0)
	manager.windowBar:HideBar()
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = ChallengeRogueTeamData:GetCacheTemplateID()

	arg_11_0.level_, arg_11_0.score_, arg_11_0.expToLvValue_, arg_11_0.scoreIDList_, arg_11_0.maxLevel_ = ChallengeRogueTeamTools.GetCurrentSurveyLevel(var_11_0)
	arg_11_0.levelProgressSlider_.transform.sizeDelta = Vector2(-1 * arg_11_0.layout_.spacing, arg_11_0.levelProgressSlider_.transform.sizeDelta.y)
	arg_11_0.levelProgressSlider_.value = math.min(arg_11_0.level_, arg_11_0.maxLevel_) / arg_11_0.maxLevel_
	arg_11_0.levelProgressText_.text = arg_11_0.level_
	arg_11_0.expProgressText_.text = math.floor(arg_11_0.score_ / arg_11_0.expToLvValue_) >= arg_11_0.maxLevel_ and "--/--" or arg_11_0.score_ % arg_11_0.expToLvValue_ .. "/" .. arg_11_0.expToLvValue_
	arg_11_0.expProgressSlider_.value = math.floor(arg_11_0.score_ / arg_11_0.expToLvValue_) >= arg_11_0.maxLevel_ and 1 or arg_11_0.score_ % arg_11_0.expToLvValue_ / arg_11_0.expToLvValue_
	arg_11_0.unCompleteIndex_ = ChallengeRogueTeamData:GetUnCompleteIndex(var_11_0, arg_11_0.activityId_)

	local var_11_1 = ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.PASS_POINT_REWARD_LEVEL, ChallengeRogueTeamData:GetCacheTemplateID())
	local var_11_2 = 0
	local var_11_3 = #arg_11_0.scoreIDList_

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if iter_11_1 > arg_11_0.level_ then
			var_11_2 = iter_11_1

			break
		end
	end

	for iter_11_2 = arg_11_0.unCompleteIndex_, #arg_11_0.scoreIDList_ do
		if math.floor(ActivityPointRewardCfg[arg_11_0.scoreIDList_[iter_11_2]].need / arg_11_0.expToLvValue_) == var_11_2 then
			var_11_3 = iter_11_2

			break
		end
	end

	arg_11_0.rewardIcon_.sprite = ItemTools.getItemSprite(ActivityPointRewardCfg[arg_11_0.scoreIDList_[var_11_3]].reward_item_list[1][1])

	arg_11_0:RefreshScroll()
end

function var_0_0.RefreshScroll(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardItemList_) do
		SetActive(iter_12_1.gameObject_, false)
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0.scoreIDList_) do
		if not arg_12_0.rewardItemList_[iter_12_2] then
			local var_12_0 = GameObject.Instantiate(arg_12_0.rewardItemGo_, arg_12_0.rewardContent_)

			arg_12_0.rewardItemList_[iter_12_2] = ChallengeRogueTeamScoreItem.New(var_12_0, arg_12_0.scoreIDList_)
		end

		arg_12_0.rewardItemList_[iter_12_2]:SetData(iter_12_3, iter_12_2)
		SetActive(arg_12_0.rewardItemList_[iter_12_2].gameObject_, true)
	end

	local var_12_1 = arg_12_0.layout_.padding.left + #arg_12_0.scoreIDList_ * arg_12_0.rewardItemGo_.transform.rect.width + #arg_12_0.scoreIDList_ * arg_12_0.layout_.spacing - arg_12_0.scrollView_.viewport.rect.width / arg_12_0.layout_.transform.localScale.x
	local var_12_2 = arg_12_0.layout_.padding.left + (arg_12_0.unCompleteIndex_ - 1) * (arg_12_0.rewardItemGo_.transform.rect.width + arg_12_0.layout_.spacing)

	arg_12_0.scrollView_.horizontalNormalizedPosition = var_12_2 / var_12_1
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.rewardItemList_ then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.rewardItemList_) do
			iter_13_1:Dispose()
		end

		arg_13_0.rewardItemList_ = nil
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
