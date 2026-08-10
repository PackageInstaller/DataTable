local var_0_0 = import("game.views.stage.bossChallenge.BattleBossInfoBaseView")
local var_0_1 = class("BattleBossChallengeView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossInformationUI"
end

function var_0_1.Init(arg_2_0)
	var_0_1.super.Init(arg_2_0)

	arg_2_0.difficultItemList_ = {}
	arg_2_0.targetItemList_ = {}
	arg_2_0.affixItemList_ = {}
	arg_2_0.hideInfoHandler_ = handler(arg_2_0, arg_2_0.HideInfo)
	arg_2_0.switchDifficultHandler_ = handler(arg_2_0, arg_2_0.SwitchDifficult)
	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.startBattleBtn_.transform, "name")
end

function var_0_1.OnEnterExtend(arg_3_0)
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_DESC")

	arg_3_0.bossIndex_ = arg_3_0.params_.bossIndex or BattleBossChallengeData:GetCacheSelectBossIndex()

	BattleBossChallengeData:SaveCacheSelectBossIndex(arg_3_0.bossIndex_)
	manager.notify:RegistListener(BOSS_CHALLENGE_SWITCH_DIFFICULT, arg_3_0.switchDifficultHandler_)
	manager.redPoint:bindUIandKey(arg_3_0.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)
	manager.notify:RegistListener(CLICK_AFFIX, arg_3_0.hideInfoHandler_)
end

function var_0_1.OnExit(arg_4_0)
	var_0_1.super.OnExit(arg_4_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_SWITCH_DIFFICULT, arg_4_0.switchDifficultHandler_)
	manager.notify:RemoveListener(CLICK_AFFIX, arg_4_0.hideInfoHandler_)
	manager.redPoint:unbindUIandKey(arg_4_0.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)
end

function var_0_1.OnUpdate(arg_5_0)
	var_0_1.super.OnUpdate(arg_5_0)
	arg_5_0:RefreshResetBtn()
	arg_5_0:RefreshStar()
end

function var_0_1.Dispose(arg_6_0)
	var_0_1.super.Dispose(arg_6_0)

	arg_6_0.switchDifficultHandler_ = nil

	for iter_6_0, iter_6_1 in pairs(arg_6_0.affixItemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.affixItemList_ = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.difficultItemList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.difficultItemList_ = nil

	for iter_6_4, iter_6_5 in ipairs(arg_6_0.targetItemList_) do
		iter_6_5:Dispose()
	end

	arg_6_0.targetItemList_ = nil
end

function var_0_1.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.startBattleBtn_, nil, function()
		if arg_7_0.isLock_ then
			ShowTips("NEED_UNLOCK_FRONT_DIFFICULT")

			return
		end

		BattleBossChallengeNormalData:SetSelectDifficult(arg_7_0.bossIndex_, arg_7_0.difficult_)

		local var_8_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.BOSS_CHALLENGE, BossTools.GetContID(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE, arg_7_0.bossIndex_), nil, {
			stageType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE,
			stageID = arg_7_0.curStageID_,
			bossIndex = arg_7_0.bossIndex_
		})

		arg_7_0:Go("/sectionSelectHero", {
			section = arg_7_0.curStageID_,
			bossIndex = arg_7_0.bossIndex_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE,
			reserveParams = var_8_0
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossStarExchange")
	end)
	arg_7_0:AddBtnListener(arg_7_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_NORMAL_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetNormalModeBoss(arg_7_0.bossIndex_, function(arg_12_0)
					if isSuccess(arg_12_0.result) then
						arg_7_0:RefreshData()
						arg_7_0:RefreshUI()
					else
						ShowTips(arg_12_0.result)
					end
				end)
			end
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
		SetActive(arg_7_0.bgBtn_.gameObject, false)

		arg_7_0.heroLockScroll_.normalizedPosition = Vector2(0, 1)
	end)
end

function var_0_1.RefreshData(arg_14_0)
	local var_14_0 = BattleBossChallengeNormalData:GetBossList()

	arg_14_0.templateID_ = StageGroupCfg[var_14_0[arg_14_0.bossIndex_]].boss_id
	arg_14_0.difficult_ = BattleBossChallengeNormalData:GetSelectDifficult(arg_14_0.bossIndex_)
	arg_14_0.curStageID_ = arg_14_0:GetStageID()
	arg_14_0.lockHeroGroup_ = BattleBossChallengeNormalData:GetLockHero()
	arg_14_0.isLock_ = arg_14_0.difficult_ > BattleBossChallengeNormalData:GetFinishIndex(arg_14_0.bossIndex_)
end

function var_0_1.GetBossID(arg_15_0)
	return
end

function var_0_1.RefreshUI(arg_16_0)
	var_0_1.super.RefreshUI(arg_16_0)
	arg_16_0:RefreshStar()
	arg_16_0:RefreshDifficultItem()
	arg_16_0:RefreshTargetItem()
	arg_16_0:RefreshAffix()
	arg_16_0:RefreshResetBtn()
	arg_16_0:RefreshStartBtn()
end

function var_0_1.GetAffix(arg_17_0)
	local var_17_0 = BattleBossStageCfg[arg_17_0.curStageID_].affix_type

	if type(var_17_0) ~= "table" then
		return {}
	end

	return getMosterAffix(var_17_0)
end

function var_0_1.GetStageID(arg_18_0)
	return BattleBossChallengeNormalData:GetStageList(arg_18_0.bossIndex_, arg_18_0.difficult_)
end

function var_0_1.HideInfo(arg_19_0)
	SetActive(arg_19_0.bgBtn_.gameObject, true)
end

function var_0_1.SwitchDifficult(arg_20_0, arg_20_1)
	arg_20_0.difficult_ = arg_20_1
	arg_20_0.curStageID_ = arg_20_0:GetStageID()
	arg_20_0.isLock_ = arg_20_0.difficult_ > BattleBossChallengeNormalData:GetFinishIndex(arg_20_0.bossIndex_)

	arg_20_0:RefreshTargetItem()
	arg_20_0:RefreshAffix()

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.difficultItemList_) do
		iter_20_1:SwitchDifficult(arg_20_1)
	end

	arg_20_0:RefreshStartBtn()
