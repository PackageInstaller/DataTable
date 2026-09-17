local this = class("situationCommand_scaleStamp", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.startScale = self.param.startScale
  self.endScale = self.param.endScale
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getStampContainer(self.param.guid)
  if container then
    container:setScale(self.endScale)
  end
end

function this:undoIt()
  local container = L_SituationManager:getStampContainer(self.param.guid)
  if container then
    container:setScale(self.startScale)
  end
end

return this
