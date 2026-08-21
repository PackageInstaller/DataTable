ys = ys or {}

local var_0_0 = class("BattleSceneObject")

ys.Battle.BattleSceneObject = var_0_0
var_0_0.__name = "BattleSceneObject"

function var_0_0.Ctor(arg_1_0)
	return
end

function var_0_0.GetGO(arg_2_0)
	return arg_2_0._go
end

function var_0_0.GetTf(arg_3_0)
	return arg_3_0._tf
end

function var_0_0.SetGO(arg_4_0, arg_4_1)
	arg_4_0._go = arg_4_1
	arg_4_0._tf = arg_4_1.transform

	return
end

function var_0_0.GetCldBoxSize(arg_5_0)
	assert(false, arg_5_0.__name .. ".GetCldBoxSize: this function should be override!!!")

	return
end

function var_0_0.GetCldBox(arg_6_0)
	assert(false, arg_6_0.__name .. ".GetCldBox: this function should be override!!!")

	return
end

function var_0_0.GetCldData(arg_7_0)
	assert(false, arg_7_0.__name .. ".GetCldData: this function should be override!!!")

	return
end

function var_0_0.GetGOPosition(arg_8_0)
	return arg_8_0._tf.localPosition
end

function var_0_0.CameraOrthogonal(arg_9_0, arg_9_1)
	arg_9_0._tf.localRotation = arg_9_1.transform.localRotation

	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0._tf = nil

	var_0.Battle.BattleResourceManager.GetInstance():DestroyOb(arg_10_0._go)

	arg_10_0._go = nil

	return
end

return
