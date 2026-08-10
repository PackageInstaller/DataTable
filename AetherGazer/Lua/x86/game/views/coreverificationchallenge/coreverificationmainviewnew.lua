local var_0_0 = class("CoreVerificationMainViewNew", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_new"
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

	arg_4_0.mainBossItem_ = CoreVerificationBossItemNew.New(arg_4_0.boss1Go_, 1)
	arg_4_0.subBossItem_ = CoreVerificationBossItemNew.New(arg_4_0.boss2Go_, 2)
	arg_4_0.stateController_ = arg_4_0.coreverificationmainControllerexcollection_:GetController("statescore")
	arg_4_0.uiList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.uiListGo_, CoreVerificationModeItem)
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.CORE_VERIFICATION
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		JumpTools.OpenPageByJump("coreVerificationPre", {})
	end)
	arg_5_0:AddBtnListener(arg_5_0.challengeBtn_, nil, function()
		local var_9_0 = CoreVerificationChallengeTools.GetActivityId()
		local var_9_1 = CoreVerificationData:GetMaxUnlockByBossType(1)
		local var_9_2 = CoreVerificationData:GetMaxUnlockByBossType(2)

		if ActivityData:GetActivityIsOpen(var_9_0) then
			if var_9_1 >= 4 or var_9_2 >= 4 then
				CoreVerificationChallengeTools.GetEnterViewUIName(var_9_0)
			else
				ShowTips("CORE_VERIFICATION_CL_UNLOCK_TIPS")
			end
		else
			ShowTips("SOLO_NOT_OPEN")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.illustratedBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("challenge_attribute_achie_jump")
		JumpTools.OpenPageByJump("/coreVerificationChallengeIllustratedView", {})
	end)
end

function var_0_0.UpdateCoreVerification(arg_11_0)
	CoreVerificationAction.UpdateChallengeRedPoints()
	arg_11_0:RefreshTitle()
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = CoreVerificationChallengeTools.GetAllActivityIds()[arg_12_1]

	arg_12_2:SetData(arg_12_1, var_12_0)
	arg_12_2:SetSelect(var_12_0 == CoreVerificationChallengeTools.GetActivityId())
end

function var_0_0.OnCoreVerificationChallengeSwitchMode(arg_13_0, arg_13_1)
	if CoreVerificationChallengeTools.GetActivityId() == arg_13_1 then
		return
	end

	CoreVerificationChallengeTools.SetSelectedActivityId(arg_13_1)
	arg_13_0:ClearRedPoint(arg_13_1)
	arg_13_0:RefreshChallenge()
end

function var_0_0.ClearRedPoint(arg_14_0, arg_14_1)
	local var_14_0 = CoreVerificationChallengeTools.GetActionCls(arg_14_1)
	local var_14_1 = CoreVerificationChallengeTools.GetDataCls(arg_14_1)
	local var_14_2 = CoreVerificationChallengeTools.GetActionCls(arg_14_1)

	if var_14_2 then
		var_14_2.SetSeasonIsTips()
		var_14_2.UpdateRewardRedPoints()
	end
end

function var_0_0.OnEnter(arg_15_0)
	local var_15_0 = getData("CoreVerification", "click_time") or 0
	local var_15_1 = _G.gameTimer:GetNextDayFreshTime()

	if var_15_1 > 0 and var_15_0 < var_15_1 then
		CoreVerificationChallengeTools.selectedActivityId_ = nil

		CoreVerificationChallengeTools.GetActivityId()
	end

	saveData("CoreVerification", "click_time", var_15_1)
	CoreVerificationAction.UpdateChallengeRedPoints()

	if ActivityData:GetActivityIsOpen(CoreVerificationChallengeTools.GetActivityId()) then
		local var_15_2 = CoreVerificationChallengeTools.GetModeIndex()

		if var_15_2 == 1 then
			CoreVerificationChallengeAction.UpdateRewardRedPoints()
		elseif var_15_2 == 2 then
			CoreVerificationChallengeMode2Action.UpdateRewardRedPoints()
		end
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	arg_15_0:BindRedPoint()
	arg_15_0:RefreshTitle()

	local var_15_3 = CoreVerificationChallengeTools.GetActivityId()

	CoreVerificationChallengeTools.SetSelectedActivityId(var_15_3)

	if ActivityData:GetActivityIsOpen(var_15_3) then
		arg_15_0:RefreshChallenge()
	end
