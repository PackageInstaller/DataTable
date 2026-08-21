local var_0_0 = class("CoreVerificationChallengeStageViewMode2", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode2/Core_Verification_ChallengeStageUI_Mode2"
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
	arg_4_0.buffAffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexBuffItem), arg_4_0.bufflList_, CoreVerificationChallengeStageAffixItemMode2)
	arg_4_0.debuffAffixList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexDebuffItem), arg_4_0.debuffList_, CoreVerificationChallengeStageAffixItemMode2)
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
		local var_6_0, var_6_1 = CoreVerificationChallengeMode2Data:GetPostNum()

		if var_6_1 < var_6_0 then
			ShowTips("CORE_VERIFICATION_CL_COST_OVERLIMIT")

			return
		end

		local var_6_2 = CoreVerificationChallengeMode2Data:GetSelectAffixs()

		CoreVerificationChallengeMode2Action.SetBattleAffixs()

		local var_6_3 = CoreVerificationChallengeTools.GetActivityId()

		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", {
			section = arg_5_0.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE2,
			activityID = var_6_3
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

function var_0_0.IndexBuffItem(arg_11_0, arg_11_1, arg_11_2)
	arg_11_2:RefreshUI(arg_11_0.cfg.stage_affix_buff[arg_11_1], 0, 1, arg_11_0.stage_id)
	arg_11_2:RegisterClickListener(function(arg_12_0, arg_12_1)
		arg_11_0:RefreshCallBack()

		if arg_12_1 then
			arg_11_0.tipsStateController_:SetSelectedIndex(0)
			arg_11_0:ShowTipsView(arg_12_0)
		else
			SetActive(arg_11_0.tipsGo_, false)
		end
	end)
end

function var_0_0.IndexDebuffItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.cfg.stage_affix_debuff[arg_13_1], 1, 1, arg_13_0.stage_id)
	arg_13_2:RegisterClickListener(function(arg_14_0, arg_14_1)
		arg_13_0:RefreshCallBack()

		if arg_14_1 then
			arg_13_0.tipsStateController_:SetSelectedIndex(1)
			arg_13_0:ShowTipsView(arg_14_0)
		else
			SetActive(arg_13_0.tipsGo_, false)
		end
	end)
end

function var_0_0.ShowTipsView(arg_15_0, arg_15_1)
	SetActive(arg_15_0.tipsGo_, true)

	local var_15_0 = ActivityAffixPoolCfg[arg_15_1].affix

	var_15_0[2] = var_15_0[2] == 50 and 1 or var_15_0[2]
	arg_15_0.tipsNameText_.text = getAffixName(var_15_0)
	arg_15_0.tipsDescText_.text = getAffixDesc(var_15_0)
	arg_15_0.tipsLimitText_.text = ActivityAffixPoolCfg[arg_15_1].point
	arg_15_0.tipsLimitText_2.text = ActivityAffixPoolCfg[arg_15_1].point
end

