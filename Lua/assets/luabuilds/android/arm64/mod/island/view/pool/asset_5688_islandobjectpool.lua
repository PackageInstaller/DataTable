local IslandObjectPool = class("IslandObjectPool")

function IslandObjectPool:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.root = arg_1_1
	self.assetPath = arg_1_2
	self.assetType = arg_1_3
	self.capacity = arg_1_4 or 3
	self.asset = nil
	self.key = self.assetPath
	self.items = {}
	self.isLoading = false
	self.insIdList = {}

	return
end

function IslandObjectPool:SetInstanceDestroyPreProcessor(arg_2_1)
	self.instanceDestroyPreProcessor = arg_2_1

	return
end

function IslandObjectPool:Isloaded()
	return self.asset ~= nil
end

function IslandObjectPool:IsLoading()
	return self.isLoading
end

function IslandObjectPool:CanDelete()
	return self:Isloaded() and #self.items > 0
end

function IslandObjectPool:ActiveOrDisactiveItem(arg_6_1, arg_6_2)
	SetActive(arg_6_1, arg_6_2)

	return
end

function IslandObjectPool:Load(arg_7_1)
	self.isLoading = true
	self.loadingId = IslandAssetLoadDispatcher.Instance:Enqueue(self.assetPath, "", self.assetType, UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
		assert(arg_8_0, "asset is nil >>>" .. self.assetPath)

		self.asset = arg_8_0

		if self:Isloaded() then
			arg_7_1()
		end

		self.isLoading = false

		return
	end), true, true)

	return
end

function IslandObjectPool:NewItem()
	assert(self:Isloaded(), "call load first")

	return Object.Instantiate(self.asset)
end

function IslandObjectPool:NewItemAsyn(arg_10_1)
	assert(self:Isloaded(), "call load first")
	table.insert(self.insIdList, (FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(self.asset, function(arg_11_0)
		arg_10_1(arg_11_0)

		return
	end)))

	return
end

function IslandObjectPool:DequeueAsyn(arg_12_1)
	if #self.items > 0 then
		local var_12_0 = table.remove(self.items, 1)

		if UIUtil.IsGameObject(var_12_0) then
			self:ActiveOrDisactiveItem(var_12_0, true)
		end

		arg_12_1(var_12_0)
	else
		self:NewItemAsyn(function(arg_13_0)
			if UIUtil.IsGameObject(arg_13_0) then
				self:ActiveOrDisactiveItem(arg_13_0, true)
			end

			arg_12_1(arg_13_0)

			return
		end)
	end

	return
end

function IslandObjectPool:Dequeue()
	local var_14_0 = #self.items > 0 and table.remove(self.items, 1) or self:NewItem()

	if UIUtil.IsGameObject(var_14_0) then
		self:ActiveOrDisactiveItem(var_14_0, true)
	end

	assert(var_14_0, "item is nil", self.assetPath)

	return var_14_0
end

function IslandObjectPool:Enqueue(arg_15_1)
	assert(arg_15_1, "item is nil")

	if #self.items >= self.capacity then
		existCall(self.instanceDestroyPreProcessor, arg_15_1)
		Object.Destroy(arg_15_1)

		return
	end

	if UIUtil.IsGameObject(arg_15_1) then
		setParent(arg_15_1, self.root)
		self:ActiveOrDisactiveItem(arg_15_1, false)
	end

	table.insert(self.items, arg_15_1)

	return
end

function IslandObjectPool:Clear()
	for iter_16_0, iter_16_1 in ipairs(self.items) do
		existCall(self.instanceDestroyPreProcessor, iter_16_1)
		Object.Destroy(iter_16_1)
	end

	self.items = {}

	for iter_16_2, iter_16_3 in ipairs(self.insIdList) do
		FrameAsyncInstantiateManager.Instance:Cancel(iter_16_3)
	end

	self.insIdList = {}

	return
end

function IslandObjectPool:Dispose()
	self:Clear()

	self.items = nil
	self.asset = nil

	if self.loadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(self.loadingId)

		self.loadingId = nil
	end

	return
end

return IslandObjectPool
