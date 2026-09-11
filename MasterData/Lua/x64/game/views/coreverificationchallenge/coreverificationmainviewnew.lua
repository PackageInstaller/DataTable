local CoreVerificationMainViewNew = class("CoreVerificationMainViewNew", ReduxView)

function CoreVerificationMainViewNew:UIName()
	return "Widget/System/Core_verification_new/Core_verification_new"
end

function CoreVerificationMainViewNew:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationMainViewNew:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationMainViewNew:InitUI()
	self:BindCfgUI()

	self.mainBossItem_ = CoreVerificationBossItemNew.New(self.boss1Go_, 1)
	self.subBossItem_ = CoreVerificationBossItemNew.New(self.boss2Go_, 2)
	self.stateController_ = self.coreverificationmainControllerexcollection_:GetController("statescore")
	self.uiList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, CoreVerificationModeItem)
end

function CoreVerificationMainViewNew:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationPre", {})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		local var_9_0 = CoreVerificationChallengeTools.GetActivityId()

		if ActivityData:GetActivityIsOpen(var_9_0) then
			if CoreVerificationData:GetMaxUnlockByBossType(1) >= 4 or CoreVerificationData:GetMaxUnlockByBossType(2) >= 4 then
				CoreVerificationChallengeTools.GetEnterViewUIName(var_9_0)
			else
				ShowTips("CORE_VERIFICATION_CL_UNLOCK_TIPS")
			end
		else
			ShowTips("SOLO_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_jump")
		JumpTools.OpenPageByJump("/coreVerificationChallengeIllustratedView", {})
	end)
end

function CoreVerificationMainViewNew:UpdateCoreVerification()
	CoreVerificationAction.UpdateChallengeRedPoints()
	self:RefreshTitle()
end

function CoreVerificationMainViewNew:IndexItem(arg_12_1, arg_12_2)
	local var_12_0 = CoreVerificationChallengeTools.GetAllActivityIds()[arg_12_1]

	arg_12_2:SetData(arg_12_1, var_12_0)
	arg_12_2:SetSelect(var_12_0 == CoreVerificationChallengeTools.GetActivityId())
end

function CoreVerificationMainViewNew:OnCoreVerificationChallengeSwitchMode(arg_13_1)
	if CoreVerificationChallengeTools.GetActivityId() == arg_13_1 then
		return
	end

	CoreVerificationChallengeTools.SetSelectedActivityId(arg_13_1)
	self:ClearRedPoint(arg_13_1)
	self:RefreshChallenge()
end

function CoreVerificationMainViewNew:ClearRedPoint(arg_14_1)
	local var_14_0 = CoreVerificationChallengeTools.GetActionCls(arg_14_1)
	local var_14_1 = CoreVerificationChallengeTools.GetDataCls(arg_14_1)
	local var_14_2 = CoreVerificationChallengeTools.GetActionCls(arg_14_1)

	if var_14_2 then
		var_14_2.SetSeasonIsTips()
		var_14_2.UpdateRewardRedPoints()
	end
end

function CoreVerificationMainViewNew:OnEnter()
	local var_15_0 = getData("CoreVerification", "click_time") or 0
	local var_15_1 = _G.gameTimer:GetNextDayFreshTime()

	if var_15_1 > 0 and var_15_0 < var_15_1 then
		CoreVerificationChallengeTools.selectedActivityId_ = nil

		CoreVerificationChallengeTools.GetActivityId()
	end

	saveData("CoreVerification", "click_time", var_15_1)
	CoreVerificationAction.UpdateChallengeRedPoints()

	if ActivityData:GetActivityIsOpen(CoreVerificationChallengeTools.GetActivityId()) then
		local var_15_2 = CoreVerificationChallengeTools.GetModeIndex()

		if var_15_2 == 1 then
			CoreVerificationChallengeAction.UpdateRewardRedPoints()
		elseif var_15_2 == 2 then
			CoreVerificationChallengeMode2Action.UpdateRewardRedPoints()
		end
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	self:BindRedPoint()
	self:RefreshTitle()

	local var_15_3 = CoreVerificationChallengeTools.GetActivityId()

	CoreVerificationChallengeTools.SetSelectedActivityId(var_15_3)

	if ActivityData:GetActivityIsOpen(var_15_3) then
		self:RefreshChallenge()
	end
