BattleMatrixResultView = import("game.views.battleResult.matrix.BattleMatrixResultView")

local var_0_0 = class("BattleMatrixResultView", BattleMatrixResultView)

function var_0_0.SetLevelTitle(arg_1_0)
	local var_1_0 = arg_1_0.stageData:GetActivityID()
	local var_1_1 = ActivityTools.GetActivityType(var_1_0)

	if var_1_1 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		local var_1_2 = ActivityMatrixData:GetTierID(var_1_0)
		local var_1_3 = ActivityMatrixTierTemplateCfg[var_1_2]

		arg_1_0.stareText_.text = string.format("%s-%s", var_1_3.tier, var_1_3.level)

		local var_1_4 = arg_1_0.stageData:GetStageId()
		local var_1_5 = BattleActivityMatrixCfg[var_1_4]

		arg_1_0.lvText_.text = GetI18NText(var_1_5.name)
		arg_1_0.difficultText_.text = ""
		arg_1_0.affixData = ActivityMatrixData:GetAffixList(var_1_0)

		arg_1_0.affixList:StartScroll(math.max(#arg_1_0.affixData, 3))
	elseif var_1_1 == ActivityTemplateConst.STRATEGY_MATRIX then
		local var_1_6 = StrategyMatrixData:GetTierID(var_1_0)
		local var_1_7 = StrategyMatrixTierTemplateCfg[var_1_6]

		arg_1_0.stareText_.text = string.format("%s-%s", var_1_7.tier, var_1_7.level)

		local var_1_8 = arg_1_0.stageData:GetStageId()
		local var_1_9 = BattleStrategyMatrixCfg[var_1_8]

		arg_1_0.lvText_.text = GetI18NText(var_1_9.name)
		arg_1_0.difficultText_.text = ""
		arg_1_0.affixData = StrategyMatrixData:GetAffixList(var_1_0)

		arg_1_0.affixList:StartScroll(math.max(#arg_1_0.affixData, 3))
	end

	arg_1_0.timeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_0.titleTransform_)
end

function var_0_0.RefreshHeroS(arg_2_0)
	local var_2_0 = arg_2_0.stageData:GetHeroTeam()
	local var_2_1 = arg_2_0.stageData:GetActivityID()
	local var_2_2 = ActivityTools.GetActivityType(var_2_1)

	if var_2_2 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		for iter_2_0 = 1, 3 do
			if not var_2_0[iter_2_0] or var_2_0[iter_2_0] == 0 then
				SetActive(arg_2_0.heroGo_[iter_2_0], false)
			else
				SetActive(arg_2_0.heroGo_[iter_2_0], true)

				local var_2_3 = SkinCfg[ActivityMatrixData:GetHeroSkin(var_2_1, var_2_0[iter_2_0])]

				arg_2_0.heroImg_[iter_2_0].sprite = getSpriteViaConfig("HeroIcon", var_2_3.picture_id)

				local var_2_4 = ActivityMatrixData:GetHeroData(var_2_1, var_2_0[iter_2_0])
				local var_2_5 = var_2_4:GetHeroHP()
				local var_2_6 = var_2_4:GetHeroMaxHP()

				arg_2_0.hpText_[iter_2_0].text = string.format("<color=#FF9500>%s</color>/%s", var_2_5, var_2_6)
				arg_2_0[string.format("hpSlider%s_", iter_2_0)].value = var_2_5 / var_2_6
			end
		end
	elseif var_2_2 == ActivityTemplateConst.STRATEGY_MATRIX then
		for iter_2_1 = 1, 3 do
			if not var_2_0[iter_2_1] or var_2_0[iter_2_1] == 0 then
				SetActive(arg_2_0.heroGo_[iter_2_1], false)
			else
				SetActive(arg_2_0.heroGo_[iter_2_1], true)

				local var_2_7 = SkinCfg[StrategyMatrixData:GetHeroSkin(var_2_1, var_2_0[iter_2_1])]

				arg_2_0.heroImg_[iter_2_1].sprite = getSpriteViaConfig("HeroIcon", var_2_7.picture_id)

				local var_2_8 = StrategyMatrixData:GetHeroDataNew(var_2_0[iter_2_1])
				local var_2_9 = var_2_8:GetHeroHP()
				local var_2_10 = var_2_8:GetHeroMaxHP()

				arg_2_0.hpText_[iter_2_1].text = string.format("<color=#FF9500>%s</color>/%s", var_2_9, var_2_10)
				arg_2_0[string.format("hpSlider%s_", iter_2_1)].value = var_2_9 / var_2_10
			end
		end
	end
end

return var_0_0
