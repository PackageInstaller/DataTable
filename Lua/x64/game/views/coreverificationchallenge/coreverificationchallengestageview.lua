local var_0_0 = class("CoreVerificationChallengeStageView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_Verification_ChallengeStageUI_new"
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

	arg_4_0.envAffixItem = CoreVerificationChallengeAffixItemItem.New(arg_4_0.envAffixGo_)
	arg_4_0.tipsStateController_ = arg_4_0.tipsGo_:GetComponent("ControllerExCollection"):GetController("tipsState")
	arg_4_0.affixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexHeroItem), arg_4_0.uiListGo_, CoreVerificationChallengeAffixSelectItem)
	arg_4_0.buffAffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBuffItem), arg_4_0.bufflList_, CoreVerificationChallengeStageAffixItem)
	arg_4_0.debuffAffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDebuffItem), arg_4_0.debuffList_, CoreVerificationChallengeStageAffixItem)
	arg_4_0.challengeHeadItems = {}

	for iter_4_0 = 1, 3 do
		arg_4_0.challengeHeadItems[iter_4_0] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["heroItemGo_" .. iter_4_0], iter_4_0)
	end

	arg_4_0.recommondHeroItems = {}

	for iter_4_1 = 1, 3 do
		arg_4_0.recommondHeroItems[iter_4_1] = CoreVerificationChallengeHeroHeadItem.New(arg_4_0["recommandGo_" .. iter_4_1], iter_4_1)
	end

	arg_4_0.updateInfoHandler = handler(arg_4_0, arg_4_0.UpdateCoreVerification)
	arg_4_0.scoreController_ = arg_4_0.controller_:GetController("scorstate")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		local var_6_0 = CoreVerificationChallengeData:GetSelectAffixs()

		CoreVerificationChallengeAction.SetBattleAffixs()

		local var_6_1 = CoreVerificationChallengeTools.GetActivityId()

		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = arg_5_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE,
			activityID = var_6_1
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

function var_0_0.IndexHeroItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:SetData(arg_11_1, arg_11_0.select_affixs[arg_11_1])
end

function var_0_0.IndexBuffItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:RefreshUI(arg_12_0.cfg.stage_buff[arg_12_1][1], 0, 1, arg_12_0.stage_id)
	arg_12_2:RefreshLock()
	arg_12_2:RegisterClickListener(function(arg_13_0, arg_13_1)
		arg_12_0:RefreshCallBack()

		if arg_13_1 then
			arg_12_0.tipsStateController_:SetSelectedIndex(0)
			arg_12_0:ShowTipsView(arg_13_0)
		else
			SetActive(arg_12_0.tipsGo_, false)
		end
	end)
end

function var_0_0.IndexDebuffItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(arg_14_0.cfg.stage_debuff[arg_14_1][1], 1, 1, arg_14_0.stage_id)
	arg_14_2:RefreshLock()
	arg_14_2:RegisterClickListener(function(arg_15_0, arg_15_1)
		arg_14_0:RefreshCallBack()

		if arg_15_1 then
			arg_14_0.tipsStateController_:SetSelectedIndex(1)
			arg_14_0:ShowTipsView(arg_15_0)
		else
			SetActive(arg_14_0.tipsGo_, false)
		end
	end)
end

function var_0_0.ShowTipsView(arg_16_0, arg_16_1)
	SetActive(arg_16_0.tipsGo_, true)

	local var_16_0 = ActivityAffixPoolCfg[arg_16_1].affix

	var_16_0[2] = var_16_0[2] == 50 and 1 or var_16_0[2]
	arg_16_0.tipsNameText_.text = getAffixName(var_16_0)
	arg_16_0.tipsDescText_.text = getAffixDesc(var_16_0)

	local var_16_1 = CoreVerificationChallengeData:GetBuffLevelById(arg_16_1)

	var_16_1 = var_16_1 == 0 and 1 or var_16_1
	arg_16_0.tipsLvText_.text = string.format(GetTips("PINBALL_HERO_LEVEL"), var_16_1)
	arg_16_0.tipsSubText_.text = ""
end

