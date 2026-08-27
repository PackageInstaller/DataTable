Queue = {}
Queue.__index = Queue

function Queue.New()
  local o = {}
  o.data = {}
  o.first = 0
  o.last = -1
  setmetatable(o, Queue)
  return o
end

function Queue:Count()
  return self.last - self.first + 1
end

function Queue:Empty()
  return self.last - self.first == -1
end

function Queue:PeekFront()
  if self:Empty() then
    return nil
  end
  return self.data[self.first]
end

function Queue:PeekBack()
  if self:Empty() then
    return nil
  end
  return self.data[self.last]
end

function Queue:PushFront(value)
  local first = self.first - 1
  self.first = first
  self.data[first] = value
end

function Queue:PushBack(value)
  local last = self.last + 1
  self.last = last
  self.data[last] = value
end

function Queue:PopFront()
  local first = self.first
  if first > self.last then
    error("List is empty")
  end
  local value = self.data[first]
  self.data[first] = nil
  self.first = first + 1
  return value
end

function Queue:PopBack()
  local last = self.last
  if last < self.first then
    error("List is empty")
  end
  local value = self.data[last]
  self.data[last] = nil
  self.last = last - 1
  return value
end

function Queue:Clear()
  self.data = {}
  self.first = 0
  self.last = -1
end

return Queue
