_class("LinkedList", Object)
LinkedList = LinkedList

function LinkedList:Constructor()
  self.first = nil
  self.last = nil
  self.count = 0
end

function LinkedList:Dispose()
  self.first = nil
  self.last = nil
  self.count = 0
end

function LinkedList:Count()
  return self.count
end

function LinkedList:GetFirst()
  if self.count == 0 then
    return
  end
  if self.first then
    return self.first.value
  end
end

function LinkedList:GetLast()
  if self.count == 0 then
    return
  end
  if self.last then
    return self.last.value
  end
end

function LinkedList:Get(index)
  if index < 1 or index > self.count then
    return
  end
  if index <= self.count / 2 then
    local current = self.first
    for i = 1, index - 1 do
      current = current.next
    end
    return current.value
  else
    local current = self.last
    for i = self.count, index + 1, -1 do
      current = current.prev
    end
    return current.value
  end
end

function LinkedList:AddFirst(item)
  if item == nil then
    return
  end
  local newNode = LinkedListNode:New(item)
  if self.count == 0 then
    self.first = newNode
    self.last = self.first
    self.count = self.count + 1
    return
  end
  local temp = self.first
  temp:SetNear(newNode, temp.next)
  newNode:SetNear(nil, temp)
  self.first = newNode
  self.count = self.count + 1
end

function LinkedList:AddLast(item)
  if item == nil then
    return
  end
  local newNode = LinkedListNode:New(item)
  if self.count == 0 then
    self.first = newNode
    self.last = self.first
    self.count = self.count + 1
    return
  end
  self.last:SetNear(self.last.prev, newNode)
  newNode:SetNear(self.last, nil)
  self.last = newNode
  self.count = self.count + 1
end

function LinkedList:RemoveLast()
  if self.count == 0 then
    return
  end
  if self.count == 1 then
    self.first = nil
    self.last = nil
    self.count = 0
    return
  end
  self.last = self.last.prev
  self.last.next = nil
  self.count = self.count - 1
end

function LinkedList:RemoveFirst()
  if self.count == 0 then
    return
  end
  if self.count == 1 then
    self.first = nil
    self.last = nil
    self.count = 0
    return
  end
  self.first = self.first.next
  self.first.prev = nil
  self.count = self.count - 1
end

function LinkedList:PopFirst()
  if self.count == 0 then
    return
  end
  local first = self.first
  self:RemoveFirst()
  return first.value
end

function LinkedList:PopLast()
  if self.count == 0 then
    return
  end
  local last = self.last
  self:RemoveLast()
  return last.value
end

function LinkedList:Foreach(func)
  if func == nil then
    return
  end
  local node = self.first
  while node ~= nil do
    func(node.value)
    node = node.next
  end
end

function LinkedList:ReverseForeach(func)
  if func == nil then
    return
  end
  local node = self.last
  while node ~= nil do
    func(node.value)
    node = node.prev
  end
end

function LinkedList:Reverse()
  local p, q, pr = self.first
  self.last = self.first
  self.first = nil
  while p do
    pr = p.next
    p.prev = pr
    p.next = q
    q = p
    p = pr
  end
  self.first = q
end
