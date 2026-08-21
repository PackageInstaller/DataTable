local var_0_0 = class("GuideUILoader")

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
	arg_3_0:Load(arg_3_1.name, function(arg_4_0)
		if not arg_3_1 then
			return
		end

		arg_4_0.localPosition = arg_3_1.position + Vector3(arg_4_0.pivot.x * arg_3_1.size.x, arg_4_0.pivot.y * arg_3_1.size.y, 0)
		arg_4_0.anchorMin = Vector2(0.5, 0.5)
		arg_4_0.anchorMax = Vector2(0.5, 0.5)
		arg_4_0.sizeDelta = arg_3_1.size + Vector2.one * arg_3_1.length * 2

		return
	end)

	return
end

function var_0_0.LoadRes(arg_5_0, arg_5_1, arg_5_2)
	LoadAnyAsync("guideitem/" .. arg_5_1, "", nil, function(arg_6_0)
		if IsNil(arg_6_0) then
			return
		end

		local var_6_0 = Object.Instantiate(arg_6_0, arg_5_0.root).transform

		table.insert(arg_5_0.caches, var_6_0)

		if arg_5_2 then
			arg_5_2(var_6_0)
		end

		return
	end)

	return
end

function var_0_0.Clear(arg_7_0)
	if arg_7_0.caches and #arg_7_0.caches > 0 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.caches) do
			Object.Destroy(iter_7_1.gameObject)
		end

		arg_7_0.caches = {}
	end

	return
end

return var_0_0
