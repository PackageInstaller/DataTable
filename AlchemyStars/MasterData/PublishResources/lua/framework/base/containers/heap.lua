local floor = math.floor
_class("Heap", Object)
Heap = Heap
Heap.CPM_CUSTOM = 1
Heap.CPM_GREATER = 2
Heap.CPM_LESS = 3

function Heap:Constructor(cpm, comparer)
  self.array = {}
  self.size = 0
  self.item_ever_enqueued = 0
  if cpm == Heap.CPM_CUSTOM then
    self.CheckPriority = Heap.CheckPriorityByComparer
    self.comparer = comparer
  elseif cpm == Heap.CPM_GREATER then
    self.CheckPriority = Heap.CheckPriorityByGreater
  elseif cpm == Heap.CPM_LESS then
    self.CheckPriority = Heap.CheckPriorityByLess
  else
    self.CheckPriority = Heap.CheckPriorityByGreater
  end
end

function Heap:BuildHeapPriorityQueue()
  local last_parent = floor(self.size * 0.5)
  for hi = last_parent, 1, -1 do
    self:CascadeDown(hi)
  end
end

function Heap:Clear()
  self.array = {}
  self.size = 0
end

function Heap:Size()
  return self.size
end

function Heap:Empty()
  return self.size == 0
end

function Heap:Peek()
  if self.size > 0 then
    return self.array[1]
  end
end

function Heap:GetAt(hi)
  if 0 < hi and hi <= self.size then
    return self.array[hi]
  end
end

function Heap:Contains(item)
  local hi = item._heap_index
  if hi and 0 < hi then
    return true
  end
end

function Heap:Enqueue(item)
  local hi = item._heap_index
  if hi and 0 < hi then
    self:UpdatePriorityByIndex(hi)
    return
  end
  hi = self.size + 1
  self.size = hi
  self.array[hi] = item
  item._heap_index = hi
  local ii = self.item_ever_enqueued + 1
  self.item_ever_enqueued = ii
  item._insertion_index = ii
  self:CascadeUp(hi)
end

function Heap:Dequeue()
  local size = self.size
  if size == 0 then
    return
  end
  local item = self.array[1]
  item._heap_index = -1
  if size == 1 then
    self.array[1] = nil
    self.size = 0
  else
    local temp = self.array[size]
    self.array[1] = temp
    temp._heap_index = 1
    self.array[size] = nil
    self.size = size - 1
    self:CascadeDown(1)
  end
  return item
end

function Heap:UpdatePriority(item)
  local hi = item._heap_index
  if hi and 0 < hi then
    self:UpdatePriorityByIndex(hi)
  end
end

function Heap:UpdatePriorityByIndex(hi)
  if hi < 1 or hi > self.size then
    return
  end
  local parent = floor(hi * 0.5)
  if 0 < parent and self:CheckPriority(self.array[hi], self.array[parent]) then
    self:CascadeUp(hi)
  else
    self:CascadeDown(hi)
  end
end

function Heap:Remove(item)
  local hi = item._heap_index
  if hi and 0 < hi then
    self:RemoveByIndex(hi)
  end
end

function Heap:RemoveByIndex(hi)
  if hi < 1 or hi > self.size then
    Log.error("Heap:RemoveByIndex error index ", hi, self.size, Log.traceback())
    return
  end
  self.array[hi]._heap_index = -1
  local size = self.size
  if hi == size then
    self.array[hi] = nil
    self.size = size - 1
  else
    local temp = self.array[size]
    self.array[hi] = temp
    temp._heap_index = hi
    self.array[size] = nil
    self.size = size - 1
    self:UpdatePriorityByIndex(hi)
  end
end

function Heap:Check(must_less_priority_than_this)
  for hi = 1, #self.array do
    local item = self.array[hi]
    if item._heap_index ~= hi then
      return false
    end
    if must_less_priority_than_this and self:CheckPriority(item, must_less_priority_than_this) then
      return false
    end
    local pi = floor(hi * 0.5)
    if 0 < pi then
      local parent = self.array[pi]
      if self:CheckPriority(item, parent) then
        return false
      end
    end
  end
  return true
end

function Heap:Swap(i, j)
  local item_i = self.array[i]
  local item_j = self.array[j]
  self.array[i] = item_j
  self.array[j] = item_i
  item_i._heap_index = j
  item_j._heap_index = i
end

function Heap:CascadeUp(hi)
  local parent = floor(hi * 0.5)
  while 0 < parent do
    if self:CheckPriority(self.array[hi], self.array[parent]) then
      self:Swap(hi, parent)
      hi = parent
      parent = floor(hi * 0.5)
    else
      break
    end
  end
end

function Heap:CascadeDown(hi)
  local l, r
  local largest = hi
  while true do
    l = 2 * hi
    r = 2 * hi + 1
    if l <= self.size and self:CheckPriority(self.array[l], self.array[largest]) then
      largest = l
    end
    if r <= self.size and self:CheckPriority(self.array[r], self.array[largest]) then
      largest = r
    end
    if largest == hi then
      break
    end
    self:Swap(hi, largest)
    hi = largest
  end
end

function Heap:CheckPriorityByGreater(higher, lower)
  if lower < higher then
    return true
  elseif higher < lower then
    return false
  else
    return higher._insertion_index < lower._insertion_index
  end
end

function Heap:CheckPriorityByLess(higher, lower)
  if higher < lower then
    return true
  elseif lower < higher then
    return false
  else
    return higher._insertion_index < lower._insertion_index
  end
end

function Heap:CheckPriorityByComparer(higher, lower)
  local result = self.comparer(higher, lower)
  if 0 < result then
    return true
  elseif result < 0 then
    return false
  else
    return higher._insertion_index < lower._insertion_index
  end
end
