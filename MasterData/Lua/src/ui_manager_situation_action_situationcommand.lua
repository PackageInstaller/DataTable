local this = class("situationCommand", require("modules.common.undo.undoCommandBase"))

function this:ctor(param, solution)
  this.super.ctor(self, param)
  self.solution = solution
end

function this:enter()
end

function this:doIt()
end

function this:undoIt()
end

return this
