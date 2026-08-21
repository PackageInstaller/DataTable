local var_0_0 = class("BossAdvanceTargetView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossCombatUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.hardList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshMultipleItem), arg_3_0.hardUIList_, BossAdvanceTargetMultiple)
	arg_3_0.affixList_ = LuaList.New(handler(arg_3_0, arg_3_0.RefreshAffixItem), arg_3_0.affixUIList_, BossAdvanceTargetCondition)
	arg_3_0.chooseConditionHandler_ = handler(arg_3_0, arg_3_0.ChooseCondition)
	arg_3_0.challengeUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateBossChallenge)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistHomeCallBack(function()
		arg_4_0:SaveTargerData(function()
			arg_4_0:Go("/home")
		end)
	end)
	manager.windowBar:RegistBackCallBack(function()
		arg_4_0:SaveTargerData(function()
			arg_4_0:Back()
		end)
	end)
	BossTools.CheckTimeout()

	arg_4_0.bossIndex_ = arg_4_0.params_.bossIndex

	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()

	local var_4_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_4_1 = BossChallengeAdvanceCfg[var_4_0]

	arg_4_0.hardList_:StartScroll(#var_4_1.difficult_point, 1)

	local var_4_2 = arg_4_0.cfg_

	arg_4_0.affixList_:StartScroll(#var_4_2.time_pool + #var_4_2.affix_pool, 1)
	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_CONDITION, arg_4_0.chooseConditionHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, arg_4_0.chooseConditionHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_4_0.challengeUpdateHandler_)
end

function var_0_0.OnExit(arg_9_0)
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_CONDITION, arg_9_0.chooseConditionHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, arg_9_0.chooseConditionHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_9_0.challengeUpdateHandler_)
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)

	arg_10_0.challengeUpdateHandler_ = nil
	arg_10_0.chooseConditionHandler_ = nil

	if arg_10_0.hardList_ then
		arg_10_0.hardList_:Dispose()

		arg_10_0.hardList_ = nil
	end

	if arg_10_0.affixList_ then
		arg_10_0.affixList_:Dispose()

		arg_10_0.affixList_ = nil
	end
end

function var_0_0.AddListeners(arg_11_0)
	arg_11_0:AddBtnListener(arg_11_0.battleBtn_, nil, function()
		arg_11_0:SaveTargerData(function(arg_13_0)
			if isSuccess(arg_13_0.result) then
				local var_13_0 = BossChallengeAdvancePoolCfg[arg_11_0.poolID_]
				local var_13_1 = ReserveParams.New(nil, BossTools.GetContID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE, arg_11_0.bossIndex_), nil, {
					stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE,
					stageID = var_13_0.stage_id,
					bossIndex = arg_11_0.params_.bossIndex
				})

				arg_11_0:Go("/sectionSelectHero", {
					section = var_13_0.stage_id,
					bossIndex = arg_11_0.bossIndex_,
					sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE_ADVANCE,
					reserveParams = var_13_1
				})
			end
		end)
	end)
end

function var_0_0.RefreshData(arg_14_0)
	local var_14_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_14_0.bossIndex_]

	arg_14_0.bossID_ = var_14_0.templateID
	arg_14_0.poolID_ = var_14_0.id
	arg_14_0.cfg_ = BossChallengeAdvancePoolCfg[arg_14_0.poolID_]
end

function var_0_0.RefreshUI(arg_15_0)
	local var_15_0 = BossChallengeUICfg[arg_15_0.bossID_]

	arg_15_0.bossImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, var_15_0.icon))
	arg_15_0.bossAffixText_.text = getAffixDesc(var_15_0.custom_affix)

	arg_15_0:ChooseCondition()
end

function var_0_0.UpdateBossChallenge(arg_16_0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function var_0_0.RefreshMultipleItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:SetData(arg_17_0.bossIndex_, arg_17_1)
end

function var_0_0.RefreshAffixItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.cfg_
	local var_18_1
	local var_18_2

	if arg_18_1 <= #var_18_0.time_pool then
		var_18_1 = BossConst.TYPE_STAGE
		var_18_2 = var_18_0.time_pool[arg_18_1]
	else
		var_18_1 = BossConst.TYPE_AFFIX
		var_18_2 = var_18_0.affix_pool[arg_18_1 - #var_18_0.time_pool]
	end

	arg_18_2:SetData(arg_18_0.bossIndex_, var_18_1, var_18_2)
end

function var_0_0.ChooseCondition(arg_19_0)
	arg_19_0.pointText_.text = BattleBossChallengeAdvanceData:GetPointValue(arg_19_0.bossIndex_)

	local var_19_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_19_0.bossIndex_]
	local var_19_1 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_19_2 = var_19_0.multipleIndex
	local var_19_3 = BossChallengeAdvanceCfg[var_19_1].monster_value[var_19_2]

	arg_19_0.bossAttackText_.text = string.format("+%s%%", var_19_3[1] / 10 - 100)
	arg_19_0.bossHpText_.text = string.format("+%s%%", var_19_3[3] / 10 - 100)
end

function var_0_0.SaveTargerData(arg_20_0, arg_20_1)
	local var_20_0 = BattleBossChallengeAdvanceData:GetBossList()[arg_20_0.bossIndex_]
	local var_20_1 = var_20_0.multipleIndex
	local var_20_2 = clone(var_20_0.condition)

	BattleBossChallengeAction.ModifySelectAffix(var_20_0.id, var_20_0.multipleIndex, var_20_0.condition[BossConst.TYPE_STAGE], var_20_0.condition[BossConst.TYPE_AFFIX], function(arg_21_0)
		if isSuccess(arg_21_0.result) then
			BattleBossChallengeAdvanceData:SetBossTarget(arg_20_0.bossIndex_, var_20_1, var_20_2)
		else
			ShowTips(arg_21_0.result)
		end

		arg_20_1(arg_21_0)
	end)
end

return var_0_0
