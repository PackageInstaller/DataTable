local var_0_0 = class("ValentineQteGamePoolMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.tpl = arg_1_1
	arg_1_0.initCnt = arg_1_2
	arg_1_0.maxCnt = arg_1_3
	arg_1_0.items = {}

	setActive(arg_1_0.tpl, false)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	for iter_2_0 = 1, arg_2_0.initCnt do
		table.insert(arg_2_0.items, (arg_2_0:NewItem()))
	end

	return
end

function var_0_0.NewItem(arg_3_0)
	local var_3_0 = Instantiate(arg_3_0.tpl)

	SetParent(var_3_0, arg_3_0.tpl.transform.parent)

	return var_3_0
end

function var_0_0.Dequeue(arg_4_0)
	local var_4_0 = #arg_4_0.items > 0 and table.remove(arg_4_0.items, 1) or arg_4_0:NewItem()

	setActive(var_4_0, true)

	return var_4_0
end

function var_0_0.Enqueue(arg_5_0, arg_5_1)
	if #arg_5_0.items >= arg_5_0.maxCnt then
		arg_5_0:DestroyItem(arg_5_1)
	else
		setActive(arg_5_1, false)
		SetParent(arg_5_1, arg_5_0.tpl.transform.parent)
		table.insert(arg_5_0.items, arg_5_1.gameObject)
	end

	return
end

function var_0_0.DestroyItem(arg_6_0, arg_6_1)
	Object.Destroy(go(arg_6_1))

	return
end

function var_0_0.Destroy(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.items) do
		arg_7_0:DestroyItem(iter_7_1)
	end

	arg_7_0.items = nil

	return
end

return var_0_0
