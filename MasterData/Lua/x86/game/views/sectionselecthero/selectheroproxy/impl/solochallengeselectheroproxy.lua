local SoloChallengeSelectHeroProxy = class("SoloChallengeSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function SoloChallengeSelectHeroProxy:InitCustomParams()
	self.needMimirPanel = false
	self.canChangeTeam = false
end

return SoloChallengeSelectHeroProxy
