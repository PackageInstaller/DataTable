local this = class("situationCommand_moveHero", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.heroConfigId = self.param.heroConfigId
  self.startPos = self.param.startPos
  self.endPos = self.param.endPos
  self:doIt()
end

function this:doIt()
  local heroContainer = L_SituationManager:getHeroContainer(self.heroConfigId)
  if heroContainer then
    heroContainer:setLocalPosition(self.endPos)
  end
end

function this:undoIt()
  local heroContainer = L_SituationManager:getHeroContainer(self.heroConfigId)
  if heroContainer then
    heroContainer:setLocalPosition(self.startPos)
  end
end

return this