end

function var_0_1.RefreshAffix(arg_21_0)
	local var_21_0 = arg_21_0:GetAffix()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if arg_21_0.affixItemList_[iter_21_0] then
			arg_21_0.affixItemList_[iter_21_0]:SetData(iter_21_1)
		else
			arg_21_0.affixItemList_[iter_21_0] = AffixItemView.New(arg_21_0.affixItem_, arg_21_0.affixPanel_, iter_21_1)
		end
	end

	for iter_21_2 = #arg_21_0.affixItemList_, #var_21_0 + 1, -1 do
		arg_21_0.affixItemList_[iter_21_2]:Show(false)
	end
end

function var_0_1.RefreshStar(arg_22_0)
	local var_22_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_22_1 = var_22_0.reward[#var_22_0.reward][1]
	local var_22_2 = BattleBossChallengeNormalData:GetReceiveStarList()

	for iter_22_0 = 1, #var_22_0.reward do
		if not table.keyof(var_22_2, var_22_0.reward[iter_22_0][1]) then
			var_22_1 = var_22_0.reward[iter_22_0][1]

			break
		end
	end

	arg_22_0.textCurStar_.text = StageTools.CalcBossChallengeStar()
	arg_22_0.textTotalStar_.text = string.format("/%s", var_22_1)
end

function var_0_1.RefreshDifficultItem(arg_23_0)
	local var_23_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_23_1 = BattleBossChallengeNormalData:GetSelectDifficult(arg_23_0.bossIndex_)

	for iter_23_0 = 1, var_23_0.level_amount do
		if arg_23_0.difficultItemList_[iter_23_0] == nil then
			arg_23_0.difficultItemList_[iter_23_0] = BattleBossChallengeDifficultItem.New(arg_23_0.goDifficultItem_, arg_23_0.goDifficultParent_, arg_23_0.goLight_, arg_23_0.goLightParent_, iter_23_0)
		end

		arg_23_0.difficultItemList_[iter_23_0]:SetData(arg_23_0.bossIndex_)
		arg_23_0.difficultItemList_[iter_23_0]:SwitchDifficult(var_23_1)
	end
end

function var_0_1.RefreshTargetItem(arg_24_0)
	local var_24_0 = BattleBossChallengeNormalData:GetStarList(arg_24_0.curStageID_)

	for iter_24_0 = 1, 3 do
		if arg_24_0.targetItemList_[iter_24_0] == nil then
			arg_24_0.targetItemList_[iter_24_0] = BattleBossTargetItem.New(arg_24_0[string.format("goTargetItem%s_", iter_24_0)], iter_24_0)
		end

		arg_24_0.targetItemList_[iter_24_0]:Refresh(var_24_0[iter_24_0] == 1, BattleBossStageCfg[arg_24_0.curStageID_].three_star_need[iter_24_0])
	end
end

function var_0_1.RefreshResetBtn(arg_25_0)
	if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) > 0 then
		SetActive(arg_25_0.resetGo_, false)

		return
	end

	if table.length(BattleBossChallengeNormalData:GetLockHero()[arg_25_0.bossIndex_]) > 0 then
		SetActive(arg_25_0.resetGo_, true)
	else
		SetActive(arg_25_0.resetGo_, false)
	end
end

function var_0_1.RefreshStartBtn(arg_26_0)
	if arg_26_0.isLock_ then
		arg_26_0.controller_:SetSelectedState("false")
	else
		arg_26_0.controller_:SetSelectedState("true")
	end
end

return var_0_1
