local var_0_0 = class("CoreVerificationCommonStageViewMode2", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode2/Core_Verification_OrdinaryStageUI_Mode2"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.challengeHeadItems = {}
	arg_4_0.stateController_ = arg_4_0.controller_:GetController("state")
	arg_4_0.tipsStateController_ = arg_4_0.tipsGo_:GetComponent("ControllerExCollection"):GetController("tipsState")
	arg_4_0.envAffixItem = CoreVerificationChallengeAffixItemItem.New(arg_4_0.envAffixGo_)

	for iter_4_0 = 1, 3 do
		arg_4_0.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	arg_4_0.recommondHeroItems = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.recommondHeroItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["recommandGo_" .. iter_4_1], iter_4_1)
	end

	arg_4_0.updateInfoHandler = handler(arg_4_0, arg_4_0.UpdateCoreVerification)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_6_0 = CoreVerificationChallengeTools.GetActivityId()

		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = arg_5_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2,
			activityID = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.flushedBtn_, nil, function()
		if CoreVerificationChallengeMode2Data:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
				OkCallback = function()
					CoreVerificationChallengeMode2Action.ResetCurStage(arg_5_0.stage_id)
				end
			})
		else
			ShowTips("CORE_VERIFICATION_CL_LOCK_TIPS_2")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, function()
		SetActive(arg_5_0.tipsGo_, false)
	end)
end

function var_0_0.OnEnter(arg_11_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_11_0.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.redPoint:bindUIandKey(arg_11_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)

	local var_11_0 = handler(arg_11_0, function()
		arg_11_0:UpdateCoreVerification()
	end)

	TimeTools.StartAfterSeconds(0.033, var_11_0, {})
end

function var_0_0.UpdateCoreVerification(arg_13_0)
	arg_13_0.cfg = arg_13_0.params_.cfg
	arg_13_0.index = arg_13_0.params_.index
	arg_13_0.stage_id = arg_13_0.cfg.stage_id
	arg_13_0.heroList = arg_13_0.params_.heroList
	arg_13_0.params_.heroList = nil

	arg_13_0:RefreshTitle()
	arg_13_0:RefreshEnvAffix()
	SetActive(arg_13_0.tipsGo_, false)
end

function var_0_0.ShowTipsView(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	SetActive(arg_14_0.tipsGo_, true)

	local var_14_0 = ActivityAffixPoolCfg[arg_14_1].affix

	var_14_0[2] = var_14_0[2] == 50 and 1 or var_14_0[2]
	arg_14_0.tipsNameText_.text = getAffixName(var_14_0)
	arg_14_0.tipsDescText_.text = getAffixDesc(var_14_0)
	buffLv = buffLv == 0 and 1 or buffLv
	arg_14_0.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), buffLv)
end

function var_0_0.RefreshEnvAffix(arg_15_0)
	local var_15_0 = CoreVerificationClMode2Cfg[arg_15_0.stage_id]
	local var_15_1 = {
		type = 3,
		buff_id = var_15_0.stage_affix[1]
	}

	arg_15_0.envAffixItem:RefreshUI(var_15_1)

	local var_15_2 = ActivityAffixPoolCfg[var_15_0.stage_affix[1]].affix

	arg_15_0.stageAffixName_.text = getAffixName(var_15_2)
	arg_15_0.stageAffixDesc_.text = getAffixDesc(var_15_2)
	arg_15_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", arg_15_0.cfg.stage_img))
	arg_15_0.stageName_.text = arg_15_0.cfg.stage_name

	local var_15_3 = var_15_0.recommend_team

	for iter_15_0 = 1, 3 do
		local var_15_4 = var_15_3[iter_15_0] and var_15_3[iter_15_0] or 0

		arg_15_0.recommondHeroItems[iter_15_0]:RefreshUI(var_15_4)
	end

	local var_15_5 = ActivityAffixPoolCfg[var_15_0.stage_buff[1]].affix

	arg_15_0.buffIcon_.sprite = getAffixSprite(var_15_5)
	arg_15_0.buffName_.text = getAffixName(var_15_5)
	arg_15_0.buffDesc_.text = getAffixDesc(var_15_5)
end

function var_0_0.OnExit(arg_16_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_16_0.updateInfoHandler)
	manager.redPoint:unbindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	var_0_0.super.OnExit(arg_16_0)
end

function var_0_0.RefreshTitle(arg_17_0)
	local var_17_0 = arg_17_0.cfg.stage_com_affix[1]
	local var_17_1 = ActivityAffixPoolCfg[var_17_0].affix

	arg_17_0.comAffixName_.text = getAffixName(var_17_1)
	arg_17_0.comAffixDesc_.text = getAffixDesc(var_17_1)
	arg_17_0.titleText_.text = arg_17_0.cfg.stage_name
	arg_17_0.limitText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_5"), "+" .. arg_17_0.cfg.cost_limit_up)

	local var_17_2 = CoreVerificationChallengeMode2Data:GetCommonStageByIndex(arg_17_0.index)

	if var_17_2 and #var_17_2.common_lock_id > 0 then
		arg_17_0.stateController_:SetSelectedIndex(1)
	else
		arg_17_0.stateController_:SetSelectedIndex(0)
	end

	for iter_17_0 = 1, 3 do
		local var_17_3 = 0

		if arg_17_0.heroList then
			var_17_3 = arg_17_0.heroList[iter_17_0] and arg_17_0.heroList[iter_17_0] or 0
		end

		arg_17_0.challengeHeadItems[iter_17_0]:RefreshUI(var_17_3)
	end

	local var_17_4 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_17_0.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(var_17_4.stopTime)
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0 = 1, 3 do
		arg_18_0.challengeHeadItems[iter_18_0]:Dispose()

		arg_18_0.challengeHeadItems[iter_18_0] = nil
	end

	for iter_18_1 = 1, 3 do
		arg_18_0.recommondHeroItems[iter_18_1]:Dispose()

		arg_18_0.recommondHeroItems[iter_18_1] = nil
	end

	arg_18_0.envAffixItem:Dispose()
	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
