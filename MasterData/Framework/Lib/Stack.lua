Stack = {}
Stack.__index = Stack

function Stack.New()
  local o = {}
  o.data = {}
  o.bottom = 1
  o.top = 1
  setmetatable(o, Stack)
  return o
end

function Stack:Count()
  return self.top - self.bottom
end

function Stack:Empty()
  return self.bottom == self.top
end

function Stack:Push(item)
  self.data[self.top] = item
  self.top = self.top + 1
end

function Stack:Pop()
  if self:Empty() then
    return nil
  end
  local index = self.top - 1
  local o = self.data[index]
  self.data[index] = nil
  self.top = index
  return o
end

function Stack:Find(judgeFunc)
  for index = self:Count(), 1, -1 do
    local item = self.data[index]
    if judgeFunc(item) then
      return item
    end
  end
end

function Stack:Peek()
  if self:Empty() then
    return nil
  end
  return self.data[self.top - 1]
end

function Stack:Clear()
  self.data = {}
  self.top = self.bottom
end

return Stack
