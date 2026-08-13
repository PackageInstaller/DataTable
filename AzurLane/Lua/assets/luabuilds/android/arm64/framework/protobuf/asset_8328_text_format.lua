string = var_0_10000
math = var_0_10001
print = var_0_10002
getmetatable = var_0_10003
table = var_0_10004
ipairs = var_0_10005
tostring = var_0_10006
require = var_0_10007

local var_0_0 = var_0_10007("descriptor")

module = var_0_10008

var_0_10008("text_format")

local function var_0_1(arg_1_0)
	local var_1_0 = var_0_10000.len(arg_1_0)

	for iter_1_0 = 1, var_1_0, 16 do
		local var_1_1 = ""

		for iter_1_1 = iter_1_0, var_0_10001.min(iter_1_0 + 16 - 1, var_1_0) do
			var_1_1 = var_0_10000.format("%s  %02x", var_1_1, var_0_10000.byte(arg_1_0, iter_1_1))
		end

		var_0_10002(var_1_1)
	end

	return
end

local var_0_2 = format
local var_0_3 = var_0_0.FieldDescriptor

local function var_0_4(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in arg_2_1:ListFields() do
		local function var_2_0(arg_3_0)
			local var_3_0 = iter_2_0.name

			arg_2_0(var_0_10000.rep(" ", arg_2_2))

			if iter_2_0.type == var_0_3.TYPE_MESSAGE then
				if var_0_10003(arg_2_1)._extensions_by_name[iter_2_0.full_name] then
					arg_2_0("[" .. var_3_0 .. "] {\n")
				else
					arg_2_0(var_3_0 .. " {\n")
				end

				msg_format_indent = var_3

				var_3(arg_2_0, arg_3_0, arg_2_2 + 4)
				arg_2_0(var_0_10000.rep(" ", arg_2_2))
				arg_2_0("}\n")
			else
				arg_2_0(var_0_10000.format("%s: %s\n", var_3_0, var_0_10006(arg_3_0)))
			end

			return
		end

		if iter_2_0.label == var_0_3.LABEL_REPEATED then
			for iter_2_2, iter_2_3 in var_0_10005(iter_2_1) do
				var_2_0(iter_2_3)
			end
		else
			var_2_0(iter_2_1)
		end
	end

	return
end

local var_0_5 = msg_format_indent

local function var_0_6(arg_4_0)
	local var_4_0 = {}

	local function var_4_1(arg_5_0)
		var_4_0[#var_4_0 + 1] = arg_5_0

		return
	end

	msg_format_indent = var_1_10003

	var_1_10003(var_4_1, arg_4_0, 0)

	return var_0_10004.concat(var_4_0)
end

local var_0_7 = msg_format

return
