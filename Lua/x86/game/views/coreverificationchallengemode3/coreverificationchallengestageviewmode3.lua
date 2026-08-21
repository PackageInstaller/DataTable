local var_0_0 = class("CoreVerificationChallengeStageViewMode3", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode3/Core_Verification_OrdinaryStageUI_Mode3"
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

	for iter_4_0 = 1, 3 do
		arg_4_0.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	arg_4_0.rightHeadItems = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.rightHeadItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["heroRightGo_" .. iter_4_1], iter_4_1)
	end

	arg_4_0.recommondHeroItems = {}
	arg_4_0.recommondAttributeItems = {}
	arg_4_0.updateInfoHandler = handler(arg_4_0, arg_4_0.UpdateCoreVerification)
	arg_4_0.timeController_ = arg_4_0.controller_:GetController("time")
	arg_4_0.pointsController_ = arg_4_0.controller_:GetController("points")
	arg_4_0.stateController_ = arg_4_0.controller_:GetController("state01")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_6_0 = CoreVerificationChallengeTools.GetActivityId()

		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = arg_5_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE3,
			activityID = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.flushedBtn_, nil, function()
		if CoreVerificationChallengeMode3Data:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
				OkCallback = function()
					CoreVerificationChallengeMode3Action.ResetCurStage(arg_5_0.stage_id)
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
end

