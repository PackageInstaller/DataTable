local var_0_0 = class("BattleHodurResultMainlineView", NewBattleSettlementView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Hodur/BattleResultWinUI_Hodur_Mainline"
end

function var_0_0.RenderView(arg_2_0)
	arg_2_0:RenderTitleView()
	arg_2_0:RefreshMyExpS()
	arg_2_0:RefreshHeroS()
	arg_2_0:RenderCommonUI()
	arg_2_0:RefreshBattleTime()
	arg_2_0:RefreshBottomBtn()
	arg_2_0:RenderChapterInfo()
end

function var_0_0.RenderChapterInfo(arg_3_0)
	local var_3_0, var_3_1 = HodurTools.GetChapterProgress(arg_3_0.params_.chapterID)

	arg_3_0.chapterText_.text = string.format("%d/%d", var_3_0, var_3_1)
end

function var_0_0.RefreshHeroS(arg_4_0)
	local var_4_0, var_4_1 = arg_4_0.stageData:GetHeroTeam()
	local var_4_2 = arg_4_0.stageData:GetSystemHeroTeam()

	if var_4_0[2] == 0 then
		table.remove(var_4_0, 2)
		table.remove(var_4_1, 2)
		table.insert(var_4_0, 0)
		table.insert(var_4_1, 0)
	end

	local var_4_3 = arg_4_0.params_.battleResult.heroDataCollect

	for iter_4_0 = 1, 3 do
		if not var_4_0[iter_4_0] or var_4_0[iter_4_0] == 0 then
			arg_4_0.heroModule[iter_4_0]:SetHeroData(nil)
			arg_4_0.heroModule[iter_4_0]:ShowCaptain(false)
		else
			arg_4_0.heroModule[iter_4_0]:ShowCaptain(iter_4_0 == 1)

			local var_4_4 = arg_4_0.stageData:GetHeroDataByPos(iter_4_0)

			arg_4_0.heroModule[iter_4_0]:SetHeroData({
				id = var_4_4.id,
				using_skin = var_4_4.using_skin,
				star = var_4_4.star or 0
			})

			if var_4_3[iter_4_0] and arg_4_0:NeedAddExp() then
				arg_4_0.heroModule[iter_4_0]:PlayLevelUpTween(var_4_3[iter_4_0].oldLv, var_4_3[iter_4_0].newLv, var_4_3[iter_4_0].oldPersent, var_4_3[iter_4_0].newPersent, 2)
			else
				arg_4_0.heroModule[iter_4_0]:ShowLevel(var_4_4.level, 1)
			end

			local var_4_5 = var_4_4.tempID

			if var_4_5 == 0 then
				var_4_5 = var_4_4.id
			end

			local var_4_6, var_4_7 = HodurTools.GetChapterHeroHP(arg_4_0.params_.chapterID, var_4_5)

			if var_4_6 == 0 then
				arg_4_0.heroModule[iter_4_0].hpNum_.text = string.format("%s%%", 0)
			else
				arg_4_0.heroModule[iter_4_0].hpNum_.text = string.format("%s%%", math.max(1, math.floor(var_4_6 / var_4_7 * 100)))
			end

			arg_4_0.heroModule[iter_4_0].hpImg_.fillAmount = var_4_6 / var_4_7
		end
	end
end

function var_0_0.OnAddListner(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.confirmBtn_, nil, function()
		arg_5_0:CloseFunc()
	end)
	arg_5_0:AddBtnListener(arg_5_0.restartBtn_, nil, function()
		BattleInstance.OnceMoreBattle(arg_5_0.stageData)
	end)
end

return var_0_0
