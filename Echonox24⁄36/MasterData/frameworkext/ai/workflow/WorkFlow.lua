module("frameworkext.ai.workflow.WorkFlow", package.seeall)

local var_0_0 = class("WorkFlow", FlowSingle)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.currentWork = arg_1_0
	arg_1_0._guid = 0
	arg_1_0._isInitWorkflow = false
end

function var_0_0.start(arg_2_0, arg_2_1)
	arg_2_0:_initWorkflow()

	arg_2_0.currentWork = arg_2_0

	arg_2_0.currentWork:onStart(arg_2_1)
end

function var_0_0.stop(arg_3_0)
	if arg_3_0.status == WorkStatus.Running then
		arg_3_0:onInterrupt()
	end
end

function var_0_0.enterWork(arg_4_0, arg_4_1)
	arg_4_0.currentWork = arg_4_1
end

function var_0_0._initWorkflow(arg_5_0)
	if arg_5_0._isInitWorkflow then
		return
	end

	arg_5_0:_initChildWork(arg_5_0, arg_5_0)

	arg_5_0._isInitWorkflow = true
end

function var_0_0._initChildWork(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1.workflow = arg_6_2

	if arg_6_1.id == nil then
		arg_6_1.id = arg_6_0:_getNextGuid()
	end

	local var_6_0 = arg_6_1:getChildren()

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			arg_6_0:_initChildWork(iter_6_1, arg_6_2)
		end
	end
end

function var_0_0._getNextGuid(arg_7_0)
	local var_7_0 = arg_7_0._guid + 1

	arg_7_0._guid = var_7_0

	return var_7_0
end

function var_0_0.serialize(arg_8_0)
	arg_8_0:_initWorkflow()

	local var_8_0 = var_0_0.super.serialize(arg_8_0)

	var_8_0.currentWorkId = arg_8_0.currentWork.id

	local var_8_1 = {
		[arg_8_0.id] = var_8_0
	}

	arg_8_0:_childSerialize(arg_8_0._child, var_8_1)

	return require("cjson").encode(var_8_1)
end

function var_0_0._childSerialize(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:serialize()

	if var_9_0 then
		arg_9_2[arg_9_1.id] = var_9_0
	end

	local var_9_1 = arg_9_1:getChildren()

	if var_9_1 then
		for iter_9_0, iter_9_1 in ipairs(var_9_1) do
			arg_9_0:_childSerialize(iter_9_1, arg_9_2)
		end
	end
end

function var_0_0.deserialize(arg_10_0, arg_10_1)
	arg_10_0:_initWorkflow()

	local var_10_0 = require("cjson").decode(arg_10_1)
	local var_10_1 = var_10_0[arg_10_0.id]

	var_0_0.super.deserialize(arg_10_0, var_10_1)
	arg_10_0:_childDeserialize(arg_10_0._child, var_10_0, var_10_1.currentWorkId)
end

function var_0_0._childDeserialize(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_1.id == arg_11_3 then
		arg_11_0.currentWork = arg_11_1
	end

	local var_11_0 = arg_11_2[arg_11_1.id]

	if var_11_0 then
		arg_11_1:deserialize(var_11_0)
	end

	local var_11_1 = arg_11_1:getChildren()

	if var_11_1 then
		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			arg_11_0:_childDeserialize(iter_11_1, arg_11_2, arg_11_3)
		end
	end
end

function var_0_0.destroy(arg_12_0)
	if arg_12_0.status == WorkStatus.Running then
		arg_12_0:onInterrupt()
	end

	arg_12_0._isInitWorkflow = true
	arg_12_0.currentWork = nil
	arg_12_0._guid = 0

	arg_12_0:onDestroy()
end

return var_0_0
