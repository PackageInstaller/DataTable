local MythicSectionStageInfoView = class("MythicSectionStageInfoView", (import("game.views.sectionSelectHero.SectionStageInfoView")))

function MythicSectionStageInfoView:RefreshTitle()
	self.titleText_.text = self.sectionProxy_.teamID == 1 and GetTips("TEAM_1") or self.sectionProxy_.teamID == 2 and GetTips("TEAM_2") or BattleStageTools.GetStageName(self.stageType_, self.stageID_)
end

return MythicSectionStageInfoView
