local var_0_0 = class("HodurChallengeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/Activity_Hodur_BossCheckpointMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.affixModule_ = HodurChallengeAffixModule.New(arg_3_0.affixPageGo_)
	arg_3_0.heroModule_ = HodurChallengeHeroModule.New(arg_3_0.heroPageGo_)
	arg_3_0.baceController_ = arg_3_0.mainControllerEx_:GetController("bace")
	arg_3_0.scoreController_ = arg_3_0.mainControllerEx_:GetController("Score")
	arg_3_0.tipsPosController_ = arg_3_0.mainControllerEx_:GetController("tipsPos")
	arg_3_0.difficultyController_ = arg_3_0.mainControllerEx_:GetController("difficulty")
	arg_3_0.bossList_ = {}

	for iter_3_0 = 1, 4 do
		local var_3_0 = {}

		ComponentBinder.GetInstance():BindCfgUI(var_3_0, arg_3_0["bossItem_" .. iter_3_0])

		var_3_0.gameObject_ = arg_3_0["affixItem_" .. iter_3_0]
		var_3_0.index = iter_3_0
		var_3_0.selectController_ = var_3_0.mainControllerEx_:GetController("select")
		var_3_0.lockController_ = var_3_0.mainControllerEx_:GetController("lock")
		var_3_0.numController_ = var_3_0.mainControllerEx_:GetController("num")

		var_3_0.selectController_:SetSelectedState("off")
		arg_3_0:AddBtnListener(var_3_0.clickBtn_, nil, function()
			arg_3_0:OnClickBossItem(var_3_0, iter_3_0)
		end)

		arg_3_0.bossList_[iter_3_0] = var_3_0
	end

	arg_3_0.efficiencyText_ = arg_3_0.mainGo_:GetComponent("RollingNumberText")
	arg_3_0.scoreEfficiency = 100
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.startBtn_, nil, function()
		HodurSystemData:CacheAffixList(arg_6_0.affixModule_:GetSelectedAffix())
		HodurTools.GotoChallengeBattle(arg_6_0.chapterID_, ActivityConst.ACTIVITY_HODUR_MAIN)
	end)
	arg_6_0:AddBtnListener(arg_6_0.continueBtn_, nil, function()
		HodurTools.GotoChallengeBattle(arg_6_0.chapterID_, ActivityConst.ACTIVITY_HODUR_MAIN)
	end)
	arg_6_0:AddBtnListener(arg_6_0.giveupBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("HODUR_SETTLE_CHALLENGE_TIP"),
			OkCallback = function()
				HodurTools.GotoChallengeSettle(arg_6_0.chapterID_)
				HodurTools.SettleChallenge()
			end,
			CancelCallback = function()
				return
			end
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/hodurRankView", {
			activityID = ActivityConst.ACTIVITY_HODUR_MAIN
		})
	end)
end

function var_0_0.OnEnter(arg_13_0)
	arg_13_0.chapterID_ = arg_13_0.params_.chapter_id

	arg_13_0:RefreshUI()
	HodurSystemData:ClearAffixCache()
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0.affixModule_:ShowTips(false)
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0.affixModule_:SetData(arg_17_0.chapterID_)
	arg_17_0.heroModule_:SetData(arg_17_0.chapterID_)
	arg_17_0:RefreshPage()
	arg_17_0:RefreshAffixInfo()
	arg_17_0:RefreshChapterState()
	arg_17_0:RefreshBossItem()
end

function var_0_0.RefreshPage(arg_18_0)
	local var_18_0 = HodurTools.GetChallengeHero()

	if var_18_0 and #var_18_0 > 0 then
		arg_18_0.baceController_:SetSelectedState("bace02")
		arg_18_0.scoreController_:SetSelectedState("Points")
		arg_18_0:ShowBossInfo(true, HodurTools.GetChallengeCurIndex())
	else
		arg_18_0.baceController_:SetSelectedState("bace01")
		arg_18_0.scoreController_:SetSelectedState("Efficiency")
		arg_18_0:ShowBossInfo(true, 1)
	end
end

