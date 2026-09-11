local CoreVerificationEnterStageViewMode4 = class("CoreVerificationEnterStageViewMode4", ReduxView)

function CoreVerificationEnterStageViewMode4:OnCtor()
	self.timers = {}
end

function CoreVerificationEnterStageViewMode4:UIName()
	return "Widget/System/Core_verification_new/Mode4/Core_verification_ChooseUI04"
end

function CoreVerificationEnterStageViewMode4:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationEnterStageViewMode4:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationEnterStageViewMode4:InitUI()
	self:BindCfgUI()

	self.commonItems = {}

	for iter_5_0, iter_5_1 in ipairs(CoreVerificationClMode4Cfg.get_id_list_by_activity_id[CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)]) do
		if self["selectionGo_" .. iter_5_0] and not isNil(self["selectionGo_" .. iter_5_0]) then
			self.commonItems[iter_5_0] = CoreVerificationMode4StageItem.New(self["selectionGo_" .. iter_5_0])
		end
	end

	self.lockController = self.illustratedController_:GetController("lock")
	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
end

function CoreVerificationEnterStageViewMode4:AddUIListeners()
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
	self:AddBtnListener(self.illustratedBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_jump")
		JumpTools.OpenPageByJump("/coreVerificationChallengeIllustratedView", {})
	end)
	self:AddBtnListener(self.btn_flushedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_CL_RESETTIPS2"),
			OkCallback = function()
				CoreVerificationChallengeMode4Action.ResetAll(self.activityID)
			end
		})
	end)
	self:AddBtnListener(self.seasonBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationChallengeSeasonTipView")
	end)
end

function CoreVerificationEnterStageViewMode4:UpdateCoreVerification()
	self.commonStage = CoreVerificationChallengeMode4Data:GetCommonStage()
	self.challengeStage = CoreVerificationChallengeMode4Data:GetChallengeStage()

	self:RefreshTitle()
	self:RefreshBoss()
	self:RefreshStages()
	SetActive(self.btn_flushedBtn_.gameObject, self:IsResetEnabled())
end

function CoreVerificationEnterStageViewMode4:RefreshTimeText()
	self.refreshTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(ActivityData:GetActivityData(self.activityID).stopTime)
end

function CoreVerificationEnterStageViewMode4:RefreshBoss()
	self.bossIcon_.spriteSync = string.format("TextureConfig/Core_verification_new/BossAttribute/%s", CoreVerificationChallengeMode4Data:GetChallengeStageCfg((CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4))).stage_img)
end

function CoreVerificationEnterStageViewMode4:RefreshTitle()
	local var_17_0 = ActivityAffixPoolCfg[CoreVerificationChallengeMode4Data:GetChallengeStageCfg((CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4))).stage_com_affix[1]].affix

	self.comAffixName_.text = getAffixName(var_17_0)
	self.comAffixIcon_.sprite = getAffixSprite(var_17_0)

	if self.comAffixIcon_1 and not isNil(self.comAffixIcon_1) then
		self.comAffixIcon_1.sprite = getAffixSprite(var_17_0)
	end

	self:RefreshTimeText()

	self.allscoreText_1.text = CoreVerificationChallengeMode4Data:GetMaxPoint()
	self.allscoreText_2.text = CoreVerificationChallengeMode4Data:GetCurPoint()

	local var_17_1 = CoreVerificationChallengeTools.GetIllustrated()

	if var_17_1 and #var_17_1 > 0 then
		local var_17_2 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_17_2 == 0 then
			self.lockController:SetSelectedIndex(1)
		else
			self.lockController:SetSelectedIndex(0)

			self.illustratedIcon_.spriteAsync = string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_17_2)
		end
	else
		self.lockController:SetSelectedIndex(1)
	end
end

function CoreVerificationEnterStageViewMode4:RefreshStages()
	for iter_18_0, iter_18_1 in ipairs(CoreVerificationClMode4Cfg.get_id_list_by_activity_id[CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)]) do
		self.commonItems[iter_18_0]:SetData(iter_18_1, iter_18_0)
	end
end

function CoreVerificationEnterStageViewMode4:IsResetEnabled()
	return true
end

function CoreVerificationEnterStageViewMode4:OnEnter()
	self.activityID = CoreVerificationChallengeTools.GetActivityId()

	self:RegistEventListener(CORE_VERIFICATION_CHALLENGE_RESET, self.updateInfoHandler)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	self:UpdateCoreVerification()

	if CoreVerificationChallengeMode4Data:GetSeasonIsTips() then
		self:StartScheduleDelayEnterCall()
	end
end

function CoreVerificationEnterStageViewMode4:OnExit()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	self:RemoveAllEventListener()
	self:StopAllTimer()
end

function CoreVerificationEnterStageViewMode4:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function CoreVerificationEnterStageViewMode4:OnBehind()
	manager.windowBar:HideBar()
end

function CoreVerificationEnterStageViewMode4:Dispose()
	CoreVerificationEnterStageViewMode4.super.Dispose(self)

	for iter_24_0, iter_24_1 in pairs(self.commonItems) do
		iter_24_1:Dispose()
	end

	self.commonItems = nil
end

function CoreVerificationEnterStageViewMode4:StopAllTimer()
	for iter_25_0, iter_25_1 in pairs(self.timers) do
		iter_25_1:Stop()
	end

	self.timers = {}
end

local var_0_1 = "delayedEnterCall"

function CoreVerificationEnterStageViewMode4:StartScheduleDelayEnterCall()
	local var_26_0 = FrameTimer.New(function()
		if not manager.guide:IsPlaying() then
			self:StopScheduleDelayEnterCall()
			manager.windowBar:ShowGameHelp()
			CoreVerificationChallengeMode4Action.SetSeasonIsTips()
		end
	end, 1, -1)

	var_26_0:Start()

	self.timers[var_0_1] = var_26_0
end

function CoreVerificationEnterStageViewMode4:StopScheduleDelayEnterCall()
	if self.timers[var_0_1] then
		self.timers[var_0_1]:Stop()

		self.timers[var_0_1] = nil
	end
end

return CoreVerificationEnterStageViewMode4
