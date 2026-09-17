local this = class("situationCommand_removeStamp", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.guid = self.param.guid
  local container = L_SituationManager:getStampContainer(self.guid)
  self.data = container.data
  self:doIt()
end

function this:doIt()
  self.solution:removeStampByGuid(self.guid)
end

function this:undoIt()
  local container = self.solution:createStamp(self.data)
  container:setGuid(self.guid)
end

return this
