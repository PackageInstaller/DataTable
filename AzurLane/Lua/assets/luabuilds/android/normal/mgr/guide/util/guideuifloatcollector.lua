class = var_0_10000

local var_0_0 = var_0_10000("GuideUIFloatCollector")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1
	arg_1_0.caches = {}

	return
end

function var_0_0.SetFloat(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.parent

	setParent = var_1_10003

	var_1_10003(arg_2_1, arg_2_0.root, true)

	Vector3 = var_1_10003
	arg_2_1.localPosition = var_1_10003.New(arg_2_1.localPosition.x, arg_2_1.localPosition.y, 0)
	table = var_3

	var_3.insert(arg_2_0.caches, {
		parent = var_2_0,
		tr = arg_2_1
	})

	return
end

function var_0_0.Clear(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.caches) do
		local var_3_0 = iter_3_1.parent
		local var_3_1 = iter_3_1.tr

		setParent = var_1_10008

		var_1_10008(var_3_1, var_3_0, true)

		Vector3 = var_1_10008
		var_3_1.localPosition = var_1_10008.New(var_3_1.localPosition.x, var_3_1.localPosition.y, 0)
	end

	arg_3_0.caches = {}

	return
end

return var_0_0
