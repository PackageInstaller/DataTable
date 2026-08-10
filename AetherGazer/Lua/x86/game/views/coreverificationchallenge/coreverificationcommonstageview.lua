local var_0_0 = class("CoreVerificationCommonStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_Verification_OrdinaryStageUI_new"
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
	arg_4_0.buffAffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBuffItem), arg_4_0.buffList_, CoreVerificationCommonStageAffixItem)
	arg_4_0.debuffAffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDebuffItem), arg_4_0.debuffList_, CoreVerificationCommonStageAffixItem)

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
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE,
			activityID = var_6_0
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.flushedBtn_, nil, function()
		if CoreVerificationChallengeData:IsJumpAllStage() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
				OkCallback = function()
					CoreVerificationChallengeAction.ResetCurStage(arg_5_0.stage_id)
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
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.buffList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_0.debuffList_.transform)

	local var_11_0 = handler(arg_11_0, function()
		arg_11_0:UpdateCoreVerification()
	end)

	TimeTools.StartAfterSeconds(0.033, var_11_0, {})
	manager.redPoint:bindUIandKey(arg_11_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
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
	arg_13_0:RefreshAffixList()
end

function var_0_0.RefreshAffixList(arg_14_0)
	arg_14_0.buffAffixList_:StartScroll(#arg_14_0.cfg.stage_buff)
	arg_14_0.debuffAffixList_:StartScroll(#arg_14_0.cfg.stage_debuff)
end

function var_0_0.IndexBuffItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:RefreshUI(arg_15_0.cfg.stage_buff[arg_15_1][1], 0, 0, arg_15_1)
	arg_15_2:RefreshLock()
	arg_15_2:RegisterClickListener(function(arg_16_0, arg_16_1, arg_16_2)
		if arg_16_1 then
			arg_15_0.tipsStateController_:SetSelectedIndex(0)
			arg_15_0:ShowTipsView(arg_16_0, arg_16_1, arg_16_2)
		else
			SetActive(arg_15_0.tipsGo_, false)
		end
	end)
end

function var_0_0.IndexDebuffItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_0.cfg.stage_debuff[arg_17_1][1], 1, 0, arg_17_1)
	arg_17_2:RefreshLock()
	arg_17_2:RegisterClickListener(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_1 then
			arg_17_0.tipsStateController_:SetSelectedIndex(1)
			arg_17_0:ShowTipsView(arg_18_0, arg_18_1, arg_18_2)
		else
			SetActive(arg_17_0.tipsGo_, false)
		end
	end)
end

function var_0_0.ShowTipsView(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	SetActive(arg_19_0.tipsGo_, true)

	local var_19_0 = ActivityAffixPoolCfg[arg_19_1].affix

	var_19_0[2] = var_19_0[2] == 50 and 1 or var_19_0[2]
	arg_19_0.tipsNameText_.text = getAffixName(var_19_0)
	arg_19_0.tipsDescText_.text = getAffixDesc(var_19_0)

	local var_19_1 = CoreVerificationChallengeData:GetBuffLevelById(arg_19_1)

	var_19_1 = var_19_1 == 0 and 1 or var_19_1
	arg_19_0.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), var_19_1)

	local var_19_2 = arg_19_0.cfg.stage_buff_upgrade

	arg_19_0.tipsSubText_.text = var_19_2[arg_19_3]
end

function var_0_0.RefreshEnvAffix(arg_20_0)
	local var_20_0 = CoreVerificationClMode1Cfg[arg_20_0.stage_id]
	local var_20_1 = {
		type = 3,
		buff_id = var_20_0.stage_affix[1]
	}

	arg_20_0.envAffixItem:RefreshUI(var_20_1)

	local var_20_2 = ActivityAffixPoolCfg[var_20_0.stage_affix[1]].affix

	arg_20_0.stageAffixName_.text = getAffixName(var_20_2)
	arg_20_0.stageAffixDesc_.text = getAffixDesc(var_20_2)
	arg_20_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", arg_20_0.cfg.stage_img))
	arg_20_0.stageName_.text = arg_20_0.cfg.stage_name

	local var_20_3 = var_20_0.recommend_team

	for iter_20_0 = 1, 3 do
		local var_20_4 = var_20_3[iter_20_0] and var_20_3[iter_20_0] or 0

		arg_20_0.recommondHeroItems[iter_20_0]:RefreshUI(var_20_4)
	end
end

function var_0_0.OnExit(arg_21_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_21_0.updateInfoHandler)
	arg_21_0.buffAffixList_:StopRender()
	arg_21_0.debuffAffixList_:StopRender()
	manager.redPoint:unbindUIandKey(arg_21_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	var_0_0.super.OnExit(arg_21_0)
end

function var_0_0.RefreshTitle(arg_22_0)
	local var_22_0 = arg_22_0.cfg.stage_com_affix[1]
	local var_22_1 = ActivityAffixPoolCfg[var_22_0].affix

	arg_22_0.comAffixName_.text = getAffixName(var_22_1)
	arg_22_0.comAffixDesc_.text = getAffixDesc(var_22_1)
	arg_22_0.titleText_.text = arg_22_0.cfg.stage_name
	arg_22_0.topDescText_.text = GetTips("CORE_VERIFICATION_CL_BUFF_TIPS")

	local var_22_2 = CoreVerificationChallengeData:GetCommonStageByIndex(arg_22_0.index)

	if var_22_2 and #var_22_2.common_lock_id > 0 then
		arg_22_0.stateController_:SetSelectedIndex(1)
	else
		arg_22_0.stateController_:SetSelectedIndex(0)
	end

	for iter_22_0 = 1, 3 do
		local var_22_3 = 0

		if arg_22_0.heroList then
			var_22_3 = arg_22_0.heroList[iter_22_0] and arg_22_0.heroList[iter_22_0] or 0
		end

		arg_22_0.challengeHeadItems[iter_22_0]:RefreshUI(var_22_3)
	end

	local var_22_4 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_22_0.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(var_22_4.stopTime)
end

function var_0_0.Dispose(arg_23_0)
	for iter_23_0 = 1, 3 do
		arg_23_0.challengeHeadItems[iter_23_0]:Dispose()

		arg_23_0.challengeHeadItems[iter_23_0] = nil
	end

	for iter_23_1 = 1, 3 do
		arg_23_0.recommondHeroItems[iter_23_1]:Dispose()

		arg_23_0.recommondHeroItems[iter_23_1] = nil
	end

	if arg_23_0.buffAffixList_ then
		arg_23_0.buffAffixList_:Dispose()

		arg_23_0.buffAffixList_ = nil
	end

	if arg_23_0.debuffAffixList_ then
		arg_23_0.debuffAffixList_:Dispose()

		arg_23_0.debuffAffixList_ = nil
	end

	arg_23_0.envAffixItem:Dispose()
	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
