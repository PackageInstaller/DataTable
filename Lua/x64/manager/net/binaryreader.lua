import("bit")

local var_0_0 = class("BinaryReader")

function var_0_0.Initialize(arg_1_0, arg_1_1)
	arg_1_0.index_ = 1
	arg_1_0.data_ = arg_1_1
	arg_1_0.binaryArray_ = {}

	arg_1_0:ToBinaryArray()
end

function var_0_0.EOF(arg_2_0)
	return string.byte(arg_2_0.data_, arg_2_0.index_) == nil
end

function var_0_0.ToBinaryArray(arg_3_0)
	local var_3_0 = #arg_3_0.data_

	for iter_3_0 = 1, var_3_0 do
		arg_3_0.binaryArray_[iter_3_0] = string.byte(arg_3_0.data_, iter_3_0)
	end
end

function var_0_0.Read(arg_4_0, arg_4_1)
	local var_4_0 = string.byte(arg_4_0.data_, arg_4_0.index_)

	if var_4_0 == nil then
		return 0
	end

	for iter_4_0 = arg_4_0.index_ + 1, arg_4_0.index_ + arg_4_1 - 1 do
		local var_4_1 = string.byte(arg_4_0.data_, iter_4_0)
		local var_4_2 = bit.lshift(var_4_0, 8)

		var_4_0 = bit.bor(var_4_2, var_4_1)
	end

	arg_4_0.index_ = arg_4_0.index_ + arg_4_1

	return var_4_0
end

return var_0_0
