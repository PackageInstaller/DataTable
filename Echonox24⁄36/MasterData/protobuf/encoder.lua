local var_0_0 = string
local var_0_1 = table
local var_0_2 = ipairs
local var_0_3 = assert
local var_0_4 = require("pb")
local var_0_5 = require("protobuf.wire_format")

module("protobuf.encoder")

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

	if arg_1_0 <= 34359738367 then
		return 5
	end

	if arg_1_0 <= 4398046511103 then
		return 6
	end

	if arg_1_0 <= 562949953421311 then
		return 7
	end

	if arg_1_0 <= 7.205759403792794e+16 then
		return 8
	end

	if arg_1_0 <= 9.223372036854776e+18 then
		return 9
	end

	return 10
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

	if arg_2_0 <= 34359738367 then
		return 5
	end

	if arg_2_0 <= 4398046511103 then
		return 6
	end

	if arg_2_0 <= 562949953421311 then
		return 7
	end

	if arg_2_0 <= 7.205759403792794e+16 then
		return 8
	end

	if arg_2_0 <= 9.223372036854776e+18 then
		return 9
	end

	return 10
end

function _TagSize(arg_3_0)
	return _VarintSize(var_0_5.PackTag(arg_3_0, 0))
end

function _SimpleSizer(arg_4_0)
	return function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = _TagSize(arg_5_0)

		if arg_5_2 then
			local var_5_1 = _VarintSize

			return function(arg_6_0)
				local var_6_0 = 0

				for iter_6_0, iter_6_1 in var_0_2(arg_6_0) do
					var_6_0 = var_6_0 + arg_4_0(iter_6_1)
				end

				return var_6_0 + var_5_1(var_6_0) + var_5_0
			end
		elseif arg_5_1 then
			return function(arg_7_0)
				local var_7_0 = var_5_0 * #arg_7_0

				for iter_7_0, iter_7_1 in var_0_2(arg_7_0) do
					var_7_0 = var_7_0 + arg_4_0(iter_7_1)
				end

				return var_7_0
			end
		else
			return function(arg_8_0)
				return var_5_0 + arg_4_0(arg_8_0)
			end
		end
	end
end

function _ModifiedSizer(arg_9_0, arg_9_1)
	return function(arg_10_0, arg_10_1, arg_10_2)
		local var_10_0 = _TagSize(arg_10_0)

		if arg_10_2 then
			local var_10_1 = _VarintSize

			return function(arg_11_0)
				local var_11_0 = 0

				for iter_11_0, iter_11_1 in var_0_2(arg_11_0) do
					var_11_0 = var_11_0 + arg_9_0(arg_9_1(iter_11_1))
				end

				return var_11_0 + var_10_1(var_11_0) + var_10_0
			end
		elseif arg_10_1 then
			return function(arg_12_0)
				local var_12_0 = var_10_0 * #arg_12_0

				for iter_12_0, iter_12_1 in var_0_2(arg_12_0) do
					var_12_0 = var_12_0 + arg_9_0(arg_9_1(iter_12_1))
				end

				return var_12_0
			end
		else
			return function(arg_13_0)
				return var_10_0 + arg_9_0(arg_9_1(arg_13_0))
			end
		end
	end
end

function _FixedSizer(arg_14_0)
	return function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = _TagSize(arg_15_0)

		if arg_15_2 then
			local var_15_1 = _VarintSize

			return function(arg_16_0)
				local var_16_0 = #arg_16_0 * arg_14_0

				return var_16_0 + var_15_1(var_16_0) + var_15_0
			end
		elseif arg_15_1 then
			local var_15_2 = arg_14_0 + var_15_0

			return function(arg_17_0)
				return #arg_17_0 * var_15_2
			end
		else
			local var_15_3 = arg_14_0 + var_15_0

			return function(arg_18_0)
				return var_15_3
			end
		end
	end
end

