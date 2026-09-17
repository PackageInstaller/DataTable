local this = class("undoCommandBase")

function this:ctor(param)
  self.param = param
end

function this:enter()
end

function this:doIt()
end

function this:undoIt()
end

return this
