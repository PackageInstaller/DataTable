local FactorySoloChallengeMainView = class("FactorySoloChallengeMainView", (import("game.views.soloChallenge.SoloChallengeMainView")))

function FactorySoloChallengeMainView:UIName()
	return "UI/MardukUI/SoloChallenge/MardukSoloChallengeMain"
end

function FactorySoloChallengeMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.switchItemList_ = {}
	self.rewardItemList_ = {}
	self.onClickHandler_ = handler(self, self.OnClick)
	self.adaptImg_ = self:FindCom("SelfAdaptImage", nil, self.roleTras_)
	self.difficultyStateList_ = {}

	for iter_2_0 = 1, 3 do
		self.difficultyStateList_[iter_2_0] = ControllerUtil.GetController(self["diffcultyState_" .. iter_2_0], "complete")
	end

	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
end

function FactorySoloChallengeMainView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("FACTORY_ACTIVITY_SOLO_CHALLENGE_DESCRIPE")
end

function FactorySoloChallengeMainView:AddListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeReward", {
			activityID = self.selectActivityID_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.selectActivityID_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("soloChallengeDifficultySelect", {
			activityID = self.selectActivityID_
		})
	end)
end

function FactorySoloChallengeMainView:OnExit()
	self:UnbindRewardRedPoint()
	FactorySoloChallengeMainView.super.OnExit(self)
end

function FactorySoloChallengeMainView:RefreshUI()
	self.subActivityList_ = ActivityCfg[self.activityID_].sub_activity_list

	local var_8_0 = SoloChallengeData:GetSelectActivityID(self.activityID_) or self.subActivityList_[1]

	self:BindRewardRedPoint(var_8_0)

	self.selectActivityID_ = var_8_0

	if self.selectActivityID_ == nil then
		return
	end

	self.selectController_:SetSelectedState(tostring(table.indexof(self.subActivityList_, self.selectActivityID_) or 1))
	SoloChallengeData:SetSelectActivityID(self.activityID_, self.selectActivityID_)
	self:RefreshSwitchItem()
	self:RefreshRoleImage()
	self:RefreshDesc()
	self:RefreshDifficultyState()
end

function FactorySoloChallengeMainView:RefreshDifficultyState()
	local var_9_0 = SoloChallengeData:GetCompletedActivityList()[self.selectActivityID_]

	for iter_9_0, iter_9_1 in ipairs(self.difficultyStateList_) do
		if table.keyof(var_9_0, iter_9_0) ~= nil then
			iter_9_1:SetSelectedState("true")
		else
			iter_9_1:SetSelectedState("false")
		end
	end
end

function FactorySoloChallengeMainView:RefreshActivityDesc()
	self.activityDescText_.text = GetTips("FACTORY_ACTIVITY_SOLO_CHALLENGE_CONTENT")
end

function FactorySoloChallengeMainView:BindRewardRedPoint(arg_11_1)
	if self.boundRedPoint_ == true and self.selectActivityID_ ~= arg_11_1 then
		manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, self.activityID_, self.selectActivityID_)))
	end

	if #SoloChallengeData:GetCompletedActivityList()[arg_11_1] > #SoloChallengeData:GetReceivedActivityList()[arg_11_1] then
		manager.redPoint:bindUIandKey(self.rewardBtn_.transform, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, self.activityID_, arg_11_1)))

		self.boundRedPoint_ = true
	else
		self.boundRedPoint_ = false
	end
end

function FactorySoloChallengeMainView:UnbindRewardRedPoint()
	if self.boundRedPoint_ then
		manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, (string.format("%s_%s_%s", RedPointConst.SOLO_CHALLENGE, self.activityID_, self.selectActivityID_)))
	end
end

function FactorySoloChallengeMainView:RefreshRoleImage()
	return
end

function FactorySoloChallengeMainView:GetSwitchItemClass()
	return FactorySoloChallengeSwitchItem
end

return FactorySoloChallengeMainView
