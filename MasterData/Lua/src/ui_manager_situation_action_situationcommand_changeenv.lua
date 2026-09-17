local this = class("situationCommand_changeEnv", require("ui.manager.situation.action.situationCommand"))

function this:enter()
  self.param = self.param
  self.preEnvId = self.param.preEnvId
  self.curEnvId = self.param.curEnvId
  self:doIt()
end

function this:doIt()
  self.solution:changeEnv(self.curEnvId)
end

function this:undoIt()
  self.solution:changeEnv(self.preEnvId)
end

return this
