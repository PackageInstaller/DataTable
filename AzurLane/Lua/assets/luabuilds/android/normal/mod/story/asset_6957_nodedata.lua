ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
ys = var_0_10001

local var_0_1

if not var_0_10001.Story then
	var_0_1 = {}
end

var_0.Story = var_0_1
ys = var_0

local var_0_2 = var_0.Story

class = var_0_1
var_0_2.NodeData = var_0_1("NodeData")
ys = var_0_2

local var_0_3 = var_0_2.Story.NodeData

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._data = arg_1_1 or {}
	arg_1_0._allSeq = {
		arg_1_2
	}

	return
end

function var_0_3.AddSeq(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0._allSeq, arg_2_1)

	return
end

function var_0_3.GetAllSeq(arg_3_0)
	return arg_3_0._allSeq
end

return
