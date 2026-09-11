local CoreVerificationChallengeStageViewMode3 = class("CoreVerificationChallengeStageViewMode3", ReduxView)

function CoreVerificationChallengeStageViewMode3:UIName()
	return "Widget/System/Core_verification_new/Mode3/Core_Verification_OrdinaryStageUI_Mode3"
end

function CoreVerificationChallengeStageViewMode3:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationChallengeStageViewMode3:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationChallengeStageViewMode3:InitUI()
	self:BindCfgUI()

	self.challengeHeadItems = {}

	for iter_4_0 = 1, 3 do
		self.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	self.rightHeadItems = {}

	for iter_4_1 = 1, 3 do
		self.rightHeadItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(self["heroRightGo_" .. iter_4_1], iter_4_1)
	end

	self.recommondHeroItems = {}
	self.recommondAttributeItems = {}
	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
	self.timeController_ = self.controller_:GetController("time")
	self.pointsController_ = self.controller_:GetController("points")
	self.stateController_ = self.controller_:GetController("state01")
end

function CoreVerificationChallengeStageViewMode3:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = self.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3,
			activityID = CoreVerificationChallengeTools.GetActivityId()
		})
	end)
	self:AddBtnListener(self.flushedBtn_, nil, function()
		if CoreVerificationChallengeMode3Data:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
				OkCallback = function()
					CoreVerificationChallengeMode3Action.ResetCurStage(self.stage_id)
				end
			})
		else
			ShowTips("CORE_VERIFICATION_CL_LOCK_TIPS_2")
		end
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
end

function CoreVerificationChallengeStageViewMode3:OnEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	TimeTools.StartAfterSeconds(0.033, handler(self, function()
		self:UpdateCoreVerification()
	end), {})
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function CoreVerificationChallengeStageViewMode3:UpdateCoreVerification()
	self.cfg = CoreVerificationChallengeMode3Data:GetChallengeStageCfg()
	self.stage_id = self.cfg.stage_id

	self:RefreshTitle()
	self:RefreshEnvAffix()
	self:RefreshCallBack()
end

function CoreVerificationChallengeStageViewMode3:RefreshCallBack()
	return
end

function CoreVerificationChallengeStageViewMode3:RefreshEnvAffix()
	local var_14_0 = CoreVerificationClMode3Cfg[self.stage_id]

	self.stageDesc_.text = getAffixDesc(ActivityAffixPoolCfg[CoreVerificationClMode3Cfg[self.stage_id].stage_affix[1]].affix)
	self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[var_14_0.type_affix[1]].affix)
	self.stageAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[var_14_0.type_affix[1]].affix)

	if var_14_0.type_affix and #var_14_0.type_affix > 0 then
		self.stateController_:SetSelectedIndex(0)
	else
		self.stateController_:SetSelectedIndex(1)
	end

	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", self.cfg.stage_img))
	self.stageName_.text = self.cfg.stage_name

	for iter_14_0, iter_14_1 in ipairs(var_14_0.recommend) do
		self.recommondAttributeItems[iter_14_0] = self.recommondAttributeItems[iter_14_0] or CoreVerificationChallengeRecommendAttributeItem.New(Object.Instantiate(self.attributeGo_, self.tagContent_), iter_14_0)

		SetActive(self.recommondAttributeItems[iter_14_0].gameObject_, true)
		self.recommondAttributeItems[iter_14_0]:RefreshUI(iter_14_1)
	end

	for iter_14_2 = #var_14_0.recommend + 1, #self.recommondAttributeItems do
		SetActive(self.recommondAttributeItems[iter_14_2].gameObject_, false)
	end

	for iter_14_3, iter_14_4 in ipairs(var_14_0.recommend_team) do
		self.recommondHeroItems[iter_14_3] = self.recommondHeroItems[iter_14_3] or CoreVerificationChallengeHeroHeadItem.New(Object.Instantiate(self.recommendGo_, self.roleTrs_), iter_14_3)

		SetActive(self.recommondHeroItems[iter_14_3].gameObject_, true)
		self.recommondHeroItems[iter_14_3]:RefreshUI(iter_14_4 and iter_14_4 or 0)
	end

	for iter_14_5 = #var_14_0.recommend_team + 1, #self.recommondHeroItems do
		SetActive(self.recommondHeroItems[iter_14_5].gameObject_, false)
	end
end

function CoreVerificationChallengeStageViewMode3:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	CoreVerificationChallengeStageViewMode3.super.OnExit(self)
end

function CoreVerificationChallengeStageViewMode3:RefreshTitle()
	self.titleText_.text = self.cfg.stage_name
	self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)

	local var_16_0 = CoreVerificationChallengeMode3Data:GetChallengeStage()

	if var_16_0.recently_challenge_value and var_16_0.recently_challenge_value > 0 then
		self.timeController_:SetSelectedIndex(1)
		self.pointsController_:SetSelectedIndex(1)

		self.scoreText_.text = var_16_0.recently_challenge_value or 0
		self.pushTimeText_.text = manager.time:DescCdTime2(var_16_0.min_seconds)
	else
		self.timeController_:SetSelectedIndex(0)
		self.pointsController_:SetSelectedIndex(0)
	end

	local var_16_1

	if var_16_0 then
		var_16_1 = var_16_0.challenge_lock or {}
	end

	for iter_16_0 = 1, 3 do
		self.challengeHeadItems[iter_16_0]:RefreshUI((var_16_1[iter_16_0] or nil) and (var_16_1[iter_16_0] or 0))
	end

	for iter_16_1 = 1, 3 do
		self.rightHeadItems[iter_16_1]:RefreshUI((var_16_1[iter_16_1] or nil) and (var_16_1[iter_16_1] or 0))
	end

	self.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
end

function CoreVerificationChallengeStageViewMode3:Dispose()
	for iter_17_0 = 1, 3 do
		self.challengeHeadItems[iter_17_0]:Dispose()

		self.challengeHeadItems[iter_17_0] = nil
	end

	for iter_17_1 = 1, 3 do
		self.rightHeadItems[iter_17_1]:Dispose()

		self.rightHeadItems[iter_17_1] = nil
	end

	for iter_17_2 = 1, #self.recommondHeroItems do
		self.recommondHeroItems[iter_17_2]:Dispose()

		self.recommondHeroItems[iter_17_2] = nil
	end

	for iter_17_3 = 1, #self.recommondAttributeItems do
		self.recommondAttributeItems[iter_17_3]:Dispose()

		self.recommondAttributeItems[iter_17_3] = nil
	end

	CoreVerificationChallengeStageViewMode3.super.Dispose(self)
end

return CoreVerificationChallengeStageViewMode3
