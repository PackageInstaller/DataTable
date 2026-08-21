local var_0_0 = class("CoreVerificationEnterStageViewMode2", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode2/Core_verification_ChooseUI02"
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

	arg_4_0.commonItems = {}
	arg_4_0.challengeHeadItems = {}

	for iter_4_0 = 1, 2 do
		local var_4_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)
		local var_4_1 = CoreVerificationClMode2Cfg.get_id_list_by_activity_id[var_4_0]
		local var_4_2 = CoreVerificationClMode2Cfg[var_4_1[iter_4_0]]

		arg_4_0.commonItems[iter_4_0] = CoreVerificationCommonStageItemMode2.New(arg_4_0["selectionGo_" .. iter_4_0], var_4_2, iter_4_0)
	end

	for iter_4_1 = 1, 3 do
		arg_4_0.challengeHeadItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["heroItemGo_" .. iter_4_1], iter_4_1)
	end

	arg_4_0.stateChallengeController_ = arg_4_0.clController_:GetController("scorstate")
	arg_4_0.lockController_ = arg_4_0.illustratedController_:GetController("lock")
	arg_4_0.updateInfoHandler = handler(arg_4_0, arg_4_0.UpdateCoreVerification)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeRankView", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.challengeBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeStageViewMode2", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_jump")
		JumpTools.OpenPageByJump("/coreVerificationChallengeIllustratedView", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.btn_flushedBtn_, nil, function()
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
	arg_5_0:AddBtnListener(arg_5_0.seasonBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationChallengeSeasonTipView")
	end)
end

function var_0_0.OnEnter(arg_15_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_RESET, arg_15_0.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.redPoint:bindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	arg_15_0:UpdateCoreVerification()
end

function var_0_0.UpdateCoreVerification(arg_16_0)
	arg_16_0.common_stage = CoreVerificationChallengeMode2Data:GetCommonStage()
	arg_16_0.challenge_stage = CoreVerificationChallengeMode2Data:GetChallengeStage()
	arg_16_0.isTips = CoreVerificationChallengeMode2Data:GetSeasonIsTips()

	if arg_16_0.isTips then
		CoreVerificationChallengeMode2Action.SetSeasonIsTips()
		JumpTools.OpenPageByJump("coreVerificationChallengeSeasonTipView")
	end

	arg_16_0:RefreshTitle()
	arg_16_0:RefreshCommonStage()
	arg_16_0:RefreshChallengeStage()
end

function var_0_0.RefreshChallengeStage(arg_17_0)
	local var_17_0 = CoreVerificationChallengeMode2Data:GetChallengeStage()

	if var_17_0.max_challenge_value and var_17_0.max_challenge_value > 0 then
		arg_17_0.stateChallengeController_:SetSelectedIndex(0)

		arg_17_0.challengeScoreText_.text = var_17_0.max_challenge_value
	else
		arg_17_0.stateChallengeController_:SetSelectedIndex(1)
	end

	local var_17_1 = CoreVerificationChallengeMode2Data:GetChallengeStageCfg()

	arg_17_0.challengeNameText_.text = GetI18NText(var_17_1.stage_name)
	arg_17_0.recommendIcon_.sprite = HeroTools.GetSkillAttributeIcon(var_17_1.recommend[1])

	local var_17_2 = var_17_0.challenge_lock

	if var_17_2 then
		for iter_17_0 = 1, 3 do
			local var_17_3 = var_17_2[iter_17_0] and var_17_2[iter_17_0] or 0

			arg_17_0.challengeHeadItems[iter_17_0]:RefreshUI(var_17_3)
		end
	end
end

function var_0_0.RefreshCommonStage(arg_18_0)
	local var_18_0 = CoreVerificationChallengeMode2Data:GetActivityId()
	local var_18_1 = ActivityCfg[var_18_0].sub_activity_list[2]
	local var_18_2 = CoreVerificationClMode2Cfg.get_id_list_by_activity_id[var_18_1]

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.common_stage) do
		local var_18_3 = 0

		for iter_18_2, iter_18_3 in ipairs(var_18_2) do
			if iter_18_1.stage_id == iter_18_3 then
				var_18_3 = iter_18_2
			end
		end

		arg_18_0.commonItems[var_18_3]:RefreshUI(iter_18_1)
	end

	if arg_18_0.common_stage and #arg_18_0.common_stage <= 0 then
		for iter_18_4 = 1, #arg_18_0.commonItems do
			arg_18_0.commonItems[iter_18_4]:RefreshUI(nil)
		end
	end
end

function var_0_0.OnExit(arg_19_0)
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_RESET, arg_19_0.updateInfoHandler)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_19_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function var_0_0.RefreshTitle(arg_20_0)
	local var_20_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE2)
	local var_20_1 = CoreVerificationClMode2Cfg.get_id_list_by_activity_id[var_20_0]
	local var_20_2 = CoreVerificationClMode2Cfg[var_20_1[3]].stage_com_affix[1]
	local var_20_3 = ActivityAffixPoolCfg[var_20_2].affix

	arg_20_0.comAffixName_.text = getAffixName(var_20_3)

	local var_20_4 = CoreVerificationChallengeMode2Data:GetPostLimitNum()

	arg_20_0.comAffixDesc_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST_LIMIT_1"), var_20_4)
	arg_20_0.comAffixIcon_.sprite = getAffixSprite(var_20_3)

	local var_20_5 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_20_0.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(var_20_5.stopTime)

	local var_20_6 = CoreVerificationChallengeMode2Data:GetChallengeStageCfg()

	arg_20_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/BossAttribute/", var_20_6.stage_img))

	local var_20_7 = CoreVerificationChallengeTools.GetIllustrated()

	if var_20_7 and #var_20_7 > 0 then
		local var_20_8 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_20_8 == 0 then
			arg_20_0.lockController_:SetSelectedIndex(1)
		else
			arg_20_0.lockController_:SetSelectedIndex(0)

			arg_20_0.illustratedIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_20_8))
		end
	else
		arg_20_0.lockController_:SetSelectedIndex(1)
	end
end

function var_0_0.Dispose(arg_21_0)
	for iter_21_0 = 1, #arg_21_0.commonItems do
		arg_21_0.commonItems[iter_21_0]:Dispose()

		arg_21_0.commonItems[iter_21_0] = nil
	end

	for iter_21_1 = 1, 3 do
		arg_21_0.challengeHeadItems[iter_21_1]:Dispose()

		arg_21_0.challengeHeadItems[iter_21_1] = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
