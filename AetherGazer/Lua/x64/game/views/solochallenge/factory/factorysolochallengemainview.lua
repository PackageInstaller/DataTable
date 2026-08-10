local var_0_0 = import("game.views.soloChallenge.SoloChallengeMainView")
local var_0_1 = class("FactorySoloChallengeMainView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeMain"
end

function var_0_1.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.switchItemList_ = {}
	arg_2_0.rewardItemList_ = {}
	arg_2_0.onClickHandler_ = handler(arg_2_0, arg_2_0.OnClick)
	arg_2_0.adaptImg_ = arg_2_0:FindCom("SelfAdaptImage", nil, arg_2_0.roleTras_)
	arg_2_0.difficultyStateList_ = {}

	for iter_2_0 = 1, 3 do
		arg_2_0.difficultyStateList_[iter_2_0] = ControllerUtil.GetController(arg_2_0["diffcultyState_" .. iter_2_0], "complete")
	end

	arg_2_0.selectController_ = ControllerUtil.GetController(arg_2_0.transform_, "select")
end

function var_0_1.OnTop(arg_3_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("FACTORY_ACTIVITY_SOLO_CHALLENGE_DESCRIPE")
end

function var_0_1.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeReward", {
			activityID = arg_4_0.selectActivityID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_4_0.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeDifficultySelect", {
			activityID = arg_4_0.selectActivityID_
		})
	end)
end

function var_0_1.OnExit(arg_7_0)
	arg_7_0:UnbindRewardRedPoint()
	var_0_1.super.OnExit(arg_7_0)
end

function var_0_1.RefreshUI(arg_8_0)
	arg_8_0.subActivityList_ = ActivityCfg[arg_8_0.activityID_].sub_activity_list

	local var_8_0 = SoloChallengeData:GetSelectActivityID(arg_8_0.activityID_) or arg_8_0.subActivityList_[1]

	arg_8_0:BindRewardRedPoint(var_8_0)

	arg_8_0.selectActivityID_ = var_8_0

	if arg_8_0.selectActivityID_ == nil then
		return
	end

	local var_8_1 = table.indexof(arg_8_0.subActivityList_, arg_8_0.selectActivityID_) or 1

	arg_8_0.selectController_:SetSelectedState(tostring(var_8_1))
	SoloChallengeData:SetSelectActivityID(arg_8_0.activityID_, arg_8_0.selectActivityID_)
	arg_8_0:RefreshSwitchItem()
	arg_8_0:RefreshRoleImage()
	arg_8_0:RefreshDesc()
	arg_8_0:RefreshDifficultyState()
end

function var_0_1.RefreshDifficultyState(arg_9_0)
	local var_9_0 = SoloChallengeData:GetCompletedActivityList()[arg_9_0.selectActivityID_]

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.difficultyStateList_) do
		if table.keyof(var_9_0, iter_9_0) ~= nil then
			iter_9_1:SetSelectedState("true")
		else
			iter_9_1:SetSelectedState("false")
		end
	end
end

function var_0_1.RefreshActivityDesc(arg_10_0)
	arg_10_0.activityDescText_.text = GetTips("FACTORY_ACTIVITY_SOLO_CHALLENGE_CONTENT")
end

function var_0_1.BindRewardRedPoint(arg_11_0, arg_11_1)
	local var_11_0 = SoloChallengeData:GetCompletedActivityList()[arg_11_1]
	local var_11_1 = SoloChallengeData:GetReceivedActivityList()[arg_11_1]
	local var_11_2

	if arg_11_0.boundRedPoint_ == true and arg_11_0.selectActivityID_ ~= arg_11_1 then
		local var_11_3 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_11_0.activityID_, arg_11_0.selectActivityID_)

		manager.redPoint:unbindUIandKey(arg_11_0.rewardBtn_.transform, var_11_3)
	end

	if #var_11_0 > #var_11_1 then
		local var_11_4 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_11_0.activityID_, arg_11_1)

		manager.redPoint:bindUIandKey(arg_11_0.rewardBtn_.transform, var_11_4)

		arg_11_0.boundRedPoint_ = true
	else
		arg_11_0.boundRedPoint_ = false
	end
end

function var_0_1.UnbindRewardRedPoint(arg_12_0)
	if arg_12_0.boundRedPoint_ then
		local var_12_0 = string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, arg_12_0.activityID_, arg_12_0.selectActivityID_)

		manager.redPoint:unbindUIandKey(arg_12_0.rewardBtn_.transform, var_12_0)
	end
end

function var_0_1.RefreshRoleImage(arg_13_0)
	return
end

function var_0_1.GetSwitchItemClass(arg_14_0)
	return FactorySoloChallengeSwitchItem
end

return var_0_1
