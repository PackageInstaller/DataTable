class = var_0_10000

local var_0_0 = var_0_10000("SpineCellView")

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.InitCellTransform(arg_2_0)
	local var_2_0 = arg_2_0.tf

	arg_2_0.tfShip = var_1.Find(var_2_0, "ship")

	local var_2_1 = arg_2_0.tf

	arg_2_0.tfShadow = var_1.Find(var_2_1, "shadow")

	return
end

function var_0_0.GetRotatePivot(arg_3_0)
	return arg_3_0.tfShip
end

function var_0_0.GetAction(arg_4_0)
	return arg_4_0.action
end

function var_0_0.SetAction(arg_5_0, arg_5_1)
	arg_5_0.action = arg_5_1

	if arg_5_0.spineRole then
		local var_5_0 = arg_5_0.spineRole

		var_2.SetAction(var_5_0, arg_5_1)
	end

	return
end

function var_0_0.GetSpineRole(arg_6_0)
	return arg_6_0.spineRole
end

function var_0_0.LoadSpine(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0.lastPrefab == arg_7_1 then
		local var_7_0 = arg_7_0.spineRole

		if var_5.CheckInited(var_7_0) then
			existCall = var_5

			var_5(arg_7_4)
		end

		return
	end

	arg_7_0.UnloadSpine(arg_7_0)

	arg_7_0.lastPrefab = arg_7_1
	SpineRole = var_5
	arg_7_0.spineRole = var_5.New()

	local var_7_1 = arg_7_0.spineRole

	var_5.SetData(var_7_1, arg_7_1, arg_7_3)

	local var_7_2 = arg_7_0.spineRole

	var_5.Load(var_7_2, function()
		local var_8_0 = arg_7_0.spineRole

		var_0.SetParent(var_8_0, arg_7_0.tfShip)

		local var_8_1 = arg_7_0.spineRole

		var_0.SetRaycastTarget(var_8_1, false)

		local var_8_2 = arg_7_0.spineRole
		local var_8_3 = var_0.SetLocalPosition

		Vector3 = var_3

		var_8_3(var_8_2, var_3.zero)

		local var_8_4

		if not arg_7_2 or not (arg_7_2 * 0.01) then
			var_8_4 = 1
		end

		arg_7_2 = var_8_4

		local var_8_5 = arg_7_0.spineRole
		local var_8_6 = var_0.SetLocalScale

		Vector3 = var_3

		var_8_6(var_8_5, var_3(0.4 * arg_7_2, 0.4 * arg_7_2, 1))

		local var_8_7 = arg_7_0
		local var_8_8 = var_0.SetAction
		local var_8_9 = arg_7_0

		var_8_8(var_8_7, var_3.GetAction(var_8_9))

		existCall = var_8_8

		var_8_8(arg_7_4)

		return
	end, nil, arg_7_0.spineRole.ORBIT_KEY_SLG)

	return
end

function var_0_0.UnloadSpine(arg_9_0)
	arg_9_0.lastPrefab = nil

	if arg_9_0.spineRole then
		local var_9_0 = arg_9_0.spineRole

		var_1.Dispose(var_9_0)

		arg_9_0.spineRole = nil
	end

	return
end

function var_0_0.UpdateSortingOrder(arg_10_0)
	GetComponent = var_1_10001

	local var_10_0 = arg_10_0.tf

	typeof = var_1_10004
	Canvas = var_1_10006

	local var_10_1 = var_1_10001(var_10_0, var_1_10004(var_1_10006)).sortingOrder

	return
end

function var_0_0.SetSpineVisible(arg_11_0, arg_11_1)
	if arg_11_0.spineRole then
		local var_11_0 = arg_11_0.spineRole

		var_2.SetVisible(var_11_0, arg_11_1)
	end

	return
end

function var_0_0.ClearSpine(arg_12_0)
	arg_12_0.UnloadSpine(arg_12_0)

	return
end

return var_0_0
