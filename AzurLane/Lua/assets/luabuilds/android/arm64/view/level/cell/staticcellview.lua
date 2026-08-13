class = var_0_10000

local var_0_0 = "StaticCellView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.level.cell.LevelCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.parent = arg_1_1
	arg_1_0.go = nil
	arg_1_0.tf = nil
	arg_1_0.info = nil

	return
end

function var_0_1.PrepareBase(arg_2_0, arg_2_1)
	GameObject = var_1_10002
	arg_2_0.go = var_1_10002.New(arg_2_1)

	local var_2_0 = arg_2_0.go
	local var_2_1 = var_2.AddComponent

	typeof = var_1_10005
	RectTransform = var_1_10007

	var_2_1(var_2_0, var_1_10005(var_1_10007))

	setParent = var_2_1

	var_2_1(arg_2_0.go, arg_2_0.parent)

	tf = var_2_1
	arg_2_0.tf = var_2_1(arg_2_0.go)
	arg_2_0.tf.sizeDelta = arg_2_0.parent.sizeDelta

	arg_2_0:OverrideCanvas()
	arg_2_0:ResetCanvasOrder()

	return
end

function var_0_1.DestroyGO(arg_3_0)
	if arg_3_0.loader then
		local var_3_0 = arg_3_0.loader

		var_1.ClearRequests(var_3_0)
	end

	IsNil = var_1

	if not var_1(arg_3_0.go) then
		Destroy = var_1

		var_1(arg_3_0.go)

		arg_3_0.go = nil
		arg_3_0.tf = nil
	end

	return
end

function var_0_1.Update(arg_4_0)
	assert = var_1_10001

	var_1_10001(false, "not implemented")

	return
end

function var_0_1.Clear(arg_5_0)
	arg_5_0.parent = nil
	arg_5_0.info = nil

	arg_5_0:DestroyGO()

	return
end

return var_0_1
