local LRUNode = class("LRUNode")

function LRUNode:Ctor()
	self.next = nil
	self.pre = nil
	self.value = nil
	self.key = nil
end

return LRUNode
