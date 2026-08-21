local var_0_0 = class("IslandObjectPool")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.root = arg_1_1
	arg_1_0.assetPath = arg_1_2
	arg_1_0.assetType = arg_1_3
	arg_1_0.capacity = arg_1_4 or 3
	arg_1_0.asset = nil
	arg_1_0.key = arg_1_0.assetPath
	arg_1_0.items = {}
	arg_1_0.isLoading = false
	arg_1_0.insIdList = {}

	return
end

function var_0_0.SetInstanceDestroyPreProcessor(arg_2_0, arg_2_1)
	arg_2_0.instanceDestroyPreProcessor = arg_2_1

	return
end

function var_0_0.Isloaded(arg_3_0)
	return arg_3_0.asset ~= nil
end

function var_0_0.IsLoading(arg_4_0)
	return arg_4_0.isLoading
end

function var_0_0.CanDelete(arg_5_0)
	return arg_5_0:Isloaded() and #arg_5_0.items > 0
end

function var_0_0.ActiveOrDisactiveItem(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_1, arg_6_2)

	return
end

function var_0_0.Load(arg_7_0, arg_7_1)
	arg_7_0.isLoading = true
	arg_7_0.loadingId = IslandAssetLoadDispatcher.Instance:Enqueue(arg_7_0.assetPath, "", arg_7_0.assetType, UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
		assert(arg_8_0, "asset is nil >>>" .. arg_7_0.assetPath)

		arg_7_0.asset = arg_8_0

		if arg_7_0:Isloaded() then
			arg_7_1()
		end

		arg_7_0.isLoading = false

		return
	end), true, true)

	return
end

function var_0_0.NewItem(arg_9_0)
	assert(arg_9_0:Isloaded(), "call load first")

	return Object.Instantiate(arg_9_0.asset)
end

function var_0_0.NewItemAsyn(arg_10_0, arg_10_1)
	assert(arg_10_0:Isloaded(), "call load first")
	table.insert(arg_10_0.insIdList, (FrameAsyncInstantiateManager.Instance:EnqueueInstantiate(arg_10_0.asset, function(arg_11_0)
		arg_10_1(arg_11_0)

		return
	end)))

	return
end

function var_0_0.DequeueAsyn(arg_12_0, arg_12_1)
	if #arg_12_0.items > 0 then
		local var_12_0 = table.remove(arg_12_0.items, 1)

		if UIUtil.IsGameObject(var_12_0) then
			arg_12_0:ActiveOrDisactiveItem(var_12_0, true)
		end

		arg_12_1(var_12_0)
	else
		arg_12_0:NewItemAsyn(function(arg_13_0)
			if UIUtil.IsGameObject(arg_13_0) then
				arg_12_0:ActiveOrDisactiveItem(arg_13_0, true)
			end

			arg_12_1(arg_13_0)

			return
		end)
	end

	return
end

function var_0_0.Dequeue(arg_14_0)
	local var_14_0 = #arg_14_0.items > 0 and table.remove(arg_14_0.items, 1) or arg_14_0:NewItem()

	if UIUtil.IsGameObject(var_14_0) then
		arg_14_0:ActiveOrDisactiveItem(var_14_0, true)
	end

	assert(var_14_0, "item is nil", arg_14_0.assetPath)

	return var_14_0
end

function var_0_0.Enqueue(arg_15_0, arg_15_1)
	assert(arg_15_1, "item is nil")

	if #arg_15_0.items >= arg_15_0.capacity then
		existCall(arg_15_0.instanceDestroyPreProcessor, arg_15_1)
		Object.Destroy(arg_15_1)

		return
	end

	if UIUtil.IsGameObject(arg_15_1) then
		setParent(arg_15_1, arg_15_0.root)
		arg_15_0:ActiveOrDisactiveItem(arg_15_1, false)
	end

	table.insert(arg_15_0.items, arg_15_1)

	return
end

function var_0_0.Clear(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.items) do
		existCall(arg_16_0.instanceDestroyPreProcessor, iter_16_1)
		Object.Destroy(iter_16_1)
	end

	arg_16_0.items = {}

	for iter_16_2, iter_16_3 in ipairs(arg_16_0.insIdList) do
		FrameAsyncInstantiateManager.Instance:Cancel(iter_16_3)
	end

	arg_16_0.insIdList = {}

	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:Clear()

	arg_17_0.items = nil
	arg_17_0.asset = nil

	if arg_17_0.loadingId then
		IslandAssetLoadDispatcher.Instance:Cancel(arg_17_0.loadingId)

		arg_17_0.loadingId = nil
	end

	return
end

return var_0_0
