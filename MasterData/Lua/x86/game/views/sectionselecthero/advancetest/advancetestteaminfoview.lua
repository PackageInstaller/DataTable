local AdvanceTestTeamInfoView = class("AdvanceTestTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function AdvanceTestTeamInfoView:GetHeroList()
	return AdvanceTestData:GetSortedHeroList()
end

return AdvanceTestTeamInfoView
