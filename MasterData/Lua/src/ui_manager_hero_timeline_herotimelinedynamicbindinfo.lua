local this = class("heroTimelineDynamicBindInfo", require("ui.manager.hero.timeline.timelineDynamicBindInfo"))

function this:setHeroId(heroId)
  self.heroId = heroId
end

return this
