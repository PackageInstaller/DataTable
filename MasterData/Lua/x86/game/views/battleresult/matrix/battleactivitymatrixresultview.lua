BattleMatrixResultView = import("game.views.battleResult.matrix.BattleMatrixResultView")

local BattleMatrixResultView = class("BattleMatrixResultView", BattleMatrixResultView)

function BattleMatrixResultView:SetLevelTitle()
	local var_1_0 = self.stageData:GetActivityID()
	local var_1_1 = ActivityTools.GetActivityType(var_1_0)

	if var_1_1 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		local var_1_2 = ActivityMatrixTierTemplateCfg[ActivityMatrixData:GetTierID(var_1_0)]

		self.stareText_.text = string.format("%s-%s", var_1_2.tier, var_1_2.level)
		self.lvText_.text = GetI18NText(BattleActivityMatrixCfg[self.stageData:GetStageId()].name)
		self.difficultText_.text = ""
		self.affixData = ActivityMatrixData:GetAffixList(var_1_0)

		self.affixList:StartScroll(math.max(#self.affixData, 3))
	elseif var_1_1 == ActivityTemplateConst.STRATEGY_MATRIX then
		local var_1_3 = StrategyMatrixTierTemplateCfg[StrategyMatrixData:GetTierID(var_1_0)]

		self.stareText_.text = string.format("%s-%s", var_1_3.tier, var_1_3.level)
		self.lvText_.text = GetI18NText(BattleStrategyMatrixCfg[self.stageData:GetStageId()].name)
		self.difficultText_.text = ""
		self.affixData = StrategyMatrixData:GetAffixList(var_1_0)

		self.affixList:StartScroll(math.max(#self.affixData, 3))
	end

	self.timeText_.text = manager.time:DescCTime(BattleFieldData:GetBattleResultData().useSecond, "%M:%S")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.titleTransform_)
end

function BattleMatrixResultView:RefreshHeroS()
	local var_2_0 = self.stageData:GetHeroTeam()
	local var_2_1 = self.stageData:GetActivityID()
	local var_2_2 = ActivityTools.GetActivityType(var_2_1)

	if var_2_2 == ActivityTemplateConst.SUB_SINGLE_MATRIX then
		for iter_2_0 = 1, 3 do
			if not var_2_0[iter_2_0] or var_2_0[iter_2_0] == 0 then
				SetActive(self.heroGo_[iter_2_0], false)
			else
				SetActive(self.heroGo_[iter_2_0], true)

				self.heroImg_[iter_2_0].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[ActivityMatrixData:GetHeroSkin(var_2_1, var_2_0[iter_2_0])].picture_id)

				local var_2_3 = ActivityMatrixData:GetHeroData(var_2_1, var_2_0[iter_2_0])
				local var_2_4 = var_2_3:GetHeroHP()
				local var_2_5 = var_2_3:GetHeroMaxHP()

				self.hpText_[iter_2_0].text = string.format("<color=#FF9500>%s</color>/%s", var_2_4, var_2_5)
				self[string.format("hpSlider%s_", iter_2_0)].value = var_2_4 / var_2_5
			end
		end
	elseif var_2_2 == ActivityTemplateConst.STRATEGY_MATRIX then
		for iter_2_1 = 1, 3 do
			if not var_2_0[iter_2_1] or var_2_0[iter_2_1] == 0 then
				SetActive(self.heroGo_[iter_2_1], false)
			else
				SetActive(self.heroGo_[iter_2_1], true)

				self.heroImg_[iter_2_1].sprite = getSpriteViaConfig("HeroIcon", SkinCfg[StrategyMatrixData:GetHeroSkin(var_2_1, var_2_0[iter_2_1])].picture_id)

				local var_2_6 = StrategyMatrixData:GetHeroDataNew(var_2_0[iter_2_1])
				local var_2_7 = var_2_6:GetHeroHP()
				local var_2_8 = var_2_6:GetHeroMaxHP()

				self.hpText_[iter_2_1].text = string.format("<color=#FF9500>%s</color>/%s", var_2_7, var_2_8)
				self[string.format("hpSlider%s_", iter_2_1)].value = var_2_7 / var_2_8
			end
		end
	end
end

return BattleMatrixResultView
