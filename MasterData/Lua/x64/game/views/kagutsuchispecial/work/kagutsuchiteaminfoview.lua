local KagutsuchiTeamInfoView = class("KagutsuchiTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function KagutsuchiTeamInfoView:GetHeroList()
	return (HeroTools.Sort({
		[1158] = HeroData:GetHeroData(1158)
	}))
end

return KagutsuchiTeamInfoView
