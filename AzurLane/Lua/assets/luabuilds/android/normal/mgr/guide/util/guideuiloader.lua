class = var_0_10000

local var_0_0 = var_0_10000("GuideUILoader")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1
	arg_1_0.caches = {}

	return
end

function var_0_0.Load(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:LoadRes(arg_2_1, arg_2_2)

	return
end

function var_0_0.LoadHighLightArea(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.name

	arg_3_0:Load(var_3_0, function(arg_4_0)
		if not arg_3_1 then
			return
		end

		local var_4_0 = arg_4_0.pivot
		local var_4_1 = arg_3_1.position

		Vector3 = var_2_10003
		arg_4_0.localPosition = var_4_1 + var_2_10003(var_4_0.x * arg_3_1.size.x, var_4_0.y * arg_3_1.size.y, 0)
		Vector2 = var_2
		arg_4_0.anchorMin = var_2(0.5, 0.5)
		Vector2 = var_2
		arg_4_0.anchorMax = var_2(0.5, 0.5)

		local var_4_2 = arg_3_1.size

		Vector2 = var_3
		arg_4_0.sizeDelta = var_4_2 + var_3.one * arg_3_1.length * 2

		return
	end)

	return
end

function var_0_0.LoadRes(arg_5_0, arg_5_1, arg_5_2)
	LoadAnyAsync = var_1_10003

	var_1_10003("guideitem/" .. arg_5_1, "", nil, function(arg_6_0)
		IsNil = var_2_10001

		if var_2_10001(arg_6_0) then
			return
		end

		Object = var_1

		local var_6_0 = var_1.Instantiate(arg_6_0, arg_5_0.root).transform

		table = var_2

		var_2.insert(arg_5_0.caches, var_6_0)

		if arg_5_2 then
			arg_5_2(var_6_0)
		end

		return
	end)

	return
end

function var_0_0.Clear(arg_7_0)
	if arg_7_0.caches and #arg_7_0.caches > 0 then
		ipairs = var_1

		for iter_7_0, iter_7_1 in var_1(arg_7_0.caches) do
			Object = var_1_10006

			var_1_10006.Destroy(iter_7_1.gameObject)
		end

		arg_7_0.caches = {}
	end

	return
end

return var_0_0
