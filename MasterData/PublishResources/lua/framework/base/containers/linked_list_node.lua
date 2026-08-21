_class("LinkedListNode", Object)
LinkedListNode = LinkedListNode

function LinkedListNode:Constructor(v)
  self.value = v
  self.next = nil
  self.prev = nil
end

function LinkedListNode:SetNear(prev, next)
  self.prev = prev
  self.next = next
end
