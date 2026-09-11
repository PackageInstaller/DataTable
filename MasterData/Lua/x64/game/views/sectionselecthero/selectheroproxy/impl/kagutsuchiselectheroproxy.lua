local KagutsuchiSelectHeroProxy = class("KagutsuchiSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function KagutsuchiSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/kagutsuchiTeamInfo"
end

return KagutsuchiSelectHeroProxy
