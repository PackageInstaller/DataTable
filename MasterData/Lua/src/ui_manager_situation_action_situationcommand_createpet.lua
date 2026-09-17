local this = class("situationCommand_createHero", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.petContainer = nil
  self:doIt()
end

function this:doIt()
  self.petContainer = self.solution:createPet(self.param)
end

function this:undoIt()
  self.solution:removePet(self.param.petGuid)
end

return this