end

function var_0_0.RefreshChallenge(arg_16_0)
	local var_16_0 = CoreVerificationChallengeTools.GetChallengeStage()
	local var_16_1 = CoreVerificationChallengeTools.GetChallengeStageCfg()

	arg_16_0.challengeBossImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", var_16_1.stage_img))

	if var_16_0.max_challenge_value and var_16_0.max_challenge_value > 0 then
		local var_16_2 = CoreVerificationChallengeTools:GetIllustrated()

		if var_16_2 and #var_16_2 > 0 then
			arg_16_0.stateController_:SetSelectedIndex(0)

			local var_16_3 = CoreVerificationChallengeTools.GetMaxIllustrated()

			arg_16_0.systemImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_16_3))
		else
			arg_16_0.stateController_:SetSelectedIndex(1)
		end
	else
		arg_16_0.stateController_:SetSelectedIndex(2)
	end

	local var_16_4 = CoreVerificationChallengeTools.GetIllustrated()

	if var_16_4 and #var_16_4 > 0 then
		local var_16_5 = CoreVerificationChallengeTools.GetMaxIllustrated()

		if var_16_5 == 0 then
			arg_16_0.stateController_:SetSelectedIndex(1)
		else
			arg_16_0.stateController_:SetSelectedIndex(0)

			arg_16_0.systemImg_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_16_5))
		end
	else
		arg_16_0.stateController_:SetSelectedIndex(1)
	end

	local var_16_6 = CoreVerificationChallengeTools.GetModeIndex()
	local var_16_7 = CoreVerificationChallengeTools.GetRankScore()

	arg_16_0.scoreText_.text = var_16_7 == 0 and "--" or var_16_7

	local var_16_8 = CoreVerificationChallengeTools.GetActivityId()
	local var_16_9 = ActivityData:GetActivityData(var_16_8)

	arg_16_0.challengeTimeText_.text = manager.time:GetLostTimeStrWith2Unit(var_16_9.stopTime)

	local var_16_10 = ActivityCfg[var_16_8]

	arg_16_0.stageNameText_.text = GetI18NText(var_16_10.remark)
	arg_16_0.bigBossRecommendIcon_.sprite = HeroTools.GetSkillAttributeIcon(var_16_1.recommend[1])

	local var_16_11 = CoreVerificationChallengeTools.GetAllActivityIds()

	if #var_16_11 > 1 then
		SetActive(arg_16_0.uiListGo_.gameObject, true)
		arg_16_0.uiList_:StartScrollWithoutAnimator(#var_16_11)
	else
		SetActive(arg_16_0.uiListGo_.gameObject, false)
	end
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:UnBindRedPoint()
	manager.windowBar:HideBar()
end

function var_0_0.BindRedPoint(arg_18_0)
	arg_18_0:UnBindRedPoint()
	manager.redPoint:bindUIandKey(arg_18_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)

	if #CoreVerificationChallengeTools.GetAllActivityIds() < 2 then
		local var_18_0 = CoreVerificationChallengeTools.GetActivityId()

		manager.redPoint:bindUIandKey(arg_18_0.newTagTrs_, string.format("%s_%s", RedPointConst.CORE_VERIFICATION_CHALLENGE_NEXT, var_18_0))
	end
end

function var_0_0.UnBindRedPoint(arg_19_0)
	manager.redPoint:unbindUIandKey(arg_19_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_REWARD)
	manager.redPoint:unbindUIandKey(arg_19_0.newTagTrs_)

	if arg_19_0.uiList_ then
		for iter_19_0, iter_19_1 in pairs(arg_19_0.uiList_:GetItemList()) do
			iter_19_1:UnBindRedPoint()
		end
	end
end

function var_0_0.RefreshTitle(arg_20_0)
	arg_20_0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(CoreVerificationData:GetRefreshTime())

	arg_20_0.mainBossItem_:RefreshUI()
	arg_20_0.subBossItem_:RefreshUI()
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	if arg_21_0.subBossItem_ then
		arg_21_0.subBossItem_:Dispose()

		arg_21_0.subBossItem_ = nil
	end

	if arg_21_0.mainBossItem_ then
		arg_21_0.mainBossItem_:Dispose()

		arg_21_0.mainBossItem_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
