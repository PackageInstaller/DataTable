local this = class("situationCommand_rotateHero", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.guid = self.param.guid
  self.startRotate = self.param.startRotate
  self.endRotate = self.param.endRotate
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getObjContainer(self.guid)
  if container then
    container:setRotation(self.endRotate)
  end
end

function this:undoIt()
  local container = L_SituationManager:getObjContainer(self.guid)
  if container then
    container:setRotation(self.startRotate)
  end
end

return this
