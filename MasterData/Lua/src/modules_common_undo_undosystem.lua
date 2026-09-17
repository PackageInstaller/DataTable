local this = class("undoSystem")

function this:ctor(param)
  self.maxCount = param.maxCount or 10
  self.name = param.name or "undoSystem"
  self.undoStack = {}
  self.redoStack = {}
end

function this:bindNotify(action)
  self.notify = action
end

function this:execute(command)
  command:enter()
  table.insert(self.undoStack, command)
  self:checkLimit(self.undoStack)
  self.redoStack = {}
  if self.notify then
    self.notify()
  end
end

function this:undo()
  local command = table.remove(self.undoStack)
  if command then
    command:undoIt()
    table.insert(self.redoStack, command)
    self:checkLimit(self.redoStack)
    if self.notify then
      self.notify()
    end
  end
end

function this:redo()
  local command = table.remove(self.redoStack)
  if command then
    command:doIt()
    table.insert(self.undoStack, command)
    self:checkLimit(self.undoStack)
    if self.notify then
      self.notify()
    end
  end
end

function this:checkLimit(stack)
  while #stack > self.maxCount do
    table.remove(stack, 1)
  end
end

function this:hasUndo()
  return #self.undoStack > 0
end

function this:hasRedo()
  return #self.redoStack > 0
end

function this:clear()
  self.undoStack = {}
  self.redoStack = {}
  if self.notify then
    self.notify()
  end
end

return this
