local this = class("situationCommand_setPetAction", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.petGuid = self.param.petGuid
  self.preActionId = self.param.preActionId
  self.preActionTime = self.param.preActionTime
  self.curActionId = self.param.curActionId
  self.curActionTime = self.param.curActionTime
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setAction(self.curActionId, self.curActionTime)
  end
end

function this:undoIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setAction(self.preActionId, self.preActionTime)
  end
end

return this
