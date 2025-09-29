module("framework.datastruct.StringBuffer", package.seeall)

local var_0_0 = class("StringBuffer")
local var_0_1 = "\r\n"

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._dataList = arg_1_1 and {
		arg_1_1
	} or nil
end

function var_0_0.append(arg_2_0, arg_2_1)
	if not arg_2_0._dataList then
		arg_2_0._dataList = {}
	end

	arg_2_0._dataList[#arg_2_0._dataList + 1] = arg_2_1

	return arg_2_0
end

function var_0_0.appendLine(arg_3_0)
	return arg_3_0:append(var_0_1)
end

function var_0_0.toString(arg_4_0, arg_4_1)
	if not arg_4_0._dataList then
		return ""
	end

	arg_4_1 = arg_4_1 or ""

	return table.concat(arg_4_0._dataList, arg_4_1, 1, #arg_4_0._dataList)
end

function var_0_0.clear(arg_5_0)
	arg_5_0._dataList = nil
end

return var_0_0
