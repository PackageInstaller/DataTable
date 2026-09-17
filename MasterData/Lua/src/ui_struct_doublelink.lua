local this = class("doubleLink")

function this:ctor()
  self:reset()
end

function this:reset()
  self.head = {}
  self.tail = {}
  self.head.next = self.tail
  self.tail.pre = self.head
  self.count = 0
end

function this:nodeHeadInsert(node)
  local head = self.head
  local next = head.next
  node.pre = head
  node.next = next
  head.next = node
  next.pre = node
  self.count = self.count + 1
  return node
end

function this:nodeRemove(node)
  node.pre.next = node.next
  node.next.pre = node.pre
  self.count = self.count - 1
end

function this:getFirst()
  return self.head.next
end

function this:getLast()
  return self.tail.pre
end

return this
