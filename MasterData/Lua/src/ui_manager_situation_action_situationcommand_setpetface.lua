local this = class("situationCommand_setPetFace", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.petGuid = self.param.petGuid
  self.preFaceId = self.param.preFaceId
  self.curFaceId = self.param.curFaceId
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setFace(self.curFaceId)
  end
end

function this:undoIt()
  local container = L_SituationManager:getPetContainer(self.petGuid)
  if container then
    container:setFace(self.preFaceId)
  end
end

return this
