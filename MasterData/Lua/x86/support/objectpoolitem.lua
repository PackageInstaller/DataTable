local ObjectPoolItem = class("ObjectPoolItem")

function ObjectPoolItem:Ctor()
	self.fromObjectPool = false
	self.objects_ = {}
	self.freeList_ = {}
	self.usingList = {}
end

function ObjectPoolItem:OnCtor(arg_2_1, arg_2_2, arg_2_3)
	self.itemPrefab_ = arg_2_2
	self.parent_ = arg_2_1
	self.fromObjectPool = false

	for iter_2_0 = 1, arg_2_3 do
		self:Create()
	end
end

function ObjectPoolItem:InitFromObjectPool(arg_3_1, arg_3_2, arg_3_3)
	self.parent_ = arg_3_1
	self.assetPath_ = arg_3_2
	self.fromObjectPool = true

	for iter_3_0 = 1, arg_3_3 do
		self:Create()
	end
end

function ObjectPoolItem:Create()
	local var_4_0 = self.fromObjectPool and manager.objectPool:Get(self.assetPath_) or Object.Instantiate(self.itemPrefab_, self.parent_)

	if var_4_0.transform.parent ~= self.parent_ then
		var_4_0.transform:SetParent(self.parent_, false)
	end

	table.insert(self.objects_, var_4_0)
	table.insert(self.freeList_, var_4_0)

	return var_4_0
end

function ObjectPoolItem:Get()
	if #self.freeList_ <= 0 then
		self:Create()
	end

	local var_5_0 = self.freeList_[#self.freeList_]

	self.freeList_[#self.freeList_].transform.localScale = Vector3(1, 1, 1)
	var_5_0.transform.localPosition = Vector3(1, 1, 1)

	table.insert(self.usingList, var_5_0)
	table.remove(self.freeList_, #self.freeList_)

	return var_5_0
end

function ObjectPoolItem:Return(arg_6_1)
	local var_6_0 = table.indexof(self.usingList, arg_6_1)

	if var_6_0 ~= false then
		table.insert(self.freeList_, arg_6_1)
		table.remove(self.usingList, var_6_0)
	end
end

function ObjectPoolItem:Dispose()
	if self.fromObjectPool and manager.objectPool:IsRecycleAssetPath(self.assetPath_) then
		for iter_7_0 = 1, #self.objects_ do
			manager.objectPool:Return(self.assetPath_, self.objects_[iter_7_0])
		end
	else
		for iter_7_1 = 1, #self.objects_ do
			Object.Destroy(self.objects_[iter_7_1])
		end
	end
end

return ObjectPoolItem
