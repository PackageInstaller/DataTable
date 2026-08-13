class = var_0_10000

local var_0_0 = var_0_10000("IslandObjectPool")

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
	local var_5_0

	if arg_5_0:Isloaded() then
		var_5_0 = #arg_5_0.items > 0
	end

	return var_5_0
end

function var_0_0.ActiveOrDisactiveItem(arg_6_0, arg_6_1, arg_6_2)
	SetActive = var_1_10003

	var_1_10003(arg_6_1, arg_6_2)

	return
end

function var_0_0.Load(arg_7_0, arg_7_1)
	arg_7_0.isLoading = true
	IslandAssetLoadDispatcher = var_2

	local var_7_0 = var_2.Instance
	local var_7_1 = var_2.Enqueue
	local var_7_2 = arg_7_0.assetPath
	local var_7_3 = ""
	local var_7_4 = arg_7_0.assetType

	UnityEngine = var_1_10007
	arg_7_0.loadingId = var_7_1(var_7_0, var_7_2, var_7_3, var_7_4, var_1_10007.Events.UnityAction_UnityEngine_Object(function(arg_8_0)
		assert = var_2_10001

		var_2_10001(arg_8_0, "asset is nil >>>" .. arg_7_0.assetPath)

		arg_7_0.asset = arg_8_0

		local var_8_0 = arg_7_0

		if var_1.Isloaded(var_8_0) then
			arg_7_1()
		end

		arg_7_0.isLoading = false

		return
	end), true, true)

	return
end

function var_0_0.NewItem(arg_9_0)
	assert = var_1_10001

	var_1_10001(arg_9_0:Isloaded(), "call load first")

	Object = var_1_10001

	return var_1_10001.Instantiate(arg_9_0.asset)
end

function var_0_0.NewItemAsyn(arg_10_0, arg_10_1)
	assert = var_1_10002

	var_1_10002(arg_10_0:Isloaded(), "call load first")

	FrameAsyncInstantiateManager = var_1_10002

	local var_10_0 = var_1_10002.Instance
	local var_10_1 = var_2.EnqueueInstantiate(var_10_0, arg_10_0.asset, function(arg_11_0)
		arg_10_1(arg_11_0)

		return
	end)

	table = var_10_0

	var_10_0.insert(arg_10_0.insIdList, var_10_1)

	return
end

function var_0_0.DequeueAsyn(arg_12_0, arg_12_1)
	if #arg_12_0.items > 0 then
		table = var_2

		local var_12_0 = var_2.remove(arg_12_0.items, 1)

		UIUtil = var_3

		if var_3.IsGameObject(var_12_0) then
			arg_12_0:ActiveOrDisactiveItem(var_12_0, true)
		end

		arg_12_1(var_12_0)
	else
		arg_12_0:NewItemAsyn(function(arg_13_0)
			UIUtil = var_2_10001

			if var_2_10001.IsGameObject(arg_13_0) then
				local var_13_0 = arg_12_0

				var_1.ActiveOrDisactiveItem(var_13_0, arg_13_0, true)
			end

			arg_12_1(arg_13_0)

			return
		end)
	end

	return
end

function var_0_0.Dequeue(arg_14_0)
	local var_14_0

	if #arg_14_0.items > 0 then
		table = var_2
		var_14_0 = var_2.remove(arg_14_0.items, 1)
	else
		var_14_0 = arg_14_0:NewItem()
	end

	UIUtil = var_2

	if var_2.IsGameObject(var_14_0) then
		arg_14_0:ActiveOrDisactiveItem(var_14_0, true)
	end

	assert = var_2

	var_2(var_14_0, "item is nil", arg_14_0.assetPath)

	return var_14_0
end

function var_0_0.Enqueue(arg_15_0, arg_15_1)
	assert = var_1_10002

	var_1_10002(arg_15_1, "item is nil")

	if #arg_15_0.items >= arg_15_0.capacity then
		existCall = var_2

		var_2(arg_15_0.instanceDestroyPreProcessor, arg_15_1)

		Object = var_2

		var_2.Destroy(arg_15_1)

		return
	end

	UIUtil = var_2

	if var_2.IsGameObject(arg_15_1) then
		setParent = var_2

		var_2(arg_15_1, arg_15_0.root)
		arg_15_0:ActiveOrDisactiveItem(arg_15_1, false)
	end

	table = var_2

	var_2.insert(arg_15_0.items, arg_15_1)

	return
end

function var_0_0.Clear(arg_16_0)
	ipairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.items) do
		existCall = var_1_10006

		var_1_10006(arg_16_0.instanceDestroyPreProcessor, iter_16_1)

		Object = var_1_10006

		var_1_10006.Destroy(iter_16_1)
	end

	arg_16_0.items = {}
	ipairs = var_1

	for iter_16_2, iter_16_3 in var_1(arg_16_0.insIdList) do
		FrameAsyncInstantiateManager = var_1_10006

		local var_16_0 = var_1_10006.Instance

		var_1_10006.Cancel(var_16_0, iter_16_3)
	end

	arg_16_0.insIdList = {}

	return
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:Clear()

	arg_17_0.items = nil
	arg_17_0.asset = nil

	if arg_17_0.loadingId then
		IslandAssetLoadDispatcher = var_1

		local var_17_0 = var_1.Instance

		var_1.Cancel(var_17_0, arg_17_0.loadingId)

		arg_17_0.loadingId = nil
	end

	return
end

return var_0_0
