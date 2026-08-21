_class("SortedArray", Object)
SortedArray = SortedArray
local floor = math.floor

function SortedArray:Constructor(compare_method, comparer)
  self.elements = {}
  if compare_method == Algorithm.COMPARE_LESS then
    self.comparer = Algorithm.LessComparer
  elseif compare_method == Algorithm.COMPARE_GREATER then
    self.comparer = Algorithm.GreaterComparer
  elseif compare_method == Algorithm.COMPARE_CUSTOM then
    self.comparer = comparer
  else
    self.comparer = Algorithm.LessComparer
  end
  self.allow_duplicate = false
end

function SortedArray:Empty()
  return #self.elements == 0
end

function SortedArray:Size()
  return #self.elements
end

function SortedArray:Clear()
  self.elements = {}
end

function SortedArray:AllowDuplicate()
  self.allow_duplicate = true
end

function SortedArray:Insert(value)
  if value == nil then
    return
  end
  local index, exist = self:FindInsertIndexInternal(value)
  if exist and not self.allow_duplicate then
    if _DEBUG then
      LogError("SortedArray:Insert, duplicate element")
    end
    self.elements[index] = value
  else
    local elements = self.elements
    for i = #elements, index, -1 do
      elements[i + 1] = elements[i]
    end
    elements[index] = value
  end
end

function SortedArray:Remove(value)
  if value == nil then
    return false
  end
  local index = self:BinarySearchInternal(value)
  if index == -1 then
    return false
  end
  local elements = self.elements
  local size = #elements
  for i = index, size - 1 do
    elements[i] = elements[i + 1]
  end
  elements[size] = nil
  return true
end

function SortedArray:RemoveLeft(nCount)
  if nCount <= 0 then
    return 0
  end
  local elements = self.elements
  local size = #elements
  if nCount >= size then
    self:Clear()
    return size
  end
  local i = 0
  for i = 1, size do
    if i <= size - nCount then
      elements[i] = elements[i + nCount]
    else
      elements[i] = nil
    end
  end
  return nCount
end

function SortedArray:RemoveByIndex(index)
  local elements = self.elements
  local size = #elements
  if index < 1 or index > size then
    return nil
  end
  local temp = elements[index]
  for i = index, size - 1 do
    elements[i] = elements[i + 1]
  end
  elements[size] = nil
  return temp
end

SortedArray.RemoveAt = SortedArray.RemoveByIndex

function SortedArray:Find(value)
  if value == nil then
    return -1
  end
  return self:BinarySearchInternal(value)
end

function SortedArray:Contains(value)
  return self:Find(value) > 0
end

function SortedArray:GetAt(index)
  return self.elements[index]
end

function SortedArray:ForEach(func)
  local elements = self.elements
  for i = 1, #elements do
    func(elements[i])
  end
end

function SortedArray:HandleForeach(handle, func, ...)
  local elements = self.elements
  for i = 1, #elements do
    local bSuccess = func(handle, elements[i], ...)
    if false == bSuccess or 0 == bSuccess then
      break
    end
  end
end

function SortedArray:RemoveByCallback(value, handle, func)
  if value == nil then
    return false
  end
  local elements = self.elements
  local size = #elements
  local nWorkIndex = 1
  for i = 1, size do
    local nNeedDel = func(handle, value, elements[i])
    if false == nNeedDel or 0 == nNeedDel then
      if i ~= nWorkIndex then
        elements[nWorkIndex] = elements[i]
      end
      nWorkIndex = nWorkIndex + 1
    end
  end
  for i = nWorkIndex, size do
    elements[size] = nil
  end
  return true
end

function SortedArray:BinarySearchInternal(value)
  local elements = self.elements
  local low = 1
  local high = #elements
  local comparer = self.comparer
  local mid, result
  while low <= high do
    mid = floor((low + high) * 0.5)
    result = comparer(value, elements[mid])
    if 0 < result then
      high = mid - 1
    elseif result < 0 then
      low = mid + 1
    else
      return mid
    end
  end
  return -1
end

function SortedArray:FindInsertIndexInternal(value)
  local elements = self.elements
  local low = 1
  local high = #elements
  local comparer = self.comparer
  local mid, result
  while low <= high do
    mid = floor((low + high) * 0.5)
    result = comparer(value, elements[mid])
    if 0 < result then
      high = mid - 1
    elseif result < 0 then
      low = mid + 1
    else
      return mid, true
    end
  end
  return low, false
end

function SortedArray:IncertionSort(value)
  local elements = self.elements
  local comparer = self.comparer
  local i = #elements
  while 0 < i and 0 < comparer(value, elements[i]) do
    elements[i + 1] = elements[i]
    i = i - 1
  end
  elements[i + 1] = value
end

function SortedArray:GetFirstElement()
  if #self.elements > 0 then
    return self.elements[1]
  end
  return nil
end

function SortedArray:GetLastValue()
  local elements = self.elements
  return self.elements[#self.elements]
end
