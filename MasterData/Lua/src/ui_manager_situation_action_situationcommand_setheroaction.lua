local this = class("situationCommand_setHeroAction", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.heroConfigId = self.param.heroConfigId
  self.preActionId = self.param.preActionId
  self.preActionTime = self.param.preActionTime
  self.curActionId = self.param.curActionId
  self.curActionTime = self.param.curActionTime
  self.stopCommand = self.param.stopCommand
  self:doIt()
end

function this:doIt()
  local container = L_SituationManager:getHeroContainer(self.heroConfigId)
  if container then
    container:setAction(self.curActionId, self.curActionTime, self.stopCommand)
    if self.stopCommand then
      self.stopCommand = nil
    end
  end
end

function this:undoIt()
  local container = L_SituationManager:getHeroContainer(self.heroConfigId)
  if container then
    container:setAction(self.preActionId, self.preActionTime)
  end
end

return this
