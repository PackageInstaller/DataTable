module("framework.datastruct.ViewStack", package.seeall)

local var_0_0 = class("ViewStack", Stack)

function var_0_0.removeByIndex(arg_1_0, arg_1_1)
	table.remove(arg_1_0._stack, arg_1_1)
end

function var_0_0.findByValue(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1 = arg_2_0:getSize()
	local var_2_2 = false

	if arg_2_2 then
		for iter_2_0 = var_2_1, 1, -1 do
			var_2_2 = arg_2_0._stack[iter_2_0]

			if arg_2_2(var_2_2, arg_2_1) then
				var_2_0 = iter_2_0

				break
			end
		end
	else
		for iter_2_1 = arg_2_0:getSize(), 1, -1 do
			var_2_2 = arg_2_0._stack[iter_2_1]

			if var_2_2 == arg_2_1 then
				var_2_0 = iter_2_1

				break
			end
		end
	end

	return var_2_0, var_2_2
end

function var_0_0.getDataByIndex(arg_3_0, arg_3_1)
	return arg_3_0._stack[arg_3_1]
end

function var_0_0.removeAllUntilIndex(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getSize()

	if arg_4_1 <= var_4_0 then
		for iter_4_0 = var_4_0, arg_4_1, -1 do
			arg_4_0:removeByIndex(iter_4_0)
		end
	end
end

function var_0_0.removeBetweenIndex(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0 = arg_5_2, arg_5_1, -1 do
		arg_5_0:removeByIndex(iter_5_0)
	end
end

function var_0_0.removeByValue(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0, var_6_1 = arg_6_0:findByValue(arg_6_1, arg_6_2)

	if var_6_0 then
		arg_6_0:removeByIndex(var_6_0)
	end
end

function var_0_0.removeUpByValue(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0, var_7_1 = arg_7_0:findByValue(arg_7_1, arg_7_2)

	if var_7_0 then
		arg_7_0:removeAllUntilIndex(var_7_0)
	end
end

function var_0_0.cloneBetweenData(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0 = arg_8_1, arg_8_2 do
		table.insert(var_8_0, arg_8_0:getDataByIndex(iter_8_0))
	end

	return var_8_0
end

function var_0_0.printStack(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._stack) do
		dump(iter_9_1, iter_9_0)
	end
end

return var_0_0
