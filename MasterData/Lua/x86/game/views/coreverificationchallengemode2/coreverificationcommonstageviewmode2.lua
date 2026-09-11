local CoreVerificationCommonStageViewMode2 = class("CoreVerificationCommonStageViewMode2", ReduxView)

function CoreVerificationCommonStageViewMode2:UIName()
	return "Widget/System/Core_verification_new/Mode2/Core_Verification_OrdinaryStageUI_Mode2"
end

function CoreVerificationCommonStageViewMode2:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationCommonStageViewMode2:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationCommonStageViewMode2:InitUI()
	self:BindCfgUI()

	self.challengeHeadItems = {}
	self.stateController_ = self.controller_:GetController("state")
	self.tipsStateController_ = self.tipsGo_:GetComponent("ControllerExCollection"):GetController("tipsState")
	self.envAffixItem = CoreVerificationChallengeAffixItemItem.New(self.envAffixGo_)

	for iter_4_0 = 1, 3 do
		self.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	self.recommondHeroItems = {}

	for iter_4_1 = 1, 3 do
		self.recommondHeroItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(self["recommandGo_" .. iter_4_1], iter_4_1)
	end

	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
end

function CoreVerificationCommonStageViewMode2:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = self.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2,
			activityID = CoreVerificationChallengeTools.GetActivityId()
		})
	end)
	self:AddBtnListener(self.flushedBtn_, nil, function()
		if CoreVerificationChallengeMode2Data:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
				OkCallback = function()
					CoreVerificationChallengeMode2Action.ResetCurStage(self.stage_id)
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
	self:AddBtnListener(self.bgBtn_, nil, function()
		SetActive(self.tipsGo_, false)
	end)
end

function CoreVerificationCommonStageViewMode2:OnEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	TimeTools.StartAfterSeconds(0.033, handler(self, function()
		self:UpdateCoreVerification()
	end), {})
end

function CoreVerificationCommonStageViewMode2:UpdateCoreVerification()
	self.cfg = self.params_.cfg
	self.index = self.params_.index
	self.stage_id = self.cfg.stage_id
	self.heroList = self.params_.heroList
	self.params_.heroList = nil

	self:RefreshTitle()
	self:RefreshEnvAffix()
	SetActive(self.tipsGo_, false)
end

function CoreVerificationCommonStageViewMode2:ShowTipsView(arg_14_1, arg_14_2, arg_14_3)
	SetActive(self.tipsGo_, true)

	local var_14_0 = ActivityAffixPoolCfg[arg_14_1].affix

	var_14_0[2] = ActivityAffixPoolCfg[arg_14_1].affix[2] == 50 and 1 or var_14_0[2]
	self.tipsNameText_.text = getAffixName(var_14_0)
	self.tipsDescText_.text = getAffixDesc(var_14_0)
	buffLv = buffLv == 0 and 1 or buffLv
	self.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), buffLv)
end

function CoreVerificationCommonStageViewMode2:RefreshEnvAffix()
	self.envAffixItem:RefreshUI({
		type = 3,
		buff_id = CoreVerificationClMode2Cfg[self.stage_id].stage_affix[1]
	})

	self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_affix[1]].affix)
	self.stageAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_affix[1]].affix)
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", self.cfg.stage_img))
	self.stageName_.text = self.cfg.stage_name

	for iter_15_0 = 1, 3 do
		self.recommondHeroItems[iter_15_0]:RefreshUI((CoreVerificationClMode2Cfg[self.stage_id].recommend_team[iter_15_0] or nil) and (CoreVerificationClMode2Cfg[self.stage_id].recommend_team[iter_15_0] or 0))
	end

	self.buffIcon_.sprite = getAffixSprite(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_buff[1]].affix)
	self.buffName_.text = getAffixName(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_buff[1]].affix)
	self.buffDesc_.text = getAffixDesc(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_buff[1]].affix)
end

function CoreVerificationCommonStageViewMode2:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	CoreVerificationCommonStageViewMode2.super.OnExit(self)
end

function CoreVerificationCommonStageViewMode2:RefreshTitle()
	self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.titleText_.text = self.cfg.stage_name
	self.limitText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_5"), "+" .. self.cfg.cost_limit_up)

	local var_17_0 = CoreVerificationChallengeMode2Data:GetCommonStageByIndex(self.index)

	if var_17_0 and #var_17_0.common_lock_id > 0 then
		self.stateController_:SetSelectedIndex(1)
	else
		self.stateController_:SetSelectedIndex(0)
	end

	for iter_17_0 = 1, 3 do
		self.challengeHeadItems[iter_17_0]:RefreshUI((self.heroList or nil) and (self.heroList[iter_17_0] and self.heroList[iter_17_0] or 0))
	end

	self.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
end

function CoreVerificationCommonStageViewMode2:Dispose()
	for iter_18_0 = 1, 3 do
		self.challengeHeadItems[iter_18_0]:Dispose()

		self.challengeHeadItems[iter_18_0] = nil
	end

	for iter_18_1 = 1, 3 do
		self.recommondHeroItems[iter_18_1]:Dispose()

		self.recommondHeroItems[iter_18_1] = nil
	end

	self.envAffixItem:Dispose()
	CoreVerificationCommonStageViewMode2.super.Dispose(self)
end

return CoreVerificationCommonStageViewMode2
