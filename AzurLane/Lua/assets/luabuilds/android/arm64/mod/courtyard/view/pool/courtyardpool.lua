class = var_0_10000

local var_0_0 = var_0_10000("CourtYardPool")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.prefab = arg_1_2
	arg_1_0.parentTF = arg_1_1
	GetOrAddComponent = var_1_10005

	local var_1_0 = arg_1_0.prefab

	typeof = var_1_10008
	CanvasGroup = var_1_10010

	var_1_10005(var_1_0, var_1_10008(var_1_10010))

	local var_1_1 = arg_1_0.prefab.transform

	var_5.SetParent(var_1_1, arg_1_0.parentTF, false)

	arg_1_0.layer = arg_1_0.parentTF.gameObject.layer
	arg_1_0.items = {}
	arg_1_0.max = arg_1_4
	arg_1_0.initCnt = arg_1_3

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	for iter_2_0 = 1, arg_2_0.initCnt do
		arg_2_0:NewItem()
	end

	return
end

function var_0_0.Enqueue(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_0.items

	if arg_3_0.max <= var_3_0 then
		Object = var_3_0

		var_3_0.Destroy(arg_3_1)
	else
		local var_3_1 = arg_3_1.transform

		Vector3 = var_3
		var_3_1.localPosition = var_3.one
		setActiveViaLayer = var_3_1

		var_3_1(arg_3_1.transform, false)

		local var_3_2 = arg_3_1.transform

		var_2.SetParent(var_3_2, arg_3_0.parentTF, true)

		table = var_2

		var_2.insert(arg_3_0.items, arg_3_1)
	end

	return
end

function var_0_0.Dequeue(arg_4_0)
	if #arg_4_0.items <= 0 then
		arg_4_0:NewItem()
	end

	table = var_1

	local var_4_0 = var_1.remove(arg_4_0.items, 1)

	setActiveViaLayer = var_2

	var_2(var_4_0.transform, true)

	return var_4_0
end

function var_0_0.NewItem(arg_5_0)
	Object = var_1_10001

	local var_5_0 = var_1_10001.Instantiate(arg_5_0.prefab).transform

	Vector3 = var_3
	var_5_0.localScale = var_3.one

	arg_5_0:Enqueue(var_1)

	return
end

function var_0_0.Dispose(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.items) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_6_1)
	end

	arg_6_0.items = nil
	arg_6_0.prefab = nil

	return
end

return var_0_0