function var_0_0.RefreshAffixInfo(arg_19_0)
	local var_19_0 = {}
	local var_19_1 = HodurTools.GetChallengeAffix()

	if var_19_1 and #var_19_1 > 0 then
		var_19_0 = var_19_1

		arg_19_0.affixModule_:SetSelectedAffix(var_19_0)
	else
		var_19_0 = arg_19_0.affixModule_:GetSelectedAffix()
	end

	local var_19_2 = #var_19_0

	if var_19_2 == nil then
		var_19_2 = 0
	end

	local var_19_3 = arg_19_0.scoreEfficiency
	local var_19_4 = 100

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_5 = PublicBuffCfg[iter_19_1]

		if var_19_5 then
			var_19_4 = var_19_4 + ActivityAffixPoolCfg[var_19_5.buff_class_id].point
		end
	end

	arg_19_0.scoreEfficiency = var_19_4

	local var_19_6 = string.format("%d%%", var_19_4)

	arg_19_0.efficiencyText_:Change(var_19_3, arg_19_0.scoreEfficiency)

	if var_19_2 < 3 then
		arg_19_0.difficultyController_:SetSelectedState("num0")
	elseif var_19_2 >= 3 and var_19_2 < 6 then
		arg_19_0.difficultyController_:SetSelectedState("num3")
	else
		arg_19_0.difficultyController_:SetSelectedState("num6")
	end
end

function var_0_0.RefreshChapterState(arg_20_0)
	local var_20_0 = HodurTools.GetChallengeCurScore()
	local var_20_1 = HodurTools.GetChallengeMaxScore()

	arg_20_0.curScoreText_.text = tostring(var_20_0)
	arg_20_0.maxScoreText_.text = tostring(var_20_1)
end

function var_0_0.RefreshBossItem(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0.bossList_) do
		if HodurTools.GetChallengeStageUnlock(iter_21_1.index) then
			iter_21_1.lockController_:SetSelectedState("unlock")
		else
			iter_21_1.lockController_:SetSelectedState("lock")
		end

		if HodurTools.GetChallengeStageFinish(iter_21_1.index) then
			iter_21_1.numController_:SetSelectedState("on")

			local var_21_0 = HodurTools.GetChallengeStageCurScore(iter_21_1.index)

			iter_21_1.scoreText_.text = tostring(var_21_0)
		else
			iter_21_1.numController_:SetSelectedState("off")
		end
	end
end

function var_0_0.OnClickBossItem(arg_22_0, arg_22_1, arg_22_2)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.bossList_) do
		if iter_22_1.index == arg_22_2 then
			iter_22_1.selectController_:SetSelectedState("on")
			arg_22_0:ShowBossInfo(true, arg_22_2)
		else
			iter_22_1.selectController_:SetSelectedState("off")
		end
	end
end

function var_0_0.ShowBossInfo(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0.isShowBossInfo_ = arg_23_1

	if arg_23_0.selectIndex_ ~= arg_23_2 then
		arg_23_0.bossAnimator_:Play("UI_BOSS_cx", -1, 0)
	end

	arg_23_0.selectIndex_ = arg_23_2

	SetActive(arg_23_0.tipsGo_, arg_23_1)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.bossList_) do
		iter_23_1.selectController_:SetSelectedState("off")
	end

	if arg_23_1 then
		arg_23_0.bossList_[arg_23_2].selectController_:SetSelectedState("on")

		local var_23_0 = ActivityHodurChapterCfg[arg_23_0.chapterID_].stage_list[arg_23_2][1]
		local var_23_1 = BattleHodurStageCfg[var_23_0]

		arg_23_0.bossNameText_.text = var_23_1.name
		arg_23_0.bossDescText_.text = var_23_1.description
		arg_23_0.bossMaxScoreText_.text = HodurTools.GetChallengeStageMaxScore(arg_23_2)
	end

	arg_23_0.tipsPosController_:SetSelectedState(tostring(arg_23_2) or "1")

	for iter_23_2 = 1, 4 do
		local var_23_2 = ActivityHodurChapterCfg[arg_23_0.chapterID_].stage_list[arg_23_2][1]
		local var_23_3 = ActivityHodurCfg[var_23_2]

		arg_23_0["bossImg_" .. iter_23_2].sprite = getSpriteWithoutAtlas("TextureConfig/Activity_Hodur/Boss/" .. var_23_3.boss_img) or nil
	end
end

function var_0_0.OnHodurResetChapter(arg_24_0)
	arg_24_0:RefreshUI()
end

function var_0_0.OnHodurChallengeSelectAffix(arg_25_0)
	arg_25_0:RefreshAffixInfo()
end

function var_0_0.Dispose(arg_26_0)
	arg_26_0.affixModule_:Dispose()
	arg_26_0.heroModule_:Dispose()
	var_0_0.super.Dispose(arg_26_0)
	arg_26_0:RemoveAllListeners()
end

return var_0_0
