local this = class("situationCommand_removeHero", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.heroConfigId = self.param.heroConfigId
  local container = L_SituationManager:getHeroContainer(self.heroConfigId)
  self.data = container.data
  self:doIt()
end

function this:doIt()
  self.solution:removeHeroByConfigId(self.data.heroConfigId)
end

function this:undoIt()
  self.solution:createHero(self.data)
end

return this
