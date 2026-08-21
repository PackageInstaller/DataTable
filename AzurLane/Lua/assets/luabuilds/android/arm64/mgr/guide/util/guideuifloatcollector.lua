local var_0_0 = class("GuideUIFloatCollector")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1
	arg_1_0.caches = {}

	return
end

function var_0_0.SetFloat(arg_2_0, arg_2_1)
	setParent(arg_2_1, arg_2_0.root, true)

	arg_2_1.localPosition = Vector3.New(arg_2_1.localPosition.x, arg_2_1.localPosition.y, 0)

	table.insert(arg_2_0.caches, {
		parent = arg_2_1.parent,
		tr = arg_2_1
	})

	return
end

function var_0_0.Clear(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.caches) do
		setParent(iter_3_1.tr, iter_3_1.parent, true)

		iter_3_1.tr.localPosition = Vector3.New(iter_3_1.tr.localPosition.x, iter_3_1.tr.localPosition.y, 0)
	end

	arg_3_0.caches = {}

	return
end

return var_0_0
