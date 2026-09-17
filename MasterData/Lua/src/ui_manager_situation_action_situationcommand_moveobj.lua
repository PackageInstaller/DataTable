local this = class("situationCommand_moveObj", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.startPos = self.param.startPos
  self.endPos = self.param.endPos
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getObjContainer(self.param.guid)
  if container then
    container:setLocalPosition(self.endPos)
  end
end

function this:undoIt()
  local container = L_SituationManager:getObjContainer(self.param.guid)
  if container then
    container:setLocalPosition(self.startPos)
  end
end

return this
