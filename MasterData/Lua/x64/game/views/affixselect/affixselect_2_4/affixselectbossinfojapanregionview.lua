local AffixSelectBossInfoJapanRegionView = class("AffixSelectBossInfoJapanRegionView", (import("game.views.AffixSelect.AffixSelectBossInfoView")))

function AffixSelectBossInfoJapanRegionView:UIName()
	return "Widget/Version/Alone_AffixSelect/Alone_AffixSelect_BossInfoUI"
end

function AffixSelectBossInfoJapanRegionView:UpdateView()
	self.nameText_.text = GetMonsterName(self.bossIDList_)
	self.raceText_.text = GetTips("RACE_TYPE_" .. MonsterCfg[self.bossIDList_[1]].race)

	local var_2_0 = ""

	for iter_2_0, iter_2_1 in pairs(self.bossIDList_) do
		var_2_0 = var_2_0 .. iter_2_1
	end

	self.icon_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. var_2_0)
	self.riskText_.text = NumberTools.IntToRomam(MonsterCfg[self.bossIDList_[1]].type + 1)

	self:UpdateData()
	self:RefreshSkill()
end

return AffixSelectBossInfoJapanRegionView
