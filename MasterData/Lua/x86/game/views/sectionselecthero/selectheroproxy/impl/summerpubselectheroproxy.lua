local SummerPubSelectHeroProxy = class("SummerPubSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function SummerPubSelectHeroProxy:InitCustomParams(arg_1_1)
	self.needReserveProposalPanel = false
	self.canChangeReserveProposal = false
end

return SummerPubSelectHeroProxy