function var_0_0.OnEnter(arg_16_0)
	manager.notify:RegistListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_16_0.updateInfoHandler)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.bufflList_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_0.debuffList_.transform)

	local var_16_0 = handler(arg_16_0, function()
		arg_16_0:UpdateCoreVerification()
	end)

	TimeTools.StartAfterSeconds(0.033, var_16_0, {})
	manager.redPoint:bindUIandKey(arg_16_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
end

function var_0_0.UpdateCoreVerification(arg_18_0)
	arg_18_0.selectAffixList = {}
	arg_18_0.cfg = CoreVerificationChallengeMode2Data:GetChallengeStageCfg()
	arg_18_0.stage_id = arg_18_0.cfg.stage_id

	local var_18_0 = CoreVerificationClMode2Cfg[arg_18_0.stage_id]

	SetActive(arg_18_0.tipsGo_, false)
	arg_18_0:RefreshTitle()
	arg_18_0:RefreshEnvAffix()
	arg_18_0:RefreshCallBack()
	arg_18_0:RefreshAffixList()
end

function var_0_0.RefreshAffixList(arg_19_0)
	arg_19_0.buffAffixList_:StartScroll(#arg_19_0.cfg.stage_affix_buff)
	arg_19_0.debuffAffixList_:StartScroll(#arg_19_0.cfg.stage_affix_debuff)
end

function var_0_0.RefreshCallBack(arg_20_0)
	arg_20_0.efficiencyNum_.text = CoreVerificationChallengeMode2Data:GetEfficiencyNum()

	local var_20_0, var_20_1 = CoreVerificationChallengeMode2Data:GetPostNum()

	if var_20_1 < var_20_0 then
		arg_20_0.limitNumText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST"), "<color=#FF000B>" .. var_20_0 .. "</color>" .. "/" .. "<color=#CDD2D9>" .. var_20_1 .. "</color>")
	else
		arg_20_0.limitNumText_.text = string.format(GetTips("CORE_VERIFICATION_CL_COST"), var_20_0 .. "/" .. var_20_1)
	end
end

function var_0_0.RefreshEnvAffix(arg_21_0)
	local var_21_0 = CoreVerificationClMode2Cfg[arg_21_0.stage_id]
	local var_21_1 = {
		type = 3,
		buff_id = var_21_0.stage_affix[1]
	}

	arg_21_0.envAffixItem:RefreshUI(var_21_1)

	local var_21_2 = ActivityAffixPoolCfg[var_21_0.stage_affix[1]].affix

	arg_21_0.stageAffixName_.text = getAffixName(var_21_2)
	arg_21_0.stageAffixDesc_.text = getAffixDesc(var_21_2)
	arg_21_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/BossAttribute_new/", arg_21_0.cfg.stage_img))

	local var_21_3 = var_21_0.recommend_team

	for iter_21_0 = 1, 3 do
		local var_21_4 = var_21_3[iter_21_0] and var_21_3[iter_21_0] or 0

		arg_21_0.recommondHeroItems[iter_21_0]:RefreshUI(var_21_4)
	end
end

function var_0_0.OnExit(arg_22_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_22_0.updateInfoHandler)
	manager.redPoint:unbindUIandKey(arg_22_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	var_0_0.super.OnExit(arg_22_0)
end

function var_0_0.RefreshTitle(arg_23_0)
	local var_23_0 = arg_23_0.cfg.stage_com_affix[1]
	local var_23_1 = ActivityAffixPoolCfg[var_23_0].affix

	arg_23_0.titleText_.text = arg_23_0.cfg.stage_name
	arg_23_0.comAffixName_.text = getAffixName(var_23_1)
	arg_23_0.comAffixDesc_.text = getAffixDesc(var_23_1)

	local var_23_2 = CoreVerificationChallengeMode2Data:GetChallengeStage()

	arg_23_0.efficiencyNum_.text = CoreVerificationChallengeMode2Data:GetEfficiencyNum()

	local var_23_3 = CoreVerificationChallengeMode2Data:GetSelectAffixs()

	if var_23_2.max_challenge_value and var_23_2.max_challenge_value > 0 then
		arg_23_0.scoreController_:SetSelectedIndex(0)

		arg_23_0.scoreText_.text = var_23_2.max_challenge_value
	else
		arg_23_0.scoreController_:SetSelectedIndex(1)
	end

	local var_23_4 = var_23_2.challenge_lock

	for iter_23_0 = 1, 3 do
		local var_23_5 = var_23_4[iter_23_0] and var_23_4[iter_23_0] or 0

		arg_23_0.challengeHeadItems[iter_23_0]:RefreshUI(var_23_5)
	end

	local var_23_6 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_23_0.refreshTime_.text = manager.time:GetLostTimeStrWith2Unit(var_23_6.stopTime)
end

function var_0_0.Dispose(arg_24_0)
	for iter_24_0 = 1, 3 do
		arg_24_0.challengeHeadItems[iter_24_0]:Dispose()

		arg_24_0.challengeHeadItems[iter_24_0] = nil
	end

	for iter_24_1 = 1, 3 do
		arg_24_0.recommondHeroItems[iter_24_1]:Dispose()

		arg_24_0.recommondHeroItems[iter_24_1] = nil
	end

	if arg_24_0.buffAffixList_ then
		arg_24_0.buffAffixList_:Dispose()

		arg_24_0.buffAffixList_ = nil
	end

	if arg_24_0.debuffAffixList_ then
		arg_24_0.debuffAffixList_:Dispose()

		arg_24_0.debuffAffixList_ = nil
	end

	arg_24_0.envAffixItem:Dispose()
	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
