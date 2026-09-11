local CoreVerificationEnterStageViewMode2 = class("CoreVerificationEnterStageViewMode2", ReduxView)

function CoreVerificationEnterStageViewMode2:UIName()
	return "Widget/System/Core_verification_new/Mode2/Core_verification_ChooseUI02"
end

function CoreVerificationEnterStageViewMode2:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationEnterStageViewMode2:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationEnterStageViewMode2:InitUI()
	self:BindCfgUI()

	self.commonItems = {}
	self.challengeHeadItems = {}

	for iter_4_0 = 1, 2 do
		self.commonItems[iter_4_0] = CoreVerificationCommonStageItemMode2.New(self["selectionGo_" .. iter_4_0], CoreVerificationClMode2Cfg[CoreVerificationClMode2Cfg.get_id_list_by_activity_id[CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)][iter_4_0]], iter_4_0)
	end

	for iter_4_1 = 1, 3 do
		self.challengeHeadItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(self["heroItemGo_" .. iter_4_1], iter_4_1)
	end

	self.stateChallengeController_ = self.clController_:GetController("scorstate")
	self.lockController_ = self.illustratedController_:GetController("lock")
	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
end

function CoreVerificationEnterStageViewMode2:AddUIListeners()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeRankView", {})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeStageViewMode2", {})
	end)
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_jump")
		JumpTools.OpenPageByJump("/coreVerificationChallengeIllustratedView", {})
	end)
	self:AddBtnListener(self.btn_flushedBtn_, nil, function()
		if CoreVerificationChallengeMode2Data:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS2"),
				OkCallback = function()
					CoreVerificationChallengeMode2Action.Reset()
				end
			})
		elseif CoreVerificationChallengeMode2Data:IsGetTaskReward() then
			ShowTips("CORE_VERIFICATION_CL_LOCK_TIPS_2")
		else
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS2"),
				OkCallback = function()
					CoreVerificationChallengeMode2Action.Reset()
				end
			})
		end
	end)
	self:AddBtnListener(self.seasonBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationChallengeSeasonTipView")
	end)
end

function CoreVerificationEnterStageViewMode2:OnEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_RESET, self.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	self:UpdateCoreVerification()
end

function CoreVerificationEnterStageViewMode2:UpdateCoreVerification()
	self.common_stage = CoreVerificationChallengeMode2Data:GetCommonStage()
	self.challenge_stage = CoreVerificationChallengeMode2Data:GetChallengeStage()
	self.isTips = CoreVerificationChallengeMode2Data:GetSeasonIsTips()

	if self.isTips then
		CoreVerificationChallengeMode2Action.SetSeasonIsTips()
		JumpTools.OpenPageByJump("coreVerificationChallengeSeasonTipView")
	end

	self:RefreshTitle()
	self:RefreshCommonStage()
	self:RefreshChallengeStage()
end

function CoreVerificationEnterStageViewMode2:RefreshChallengeStage()
	local var_17_0 = CoreVerificationChallengeMode2Data:GetChallengeStage()

	if var_17_0.max_challenge_value and var_17_0.max_challenge_value > 0 then
		self.stateChallengeController_:SetSelectedIndex(0)

		self.challengeScoreText_.text = var_17_0.max_challenge_value
	else
		self.stateChallengeController_:SetSelectedIndex(1)
	end

	local var_17_1 = CoreVerificationChallengeMode2Data:GetChallengeStageCfg()

	self.challengeNameText_.text = GetI18NText(var_17_1.stage_name)
	self.recommendIcon_.sprite = HeroTools.GetSkillAttributeIcon(var_17_1.recommend[1])

	if var_17_0.challenge_lock then
		for iter_17_0 = 1, 3 do
			self.challengeHeadItems[iter_17_0]:RefreshUI((var_17_0.challenge_lock[iter_17_0] or nil) and (var_17_0.challenge_lock[iter_17_0] or 0))
		end
	end
end

function CoreVerificationEnterStageViewMode2:RefreshCommonStage()
	local var_18_0 = CoreVerificationClMode2Cfg.get_id_list_by_activity_id[ActivityCfg[CoreVerificationChallengeMode2Data:GetActivityId()].sub_activity_list[2]]

	for iter_18_0, iter_18_1 in ipairs(self.common_stage) do
		local var_18_1 = 0

		for iter_18_2, iter_18_3 in ipairs(var_18_0) do
			if iter_18_1.stage_id == iter_18_3 then
				var_18_1 = iter_18_2
			end
		end

		self.commonItems[var_18_1]:RefreshUI(iter_18_1)
	end

	if self.common_stage and #self.common_stage <= 0 then
		for iter_18_4 = 1, #self.commonItems do
			self.commonItems[iter_18_4]:RefreshUI(nil)
		end
	end
end

function CoreVerificationEnterStageViewMode2:OnExit()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_RESET, self.updateInfoHandler)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function CoreVerificationEnterStageViewMode2:RefreshTitle()
	local var_20_0 = ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[CoreVerificationClMode2Cfg.get_id_list_by_activity_id[CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)][3]].stage_com_affix[1]].affix

	self.comAffixName_.text = getAffixName(var_20_0)
	self.comAffixDesc_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_1"), (CoreVerificationChallengeMode2Data:GetPostLimitNum()))
	self.comAffixIcon_.sprite = getAffixSprite(var_20_0)
	self.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/BossAttribute/", CoreVerificationChallengeMode2Data:GetChallengeStageCfg().stage_img))

	local var_20_1 = CoreVerificationChallengeTools.GetIllustrated()

	if var_20_1 and #var_20_1 > 0 then
		local var_20_2 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_20_2 == 0 then
			self.lockController_:SetSelectedIndex(1)
		else
			self.lockController_:SetSelectedIndex(0)

			self.illustratedIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_20_2))
		end
	else
		self.lockController_:SetSelectedIndex(1)
	end
end

function CoreVerificationEnterStageViewMode2:Dispose()
	for iter_21_0 = 1, #self.commonItems do
		self.commonItems[iter_21_0]:Dispose()

		self.commonItems[iter_21_0] = nil
	end

	for iter_21_1 = 1, 3 do
		self.challengeHeadItems[iter_21_1]:Dispose()

		self.challengeHeadItems[iter_21_1] = nil
	end

	CoreVerificationEnterStageViewMode2.super.Dispose(self)
end

return CoreVerificationEnterStageViewMode2