function var_0_0.OnEnter(arg_17_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_17_0.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.bufflList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_0.debuffList_.transform)

	local var_17_0 = handler(arg_17_0, function()
		arg_17_0:UpdateCoreVerification()
	end)

	TimeTools.StartAfterSeconds(0.033, var_17_0, {})
	manager.redPoint:bindUIandKey(arg_17_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function var_0_0.UpdateCoreVerification(arg_19_0)
	arg_19_0.selectAffixList = {}
	arg_19_0.cfg = CoreVerificationChallengeData:GetChallengeStageCfg()
	arg_19_0.stage_id = arg_19_0.cfg.stage_id

	local var_19_0 = CoreVerificationClMode1Cfg[arg_19_0.stage_id]

	SetActive(arg_19_0.tipsGo_, false)

	if #CoreVerificationChallengeData:GetBuffList() <= 0 then
		CoreVerificationChallengeData:ResetSelectAffix()
	end

	arg_19_0:RefreshTitle()
	arg_19_0:RefreshEnvAffix()
	arg_19_0:RefreshCallBack()
	arg_19_0:RefreshAffixList()
end

function var_0_0.RefreshAffixList(arg_20_0)
	arg_20_0.buffAffixList_:StartScroll(#arg_20_0.cfg.stage_buff)
	arg_20_0.debuffAffixList_:StartScroll(#arg_20_0.cfg.stage_debuff)
end

function var_0_0.RefreshCallBack(arg_21_0)
	local var_21_0 = CoreVerificationChallengeData:GetSelectAffixs()

	arg_21_0.select_affixs = CoreVerificationChallengeData:GetSelectAffixs()

	arg_21_0.affixList_:StartScroll(#arg_21_0.select_affixs)

	arg_21_0.efficiencyNum_.text = CoreVerificationChallengeData:GetEfficiencyNum()
	arg_21_0.affixNum_.text = string.format("%s/6", var_21_0 and #var_21_0 or 0)
end

function var_0_0.RefreshEnvAffix(arg_22_0)
	local var_22_0 = CoreVerificationClMode1Cfg[arg_22_0.stage_id]
	local var_22_1 = {
		type = 3,
		buff_id = var_22_0.stage_affix[1]
	}

	arg_22_0.envAffixItem:RefreshUI(var_22_1)

	local var_22_2 = ActivityAffixPoolCfg[var_22_0.stage_affix[1]].affix

	arg_22_0.stageAffixName_.text = getAffixName(var_22_2)
	arg_22_0.stageAffixDesc_.text = getAffixDesc(var_22_2)
	arg_22_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", arg_22_0.cfg.stage_img))

	local var_22_3 = var_22_0.recommend_team

	for iter_22_0 = 1, 3 do
		local var_22_4 = var_22_3[iter_22_0] and var_22_3[iter_22_0] or 0

		arg_22_0.recommondHeroItems[iter_22_0]:RefreshUI(var_22_4)
	end
end

function var_0_0.OnExit(arg_23_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_23_0.updateInfoHandler)
	manager.redPoint:unbindUIandKey(arg_23_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	var_0_0.super.OnExit(arg_23_0)
end

function var_0_0.RefreshTitle(arg_24_0)
	local var_24_0 = arg_24_0.cfg.stage_com_affix[1]
	local var_24_1 = ActivityAffixPoolCfg[var_24_0].affix

	arg_24_0.titleText_.text = arg_24_0.cfg.stage_name
	arg_24_0.comAffixName_.text = getAffixName(var_24_1)
	arg_24_0.comAffixDesc_.text = getAffixDesc(var_24_1)

	local var_24_2 = CoreVerificationChallengeData:GetChallengeStage()

	arg_24_0.efficiencyNum_.text = CoreVerificationChallengeData:GetEfficiencyNum()

	local var_24_3 = CoreVerificationChallengeData:GetSelectAffixs()

	arg_24_0.affixNum_.text = string.format("%s/6", var_24_3 and #var_24_3 or 0)

	if var_24_2.max_challenge_value and var_24_2.max_challenge_value > 0 then
		arg_24_0.scoreController_:SetSelectedIndex(0)

		arg_24_0.scoreText_.text = var_24_2.max_challenge_value
	else
		arg_24_0.scoreController_:SetSelectedIndex(1)
	end

	local var_24_4 = var_24_2.challenge_lock

	for iter_24_0 = 1, 3 do
		local var_24_5 = 0

		if var_24_4 then
			var_24_5 = var_24_4[iter_24_0] and var_24_4[iter_24_0] or 0
		end

		arg_24_0.challengeHeadItems[iter_24_0]:RefreshUI(var_24_5)
	end

	local var_24_6 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_24_0.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(var_24_6.stopTime)
end

function var_0_0.Dispose(arg_25_0)
	for iter_25_0 = 1, 3 do
		arg_25_0.challengeHeadItems[iter_25_0]:Dispose()

		arg_25_0.challengeHeadItems[iter_25_0] = nil
	end

	for iter_25_1 = 1, 3 do
		arg_25_0.recommondHeroItems[iter_25_1]:Dispose()

		arg_25_0.recommondHeroItems[iter_25_1] = nil
	end

	if arg_25_0.affixList_ then
		arg_25_0.affixList_:Dispose()

		arg_25_0.affixList_ = nil
	end

	if arg_25_0.buffAffixList_ then
		arg_25_0.buffAffixList_:Dispose()

		arg_25_0.buffAffixList_ = nil
	end

	if arg_25_0.debuffAffixList_ then
		arg_25_0.debuffAffixList_:Dispose()

		arg_25_0.debuffAffixList_ = nil
	end

	arg_25_0.envAffixItem:Dispose()
	var_0_0.super.Dispose(arg_25_0)
end

return var_0_0
