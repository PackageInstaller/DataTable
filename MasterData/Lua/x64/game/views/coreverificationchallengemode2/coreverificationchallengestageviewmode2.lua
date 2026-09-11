local CoreVerificationChallengeStageViewMode2 = class("CoreVerificationChallengeStageViewMode2", ReduxView)

function CoreVerificationChallengeStageViewMode2:UIName()
	return "Widget/System/Core_verification_new/Mode2/Core_Verification_ChallengeStageUI_Mode2"
end

function CoreVerificationChallengeStageViewMode2:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationChallengeStageViewMode2:Init()
	self:InitUI()
	self:AddUIListeners()
end

function CoreVerificationChallengeStageViewMode2:InitUI()
	self:BindCfgUI()

	self.envAffixItem = CoreVerificationChallengeAffixItemItem.New(self.envAffixGo_)
	self.tipsStateController_ = self.tipsGo_:GetComponent("ControllerExCollection"):GetController("tipsState")
	self.buffAffixList_ = LuaList.New(handler(self, self.IndexBuffItem), self.bufflList_, CoreVerificationChallengeStageAffixItemMode2)
	self.debuffAffixList_ = LuaList.New(handler(self, self.IndexDebuffItem), self.debuffList_, CoreVerificationChallengeStageAffixItemMode2)
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

function CoreVerificationChallengeStageViewMode2:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_6_0, var_6_1 = CoreVerificationChallengeMode2Data:GetPostNum()

		if var_6_1 < var_6_0 then
			ShowTips("CORE_VERIFICATION_CL_COST_OVERLIMIT")

			return
		end

		local var_6_2 = CoreVerificationChallengeMode2Data:GetSelectAffixs()

		CoreVerificationChallengeMode2Action.SetBattleAffixs()
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

function CoreVerificationChallengeStageViewMode2:IndexBuffItem(arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(self.cfg.stage_affix_buff[arg_11_1], 0, 1, self.stage_id)
	arg_11_2:RegisterClickListener(function(arg_12_0, arg_12_1)
		self:RefreshCallBack()

		if arg_12_1 then
			self.tipsStateController_:SetSelectedIndex(0)
			self:ShowTipsView(arg_12_0)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function CoreVerificationChallengeStageViewMode2:IndexDebuffItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(self.cfg.stage_affix_debuff[arg_13_1], 1, 1, self.stage_id)
	arg_13_2:RegisterClickListener(function(arg_14_0, arg_14_1)
		self:RefreshCallBack()

		if arg_14_1 then
			self.tipsStateController_:SetSelectedIndex(1)
			self:ShowTipsView(arg_14_0)
		else
			SetActive(self.tipsGo_, false)
		end
	end)
end

function CoreVerificationChallengeStageViewMode2:ShowTipsView(arg_15_1)
	SetActive(self.tipsGo_, true)

	local var_15_0 = ActivityAffixPoolCfg[arg_15_1].affix

	var_15_0[2] = ActivityAffixPoolCfg[arg_15_1].affix[2] == 50 and 1 or var_15_0[2]
	self.tipsNameText_.text = getAffixName(var_15_0)
	self.tipsDescText_.text = getAffixDesc(var_15_0)
	self.tipsLimitText_.text = ActivityAffixPoolCfg[arg_15_1].point
	self.tipsLimitText_2.text = ActivityAffixPoolCfg[arg_15_1].point
end

function CoreVerificationChallengeStageViewMode2:OnEnter()
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

function CoreVerificationChallengeStageViewMode2:UpdateCoreVerification()
	self.selectAffixList = {}
	self.cfg = CoreVerificationChallengeMode2Data:GetChallengeStageCfg()
	self.stage_id = self.cfg.stage_id

	SetActive(self.tipsGo_, false)
	self:RefreshTitle()
	self:RefreshEnvAffix()
	self:RefreshCallBack()
	self:RefreshAffixList()
end

function CoreVerificationChallengeStageViewMode2:RefreshAffixList()
	self.buffAffixList_:StartScroll(#self.cfg.stage_affix_buff)
	self.debuffAffixList_:StartScroll(#self.cfg.stage_affix_debuff)
end

function CoreVerificationChallengeStageViewMode2:RefreshCallBack()
	self.efficiencyNum_.text = CoreVerificationChallengeMode2Data:GetEfficiencyNum()

	local var_20_0, var_20_1 = CoreVerificationChallengeMode2Data:GetPostNum()

	self.limitNumText_.text = var_20_1 < var_20_0 and string.format(GetTips("CORE_VERIFICATION_CL_COST"), "<color=#FF000B>" .. var_20_0 .. "</color>" .. "/" .. "<color=#CDD2D9>" .. var_20_1 .. "</color>") or string.format(GetTips("CORE_VERIFICATION_CL_COST"), var_20_0 .. "/" .. var_20_1)
end

function CoreVerificationChallengeStageViewMode2:RefreshEnvAffix()
	self.envAffixItem:RefreshUI({
		type = 3,
		buff_id = CoreVerificationClMode2Cfg[self.stage_id].stage_affix[1]
	})

	self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_affix[1]].affix)
	self.stageAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[CoreVerificationClMode2Cfg[self.stage_id].stage_affix[1]].affix)
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", self.cfg.stage_img))

	for iter_21_0 = 1, 3 do
		self.recommondHeroItems[iter_21_0]:RefreshUI((CoreVerificationClMode2Cfg[self.stage_id].recommend_team[iter_21_0] or nil) and (CoreVerificationClMode2Cfg[self.stage_id].recommend_team[iter_21_0] or 0))
	end
end

function CoreVerificationChallengeStageViewMode2:OnExit()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	CoreVerificationChallengeStageViewMode2.super.OnExit(self)
end

function CoreVerificationChallengeStageViewMode2:RefreshTitle()
	self.titleText_.text = self.cfg.stage_name
	self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)

	local var_23_0 = CoreVerificationChallengeMode2Data:GetChallengeStage()

	self.efficiencyNum_.text = CoreVerificationChallengeMode2Data:GetEfficiencyNum()

	local var_23_1 = CoreVerificationChallengeMode2Data:GetSelectAffixs()

	if var_23_0.max_challenge_value and var_23_0.max_challenge_value > 0 then
		self.scoreController_:SetSelectedIndex(0)

		self.scoreText_.text = var_23_0.max_challenge_value
	else
		self.scoreController_:SetSelectedIndex(1)
	end

	local var_23_2 = var_23_0.challenge_lock

	for iter_23_0 = 1, 3 do
		self.challengeHeadItems[iter_23_0]:RefreshUI((var_23_2[iter_23_0] or nil) and (var_23_2[iter_23_0] or 0))
	end

	self.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
end

function CoreVerificationChallengeStageViewMode2:Dispose()
	for iter_24_0 = 1, 3 do
		self.challengeHeadItems[iter_24_0]:Dispose()

		self.challengeHeadItems[iter_24_0] = nil
	end

	for iter_24_1 = 1, 3 do
		self.recommondHeroItems[iter_24_1]:Dispose()

		self.recommondHeroItems[iter_24_1] = nil
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
	CoreVerificationChallengeStageViewMode2.super.Dispose(self)
end

return CoreVerificationChallengeStageViewMode2
