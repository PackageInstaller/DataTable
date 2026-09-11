local CoreVerificationChallengeStageView = class("CoreVerificationChallengeStageView", ReduxView)

function CoreVerificationChallengeStageView:UIName()
	return "Widget/System/Core_verification_new/Core_Verification_ChallengeStageUI_new"
end

function CoreVerificationChallengeStageView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationChallengeStageView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationChallengeStageView:InitUI()
	self:BindCfgUI()

	self.envAffixItem = CoreVerificationChallengeAffixItemItem.New(self.envAffixGo_)
	self.tipsStateController_ = self.tipsGo_:GetComponent("ControllerExCollection"):GetController("tipsState")
	self.affixList_ = LuaList.New(handler(self, self.IndexHeroItem), self.uiListGo_, CoreVerificationChallengeAffixSelectItem)
	self.buffAffixList_ = LuaList.New(handler(self, self.IndexBuffItem), self.bufflList_, CoreVerificationChallengeStageAffixItem)
	self.debuffAffixList_ = LuaList.New(handler(self, self.IndexDebuffItem), self.debuffList_, CoreVerificationChallengeStageAffixItem)
	self.challengeHeadItems = {}

	for iter_4_0 = 1, 3 do
		self.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	self.recommondHeroItems = {}

	for iter_4_1 = 1, 3 do
		self.recommondHeroItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(self["recommandGo_" .. iter_4_1], iter_4_1)
	end

	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
	self.scoreController_ = self.controller_:GetController("scorstate")
end

function CoreVerificationChallengeStageView:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_6_0 = CoreVerificationChallengeData:GetSelectAffixs()

		CoreVerificationChallengeAction.SetBattleAffixs()
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

function CoreVerificationChallengeStageView:IndexHeroItem(arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, self.select_affixs[arg_11_1])
end

function CoreVerificationChallengeStageView:IndexBuffItem(arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(self.cfg.stage_buff[arg_12_1][1], 0, 1, self.stage_id)
	arg_12_2:RefreshLock()
	arg_12_2:RegisterClickListener(function(arg_13_0, arg_13_1)
		self:RefreshCallBack()

		if arg_13_1 then
			self.tipsStateController_:SetSelectedIndex(0)
			self:ShowTipsView(arg_13_0)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function CoreVerificationChallengeStageView:IndexDebuffItem(arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(self.cfg.stage_debuff[arg_14_1][1], 1, 1, self.stage_id)
	arg_14_2:RefreshLock()
	arg_14_2:RegisterClickListener(function(arg_15_0, arg_15_1)
		self:RefreshCallBack()

		if arg_15_1 then
			self.tipsStateController_:SetSelectedIndex(1)
			self:ShowTipsView(arg_15_0)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function CoreVerificationChallengeStageView:ShowTipsView(arg_16_1)
	SetActive(self.tipsGo_, true)

	local var_16_0 = ActivityAffixPoolCfg[arg_16_1].affix

	var_16_0[2] = ActivityAffixPoolCfg[arg_16_1].affix[2] == 50 and 1 or var_16_0[2]
	self.tipsNameText_.text = getAffixName(var_16_0)
	self.tipsDescText_.text = getAffixDesc(var_16_0)

	local var_16_1 = CoreVerificationChallengeData:GetBuffLevelById(arg_16_1)

	var_16_1 = var_16_1 == 0 and 1 or var_16_1
	self.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), var_16_1)
	self.tipsSubText_.text = ""
end

function CoreVerificationChallengeStageView:OnEnter()
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.bufflList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.debuffList_.transform)
	TimeTools.StartAfterSeconds(0.033, handler(self, function()
		self:UpdateCoreVerification()
	end), {})
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function CoreVerificationChallengeStageView:UpdateCoreVerification()
	self.selectAffixList = {}
	self.cfg = CoreVerificationChallengeData:GetChallengeStageCfg()
	self.stage_id = self.cfg.stage_id

	SetActive(self.tipsGo_, false)

	if #CoreVerificationChallengeData:GetBuffList() <= 0 then
		CoreVerificationChallengeData:ResetSelectAffix()
	end

	self:RefreshTitle()
	self:RefreshEnvAffix()
	self:RefreshCallBack()
	self:RefreshAffixList()
end

function CoreVerificationChallengeStageView:RefreshAffixList()
	self.buffAffixList_:StartScroll(#self.cfg.stage_buff)
	self.debuffAffixList_:StartScroll(#self.cfg.stage_debuff)
end

function CoreVerificationChallengeStageView:RefreshCallBack()
	local var_21_0 = CoreVerificationChallengeData:GetSelectAffixs()

	self.select_affixs = CoreVerificationChallengeData:GetSelectAffixs()

	self.affixList_:StartScroll(#self.select_affixs)

	self.efficiencyNum_.text = CoreVerificationChallengeData:GetEfficiencyNum()
	self.affixNum_.text = string.format("%s/6", (var_21_0 or nil) and (#var_21_0 or 0))
end

function CoreVerificationChallengeStageView:RefreshEnvAffix()
	self.envAffixItem:RefreshUI({
		type = 3,
		buff_id = CoreVerificationClMode1Cfg[self.stage_id].stage_affix[1]
	})

	self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[CoreVerificationClMode1Cfg[self.stage_id].stage_affix[1]].affix)
	self.stageAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[CoreVerificationClMode1Cfg[self.stage_id].stage_affix[1]].affix)
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", self.cfg.stage_img))

	for iter_22_0 = 1, 3 do
		self.recommondHeroItems[iter_22_0]:RefreshUI((CoreVerificationClMode1Cfg[self.stage_id].recommend_team[iter_22_0] or nil) and (CoreVerificationClMode1Cfg[self.stage_id].recommend_team[iter_22_0] or 0))
	end
end

function CoreVerificationChallengeStageView:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	CoreVerificationChallengeStageView.super.OnExit(self)
end

function CoreVerificationChallengeStageView:RefreshTitle()
	self.titleText_.text = self.cfg.stage_name
	self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)

	local var_24_0 = CoreVerificationChallengeData:GetChallengeStage()

	self.efficiencyNum_.text = CoreVerificationChallengeData:GetEfficiencyNum()

	local var_24_1 = CoreVerificationChallengeData:GetSelectAffixs()

	self.affixNum_.text = string.format("%s/6", (var_24_1 or nil) and (#var_24_1 or 0))

	if var_24_0.max_challenge_value and var_24_0.max_challenge_value > 0 then
		self.scoreController_:SetSelectedIndex(0)

		self.scoreText_.text = var_24_0.max_challenge_value
	else
		self.scoreController_:SetSelectedIndex(1)
	end

	local var_24_2 = var_24_0.challenge_lock

	for iter_24_0 = 1, 3 do
		self.challengeHeadItems[iter_24_0]:RefreshUI((var_24_2 or nil) and (var_24_2[iter_24_0] and var_24_2[iter_24_0] or 0))
	end

	self.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
end

function CoreVerificationChallengeStageView:Dispose()
	for iter_25_0 = 1, 3 do
		self.challengeHeadItems[iter_25_0]:Dispose()

		self.challengeHeadItems[iter_25_0] = nil
	end

	for iter_25_1 = 1, 3 do
		self.recommondHeroItems[iter_25_1]:Dispose()

		self.recommondHeroItems[iter_25_1] = nil
	end

	if self.affixList_ then
		self.affixList_:Dispose()

		self.affixList_ = nil
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
	CoreVerificationChallengeStageView.super.Dispose(self)
end

return CoreVerificationChallengeStageView
