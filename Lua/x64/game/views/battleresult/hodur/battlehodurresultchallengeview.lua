local var_0_0 = class("BattleHodurResultChallengeView", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/BattleResultWinUI_Hodur_Challenge"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.hasSnapshot_ = GetBattleResultSnapShot()

	arg_2_0:InitUI()

	arg_2_0.btnController = arg_2_0.btnController_:GetController("btn")
	arg_2_0.adaptComp = arg_2_0:FindCom("AdaptImage", nil, arg_2_0.commonMaskBg_.transform)
	arg_2_0.mainCon = arg_2_0.mainControllerEx_:GetController("state01")

	arg_2_0:AddListener()
end

function var_0_0.RenderView(arg_3_0)
	arg_3_0:RenderTitleView()
	arg_3_0:RefreshMyExpS()
	arg_3_0:RefreshHeroS()
	arg_3_0:RenderCommonUI()
	arg_3_0:RefreshBattleTime()
	arg_3_0:RefreshBottomBtn()
	arg_3_0:RenderChapterInfo()
	arg_3_0:RenderScoreInfo()
end

function var_0_0.RenderChapterInfo(arg_4_0)
	local var_4_0 = arg_4_0.btnControllerEx_:GetController("default0")
	local var_4_1 = HodurTools.GetChallengeCurIndex() - 1
	local var_4_2 = #ActivityHodurChapterCfg[arg_4_0.params_.chapterID].stage_list

	if HodurTools.GetChallengeComplete() then
		var_4_1 = var_4_2

		var_4_0:SetSelectedState("state1")
	else
		var_4_0:SetSelectedState("state0")
	end

	arg_4_0.chapterText_.text = string.format("%d/%d", var_4_1, var_4_2)
	arg_4_0.scoreText_.text = string.format("%d", HodurTools.GetChallengeStageCurScore(var_4_1))

	local var_4_3 = HodurTools.GetChallengeScoreList()

	arg_4_0.timeScoreText_.text = tostring(var_4_3[1] or 0)
	arg_4_0.bloodScoreText_.text = tostring(var_4_3[2] or 0)
	arg_4_0.comboScoreText_.text = tostring(var_4_3[3] or 0)
	arg_4_0.skillScoreText_.text = tostring(var_4_3[4] or 0)
	arg_4_0.allScoreText_.text = tostring(var_4_3[1] + var_4_3[2] + var_4_3[3] + var_4_3[4] or 0)

	local var_4_4 = HodurTools.GetChallengeAffix()
	local var_4_5 = 100

	for iter_4_0, iter_4_1 in ipairs(var_4_4) do
		local var_4_6 = PublicBuffCfg[iter_4_1]

		if var_4_6 then
			var_4_5 = var_4_5 + ActivityAffixPoolCfg[var_4_6.buff_class_id].point
		end
	end

	arg_4_0.scoreEfficiency = var_4_5

	local var_4_7 = string.format("%d%%", var_4_5)

	arg_4_0.effScoreText_.text = var_4_7
end

function var_0_0.RefreshHeroS(arg_5_0)
	local var_5_0, var_5_1 = arg_5_0.stageData:GetHeroTeam()
	local var_5_2 = arg_5_0.stageData:GetSystemHeroTeam()

	if var_5_0[2] == 0 then
		table.remove(var_5_0, 2)
		table.remove(var_5_1, 2)
		table.insert(var_5_0, 0)
		table.insert(var_5_1, 0)
	end

	local var_5_3 = arg_5_0.params_.battleResult.heroDataCollect

	for iter_5_0 = 1, 3 do
		if not var_5_0[iter_5_0] or var_5_0[iter_5_0] == 0 then
			arg_5_0.heroModule[iter_5_0]:SetHeroData(nil)
			arg_5_0.heroModule[iter_5_0]:ShowCaptain(false)
		else
			arg_5_0.heroModule[iter_5_0]:ShowCaptain(iter_5_0 == 1)

			local var_5_4 = arg_5_0.stageData:GetHeroDataByPos(iter_5_0)

			arg_5_0.heroModule[iter_5_0]:SetHeroData({
				id = var_5_4.id,
				using_skin = var_5_4.using_skin,
				star = var_5_4.star or 0
			})

			if var_5_3[iter_5_0] and arg_5_0:NeedAddExp() then
				arg_5_0.heroModule[iter_5_0]:PlayLevelUpTween(var_5_3[iter_5_0].oldLv, var_5_3[iter_5_0].newLv, var_5_3[iter_5_0].oldPersent, var_5_3[iter_5_0].newPersent, 2)
			else
				arg_5_0.heroModule[iter_5_0]:ShowLevel(var_5_4.level, 1)
			end

			local var_5_5 = var_5_4.tempID

			if not var_5_5 or var_5_5 == 0 then
				var_5_5 = var_5_4.id
			end

			local var_5_6, var_5_7 = HodurTools.GetChallengeHeroHP(var_5_5)

			if var_5_6 == 0 then
				arg_5_0.heroModule[iter_5_0].hpNum_.text = string.format("%s%%", 0)
			else
				arg_5_0.heroModule[iter_5_0].hpNum_.text = string.format("%s%%", math.max(1, math.floor(var_5_6 / var_5_7 * 100)))
			end

			arg_5_0.heroModule[iter_5_0].hpImg_.fillAmount = var_5_6 / var_5_7
		end
	end
end

function var_0_0.RenderScoreInfo(arg_6_0)
	arg_6_0.scoreAni_:Play("UI_scoreicon_cx", -1, 0)
	arg_6_0.mainCon:SetSelectedIndex(1)
	manager.ui:UIEventEnabledByUI(false, true)

	arg_6_0.aniTimer_ = Timer.New(function()
		arg_6_0.mainCon:SetSelectedIndex(0)
		manager.ui:UIEventEnabledByUI(true, false)
	end, 1.5, 1)

	arg_6_0.aniTimer_:Start()
end

function var_0_0.OnAddListner(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.exitBtn_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.restartBtn_, nil, function()
		if HodurSystemData:GetCachedStageData() then
			BattleController.GetInstance():LaunchBattle(HodurSystemData:GetCachedStageData())
		else
			BattleInstance.OnceMoreBattle(arg_8_0.stageData)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.confirm2Btn_, nil, function()
		BattleController.GetInstance():LaunchBattle(arg_8_0.stageData:GetNextStage())
	end)
	arg_8_0:AddBtnListener(arg_8_0.confirmBtn_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.allBtn_, nil, function()
		arg_8_0.mainCon:SetSelectedIndex(0)
	end)
	arg_8_0:AddBtnListener(arg_8_0.detailBtn_, nil, function()
		arg_8_0.mainCon:SetSelectedIndex(1)
	end)
end

function var_0_0.OnExit(arg_15_0)
	if arg_15_0.aniTimer_ then
		arg_15_0.aniTimer_:Stop()

		arg_15_0.aniTimer_ = nil
	end
end

return var_0_0
