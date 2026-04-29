_class("ArrayList", Object)
ArrayList = ArrayList

function ArrayList:Constructor()
  self.elements = {}
end

function ArrayList:Empty()
  return #self.elements == 0
end

function ArrayList:Size()
  return #self.elements
end

function ArrayList:Clear()
  self.elements = {}
end

function ArrayList:PushBack(value)
  if value == nil then
    return
  end
  local elements = self.elements
  elements[#elements + 1] = value
end

function ArrayList:PushFront(value)
  if value == nil then
    return
  end
  local elements = self.elements
  for i = #elements, 1, -1 do
    elements[i + 1] = elements[i]
  end
  elements[1] = value
end

function ArrayList:Insert(value, index)
  if value == nil then
    return
  end
  local elements = self.elements
  local size = #elements
  if index < 1 then
    self:PushFront(value)
    return
  elseif index > size then
    self:PushBack(value)
    return
  end
  for i = size, index, -1 do
    elements[i + 1] = elements[i]
  end
  elements[index] = value
end

function ArrayList:MoveToBack(index)
  local elements = self.elements
  local size = #elements
  if index < 1 or index >= size then
    return
  end
  local temp = elements[index]
  for i = index, size - 1 do
    elements[i] = elements[i + 1]
  end
  elements[size] = temp
end

function ArrayList:MoveToFront(index)
  local elements = self.elements
  local size = #elements
  if index <= 1 or index > size then
    return
  end
  local temp = elements[index]
  for i = index - 1, 1, -1 do
    elements[i + 1] = elements[i]
  end
  elements[1] = temp
end

function ArrayList:MoveToIndex(old_index, new_index)
  local elements = self.elements
  local size = #elements
  if old_index < 1 or old_index > size then
    return
  end
  if new_index < 1 or new_index > size then
    return
  end
  if old_index == new_index then
    return
  end
  local temp = elements[old_index]
  if old_index < new_index then
    for i = old_index, new_index - 1 do
      elements[i] = elements[i + 1]
    end
  else
    for i = old_index - 1, new_index, -1 do
      elements[i + 1] = elements[i]
    end
  end
  elements[new_index] = temp
end

function ArrayList:PopBack()
  local elements = self.elements
  local size = #elements
  local temp = elements[size]
  elements[size] = nil
  return temp
end

function ArrayList:RemoveByIndex(index)
  local elements = self.elements
  local size = #elements
  if index < 1 or index > size then
    return
  end
  for i = index, size - 1 do
    elements[i] = elements[i + 1]
  end
  elements[size] = nil
end

ArrayList.RemoveAt = ArrayList.RemoveByIndex

function ArrayList:RemoveFirst(value)
  local index = self:Find(value, 1)
  self:RemoveAt(index)
  return index
end

ArrayList.Remove = ArrayList.RemoveFirst

function ArrayList:Find(value, from_index)
  from_index = from_index or 1
  local elements = self.elements
  for i = from_index, #elements do
    if elements[i] == value then
      return i
    end
  end
  return -1
end

function ArrayList:Contains(value, from_index)
  local index = self:Find(value, from_index)
  if index == -1 then
    return false
  else
    return true
  end
end

function ArrayList:GetAt(index)
  return self.elements[index]
end

function ArrayList:Front()
  return self.elements[1]
end

function ArrayList:ForEach(func)
  local elements = self.elements
  for i = 1, #elements do
    func(elements[i])
  end
end

function ArrayList:HandleForeach(handler, func, ...)
  local elements = self.elements
  for i = 1, #elements do
    local bSuccess = func(handler, elements[i], ...)
    if false == bSuccess or 0 == bSuccess then
      break
    end
  end
end

function ArrayList:RemoveByValue(value)
  local index = self:Find(value, 1)
  if index < 1 or index > #self.elements then
    return false
  end
  self:RemoveAt(index)
  return true
end

function ArrayList:Clone(al)
  if al == nil then
    return
  end
  if type(al) ~= "table" then
    return
  end
  if al._className ~= "ArrayList" then
    return
  end
  al:ForEach(function(v)
    self:PushBack(v)
  end)
end
