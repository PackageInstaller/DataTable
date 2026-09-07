local OrderTplPool = class("OrderTplPool")

function OrderTplPool:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.initCnt = arg_1_2
	self.maxCnt = arg_1_3
	self.prefab = arg_1_1.gameObject
	self.root = arg_1_1.parent
	self.items = {}

	self:Init()

	return
end

function OrderTplPool:NewItem()
	return Object.Instantiate(self.prefab)
end

function OrderTplPool:Init()
	for iter_3_0 = 1, self.initCnt do
		self:Enqueue((self:NewItem()))
	end

	return
end

function OrderTplPool:Enqueue(arg_4_1)
	if #self.items + 1 > self.maxCnt then
		Object.Destroy(arg_4_1)
	else
		setParent(arg_4_1, self.root)

		arg_4_1.transform.localPosition = Vector3.zero

		table.insert(self.items, arg_4_1)
	end

	return
end

function OrderTplPool:Dequeue()
	return #self.items > 0 and table.remove(self.items, 1) or self:NewItem()
end

function OrderTplPool:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.items) do
		Object.Destroy(iter_6_1)
	end

	self.items = {}
	self.prefab = nil

	return
end

return OrderTplPool
