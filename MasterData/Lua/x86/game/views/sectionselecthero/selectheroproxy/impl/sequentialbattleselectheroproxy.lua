local SequentialBattleSelectHeroProxy = class("SequentialBattleSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function SequentialBattleSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/heroTeamInfoSequentialBattle"
end

function SequentialBattleSelectHeroProxy:GetAdditionalViewClass()
	return SequentialBattleSectionAdditionalView
end

function SequentialBattleSelectHeroProxy:ChangeHeroTeam(...)
	SequentialBattleSelectHeroProxy.super.ChangeHeroTeam(self, ...)
	self:RefreshEnableBuff()
end

function SequentialBattleSelectHeroProxy:ApplyReserveProposal(...)
	SequentialBattleSelectHeroProxy.super.ApplyReserveProposal(self, ...)
	self:RefreshEnableBuff()
end

function SequentialBattleSelectHeroProxy:RefreshEnableBuff()
	SequentialBattleTools.SaveEnabledBuff(self.activityID, (table.keyof(SequentialBattleChapterCfg[self.activityID].stage_id, self.stageID)))
end

return SequentialBattleSelectHeroProxy
