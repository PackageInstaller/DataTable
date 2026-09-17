local this = class("petTimelineDynamicBindInfo", require("ui.manager.hero.timeline.timelineDynamicBindInfo"))

function this:setPetID(petId)
  self.petId = petId
  self.animId = nil
end

function this:setAnimId(animId)
  self.animId = animId
end

return this
