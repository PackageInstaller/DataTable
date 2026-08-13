class = var_0_10000

local var_0_0 = var_0_10000("OrderTplPool")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.initCnt = arg_1_2
	arg_1_0.maxCnt = arg_1_3
	arg_1_0.prefab = arg_1_1.gameObject
	arg_1_0.root = arg_1_1.parent
	arg_1_0.items = {}

	arg_1_0:Init()

	return
end

function var_0_0.NewItem(arg_2_0)
	Object = var_1_10001

	return var_1_10001.Instantiate(arg_2_0.prefab)
end

function var_0_0.Init(arg_3_0)
	for iter_3_0 = 1, arg_3_0.initCnt do
		local var_3_0 = arg_3_0:NewItem()

		arg_3_0:Enqueue(var_3_0)
	end

	return
end

function var_0_0.Enqueue(arg_4_0, arg_4_1)
	if #arg_4_0.items + 1 > arg_4_0.maxCnt then
		Object = var_2

		var_2.Destroy(arg_4_1)
	else
		setParent = var_2

		var_2(arg_4_1, arg_4_0.root)

		local var_4_0 = arg_4_1.transform

		Vector3 = var_3
		var_4_0.localPosition = var_3.zero
		table = var_4_0

		var_4_0.insert(arg_4_0.items, arg_4_1)
	end

	return
end

function var_0_0.Dequeue(arg_5_0)
	local var_5_0

	if #arg_5_0.items > 0 then
		table = var_2
		var_5_0 = var_2.remove(arg_5_0.items, 1)
	else
		var_5_0 = arg_5_0:NewItem()
	end

	return var_5_0
end

function var_0_0.Dispose(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.items) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_6_1)
	end

	arg_6_0.items = {}
	arg_6_0.prefab = nil

	return
end

return var_0_0
