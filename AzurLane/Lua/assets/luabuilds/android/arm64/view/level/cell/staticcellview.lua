local var_0_0 = class("StaticCellView", import("view.level.cell.LevelCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.parent = arg_1_1
	arg_1_0.go = nil
	arg_1_0.tf = nil
	arg_1_0.info = nil

	return
end

function var_0_0.PrepareBase(arg_2_0, arg_2_1)
	arg_2_0.go = GameObject.New(arg_2_1)

	arg_2_0.go:AddComponent(typeof(RectTransform))
	setParent(arg_2_0.go, arg_2_0.parent)

	arg_2_0.tf = tf(arg_2_0.go)
	arg_2_0.tf.sizeDelta = arg_2_0.parent.sizeDelta

	arg_2_0:OverrideCanvas()
	arg_2_0:ResetCanvasOrder()

	return
end

function var_0_0.DestroyGO(arg_3_0)
	if arg_3_0.loader then
		arg_3_0.loader:ClearRequests()
	end

	if not IsNil(arg_3_0.go) then
		Destroy(arg_3_0.go)

		arg_3_0.go = nil
		arg_3_0.tf = nil
	end

	return
end

function var_0_0.Update(arg_4_0)
	assert(false, "not implemented")

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0.parent = nil
	arg_5_0.info = nil

	arg_5_0:DestroyGO()

	return
end

return var_0_0
