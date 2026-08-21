local var_0_0 = class("OrderTplPool")

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
	return Object.Instantiate(arg_2_0.prefab)
end

function var_0_0.Init(arg_3_0)
	for iter_3_0 = 1, arg_3_0.initCnt do
		arg_3_0:Enqueue((arg_3_0:NewItem()))
	end

	return
end

function var_0_0.Enqueue(arg_4_0, arg_4_1)
	if #arg_4_0.items + 1 > arg_4_0.maxCnt then
		Object.Destroy(arg_4_1)
	else
		setParent(arg_4_1, arg_4_0.root)

		arg_4_1.transform.localPosition = Vector3.zero

		table.insert(arg_4_0.items, arg_4_1)
	end

	return
end

function var_0_0.Dequeue(arg_5_0)
	return #arg_5_0.items > 0 and table.remove(arg_5_0.items, 1) or arg_5_0:NewItem()
end

function var_0_0.Dispose(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.items) do
		Object.Destroy(iter_6_1)
	end

	arg_6_0.items = {}
	arg_6_0.prefab = nil

	return
end

return var_0_0
