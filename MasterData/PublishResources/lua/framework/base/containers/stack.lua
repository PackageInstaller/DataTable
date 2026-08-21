_class("Stack", Object)
Stack = Stack

function Stack:Constructor()
  self.elements = {}
end

function Stack:Empty()
  return #self.elements == 0
end

function Stack:Size()
  return #self.elements
end

function Stack:Clear()
  self.elements = {}
end

function Stack:Push(value)
  if value == nil then
    return
  end
  local elements = self.elements
  elements[#elements + 1] = value
end

function Stack:Pop()
  local elements = self.elements
  local size = #elements
  local temp = elements[size]
  elements[size] = nil
  return temp
end

function Stack:Top()
  local elements = self.elements
  return elements[#elements]
end

function Stack:ForEach(func)
  local elements = self.elements
  local size = #elements
  for i = size, 1, -1 do
    func(elements[i])
  end
end

function Stack:Contains(value)
  local elements = self.elements
  local size = #elements
  for i = size, 1, -1 do
    if elements[i] == value then
      return true
    end
  end
  return false
end

function Stack:ToArray()
  local t = {}
  local elements = self.elements
  local size = #elements
  for i = size, 1, -1 do
    t[#t + 1] = elements[i]
  end
  return t
end
