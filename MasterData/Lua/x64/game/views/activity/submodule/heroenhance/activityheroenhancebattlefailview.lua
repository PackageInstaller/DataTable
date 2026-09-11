NewBattleFailedView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedView")

local ActivityHeroEnhanceBattleFailView = class("ActivityHeroEnhanceBattleFailView", NewBattleFailedView)

function ActivityHeroEnhanceBattleFailView:UIName()
	return "Widget/Version/Alone_HeroEnhanceUI/Alone_HeroEnhance_BattleResultLoseUI"
end

function ActivityHeroEnhanceBattleFailView:RebuildUI()
	self:ChangeStyle()
	self:RefreshRecommendType()
	self:RefreshRecommendLevel()

	local var_2_0 = {
		GetTips("BATTLE_TOTAL_TIME"),
		": "
	}

	var_2_0[3] = self:GetBattleTime() or "00"
	self.battleTimeText_.text = table.concat(var_2_0)
	self.titleTxt_.text = BattleStageTools.GetStageName(self.stageType_, self.stageID_)

	self.posController:SetSelectedState("false")
	SetActive(self.tipsTitleObj_, true)
	SetActive(self.tips1Obj_, true)
	SetActive(self.tips2Obj_, true)
	SetActive(self.tips3Obj_, false)

	local var_2_1 = GameSetting.activity_hero_enhance_fail_tips.value[2]

	for iter_2_0 = 2, #GameSetting.activity_hero_enhance_fail_tips.value, 2 do
		if self.params_.stageData:GetActivityID() == GameSetting.activity_hero_enhance_fail_tips.value[iter_2_0] then
			var_2_1 = GameSetting.activity_hero_enhance_fail_tips.value[iter_2_0 - 1]

			break
		end
	end

	self.TipsText_1.text = GetTips(var_2_1[1])
	self.TipsText_2.text = GetTips(var_2_1[2])

	SetActive(self.bottomLineObj_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoTrans_)
end

return ActivityHeroEnhanceBattleFailView
