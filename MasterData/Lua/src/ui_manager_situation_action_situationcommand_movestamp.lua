local this = class("situationCommand_moveStamp", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.startPos = self.param.startPos
  self.endPos = self.param.endPos
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getStampContainer(self.param.guid)
  if container then
    container:setPosition(self.endPos)
  end
end

function this:undoIt()
  local container = L_SituationManager:getStampContainer(self.param.guid)
  if container then
    container:setPosition(self.startPos)
  end
end

return this
