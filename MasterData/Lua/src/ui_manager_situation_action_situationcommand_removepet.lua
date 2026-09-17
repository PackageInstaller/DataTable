local this = class("situationCommand_removePet", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.petGuid = self.param.petGuid
  local container = L_SituationManager:getPetContainer(self.petGuid)
  self.data = container.data
  self:doIt()
end

function this:doIt()
  self.solution:removePet(self.petGuid)
end

function this:undoIt()
  self.solution:createPet(self.data)
end

return this
