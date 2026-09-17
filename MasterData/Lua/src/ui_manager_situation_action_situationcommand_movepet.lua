local this = class("situationCommand_movePet", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.petGuid = self.param.petGuid
  self.startPos = self.param.startPos
  self.endPos = self.param.endPos
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setLocalPosition(self.endPos)
  end
end

function this:undoIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setLocalPosition(self.startPos)
  end
end

return this
