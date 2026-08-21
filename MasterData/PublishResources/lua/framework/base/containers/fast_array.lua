_class("FastArray", Object)
FastArray = FastArray

function FastArray:Constructor()
  self.elements = {}
end

function FastArray:Empty()
  return #self.elements == 0
end

function FastArray:Size()
  return #self.elements
end

function FastArray:Clear()
  self.elements = {}
end

function FastArray:PushBack(value)
  if value == nil then
    return
  end
  local elements = self.elements
  elements[#elements + 1] = value
end

FastArray.Insert = FastArray.PushBack

function FastArray:PopBack()
  local elements = self.elements
  local size = #elements
  local temp = elements[size]
  elements[size] = nil
  return temp
end

function FastArray:RemoveByIndex(index)
  local elements = self.elements
  local size = #elements
  if index < 1 or index > size then
    return
  end
  local temp = elements[index]
  elements[index] = elements[size]
  elements[size] = nil
  return temp
end

FastArray.RemoveAt = FastArray.RemoveByIndex

function FastArray:RemoveFirst(value)
  local index = self:Find(value, 1)
  self:RemoveAt(index)
end

FastArray.Remove = FastArray.RemoveFirst

function FastArray:Find(value, from_index)
  from_index = from_index or 1
  local elements = self.elements
  for i = from_index, #elements do
    if elements[i] == value then
      return i
    end
  end
  return -1
end

function FastArray:Contains(value, from_index)
  local index = self:Find(value, from_index)
  if index == -1 then
    return false
  else
    return true
  end
end

function FastArray:GetAt(index)
  return self.elements[index]
end

function FastArray:ForEach(func)
  local elements = self.elements
  for i = 1, #elements do
    func(elements[i])
  end
end
