local this = class("situationCommand_rotatePet", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.petGuid = self.param.petGuid
  self.startRotate = self.param.startRotate
  self.endRotate = self.param.endRotate
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setRotation(self.endRotate)
  end
end

function this:undoIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setRotation(self.startRotate)
  end
end

return this
