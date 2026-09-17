local this = class("queue")

function this:ctor()
  self.list = {}
end

function this:enQueue(data)
  table.insert(self.list, data)
end

function this:deQueue()
  return table.remove(self.list, 1)
end

function this:getFirst()
  return self.list[1]
end

function this:getLast()
  return self.list[#self.list]
end

function this:getLength()
  return #self.list
end

function this:clear()
  table.clear(self.list)
end

function this:clean()
  self.list = {}
end

return this
