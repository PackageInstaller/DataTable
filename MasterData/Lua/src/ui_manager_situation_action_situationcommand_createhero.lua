local this = class("situationCommand_createHero", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.heroContainer = nil
  self:doIt()
end

function this:doIt()
  self.heroContainer = self.solution:createHero(self.param)
end

function this:undoIt()
  self.solution:removeHeroByConfigId(self.param.heroConfigId)
end

return this
