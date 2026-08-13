ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
class = ys

local var_0_1 = var_0("ISeqNode")

ys = var_0_10001
var_0_10001.ISeqNode = var_0_1
var_0_1.Finish = false
var_0_1._init = false
var_0_1._data = nil
var_0_1._cfg = nil

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._data = arg_1_1
	arg_1_0._cfg = arg_1_2

	return
end

function var_0_1.UpdateNode(arg_2_0)
	if arg_2_0.Finish then
		return
	end

	if not arg_2_0._init then
		arg_2_0._init = true

		arg_2_0:Init()
	end

	if arg_2_0.Finish then
		return
	end

	arg_2_0:Update()

	return
end

function var_0_1.Init(arg_3_0)
	return
end

function var_0_1.Update(arg_4_0)
	return
end

function var_0_1.Dispose(arg_5_0)
	arg_5_0.Finish = true

	arg_5_0:Clear()

	return
end

function var_0_1.Clear(arg_6_0)
	return
end

return
