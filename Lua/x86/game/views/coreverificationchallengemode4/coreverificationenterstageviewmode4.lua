local var_0_0 = class("CoreVerificationEnterStageViewMode4", ReduxView)

function var_0_0.OnCtor(arg_1_0)
	arg_1_0.timers = {}
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Core_verification_new/Mode4/Core_verification_ChooseUI04"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.commonItems = {}

	local var_5_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)
	local var_5_1 = CoreVerificationClMode4Cfg.get_id_list_by_activity_id[var_5_0]

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = arg_5_0["selectionGo_" .. iter_5_0]

		if var_5_2 and not isNil(var_5_2) then
			arg_5_0.commonItems[iter_5_0] = CoreVerificationMode4StageItem.New(var_5_2)
		end
	end

	arg_5_0.lockController = arg_5_0.illustratedController_:GetController("lock")
	arg_5_0.updateInfoHandler = handler(arg_5_0, arg_5_0.UpdateCoreVerification)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_6_0:AddBtnListener(arg_6_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationChallengeRankView", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.illustratedBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_jump")
		JumpTools.OpenPageByJump("/coreVerificationChallengeIllustratedView", {})
	end)
	arg_6_0:AddBtnListener(arg_6_0.btn_flushedBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_CL_RESETTIPS2"),
			OkCallback = function()
				CoreVerificationChallengeMode4Action.ResetAll(arg_6_0.activityID)
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.seasonBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationChallengeSeasonTipView")
	end)
end

function var_0_0.UpdateCoreVerification(arg_14_0)
	arg_14_0.commonStage = CoreVerificationChallengeMode4Data:GetCommonStage()
	arg_14_0.challengeStage = CoreVerificationChallengeMode4Data:GetChallengeStage()

	arg_14_0:RefreshTitle()
	arg_14_0:RefreshBoss()
	arg_14_0:RefreshStages()
	SetActive(arg_14_0.btn_flushedBtn_.gameObject, arg_14_0:IsResetEnabled())
end

function var_0_0.RefreshTimeText(arg_15_0)
	local var_15_0 = ActivityData:GetActivityData(arg_15_0.activityID)

	arg_15_0.refreshTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_15_0.stopTime)
end

function var_0_0.RefreshBoss(arg_16_0)
	local var_16_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)
	local var_16_1 = CoreVerificationChallengeMode4Data:GetChallengeStageCfg(var_16_0)

	arg_16_0.bossIcon_.spriteSync = string.format("TextureConfig/Core_verification_new/BossAttribute/%s", var_16_1.stage_img)
end

function var_0_0.RefreshTitle(arg_17_0)
	local var_17_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)
	local var_17_1 = CoreVerificationChallengeMode4Data:GetChallengeStageCfg(var_17_0).stage_com_affix[1]
	local var_17_2 = ActivityAffixPoolCfg[var_17_1].affix

	arg_17_0.comAffixName_.text = getAffixName(var_17_2)
	arg_17_0.comAffixIcon_.sprite = getAffixSprite(var_17_2)

	if arg_17_0.comAffixIcon_1 and not isNil(arg_17_0.comAffixIcon_1) then
		arg_17_0.comAffixIcon_1.sprite = getAffixSprite(var_17_2)
	end

	arg_17_0:RefreshTimeText()

	arg_17_0.allscoreText_1.text = CoreVerificationChallengeMode4Data:GetMaxPoint()
	arg_17_0.allscoreText_2.text = CoreVerificationChallengeMode4Data:GetCurPoint()

	local var_17_3 = CoreVerificationChallengeTools.GetIllustrated()

	if var_17_3 and #var_17_3 > 0 then
		local var_17_4 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_17_4 == 0 then
			arg_17_0.lockController:SetSelectedIndex(1)
		else
			arg_17_0.lockController:SetSelectedIndex(0)

			arg_17_0.illustratedIcon_.spriteAsync = string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_17_4)
		end
	else
		arg_17_0.lockController:SetSelectedIndex(1)
	end
end

function var_0_0.RefreshStages(arg_18_0)
	local var_18_0 = CoreVerificationChallengeTools.GetModeStageActivityId(ActivityTemplateConst.CORE_VERIFICATION_CHALLENGE_MODE4)
	local var_18_1 = CoreVerificationClMode4Cfg.get_id_list_by_activity_id[var_18_0]

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		arg_18_0.commonItems[iter_18_0]:SetData(iter_18_1, iter_18_0)
	end
end

function var_0_0.IsResetEnabled(arg_19_0)
	return true
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0.activityID = CoreVerificationChallengeTools.GetActivityId()

	arg_20_0:RegistEventListener(CORE_VERIFICATION_CHALLENGE_RESET, arg_20_0.updateInfoHandler)
	manager.redPoint:bindUIandKey(arg_20_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	arg_20_0:UpdateCoreVerification()

	if CoreVerificationChallengeMode4Data:GetSeasonIsTips() then
		arg_20_0:StartScheduleDelayEnterCall()
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.redPoint:unbindUIandKey(arg_21_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	arg_21_0:RemoveAllEventListener()
	arg_21_0:StopAllTimer()
end

function var_0_0.OnTop(arg_22_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function var_0_0.OnBehind(arg_23_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_24_0)
	var_0_0.super.Dispose(arg_24_0)

	for iter_24_0, iter_24_1 in pairs(arg_24_0.commonItems) do
		iter_24_1:Dispose()
	end

	arg_24_0.commonItems = nil
end

function var_0_0.StopAllTimer(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.timers) do
		iter_25_1:Stop()
	end

	arg_25_0.timers = {}
end

local var_0_1 = "delayedEnterCall"

function var_0_0.StartScheduleDelayEnterCall(arg_26_0)
	local var_26_0 = FrameTimer.New(function()
		if not manager.guide:IsPlaying() then
			arg_26_0:StopScheduleDelayEnterCall()
			manager.windowBar:ShowGameHelp()
			CoreVerificationChallengeMode4Action.SetSeasonIsTips()
		end
	end, 1, -1)

	var_26_0:Start()

	arg_26_0.timers[var_0_1] = var_26_0
end

function var_0_0.StopScheduleDelayEnterCall(arg_28_0)
	if arg_28_0.timers[var_0_1] then
		arg_28_0.timers[var_0_1]:Stop()

		arg_28_0.timers[var_0_1] = nil
	end
end

return var_0_0