function var_0_0.OnEnter(arg_10_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_10_0.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	local var_10_0 = handler(arg_10_0, function()
		arg_10_0:UpdateCoreVerification()
	end)

	TimeTools.StartAfterSeconds(0.033, var_10_0, {})
	manager.redPoint:bindUIandKey(arg_10_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function var_0_0.UpdateCoreVerification(arg_12_0)
	arg_12_0.cfg = CoreVerificationChallengeMode3Data:GetChallengeStageCfg()
	arg_12_0.stage_id = arg_12_0.cfg.stage_id

	arg_12_0:RefreshTitle()
	arg_12_0:RefreshEnvAffix()
	arg_12_0:RefreshCallBack()
end

function var_0_0.RefreshCallBack(arg_13_0)
	return
end

function var_0_0.RefreshEnvAffix(arg_14_0)
	local var_14_0 = CoreVerificationClMode3Cfg[arg_14_0.stage_id]
	local var_14_1 = {
		type = 3,
		buff_id = var_14_0.stage_affix[1]
	}
	local var_14_2 = ActivityAffixPoolCfg[var_14_0.stage_affix[1]].affix

	arg_14_0.stageDesc_.text = getAffixDesc(var_14_2)

	local var_14_3 = ActivityAffixPoolCfg[var_14_0.type_affix[1]].affix

	arg_14_0.stageAffixName_.text = getAffixName(var_14_3)
	arg_14_0.stageAffixDesc_.text = getAffixDesc(var_14_3)

	local var_14_4 = var_14_0.type_affix

	if var_14_4 and #var_14_4 > 0 then
		arg_14_0.stateController_:SetSelectedIndex(0)
	else
		arg_14_0.stateController_:SetSelectedIndex(1)
	end

	arg_14_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", arg_14_0.cfg.stage_img))
	arg_14_0.stageName_.text = arg_14_0.cfg.stage_name

	local var_14_5 = var_14_0.recommend

	for iter_14_0, iter_14_1 in ipairs(var_14_5) do
		if not arg_14_0.recommondAttributeItems[iter_14_0] then
			local var_14_6 = Object.Instantiate(arg_14_0.attributeGo_, arg_14_0.tagContent_)

			arg_14_0.recommondAttributeItems[iter_14_0] = CoreVerificationChallengeRecommendAttributeItem.New(var_14_6, iter_14_0)
		end

		SetActive(arg_14_0.recommondAttributeItems[iter_14_0].gameObject_, true)
		arg_14_0.recommondAttributeItems[iter_14_0]:RefreshUI(iter_14_1)
	end

	for iter_14_2 = #var_14_5 + 1, #arg_14_0.recommondAttributeItems do
		SetActive(arg_14_0.recommondAttributeItems[iter_14_2].gameObject_, false)
	end

	local var_14_7 = var_14_0.recommend_team

	for iter_14_3, iter_14_4 in ipairs(var_14_7) do
		if not arg_14_0.recommondHeroItems[iter_14_3] then
			local var_14_8 = Object.Instantiate(arg_14_0.recommendGo_, arg_14_0.roleTrs_)

			arg_14_0.recommondHeroItems[iter_14_3] = CoreVerificationChallengeHeroHeadItem.New(var_14_8, iter_14_3)
		end

		SetActive(arg_14_0.recommondHeroItems[iter_14_3].gameObject_, true)

		local var_14_9 = iter_14_4 and iter_14_4 or 0

		arg_14_0.recommondHeroItems[iter_14_3]:RefreshUI(var_14_9)
	end

	for iter_14_5 = #var_14_7 + 1, #arg_14_0.recommondHeroItems do
		SetActive(arg_14_0.recommondHeroItems[iter_14_5].gameObject_, false)
	end
end

function var_0_0.OnExit(arg_15_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_15_0.updateInfoHandler)
	manager.redPoint:unbindUIandKey(arg_15_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	var_0_0.super.OnExit(arg_15_0)
end

function var_0_0.RefreshTitle(arg_16_0)
	local var_16_0 = arg_16_0.cfg.stage_com_affix[1]
	local var_16_1 = ActivityAffixPoolCfg[var_16_0].affix

	arg_16_0.titleText_.text = arg_16_0.cfg.stage_name
	arg_16_0.comAffixName_.text = getAffixName(var_16_1)
	arg_16_0.comAffixDesc_.text = getAffixDesc(var_16_1)

	local var_16_2 = CoreVerificationChallengeMode3Data:GetChallengeStage()

	if var_16_2.recently_challenge_value and var_16_2.recently_challenge_value > 0 then
		arg_16_0.timeController_:SetSelectedIndex(1)
		arg_16_0.pointsController_:SetSelectedIndex(1)

		arg_16_0.scoreText_.text = var_16_2.recently_challenge_value or 0

		local var_16_3 = var_16_2.min_seconds

		arg_16_0.pushTimeText_.text = manager.time:DescCdTime2(var_16_3)
	else
		arg_16_0.timeController_:SetSelectedIndex(0)
		arg_16_0.pointsController_:SetSelectedIndex(0)
	end

	local var_16_4 = var_16_2 and var_16_2.challenge_lock or {}

	for iter_16_0 = 1, 3 do
		local var_16_5 = var_16_4[iter_16_0] and var_16_4[iter_16_0] or 0

		arg_16_0.challengeHeadItems[iter_16_0]:RefreshUI(var_16_5)
	end

	for iter_16_1 = 1, 3 do
		local var_16_6 = var_16_4[iter_16_1] and var_16_4[iter_16_1] or 0

		arg_16_0.rightHeadItems[iter_16_1]:RefreshUI(var_16_6)
	end

	local var_16_7 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_16_0.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(var_16_7.stopTime)
end

function var_0_0.Dispose(arg_17_0)
	for iter_17_0 = 1, 3 do
		arg_17_0.challengeHeadItems[iter_17_0]:Dispose()

		arg_17_0.challengeHeadItems[iter_17_0] = nil
	end

	for iter_17_1 = 1, 3 do
		arg_17_0.rightHeadItems[iter_17_1]:Dispose()

		arg_17_0.rightHeadItems[iter_17_1] = nil
	end

	for iter_17_2 = 1, #arg_17_0.recommondHeroItems do
		arg_17_0.recommondHeroItems[iter_17_2]:Dispose()

		arg_17_0.recommondHeroItems[iter_17_2] = nil
	end

	for iter_17_3 = 1, #arg_17_0.recommondAttributeItems do
		arg_17_0.recommondAttributeItems[iter_17_3]:Dispose()

		arg_17_0.recommondAttributeItems[iter_17_3] = nil
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
