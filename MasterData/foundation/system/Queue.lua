local Queue = {}

function Queue.New()
  local queue = {first = 0, last = -1}
  setmetatable(queue, Queue)
  Queue.__index = Queue
  return queue
end

function Queue:Push(value)
  local last = self.last + 1
  self.last = last
  self[last] = value
end

function Queue:Pop()
  local first = self.first
  if first > self.last then
    return nil
  end
  local value = self[first]
  self[first] = nil
  self.first = first + 1
  return value
end

function Queue:Peek()
  local first = self.first
  if first > self.last then
    return nil
  end
  return self[first]
end

function Queue:Count()
  return self.last - self.first + 1
end

function Queue:IsEmpty()
  return self.first > self.last
end

return Queue
