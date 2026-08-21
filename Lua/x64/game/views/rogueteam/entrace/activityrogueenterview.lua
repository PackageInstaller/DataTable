local var_0_0 = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
local var_0_1 = class("ActivityRogueEnterView", var_0_0)

function var_0_1.GetUIName(arg_1_0)
	return "Widget/System/Activity_Roulike/Activity_Roulike_MainUI"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.doubleController_ = arg_3_0.controllerEx_:GetController("double")
	arg_3_0.tipsGoList_ = {}
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.goBtn_, nil, function()
		JumpTools.GoToSystem("/challengeRogueTeamEntrace", {
			templateID = arg_4_0.templateId_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.scoreBtn_, nil, function()
		JumpTools.OpenPageByJump("challengeRogueTeamScorePop", {
			activityId = ChallengeRogueTeamData:GetScoreActivityIDByTemple(arg_4_0.templateId_)
		})

		local var_6_0, var_6_1 = ChallengeRogueTeamTools.GetIsNewScoreReward(arg_4_0.templateId_)

		if var_6_0 then
			ChallengeRogueTeamAction.SetLastScoreId(arg_4_0.templateId_, var_6_1)
			manager.redPoint:setTip(RedPointConst.CHALLENGE_ROGUE_TEAM_NEW_REWARD, 0)
		end
	end)
end

function var_0_1.OnEnter(arg_7_0)
	arg_7_0:UpdateTitleShow()

	arg_7_0.templateId_ = ChallengeRogueTeamData:GetCacheTemplateID()
	arg_7_0.levelText_.text = ChallengeRogueTeamTools.GetCurrentSurveyLevel(arg_7_0.templateId_)

	local var_7_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_ROGUE_DOUBLE_REWARD_4_4)

	arg_7_0.doubleController_:SetSelectedState(tostring(var_7_0 and var_7_0:IsActivitying()))

	arg_7_0.mutiText_.text = GameSetting.rogue_team_multi_reward.value[1]
	arg_7_0.timer_ = Timer.New(function()
		arg_7_0.timeText_.text = manager.time:GetLostTimeStr2(var_7_0.stopTime)
	end, 1, -1)

	arg_7_0.timer_:Start()

	arg_7_0.pointRedPointStr_ = string.format("%s_%s", RedPointConst.ACTIVITY_POINT_REWARD, ChallengeRogueTeamTools.GetPointActivityID(arg_7_0.templateId_))

	manager.redPoint:bindUIandKey(arg_7_0.scoreBtn_.transform, arg_7_0.pointRedPointStr_)

	arg_7_0.tipTitleText_.text = GetTips("ROUGE_TEAM_UPDATE_TITLE")
	arg_7_0.tipsList_ = string.split(GetTips("ROUGE_TEAM_UPDATE"), "\n")

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.tipsList_) do
		local var_7_1 = arg_7_0.tipsGoList_[iter_7_0]

		if var_7_1 == nil then
			var_7_1 = Object.Instantiate(arg_7_0.tipItemGo_, arg_7_0.tipItemContain_, false)

			table.insert(arg_7_0.tipsGoList_, var_7_1)
		end

		SetActive(var_7_1, true)

		var_7_1.transform:Find("textNEWdec"):GetComponent("Text").text = iter_7_1
	end

	for iter_7_2 = #arg_7_0.tipsList_ + 1, #arg_7_0.tipsGoList_ do
		SetActive(arg_7_0.tipsGoList_[iter_7_2], false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.tipItemContain_)

	arg_7_0.tipScroll_.enabled = #arg_7_0.tipsList_ >= 4
end

function var_0_1.OnExit(arg_9_0)
	manager.redPoint:unbindUIandKey(arg_9_0.scoreBtn_.transform, arg_9_0.pointRedPointStr_)

	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end

	var_0_1.super.OnExit(arg_9_0)
end

function var_0_1.OnDisPose(arg_10_0)
	arg_10_0.super.OnDisPose(arg_10_0)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0.tipsGoList_) do
		Object.Destroy(iter_10_1)
	end
end

return var_0_1
