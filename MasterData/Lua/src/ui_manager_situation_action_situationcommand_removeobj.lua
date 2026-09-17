local this = class("situationCommand_removeObj", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.guid = self.param.guid
  local container = L_SituationManager:getObjContainer(self.guid)
  self.data = container.data
  self:doIt()
end

function this:doIt()
  self.solution:removeObjByGuid(self.guid)
end

function this:undoIt()
  local container = self.solution:createObj(self.data)
  container:setGuid(self.guid)
end

return this