end

function CoreVerificationMainViewNew:RefreshChallenge()
	local var_16_0 = CoreVerificationChallengeTools.GetChallengeStage()
	local var_16_1 = CoreVerificationChallengeTools.GetChallengeStageCfg()

	self.challengeBossImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", var_16_1.stage_img))

	if var_16_0.max_challenge_value and var_16_0.max_challenge_value > 0 then
		local var_16_2 = CoreVerificationChallengeTools:GetIllustrated()

		if var_16_2 and #var_16_2 > 0 then
			self.stateController_:SetSelectedIndex(0)

			self.systemImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", (CoreVerificationChallengeTools.GetMaxIllustrated())))
		else
			self.stateController_:SetSelectedIndex(1)
		end
	else
		self.stateController_:SetSelectedIndex(2)
	end

	local var_16_3 = CoreVerificationChallengeTools.GetIllustrated()

	if var_16_3 and #var_16_3 > 0 then
		local var_16_4 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_16_4 == 0 then
			self.stateController_:SetSelectedIndex(1)
		else
			self.stateController_:SetSelectedIndex(0)

			self.systemImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_16_4))
		end
	else
		self.stateController_:SetSelectedIndex(1)
	end

	local var_16_5 = CoreVerificationChallengeTools.GetModeIndex()
	local var_16_6 = CoreVerificationChallengeTools.GetRankScore()

	self.scoreText_.text = var_16_6 == 0 and "--" or var_16_6

	local var_16_7 = CoreVerificationChallengeTools.GetActivityId()

	self.challengeTimeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(var_16_7).stopTime)
	self.stageNameText_.text = GetI18NText(ActivityCfg[var_16_7].remark)
	self.bigBossRecommendIcon_.sprite = HeroTools.GetSkillAttributeIcon(var_16_1.recommend[1])

	local var_16_8 = CoreVerificationChallengeTools.GetAllActivityIds()

	if #var_16_8 > 1 then
		SetActive(self.uiListGo_.gameObject, true)
		self.uiList_:StartScrollWithoutAnimator(#var_16_8)
	else
		SetActive(self.uiListGo_.gameObject, false)
	end
end

function CoreVerificationMainViewNew:OnExit()
	self:UnBindRedPoint()
	manager.windowBar:HideBar()
end

function CoreVerificationMainViewNew:BindRedPoint()
	self:UnBindRedPoint()
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)

	if #CoreVerificationChallengeTools.GetAllActivityIds() < 2 then
		manager.redPoint:bindUIandKey(self.newTagTrs_, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, (CoreVerificationChallengeTools.GetActivityId())))
	end
end

function CoreVerificationMainViewNew:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)
	manager.redPoint:unbindUIandKey(self.newTagTrs_)

	if self.uiList_ then
		for iter_19_0, iter_19_1 in pairs(self.uiList_:GetItemList()) do
			iter_19_1:UnBindRedPoint()
		end
	end
end

function CoreVerificationMainViewNew:RefreshTitle()
	self.timeText_.text = manager.time:GetLostTimeStrWith2Unit(CoreVerificationData:GetRefreshTime())

	self.mainBossItem_:RefreshUI()
	self.subBossItem_:RefreshUI()
end

function CoreVerificationMainViewNew:Dispose()
	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	if self.subBossItem_ then
		self.subBossItem_:Dispose()

		self.subBossItem_ = nil
	end

	if self.mainBossItem_ then
		self.mainBossItem_:Dispose()

		self.mainBossItem_ = nil
	end

	CoreVerificationMainViewNew.super.Dispose(self)
end

return CoreVerificationMainViewNew
