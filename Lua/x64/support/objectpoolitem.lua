local var_0_0 = class("ObjectPoolItem")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.fromObjectPool = false
	arg_1_0.objects_ = {}
	arg_1_0.freeList_ = {}
	arg_1_0.usingList = {}
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.itemPrefab_ = arg_2_2
	arg_2_0.parent_ = arg_2_1
	arg_2_0.fromObjectPool = false

	for iter_2_0 = 1, arg_2_3 do
		arg_2_0:Create()
	end
end

function var_0_0.InitFromObjectPool(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.parent_ = arg_3_1
	arg_3_0.assetPath_ = arg_3_2
	arg_3_0.fromObjectPool = true

	for iter_3_0 = 1, arg_3_3 do
		arg_3_0:Create()
	end
end

function var_0_0.Create(arg_4_0)
	local var_4_0

	if arg_4_0.fromObjectPool then
		var_4_0 = manager.objectPool:Get(arg_4_0.assetPath_)
	else
		var_4_0 = Object.Instantiate(arg_4_0.itemPrefab_, arg_4_0.parent_)
	end

	local var_4_1 = var_4_0.transform

	if var_4_1.parent ~= arg_4_0.parent_ then
		var_4_1:SetParent(arg_4_0.parent_, false)
	end

	table.insert(arg_4_0.objects_, var_4_0)
	table.insert(arg_4_0.freeList_, var_4_0)

	return var_4_0
end

function var_0_0.Get(arg_5_0)
	if #arg_5_0.freeList_ <= 0 then
		arg_5_0:Create()
	end

	local var_5_0 = arg_5_0.freeList_[#arg_5_0.freeList_]

	var_5_0.transform.localScale = Vector3(1, 1, 1)
	var_5_0.transform.localPosition = Vector3(1, 1, 1)

	table.insert(arg_5_0.usingList, var_5_0)
	table.remove(arg_5_0.freeList_, #arg_5_0.freeList_)

	return var_5_0
end

function var_0_0.Return(arg_6_0, arg_6_1)
	local var_6_0 = table.indexof(arg_6_0.usingList, arg_6_1)

	if var_6_0 ~= false then
		table.insert(arg_6_0.freeList_, arg_6_1)
		table.remove(arg_6_0.usingList, var_6_0)
	end
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.fromObjectPool and manager.objectPool:IsRecycleAssetPath(arg_7_0.assetPath_) then
		for iter_7_0 = 1, #arg_7_0.objects_ do
			manager.objectPool:Return(arg_7_0.assetPath_, arg_7_0.objects_[iter_7_0])
		end
	else
		for iter_7_1 = 1, #arg_7_0.objects_ do
			Object.Destroy(arg_7_0.objects_[iter_7_1])
		end
	end
end

return var_0_0
