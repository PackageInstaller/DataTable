module("framework.pathfinding.astar.UHeap", package.seeall)

local var_0_0 = class("UHeap")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	local function var_1_0(arg_2_0, arg_2_1)
		return true
	end

	local function var_1_1(arg_3_0, arg_3_1)
		return
	end

	arg_1_0._funcPred = arg_1_1 or var_1_0
	arg_1_0._funcMove = arg_1_2 or var_1_1
	arg_1_0._arrayElems = {}
end

function var_0_0.swap(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0._arrayElems[arg_4_1]
	local var_4_1 = arg_4_0._arrayElems[arg_4_2]

	arg_4_0._arrayElems[arg_4_1] = var_4_1
	arg_4_0._arrayElems[arg_4_2] = var_4_0

	arg_4_0._funcMove(var_4_0, arg_4_2)
	arg_4_0._funcMove(var_4_1, arg_4_1)
end

function var_0_0.sink(arg_5_0, arg_5_1)
	local var_5_0 = #arg_5_0._arrayElems
	local var_5_1 = arg_5_1

	while true do
		local var_5_2 = var_5_1 * 2
		local var_5_3 = var_5_2 + 1

		if var_5_0 < var_5_2 then
			return
		end

		local var_5_4 = var_5_1
		local var_5_5 = var_5_2
		local var_5_6 = arg_5_0._arrayElems[var_5_4]
		local var_5_7 = arg_5_0._arrayElems[var_5_5]

		if var_5_0 < var_5_3 then
			if arg_5_0._funcPred(var_5_7, var_5_6) then
				arg_5_0:swap(var_5_4, var_5_5)
			end

			var_5_1 = var_5_2
		else
			local var_5_8 = arg_5_0._arrayElems[var_5_3]

			if arg_5_0._funcPred(var_5_7, var_5_8) and arg_5_0._funcPred(var_5_7, var_5_6) then
				arg_5_0:swap(var_5_4, var_5_5)

				var_5_1 = var_5_2
			elseif arg_5_0._funcPred(var_5_8, var_5_6) then
				arg_5_0:swap(var_5_4, var_5_3)

				var_5_1 = var_5_3
			else
				return
			end
		end
	end
end

function var_0_0.rise(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1

	while true do
		local var_6_1 = math.floor(var_6_0 / 2)

		if var_6_1 == 0 then
			return
		end

		local var_6_2 = arg_6_0._arrayElems[var_6_1]
		local var_6_3 = arg_6_0._arrayElems[var_6_0]

		if arg_6_0._funcPred(var_6_3, var_6_2) then
			arg_6_0:swap(var_6_1, var_6_0)
		end

		var_6_0 = var_6_1
	end
end

function var_0_0.push(arg_7_0, arg_7_1)
	table.insert(arg_7_0._arrayElems, arg_7_1)

	local var_7_0 = #arg_7_0._arrayElems

	arg_7_0._funcMove(arg_7_1, var_7_0)
	arg_7_0:rise(var_7_0)
end

function var_0_0.empty(arg_8_0)
	return #arg_8_0._arrayElems == 0
end

function var_0_0.contains(arg_9_0, arg_9_1)
	if table.indexof(arg_9_0._arrayElems, arg_9_1) then
		return true
	end

	return false
end

function var_0_0.top(arg_10_0)
	return arg_10_0._arrayElems[1]
end

function var_0_0.pop(arg_11_0)
	if arg_11_0:empty() then
		return
	end

	local var_11_0 = #arg_11_0._arrayElems
	local var_11_1 = arg_11_0._arrayElems[var_11_0]

	arg_11_0._arrayElems[1] = var_11_1

	arg_11_0._funcMove(var_11_1, 1)
	table.remove(arg_11_0._arrayElems, var_11_0)
	arg_11_0:sink(1)
end

function var_0_0.clear(arg_12_0)
	arg_12_0._arrayElems = {}
end

function var_0_0.size(arg_13_0)
	return #arg_13_0._arrayElems
end

return var_0_0
