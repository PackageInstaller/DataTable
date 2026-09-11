local CoreVerificationCommonStageView = class("CoreVerificationCommonStageView", ReduxView)

function CoreVerificationCommonStageView:UIName()
	return "Widget/System/Core_verification_new/Core_Verification_OrdinaryStageUI_new"
end

function CoreVerificationCommonStageView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationCommonStageView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationCommonStageView:InitUI()
	self:BindCfgUI()

	self.challengeHeadItems = {}
	self.stateController_ = self.controller_:GetController("state")
	self.tipsStateController_ = self.tipsGo_:GetComponent("ControllerExCollection"):GetController("tipsState")
	self.envAffixItem = CoreVerificationChallengeAffixItemItem.New(self.envAffixGo_)
	self.buffAffixList_ = LuaList.New(handler(self, self.IndexBuffItem), self.buffList_, CoreVerificationCommonStageAffixItem)
	self.debuffAffixList_ = LuaList.New(handler(self, self.IndexDebuffItem), self.debuffList_, CoreVerificationCommonStageAffixItem)

	for iter_4_0 = 1, 3 do
		self.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	self.recommondHeroItems = {}

	for iter_4_1 = 1, 3 do
		self.recommondHeroItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(self["recommandGo_" .. iter_4_1], iter_4_1)
	end

	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
end

function CoreVerificationCommonStageView:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = self.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE,
			activityID = CoreVerificationChallengeTools.GetActivityId()
		})
	end)
	self:AddBtnListener(self.flushedBtn_, nil, function()
		if CoreVerificationChallengeData:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
				OkCallback = function()
					CoreVerificationChallengeAction.ResetCurStage(self.stage_id)
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

function CoreVerificationCommonStageView:OnEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.buffList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.debuffList_.transform)
	TimeTools.StartAfterSeconds(0.033, handler(self, function()
		self:UpdateCoreVerification()
	end), {})
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function CoreVerificationCommonStageView:UpdateCoreVerification()
	self.cfg = self.params_.cfg
	self.index = self.params_.index
	self.stage_id = self.cfg.stage_id
	self.heroList = self.params_.heroList
	self.params_.heroList = nil

	self:RefreshTitle()
	self:RefreshEnvAffix()
	SetActive(self.tipsGo_, false)
	self:RefreshAffixList()
end

function CoreVerificationCommonStageView:RefreshAffixList()
	self.buffAffixList_:StartScroll(#self.cfg.stage_buff)
	self.debuffAffixList_:StartScroll(#self.cfg.stage_debuff)
end

function CoreVerificationCommonStageView:IndexBuffItem(arg_15_1, arg_15_2)
	arg_15_2:RefreshUI(self.cfg.stage_buff[arg_15_1][1], 0, 0, arg_15_1)
	arg_15_2:RefreshLock()
	arg_15_2:RegisterClickListener(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_1 then
			self.tipsStateController_:SetSelectedIndex(0)
			self:ShowTipsView(arg_16_0, arg_16_1, arg_16_2)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function CoreVerificationCommonStageView:IndexDebuffItem(arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(self.cfg.stage_debuff[arg_17_1][1], 1, 0, arg_17_1)
	arg_17_2:RefreshLock()
	arg_17_2:RegisterClickListener(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_1 then
			self.tipsStateController_:SetSelectedIndex(1)
			self:ShowTipsView(arg_18_0, arg_18_1, arg_18_2)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function CoreVerificationCommonStageView:ShowTipsView(arg_19_1, arg_19_2, arg_19_3)
	SetActive(self.tipsGo_, true)

	local var_19_0 = ActivityAffixPoolCfg[arg_19_1].affix

	var_19_0[2] = ActivityAffixPoolCfg[arg_19_1].affix[2] == 50 and 1 or var_19_0[2]
	self.tipsNameText_.text = getAffixName(var_19_0)
	self.tipsDescText_.text = getAffixDesc(var_19_0)

	local var_19_1 = CoreVerificationChallengeData:GetBuffLevelById(arg_19_1)

	var_19_1 = var_19_1 == 0 and 1 or var_19_1
	self.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), var_19_1)
	self.tipsSubText_.text = self.cfg.stage_buff_upgrade[arg_19_3]
end

function CoreVerificationCommonStageView:RefreshEnvAffix()
	self.envAffixItem:RefreshUI({
		type = 3,
		buff_id = CoreVerificationClMode1Cfg[self.stage_id].stage_affix[1]
	})

	self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[CoreVerificationClMode1Cfg[self.stage_id].stage_affix[1]].affix)
	self.stageAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[CoreVerificationClMode1Cfg[self.stage_id].stage_affix[1]].affix)
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", self.cfg.stage_img))
	self.stageName_.text = self.cfg.stage_name

	for iter_20_0 = 1, 3 do
		self.recommondHeroItems[iter_20_0]:RefreshUI((CoreVerificationClMode1Cfg[self.stage_id].recommend_team[iter_20_0] or nil) and (CoreVerificationClMode1Cfg[self.stage_id].recommend_team[iter_20_0] or 0))
	end
end

function CoreVerificationCommonStageView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	self.buffAffixList_:StopRender()
	self.debuffAffixList_:StopRender()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	CoreVerificationCommonStageView.super.OnExit(self)
end

function CoreVerificationCommonStageView:RefreshTitle()
	self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.titleText_.text = self.cfg.stage_name
	self.topDescText_.text = GetTips("CORE_VERIFICATION_CL_BUFF_TIPS")

	local var_22_0 = CoreVerificationChallengeData:GetCommonStageByIndex(self.index)

	if var_22_0 and #var_22_0.common_lock_id > 0 then
		self.stateController_:SetSelectedIndex(1)
	else
		self.stateController_:SetSelectedIndex(0)
	end

	for iter_22_0 = 1, 3 do
		self.challengeHeadItems[iter_22_0]:RefreshUI((self.heroList or nil) and (self.heroList[iter_22_0] and self.heroList[iter_22_0] or 0))
	end

	self.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
end

function CoreVerificationCommonStageView:Dispose()
	for iter_23_0 = 1, 3 do
		self.challengeHeadItems[iter_23_0]:Dispose()

		self.challengeHeadItems[iter_23_0] = nil
	end

	for iter_23_1 = 1, 3 do
		self.recommondHeroItems[iter_23_1]:Dispose()

		self.recommondHeroItems[iter_23_1] = nil
	end

	if self.buffAffixList_ then
		self.buffAffixList_:Dispose()

		self.buffAffixList_ = nil
	end

	if self.debuffAffixList_ then
		self.debuffAffixList_:Dispose()

		self.debuffAffixList_ = nil
	end

	self.envAffixItem:Dispose()
	CoreVerificationCommonStageView.super.Dispose(self)
end

return CoreVerificationCommonStageView
