local DestroyBoxSelectHeroProxy = class("DestroyBoxSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function DestroyBoxSelectHeroProxy:InitCustomParams()
	self.canUseOwnHero = false
end

return DestroyBoxSelectHeroProxy
