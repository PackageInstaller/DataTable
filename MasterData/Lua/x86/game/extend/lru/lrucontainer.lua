local LRUContainer = class("LRUContainer")

function LRUContainer:Ctor(arg_1_1, arg_1_2)
	self.limit = arg_1_1
	self.recycleCb = arg_1_2
	self.head = nil
	self.tail = nil
	self.map = {}
	self.count = 0

	if arg_1_1 == -1 then
		self.limit = 99999
	end
end

function LRUContainer:Get(arg_2_1)
	return self.map[arg_2_1]
end

function LRUContainer:Use(arg_3_1, arg_3_2)
	if self.map[arg_3_1] and self.count >= 1 then
		self:MoveToFront(arg_3_1)

		return true
	else
		self:AddToFront(arg_3_1, arg_3_2)

		if self.count > self.limit then
			if self.recycleCb then
				self.recycleCb(self:RemoveNode(self.tail.key).value)
			end
		end

		return false
	end
end

function LRUContainer:RemoveNode(arg_4_1)
	if self.map[arg_4_1] then
		if self.map[arg_4_1].pre then
			self.map[arg_4_1].pre.next = self.map[arg_4_1].next
		end

		if self.map[arg_4_1].next then
			self.map[arg_4_1].next.pre = self.map[arg_4_1].pre
		end

		if self.map[arg_4_1] == self.head then
			self.head = self.map[arg_4_1].next
		end

		if self.map[arg_4_1] == self.tail then
			self.tail = self.map[arg_4_1].pre
		end

		self.map[arg_4_1].next = nil
		self.map[arg_4_1].pre = nil
		self.map[arg_4_1] = nil
		self.count = self.count - 1

		return self.map[arg_4_1]
	end

	return nil
end

function LRUContainer:AddToFront(arg_5_1, arg_5_2)
	local var_5_0 = self.map[arg_5_1]

	if not self.map[arg_5_1] then
		var_5_0 = LRUNode.New()
		var_5_0.value = arg_5_2
		var_5_0.key = arg_5_1
		self.map[arg_5_1] = var_5_0
	end

	local var_5_1 = self.head

	if not self.head then
		self.head = var_5_0
		self.tail = var_5_0
		self.count = self.count + 1

		return true
	end

	var_5_0.next = var_5_1
	var_5_0.pre = var_5_1.pre
	var_5_1.pre = var_5_0
	self.head = var_5_0
	self.count = self.count + 1

	return true
end

function LRUContainer:MoveToFront(arg_6_1)
	if not self.map[arg_6_1] then
		return false
	end

	if self.map[arg_6_1] == self.head then
		return true
	end

	local var_6_0 = self:RemoveNode(arg_6_1)

	if var_6_0 then
		self:AddToFront(var_6_0.key, var_6_0.value)

		return true
	end

	return false
end

function LRUContainer:Dispose()
	while self.head ~= nil do
		if self.recycleCb then
			self.recycleCb(self.head.value)
		end
	end
end

return LRUContainer
