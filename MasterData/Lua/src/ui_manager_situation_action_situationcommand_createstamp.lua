local this = class("situationCommand_createStamp", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self:doIt(true)
end

function this:doIt(isFirst)
  local container = self.solution:createStamp(self.param, isFirst)
  if not self.guid then
    self.guid = container.guid
  else
    container:setGuid(self.guid)
  end
end

function this:undoIt()
  self.solution:removeStampByGuid(self.guid)
end

return this
