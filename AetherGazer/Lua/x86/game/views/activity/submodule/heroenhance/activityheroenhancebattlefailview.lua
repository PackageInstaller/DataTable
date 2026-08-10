NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")

local var_0_0 = class("ActivityHeroEnhanceBattleFailView", NewBattleFailedView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhance_BattleResultLoseUI"
end

function var_0_0.RebuildUI(arg_2_0)
	arg_2_0:ChangeStyle()
	arg_2_0:RefreshRecommendType()
	arg_2_0:RefreshRecommendLevel()

	arg_2_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_2_0:GetBattleTime() or "00"
	})
	arg_2_0.titleTxt_.text = BattleStageTools.GetStageName(arg_2_0.stageType_, arg_2_0.stageID_)

	arg_2_0.posController:SetSelectedState("false")
	SetActive(arg_2_0.tipsTitleObj_, true)
	SetActive(arg_2_0.tips1Obj_, true)
	SetActive(arg_2_0.tips2Obj_, true)
	SetActive(arg_2_0.tips3Obj_, false)

	local var_2_0 = #GameSetting.activity_hero_enhance_fail_tips.value
	local var_2_1 = GameSetting.activity_hero_enhance_fail_tips.value[2]

	for iter_2_0 = 2, var_2_0, 2 do
		if arg_2_0.params_.stageData:GetActivityID() == GameSetting.activity_hero_enhance_fail_tips.value[iter_2_0] then
			var_2_1 = GameSetting.activity_hero_enhance_fail_tips.value[iter_2_0 - 1]

			break
		end
	end

	arg_2_0.TipsText_1.text = GetTips(var_2_1[1])
	arg_2_0.TipsText_2.text = GetTips(var_2_1[2])

	SetActive(arg_2_0.bottomLineObj_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_2_0.infoTrans_)
end

return var_0_0