Int32Sizer = _SimpleSizer(_SignedVarintSize)
Int64Sizer = _SimpleSizer(var_0_4.signed_varint_size)
EnumSizer = Int32Sizer
UInt32Sizer = _SimpleSizer(_VarintSize)
UInt64Sizer = _SimpleSizer(var_0_4.varint_size)
SInt32Sizer = _ModifiedSizer(_SignedVarintSize, var_0_5.ZigZagEncode32)
SInt64Sizer = SInt32Sizer
Fixed32Sizer = _FixedSizer(4)
SFixed32Sizer = Fixed32Sizer
FloatSizer = Fixed32Sizer
Fixed64Sizer = _FixedSizer(8)
SFixed64Sizer = Fixed64Sizer
DoubleSizer = Fixed64Sizer
BoolSizer = _FixedSizer(1)

function StringSizer(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = _TagSize(arg_19_0)
	local var_19_1 = _VarintSize

	var_0_3(not arg_19_2)

	if arg_19_1 then
		return function(arg_20_0)
			local var_20_0 = var_19_0 * #arg_20_0

			for iter_20_0, iter_20_1 in var_0_2(arg_20_0) do
				local var_20_1 = #iter_20_1

				var_20_0 = var_20_0 + var_19_1(var_20_1) + var_20_1
			end

			return var_20_0
		end
	else
		return function(arg_21_0)
			local var_21_0 = #arg_21_0

			return var_19_0 + var_19_1(var_21_0) + var_21_0
		end
	end
end

function BytesSizer(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = _TagSize(arg_22_0)
	local var_22_1 = _VarintSize

	var_0_3(not arg_22_2)

	if arg_22_1 then
		return function(arg_23_0)
			local var_23_0 = var_22_0 * #arg_23_0

			for iter_23_0, iter_23_1 in var_0_2(arg_23_0) do
				local var_23_1 = #iter_23_1

				var_23_0 = var_23_0 + var_22_1(var_23_1) + var_23_1
			end

			return var_23_0
		end
	else
		return function(arg_24_0)
			local var_24_0 = #arg_24_0

			return var_22_0 + var_22_1(var_24_0) + var_24_0
		end
	end
end

function MessageSizer(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = _TagSize(arg_25_0)
	local var_25_1 = _VarintSize

	var_0_3(not arg_25_2)

	if arg_25_1 then
		return function(arg_26_0)
			local var_26_0 = var_25_0 * #arg_26_0

			for iter_26_0, iter_26_1 in var_0_2(arg_26_0) do
				local var_26_1 = iter_26_1:ByteSize()

				var_26_0 = var_26_0 + var_25_1(var_26_1) + var_26_1
			end

			return var_26_0
		end
	else
		return function(arg_27_0)
			local var_27_0 = arg_27_0:ByteSize()

			return var_25_0 + var_25_1(var_27_0) + var_27_0
		end
	end
end

local var_0_6 = var_0_4.varint_encoder
local var_0_7 = var_0_4.signed_varint_encoder
local var_0_8 = var_0_4.varint_encoder64
local var_0_9 = var_0_4.signed_varint_encoder64

function _VarintBytes(arg_28_0)
	local var_28_0 = {}

	local function var_28_1(arg_29_0)
		var_28_0[#var_28_0 + 1] = arg_29_0
	end

	var_0_7(var_28_1, arg_28_0)

	return var_0_1.concat(var_28_0)
end

function TagBytes(arg_30_0, arg_30_1)
	return _VarintBytes(var_0_5.PackTag(arg_30_0, arg_30_1))
end

function _SimpleEncoder(arg_31_0, arg_31_1, arg_31_2)
	return function(arg_32_0, arg_32_1, arg_32_2)
		if arg_32_2 then
			local var_32_0 = TagBytes(arg_32_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
			local var_32_1 = var_0_6

			return function(arg_33_0, arg_33_1)
				arg_33_0(var_32_0)

				local var_33_0 = 0

				for iter_33_0, iter_33_1 in var_0_2(arg_33_1) do
					var_33_0 = var_33_0 + arg_31_2(iter_33_1)
				end

				var_32_1(arg_33_0, var_33_0)

				for iter_33_2 in arg_33_1 do
					arg_31_1(arg_33_0, iter_33_2)
				end
			end
		elseif arg_32_1 then
			local var_32_2 = TagBytes(arg_32_0, arg_31_0)

			return function(arg_34_0, arg_34_1)
				for iter_34_0, iter_34_1 in var_0_2(arg_34_1) do
					arg_34_0(var_32_2)
					arg_31_1(arg_34_0, iter_34_1)
				end
			end
		else
			local var_32_3 = TagBytes(arg_32_0, arg_31_0)

			return function(arg_35_0, arg_35_1)
				arg_35_0(var_32_3)
				arg_31_1(arg_35_0, arg_35_1)
			end
		end
	end
end

function _ModifiedEncoder(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	return function(arg_37_0, arg_37_1, arg_37_2)
		if arg_37_2 then
			local var_37_0 = TagBytes(arg_37_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
			local var_37_1 = var_0_6

			return function(arg_38_0, arg_38_1)
				arg_38_0(var_37_0)

				local var_38_0 = 0

				for iter_38_0, iter_38_1 in var_0_2(arg_38_1) do
					var_38_0 = var_38_0 + arg_36_2(arg_36_3(iter_38_1))
				end

				var_37_1(arg_38_0, var_38_0)

				for iter_38_2, iter_38_3 in var_0_2(arg_38_1) do
					arg_36_1(arg_38_0, arg_36_3(iter_38_3))
				end
			end
		elseif arg_37_1 then
			local var_37_2 = TagBytes(arg_37_0, arg_36_0)

			return function(arg_39_0, arg_39_1)
				for iter_39_0, iter_39_1 in var_0_2(arg_39_1) do
					arg_39_0(var_37_2)
					arg_36_1(arg_39_0, arg_36_3(iter_39_1))
				end
			end
		else
			local var_37_3 = TagBytes(arg_37_0, arg_36_0)

			return function(arg_40_0, arg_40_1)
				arg_40_0(var_37_3)
				arg_36_1(arg_40_0, arg_36_3(arg_40_1))
			end
		end
	end
end

function _StructPackEncoder(arg_41_0, arg_41_1, arg_41_2)
	return function(arg_42_0, arg_42_1, arg_42_2)
		local var_42_0 = var_0_4.struct_pack

		if arg_42_2 then
			local var_42_1 = TagBytes(arg_42_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
			local var_42_2 = var_0_6

			return function(arg_43_0, arg_43_1)
				arg_43_0(var_42_1)
				var_42_2(arg_43_0, #arg_43_1 * arg_41_1)

				for iter_43_0, iter_43_1 in var_0_2(arg_43_1) do
					var_42_0(arg_43_0, arg_41_2, iter_43_1)
				end
			end
		elseif arg_42_1 then
			local var_42_3 = TagBytes(arg_42_0, arg_41_0)

			return function(arg_44_0, arg_44_1)
				for iter_44_0, iter_44_1 in var_0_2(arg_44_1) do
					arg_44_0(var_42_3)
					var_42_0(arg_44_0, arg_41_2, iter_44_1)
				end
			end
		else
			local var_42_4 = TagBytes(arg_42_0, arg_41_0)

			return function(arg_45_0, arg_45_1)
				arg_45_0(var_42_4)
				var_42_0(arg_45_0, arg_41_2, arg_45_1)
			end
		end
	end
end

Int32Encoder = _SimpleEncoder(var_0_5.WIRETYPE_VARINT, var_0_7, _SignedVarintSize)
Int64Encoder = _SimpleEncoder(var_0_5.WIRETYPE_VARINT, var_0_9, _SignedVarintSize)
EnumEncoder = Int32Encoder
UInt32Encoder = _SimpleEncoder(var_0_5.WIRETYPE_VARINT, var_0_6, _VarintSize)
UInt64Encoder = _SimpleEncoder(var_0_5.WIRETYPE_VARINT, var_0_8, _VarintSize)
SInt32Encoder = _ModifiedEncoder(var_0_5.WIRETYPE_VARINT, var_0_6, _VarintSize, var_0_5.ZigZagEncode32)
SInt64Encoder = _ModifiedEncoder(var_0_5.WIRETYPE_VARINT, var_0_8, _VarintSize, var_0_5.ZigZagEncode64)
Fixed32Encoder = _StructPackEncoder(var_0_5.WIRETYPE_FIXED32, 4, var_0_0.byte("I"))
Fixed64Encoder = _StructPackEncoder(var_0_5.WIRETYPE_FIXED64, 8, var_0_0.byte("Q"))
SFixed32Encoder = _StructPackEncoder(var_0_5.WIRETYPE_FIXED32, 4, var_0_0.byte("i"))
SFixed64Encoder = _StructPackEncoder(var_0_5.WIRETYPE_FIXED64, 8, var_0_0.byte("q"))
FloatEncoder = _StructPackEncoder(var_0_5.WIRETYPE_FIXED32, 4, var_0_0.byte("f"))
DoubleEncoder = _StructPackEncoder(var_0_5.WIRETYPE_FIXED64, 8, var_0_0.byte("d"))

function BoolEncoder(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = "\x00"
	local var_46_1 = "\x01"

	if arg_46_2 then
		local var_46_2 = TagBytes(arg_46_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
		local var_46_3 = var_0_6

		return function(arg_47_0, arg_47_1)
			arg_47_0(var_46_2)
			var_46_3(arg_47_0, #arg_47_1)

			for iter_47_0, iter_47_1 in var_0_2(arg_47_1) do
				if iter_47_1 then
					arg_47_0(var_46_1)
				else
					arg_47_0(var_46_0)
				end
			end
		end
	elseif arg_46_1 then
		local var_46_4 = TagBytes(arg_46_0, var_0_5.WIRETYPE_VARINT)

		return function(arg_48_0, arg_48_1)
			for iter_48_0, iter_48_1 in var_0_2(arg_48_1) do
				arg_48_0(var_46_4)

				if iter_48_1 then
					arg_48_0(var_46_1)
				else
					arg_48_0(var_46_0)
				end
			end
		end
	else
		local var_46_5 = TagBytes(arg_46_0, var_0_5.WIRETYPE_VARINT)

		return function(arg_49_0, arg_49_1)
			arg_49_0(var_46_5)

			if arg_49_1 then
				return arg_49_0(var_46_1)
			end

			return arg_49_0(var_46_0)
		end
	end
end

function StringEncoder(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = TagBytes(arg_50_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
	local var_50_1 = var_0_6

	var_0_3(not arg_50_2)

	if arg_50_1 then
		return function(arg_51_0, arg_51_1)
			for iter_51_0, iter_51_1 in var_0_2(arg_51_1) do
				arg_51_0(var_50_0)
				var_50_1(arg_51_0, #iter_51_1)
				arg_51_0(iter_51_1)
			end
		end
	else
		return function(arg_52_0, arg_52_1)
			arg_52_0(var_50_0)
			var_50_1(arg_52_0, #arg_52_1)

			return arg_52_0(arg_52_1)
		end
	end
end

function BytesEncoder(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = TagBytes(arg_53_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
	local var_53_1 = var_0_6

	var_0_3(not arg_53_2)

	if arg_53_1 then
		return function(arg_54_0, arg_54_1)
			for iter_54_0, iter_54_1 in var_0_2(arg_54_1) do
				arg_54_0(var_53_0)
				var_53_1(arg_54_0, #iter_54_1)
				arg_54_0(iter_54_1)
			end
		end
	else
		return function(arg_55_0, arg_55_1)
			arg_55_0(var_53_0)
			var_53_1(arg_55_0, #arg_55_1)

			return arg_55_0(arg_55_1)
		end
	end
end

function MessageEncoder(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = TagBytes(arg_56_0, var_0_5.WIRETYPE_LENGTH_DELIMITED)
	local var_56_1 = var_0_6

	var_0_3(not arg_56_2)

	if arg_56_1 then
		return function(arg_57_0, arg_57_1)
			for iter_57_0, iter_57_1 in var_0_2(arg_57_1) do
				arg_57_0(var_56_0)
				var_56_1(arg_57_0, iter_57_1:ByteSize())
				iter_57_1:_InternalSerialize(arg_57_0)
			end
		end
	else
		return function(arg_58_0, arg_58_1)
			arg_58_0(var_56_0)
			var_56_1(arg_58_0, arg_58_1:ByteSize())

			return arg_58_1:_InternalSerialize(arg_58_0)
		end
	end
end
