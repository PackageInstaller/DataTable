local var_0_0 = string
local var_0_1 = table
local var_0_2 = ipairs
local var_0_3 = assert
local var_0_4 = uint64
local var_0_5 = type
local var_0_6 = require("pb")
local var_0_7 = require("wire_format")

module("encoder")

function _VarintSize(arg_1_0)
	if arg_1_0 <= 127 then
		return 1
	end

	if arg_1_0 <= 16383 then
		return 2
	end

	if arg_1_0 <= 2097151 then
		return 3
	end

	if arg_1_0 <= 268435455 then
		return 4
	end

	return 5
end

function _SignedVarintSize(arg_2_0)
	if arg_2_0 < 0 then
		return 10
	end

	if arg_2_0 <= 127 then
		return 1
	end

	if arg_2_0 <= 16383 then
		return 2
	end

	if arg_2_0 <= 2097151 then
		return 3
	end

	if arg_2_0 <= 268435455 then
		return 4
	end

	return 5
end

function _VarintSize64(arg_3_0)
	local var_3_0 = 0
	local var_3_1 = 0

	if var_0_5(arg_3_0) == "number" then
		var_3_1 = arg_3_0
	else
		var_3_1, var_3_0 = var_0_4.new(arg_3_0):tonum2()
	end

	if var_3_0 == 0 then
		if var_3_1 <= 127 then
			return 1
		end

		if var_3_1 <= 16383 then
			return 2
		end

		if var_3_1 <= 2097151 then
			return 3
		end

		if var_3_1 <= 268435455 then
			return 4
		end

		return 5
	else
		if var_3_0 <= 7 then
			return 5
		end

		if var_3_0 <= 1023 then
			return 6
		end

		if var_3_0 <= 131071 then
			return 7
		end

		if var_3_0 <= 16777215 then
			return 8
		end

		if var_3_0 <= 2147483647 then
			return 9
		end

		return 10
	end
end

