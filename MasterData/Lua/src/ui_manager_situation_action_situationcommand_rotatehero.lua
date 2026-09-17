local this = class("situationCommand_rotateHero", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.heroConfigId = self.param.heroConfigId
  self.startRotate = self.param.startRotate
  self.endRotate = self.param.endRotate
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getHeroContainer(self.heroConfigId)
  if container then
    container:setRotation(self.endRotate)
  end
end

function this:undoIt()
  local container = L_SituationManager:getHeroContainer(self.heroConfigId)
  if container then
    container:setRotation(self.startRotate)
  end
end

return this
