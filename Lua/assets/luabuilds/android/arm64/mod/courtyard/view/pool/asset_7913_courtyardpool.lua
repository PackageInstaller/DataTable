local CourtYardPool = class("CourtYardPool")

function CourtYardPool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.prefab = arg_1_2
	self.parentTF = arg_1_1

	GetOrAddComponent(self.prefab, typeof(CanvasGroup))
	self.prefab.transform:SetParent(self.parentTF, false)

	self.layer = self.parentTF.gameObject.layer
	self.items = {}
	self.max = arg_1_4
	self.initCnt = arg_1_3

	self:Init()

	return
end

function CourtYardPool:Init()
	for iter_2_0 = 1, self.initCnt do
		self:NewItem()
	end

	return
end

function CourtYardPool:Enqueue(arg_3_1)
	if #self.items >= self.max then
		Object.Destroy(arg_3_1)
	else
		arg_3_1.transform.localPosition = Vector3.one

		setActiveViaLayer(arg_3_1.transform, false)
		arg_3_1.transform:SetParent(self.parentTF, true)
		table.insert(self.items, arg_3_1)
	end

	return
end

function CourtYardPool:Dequeue()
	if #self.items <= 0 then
		self:NewItem()
	end

	local var_4_0 = table.remove(self.items, 1)

	setActiveViaLayer(var_4_0.transform, true)

	return var_4_0
end

function CourtYardPool:NewItem()
	local var_5_0 = Object.Instantiate(self.prefab)

	var_5_0.transform.localScale = Vector3.one

	self:Enqueue(var_5_0)

	return
end

function CourtYardPool:Dispose()
	for iter_6_0, iter_6_1 in ipairs(self.items) do
		Object.Destroy(iter_6_1)
	end

	self.items = nil
	self.prefab = nil

	return
end

return CourtYardPool