function _SignedVarintSize64(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = 0

	if var_0_5(arg_4_0) == "number" then
		var_4_2 = arg_4_0
		var_4_0 = arg_4_0 < 0 and 1 or 0
	else
		var_4_2, var_4_1 = int64.new(arg_4_0):tonum2()
		var_4_0 = var_4_1 > 2147483647 and 1 or 0
	end

	if var_4_0 == 1 then
		return 10
	end

	if var_4_1 == 0 then
		if var_4_2 <= 127 then
			return 1
		end

		if var_4_2 <= 16383 then
			return 2
		end

		if var_4_2 <= 2097151 then
			return 3
		end

		if var_4_2 <= 268435455 then
			return 4
		end

		return 5
	else
		if var_4_1 <= 7 then
			return 5
		end

		if var_4_1 <= 1023 then
			return 6
		end

		if var_4_1 <= 131071 then
			return 7
		end

		if var_4_1 <= 16777215 then
			return 8
		end

		if var_4_1 <= 2147483647 then
			return 9
		end

		return 10
	end
end

function _TagSize(arg_5_0)
	return _VarintSize(var_0_7.PackTag(arg_5_0, 0))
end

function _SimpleSizer(arg_6_0)
	return function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = _TagSize(arg_7_0)

		if arg_7_2 then
			local var_7_1 = _VarintSize

			return function(arg_8_0)
				local var_8_0 = 0

				for iter_8_0, iter_8_1 in var_0_2(arg_8_0) do
					var_8_0 = var_8_0 + arg_6_0(iter_8_1)
				end

				return var_8_0 + var_7_1(var_8_0) + var_7_0
			end
		elseif arg_7_1 then
			return function(arg_9_0)
				local var_9_0 = var_7_0 * #arg_9_0

				for iter_9_0, iter_9_1 in var_0_2(arg_9_0) do
					var_9_0 = var_9_0 + arg_6_0(iter_9_1)
				end

				return var_9_0
			end
		else
			return function(arg_10_0)
				return var_7_0 + arg_6_0(arg_10_0)
			end
		end
	end
end

function _ModifiedSizer(arg_11_0, arg_11_1)
	return function(arg_12_0, arg_12_1, arg_12_2)
		local var_12_0 = _TagSize(arg_12_0)

		if arg_12_2 then
			local var_12_1 = _VarintSize

			return function(arg_13_0)
				local var_13_0 = 0

				for iter_13_0, iter_13_1 in var_0_2(arg_13_0) do
					var_13_0 = var_13_0 + arg_11_0(arg_11_1(iter_13_1))
				end

				return var_13_0 + var_12_1(var_13_0) + var_12_0
			end
		elseif arg_12_1 then
			return function(arg_14_0)
				local var_14_0 = var_12_0 * #arg_14_0

				for iter_14_0, iter_14_1 in var_0_2(arg_14_0) do
					var_14_0 = var_14_0 + arg_11_0(arg_11_1(iter_14_1))
				end

				return var_14_0
			end
		else
			return function(arg_15_0)
				return var_12_0 + arg_11_0(arg_11_1(arg_15_0))
			end
		end
	end
end

function _FixedSizer(arg_16_0)
	return function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = _TagSize(arg_17_0)

		if arg_17_2 then
			local var_17_1 = _VarintSize

			return function(arg_18_0)
				local var_18_0 = #arg_18_0 * arg_16_0

				return var_18_0 + var_17_1(var_18_0) + var_17_0
			end
		elseif arg_17_1 then
			local var_17_2 = arg_16_0 + var_17_0

			return function(arg_19_0)
				return #arg_19_0 * var_17_2
			end
		else
			local var_17_3 = arg_16_0 + var_17_0

			return function(arg_20_0)
				return var_17_3
			end
		end
	end
end

Int32Sizer = _SimpleSizer(_SignedVarintSize)
Int64Sizer = _SimpleSizer(_SignedVarintSize64)
EnumSizer = Int32Sizer
UInt32Sizer = _SimpleSizer(_VarintSize)
UInt64Sizer = _SimpleSizer(_VarintSize64)
SInt32Sizer = _ModifiedSizer(_VarintSize, var_0_7.ZigZagEncode32)
SInt64Sizer = _ModifiedSizer(_VarintSize64, var_0_7.ZigZagEncode32)
Fixed32Sizer = _FixedSizer(4)
SFixed32Sizer = Fixed32Sizer
FloatSizer = Fixed32Sizer
Fixed64Sizer = _FixedSizer(8)
SFixed64Sizer = Fixed64Sizer
DoubleSizer = Fixed64Sizer
BoolSizer = _FixedSizer(1)

function StringSizer(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = _TagSize(arg_21_0)
	local var_21_1 = _VarintSize

	if arg_21_1 then
		return function(arg_22_0)
			local var_22_0 = var_21_0 * #arg_22_0

			for iter_22_0, iter_22_1 in var_0_2(arg_22_0) do
				local var_22_1 = #iter_22_1

				var_22_0 = var_22_0 + var_21_1(var_22_1) + var_22_1
			end

			return var_22_0
		end
	else
		return function(arg_23_0)
			local var_23_0 = #arg_23_0

			return var_21_0 + var_21_1(var_23_0) + var_23_0
		end
	end
end

function BytesSizer(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = _TagSize(arg_24_0)
	local var_24_1 = _VarintSize

	if arg_24_1 then
		return function(arg_25_0)
			local var_25_0 = var_24_0 * #arg_25_0

			for iter_25_0, iter_25_1 in var_0_2(arg_25_0) do
				local var_25_1 = #iter_25_1

				var_25_0 = var_25_0 + var_24_1(var_25_1) + var_25_1
			end

			return var_25_0
		end
	else
		return function(arg_26_0)
			local var_26_0 = #arg_26_0

			return var_24_0 + var_24_1(var_26_0) + var_26_0
		end
	end
end

function MessageSizer(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = _TagSize(arg_27_0)
	local var_27_1 = _VarintSize

	if arg_27_1 then
		return function(arg_28_0)
			local var_28_0 = var_27_0 * #arg_28_0

			for iter_28_0, iter_28_1 in var_0_2(arg_28_0) do
				local var_28_1 = iter_28_1:ByteSize()

				var_28_0 = var_28_0 + var_27_1(var_28_1) + var_28_1
			end

			return var_28_0
		end
	else
		return function(arg_29_0)
			local var_29_0 = arg_29_0:ByteSize()

			return var_27_0 + var_27_1(var_29_0) + var_29_0
		end
	end
end

local var_0_8 = var_0_6.varint_encoder
local var_0_9 = var_0_6.signed_varint_encoder
local var_0_10 = var_0_6.varint_encoder64
local var_0_11 = var_0_6.signed_varint_encoder64

function _VarintBytes(arg_30_0)
	local var_30_0 = {}

	local function var_30_1(arg_31_0)
		var_30_0[#var_30_0 + 1] = arg_31_0
	end

	var_0_9(var_30_1, arg_30_0)

	return var_0_1.concat(var_30_0)
end

function TagBytes(arg_32_0, arg_32_1)
	return _VarintBytes(var_0_7.PackTag(arg_32_0, arg_32_1))
end

function _SimpleEncoder(arg_33_0, arg_33_1, arg_33_2)
	return function(arg_34_0, arg_34_1, arg_34_2)
		if arg_34_2 then
			local var_34_0 = TagBytes(arg_34_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
			local var_34_1 = var_0_8

			return function(arg_35_0, arg_35_1)
				arg_35_0(var_34_0)

				local var_35_0 = 0

				for iter_35_0, iter_35_1 in var_0_2(arg_35_1) do
					var_35_0 = var_35_0 + arg_33_2(iter_35_1)
				end

				var_34_1(arg_35_0, var_35_0)

				for iter_35_2 in arg_35_1 do
					arg_33_1(arg_35_0, iter_35_2)
				end
			end
		elseif arg_34_1 then
			local var_34_2 = TagBytes(arg_34_0, arg_33_0)

			return function(arg_36_0, arg_36_1)
				for iter_36_0, iter_36_1 in var_0_2(arg_36_1) do
					arg_36_0(var_34_2)
					arg_33_1(arg_36_0, iter_36_1)
				end
			end
		else
			local var_34_3 = TagBytes(arg_34_0, arg_33_0)

			return function(arg_37_0, arg_37_1)
				arg_37_0(var_34_3)
				arg_33_1(arg_37_0, arg_37_1)
			end
		end
	end
end

function _ModifiedEncoder(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	return function(arg_39_0, arg_39_1, arg_39_2)
		if arg_39_2 then
			local var_39_0 = TagBytes(arg_39_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
			local var_39_1 = var_0_8

			return function(arg_40_0, arg_40_1)
				arg_40_0(var_39_0)

				local var_40_0 = 0

				for iter_40_0, iter_40_1 in var_0_2(arg_40_1) do
					var_40_0 = var_40_0 + arg_38_2(arg_38_3(iter_40_1))
				end

				var_39_1(arg_40_0, var_40_0)

				for iter_40_2, iter_40_3 in var_0_2(arg_40_1) do
					arg_38_1(arg_40_0, arg_38_3(iter_40_3))
				end
			end
		elseif arg_39_1 then
			local var_39_2 = TagBytes(arg_39_0, arg_38_0)

			return function(arg_41_0, arg_41_1)
				for iter_41_0, iter_41_1 in var_0_2(arg_41_1) do
					arg_41_0(var_39_2)
					arg_38_1(arg_41_0, arg_38_3(iter_41_1))
				end
			end
		else
			local var_39_3 = TagBytes(arg_39_0, arg_38_0)

			return function(arg_42_0, arg_42_1)
				arg_42_0(var_39_3)
				arg_38_1(arg_42_0, arg_38_3(arg_42_1))
			end
		end
	end
end

function _StructPackEncoder(arg_43_0, arg_43_1, arg_43_2)
	return function(arg_44_0, arg_44_1, arg_44_2)
		local var_44_0 = var_0_6.struct_pack

		if arg_44_2 then
			local var_44_1 = TagBytes(arg_44_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
			local var_44_2 = var_0_8

			return function(arg_45_0, arg_45_1)
				arg_45_0(var_44_1)
				var_44_2(arg_45_0, #arg_45_1 * arg_43_1)

				for iter_45_0, iter_45_1 in var_0_2(arg_45_1) do
					var_44_0(arg_45_0, arg_43_2, iter_45_1)
				end
			end
		elseif arg_44_1 then
			local var_44_3 = TagBytes(arg_44_0, arg_43_0)

			return function(arg_46_0, arg_46_1)
				for iter_46_0, iter_46_1 in var_0_2(arg_46_1) do
					arg_46_0(var_44_3)
					var_44_0(arg_46_0, arg_43_2, iter_46_1)
				end
			end
		else
			local var_44_4 = TagBytes(arg_44_0, arg_43_0)

			return function(arg_47_0, arg_47_1)
				arg_47_0(var_44_4)
				var_44_0(arg_47_0, arg_43_2, arg_47_1)
			end
		end
	end
end

Int32Encoder = _SimpleEncoder(var_0_7.WIRETYPE_VARINT, var_0_9, _SignedVarintSize)
Int64Encoder = _SimpleEncoder(var_0_7.WIRETYPE_VARINT, var_0_11, _SignedVarintSize64)
EnumEncoder = Int32Encoder
UInt32Encoder = _SimpleEncoder(var_0_7.WIRETYPE_VARINT, var_0_8, _VarintSize)
UInt64Encoder = _SimpleEncoder(var_0_7.WIRETYPE_VARINT, var_0_10, _VarintSize64)
SInt32Encoder = _ModifiedEncoder(var_0_7.WIRETYPE_VARINT, var_0_8, _VarintSize, var_0_7.ZigZagEncode32)
SInt64Encoder = _ModifiedEncoder(var_0_7.WIRETYPE_VARINT, var_0_10, _VarintSize64, var_0_7.ZigZagEncode64)
Fixed32Encoder = _StructPackEncoder(var_0_7.WIRETYPE_FIXED32, 4, var_0_0.byte("I"))
Fixed64Encoder = _StructPackEncoder(var_0_7.WIRETYPE_FIXED64, 8, var_0_0.byte("Q"))
SFixed32Encoder = _StructPackEncoder(var_0_7.WIRETYPE_FIXED32, 4, var_0_0.byte("i"))
SFixed64Encoder = _StructPackEncoder(var_0_7.WIRETYPE_FIXED64, 8, var_0_0.byte("q"))
FloatEncoder = _StructPackEncoder(var_0_7.WIRETYPE_FIXED32, 4, var_0_0.byte("f"))
DoubleEncoder = _StructPackEncoder(var_0_7.WIRETYPE_FIXED64, 8, var_0_0.byte("d"))

function BoolEncoder(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = "\x00"
	local var_48_1 = "\x01"

	if arg_48_2 then
		local var_48_2 = TagBytes(arg_48_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
		local var_48_3 = var_0_8

		return function(arg_49_0, arg_49_1)
			arg_49_0(var_48_2)
			var_48_3(arg_49_0, #arg_49_1)

			for iter_49_0, iter_49_1 in var_0_2(arg_49_1) do
				if iter_49_1 then
					arg_49_0(var_48_1)
				else
					arg_49_0(var_48_0)
				end
			end
		end
	elseif arg_48_1 then
		local var_48_4 = TagBytes(arg_48_0, var_0_7.WIRETYPE_VARINT)

		return function(arg_50_0, arg_50_1)
			for iter_50_0, iter_50_1 in var_0_2(arg_50_1) do
				arg_50_0(var_48_4)

				if iter_50_1 then
					arg_50_0(var_48_1)
				else
					arg_50_0(var_48_0)
				end
			end
		end
	else
		local var_48_5 = TagBytes(arg_48_0, var_0_7.WIRETYPE_VARINT)

		return function(arg_51_0, arg_51_1)
			arg_51_0(var_48_5)

			if arg_51_1 then
				return arg_51_0(var_48_1)
			end

			return arg_51_0(var_48_0)
		end
	end
end

function StringEncoder(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = TagBytes(arg_52_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
	local var_52_1 = var_0_8

	if arg_52_1 then
		return function(arg_53_0, arg_53_1)
			for iter_53_0, iter_53_1 in var_0_2(arg_53_1) do
				arg_53_0(var_52_0)
				var_52_1(arg_53_0, #iter_53_1)
				arg_53_0(iter_53_1)
			end
		end
	else
		return function(arg_54_0, arg_54_1)
			arg_54_0(var_52_0)
			var_52_1(arg_54_0, #arg_54_1)

			return arg_54_0(arg_54_1)
		end
	end
end

function BytesEncoder(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = TagBytes(arg_55_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
	local var_55_1 = var_0_8

	if arg_55_1 then
		return function(arg_56_0, arg_56_1)
			for iter_56_0, iter_56_1 in var_0_2(arg_56_1) do
				arg_56_0(var_55_0)
				var_55_1(arg_56_0, #iter_56_1)
				arg_56_0(iter_56_1)
			end
		end
	else
		return function(arg_57_0, arg_57_1)
			arg_57_0(var_55_0)
			var_55_1(arg_57_0, #arg_57_1)

			return arg_57_0(arg_57_1)
		end
	end
end

function MessageEncoder(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = TagBytes(arg_58_0, var_0_7.WIRETYPE_LENGTH_DELIMITED)
	local var_58_1 = var_0_8

	if arg_58_1 then
		return function(arg_59_0, arg_59_1)
			for iter_59_0, iter_59_1 in var_0_2(arg_59_1) do
				arg_59_0(var_58_0)
				var_58_1(arg_59_0, iter_59_1:ByteSize())
				iter_59_1:_InternalSerialize(arg_59_0)
			end
		end
	else
		return function(arg_60_0, arg_60_1)
			arg_60_0(var_58_0)
			var_58_1(arg_60_0, arg_60_1:ByteSize())

			return arg_60_1:_InternalSerialize(arg_60_0)
		end
	end
end
