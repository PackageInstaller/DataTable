local this = class("stack")

function this:ctor()
  self.list = {}
end

function this:push(data)
  table.insert(self.list, data)
end

function this:pop(data)
  return table.remove(self.list)
end

function this:getFirst()
  return self.list[#self.list]
end

function this:getLast()
  return self.list[1]
end

function this:getLength()
  return #self.list
end

function this:clear()
  table.clear(self.list)
end

return this
