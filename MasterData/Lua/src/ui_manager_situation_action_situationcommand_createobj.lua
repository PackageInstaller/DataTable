local this = class("situationCommand_createObj", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self:doIt()
end

function this:doIt()
  local container = self.solution:createObj(self.param)
  if not self.guid then
    self.guid = container.guid
  else
    container:setGuid(self.guid)
  end
end

function this:undoIt()
  self.solution:removeObjByGuid(self.guid)
end

return this
