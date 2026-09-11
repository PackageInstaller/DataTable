local AffixSelectDetailJapanRegionView = class("AffixSelectDetailJapanRegionView", (import("game.views.AffixSelect.AffixSelectDetailView")))

function AffixSelectDetailJapanRegionView:UIName()
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_StageDetailsUI"
end

function AffixSelectDetailJapanRegionView:AddUIListener()
	self:AddBtnListener(self.checkBtn_, nil, function()
		JumpTools.OpenPageByJump("affixSelectBossInfoJapanRegion", {
			bossIDList = self.cfg_.boss_id,
			index = self.params_.index
		})
	end)
	self:AddBtnListener(self.challengeBtn_, nil, function()
		gameContext:Go("/sectionSelectHero", {
			section = self.cfg_.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.AFFIX_SELECT,
			activityID = self.params_.activityId
		})
	end)
end

return AffixSelectDetailJapanRegionView
