ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Story

class = var_0_10001

local var_0_2 = "StorySleepNode"

ys = var_0_10003
var_0_1.StorySleepNode = var_0_10001(var_0_2, var_0_10003.ISeqNode)
ys = var_0_1

local var_0_3 = var_0_1.Story.StorySleepNode

pg = var_1

var_1.NodeMgr.RigisterNode("StorySleep", var_0_3)

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._time = arg_1_2[2]

	return
end

function var_0_3.Init(arg_2_0)
	os = var_1_10001
	arg_2_0._end = var_1_10001.time() + arg_2_0._time

	return
end

function var_0_3.Update(arg_3_0)
	os = var_1_10001

	if var_1_10001.time() >= arg_3_0._end then
		arg_3_0:Dispose()
	end

	return
end

return
